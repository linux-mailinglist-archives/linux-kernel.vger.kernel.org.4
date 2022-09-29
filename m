Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C39F5EF7A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbiI2OdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbiI2OdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:33:01 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAE01BCAF7;
        Thu, 29 Sep 2022 07:32:56 -0700 (PDT)
X-QQ-mid: bizesmtp84t1664461956td7juhb5
Received: from localhost.localdomain ( [113.72.145.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 29 Sep 2022 22:32:34 +0800 (CST)
X-QQ-SSF: 01000000002000201000B00A0000000
X-QQ-FEAT: Mxc3K7F63kyyWiQ/c8gCwhtJ1DS2YJuLU+aiWy+m3Y1tJkbqYk2wOc4QwNoyC
        9bXGKXrGKQuvi+/y8R1BOk2166YEp7ysra5hy/3sB4CcxVCn3CfBGgw4iNBgTdygOwQ61il
        o24Cmsov4rvvRLt2pZay/2ZkWs3o3lwKRKoS+5BLzkVntSz1urBWUlMbSnF4TOvlwJbQnXO
        1VClThiMUZrGb0ZNGT1c7k03ZKNfyXFJOMTq/A4mEaQiTfKSNg0GhHlo7uhJxBvsgb0azSU
        m36FNSaIAHxOeNNbdRsPzzMK1YWzSBhoW8EJuqqqYz4Ux3A6cFzVDnQ55/dzNeT6TzC14YQ
        fhS6wgeQcLW430Zq6AHYjnaHBtYhRicV/gA8rEwWbmAAf1XXLmWQCD8UtIa+BGKhUhEjqQG
        Yx5d+4dCT4y0gScP5kK7wQ==
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
Subject: [PATCH v1 01/30] dt-bindings: riscv: Add StarFive JH7110 bindings
Date:   Thu, 29 Sep 2022 22:31:56 +0800
Message-Id: <20220929143225.17907-2-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add device tree bindings for the StarFive JH7110 RISC-V SoC and the
VisionFive2 board for it.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 Documentation/devicetree/bindings/riscv/starfive.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
index 5b36243fd674..543be573921d 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -21,6 +21,9 @@ properties:
       - items:
           - const: beagle,beaglev-starlight-jh7100-r0
           - const: starfive,jh7100
+      - items:
+          - const: starfive,visionfive-v2
+          - const: starfive,jh7110
 
 additionalProperties: true
 
-- 
2.17.1

