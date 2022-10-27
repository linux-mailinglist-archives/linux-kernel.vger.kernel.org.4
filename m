Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E812160F515
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbiJ0K2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiJ0K1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:27:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A642C588C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:27:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l14so1416041wrw.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P38kTBSJr/DRXyh4Je0XkAOEtRTZS4roS95ylRUlbWA=;
        b=ILJoWb3XrEu77ZuGCBs0pipPfO4HGPcyLw4RSiRRZTtUO8SCysUSQExzlcDrTMIRvN
         cBb/7EBQclQbY0zrEv8j2I7E8PiPYHot7xwsKOOLha0kgM4OGpvJNZX/a/Bywk3iAGDq
         tiNgZJe/5heYhar822aPNtv4gneYYhPVFkUpLzNE02gv0IiOTV6YfhMHsZtnXsawmqJj
         Gekwk2Dr72DN8aRhqRrIln6/ekwlGOsmNGRspkG9AVr1XVz52NqnswULcIvM7d9N7a5L
         2wpww+JO5VccrA/sXkL/b5jdTiw4as9PKSPi1tCh9N8Y03eBbXgTg5IatcSelIrWtx/+
         8RIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P38kTBSJr/DRXyh4Je0XkAOEtRTZS4roS95ylRUlbWA=;
        b=Hc64NGWvJzU36gKcaUp+PJTIyMMqPI/tdYP31E2+lBmRVqo5akKOU0N4KGcOly82/8
         lEH2cH8RS+zdgX4EU/RyGkSFYNa6RmAA9HILx/rRAu1LoDsaFAV1LpsbJCQs2o5162BY
         PMadZ2o7KBvLMSbE1bNfsC8B6SHze0JI7vrAWZO0Fr5OmgtApHJFD+JSQhCmrMqs6iAt
         rV75UhjE6neQKS3M4IDuJez6pUaERH0s/87j7qJjBEsd0aGWU6tkzKbkLrc5cEXMtjlN
         VBuMbHdOTeaDaA7WgEaMcnBw28O1C1Gqaqr3jY3iOC2L4S/RHogzgBsnRsGl/P/PtARw
         wKZg==
X-Gm-Message-State: ACrzQf1I8lVL14YlwJC/sTC22U5JiDWkVo4BWVwbddaUi1Wh6NHkwMYF
        VtSjdXe2Ul1PHMeiA/2Qdv56zw==
X-Google-Smtp-Source: AMsMyM6n1kCTi8daTd2SVcuEjyzVj6ZAP/A2zOOB2oE7t372oUSp1ruGQ0IjsqMc53/pKEuRKijVQQ==
X-Received: by 2002:a05:6000:1b0e:b0:236:5c9e:7110 with SMTP id f14-20020a0560001b0e00b002365c9e7110mr18891472wrz.650.1666866470678;
        Thu, 27 Oct 2022 03:27:50 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b003b505d26776sm5088674wmb.5.2022.10.27.03.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 03:27:50 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 9/9] ASoC: qdsp6: audioreach: add support to enable module command
Date:   Thu, 27 Oct 2022 11:27:10 +0100
Message-Id: <20221027102710.21407-10-srinivas.kandagatla@linaro.org>
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

Add support to enable Module command which is required for logging
module to be able to debug.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c | 40 ++++++++++++++++++++++++++++++-
 sound/soc/qcom/qdsp6/audioreach.h |  5 ++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 1338b99f37e1..1e0c918eb576 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -731,6 +731,42 @@ static int audioreach_sal_set_media_format(struct q6apm_graph *graph,
 	return rc;
 }
 
+static int audioreach_module_enable(struct q6apm_graph *graph,
+				    struct audioreach_module *module,
+				    bool enable)
+{
+	struct apm_module_param_data *param_data;
+	struct param_id_module_enable *param;
+	int payload_size;
+	struct gpr_pkt *pkt;
+	int rc;
+	void *p;
+
+	payload_size = sizeof(*param) + APM_MODULE_PARAM_DATA_SIZE;
+
+	pkt = audioreach_alloc_apm_cmd_pkt(payload_size, APM_CMD_SET_CFG, 0);
+	if (IS_ERR(pkt))
+		return PTR_ERR(pkt);
+
+	p = (void *)pkt + GPR_HDR_SIZE + APM_CMD_HDR_SIZE;
+
+	param_data = p;
+	param_data->module_instance_id = module->instance_id;
+	param_data->error_code = 0;
+	param_data->param_id = PARAM_ID_MODULE_ENABLE;
+	param_data->param_size = sizeof(*param);
+	p = p + APM_MODULE_PARAM_DATA_SIZE;
+	param = p;
+
+	param->enable = enable;
+
+	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
+
+	kfree(pkt);
+
+	return rc;
+}
+
 static int audioreach_mfc_set_media_format(struct q6apm_graph *graph,
 					   struct audioreach_module *module,
 					   struct audioreach_module_config *cfg)
@@ -1077,7 +1113,9 @@ int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_mod
 
 	switch (module->module_id) {
 	case MODULE_ID_DATA_LOGGING:
-		rc = audioreach_logging_set_media_format(graph, module);
+		rc = audioreach_module_enable(graph, module, true);
+		if (!rc)
+			rc = audioreach_logging_set_media_format(graph, module);
 		break;
 	case MODULE_ID_PCM_DEC:
 	case MODULE_ID_PCM_ENC:
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 707dfbdbc156..1d1d47d47d40 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -537,6 +537,11 @@ struct payload_media_fmt_pcm {
 	uint8_t channel_mapping[];
 } __packed;
 
+#define PARAM_ID_MODULE_ENABLE			0x08001026
+struct param_id_module_enable {
+	uint32_t enable;
+} __packed;
+
 #define PARAM_ID_CODEC_DMA_INTF_CFG		0x08001063
 
 struct param_id_codec_dma_intf_cfg {
-- 
2.21.0

