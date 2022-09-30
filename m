Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FF25F101D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiI3QhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiI3Qg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:36:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D605B163CCB;
        Fri, 30 Sep 2022 09:36:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l14so10127121eja.7;
        Fri, 30 Sep 2022 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=l0m+9E3RrPBGmSZwDiB5yg6wloqO1uP7wOWBDHufpvI=;
        b=IqYgkVPxNnZS+HZ4Fydqs2C+P87Mp+AjKACFm38IcYDHP07Lk34vzrWuuctCmCEt0I
         s4ghgmYgxxL4gOGaCmm/GcUX49SgFw8BCDlont1Pd+7ujU2QI6bsm6RswV1MCtKhpLRW
         fC5IBBL+bKRdbeUgesaz3Z0PEPnfbomQVT9KYbAyly9cq8T6tI6NsFqom48lDbukU2+5
         zrJe89/1PQ64UjPn9zuyYnqiPEDALb0U3iWXB0cLz/w+706nQRBDp9q8RC2ple0ysH8X
         o9F3CoqOQ7DVRU4hOLmUV+EZcxMsRDATQK6DY5eJI2Xlw9vHj15Gv6R/BaZUeyVh82C4
         G/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=l0m+9E3RrPBGmSZwDiB5yg6wloqO1uP7wOWBDHufpvI=;
        b=vznLD4DFGjucpSDDjS+0ln5cRcww/GQrC/ytCT4Cpy4rtzpN8JM2pghrYTtlZZLRt7
         Hnrnob/eJ2EQkhzfA2ahgrfqAvkMgMN+oCS3MwKtLNnen6AajhWWAR24L/7+2y1jYR/b
         C7vNJIPZlAygBmecI+agmfZIewE6pBLctqzY3r3hnbjaFkkJmYhM6DJ/OuvMIHyUXyAk
         Uqwk5wH70tAoNNny1ndqmLSAl+MGiPVXo3XmqbBlAlHuAgqRrgGceGLlqgt+L6GM2CCa
         eTPD37ZzvOxYGFV+B/bFO7P+CV8FCDpBZsFyt8UyBqUoK+aMexukowNKDmnxotZKohE5
         tVtA==
X-Gm-Message-State: ACrzQf3nvycH9K6DnxPm3Wtb8XPxb4WX7tboS8m6blUTrpI6hciEc6Uc
        F7E7EMVmuunsC/CuJNZMBsc=
X-Google-Smtp-Source: AMsMyM4rzbG75FeYajqjF9cZOtKOOqQn5jYjboiHfFP5mZmGr5AdUXqB6NwhFyTrELxTWrwBr73GcQ==
X-Received: by 2002:a17:907:25c1:b0:77b:9966:ccf1 with SMTP id ae1-20020a17090725c100b0077b9966ccf1mr7181056ejc.763.1664555811525;
        Fri, 30 Sep 2022 09:36:51 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id t12-20020a056402240c00b0044e7862ab3fsm2011020eda.7.2022.09.30.09.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 09:36:50 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Tom Rini <trini@konsulko.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        u-boot@lists.denx.de, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2] dt-bindings: nvmem: u-boot,env: add Broadcom's variant binding
Date:   Fri, 30 Sep 2022 18:36:31 +0200
Message-Id: <20220930163631.27040-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Broadcom uses U-Boot for a lot of their bcmbca familiy chipsets. U-Boot
stores its configuration in an environment data block.

Such blocks are usually stored on flash as a separated partition at
hardcoded address. Broadcom however decided to:
1. Store env data block inside U-Boot partition
2. Avoid sticking to hardcoded offsets
3. Use custom header with "uEnv" magic and env data length

Example (length 0x4000):
$ hexdump -n 32 -C -s 0x40000 /dev/mtdblock0
00040000  76 6e 45 75 00 40 00 00  34 89 7a 82 49 4d 41 47  |vnEu.@..4.z.IMAG|
00040010  45 3d 4e 41 4e 44 3a 31  4d 2c 31 30 32 34 4d 00  |E=NAND:1M,1024M.|
(0x40000 offset is unit specific and can change)

Starting with the commit 118f3fbe517f4 ("dt-bindings: mtd: partitions:
support label/name only partition") DT can describe partitions matching
them by a name (without specifying actual address). With that feature
and this binding change it's possible to:
1. Specify DT node for Broadcom's U-Boot env data subpartition
2. Add nodes for specific environment data variables
3. Reference them as NVMEM cells

This binding is unlikely to help Broadcom's U-Boot. U-Boot SPL needs to
find environment data early (before it accesses DTB) and it does that by
looking for an "uEnv" magic. Dirty way.

This binding can however be used by operating systems. It allows
describing cleanly U-Boot, its env data and variables. It tells
operating system about Broadcom-specific env data so it can parse it.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Work on better commit body & add example
---
 .../devicetree/bindings/nvmem/u-boot,env.yaml | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
index e96bca99f2d9..987957e3ffc8 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -38,6 +38,8 @@ properties:
         const: u-boot,env-redundant-bool
       - description: Two redundant blocks with active having higher counter
         const: u-boot,env-redundant-count
+      - description: Broadcom's variant with custom header
+        const: brcm,env
 
   reg:
     maxItems: 1
@@ -73,3 +75,22 @@ examples:
             };
         };
     };
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            reg = <0x0 0x100000>;
+            compatible = "brcm,u-boot";
+            label = "u-boot";
+
+            partition-u-boot-env {
+                compatible = "brcm,env";
+
+                mac: ethaddr {
+                };
+            };
+        };
+    };
-- 
2.34.1

