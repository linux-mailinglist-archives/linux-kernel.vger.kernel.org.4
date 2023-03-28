Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A857A6CC067
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjC1NP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjC1NO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:14:59 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694229EEE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:14:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A0C5342618;
        Tue, 28 Mar 2023 13:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1680009289; bh=gX0+H+/vQnX55PjESjX+h3IDdrFj6hdhmYLUgpV640g=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=CDaowcFqsiAHyGEhPsbxr7OuQYRTLgtKACQB7/AjXoOgFZkOtXxgmGujiKwi3KEBZ
         /QPaSokrhFGS8cRQByxBPb1qSGfOV9vw7yeRuM2Gx1bx3+jnIPvOfAgYivfWeCGngB
         7WGDrxy7FB3bKG+RqTWxOpUqLUk2yEbKfsqq87BmM1KUdmHOwmGt41vixuFBs+owB1
         Uh279Y4CPTdWxGKhIegnpxVZm3VZQZvSc0xTvt/Jx+LrcsoTesadclhPPR/Ct2tFOY
         MYkVfw7K1cOWId4JGXrOy66gRwTMzoo6+T9084e95YnZ9B7J4PM3p3GkclKkq8sFsE
         zoUGEHTY0C9/g==
From:   Hector Martin <marcan@marcan.st>
Date:   Tue, 28 Mar 2023 22:14:17 +0900
Subject: [PATCH 4/5] mailbox: apple: Delete driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-soc-mailbox-v1-4-3953814532fd@marcan.st>
References: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st>
In-Reply-To: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Janne Grunau <j@jannau.net>
Cc:     linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=16535; i=marcan@marcan.st;
 h=from:subject:message-id; bh=gX0+H+/vQnX55PjESjX+h3IDdrFj6hdhmYLUgpV640g=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhhSlF9ZPzf+UV+fcKU1XW9eWVrhL7uieD6rzsy+d/fD3Q
 6PZ5HLnjlIWBjEOBlkxRZbGE72nuj2nn1NXTZkOM4eVCWQIAxenAEzkVj7DX3HFr88WhPtqa6xu
 WHBF4+RDwQfLP/DUnvSsTTfasPW+tQIjw7oNxYHnjM9O+iH/J8d3QgDDjk9Ff7Wmn+vWeCCzPva
 kCBsA
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is now orphaned and superseded by
drivers/soc/apple/mailbox.c.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 MAINTAINERS                     |   2 -
 drivers/mailbox/Kconfig         |  12 --
 drivers/mailbox/Makefile        |   2 -
 drivers/mailbox/apple-mailbox.c | 441 ----------------------------------------
 include/linux/apple-mailbox.h   |  19 --
 5 files changed, 476 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..c115e0ad41da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1966,7 +1966,6 @@ F:	drivers/i2c/busses/i2c-pasemi-platform.c
 F:	drivers/iommu/apple-dart.c
 F:	drivers/iommu/io-pgtable-dart.c
 F:	drivers/irqchip/irq-apple-aic.c
-F:	drivers/mailbox/apple-mailbox.c
 F:	drivers/nvme/host/apple.c
 F:	drivers/nvmem/apple-efuses.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
@@ -1974,7 +1973,6 @@ F:	drivers/soc/apple/*
 F:	drivers/watchdog/apple_wdt.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
 F:	include/dt-bindings/pinctrl/apple.h
-F:	include/linux/apple-mailbox.h
 F:	include/linux/soc/apple/*
 
 ARM/APPLE MACHINE SOUND DRIVERS
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 1495965bc394..73952108cc52 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -8,18 +8,6 @@ menuconfig MAILBOX
 
 if MAILBOX
 
-config APPLE_MAILBOX
-	tristate "Apple Mailbox driver"
-	depends on ARCH_APPLE || (ARM64 && COMPILE_TEST)
-	default ARCH_APPLE
-	help
-	  Apple SoCs have various co-processors required for certain
-	  peripherals to work (NVMe, display controller, etc.). This
-	  driver adds support for the mailbox controller used to
-	  communicate with those.
-
-	  Say Y here if you have a Apple SoC.
-
 config ARM_MHU
 	tristate "ARM MHU Mailbox"
 	depends on ARM_AMBA
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index fc9376117111..18793e6caa2f 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -60,5 +60,3 @@ obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
 obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
 
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
-
-obj-$(CONFIG_APPLE_MAILBOX)	+= apple-mailbox.o
diff --git a/drivers/mailbox/apple-mailbox.c b/drivers/mailbox/apple-mailbox.c
deleted file mode 100644
index 2a3e8d8ff8b5..000000000000
--- a/drivers/mailbox/apple-mailbox.c
+++ /dev/null
@@ -1,441 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only OR MIT
-/*
- * Apple mailbox driver
- *
- * Copyright (C) 2021 The Asahi Linux Contributors
- *
- * This driver adds support for two mailbox variants (called ASC and M3 by
- * Apple) found in Apple SoCs such as the M1. It consists of two FIFOs used to
- * exchange 64+32 bit messages between the main CPU and a co-processor.
- * Various coprocessors implement different IPC protocols based on these simple
- * messages and shared memory buffers.
- *
- * Both the main CPU and the co-processor see the same set of registers but
- * the first FIFO (A2I) is always used to transfer messages from the application
- * processor (us) to the I/O processor and the second one (I2A) for the
- * other direction.
- */
-
-#include <linux/apple-mailbox.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/gfp.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/mailbox_controller.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/spinlock.h>
-#include <linux/types.h>
-
-#define APPLE_ASC_MBOX_CONTROL_FULL  BIT(16)
-#define APPLE_ASC_MBOX_CONTROL_EMPTY BIT(17)
-
-#define APPLE_ASC_MBOX_A2I_CONTROL 0x110
-#define APPLE_ASC_MBOX_A2I_SEND0   0x800
-#define APPLE_ASC_MBOX_A2I_SEND1   0x808
-#define APPLE_ASC_MBOX_A2I_RECV0   0x810
-#define APPLE_ASC_MBOX_A2I_RECV1   0x818
-
-#define APPLE_ASC_MBOX_I2A_CONTROL 0x114
-#define APPLE_ASC_MBOX_I2A_SEND0   0x820
-#define APPLE_ASC_MBOX_I2A_SEND1   0x828
-#define APPLE_ASC_MBOX_I2A_RECV0   0x830
-#define APPLE_ASC_MBOX_I2A_RECV1   0x838
-
-#define APPLE_M3_MBOX_CONTROL_FULL  BIT(16)
-#define APPLE_M3_MBOX_CONTROL_EMPTY BIT(17)
-
-#define APPLE_M3_MBOX_A2I_CONTROL 0x50
-#define APPLE_M3_MBOX_A2I_SEND0	  0x60
-#define APPLE_M3_MBOX_A2I_SEND1	  0x68
-#define APPLE_M3_MBOX_A2I_RECV0	  0x70
-#define APPLE_M3_MBOX_A2I_RECV1	  0x78
-
-#define APPLE_M3_MBOX_I2A_CONTROL 0x80
-#define APPLE_M3_MBOX_I2A_SEND0	  0x90
-#define APPLE_M3_MBOX_I2A_SEND1	  0x98
-#define APPLE_M3_MBOX_I2A_RECV0	  0xa0
-#define APPLE_M3_MBOX_I2A_RECV1	  0xa8
-
-#define APPLE_M3_MBOX_IRQ_ENABLE	0x48
-#define APPLE_M3_MBOX_IRQ_ACK		0x4c
-#define APPLE_M3_MBOX_IRQ_A2I_EMPTY	BIT(0)
-#define APPLE_M3_MBOX_IRQ_A2I_NOT_EMPTY BIT(1)
-#define APPLE_M3_MBOX_IRQ_I2A_EMPTY	BIT(2)
-#define APPLE_M3_MBOX_IRQ_I2A_NOT_EMPTY BIT(3)
-
-#define APPLE_MBOX_MSG1_OUTCNT GENMASK(56, 52)
-#define APPLE_MBOX_MSG1_INCNT  GENMASK(51, 48)
-#define APPLE_MBOX_MSG1_OUTPTR GENMASK(47, 44)
-#define APPLE_MBOX_MSG1_INPTR  GENMASK(43, 40)
-#define APPLE_MBOX_MSG1_MSG    GENMASK(31, 0)
-
-struct apple_mbox_hw {
-	unsigned int control_full;
-	unsigned int control_empty;
-
-	unsigned int a2i_control;
-	unsigned int a2i_send0;
-	unsigned int a2i_send1;
-
-	unsigned int i2a_control;
-	unsigned int i2a_recv0;
-	unsigned int i2a_recv1;
-
-	bool has_irq_controls;
-	unsigned int irq_enable;
-	unsigned int irq_ack;
-	unsigned int irq_bit_recv_not_empty;
-	unsigned int irq_bit_send_empty;
-};
-
-struct apple_mbox {
-	void __iomem *regs;
-	const struct apple_mbox_hw *hw;
-
-	int irq_recv_not_empty;
-	int irq_send_empty;
-
-	struct mbox_chan chan;
-
-	struct device *dev;
-	struct mbox_controller controller;
-	spinlock_t rx_lock;
-};
-
-static const struct of_device_id apple_mbox_of_match[];
-
-static bool apple_mbox_hw_can_send(struct apple_mbox *apple_mbox)
-{
-	u32 mbox_ctrl =
-		readl_relaxed(apple_mbox->regs + apple_mbox->hw->a2i_control);
-
-	return !(mbox_ctrl & apple_mbox->hw->control_full);
-}
-
-static bool apple_mbox_hw_send_empty(struct apple_mbox *apple_mbox)
-{
-	u32 mbox_ctrl =
-		readl_relaxed(apple_mbox->regs + apple_mbox->hw->a2i_control);
-
-	return mbox_ctrl & apple_mbox->hw->control_empty;
-}
-
-static int apple_mbox_hw_send(struct apple_mbox *apple_mbox,
-			      struct apple_mbox_msg *msg)
-{
-	if (!apple_mbox_hw_can_send(apple_mbox))
-		return -EBUSY;
-
-	dev_dbg(apple_mbox->dev, "> TX %016llx %08x\n", msg->msg0, msg->msg1);
-
-	writeq_relaxed(msg->msg0, apple_mbox->regs + apple_mbox->hw->a2i_send0);
-	writeq_relaxed(FIELD_PREP(APPLE_MBOX_MSG1_MSG, msg->msg1),
-		       apple_mbox->regs + apple_mbox->hw->a2i_send1);
-
-	return 0;
-}
-
-static bool apple_mbox_hw_can_recv(struct apple_mbox *apple_mbox)
-{
-	u32 mbox_ctrl =
-		readl_relaxed(apple_mbox->regs + apple_mbox->hw->i2a_control);
-
-	return !(mbox_ctrl & apple_mbox->hw->control_empty);
-}
-
-static int apple_mbox_hw_recv(struct apple_mbox *apple_mbox,
-			      struct apple_mbox_msg *msg)
-{
-	if (!apple_mbox_hw_can_recv(apple_mbox))
-		return -ENOMSG;
-
-	msg->msg0 = readq_relaxed(apple_mbox->regs + apple_mbox->hw->i2a_recv0);
-	msg->msg1 = FIELD_GET(
-		APPLE_MBOX_MSG1_MSG,
-		readq_relaxed(apple_mbox->regs + apple_mbox->hw->i2a_recv1));
-
-	dev_dbg(apple_mbox->dev, "< RX %016llx %08x\n", msg->msg0, msg->msg1);
-
-	return 0;
-}
-
-static int apple_mbox_chan_send_data(struct mbox_chan *chan, void *data)
-{
-	struct apple_mbox *apple_mbox = chan->con_priv;
-	struct apple_mbox_msg *msg = data;
-	int ret;
-
-	ret = apple_mbox_hw_send(apple_mbox, msg);
-	if (ret)
-		return ret;
-
-	/*
-	 * The interrupt is level triggered and will keep firing as long as the
-	 * FIFO is empty. It will also keep firing if the FIFO was empty
-	 * at any point in the past until it has been acknowledged at the
-	 * mailbox level. By acknowledging it here we can ensure that we will
-	 * only get the interrupt once the FIFO has been cleared again.
-	 * If the FIFO is already empty before the ack it will fire again
-	 * immediately after the ack.
-	 */
-	if (apple_mbox->hw->has_irq_controls) {
-		writel_relaxed(apple_mbox->hw->irq_bit_send_empty,
-			       apple_mbox->regs + apple_mbox->hw->irq_ack);
-	}
-	enable_irq(apple_mbox->irq_send_empty);
-
-	return 0;
-}
-
-static irqreturn_t apple_mbox_send_empty_irq(int irq, void *data)
-{
-	struct apple_mbox *apple_mbox = data;
-
-	/*
-	 * We don't need to acknowledge the interrupt at the mailbox level
-	 * here even if supported by the hardware. It will keep firing but that
-	 * doesn't matter since it's disabled at the main interrupt controller.
-	 * apple_mbox_chan_send_data will acknowledge it before enabling
-	 * it at the main controller again.
-	 */
-	disable_irq_nosync(apple_mbox->irq_send_empty);
-	mbox_chan_txdone(&apple_mbox->chan, 0);
-	return IRQ_HANDLED;
-}
-
-static int apple_mbox_poll(struct apple_mbox *apple_mbox)
-{
-	struct apple_mbox_msg msg;
-	int ret = 0;
-
-	while (apple_mbox_hw_recv(apple_mbox, &msg) == 0) {
-		mbox_chan_received_data(&apple_mbox->chan, (void *)&msg);
-		ret++;
-	}
-
-	/*
-	 * The interrupt will keep firing even if there are no more messages
-	 * unless we also acknowledge it at the mailbox level here.
-	 * There's no race if a message comes in between the check in the while
-	 * loop above and the ack below: If a new messages arrives inbetween
-	 * those two the interrupt will just fire again immediately after the
-	 * ack since it's level triggered.
-	 */
-	if (apple_mbox->hw->has_irq_controls) {
-		writel_relaxed(apple_mbox->hw->irq_bit_recv_not_empty,
-			       apple_mbox->regs + apple_mbox->hw->irq_ack);
-	}
-
-	return ret;
-}
-
-static irqreturn_t apple_mbox_recv_irq(int irq, void *data)
-{
-	struct apple_mbox *apple_mbox = data;
-
-	spin_lock(&apple_mbox->rx_lock);
-	apple_mbox_poll(apple_mbox);
-	spin_unlock(&apple_mbox->rx_lock);
-
-	return IRQ_HANDLED;
-}
-
-static bool apple_mbox_chan_peek_data(struct mbox_chan *chan)
-{
-	struct apple_mbox *apple_mbox = chan->con_priv;
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&apple_mbox->rx_lock, flags);
-	ret = apple_mbox_poll(apple_mbox);
-	spin_unlock_irqrestore(&apple_mbox->rx_lock, flags);
-
-	return ret > 0;
-}
-
-static int apple_mbox_chan_flush(struct mbox_chan *chan, unsigned long timeout)
-{
-	struct apple_mbox *apple_mbox = chan->con_priv;
-	unsigned long deadline = jiffies + msecs_to_jiffies(timeout);
-
-	while (time_before(jiffies, deadline)) {
-		if (apple_mbox_hw_send_empty(apple_mbox)) {
-			mbox_chan_txdone(&apple_mbox->chan, 0);
-			return 0;
-		}
-
-		udelay(1);
-	}
-
-	return -ETIME;
-}
-
-static int apple_mbox_chan_startup(struct mbox_chan *chan)
-{
-	struct apple_mbox *apple_mbox = chan->con_priv;
-
-	/*
-	 * Only some variants of this mailbox HW provide interrupt control
-	 * at the mailbox level. We therefore need to handle enabling/disabling
-	 * interrupts at the main interrupt controller anyway for hardware that
-	 * doesn't. Just always keep the interrupts we care about enabled at
-	 * the mailbox level so that both hardware revisions behave almost
-	 * the same.
-	 */
-	if (apple_mbox->hw->has_irq_controls) {
-		writel_relaxed(apple_mbox->hw->irq_bit_recv_not_empty |
-				       apple_mbox->hw->irq_bit_send_empty,
-			       apple_mbox->regs + apple_mbox->hw->irq_enable);
-	}
-
-	enable_irq(apple_mbox->irq_recv_not_empty);
-	return 0;
-}
-
-static void apple_mbox_chan_shutdown(struct mbox_chan *chan)
-{
-	struct apple_mbox *apple_mbox = chan->con_priv;
-
-	disable_irq(apple_mbox->irq_recv_not_empty);
-}
-
-static const struct mbox_chan_ops apple_mbox_ops = {
-	.send_data = apple_mbox_chan_send_data,
-	.peek_data = apple_mbox_chan_peek_data,
-	.flush = apple_mbox_chan_flush,
-	.startup = apple_mbox_chan_startup,
-	.shutdown = apple_mbox_chan_shutdown,
-};
-
-static struct mbox_chan *apple_mbox_of_xlate(struct mbox_controller *mbox,
-					     const struct of_phandle_args *args)
-{
-	if (args->args_count != 0)
-		return ERR_PTR(-EINVAL);
-
-	return &mbox->chans[0];
-}
-
-static int apple_mbox_probe(struct platform_device *pdev)
-{
-	int ret;
-	const struct of_device_id *match;
-	char *irqname;
-	struct apple_mbox *mbox;
-	struct device *dev = &pdev->dev;
-
-	match = of_match_node(apple_mbox_of_match, pdev->dev.of_node);
-	if (!match)
-		return -EINVAL;
-	if (!match->data)
-		return -EINVAL;
-
-	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
-	if (!mbox)
-		return -ENOMEM;
-	platform_set_drvdata(pdev, mbox);
-
-	mbox->dev = dev;
-	mbox->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(mbox->regs))
-		return PTR_ERR(mbox->regs);
-
-	mbox->hw = match->data;
-	mbox->irq_recv_not_empty =
-		platform_get_irq_byname(pdev, "recv-not-empty");
-	if (mbox->irq_recv_not_empty < 0)
-		return -ENODEV;
-
-	mbox->irq_send_empty = platform_get_irq_byname(pdev, "send-empty");
-	if (mbox->irq_send_empty < 0)
-		return -ENODEV;
-
-	mbox->controller.dev = mbox->dev;
-	mbox->controller.num_chans = 1;
-	mbox->controller.chans = &mbox->chan;
-	mbox->controller.ops = &apple_mbox_ops;
-	mbox->controller.txdone_irq = true;
-	mbox->controller.of_xlate = apple_mbox_of_xlate;
-	mbox->chan.con_priv = mbox;
-	spin_lock_init(&mbox->rx_lock);
-
-	irqname = devm_kasprintf(dev, GFP_KERNEL, "%s-recv", dev_name(dev));
-	if (!irqname)
-		return -ENOMEM;
-
-	ret = devm_request_threaded_irq(dev, mbox->irq_recv_not_empty, NULL,
-					apple_mbox_recv_irq,
-					IRQF_NO_AUTOEN | IRQF_ONESHOT, irqname,
-					mbox);
-	if (ret)
-		return ret;
-
-	irqname = devm_kasprintf(dev, GFP_KERNEL, "%s-send", dev_name(dev));
-	if (!irqname)
-		return -ENOMEM;
-
-	ret = devm_request_irq(dev, mbox->irq_send_empty,
-			       apple_mbox_send_empty_irq, IRQF_NO_AUTOEN,
-			       irqname, mbox);
-	if (ret)
-		return ret;
-
-	return devm_mbox_controller_register(dev, &mbox->controller);
-}
-
-static const struct apple_mbox_hw apple_mbox_asc_hw = {
-	.control_full = APPLE_ASC_MBOX_CONTROL_FULL,
-	.control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
-
-	.a2i_control = APPLE_ASC_MBOX_A2I_CONTROL,
-	.a2i_send0 = APPLE_ASC_MBOX_A2I_SEND0,
-	.a2i_send1 = APPLE_ASC_MBOX_A2I_SEND1,
-
-	.i2a_control = APPLE_ASC_MBOX_I2A_CONTROL,
-	.i2a_recv0 = APPLE_ASC_MBOX_I2A_RECV0,
-	.i2a_recv1 = APPLE_ASC_MBOX_I2A_RECV1,
-
-	.has_irq_controls = false,
-};
-
-static const struct apple_mbox_hw apple_mbox_m3_hw = {
-	.control_full = APPLE_M3_MBOX_CONTROL_FULL,
-	.control_empty = APPLE_M3_MBOX_CONTROL_EMPTY,
-
-	.a2i_control = APPLE_M3_MBOX_A2I_CONTROL,
-	.a2i_send0 = APPLE_M3_MBOX_A2I_SEND0,
-	.a2i_send1 = APPLE_M3_MBOX_A2I_SEND1,
-
-	.i2a_control = APPLE_M3_MBOX_I2A_CONTROL,
-	.i2a_recv0 = APPLE_M3_MBOX_I2A_RECV0,
-	.i2a_recv1 = APPLE_M3_MBOX_I2A_RECV1,
-
-	.has_irq_controls = true,
-	.irq_enable = APPLE_M3_MBOX_IRQ_ENABLE,
-	.irq_ack = APPLE_M3_MBOX_IRQ_ACK,
-	.irq_bit_recv_not_empty = APPLE_M3_MBOX_IRQ_I2A_NOT_EMPTY,
-	.irq_bit_send_empty = APPLE_M3_MBOX_IRQ_A2I_EMPTY,
-};
-
-static const struct of_device_id apple_mbox_of_match[] = {
-	{ .compatible = "apple,asc-mailbox-v4", .data = &apple_mbox_asc_hw },
-	{ .compatible = "apple,m3-mailbox-v2", .data = &apple_mbox_m3_hw },
-	{}
-};
-MODULE_DEVICE_TABLE(of, apple_mbox_of_match);
-
-static struct platform_driver apple_mbox_driver = {
-	.driver = {
-		.name = "apple-mailbox",
-		.of_match_table = apple_mbox_of_match,
-	},
-	.probe = apple_mbox_probe,
-};
-module_platform_driver(apple_mbox_driver);
-
-MODULE_LICENSE("Dual MIT/GPL");
-MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
-MODULE_DESCRIPTION("Apple Mailbox driver");
diff --git a/include/linux/apple-mailbox.h b/include/linux/apple-mailbox.h
deleted file mode 100644
index 720fbb70294a..000000000000
--- a/include/linux/apple-mailbox.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
-/*
- * Apple mailbox message format
- *
- * Copyright (C) 2021 The Asahi Linux Contributors
- */
-
-#ifndef _LINUX_APPLE_MAILBOX_H_
-#define _LINUX_APPLE_MAILBOX_H_
-
-#include <linux/types.h>
-
-/* encodes a single 96bit message sent over the single channel */
-struct apple_mbox_msg {
-	u64 msg0;
-	u32 msg1;
-};
-
-#endif

-- 
2.40.0

