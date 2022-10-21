Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777FA606FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJUGBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJUGBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:01:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1279A1A4003;
        Thu, 20 Oct 2022 23:00:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g1so3272959lfu.12;
        Thu, 20 Oct 2022 23:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C5hHs2S/RQl/JXIwHudGm/5mav5RsuOJ5skKbHJaT7M=;
        b=OYP1l1n6nvRFKN66YMNkW/ZD0biklmoqW7/GKmlBQ/5ENQhPpcHwgnW/rNIUjRoyeq
         mUi4KXWRSDufdZ1cvTW+/XnGUEaYLFilpxFrjNlzxEDxCFeoa4hoLVhGgnokrL4GUPet
         uKYNILHU9QWMrCKkaYtUezb0B7qpROKi1T0G3/hNigGE37igbdbYuW2uvo4prBisHInc
         RUEzuiYlVyFbUVo4KlAGbb6R/AWWoEOYu7HdZU0ekJPUOU2oH4HXT/NQl7KkNx7KZB/t
         L3IccSVZ1ulaB+TjsnFK+9dkyAMqV/YBwlFRErIyCwwNXGnUijQlIUCwJg60u7yjz9E8
         xS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5hHs2S/RQl/JXIwHudGm/5mav5RsuOJ5skKbHJaT7M=;
        b=7EMsyztakmfRRe2zr23yF2ft/z26d8HOGVOVvypa0C4Dq8QhD2SYIK6tT69rLjMGN4
         ZkHhCeMQZ/IVrcO4Xz1hJYdobO3vKpFT1FMYk5x18IqUhWQo7y8ZRVvmkNGcjgD47ts9
         BZy5UqWdASpXXTa1+5jFjumuSUEkZHQoaVCdaE9i8UJUR7/P7TE/Vgm2ZDPHO7j/AT/x
         ZNmb2CaARC4stxeOY8wgt5uSKZHASGJra9mD7BqpSDdGmy75tGjtOuppYq1guBA+8ZuR
         jhKHEr66OT/zv0u6crgYtpQXn8sZtT0zT+XkIXgazPK8TupnzorB8sqc5QaDpB5W4KIz
         DC8g==
X-Gm-Message-State: ACrzQf3RVbqEA+W05gbsA6J3sSkEQrDaclWs8pkl9XhyEV85OU/ktDV+
        eTAIZ5x5v06+GshQ2YNjMXE=
X-Google-Smtp-Source: AMsMyM6WDH7wq1u5kd3U+odFfEpgQ30j9+6ajofiuy78KRWiVD1E3qXL80lU1+kvXFHzYz3QOVAQIg==
X-Received: by 2002:ac2:5321:0:b0:4a4:3c25:dbd with SMTP id f1-20020ac25321000000b004a43c250dbdmr5837748lfh.406.1666332056154;
        Thu, 20 Oct 2022 23:00:56 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id p6-20020ac246c6000000b0049e9122bd0esm3021950lfo.114.2022.10.20.23.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 23:00:55 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 1/2] dt-bindings: mtd: partitions: support marking rootfs partition
Date:   Fri, 21 Oct 2022 08:00:50 +0200
Message-Id: <20221021060051.2508-1-zajec5@gmail.com>
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

Linux needs to know what to use as root device. On embedded devices with
flash the only common way to specify that is cmdline & root= parameter.

That solution works with U-Boot which is Linux & cmdline aware but isn't
available with all market bootloaders. Also that method is fragile:
1. Requires specific probing order on multi-flash devices
2. Uses hardcoded partitions indexes

A lot of devices use different partitioning methods. It may be
"fixed-partitions" or some dynamic partitioning (e.g. based on parts
table). For such cases allow "linux,rootfs" property to mark correct
flash partition.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Use "linux,rootfs" as more accurate. Thanks Rob.
---
 .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml  | 1 +
 .../devicetree/bindings/mtd/partitions/partition.yaml         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index ad3ccd250802..d66a6e3bcb56 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -84,6 +84,7 @@ examples:
         partition@0 {
             label = "filesystem";
             reg = <0x00000000 0x1 0x00000000>;
+            linux,rootfs;
         };
     };
 
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index f1a02d840b12..a25cd23a34c0 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -52,6 +52,10 @@ properties:
       immune to paired-pages corruptions
     type: boolean
 
+  linux,rootfs:
+    description: Marks partition that contains root filesystem to mount and boot
+      user space from
+
 if:
   not:
     required: [ reg ]
-- 
2.34.1

