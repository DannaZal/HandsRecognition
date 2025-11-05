function output = process_palm(img)
    persistent net warnedNoGPU;
    if isempty(net)
        net = importNetworkFromONNX('models/palm_detection_full_inf_post_192x192.onnx');
    end
    if isempty(warnedNoGPU)
        warnedNoGPU = false;
    end
    
    try
        if canUseGPU
            dlX = dlarray(gpuArray(img),'SSC');   % 'SSC' = Spatial, Spatial, Channel
            out = predict(net, dlX);
            output = gather(extractdata(out));
            return; % si funciona ya retorna
        end
    catch MEg
        if ~warnedNoGPU
            fprintf(2,'No se detectó GPU o falló el uso de GPU. Se usará CPU');
            warnedNoGPU = true;
        end
    end

    % --- CPU en casos de fallar ---
    try
        dlX = dlarray(img,'SSC');
        out = predict(net, dlX);
        output = extractdata(out);
    catch MEc
        rethrow(MEc);
    end
end
