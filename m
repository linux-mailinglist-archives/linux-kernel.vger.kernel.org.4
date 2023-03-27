Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5989B6CAB40
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjC0RBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjC0RBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:01:40 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298B13C31;
        Mon, 27 Mar 2023 10:01:36 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id r14so1183789oiw.12;
        Mon, 27 Mar 2023 10:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1cer0myC+DWXq6An3rnd+VU8s9Hlurez1Dtqg1RAXY=;
        b=ROpqpACInh74Ci1JpVcsye1pNNkh2QC+5vt5MySEHLTB65qEc0+9VAo1Hdmp92yWRP
         YqCoeKNy5+xl+WWB/sgoqeMvEsaSVJXPS8NFw61uk75VCWpdMk+czKjPbMGw5AmVtRAe
         QRuG30rc/GoZKrawXgMn363rhx+86VoOaCmy7OdSIlTYLWKhSMo/z48a34Fre5g0iYlC
         t4aIZVvRaJWjS/rYeBrs5mdQ3/BasskUEMzIZcSDsHKxE/oZopljBn8OPAnR0O93Y0i1
         dwB0VJjt0qkO5sIQsbq3M5QOOXJ5GmcbbVEmCQQr1bIZFRHqOhWNfR6WVBbPJQFiIu+I
         Xfgw==
X-Gm-Message-State: AO0yUKXx0guzd08hsBFqKI01Vln+EpBMhLFVEYDcmUWXe5LMQAgVB2h8
        A+qRuofsUUWJ1P92KYTGAg==
X-Google-Smtp-Source: AK7set9SgajdaFm03+ruzVbdS8nr9AGDu1wFpBNE1MkKTQ3SXd6u3tEkVayylaoJu/IVuphkeImN8w==
X-Received: by 2002:aca:2217:0:b0:387:6a3b:5a86 with SMTP id b23-20020aca2217000000b003876a3b5a86mr5256962oic.28.1679936493734;
        Mon, 27 Mar 2023 10:01:33 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n67-20020acabd46000000b0038919e6eb5esm1610639oif.3.2023.03.27.10.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:01:33 -0700 (PDT)
Received: (nullmailer pid 4104036 invoked by uid 1000);
        Mon, 27 Mar 2023 17:01:32 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] dt-bindings: reserved-memory: Drop unneeded quotes
Date:   Mon, 27 Mar 2023 12:01:22 -0500
Message-Id: <20230327170122.4103518-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/reserved-memory/google,open-dice.yaml          | 2 +-
 .../bindings/reserved-memory/nvidia,tegra210-emc-table.yaml | 2 +-
 .../devicetree/bindings/reserved-memory/phram.yaml          | 4 ++--
 .../devicetree/bindings/reserved-memory/qcom,cmd-db.yaml    | 6 +++---
 .../devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml | 6 +++---
 .../devicetree/bindings/reserved-memory/ramoops.yaml        | 6 +++---
 .../bindings/reserved-memory/shared-dma-pool.yaml           | 2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/google,open-dice.yaml b/Documentation/devicetree/bindings/reserved-memory/google,open-dice.yaml
index a924fcfca085..c591ec37d7e8 100644
--- a/Documentation/devicetree/bindings/reserved-memory/google,open-dice.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/google,open-dice.yaml
@@ -16,7 +16,7 @@ maintainers:
   - David Brazdil <dbrazdil@google.com>
 
 allOf:
-  - $ref: "reserved-memory.yaml"
+  - $ref: reserved-memory.yaml
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra210-emc-table.yaml b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra210-emc-table.yaml
index b1b0421a4255..e2ace3df942a 100644
--- a/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra210-emc-table.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra210-emc-table.yaml
@@ -14,7 +14,7 @@ description: On Tegra210, firmware passes a binary representation of the
   EMC frequency table via a reserved memory region.
 
 allOf:
-  - $ref: "reserved-memory.yaml"
+  - $ref: reserved-memory.yaml
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/reserved-memory/phram.yaml b/Documentation/devicetree/bindings/reserved-memory/phram.yaml
index 6c4db28015f1..65c7cacf9be4 100644
--- a/Documentation/devicetree/bindings/reserved-memory/phram.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/phram.yaml
@@ -17,8 +17,8 @@ maintainers:
   - Vincent Whitchurch <vincent.whitchurch@axis.com>
 
 allOf:
-  - $ref: "reserved-memory.yaml"
-  - $ref: "/schemas/mtd/mtd.yaml"
+  - $ref: reserved-memory.yaml
+  - $ref: /schemas/mtd/mtd.yaml
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml
index df1b5e0ed3f4..610f8ef37e8d 100644
--- a/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/reserved-memory/qcom,cmd-db.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/reserved-memory/qcom,cmd-db.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Command DB
 
@@ -20,7 +20,7 @@ maintainers:
   - Bjorn Andersson <bjorn.andersson@linaro.org>
 
 allOf:
-  - $ref: "reserved-memory.yaml"
+  - $ref: reserved-memory.yaml
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
index 08eb10c25821..bab982f00485 100644
--- a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/reserved-memory/qcom,rmtfs-mem.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/reserved-memory/qcom,rmtfs-mem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Remote File System Memory
 
@@ -15,7 +15,7 @@ maintainers:
   - Bjorn Andersson <bjorn.andersson@linaro.org>
 
 allOf:
-  - $ref: "reserved-memory.yaml"
+  - $ref: reserved-memory.yaml
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
index 0391871cf44d..45cc39ecc9f8 100644
--- a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/reserved-memory/ramoops.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/reserved-memory/ramoops.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Ramoops oops/panic logger
 
@@ -27,7 +27,7 @@ maintainers:
   - Kees Cook <keescook@chromium.org>
 
 allOf:
-  - $ref: "reserved-memory.yaml"
+  - $ref: reserved-memory.yaml
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml b/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
index 47696073b665..457de0920cd1 100644
--- a/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
@@ -10,7 +10,7 @@ maintainers:
   - devicetree-spec@vger.kernel.org
 
 allOf:
-  - $ref: "reserved-memory.yaml"
+  - $ref: reserved-memory.yaml
 
 properties:
   compatible:
-- 
2.39.2

