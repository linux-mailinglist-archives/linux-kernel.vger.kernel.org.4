Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A115B9B03
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiIOMjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiIOMi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:38:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8755383F01
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:38:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c11so30662181wrp.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RV4wF232kZpwZvwtbOvkLH7fVkb3VMbqjdLt/ZUggPs=;
        b=ke/c/lzv6U9ofG/tiCo8KZL3cfn0YNdB/6+zGhj6/qboz95EF4ULmzGMUse72Mzkoh
         KcbZahR2BtpmyIkS9SxaBtR73Z4g6EjTpLtm598AQPXhlbwxSE4SV+/iS3gx3IdwUunt
         KeaJRWva6Fk7tT5NICTXrESFXwYtXd1zRqFZXhzDHA00JF9MbdN+YMFBiy2XXDy0/Xfr
         uzwvULgBsij9yZDBznJl/n8OlFLetz/Do5FWiOLJWdTGDQgyoAsnR0STZEaoS+YIXWdK
         e6YUJjDnck5spkNHJhLhlR3NGpzF31thC51xAVWWHxxAvakRRDoL+wvyQFLyZkZd8Umm
         NjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RV4wF232kZpwZvwtbOvkLH7fVkb3VMbqjdLt/ZUggPs=;
        b=4eNBem+93I/BIuKNnKjjT1iZuvwSUMOYim4RC4YeSytDuLTOscxoplVJZKzRQudvd7
         +aL66nOfmKVoRdYN/0DpjnxrnPbZaGSLWcq7I4NXX2h/iRYlX3ZZIaFyr1o6+/7Mwt1w
         m+sGjutgmTTUGbKT7GH/RYSI15K1wI5vnk5eSSHBjztEvqKl5qHUxCXjtz8WDE/+kO8P
         VxqhXgzW/i2CypZ+7y87hA0OPW6kRZNv9epE3NT6GQLt7m8FdM2RyU28vJc1evx36CuP
         c3zZfzciBTGqRWL9v2UHr7HHCXmyajlSbvLE7a7CPa/uFXgXjlqpOpva3ODSZK2VoZZS
         kY+g==
X-Gm-Message-State: ACgBeo2evP91cGQY9tN9RlTjnxVAavNaNIUuxBMjSqiyNgkaDRvLKHT4
        RjqFM0c9dHGF/rhOtHGEwMy23w==
X-Google-Smtp-Source: AA6agR5adbW9nWruS/eO1UF0hiNQtR9UN4aG/zxUPSGfS2nBdFjbR7LRzC6nG+tmXRwJ9YmfEzTpUQ==
X-Received: by 2002:adf:e94e:0:b0:228:da92:3691 with SMTP id m14-20020adfe94e000000b00228da923691mr24576549wrn.1.1663245537095;
        Thu, 15 Sep 2022 05:38:57 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id bg13-20020a05600c3c8d00b003a5f4fccd4asm3112559wmb.35.2022.09.15.05.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:38:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/9] ASoC: qdsp6: audioreach: add support for more port connections
Date:   Thu, 15 Sep 2022 13:38:34 +0100
Message-Id: <20220915123837.11591-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220915123837.11591-1-srinivas.kandagatla@linaro.org>
References: <20220915123837.11591-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AudioReach Modules can connect to other modules using source and
destination port, and each module in theory can support up to 255 port
connections. But in practice this limit is at max 8 ports at a time.
So add support for allowing multiple port connections.

This support is needed for more detailed graphs like ECNS, speaker
protection and so.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/uapi/sound/snd_ar_tokens.h |  27 ++++++++
 sound/soc/qcom/qdsp6/audioreach.c  |  34 ++++------
 sound/soc/qcom/qdsp6/audioreach.h  |   9 ++-
 sound/soc/qcom/qdsp6/topology.c    | 102 +++++++++++++++++++++++++----
 4 files changed, 136 insertions(+), 36 deletions(-)

diff --git a/include/uapi/sound/snd_ar_tokens.h b/include/uapi/sound/snd_ar_tokens.h
index 440c0725660b..b9b9093b4396 100644
--- a/include/uapi/sound/snd_ar_tokens.h
+++ b/include/uapi/sound/snd_ar_tokens.h
@@ -191,6 +191,33 @@ enum ar_event_types {
 #define AR_TKN_U32_MODULE_SRC_INSTANCE_ID	208
 #define AR_TKN_U32_MODULE_DST_INSTANCE_ID	209
 
+#define AR_TKN_U32_MODULE_SRC_OP_PORT_ID1	210
+#define AR_TKN_U32_MODULE_DST_IN_PORT_ID1	211
+#define AR_TKN_U32_MODULE_DST_INSTANCE_ID1	212
+
+#define AR_TKN_U32_MODULE_SRC_OP_PORT_ID2	213
+#define AR_TKN_U32_MODULE_DST_IN_PORT_ID2	214
+#define AR_TKN_U32_MODULE_DST_INSTANCE_ID2	215
+
+#define AR_TKN_U32_MODULE_SRC_OP_PORT_ID3	216
+#define AR_TKN_U32_MODULE_DST_IN_PORT_ID3	217
+#define AR_TKN_U32_MODULE_DST_INSTANCE_ID3	218
+
+#define AR_TKN_U32_MODULE_SRC_OP_PORT_ID4	219
+#define AR_TKN_U32_MODULE_DST_IN_PORT_ID4	220
+#define AR_TKN_U32_MODULE_DST_INSTANCE_ID4	221
+
+#define AR_TKN_U32_MODULE_SRC_OP_PORT_ID5	222
+#define AR_TKN_U32_MODULE_DST_IN_PORT_ID5	223
+#define AR_TKN_U32_MODULE_DST_INSTANCE_ID5	224
+
+#define AR_TKN_U32_MODULE_SRC_OP_PORT_ID6	225
+#define AR_TKN_U32_MODULE_DST_IN_PORT_ID6	226
+#define AR_TKN_U32_MODULE_DST_INSTANCE_ID6	227
+
+#define AR_TKN_U32_MODULE_SRC_OP_PORT_ID7	228
+#define AR_TKN_U32_MODULE_DST_IN_PORT_ID7	229
+#define AR_TKN_U32_MODULE_DST_INSTANCE_ID7	230
 
 #define AR_TKN_U32_MODULE_HW_IF_IDX		250
 #define AR_TKN_U32_MODULE_HW_IF_TYPE		251
diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index bae0b7f67e0b..37f1408f6f6f 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -311,15 +311,6 @@ static void apm_populate_sub_graph_config(struct apm_sub_graph_data *cfg,
 	cfg->sid.scenario_id = sg->scenario_id;
 }
 
-static void apm_populate_connection_obj(struct apm_module_conn_obj *obj,
-					struct audioreach_module *module)
-{
-	obj->src_mod_inst_id = module->src_mod_inst_id;
-	obj->src_mod_op_port_id = module->src_mod_op_port_id;
-	obj->dst_mod_inst_id = module->instance_id;
-	obj->dst_mod_ip_port_id = module->in_port;
-}
-
 static void apm_populate_module_prop_obj(struct apm_mod_prop_obj *obj,
 					 struct audioreach_module *module)
 {
@@ -394,17 +385,21 @@ static void audioreach_populate_graph(struct q6apm *apm, struct audioreach_graph
 			apm_populate_module_list_obj(mlobj, container, sg->sub_graph_id);
 
 			list_for_each_entry(module, &container->modules_list, node) {
-				uint32_t src_mod_inst_id;
-
-				src_mod_inst_id = module->src_mod_inst_id;
-
 				module_prop_obj = &mp_data->mod_prop_obj[nmodule];
 				apm_populate_module_prop_obj(module_prop_obj, module);
 
-				if (src_mod_inst_id) {
-					conn_obj = &mc_data->conn_obj[nconn];
-					apm_populate_connection_obj(conn_obj, module);
-					nconn++;
+				if (module->max_op_port) {
+					int pn;
+					for (pn = 0; pn < module->max_op_port; pn++) {
+						    if (module->dst_mod_inst_id[pn]) {
+							conn_obj = &mc_data->conn_obj[nconn];
+							conn_obj->src_mod_inst_id = module->instance_id;
+							conn_obj->src_mod_op_port_id = module->src_mod_op_port_id[pn];
+							conn_obj->dst_mod_inst_id = module->dst_mod_inst_id[pn];
+							conn_obj->dst_mod_ip_port_id = module->dst_mod_ip_port_id[pn];
+							nconn++;
+						}
+					}
 				}
 
 				nmodule++;
@@ -456,8 +451,7 @@ void *audioreach_alloc_graph_pkt(struct q6apm *apm, struct audioreach_graph_info
 				APM_MOD_LIST_OBJ_PSIZE(mlobj, container->num_modules);
 
 			list_for_each_entry(module, &container->modules_list, node) {
-				if (module->src_mod_inst_id)
-					num_connections++;
+				num_connections += module->num_connections;
 			}
 		}
 	}
@@ -502,7 +496,7 @@ void *audioreach_alloc_graph_pkt(struct q6apm *apm, struct audioreach_graph_info
 	param_data->module_instance_id = APM_MODULE_INSTANCE_ID;
 	param_data->param_id = APM_PARAM_ID_MODULE_LIST;
 	param_data->param_size = ml_sz - APM_MODULE_PARAM_DATA_SIZE;
-	params.mod_list_data->num_modules_list = num_sub_graphs;
+	params.mod_list_data->num_modules_list = num_modules_list;
 	p += ml_sz;
 
 	/* Module Properties */
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 1dc6ffcb3362..df5026b646c1 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -627,6 +627,8 @@ struct audioreach_container {
 	struct audioreach_sub_graph *sub_graph;
 };
 
+#define AR_MAX_MOD_LINKS	8
+
 struct audioreach_module {
 	uint32_t module_id;
 	uint32_t instance_id;
@@ -637,11 +639,12 @@ struct audioreach_module {
 	uint32_t in_port;
 	uint32_t out_port;
 
+	uint32_t num_connections;
 	/* Connections */
 	uint32_t src_mod_inst_id;
-	uint32_t src_mod_op_port_id;
-	uint32_t dst_mod_inst_id;
-	uint32_t dst_mod_ip_port_id;
+	uint32_t src_mod_op_port_id[AR_MAX_MOD_LINKS];
+	uint32_t dst_mod_inst_id[AR_MAX_MOD_LINKS];
+	uint32_t dst_mod_ip_port_id[AR_MAX_MOD_LINKS];
 
 	/* Format specifics */
 	uint32_t ch_fmt;
diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index f66d7054177c..9994e9ec01f4 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -412,19 +412,25 @@ static struct audioreach_module *audioreach_parse_common_tokens(struct q6apm *ap
 							struct snd_soc_dapm_widget *w)
 {
 	uint32_t max_ip_port = 0, max_op_port = 0, in_port = 0, out_port = 0;
-	uint32_t src_mod_inst_id = 0, src_mod_op_port_id = 0;
-	uint32_t dst_mod_inst_id = 0, dst_mod_ip_port_id = 0;
+	uint32_t src_mod_op_port_id[AR_MAX_MOD_LINKS] = { 0, };
+	uint32_t dst_mod_inst_id[AR_MAX_MOD_LINKS] = { 0, };
+	uint32_t dst_mod_ip_port_id[AR_MAX_MOD_LINKS] = { 0, };
+	uint32_t src_mod_inst_id = 0;
+
 	int module_id = 0, instance_id = 0, tkn_count = 0;
 	struct snd_soc_tplg_vendor_value_elem *mod_elem;
 	struct snd_soc_tplg_vendor_array *mod_array;
 	struct audioreach_module *mod = NULL;
+	uint32_t token;
 	bool found;
+	int max_tokens;
 
 	mod_array = audioreach_get_module_array(private);
 	mod_elem = mod_array->value;
-
-	while (tkn_count <= (le32_to_cpu(mod_array->num_elems) - 1)) {
-		switch (le32_to_cpu(mod_elem->token)) {
+	max_tokens = le32_to_cpu(mod_array->num_elems);
+	while (tkn_count <= (max_tokens - 1)) {
+		token = le32_to_cpu(mod_elem->token);
+		switch (token) {
 		/* common module info */
 		case AR_TKN_U32_MODULE_ID:
 			module_id = le32_to_cpu(mod_elem->value);
@@ -454,17 +460,80 @@ static struct audioreach_module *audioreach_parse_common_tokens(struct q6apm *ap
 		case AR_TKN_U32_MODULE_OUT_PORTS:
 			out_port = le32_to_cpu(mod_elem->value);
 			break;
-		case AR_TKN_U32_MODULE_SRC_OP_PORT_ID:
-			src_mod_op_port_id = le32_to_cpu(mod_elem->value);
-			break;
 		case AR_TKN_U32_MODULE_SRC_INSTANCE_ID:
 			src_mod_inst_id = le32_to_cpu(mod_elem->value);
 			break;
+		case AR_TKN_U32_MODULE_SRC_OP_PORT_ID:
+			src_mod_op_port_id[0] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_SRC_OP_PORT_ID1:
+			src_mod_op_port_id[1] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_SRC_OP_PORT_ID2:
+			src_mod_op_port_id[2] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_SRC_OP_PORT_ID3:
+			src_mod_op_port_id[3] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_SRC_OP_PORT_ID4:
+			src_mod_op_port_id[4] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_SRC_OP_PORT_ID5:
+			src_mod_op_port_id[5] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_SRC_OP_PORT_ID6:
+			src_mod_op_port_id[6] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_SRC_OP_PORT_ID7:
+			src_mod_op_port_id[7] = le32_to_cpu(mod_elem->value);
+			break;
 		case AR_TKN_U32_MODULE_DST_INSTANCE_ID:
-			dst_mod_inst_id = le32_to_cpu(mod_elem->value);
+			dst_mod_inst_id[0] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_DST_INSTANCE_ID1:
+			dst_mod_inst_id[1] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_DST_INSTANCE_ID2:
+			dst_mod_inst_id[2] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_DST_INSTANCE_ID3:
+			dst_mod_inst_id[3] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_DST_INSTANCE_ID4:
+			dst_mod_inst_id[4] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_DST_INSTANCE_ID5:
+			dst_mod_inst_id[5] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_DST_INSTANCE_ID6:
+			dst_mod_inst_id[6] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_DST_INSTANCE_ID7:
+			dst_mod_inst_id[7] = le32_to_cpu(mod_elem->value);
 			break;
 		case AR_TKN_U32_MODULE_DST_IN_PORT_ID:
-			dst_mod_ip_port_id = le32_to_cpu(mod_elem->value);
+			dst_mod_ip_port_id[0] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_DST_IN_PORT_ID1:
+			dst_mod_ip_port_id[1] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_DST_IN_PORT_ID2:
+			dst_mod_ip_port_id[2] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_DST_IN_PORT_ID3:
+			dst_mod_ip_port_id[3] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_DST_IN_PORT_ID4:
+			dst_mod_ip_port_id[4] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_DST_IN_PORT_ID5:
+			dst_mod_ip_port_id[5] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_DST_IN_PORT_ID6:
+			dst_mod_ip_port_id[6] = le32_to_cpu(mod_elem->value);
+			break;
+		case AR_TKN_U32_MODULE_DST_IN_PORT_ID7:
+			dst_mod_ip_port_id[7] = le32_to_cpu(mod_elem->value);
 			break;
 		default:
 			break;
@@ -475,15 +544,22 @@ static struct audioreach_module *audioreach_parse_common_tokens(struct q6apm *ap
 	}
 
 	if (mod) {
+		int pn, id = 0;
 		mod->module_id = module_id;
 		mod->max_ip_port = max_ip_port;
 		mod->max_op_port = max_op_port;
 		mod->in_port = in_port;
 		mod->out_port = out_port;
 		mod->src_mod_inst_id = src_mod_inst_id;
-		mod->src_mod_op_port_id = src_mod_op_port_id;
-		mod->dst_mod_inst_id = dst_mod_inst_id;
-		mod->dst_mod_ip_port_id = dst_mod_ip_port_id;
+		for (pn = 0; pn < mod->max_op_port; pn++) {
+			if (src_mod_op_port_id[pn] && dst_mod_inst_id[pn] && dst_mod_ip_port_id[pn]) {
+				mod->src_mod_op_port_id[id] = src_mod_op_port_id[pn];
+				mod->dst_mod_inst_id[id] = dst_mod_inst_id[pn];
+				mod->dst_mod_ip_port_id[id] = dst_mod_ip_port_id[pn];
+				id++;
+				mod->num_connections = id;
+			}
+		}
 	}
 
 	return mod;
-- 
2.21.0

