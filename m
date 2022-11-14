Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FEB627461
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiKNB6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiKNB57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:57:59 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0ECB86F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 17:57:58 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id ACDC8320091A;
        Sun, 13 Nov 2022 20:57:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 13 Nov 2022 20:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668391077; x=1668477477; bh=zX
        +HYuy4GvidniLAd+lpqew4/s4ii686Qj3H9Jd2qG0=; b=rXsRbMYFTaUdR2U+Mk
        VNvxUrkjZXlEk44QuPfO3v95apqzkYDbTcuAIKi3cFSmP1R5I36syDaXMzUiRXV5
        ZUG23SwDwoYqTOgIQt7vg0VHxW/GFVMDFVeoQSX5WU3iAAln+nsR8Q5Bni10xOaX
        B9M+OAK5vMjbNdi7pRHiBVwVvw7y1j0WyajuPvNXe7Zz4PPjTQEaLOnmvpLChWLW
        5Qk/M3W2QI0t99TuVFL04WYT5ysYIs4q5r/B1QuF3lVUzgOjhm3yJoFDmy1aepYi
        jVupkZ6508nbFlesKkfDqFbbhzMzUE3O6HnCuo3dGPf7m1foGPbVFgxwxm4j0ana
        TIqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668391077; x=1668477477; bh=zX+HYuy4Gvidn
        iLAd+lpqew4/s4ii686Qj3H9Jd2qG0=; b=MH1Dg8+TQL2ERs5dtT00JLdXcQfB6
        c2fJd7iyyNYKiV/keuHUtO6s2q1mAAs6HS9VQfpUKkBh/fzKgWvN3c3XMfGqpLoX
        IQqwXXVRlCKH08XEQswZG0lmo8pkgPjSYIa6qxzlanDSmxgWxSE1bVCDRvj0Ya/j
        NCtIEjGEjLozLrclr0QJIcrAPF9XoQjw+Z3YTnPiOmjimezhLNMWUalzf7c1jF/o
        G6jTQOKLHpk2TEMvbpSxskt+xPzUJbh5Ri0sfmfdMOmUSGyTQlbqSloJo1lL7MQ/
        l6OFLXUZTm1jtwlWJwRzZFyvTgu19aeGBsM+ciohTPYAFEQrIpP6ClF1w==
X-ME-Sender: <xms:paBxYwzFzBpsmYA5G3d8_mdiQ5Rp9N1A74OMDdOLtxX2cusov1IEVg>
    <xme:paBxY0TKPrle0i3DLAcjyf1VGiLiHt35tyo2Um1x6kqNg_9GMxe9xBVnf_JurIhif
    7kPPvORqZA3yDjkTw>
X-ME-Received: <xmr:paBxYyWPha9XnSmkJHXJgmw8GvDXF4tA3lpT_I5y-SEppvRyT7eYInOX2cZMbcUc9DLpECB1gvTLoqm_9vwwTtkU62ndZoffwBNkZNItBoWvlc9vfIwACuyL1_zDBb99ynqm1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:paBxY-iceAsZOzFz5ixstXpEwbG4H_4jWxADGwbtl8vDPr-SVoN3Uw>
    <xmx:paBxYyADd1F0DtuiYWLGr2rwjJGyNPRYnuh22E9bD4PjxR-wULLfcg>
    <xmx:paBxY_Kw4b4jj1WmI9RqoFrFSJo-ShX6XSAnMUIC-H5VWiDohh1dNQ>
    <xmx:paBxY02FZdzNDgWMItFs0hdh2CaUWFJYHKbI7YmymrC5UaWFapnLFA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 20:57:56 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 3/3] bus: sunxi-rsb: Clear interrupt status before each transfer
Date:   Sun, 13 Nov 2022 19:57:49 -0600
Message-Id: <20221114015749.28490-4-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221114015749.28490-1-samuel@sholland.org>
References: <20221114015749.28490-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the driver clears the interrupt status bits after anything
could have set them. However, this requires duplicating the same logic
in several places.

Instead of clearing the status flags in the interrupt handler, disable
all further interrupts by clearing the RSB_CTRL_GLOBAL_INT_ENB bit.
Then we can delay the status register write until the start of the next
transfer, so it only has to be done in one place.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Add a patch refactoring how the status bits are cleared

 drivers/bus/sunxi-rsb.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 3aa91aed3bf7..cb622e60897b 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -279,6 +279,7 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
 
 	int_mask = RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER;
 	writel(int_mask, rsb->regs + RSB_INTE);
+	writel(int_mask, rsb->regs + RSB_INTS);
 	writel(RSB_CTRL_START_TRANS | RSB_CTRL_GLOBAL_INT_ENB,
 	       rsb->regs + RSB_CTRL);
 
@@ -286,7 +287,6 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
 		timeout = readl_poll_timeout_atomic(rsb->regs + RSB_INTS,
 						    status, (status & int_mask),
 						    10, 100000);
-		writel(status, rsb->regs + RSB_INTS);
 	} else {
 		timeout = !wait_for_completion_io_timeout(&rsb->complete,
 							  msecs_to_jiffies(100));
@@ -296,12 +296,9 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
 	if (timeout) {
 		dev_dbg(rsb->dev, "RSB timeout\n");
 
-		/* abort the transfer */
+		/* abort the transfer and disable interrupts */
 		writel(RSB_CTRL_ABORT_TRANS, rsb->regs + RSB_CTRL);
 
-		/* clear any interrupt flags */
-		writel(readl(rsb->regs + RSB_INTS), rsb->regs + RSB_INTS);
-
 		return -ETIMEDOUT;
 	}
 
@@ -503,15 +500,11 @@ EXPORT_SYMBOL_GPL(__devm_regmap_init_sunxi_rsb);
 static irqreturn_t sunxi_rsb_irq(int irq, void *dev_id)
 {
 	struct sunxi_rsb *rsb = dev_id;
-	u32 status;
 
-	status = readl(rsb->regs + RSB_INTS);
-	rsb->status = status;
+	/* disable interrupts */
+	writel(0, rsb->regs + RSB_CTRL);
 
-	/* Clear interrupts */
-	status &= (RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR |
-		   RSB_INTS_TRANS_OVER);
-	writel(status, rsb->regs + RSB_INTS);
+	rsb->status = readl(rsb->regs + RSB_INTS);
 
 	complete(&rsb->complete);
 
@@ -532,9 +525,6 @@ static int sunxi_rsb_init_device_mode(struct sunxi_rsb *rsb)
 	if (reg & RSB_DMCR_DEVICE_START)
 		ret = -ETIMEDOUT;
 
-	/* clear interrupt status bits */
-	writel(readl(rsb->regs + RSB_INTS), rsb->regs + RSB_INTS);
-
 	return ret;
 }
 
-- 
2.37.3

