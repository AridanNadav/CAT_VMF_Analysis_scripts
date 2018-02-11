
clear;
exp_name={'Boost_IAPS_Negative_I';'Boost_IAPS_Negative_II';'Boost_IAPS_Positive_I';'Boost_IAPS_Positive_II';'Boost_aversive_cue';'Boost_faces';'Boost_faces_new';'Boost_familiar_faces';'Boost_fractals_I';'Boost_fractals_II';'Boost_visual_cue'};

for i=1:length(exp_name)
    cd(['./../../',exp_name{i},'/Analysis'])
    a=i;
end