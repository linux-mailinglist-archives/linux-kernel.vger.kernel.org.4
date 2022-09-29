Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E545EF35B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiI2KVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiI2KVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:21:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311415209D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:21:03 -0700 (PDT)
Date:   Thu, 29 Sep 2022 10:21:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664446861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dsxxoZaF18dNd+r0YNsoInNXPabb5v1nGksJW2WQVrI=;
        b=wEYIibRMpTH4xj2PTqe5gUZz9Mtx1lbehy/SMAKEGMzL8jm8zed4xw4z71QVL1raausyTE
        WSF7jtVdQyab9gDYPtHsfPnB/TD0zE+h0/GCGGw3pJ4KzcJ0iqH72tqrD9q155+maAD4jM
        a8iVKUgaF8pt3s4LwB2Sg65x3J/j34M0VKuirU7aO89isPklfdlMLK2Ca0x0f4rtjSxlWo
        UWurApxZcNWLZ4N3++UktJUQBJyKIiCJY22LD1zLdNNK5Np/OBJI0twKCPymdVR4nH1da3
        r/yl11QaA6DAwD7+v1B7pygyVgb/xl6lL6Ds6FAwuZedF8lJDofClRZcbpQxUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664446861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dsxxoZaF18dNd+r0YNsoInNXPabb5v1nGksJW2WQVrI=;
        b=x72iiN1WqPa/b0uKBW1OwaclDzPtVDsimWDtZc7A+gTC4d/NVt2tERUL0f7J3pg5SJ6qQZ
        jel2EE1/bYib2FAg==
From:   "irqchip-bot for Apurva Nandan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller:
 ti,sci-intr: Fix missing reg property in the binding
Cc:     Apurva Nandan <a-nandan@ti.com>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220819190729.32358-4-a-nandan@ti.com>
References: <20220819190729.32358-4-a-nandan@ti.com>
MIME-Version: 1.0
Message-ID: <166444686053.401.11179384254910309532.tip-bot2@tip-bot2>
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

Commit-ID:     daa0b6d0187599a574cb5cb392b259bda3dcf979
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/daa0b6d0187599a574cb5cb392b259bda3dcf979
Author:        Apurva Nandan <a-nandan@ti.com>
AuthorDate:    Sat, 20 Aug 2022 00:37:29 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 29 Sep 2022 11:13:43 +01:00

dt-bindings: interrupt-controller: ti,sci-intr: Fix missing reg property in the binding

Fix the following warning in dtbs_check
interrupt-controller@a00000: Unevaluated properties are not allowed ('reg' was unexpected)

Add the reg property in the schema.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220819190729.32358-4-a-nandan@ti.com
---
 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
index e12aee4..c99cc73 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
@@ -58,6 +58,9 @@ properties:
         1 = If intr supports edge triggered interrupts.
         4 = If intr supports level triggered interrupts.
 
+  reg:
+    maxItems: 1
+
   interrupt-controller: true
 
   '#interrupt-cells':
