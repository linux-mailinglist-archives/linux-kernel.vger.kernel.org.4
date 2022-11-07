Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FD961EA62
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 06:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiKGFWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 00:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiKGFWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 00:22:09 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06BBB4AD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 21:22:05 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2BDB75C00F1;
        Mon,  7 Nov 2022 00:22:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 07 Nov 2022 00:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1667798525; x=1667884925; bh=gy
        BTq0Ma+GLkWBSiLTWQDQZqxoZ0z5X/rfo9ICAimTw=; b=XyxbUEkpXnskgkAOAR
        behrCDtU7Ew7aMxM2Kp2Mglueji47RiwJrlzAGNi5w9qeIRRl7qMpYrF7n2SiZmx
        9FF1/37mgac7NXvl3ytu409Z9+m0xTi4tAZ9M0bjNZMZRvMxaMscffBLP+7K0nu/
        quw0b/Q33zHzOG2h7PYg+OidbtF8Igy1gWpXuXTdxWkREgXOClxNK0MZHix4kk5i
        Vz45S1KZjeWXdVpQnx9Y8ACymyT6FFldCkIZunlR21zahuQDhpRKM0YODD6tUBjy
        5oUE1i24Jrn5/F+TGhr5EfXB0KzwREA1hrLFcbjjq0yjUnPOekHVgUIPeTbBPFSx
        De2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667798525; x=1667884925; bh=gyBTq0Ma+GLkW
        BSiLTWQDQZqxoZ0z5X/rfo9ICAimTw=; b=D5VXd4bh7p2i046046Vm1vikWqeDc
        ZG/RyLXHdQLAz0Zex1DPoIkbuHmh+MMznDKd1fg4pI950jEzH6U6I6z60xnvaR+V
        lWxhL0HTwZcyHBY26iS6fgU4kj3OxwzOrajcJZaB9U0rxKyf6IL87xIb1dj5bQrX
        iyRtV9D4BFNWlStOuRsLYMVuGyZ3+Du60aEXjublB5P37TeJ08IvzgoDqoW6kX2M
        US/js3eal7uZPyKdS+pgOYd7rRHp7r2iWOog01e1dikFp6g2lb99lbDEjvCsae0F
        p/2eidHX3YrDsZXJAVBZ3JoFiMVwlplu3nOieSmc5UgvJcbL4dDQF5JKQ==
X-ME-Sender: <xms:_ZVoY5gsYOTusT8NuH8VQioRrvPAkYa5sApnhDNSF0ya66cM-kVngA>
    <xme:_ZVoY-CoGdnkWH8a8ObqemK60FwoVYHqLihym4hqwBhTR6UTi_cwJiejG32rAcN94
    N1Qtlg5iQ-sjixJ7w>
X-ME-Received: <xmr:_ZVoY5F_hmOLeQtIPkXQ_xM0xG9DgF-aUTqFuHAd9c5EG3Sxzs8aDtoyEzBpS74XleJGQSrQJ73qQXBpx2PoN7e9WDekKxubvBwVKGNgUxeZWTZl0o0O3GfCFVtspreuOU-Osw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdejgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:_ZVoY-QCcNMH9-u6gJibDQDPl519dktO4AjCK1KHlBf1t9LzU6LhPw>
    <xmx:_ZVoY2zXvUfRjBGT0qI07B7wkkLQlt5b4rBtO5MJ6cO0iXX1DMs3EQ>
    <xmx:_ZVoY05d1tvwBR7CdIJsQgoAc34WC4llzkjPq1ZUdyNlXp4x-UyeLw>
    <xmx:_ZVoY9o-QfZWcx5bkE9KtlE4m5a7R6hNMkIm89ItQCQFNbvMh91N_A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 00:22:04 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 2/2] bus: sunxi-rsb: Support atomic transfers
Date:   Sun,  6 Nov 2022 23:22:00 -0600
Message-Id: <20221107052201.65477-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221107052201.65477-1-samuel@sholland.org>
References: <20221107052201.65477-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v2:
 - Add Fixes tag to patch 2
 - Only check for specific status bits when polling

 drivers/bus/sunxi-rsb.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 17343cd75338..012e82f9b7b0 100644
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
+	int_mask = RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER;
+	writel(int_mask,
 	       rsb->regs + RSB_INTE);
 	writel(RSB_CTRL_START_TRANS | RSB_CTRL_GLOBAL_INT_ENB,
 	       rsb->regs + RSB_CTRL);
 
-	if (!wait_for_completion_io_timeout(&rsb->complete,
-					    msecs_to_jiffies(100))) {
+	if (irqs_disabled()) {
+		timeout = readl_poll_timeout_atomic(rsb->regs + RSB_INTS,
+						    status, (status & int_mask),
+						    10, 100000);
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

