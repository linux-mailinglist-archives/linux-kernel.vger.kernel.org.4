Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0C35EF7E2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbiI2Om3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbiI2OmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:42:23 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D19E1C4309;
        Thu, 29 Sep 2022 07:42:19 -0700 (PDT)
X-QQ-mid: bizesmtp84t1664461967tlxeozmi
Received: from localhost.localdomain ( [113.72.145.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 29 Sep 2022 22:32:46 +0800 (CST)
X-QQ-SSF: 01000000002000201000B00A0000000
X-QQ-FEAT: RFp2QSjOiS6rSVvirmoNsEVnXPjdjcrmOjO4alSyZJuuGn3m5l2mkkT2X4RnC
        CK462yAZBHaMBo1cztoX7M1ic/ZPFDAZtwN3zoQJikvOm1MvftwOBCjkzRJCYJojfjVtWDy
        3I6OkgH4ehb8nL2ssMUmX0FDiYXlq/m47tOaHaj48y8Sh4PPSXyplxH+eLdsUeSOT5Lr9eC
        3eeQnHobrfyTJ1LUb7lJa5F/1EbmCDssFwcK68137FL4tBq6MVRImxijrLdj6gv/FtWPcxU
        aKz74oQ/1ycNHXdrKCIlmUkLkGhZM6kI3H8S9QO4AcCzzwMW2XG5kyDtRZKhJqPSQ6gBAx0
        DbUpZM4zbxkLGHab9Bj41fN6fnj5GaZb2n2Hn7znxP/SFWsYu9UII52o3CCQJfzorZVcIeo
        YpcEB9CeQlEZByFFCMN8/g==
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
Subject: [PATCH v1 04/30] dt-bindings: sifive-l2-cache: Support StarFive JH71x0 SoCs
Date:   Thu, 29 Sep 2022 22:31:59 +0800
Message-Id: <20220929143225.17907-5-hal.feng@linux.starfivetech.com>
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

This cache controller is also used on the StarFive JH7100 and JH7110
SoCs.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
index ca3b9be58058..ba29ecfd3a92 100644
--- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
+++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
@@ -24,6 +24,8 @@ select:
         enum:
           - sifive,fu540-c000-ccache
           - sifive,fu740-c000-ccache
+          - starfive,jh7100-ccache
+          - starfive,jh7110-ccache
 
   required:
     - compatible
@@ -35,6 +37,8 @@ properties:
           - enum:
               - sifive,fu540-c000-ccache
               - sifive,fu740-c000-ccache
+              - starfive,jh7100-ccache
+              - starfive,jh7110-ccache
           - const: cache
       - items:
           - const: microchip,mpfs-ccache
-- 
2.17.1

