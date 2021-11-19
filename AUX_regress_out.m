function [EEG] = AUX_regress_out(EEG, AUX_chan_num, AUX_chan_out)
% functions to regress out AUX cahnnels from EEG data
% input parameter:
%
% EEG - EEG data structure after uploading data to EEGLAB
% AUX_chan_num - matrix of all the channel numbers that are AUX channels
% AUX_chan_out - matrix of which AUX channels numbers to regress out (if you are
% regressing out all AUX channels, then AUX_chan_out is the same matrix as
% AUX_chan_num)
%
% example
% if regress out all AUX channels:
% EEG_3 = AUX_regress_out(EEG, [64:66], [64:66]);
% if regress out only AUX channels # 64:
% EEG_1 = AUX_regress_out(EEG, [64:66], [64]);
%
AUX_chan_out = EEG.data(AUX_chan_out,:)';
AUX_chan_all = EEG.data(AUX_chan_num,:)';
all_chan_num = 1:EEG.nbchan;
[~, EEG_chan_num]=setdiff(all_chan_num, AUX_chan_num);
EEG_chan = EEG.data(EEG_chan_num,:)';

clean_EEG = EEG_chan - (AUX_chan_out * (AUX_chan_out\EEG_chan));

EEG.data = [clean_EEG'; AUX_chan_all'];
end