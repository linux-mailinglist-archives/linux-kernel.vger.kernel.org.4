Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD7B68677A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjBANvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjBANvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:51:15 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51580EB42;
        Wed,  1 Feb 2023 05:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675259473; x=1706795473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5pZy22fgi/Cqs6/TrC4Ul5oC6fmyYexDIjImkw1GxWI=;
  b=Pdpwee/SdTekpgfvU2/tiV8hq1qJSOeTju3Z22qVTuedSWf0SiyEfSmk
   FJI0HgXzddUKuf8Ej4QrnVfV+K0irN+WkrEi+wZtcw7aBAeXOI2fTRY47
   9jtzY2KSS+VKw91nEKU1GLY7DfgQamvPtHSdNqfdZkEViZ0xQXls0nKBR
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Feb 2023 05:51:13 -0800
X-QCInternal: smtphost
Received: from nalasex01b.na.qualcomm.com ([10.47.209.197])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 05:51:11 -0800
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 05:51:04 -0800
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
Subject: [PATCH 00/14] Add support for compress offload and gapless playback.
Date:   Wed, 1 Feb 2023 19:19:33 +0530
Message-ID: <20230201134947.1638197-1-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
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

Add support for compress offload and gapless playback in audioreach
platform drivers.

Mohammad Rafi Shaik (14):
  ALSA: compress: Update compress set params for gapless playback
  ASoC: qcom: SC7280: audioreach: Add sc7280 hardware param fixup
    callback
  ASoC: q6dsp: audioreach: Add placeholder decoder for compress playback
  ASoC: q6dsp: audioreach: Add support for compress offload commands
  ASoC: q6dsp: audioreach: Add support to set compress params
  ASoC: q6dsp: audioreach: Add support for sending real module ID to
    ADSP
  ASoC: q6dsp: q6apm-dai: Add async compress write support
  ASoC: q6dsp: q6apm-dai: Add open/free compress DAI callbacks
  ASoC: q6dsp: q6apm-dai: Add compress DAI and codec caps get callbacks
  ASoC: q6dsp: q6apm-dai: Add trigger/pointer compress DAI callbacks
  ASoC: q6dsp: q6apm-dai: Add compress set params and metadata DAI
    callbacks
  ASoC: q6dsp: q6apm-dai: Add mmap and copy compress DAI callbacks
  ASoC: qdsp6: audioreach: Add MP3, AAC and FLAC compress format support
  ASoC: q6dsp: audioreach: Add gapless feature support

 sound/core/compress_offload.c     |  12 +-
 sound/soc/qcom/qdsp6/audioreach.c | 299 +++++++++++++++++--
 sound/soc/qcom/qdsp6/audioreach.h |  56 ++++
 sound/soc/qcom/qdsp6/q6apm-dai.c  | 464 ++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6apm.c      | 117 ++++++++
 sound/soc/qcom/qdsp6/q6apm.h      |   8 +
 sound/soc/qcom/sc7280.c           |  21 +-
 7 files changed, 950 insertions(+), 27 deletions(-)

-- 
2.25.1

