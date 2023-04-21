Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834456EB3E0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 23:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjDUVsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjDUVsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:48:22 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B8F92;
        Fri, 21 Apr 2023 14:48:20 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6a438f0d9c9so2037793a34.1;
        Fri, 21 Apr 2023 14:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682113700; x=1684705700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRyhlU6c3feVqq/s8FXw+A2ovCuk/nDpRc2zb7Wb02o=;
        b=gxNxtdjzoe/XKbmMXUtCXzrZ45OCZaKdKG0hymenhTIqIsokflVij1J/a5z1H3mrzB
         ukna95A4RJAqJoh0clTO5u6jLou3BAKYOnEswyl2Uf6es7yAQi/WO1BlJa7U5AiRaSSv
         FXkvIQDDXZPPpmAvx/EiOPRAWYt2sdH5TeeT7Ezy51mKWykSrWoC+8hZ6D47lfo//OH6
         wF9uodnFsGAfVBexDHlarVcZan1cr56QcaSAvdRQuqzqGkVCk+crK4k15PtJqNoFtrUo
         qeivE2+ZTBvYQ/J7b9g8cJ+3VhhJT7yg8ZuaR5msNtjVlMhfwqL5/wFciJpZA30Jjlef
         LVgA==
X-Gm-Message-State: AAQBX9fuzAnpuFXZnXdwPlDP9nW9TgYHeaq4mqAujRvNqsmuj+3u92UM
        Sltc6f4P73HT0BFPrdEQkBk1bKF1fw==
X-Google-Smtp-Source: AKy350aZUQfz+TT7Tkt8vP5BUlF8jQwcYin20eCbq0naZufUG8oi6julfm/UDVlx8BlcTVY1c1/c/Q==
X-Received: by 2002:a05:6830:1698:b0:6a6:2f86:978d with SMTP id k24-20020a056830169800b006a62f86978dmr2681665otr.12.1682113700088;
        Fri, 21 Apr 2023 14:48:20 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dk10-20020a0568303b0a00b006a60606de62sm2128180otb.52.2023.04.21.14.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 14:48:19 -0700 (PDT)
Received: (nullmailer pid 1812127 invoked by uid 1000);
        Fri, 21 Apr 2023 21:48:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH] ASoC: dt-bindings: More dropping unneeded quotes
Date:   Fri, 21 Apr 2023 16:48:10 -0500
Message-Id: <20230421214810.1811962-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another batch of dropping unneeded quotes on $id and $schema which were
missed in the last round. Once all these are fixed, checking for this can
be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/nvidia,tegra-audio-common.yaml  | 4 ++--
 Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml   | 4 ++--
 .../devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml    | 4 ++--
 .../devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml     | 4 ++--
 Documentation/devicetree/bindings/sound/tas2562.yaml          | 4 ++--
 Documentation/devicetree/bindings/sound/tas2770.yaml          | 4 ++--
 Documentation/devicetree/bindings/sound/tas27xx.yaml          | 4 ++--
 Documentation/devicetree/bindings/sound/wlf,wm8903.yaml       | 4 ++--
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml
index 7c1e9895ce85..2588589ad62d 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/sound/nvidia,tegra-audio-common.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Common properties for NVIDIA Tegra audio complexes
 
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
index cdbb4096fa44..9e5b30d9c6e6 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/sound/qcom,q6apm-dai.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/sound/qcom,q6apm-dai.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Audio Process Manager Digital Audio Interfaces
 
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
index 1168410f6fbd..3552c44137ed 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/sound/qcom,q6dsp-lpass-clocks.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/sound/qcom,q6dsp-lpass-clocks.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm DSP LPASS Clock Controller
 
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
index 044e77718a1b..08c618e7e428 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/sound/qcom,q6dsp-lpass-ports.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/sound/qcom,q6dsp-lpass-ports.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm DSP LPASS(Low Power Audio SubSystem) Audio Ports
 
diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
index a5bb561bfcfb..41489a3ac79f 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2019 Texas Instruments Incorporated
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/sound/tas2562.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/sound/tas2562.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Texas Instruments TAS2562 Smart PA
 
diff --git a/Documentation/devicetree/bindings/sound/tas2770.yaml b/Documentation/devicetree/bindings/sound/tas2770.yaml
index 26088adb9dc2..930bd111b072 100644
--- a/Documentation/devicetree/bindings/sound/tas2770.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2770.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2019-20 Texas Instruments Incorporated
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/sound/tas2770.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/sound/tas2770.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Texas Instruments TAS2770 Smart PA
 
diff --git a/Documentation/devicetree/bindings/sound/tas27xx.yaml b/Documentation/devicetree/bindings/sound/tas27xx.yaml
index 8cba01316855..bda26b246634 100644
--- a/Documentation/devicetree/bindings/sound/tas27xx.yaml
+++ b/Documentation/devicetree/bindings/sound/tas27xx.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2020-2022 Texas Instruments Incorporated
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/sound/tas27xx.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/sound/tas27xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Texas Instruments TAS2764/TAS2780 Smart PA
 
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8903.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8903.yaml
index 7105ed5fd6c7..4cfa66f62681 100644
--- a/Documentation/devicetree/bindings/sound/wlf,wm8903.yaml
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8903.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/sound/wlf,wm8903.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/sound/wlf,wm8903.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: WM8903 audio codec
 
-- 
2.39.2

