Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3546F92BD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjEFP3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjEFP3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:29:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9B618FED
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:29:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f0108a7d20so3270383e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683386986; x=1685978986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcFNxwZJjHoZpWKSHiKHs54BtGGOGq9ohvpv73Bd18I=;
        b=dJfpUgM6CZ/H3KrBlF220za0DUnhwRNDMlR/kzl8wWqnFA4DgVnHkZwAbpOTDjAlkM
         HigvIxMZShpDWvvX39CH3UhnaeyrkxB9KMsZSBuS9zMYMSri9QYJLfsZfG07MKxcBqRu
         tk88mzSsbBDhFlIpKo2IjpWAhyk77MIJAg5fs9YHM82CPN9tqmHCpdEO8MiqUgsNI0wK
         pxwqh9XbuJTIjHYJy4VLvBM29R+nBacy4GS1BojXQVGDimfGGYFPEmUNffHI2/inLPsJ
         NskppM6iNqwJxHyq8qsokTsLy2oRx0n0nupYHkH2e2sT3MIqdlqufomzjIFmGczYU8XY
         G53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683386986; x=1685978986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcFNxwZJjHoZpWKSHiKHs54BtGGOGq9ohvpv73Bd18I=;
        b=h5osUTe+8vso0G+bVUfRfvxWnQsfM55DJ8t4geon5zKMyFvzhdSyKO80rgU3W4bsfA
         cc8puKxz5ZlAJ3eA118n1azcwmaSfoiFYVYN9ggwxuIKuucJf7I67PsOlxBty//QecRE
         VtbUT99KTwfg2n3Kpoo3016YiALjzRplTQcUxRoqhfpxzVxAGZ5ZOd8Vm94pwFG/6psp
         U0BSDQz5XWxWV6avECyzWKsoL1QSS9Z9hi4WkNVnydrG2N441Mfr5wSK8l5l2difWW6t
         9/EIgucmc/BUvWiMNyIP/FeLGbgZQTzayOleKKq5aR+jQgwz7LH8yFA17kTi3LCLjKpp
         aiog==
X-Gm-Message-State: AC+VfDxXUZdmXh0WBrIzIj6GHUICt8MbZUzA1s742eRviUUDFkDURSfP
        UZaJoQnBgmCwcr3Jgd6cn6Aa9Q==
X-Google-Smtp-Source: ACHHUZ6GtyMk+NQ6GhlKalLwusNPGRbxL5sJNgSk9QivSz+TC736wa6j9aBzMTZaA949wCMGrPiWQg==
X-Received: by 2002:ac2:5298:0:b0:4ef:ec6a:198c with SMTP id q24-20020ac25298000000b004efec6a198cmr1448431lfm.26.1683386986519;
        Sat, 06 May 2023 08:29:46 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v5-20020a197405000000b004eff32d6a21sm680814lfe.121.2023.05.06.08.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 08:29:46 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 06 May 2023 17:29:44 +0200
Subject: [PATCH 1/2] dt-bindings: mtd: Add SEAMA partition bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-seama-partitions-v1-1-5806af1e4ac7@linaro.org>
References: <20230506-seama-partitions-v1-0-5806af1e4ac7@linaro.org>
In-Reply-To: <20230506-seama-partitions-v1-0-5806af1e4ac7@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This types of NAND partitions appear in OpenWrt and
U-Boot.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/mtd/partitions/seama.yaml  | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/seama.yaml b/Documentation/devicetree/bindings/mtd/partitions/seama.yaml
new file mode 100644
index 000000000000..352f008ffdb1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/seama.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/seama.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Seattle Image Partitions
+
+description: The SEAttle iMAge (SEAMA) partition is a type of partition
+  used for NAND flash devices. This type of flash image is found in some
+  D-Link routers such as DIR-645, DIR-842, DIR-859, DIR-860L, DIR-885L,
+  DIR890L and DCH-M225, as well as in WD and NEC routers on the ath79
+  (MIPS), Broadcom BCM53xx, and RAMIPS platforms.
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+select: false
+
+properties:
+  compatible:
+    const: seama
+
+  '#address-cells': false
+
+  '#size-cells': false
+
+patternProperties:
+  "@[0-9a-f]+$":
+    $ref: partition.yaml#
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    flash {
+      partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        firmware@0 {
+          compatible = "seama";
+          label = "firmware";
+          reg = <0x00000000 0x08000000>;
+        };
+      };
+    };

-- 
2.34.1

