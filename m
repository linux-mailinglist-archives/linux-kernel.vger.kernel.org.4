Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318B95EF7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbiI2OdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiI2OdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:33:03 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DFC1BBEC6;
        Thu, 29 Sep 2022 07:33:00 -0700 (PDT)
X-QQ-mid: bizesmtp84t1664461960tom9azgc
Received: from localhost.localdomain ( [113.72.145.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 29 Sep 2022 22:32:38 +0800 (CST)
X-QQ-SSF: 01000000002000201000B00A0000000
X-QQ-FEAT: D6RqbDSxuq4U0+4EPbhlMjbtgIHEmuIGrzAaZUV6P9r6ULT3ZXcYmfPkM7kLO
        tBLQOMC8PMUU56VMKQOiMxHeN9VBI/RvAQs9VVbFXGv3lrEVcKX3LTtljDm4ynytHSwHqs7
        IX+cDEieJ0sZzxp7ls2POaOH6vjec26x9BYYYtomP+zcVQQKje0Qmth/sFpONH6rLx4aRvC
        +y7PlGtVz5/ARbDdaCeQeXir0ovYVGRyyRet/C2HxvOlkjl/QheEHbRSEAcxAkCltpPK4Ur
        m0n5te34lTwwTWA+kHRCGIJP+SdRrmfGTnKe0DDh5lhVgdrLJBC7ThZNaNXNZLRtIwxGXVh
        uOxYC8lsqfPf7eDftNwYZ6+J9MzLsqp1QZYjOmU8pwPvMBNvHIlPHE3LIyh6gDnibW++45W
        Rv6JzftgGvNT3wHWmu/M5A==
X-QQ-GoodBg: 0
From:   Hal Feng <hal.feng@linux.starfivetech.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/30] dt-bindings: timer: Add StarFive JH7110 clint
Date:   Thu, 29 Sep 2022 22:31:57 +0800
Message-Id: <20220929143225.17907-3-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add compatible string for the StarFive JH7110 clint.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index e64f46339079..f85e4982ad05 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -26,6 +26,7 @@ properties:
       - enum:
           - sifive,fu540-c000-clint
           - starfive,jh7100-clint
+          - starfive,jh7110-clint
           - canaan,k210-clint
       - const: sifive,clint0
 
-- 
2.17.1

