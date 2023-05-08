Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAE46FB21B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjEHN7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjEHN7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:59:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B3033D7C;
        Mon,  8 May 2023 06:59:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3062db220a3so2911563f8f.0;
        Mon, 08 May 2023 06:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683554372; x=1686146372;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ap+dt6+Pa1m8Kxx9UxC2AsvPRG1XDSvqlyGha2FT/kI=;
        b=HBuGbMkxGh/AbYCcbKiKQOztBhc+jLjY4LmfwPkYqZF+aJAk0/rRV/I5HF+x8wmvkw
         y1tpWse9mxSw/yaL8bKnCf1bxTnQ9mTxs9Os+54l0JY7RspToV6/8rCL9YWY0m/y6ymd
         SNYcT/IamI9zYp5Io53U3SQtl+DV17pjoVC/mazTXlMG8ATklhK4glP+I+QOFPkljBPQ
         89KxfBaJEyc7VtvcNgn4LY6sjVWA2w4LN0c7aSeaNIBKYsiEdN7FPZqMzxdvt6UNq6Xn
         XAeD0eZYoFe0cN3TFN+p4J1AOEUje4Nz7De6aDoTo9j5w7cwetdT+wC1l7EcYmy9n5xy
         9+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683554372; x=1686146372;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap+dt6+Pa1m8Kxx9UxC2AsvPRG1XDSvqlyGha2FT/kI=;
        b=J+Yh7skfy0ZzAWKAQ93hFth2tofcyIXZEPaum3fpLjXpRmQhCggo7ol+9tLv6U3sUG
         yugwxtG2pDvjkfa8MxDQBDHmuRA6oa7uq7GZVZO5tjNSbN2m15X+tgngWUZf/22mRjwj
         sWShcvKtoPmqKs8aMvKR1dwyx4N0JkPIEUX4UBKZ1ILbQRM7S6LPmqnI9+SGcEpvR4Iy
         CVSqjvI5M7OJ4oOmQpLBO8k+f8OBLSlDUqn8XDQ17s33BpHQVRgPXlvlSdOotwNTeeDw
         mvUXSuNZAy4ZlL8Z0ZFM5gxTz25863QO4SOCHMS0UWiP0PrHUWB+qmaUfy/TlV3Yqojd
         tRSw==
X-Gm-Message-State: AC+VfDyYulJ7m0xhuADvWcNPBKHku8K66AdCtXnyhF2rWVDudUJGIioQ
        sDHwj7RrdYo/FliNEamHZiI=
X-Google-Smtp-Source: ACHHUZ6aaX6s2lMros0F0QW4f4lUbYEPWGvBIUfJNplWFnviof2cVriAx5HdaFz/JnDPXdi6aEUciQ==
X-Received: by 2002:adf:ec8a:0:b0:2f6:c5bd:ba13 with SMTP id z10-20020adfec8a000000b002f6c5bdba13mr7293296wrn.42.1683554372138;
        Mon, 08 May 2023 06:59:32 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id l11-20020adfe58b000000b002f22c44e974sm11407238wrm.102.2023.05.08.06.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 06:59:31 -0700 (PDT)
Date:   Mon, 8 May 2023 15:59:30 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: soc: bcm: add missing dt-binding document for
 bcm23550-cdc
Message-ID: <20230508135930.GA27583@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Broadcom BCM23550 has a Cluster Dormant Control block that keeps the CPU
in idle state. A command needs to be sent to this block to bring the CPU
into running state.

This has been in use in mainline Linux since ~2016, but was never
documented. Add a dt-binding document for it.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../bindings/soc/bcm/brcm,bcm23550-cdc.yaml   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm23550-cdc.yaml

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm23550-cdc.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm23550-cdc.yaml
new file mode 100644
index 000000000000..1a952f569803
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm23550-cdc.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/bcm/brcm,bcm23550-cdc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM23550 Cluster Dormant Control
+
+description:
+  The Cluster Dormant Control block keeps the CPU in idle state. A command
+  needs to be sent to this block to bring the CPU into running state.
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    const: brcm,bcm23550-cdc
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
+    cdc@3fe0e000 {
+        compatible = "brcm,bcm23550-cdc";
+        reg = <0x3fe0e000 0x78>;
+    };
+...
-- 
2.25.1

