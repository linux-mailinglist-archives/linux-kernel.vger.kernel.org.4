Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E8A607CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiJUQx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJUQxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:53:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E9128F26F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:53:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bu30so5873442wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P38kTBSJr/DRXyh4Je0XkAOEtRTZS4roS95ylRUlbWA=;
        b=v2L7/MLQEM62vRMDJl2OvRagyQDMvI9Nymr91iGl6SCFtRwreusq9eArbalmCitKmw
         +hhaFtS/OnHIn+5Xf6nwDNqdfoUMc7HgHUiF2pUGEE3DwN7QEYkAcxb4cK4TRHIDHee5
         qtcn/Zh7JexBtSjqDnAv3pzmWv3BQM8oepnsMsqkgFsgD7GAXqIIdx6gyUhxyW1yZf0a
         jJ9asdZ03lPN3bVlMf+Jf6yZGUdf3sE3aPcWLKN0O7T8ZGPUQl3+gJSbTImklJ8iGhlu
         wGxVv2oHVoc11MJe/Ebl0h3dBwVu89Zv+HwtG2xPUafiph0CvZLyUJXmP5rEAerNZreA
         6mJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P38kTBSJr/DRXyh4Je0XkAOEtRTZS4roS95ylRUlbWA=;
        b=7DoqgyLV0Ul2nSKeTNdQo5MJh5ekjaLxTVfKAcLmZp1MQuz4iGNbTp17sjv8VV5duL
         d8dX7fvDHusAXPtzTCaB+JTxWK5DGxGDaWcOFHeaNcppbOx2ngDkOoyKMfv/fhMLuHzf
         JsBoaLYmc6uOrXxYYol89inFcgOb4oqlJOZ2fW52pRqrHoY5u96fbTqZnj4jsbriEeFO
         qmdydC+tjSU5p2TCT2gBBpWK4aa6rz4ojiLZadkCIAPrJ7Y7ephMTeuP3y3HiLeVQbw+
         Oou/5ntU19Jxp5IsGfM4b1sAyNGvqivdHbepRXak3oEZMom5eHd/Upc2LrqmDFjYDthi
         wuUQ==
X-Gm-Message-State: ACrzQf2VpiJ359+jxG6kLhXupxFc+X/+5SVoxKl2r7rQxaoyjnKYtJzu
        aMWqI46aP3GeVa2QTRGeQdyMow==
X-Google-Smtp-Source: AMsMyM6zQoWParlSxvfB2HUAFHKdeQhoLVug903b1NjXtgJhHefeJargZB0bYfSyjxfnLy/MCiC+Eg==
X-Received: by 2002:a5d:598d:0:b0:230:f238:a485 with SMTP id n13-20020a5d598d000000b00230f238a485mr13533983wri.71.1666371196492;
        Fri, 21 Oct 2022 09:53:16 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d400e000000b0022ae401e9e0sm19541773wrp.78.2022.10.21.09.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:53:15 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 9/9] ASoC: qdsp6: audioreach: add support to enable module command
Date:   Fri, 21 Oct 2022 17:52:07 +0100
Message-Id: <20221021165207.13220-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20221021165207.13220-1-srinivas.kandagatla@linaro.org>
References: <20221021165207.13220-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

