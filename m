Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699AD5EF359
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiI2KVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbiI2KVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:21:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77CD5A816
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:21:04 -0700 (PDT)
Date:   Thu, 29 Sep 2022 10:21:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664446863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eg9qUWovxMRvNklVZSf7DVJEZEye63LDAuHmgVfnSE8=;
        b=IZOsbzZKBPMOk0FQTBpAN2abp5TyfQAVvldORlsz3TyTsJenofmetzu2cQnnZY/Ghr0Uj2
        ldWQDETytmKi7H94FL2qiip88ewz4wzy21TbUK7lU7yQiRuc5aHDTuknx2LQU14jKIczCx
        69K/sR7vSGGGmFbup+og+wjqdyOHbzZBy5J8yzj6wHpjL8cEnJY+ZigXoJiaXKSwjMNPhb
        EFKxjwRehPcWWstrztRs+CcXd6PQkK6DR87euBe3IMOMMNGF+N9WeLHfdDp+6IYSHfUesm
        0x57g+bj22G2Xd570v6VpYwQ5xXsP86q0Ol774/7QugSXQM7w5XJEHsoh4wYlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664446863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eg9qUWovxMRvNklVZSf7DVJEZEye63LDAuHmgVfnSE8=;
        b=5smwON3SDVNjgwWj3/V409HjQMWArjm64uX0IglRQPl2FPCxy7A04b7QAbz6q2afVQ8d0N
        9QUNZgwi0k/ZnlDg==
From:   "irqchip-bot for Apurva Nandan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: irqchip: ti,sci-inta: Fix
 warning for missing #interrupt-cells
Cc:     Apurva Nandan <a-nandan@ti.com>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220819190729.32358-2-a-nandan@ti.com>
References: <20220819190729.32358-2-a-nandan@ti.com>
MIME-Version: 1.0
Message-ID: <166444686163.401.18116811923959898803.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     d9fc272bfd76acadf0537901549d07a1b81dbeed
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d9fc272bfd76acadf0537901549d07a1b81dbeed
Author:        Apurva Nandan <a-nandan@ti.com>
AuthorDate:    Sat, 20 Aug 2022 00:37:27 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 29 Sep 2022 11:10:10 +01:00

dt-bindings: irqchip: ti,sci-inta: Fix warning for missing #interrupt-cells

ti,sci-inta nodes, or else we will have following warning when building
device tree files with W=2 warning level.

arch/arm64/boot/dts/ti/k3-j721e-main.dtsi:147.51-156.5: Warning (interrupt_provider): /bus@100000/main-navss/interrupt-controller@33d00000: Missing #interrupt-cells in interrupt provider

And further, #interrupt-cells is required to be in yaml bindings as well
to prevent following schema warnings:

k3-j721e-common-proc-board.dtb: interrupt-controller@33d00000: Unevaluated properties are not allowed ('#interrupt-cells' was unexpected)
>From schema: linux/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml

Add #interrupt-cells property in ti,sci-inta.yaml

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220819190729.32358-2-a-nandan@ti.com
---
 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
index 88c46e6..1151518 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
@@ -59,6 +59,9 @@ properties:
 
   interrupt-controller: true
 
+  '#interrupt-cells':
+    const: 0
+
   msi-controller: true
 
   ti,interrupt-ranges:
