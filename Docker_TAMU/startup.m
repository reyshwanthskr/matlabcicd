function startup

% Setup default proxy settings based on the environment variables that
% we will have set in the run.sh script
host = getenv('MW_PROXY_HOST');
port = getenv('MW_PROXY_PORT');
if ~isempty(host) && ~isempty(port)
    % Replace the deprecated JAVA API with a wrapper
    matlab.net.internal.copyProxySettingsFromEnvironment();
end

end
