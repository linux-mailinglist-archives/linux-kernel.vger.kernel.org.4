Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE1C701E8A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbjENRJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbjENRIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:08:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA93F4693;
        Sun, 14 May 2023 10:08:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 597EA60A48;
        Sun, 14 May 2023 17:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8238DC433A1;
        Sun, 14 May 2023 17:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684084104;
        bh=nU59cXNxIxg1xRf83ZxNAjnBWCbOsi5G1w81Y+YE8yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Meb4Y+On006rm678MW9DN64znWuDr1LMYi1YqQAn6ojS/MTd919WahW9qrt7E1ia3
         0VajTyDOXUhATVqtiDNJ3nRIpTtYVEggVRnriuS0gmtRAsYjk65eYKufGKamsCUgFN
         uiASwoMfd27S6cQNeGVh1OW2zrtW7oPc2A8cqwjROzuAVJJ3Yn4xhZ9XPiBBQ2zN+z
         Wx264H/zdGkZrBAlip9e6SEAnZuppZ3B21NwH5YZb9oNzVTbccdl6qpP6VoD5KB6oC
         QCCqg6v78Xba1zrFulToJyY4u/2lEttKCWhs4rFB4o2F8tNqQ5cbf5MkclxDrP9rXQ
         mXR8XtWVmqdWA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 06/10] dt-bindings: riscv: Add bouffalolab bl808 board compatibles
Date:   Mon, 15 May 2023 00:56:47 +0800
Message-Id: <20230514165651.2199-7-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230514165651.2199-1-jszhang@kernel.org>
References: <20230514165651.2199-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several SoMs and boards are available that feature the Bouffalolab
bl808 SoC. Document the compatible strings.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 .../bindings/riscv/bouffalolab.yaml           | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/bouffalolab.yaml

diff --git a/Documentation/devicetree/bindings/riscv/bouffalolab.yaml b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
new file mode 100644
index 000000000000..3b25d1a5d04a
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/bouffalolab.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bouffalo Lab Technology SoC-based boards
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+description:
+  Bouffalo Lab Technology SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Carrier boards for the Sipeed M1s SoM
+        items:
+          - enum:
+              - sipeed,m1s-dock
+          - const: sipeed,m1s
+          - const: bouffalolab,bl808
+
+additionalProperties: true
+
+...
-- 
2.40.0

