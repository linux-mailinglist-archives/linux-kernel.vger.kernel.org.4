Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ABB64C5DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbiLNJ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237668AbiLNJ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:27:32 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8742421836;
        Wed, 14 Dec 2022 01:27:31 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f9so1574315pgf.7;
        Wed, 14 Dec 2022 01:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oDp0Y4hNKtuwWRzIl64XHBZWtkU1cebMe5ez5uOfwA=;
        b=pqjQzeUx5dqr1YIv0SnnHz+AquJUATPTy0QMtyTeqzG9ciXi8VFJ36NfszsDd0V3cM
         S1Z4RoLH7CDUhblnqxpNSMLEqp6SRFAA5uu1JPb3qjdY5OxzAQBfhjna8Tme/vakjNIa
         GpkLzn8VdJTC4/jTDayDwPJ2zCsAUkhupMRswh9l2IyKDZE822VrJyTtmC8HVuoXBBJJ
         J/wFRyXOb/HueYi4BZ+OuW8J8j5hOb3dw6OBKHVDlfe7oGqwqu04h6a4Yef3Sp1xRXE5
         yMUrXJ64S0KIQ7PVo5r9fTcqYa2bFHH3r6121GniS/820+VBXcLZeNYBz2c1E/7kTS+y
         u7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oDp0Y4hNKtuwWRzIl64XHBZWtkU1cebMe5ez5uOfwA=;
        b=Ezp5ogl5DPSCk/AVw5xYdqiLTIL8pq+4aRUmATgzM7fYywWFD5tYrQ92Ix6CZFR0pq
         GZd59CQvbp7mWi6EqBpccQM5PLAzuEJsyCXJlQnsHvR+Fm70rarJVHvzB6MugfnzCDrF
         I3rz8vlaxKI71uNYfBPE4y1Fs5av0nbHc80YAsm+ySdaO1T9Ej83OMe5m3osRrxqTxfH
         dKiMtnkuEwSIRSKMaxC5mG446zUj2mCXROnLNIiKf7pP/qrDaaomQ4aw91dhxVSstTQy
         TZiQI3XApJ1ANKvyxBvui5s1xJVcHULefS+2ClxqJ5Ply/ipKhAF80qi8Z6ZVXnFraPw
         goVw==
X-Gm-Message-State: ANoB5pnkG8hWpwuMRxnIu2UnY8YZle/MHtIjCbNPALH6xEOvBQKgDpJj
        3j0JXFN6b2hfs+KM5EfDGgA=
X-Google-Smtp-Source: AA0mqf7/dk4aWxX6iQbCbpBPPdJL/vG217lPXQbhmyLUP9sqy+fuXL1uh2qQphzUnvPObHLbPRZFfw==
X-Received: by 2002:aa7:83d7:0:b0:56c:cde:1a44 with SMTP id j23-20020aa783d7000000b0056c0cde1a44mr20623117pfn.11.1671010051011;
        Wed, 14 Dec 2022 01:27:31 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t123-20020a628181000000b00576145a9bd0sm9003312pfd.127.2022.12.14.01.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 01:27:30 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v8 3/7] dt-bindings: arm: nuvoton: Add bindings for NPCM GFXI
Date:   Wed, 14 Dec 2022 17:26:32 +0800
Message-Id: <20221214092636.810883-4-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221214092636.810883-1-milkfafa@gmail.com>
References: <20221214092636.810883-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings document for Graphics Core Information (GFXI) node. It
is used by NPCM video driver to retrieve Graphics core information.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 .../bindings/arm/npcm/nuvoton,gfxi.yaml       | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml

diff --git a/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
new file mode 100644
index 000000000000..7c8e5f99cc50
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/npcm/nuvoton,gfxi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Graphics Core Information block in Nuvoton SoCs
+
+maintainers:
+  - Joseph Liu <kwliu@nuvoton.com>
+  - Marvin Lin <kflin@nuvoton.com>
+
+description:
+  The Graphics Core Information (GFXI) are a block of registers in Nuvoton SoCs
+  that analyzes Graphics core behavior and provides information in registers.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nuvoton,npcm750-gfxi
+          - nuvoton,npcm845-gfxi
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    gfxi: gfxi@e000 {
+      compatible = "nuvoton,npcm750-gfxi", "syscon";
+      reg = <0xe000 0x100>;
+    };
-- 
2.34.1

