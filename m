Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29996FDE7E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbjEJN1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjEJN1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:27:50 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E33561B2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:27:30 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:cc75:d8ef:4074:8af9])
        by andre.telenet-ops.be with bizsmtp
        id v1TS2900R3l7qvk011TSVa; Wed, 10 May 2023 15:27:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pwjqg-001nF6-HV;
        Wed, 10 May 2023 15:27:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pwjqo-00F6wY-8K;
        Wed, 10 May 2023 15:27:26 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: timer: sifive,clint: Clean up compatible value section
Date:   Wed, 10 May 2023 15:27:24 +0200
Message-Id: <40ff1fc7f5220db7d527c57ac4bad16c3945ae08.1683725179.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the sentences in the description listing some supported variants
by comments on the individual compatible values, to ease future
maintenance.  While at it, restore alphabetical sort order.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../bindings/timer/sifive,clint.yaml          | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index 94bef9424df1bc6a..34a81510678134eb 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -29,11 +29,11 @@ properties:
     oneOf:
       - items:
           - enum:
-              - sifive,fu540-c000-clint
-              - starfive,jh7100-clint
-              - starfive,jh7110-clint
-              - canaan,k210-clint
-          - const: sifive,clint0
+              - canaan,k210-clint       # Canaan Kendryte K210
+              - sifive,fu540-c000-clint # SiFive FU540
+              - starfive,jh7100-clint   # StarFive JH7100
+              - starfive,jh7110-clint   # StarFive JH7110
+          - const: sifive,clint0        # SiFive CLINT v0 IP block
       - items:
           - enum:
               - allwinner,sun20i-d1-clint
@@ -45,14 +45,9 @@ properties:
         description: For the QEMU virt machine only
 
     description:
-      Should be "<vendor>,<chip>-clint" and "sifive,clint<version>".
-      Supported compatible strings are -
-      "sifive,fu540-c000-clint" for the SiFive CLINT v0 as integrated
-      onto the SiFive FU540 chip, "canaan,k210-clint" for the SiFive
-      CLINT v0 as integrated onto the Canaan Kendryte K210 chip, and
-      "sifive,clint0" for the SiFive CLINT v0 IP block with no chip
-      integration tweaks.
-      Please refer to sifive-blocks-ip-versioning.txt for details
+      Should be "<vendor>,<chip>-clint", followed by "sifive,clint<version>"
+      when compatible with a SiFive CLINT.  Please refer to
+      sifive-blocks-ip-versioning.txt for details regarding the latter.
 
   reg:
     maxItems: 1
-- 
2.34.1

