Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BEE69B228
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 19:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBQSBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 13:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBQSBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:01:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FD029E3A;
        Fri, 17 Feb 2023 10:01:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0C9D61F1E;
        Fri, 17 Feb 2023 18:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A06C433D2;
        Fri, 17 Feb 2023 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676656876;
        bh=9IlSeuq9CAxECTILWyWm/AaYhbpQX8KMl7DQW/S45fw=;
        h=From:To:Cc:Subject:Date:From;
        b=TtYfXVs6f4cTXtZTzgxFox8eqLBulwVarNzV1junGS9C2DGYyVh0Hz53t+jB1QyQ3
         sRAU4BxlcMiG/9LYJNWVvMK9mAletuA2L0ilRmtd2xBEKCAlBHtYhJRxUlMY9/8s4N
         Z9TORfvYJ/D4SZlOuk+5mRk6ysWMc4kCsdREvV6hwTnl9UzGaQyBAAvcvksIgQkIt2
         gUBtaK33ITjlLRX0yMpcz/fvNMdfF4t1cBe5d0UjsNn41uIBFqP4vLmNSDDQqR9t2/
         YXbkb+Ixqk3ReB98w6Jb9Qgr1y4wSlnPRfEvDSj9+EikmGiuoUTy58OPYuHaVLRLs8
         c9QIsfgtfJAgQ==
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     conor@kernel.org, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Sagar Kadam <sagar.kadam@openfive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>
Subject: [PATCH] dt-bindings: drop Sagar Kadam from SiFive binding maintainership
Date:   Fri, 17 Feb 2023 18:00:36 +0000
Message-Id: <20230217180035.39658-1-conor@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3439; i=conor.dooley@microchip.com; h=from:subject; bh=nhdSMpAMHcDxZQ/G9fKc2bxint/gSH+fhiDQTwTY+dM=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDMnvDxxet0Qq9OYUtjIF+YPbTy3dWHe3ct2aXeseJXkoXMuv PK43p6OUhUGMg0FWTJEl8XZfi9T6Py47nHvewsxhZQIZwsDFKQATmanO8M8w4umr3fe2nJj14Cj37f ZaJhuGY/fWH3z9stbvZJ76XuvLDP/rJrNI3zpvpvzw3kyDnHedXx5O3uehJr2z9fcau0/51Tl8AA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Sagar's email listed in maintainers is bouncing as his division was sold
off by the company. I attempted to contact him some days ago on what the
bounce email told me was his new contact information, but am yet to
receive a response.

Paul and Palmer are listed on each of the bindings, both of whom were
alive & well as of Wednesday so the bindings remain maintained.

CC: Sagar Kadam <sagar.kadam@openfive.com>
CC: Sagar Kadam <sagar.kadam@sifive.com>
Link: https://lore.kernel.org/all/785425ca-4000-a7e4-16d6-4d68c91b158d@kernel.org/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Palmer/Paul, as mentioned Wednesday, here you go!
---
 Documentation/devicetree/bindings/clock/sifive/fu540-prci.yaml | 1 -
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml       | 1 -
 Documentation/devicetree/bindings/pwm/pwm-sifive.yaml          | 1 -
 Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml    | 3 +--
 4 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/sifive/fu540-prci.yaml b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.yaml
index c3be1b600007..c79e752283aa 100644
--- a/Documentation/devicetree/bindings/clock/sifive/fu540-prci.yaml
+++ b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.yaml
@@ -8,7 +8,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: SiFive FU540 Power Reset Clock Interrupt Controller (PRCI)
 
 maintainers:
-  - Sagar Kadam <sagar.kadam@sifive.com>
   - Paul Walmsley  <paul.walmsley@sifive.com>
 
 description:
diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 99e01f4d0a69..63bc89e13480 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -45,7 +45,6 @@ description:
   from S-mode. So add thead,c900-plic to distinguish them.
 
 maintainers:
-  - Sagar Kadam <sagar.kadam@sifive.com>
   - Paul Walmsley  <paul.walmsley@sifive.com>
   - Palmer Dabbelt <palmer@dabbelt.com>
 
diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
index 605c1766dba8..bae993128981 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
@@ -8,7 +8,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: SiFive PWM controller
 
 maintainers:
-  - Sagar Kadam <sagar.kadam@sifive.com>
   - Paul Walmsley <paul.walmsley@sifive.com>
 
 description:
diff --git a/Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml b/Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml
index bf3f07421f7e..0551a0d1b3df 100644
--- a/Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml
+++ b/Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml
@@ -8,8 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: SiFive Composable Cache Controller
 
 maintainers:
-  - Sagar Kadam <sagar.kadam@sifive.com>
-  - Paul Walmsley  <paul.walmsley@sifive.com>
+  - Paul Walmsley <paul.walmsley@sifive.com>
 
 description:
   The SiFive Composable Cache Controller is used to provide access to fast copies
-- 
2.39.1

