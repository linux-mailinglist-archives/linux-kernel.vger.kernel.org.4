Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1AE60F514
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiJ0K2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbiJ0K1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:27:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7694FE09D2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:27:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id t4so625911wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OQ1Vt/2QFgasQ2MWgN87SiOCnuqeXhPBQT7NHiM0Fk=;
        b=u+4/ZPzxou6PU2ScLM19n6nyyr59m0ucjfFYfdcKRdZK1pCX1a+7Cal7wyMRREOloB
         veQ8wTv9YgBRQM0qKYluqlCOYQ3G3y/eI4pFlTHWs07fZ8jABxH/UjLt4oxm+9GV7qzg
         HqTXMG2WnlRhBe4CeZuLBYWtXfYFQZICLiscPv656KpcUFuinclxrDQHj558SrYIpAnN
         a6Uz360Q0nUB+X4Z+8A4NXzKLn6riJX9UrWw0KHeyqMEedchtFVPesQ4/pZLa+JeGwPU
         AR6u6xYL2LWwx1EboNTDNBwZJWJ8PuvIP33M3swTq9BCdOM79XYzv1fuUxdHnvfMBDwZ
         jx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OQ1Vt/2QFgasQ2MWgN87SiOCnuqeXhPBQT7NHiM0Fk=;
        b=x6HF6ekupBmIi+T61xwol1j13CT0yzXtRB/+Iw/P8v8W2qRommh/x1Qs4dTvmzxeLa
         aWcuFGjYOzRGHTkUy2+jHRI55cffaDkaHFxadrUTNqb5fSEIT5SIbn3HYDHj+dEfSd+D
         e4qTeCA2t8lJKYA6XhLuuFr68TCalUlykkqkBxm+WMfdZta9OFT5yjFkrWslYGfSpggG
         OtyoFR4h7r/97QsztXUt5m5kZuafjQptV51aexfQxz6RoCE2eV7wNK68QUdMHqhOpAGk
         KT94mVFRxYFLuLFWvmB8WHen6FjLfgeo8vxlUJkZ0GpiIyqwwQfm6kFANEUiNIWRKJCX
         BRmg==
X-Gm-Message-State: ACrzQf26qtCIE8qWuB+/8kocTTYzrxKsTOJqYjHTaokSVy0NiaSoCKF2
        +5swnR1dQnX/bZ79Kf8n4itDVQ==
X-Google-Smtp-Source: AMsMyM7nnR+tXOuxJm5XaqvNau8Ryy8lYz1cK4eIHSsOsVP/44R6ANzyAzanZJ6EeidIG3LjEfKwFQ==
X-Received: by 2002:a05:600c:13c8:b0:3cf:4aa7:7562 with SMTP id e8-20020a05600c13c800b003cf4aa77562mr5258578wmg.104.1666866468014;
        Thu, 27 Oct 2022 03:27:48 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b003b505d26776sm5088674wmb.5.2022.10.27.03.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 03:27:47 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 7/9] ASoC: qdsp6: audioreach: add support to enable SAL Module
Date:   Thu, 27 Oct 2022 11:27:08 +0100
Message-Id: <20221027102710.21407-8-srinivas.kandagatla@linaro.org>
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

Add support to Simple Accumulator-Limiter module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c | 77 +++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/audioreach.h | 11 +++++
 2 files changed, 88 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 99cade6d8a48..be7068742fe4 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -658,6 +658,77 @@ static int audioreach_codec_dma_set_media_format(struct q6apm_graph *graph,
 	return rc;
 }
 
+static int audioreach_sal_limiter_enable(struct q6apm_graph *graph,
+					 struct audioreach_module *module, bool enable)
+{
+	struct apm_module_param_data *param_data;
+	struct param_id_sal_limiter_enable *limiter_enable;
+	int payload_size;
+	struct gpr_pkt *pkt;
+	int rc;
+	void *p;
+
+	payload_size = sizeof(*limiter_enable) + APM_MODULE_PARAM_DATA_SIZE;
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
+	param_data->param_id = PARAM_ID_SAL_LIMITER_ENABLE;
+	param_data->param_size = sizeof(*limiter_enable);
+	p = p + APM_MODULE_PARAM_DATA_SIZE;
+	limiter_enable = p;
+
+	limiter_enable->enable_lim = enable;
+
+	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
+
+	kfree(pkt);
+
+	return rc;
+}
+
+static int audioreach_sal_set_media_format(struct q6apm_graph *graph,
+					   struct audioreach_module *module,
+					   struct audioreach_module_config *cfg)
+{
+	struct apm_module_param_data *param_data;
+	struct param_id_sal_output_config *media_format;
+	int payload_size;
+	struct gpr_pkt *pkt;
+	int rc;
+	void *p;
+
+	payload_size = sizeof(*media_format) + APM_MODULE_PARAM_DATA_SIZE;
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
+	param_data->param_id = PARAM_ID_SAL_OUTPUT_CFG;
+	param_data->param_size = sizeof(*media_format);
+	p = p + APM_MODULE_PARAM_DATA_SIZE;
+	media_format = p;
+
+	media_format->bits_per_sample = cfg->bit_width;
+
+	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
+
+	kfree(pkt);
+
+	return rc;
+}
+
 static int audioreach_i2s_set_media_format(struct q6apm_graph *graph,
 					   struct audioreach_module *module,
 					   struct audioreach_module_config *cfg)
@@ -978,6 +1049,12 @@ int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_mod
 	case MODULE_ID_CODEC_DMA_SOURCE:
 		rc = audioreach_codec_dma_set_media_format(graph, module, cfg);
 		break;
+	case MODULE_ID_SAL:
+		rc = audioreach_sal_set_media_format(graph, module, cfg);
+		if (!rc)
+			rc = audioreach_sal_limiter_enable(graph, module, true);
+		break;
+
 	default:
 		rc = 0;
 	}
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index df5026b646c1..f2b51d8fc718 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -15,6 +15,7 @@ struct q6apm_graph;
 #define MODULE_ID_PCM_CNV		0x07001003
 #define MODULE_ID_PCM_ENC		0x07001004
 #define MODULE_ID_PCM_DEC		0x07001005
+#define MODULE_ID_SAL			0x07001010
 #define MODULE_ID_CODEC_DMA_SINK	0x07001023
 #define MODULE_ID_CODEC_DMA_SOURCE	0x07001024
 #define MODULE_ID_I2S_SINK		0x0700100A
@@ -499,6 +500,16 @@ struct data_logging_config {
 	uint32_t mode;
 } __packed;
 
+#define PARAM_ID_SAL_OUTPUT_CFG			0x08001016
+struct param_id_sal_output_config {
+	uint32_t bits_per_sample;
+} __packed;
+
+#define PARAM_ID_SAL_LIMITER_ENABLE		0x0800101E
+struct param_id_sal_limiter_enable {
+	uint32_t enable_lim;
+} __packed;
+
 #define PARAM_ID_MFC_OUTPUT_MEDIA_FORMAT	0x08001024
 
 struct param_id_mfc_media_format {
-- 
2.21.0

