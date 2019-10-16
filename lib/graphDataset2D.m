function graph = graphDataset2D(g2o_filename)

% Read g2o dataset
[edges, pose_estimate] = readG2oDataset2D(g2o_filename);

% Convert to common format and return
graph = struct(...
  'model', 'dataset', ...
  'format', '2d', ...
  'scale', 1, ...
  'edges', edges, ...
  'pose_estimate', pose_estimate, ...
  'sigma_R', [], ...
  'sigma_t', [] ...
);
graph.measurements = posegraphMeasurementMatrix(graph);
graph.sigma_t = sqrt(1/median(arrayfun(@(m) m.tau, graph.measurements)));
graph.sigma_R = sqrt(1/median(arrayfun(@(m) m.kappa, graph.measurements)));

end