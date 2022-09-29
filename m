Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010B35EF70E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbiI2OBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiI2OB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:01:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744B912E43D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:01:27 -0700 (PDT)
Date:   Thu, 29 Sep 2022 14:01:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664460085;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NFxVNbNcm/nywU1w2htUSXtzMkl5DhBltodRETlHyaQ=;
        b=Z2BuNEaFNAjMYwx5QVj5Wp/cASN+XB965C8OgCc/WIjtqdkikpali793crJoutNPgqVm1l
        KhHQPJTGVcvhFMtm5ovmgJONWXcAcV5pIC8aBAgqyA93znPIjjD2SYN37OXAmCyiGSYq/5
        t0Wa/4tn6pORwRRxmvvwIUnfYdPDzZEhL6MF0RQBmAkS9KAI1xBzl7JA/HAFtyAOD+J9YE
        LLzISyirpLYQfVyvEDnAhelSnaXocaMlhSwASHGG3vN3sD9IX+6PqH1cShA+4yB1Nyvri1
        REw/YAxk3OJgTbe2+b/sYJz21OMMZuYlQBCRkqCcI8ZEYvefgwFAPFzmPik3Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664460085;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NFxVNbNcm/nywU1w2htUSXtzMkl5DhBltodRETlHyaQ=;
        b=+4rkBbB1t8zq91zWYcHaWuUn5rZ8C/UayvXGMFf1rL3KkD8gt0Hiy+d5pynSF87CdHLfwZ
        LVMO7cPyaiav1jAw==
From:   "irqchip-bot for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: irqchip: renesas,irqc: Add
 r8a779g0 support
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C4fdb6ff47f62814aab3b06efd1d4c2d7de83b109=2E16643?=
 =?utf-8?q?68373=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C4fdb6ff47f62814aab3b06efd1d4c2d7de83b109=2E166436?=
 =?utf-8?q?8373=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
MIME-Version: 1.0
Message-ID: <166446008385.401.915862437851961359.tip-bot2@tip-bot2>
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

Commit-ID:     872f3a4e90ef2a0245f9143558d9f45bfc352194
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/872f3a4e90ef2a0245f9143558d9f45bfc352194
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 28 Sep 2022 14:33:36 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 29 Sep 2022 14:56:22 +01:00

dt-bindings: irqchip: renesas,irqc: Add r8a779g0 support

Document support for the Interrupt Controller for External Devices
(INT-EX) in the Renesas R-Car V4H (R8A779G0) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/4fdb6ff47f62814aab3b06efd1d4c2d7de83b109.1664368373.git.geert+renesas@glider.be
---
 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
index 620f017..62fd47c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
@@ -37,6 +37,7 @@ properties:
           - renesas,intc-ex-r8a77990    # R-Car E3
           - renesas,intc-ex-r8a77995    # R-Car D3
           - renesas,intc-ex-r8a779a0    # R-Car V3U
+          - renesas,intc-ex-r8a779g0    # R-Car V4H
       - const: renesas,irqc
 
   '#interrupt-cells':
