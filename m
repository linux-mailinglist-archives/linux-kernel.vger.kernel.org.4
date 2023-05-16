Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D31C704A68
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjEPKWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjEPKWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:22:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F2640F5
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:22:39 -0700 (PDT)
Date:   Tue, 16 May 2023 10:22:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684232558;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4DjYR026G/RUPOr4o3268om1bIvmxLZRur6uZ5lVlo0=;
        b=vqHnr8e1rz5FR6dLyECYxHnDz10D2bPJvwka17Gbuz314l+e1A/RHKfkuhF8uYFAdQpejP
        2YTbEZGb9Q5d/5wDULLpUfIHyKL+vOLZ0zfWyd9TnRllXmjtc30nzFNVLSyri5byWu/BtU
        ev1bQ8jNric5Sf/0tNKDkpXa67iEeqRT98GH3O6U4calAlmIXYzBkQhMMJVVTLrkrczgtt
        zQmeSoZ1CN51wbTV+SPRoGKbgcq5wDbC8VQNXr+D7oXvC0z/9JH4IOjvA7Hb/qqsKP8oG3
        OxYiiQOXIyYal1eSGOUm4C39FxcYJrBiPRWq9xgCaHAUftA7sgOOlI1XPnBw5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684232558;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4DjYR026G/RUPOr4o3268om1bIvmxLZRur6uZ5lVlo0=;
        b=pafFnsyfwd6QOIClOXWzLdRijm2+TbFo4S7BZBrs96Dr9Z2jf9xJ39j7YA3/asLKQ0ajlT
        ItGDkpePivJxezBw==
From:   "irqchip-bot for Douglas Anderson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] dt-bindings: interrupt-controller:
 arm,gic-v3: Add quirk for Mediatek SoCs w/ broken FW
Cc:     Julius Werner <jwerner@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230515131353.v2.1.Iabe67a827e206496efec6beb5616d5a3b99c1e65@changeid>
References: <20230515131353.v2.1.Iabe67a827e206496efec6beb5616d5a3b99c1e65@changeid>
MIME-Version: 1.0
Message-ID: <168423255799.404.15212728549560590170.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     43cd3ddbff3c1635d0e09fe5b09af48d39dbb9d7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/43cd3ddbff3c1635d0e09fe5b09af48d39dbb9d7
Author:        Douglas Anderson <dianders@chromium.org>
AuthorDate:    Mon, 15 May 2023 13:13:50 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 16 May 2023 10:42:57 +01:00

dt-bindings: interrupt-controller: arm,gic-v3: Add quirk for Mediatek SoCs w/ broken FW

When trying to turn on the "pseudo NMI" kernel feature in Linux, it
was discovered that all Mediatek-based Chromebooks that ever shipped
(at least ones with GICv3) had a firmware bug where they wouldn't save
certain GIC "GICR" registers properly. If a processor ever entered a
suspend/idle mode where the GICR registers lost state then they'd be
reset to their default state.

As a result of the bug, if you try to enable "pseudo NMIs" on the
affected devices then certain interrupts will unexpectedly get
promoted to be "pseudo NMIs" and cause crashes / freezes / general
mayhem.

ChromeOS is looking to start turning on "pseudo NMIs" in production to
make crash reports more actionable. To do so, we will release firmware
updates for at least some of the affected Mediatek Chromebooks.
However, even when we update the firmware of a Chromebook it's always
possible that a user will end up booting with old firmware. We need to
be able to detect when we're running with firmware that will crash and
burn if pseudo NMIs are enabled.

The current plan is:
* Update the device trees of all affected Chromebooks to include the
  'mediatek,broken-save-restore-fw' property. The kernel can use this
  to know not to enable certain features like "pseudo NMI". NOTE:
  device trees for Chromebooks are never baked into the firmware but
  are bundled with the kernel. A kernel will never be configured to
  use "pseudo NMIs" and be bundled with an old device tree.
* When we get a fixed firmware for one of these Chromebooks, it will
  patch the device tree to remove this property.

For some details, you can also see the public bug
<https://issuetracker.google.com/281831288>

Reviewed-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230515131353.v2.1.Iabe67a827e206496efec6beb5616d5a3b99c1e65@changeid
---
 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index 9211726..39e64c7 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -166,6 +166,12 @@ properties:
   resets:
     maxItems: 1
 
+  mediatek,broken-save-restore-fw:
+    type: boolean
+    description:
+      Asserts that the firmware on this device has issues saving and restoring
+      GICR registers when the GIC redistributors are powered off.
+
 dependencies:
   mbi-ranges: [ msi-controller ]
   msi-controller: [ mbi-ranges ]
