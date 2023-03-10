Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C646B3CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCJKxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjCJKxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:53:39 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8E364B31;
        Fri, 10 Mar 2023 02:53:37 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id i28so6119261lfv.0;
        Fri, 10 Mar 2023 02:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678445615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BAQLdEeSrfZYQHVCxX67ELAHVT8Gl44hvbILMrM52aY=;
        b=ICetKMmwCbwiDaE3yxZqjn1i8MDyjkxLfzPryIFYluhAX4cs+hkaiU7gRkMyRf1Pz3
         KJZ1Kuqp6KFJctWPSUefng+c9ORzp0dsPVLkm1eE6R7s0A1Nb/gnZvl9bik8p2fpe6Ng
         6AuNYO08jRgLr1ICaUBJaP4Zg6/syX8m/5QwjbY4XAIprHZyKCRl7iBrsKCdUSQwipYh
         gdNbDKIqgQsPeK/CYyC8nBrlWfiIUZ+ILKPupulpnIf0/fkaenb9bCmGT2lDVCWM0yx6
         ZzMynhGA1lmX9cHFtwT1YJwUkI5yMebzfM0sUDCNZjrScq7Q56KYo83m9o8yHGgufQ4J
         z/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678445615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAQLdEeSrfZYQHVCxX67ELAHVT8Gl44hvbILMrM52aY=;
        b=eG8omrp2g/nY+DmtBopbzkUm8l+gdv7DBqJvwGNZzrjzT2rR8OMGOnmsZNwjUHtPYl
         Z23vdsOnK4Z3k8OTCUFAOvHau8liVSfx+1xX5p3F6JTgmTQkCR9OMd7tLCWTOxgBpRZk
         H93hPJZGQEEZRE2r6590Lqmr/wSEIg5W4AAYfYI9WcIZELSlsqhMEryKetuMfIPOTiK6
         QbtqaFDrVMMyV8/MONPzVZ8cI+luJDAIXcAMU8suOHlFP28lFmec8FoZegzYmJOlDV9i
         bou/cHZ8LSXcKxbFC6MmIBXNVG4i7I1l335b8cVcyEw3I14Cpa9DG8PR+jJrfzU8owcr
         IwFA==
X-Gm-Message-State: AO0yUKV0Yu69NfNx5bFxNBfOX6z7gyjcAK4AhL9NT+RH+H1Z1Du4pocs
        eyuAVpD0EmPFlmP3CYqQGrM=
X-Google-Smtp-Source: AK7set9Pu1hCa4aONY/APd64XeHEzqooYZVnWsx7KB+q0u6a5dWjYGHYDwgMHXNkRCFxPDkErwii4Q==
X-Received: by 2002:ac2:4432:0:b0:4d8:7f17:d0e9 with SMTP id w18-20020ac24432000000b004d87f17d0e9mr5963165lfl.14.1678445615544;
        Fri, 10 Mar 2023 02:53:35 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id q5-20020a2eb4a5000000b0029335c12997sm194532ljm.58.2023.03.10.02.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 02:53:34 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: nvmem: allow MTD to be explicitly an NVMEM provider
Date:   Fri, 10 Mar 2023 11:53:30 +0100
Message-Id: <20230310105330.14181-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

There are a lot of devices with NVMEM content stored in MTD devices in
relevant partitions. Add a DT binding for marking such partitions.

Note: Linux already treats every MTD partition as NVMEM provider so in
general it doesn't need to care about this binding. It's meant just to
make DT clearer in describing hardware.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
As explained in commit body this isn't really needed for Linux. I
thought it'd be a small nice addition for writing clear DTS files.
---
 .../devicetree/bindings/nvmem/mtd.yaml        | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mtd.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/mtd.yaml b/Documentation/devicetree/bindings/nvmem/mtd.yaml
new file mode 100644
index 000000000000..7435b2803cf9
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/mtd.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/mtd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MTD access based NVMEM
+
+description: |
+  MTD partitions can be NVMEM providers. This binding allows explicitly marking
+  such partitions.
+
+  The exact way of handling MTD partition content (NVMEM cells) should be
+  described using a proper NVMEM layout.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+allOf:
+  - $ref: nvmem.yaml#
+  - $ref: /schemas/mtd/partitions/partition.yaml#
+
+properties:
+  compatible:
+    const: mtd-nvmem
+
+  reg:
+    maxItems: 1
+
+required:
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            compatible = "mtd-nvmem";
+            reg = <0x0 0x40000>;
+            label = "device-data";
+
+            nvmem-layout {
+                /* Just a dummy example: Kontron can be found on OTP actually */
+                compatible = "kontron,sl28-vpd";
+            };
+        };
+    };
-- 
2.34.1

