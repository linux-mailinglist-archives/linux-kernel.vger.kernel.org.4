Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E15260F512
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiJ0K2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbiJ0K1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:27:50 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BDCEB751
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:27:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 14-20020a05600c228e00b003cf4eaef74eso1722965wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gp+qeqYpAUBfqq9AAv/QE5uuGw4jREIuhh6ZeuCDwSI=;
        b=tSQnRemXI46oIS3dmvkmIn+nigjaHOop9TSov+MmCb7R90FnPGXOkLEpw9/MztZTtx
         xpMx/Iq6hRePD0RorCoUaMULt3rAett4vJYNH7TA4cALOzoSNcXdTjoT1KDZhO2J/Mpx
         xY3h+BEZL81Ge+/FOGR7FmvjCa9RkMoDVMcZqn6meytpeWSAWYVUbGk78lQtJr8Vr9EN
         JCMkhWxhah/R/jx/sm0BDLFNUnD5FvvYQ5bK1U3/vAd0d0Qe4UUgjNz5S8YGuEMurn86
         Y+M7exXXP8KFHN4pTM1nQ0PKUfp9o+8r5WbICc+da9NiuZPcHZ9lubZ6+hlCdu8CEAp9
         nBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gp+qeqYpAUBfqq9AAv/QE5uuGw4jREIuhh6ZeuCDwSI=;
        b=yBn00NDS0FXZaHhMygqA87HcZVwJnmfWj9m944SISHmQNN3vFu6iCBdSgsNhC/mngF
         xwbZhXXFjiZNbL3FfLv/YgEesdROHmOqxfbccRoUZvfYa99CfDuM38R4Itn9u6FHZaeg
         Q8GDDjl2uYHt/Z/gzWXPbQfF/JsfvYzi1MUAMIV6IOSTC0PdWnkWO6wWo+hFM9sLkgsv
         tX992y52eeMvxGtCe78H7nDcpzwDmLzw0YtM1SiatGVef3t4NUI442YBoNvwIAvvBzfK
         dBBkLonOSgk3jMKWQJz3TCAPLea3g2SvVvmfvH5/irOBROSIn2D913V4JQQQVGhVuUEa
         Pc+w==
X-Gm-Message-State: ACrzQf3yM1mAW5CebHJyjDYq/ryH3Q0ir90/deAZZp2Ee8e6Z2NNHnl6
        ey/QATSCMOkJXrBgCJF9goVOSA==
X-Google-Smtp-Source: AMsMyM76b4UYlbmwHv93DCg1ovuumC8jcVXRQkoBmqjfzDLtj3SvT35/NFdoAlEIoq2iaolvJotUBQ==
X-Received: by 2002:a05:600c:310b:b0:3cf:33c4:bc7 with SMTP id g11-20020a05600c310b00b003cf33c40bc7mr5402758wmo.25.1666866467001;
        Thu, 27 Oct 2022 03:27:47 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b003b505d26776sm5088674wmb.5.2022.10.27.03.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 03:27:46 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 6/9] ASoC: qdsp6: audioreach: add support for more port connections
Date:   Thu, 27 Oct 2022 11:27:07 +0100
Message-Id: <20221027102710.21407-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20221027102710.21407-1-srinivas.kandagatla@linaro.org>
References: <20221027102710.21407-1-srinivas.kandagatla@linaro.org>
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
 sound/soc/qcom/qdsp6/audioreach.c  |  44 ++++++------
 sound/soc/qcom/qdsp6/audioreach.h  |   9 ++-
 sound/soc/qcom/qdsp6/topology.c    | 103 +++++++++++++++++++++++++----
 4 files changed, 144 insertions(+), 39 deletions(-)

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
index 87a3fd1f8107..99cade6d8a48 100644
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
@@ -394,22 +385,30 @@ static void audioreach_populate_graph(struct q6apm *apm, struct audioreach_graph
 			apm_populate_module_list_obj(mlobj, container, sg->sub_graph_id);
 
 			list_for_each_entry(module, &container->modules_list, node) {
-				uint32_t src_mod_inst_id;
+				int pn;
 
-				src_mod_inst_id = module->src_mod_inst_id;
-
-				module_prop_obj = &mp_data->mod_prop_obj[nmodule];
+				module_prop_obj = &mp_data->mod_prop_obj[nmodule++];
 				apm_populate_module_prop_obj(module_prop_obj, module);
 
-				if (src_mod_inst_id) {
-					conn_obj = &mc_data->conn_obj[nconn];
-					apm_populate_connection_obj(conn_obj, module);
-					nconn++;
+				if (!module->max_op_port)
+					continue;
+
+				for (pn = 0; pn < module->max_op_port; pn++) {
+					if (module->dst_mod_inst_id[pn]) {
+						conn_obj = &mc_data->conn_obj[nconn];
+						conn_obj->src_mod_inst_id = module->instance_id;
+						conn_obj->src_mod_op_port_id =
+								module->src_mod_op_port_id[pn];
+						conn_obj->dst_mod_inst_id =
+								module->dst_mod_inst_id[pn];
+						conn_obj->dst_mod_ip_port_id =
+								module->dst_mod_ip_port_id[pn];
+						nconn++;
+					}
 				}
-
-				nmodule++;
 			}
-			mlobj = (void *) mlobj + APM_MOD_LIST_OBJ_PSIZE(mlobj, container->num_modules);
+			mlobj = (void *) mlobj + APM_MOD_LIST_OBJ_PSIZE(mlobj,
+									container->num_modules);
 
 			ncontainer++;
 		}
@@ -454,8 +453,7 @@ void *audioreach_alloc_graph_pkt(struct q6apm *apm, struct audioreach_graph_info
 				APM_MOD_LIST_OBJ_PSIZE(mlobj, container->num_modules);
 
 			list_for_each_entry(module, &container->modules_list, node) {
-				if (module->src_mod_inst_id)
-					num_connections++;
+				num_connections += module->num_connections;
 			}
 		}
 	}
@@ -500,7 +498,7 @@ void *audioreach_alloc_graph_pkt(struct q6apm *apm, struct audioreach_graph_info
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
index f66d7054177c..cccc59b570b9 100644
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
@@ -475,15 +544,23 @@ static struct audioreach_module *audioreach_parse_common_tokens(struct q6apm *ap
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
+			if (src_mod_op_port_id[pn] && dst_mod_inst_id[pn] &&
+			    dst_mod_ip_port_id[pn]) {
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

