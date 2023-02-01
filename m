Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1295A686786
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjBANwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjBANvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:51:48 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5237CEB42;
        Wed,  1 Feb 2023 05:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675259507; x=1706795507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BTaJ8+5KoTktS8xIJ9S3F/B2nJGMDHG1iYv6QpvokDI=;
  b=fhCNMjwOTmVBRYFmhOIeV2iy90n8HqT6l8PWw692yMZKShBoX8QLi/M+
   36IO0aWEjS1YteNh6it0TDHAAnhM9Vf5TvED3ELpncZea5MmHgkmRrAgp
   7CfWdGoY4qRu1jz/HrqBIVJh9xE8GEU1V5X3+UqtC0K3yIQuO1QW6aCc/
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Feb 2023 05:51:47 -0800
X-QCInternal: smtphost
Received: from nalasex01b.na.qualcomm.com ([10.47.209.197])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 05:51:46 -0800
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 05:51:40 -0800
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <quic_rohkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH 03/14] ASoC: q6dsp: audioreach: Add placeholder decoder for compress playback
Date:   Wed, 1 Feb 2023 19:19:36 +0530
Message-ID: <20230201134947.1638197-4-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230201134947.1638197-1-quic_mohs@quicinc.com>
References: <20230201134947.1638197-1-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add placeholder decoder graph module for compressed playback feature.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c |  2 ++
 sound/soc/qcom/qdsp6/audioreach.h | 39 +++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 1e0c918eb576..6d3d2a04ffe8 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -1120,6 +1120,8 @@ int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_mod
 	case MODULE_ID_PCM_DEC:
 	case MODULE_ID_PCM_ENC:
 	case MODULE_ID_PCM_CNV:
+	case MODULE_ID_PLACEHOLDER_DECODER:
+	case MODULE_ID_PLACEHOLDER_ENCODER:
 		rc = audioreach_pcm_set_media_format(graph, module, cfg);
 		break;
 	case MODULE_ID_I2S_SOURCE:
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 1d1d47d47d40..b78fd9bc8eb3 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -15,6 +15,8 @@ struct q6apm_graph;
 #define MODULE_ID_PCM_CNV		0x07001003
 #define MODULE_ID_PCM_ENC		0x07001004
 #define MODULE_ID_PCM_DEC		0x07001005
+#define MODULE_ID_PLACEHOLDER_ENCODER	0x07001008
+#define MODULE_ID_PLACEHOLDER_DECODER	0x07001009
 #define MODULE_ID_SAL			0x07001010
 #define MODULE_ID_MFC			0x07001015
 #define MODULE_ID_CODEC_DMA_SINK	0x07001023
@@ -22,6 +24,10 @@ struct q6apm_graph;
 #define MODULE_ID_I2S_SINK		0x0700100A
 #define MODULE_ID_I2S_SOURCE		0x0700100B
 #define MODULE_ID_DATA_LOGGING		0x0700101A
+#define MODULE_ID_AAC_DEC		0x0700101F
+#define MODULE_ID_FLAC_DEC		0x0700102F
+#define MODULE_ID_MP3_DECODE		0x0700103B
+#define MODULE_ID_GAPLESS		0x0700104D
 
 #define APM_CMD_GET_SPF_STATE		0x01001021
 #define APM_CMD_RSP_GET_SPF_STATE	0x02001007
@@ -142,12 +148,15 @@ struct param_id_enc_bitrate_param {
 } __packed;
 
 #define DATA_FORMAT_FIXED_POINT		1
+#define DATA_FORMAT_GENERIC_COMPRESSED		5
+#define DATA_FORMAT_RAW_COMPRESSED		6
 #define PCM_LSB_ALIGNED			1
 #define PCM_MSB_ALIGNED			2
 #define PCM_LITTLE_ENDIAN		1
 #define PCM_BIT_ENDIAN			2
 
 #define MEDIA_FMT_ID_PCM	0x09001000
+#define MEDIA_FMT_ID_MP3	0x09001009
 #define PCM_CHANNEL_L		1
 #define PCM_CHANNEL_R		2
 #define SAMPLE_RATE_48K		48000
@@ -225,6 +234,28 @@ struct apm_media_format {
 	uint32_t payload_size;
 } __packed;
 
+#define MEDIA_FMT_ID_FLAC	0x09001004
+
+struct payload_media_fmt_flac_t {
+	uint16_t num_channels;
+	uint16_t sample_size;
+	uint16_t min_blk_size;
+	uint16_t max_blk_size;
+	uint32_t sample_rate;
+	uint32_t min_frame_size;
+	uint32_t max_frame_size;
+} __packed;
+
+#define MEDIA_FMT_ID_AAC	0x09001001
+
+struct payload_media_fmt_aac_t {
+	uint16_t aac_fmt_flag;
+	uint16_t audio_obj_type;
+	uint16_t num_channels;
+	uint16_t total_size_of_PCE_bits;
+	uint32_t sample_rate;
+} __packed;
+
 #define DATA_CMD_WR_SH_MEM_EP_EOS			0x04001002
 #define WR_SH_MEM_EP_EOS_POLICY_LAST	1
 #define WR_SH_MEM_EP_EOS_POLICY_EACH	2
@@ -598,6 +629,13 @@ struct param_id_vol_ctrl_master_gain {
 } __packed;
 
 
+
+#define PARAM_ID_REAL_MODULE_ID	0x0800100B
+
+struct param_id_placeholder_real_module_id {
+	uint32_t real_module_id;
+} __packed;
+
 /* Graph */
 struct audioreach_connection {
 	/* Connections */
@@ -704,6 +742,7 @@ struct audioreach_module_config {
 	u16	active_channels_mask;
 	u32	sd_line_mask;
 	int	fmt;
+	struct snd_codec codec;
 	u8 channel_map[AR_PCM_MAX_NUM_CHANNEL];
 };
 
-- 
2.25.1

