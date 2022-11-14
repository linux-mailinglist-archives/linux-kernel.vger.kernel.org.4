Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93176627460
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiKNB6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbiKNB57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:57:59 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79256385
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 17:57:56 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id AB4C13200918;
        Sun, 13 Nov 2022 20:57:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 13 Nov 2022 20:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668391075; x=1668477475; bh=8v
        64se4ndLgqbFDAHIerqamapO8xDSwZD3YbrOF2gwU=; b=nW/Za3EmB97fE3xQuz
        U6IjghrHUwvxKsNRYAo8tZ4gfTFvimat3kKsyL+VLjfRGPJ5zYlnB51PnMgHErdz
        Jgsdcq2Blkkn1IGrQ82ih1dfhaC3wX8rTcSjWHtrAmflQ14Al8CyaK/4PZytH8ub
        FBmKyvt74izhN6/cVv7dkRKszHISqk01Zi7jtxnpKCN5SATtcwEjjce6u+28HZFt
        Q9pbVdOKS/MaA/JD1aZpbebRw38r8Q2+hxewAkQM2X5XqSh/xEFK5b5DuJONAlJw
        CJ80JOXmUQ+u18v1BmERKTU8nryl8s1u1aOlM40aMHH6FOslFE2THipsR2BtZbA4
        fiDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668391075; x=1668477475; bh=8v64se4ndLgqb
        FDAHIerqamapO8xDSwZD3YbrOF2gwU=; b=LR4qa+zqLoevQmTaWy4UOL7sr85kK
        PxsH3h3OkgY4sJXhswK2jBoXG+CxNsvMXsSgTeccvtLW2lKqADVrSHbT5vuo6uMA
        0IMUXs8TF0t/T2ikJGGH3MDM9PnOEDUu8eEhsmkDIb2zcD5NqIebFIhOJu2hpj14
        UhI0aMo73HNIoz4IDdwM+T4IKhyceGKvKFM/Ax5PpiqPgKAkURqdZHnN+4EfnvZL
        Hn9efLrK/Xr01xHE5KuMC4k3JY/n3ebtLoQfPElN3YqdIPDjozErKP28Wlrn/KpQ
        mmRL/JEYSgyLUYAdUzrG1D9y2yPCxX6tPd0BoPR7EeyJ93dsKSlWkS49A==
X-ME-Sender: <xms:o6BxY9yQNfs2EzOC3IZ9p4L6kWu18z52qndUvFr-m0LfioU5y6zm1g>
    <xme:o6BxY9RxurC2QKArRKdFb9ABNm5Ibm30NjCxLrJ6ic-oqsqJ7dZdKqvca_fjL9b72
    akiIp85oA07gvK07Q>
X-ME-Received: <xmr:o6BxY3VHd4C-8sQ0yYFf8HLzriipszAPETtwKigy212pBJ1pt9Bh2PZZzrE_yQ0vh3VuY3xOpAUMTQ8-zeULwwmuE1qMhWHK2QR_K6_M6u_SZsNM7oGex5uAVAfXaQZnVjhKLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:o6BxY_j2u3d-8bYhb9t_n2-k559bjH-2DNHwgWkLds4uaFfVbn4xmw>
    <xmx:o6BxY_C7ztMptmHjDvCL7JL3sWlYyDjGsFtuN821wKhU9uR3gg0oOQ>
    <xmx:o6BxY4JBBs4W3DbIrHHUn9w5z5r3ULKIdkXAKFJXS3hjuZ5L5NYvCA>
    <xmx:o6BxYx3l2AL9es6zoxifqWJe2OAIWvgiQDyO75XxyfgA0UKMvkassw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 20:57:54 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 2/3] bus: sunxi-rsb: Support atomic transfers
Date:   Sun, 13 Nov 2022 19:57:48 -0600
Message-Id: <20221114015749.28490-3-samuel@sholland.org>
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

When communicating with a PMIC during system poweroff (pm_power_off()),
IRQs are disabled and we are in a RCU read-side critical section, so we
cannot use wait_for_completion_io_timeout(). Instead, poll the status
register for transfer completion.

Fixes: d787dcdb9c8f ("bus: sunxi-rsb: Add driver for Allwinner Reduced Serial Bus")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Clear the interrupt status register after polling

Changes in v2:
 - Add Fixes tag to patch 2
 - Only check for specific status bits when polling

 drivers/bus/sunxi-rsb.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 17343cd75338..3aa91aed3bf7 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -267,6 +267,9 @@ EXPORT_SYMBOL_GPL(sunxi_rsb_driver_register);
 /* common code that starts a transfer */
 static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
 {
+	u32 int_mask, status;
+	bool timeout;
+
 	if (readl(rsb->regs + RSB_CTRL) & RSB_CTRL_START_TRANS) {
 		dev_dbg(rsb->dev, "RSB transfer still in progress\n");
 		return -EBUSY;
@@ -274,13 +277,23 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
 
 	reinit_completion(&rsb->complete);
 
-	writel(RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER,
-	       rsb->regs + RSB_INTE);
+	int_mask = RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER;
+	writel(int_mask, rsb->regs + RSB_INTE);
 	writel(RSB_CTRL_START_TRANS | RSB_CTRL_GLOBAL_INT_ENB,
 	       rsb->regs + RSB_CTRL);
 
-	if (!wait_for_completion_io_timeout(&rsb->complete,
-					    msecs_to_jiffies(100))) {
+	if (irqs_disabled()) {
+		timeout = readl_poll_timeout_atomic(rsb->regs + RSB_INTS,
+						    status, (status & int_mask),
+						    10, 100000);
+		writel(status, rsb->regs + RSB_INTS);
+	} else {
+		timeout = !wait_for_completion_io_timeout(&rsb->complete,
+							  msecs_to_jiffies(100));
+		status = rsb->status;
+	}
+
+	if (timeout) {
 		dev_dbg(rsb->dev, "RSB timeout\n");
 
 		/* abort the transfer */
@@ -292,18 +305,18 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
 		return -ETIMEDOUT;
 	}
 
-	if (rsb->status & RSB_INTS_LOAD_BSY) {
+	if (status & RSB_INTS_LOAD_BSY) {
 		dev_dbg(rsb->dev, "RSB busy\n");
 		return -EBUSY;
 	}
 
-	if (rsb->status & RSB_INTS_TRANS_ERR) {
-		if (rsb->status & RSB_INTS_TRANS_ERR_ACK) {
+	if (status & RSB_INTS_TRANS_ERR) {
+		if (status & RSB_INTS_TRANS_ERR_ACK) {
 			dev_dbg(rsb->dev, "RSB slave nack\n");
 			return -EINVAL;
 		}
 
-		if (rsb->status & RSB_INTS_TRANS_ERR_DATA) {
+		if (status & RSB_INTS_TRANS_ERR_DATA) {
 			dev_dbg(rsb->dev, "RSB transfer data error\n");
 			return -EIO;
 		}
-- 
2.37.3

