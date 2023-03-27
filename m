Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE406CAB6D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjC0REL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjC0RDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:03:05 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9575B8E;
        Mon, 27 Mar 2023 10:02:45 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-17ab3a48158so9982016fac.1;
        Mon, 27 Mar 2023 10:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SeYOWo17NBb5LwjtRv9cwvlWMOg9Mhp9twhBeVekPd8=;
        b=65zzXP8U/C+WIq8F5fvPKb3pTiLjJLDecc/f6Lt938zdqx5AkHLuLJU4lI9eGPMgft
         +ZzUIYTaNeRL6AjH7ezyBltSs9u4fQmQVTwSesO+anCWtPJD/UoP21/gq0/ArDRRRcvC
         UUr4lNKpPRJKfI7lqGFBBVnnYqZH9JHYWmYDaN/VtvPvSTHbdmr3ukhd5fqh2fYfspQA
         stZrIC9fGr69smwRJSE/kb+mQPSkBgNDU+VO/v2m64EDb3MuJCzBTZWlyGaV0tUARLH8
         uEOUIJLn9fgE9J/31pKUMmMj969nx5majupnYcUVHgKv9Sbrd6OhLfWxuXFCtRHPcL96
         wnNw==
X-Gm-Message-State: AO0yUKUnH2nx6BzA+QMCCvPT0ph3uHUAP2wuAtqgSvN4UIs/OaMEf5mG
        dJ7ckkFtZlkgrMnIkyHlBA==
X-Google-Smtp-Source: AKy350bYJwV674V/NT/QiO8BH27KTt+gXSM0CYfo27RZ2Hy/c9vYRecH/gvO1mw2vV9rm/kYGBxvUw==
X-Received: by 2002:a05:6870:3385:b0:177:8358:d03e with SMTP id w5-20020a056870338500b001778358d03emr7884692oae.16.1679936540740;
        Mon, 27 Mar 2023 10:02:20 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y81-20020acae154000000b003878631adaesm2916056oig.52.2023.03.27.10.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:02:19 -0700 (PDT)
Received: (nullmailer pid 4107685 invoked by uid 1000);
        Mon, 27 Mar 2023 17:02:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: soc: qcom: Drop unneeded quotes
Date:   Mon, 27 Mar 2023 12:02:04 -0500
Message-Id: <20230327170205.4106310-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml     | 4 ++--
 Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml     | 4 ++--
 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml | 4 ++--
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 4 ++--
 Documentation/devicetree/bindings/soc/qcom/qcom,smem.yaml    | 4 ++--
 Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml     | 4 ++--
 Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml   | 2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
index 6026c21736d8..dfcd41429d25 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/soc/qcom/qcom,apr.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/soc/qcom/qcom,apr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm APR/GPR (Asynchronous/Generic Packet Router)
 
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
index c98aab209bc5..14dd29471c80 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/soc/qcom/qcom,eud.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/soc/qcom/qcom,eud.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Embedded USB Debugger
 
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
index ab4df0205285..8a4b7ba3aaf6 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/soc/qcom/qcom,geni-se.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/soc/qcom/qcom,geni-se.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: GENI Serial Engine QUP Wrapper Controller
 
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index 16fd67c0bd1f..abb3bfde85a8 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/soc/qcom/qcom,smd-rpm.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/soc/qcom/qcom,smd-rpm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Resource Power Manager (RPM) over SMD/GLINK
 
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smem.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smem.yaml
index 497614ddf005..bc7815d985e4 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smem.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smem.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/soc/qcom/qcom,smem.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/soc/qcom/qcom,smem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Shared Memory Manager
 
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
index aca3d40bcccb..20c8cd38ff0d 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/soc/qcom/qcom,spm.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/soc/qcom/qcom,spm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Subsystem Power Manager
 
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml
index 0e6fd57d658d..74bb92e31554 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml
@@ -20,7 +20,7 @@ properties:
 
   firmware-name:
     $ref: /schemas/types.yaml#/definitions/string
-    default: "wlan/prima/WCNSS_qcom_wlan_nv.bin"
+    default: wlan/prima/WCNSS_qcom_wlan_nv.bin
     description:
       Relative firmware image path for the WLAN NV blob.
 
-- 
2.39.2

