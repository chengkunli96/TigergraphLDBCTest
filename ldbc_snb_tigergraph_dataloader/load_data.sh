#!/bin/bash

## PLEASE modify the line below to the directory where your raw file sits and remove the '#'
# export LDBC_SNB_DATA_DIR=/home/tigergraph/ldbc_snb_data/social_network/


#start all TigerGraph services
gadmin start all

gsql -g ldbc_snb "run loading job load_ldbc_snb using 
v_person_file=\"${LDBC_SNB_DATA_DIR}/person_0_0.csv\",
v_post_file=\"${LDBC_SNB_DATA_DIR}/post_0_0.csv\", 
v_tag_file=\"${LDBC_SNB_DATA_DIR}/tag_0_0.csv\", 
v_place_file=\"${LDBC_SNB_DATA_DIR}/place_0_0.csv\",
v_comment_file=\"${LDBC_SNB_DATA_DIR}/comment_0_0.csv\", 
v_forum_file=\"${LDBC_SNB_DATA_DIR}/forum_0_0.csv\", 
v_organisation_file=\"${LDBC_SNB_DATA_DIR}/organisation_0_0.csv\", 
v_tagclass_file=\"${LDBC_SNB_DATA_DIR}/tagclass_0_0.csv\",


person_knows_person_file=\"${LDBC_SNB_DATA_DIR}/person_knows_person_0_0.csv\", 
comment_reply_of_post_file=\"${LDBC_SNB_DATA_DIR}/comment_replyOf_post_0_0.csv\",
comment_reply_of_comment_file=\"${LDBC_SNB_DATA_DIR}/comment_replyOf_comment_0_0.csv\",
post_has_creator_person_file=\"${LDBC_SNB_DATA_DIR}/post_hasCreator_person_0_0.csv\",
post_has_tag_tag_file=\"${LDBC_SNB_DATA_DIR}/post_hasTag_tag_0_0.csv\",
comment_has_creator_person_file=\"${LDBC_SNB_DATA_DIR}/comment_hasCreator_person_0_0.csv\",
post_is_located_in_place_file=\"${LDBC_SNB_DATA_DIR}/post_isLocatedIn_place_0_0.csv\",
comment_has_tag_tag_file=\"${LDBC_SNB_DATA_DIR}/comment_hasTag_tag_0_0.csv\",
comment_is_located_in_place_file=\"${LDBC_SNB_DATA_DIR}/comment_isLocatedIn_place_0_0.csv\",
forum_container_of_post_file=\"${LDBC_SNB_DATA_DIR}/forum_containerOf_post_0_0.csv\",
forum_has_member_person_file=\"${LDBC_SNB_DATA_DIR}/forum_hasMember_person_0_0.csv\",
forum_has_moderator_person_file=\"${LDBC_SNB_DATA_DIR}/forum_hasModerator_person_0_0.csv\",
forum_has_tag_tag_file=\"${LDBC_SNB_DATA_DIR}/forum_hasTag_tag_0_0.csv\",
organisation_is_located_in_place_file=\"${LDBC_SNB_DATA_DIR}/organisation_isLocatedIn_place_0_0.csv\",
person_has_interest_tag_file=\"${LDBC_SNB_DATA_DIR}/person_hasInterest_tag_0_0.csv\",
person_is_located_in_place_file=\"${LDBC_SNB_DATA_DIR}/person_isLocatedIn_place_0_0.csv\",
person_likes_comment_file=\"${LDBC_SNB_DATA_DIR}/person_likes_comment_0_0.csv\", 
person_likes_post_file=\"${LDBC_SNB_DATA_DIR}/person_likes_post_0_0.csv\", 
person_study_at_organisation_file=\"${LDBC_SNB_DATA_DIR}/person_studyAt_organisation_0_0.csv\",
person_work_at_organisation_file=\"${LDBC_SNB_DATA_DIR}/person_workAt_organisation_0_0.csv\",
place_is_part_of_place_file=\"${LDBC_SNB_DATA_DIR}/place_isPartOf_place_0_0.csv\",
tag_has_type_tagclass_file=\"${LDBC_SNB_DATA_DIR}/tag_hasType_tagclass_0_0.csv\",
tagclass_is_subclass_of_tagclass_file=\"${LDBC_SNB_DATA_DIR}/tagclass_isSubclassOf_tagclass_0_0.csv\""
