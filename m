Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9F161DDAC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 20:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiKETUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 15:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiKETUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 15:20:01 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4030B861
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 12:20:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0DBA432005C1;
        Sat,  5 Nov 2022 15:19:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 05 Nov 2022 15:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1667675999; x=1667762399; bh=Tp
        wv+c2F2PU8VoJszCGDvaTbihLFPEmYX1Wb7G6Djbg=; b=Y6fGLWrmfRddnjem6R
        Smpi3ED14bBqTQQpAKwrbY1YIc1X1eXN+Mixmjm+zD+/1W3A9uFbkme5LH/R4H0Y
        szwKF364j/976o7TgvJ/7NE2hfh/EAOeA2+KCgulsVfIlduQH3m3wRi5LbqYwWHA
        U3vjRDtuaQWloa3Su1QwbYvw4XUERmjey58qr3/MXzmPDGIYdFuplOUSHkqYjg+y
        r7meIIgxsAvxrMPUMf75C75gIO7bi0LyCGKWMD7/zfY6gIpHbVTegZ0fIyuoHnre
        JXDz/mn/jjAUi7KFXnzw3aGjh9RMufkKJu2iahQ8RB7qC3ARp5/sSpoijHNmfmM1
        3A9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667675999; x=1667762399; bh=Tpwv+c2F2PU8V
        oJszCGDvaTbihLFPEmYX1Wb7G6Djbg=; b=otS9uMteT5hsdxH2QCGs+j+EvEdm7
        fxoCVGiYhX8SqtNwZvQB0tSx/19y+lwkI5DdxfCoV2nUwuRK3co4LyJXP7U0O8pe
        R9Zo7DsVmQYAd4OVi6Qyyr8nMTW7+GqWS9R0RkN/tOth49apiZEqcN+JDEC76CUn
        tBwtJfuioAxaUPcuWOy9KsqS+d+AM5kLmBPYOFewIka7412zeFxa6GdaYTblc9Rj
        X+XoM5xyXrX+bnig4APlQ+zPhq0INJehvoXsE3rRAikTUYBU/n6HOwhcdP+ROw+N
        cuUIXnTNqOJN288m8KNjNnGApqBGgL7fc7Nu+Ju9By8Zn6u7ZawLSDg2w==
X-ME-Sender: <xms:X7dmY5VJ_sdg_rA5T6_pCQKXOIo_pzbQQcgNlj3Kpz615fLf6Ka60g>
    <xme:X7dmY5lOs_CesuFXmBKSGBxq7nacg5w1pgSDDKUEi_wQnThicqGob-T01aMlFGOZN
    QiU7nNhUCQJTV6TbQ>
X-ME-Received: <xmr:X7dmY1ZFYq9StrbDlawAmuxpOv8SocaoHXLQEHMaBwEbsR43pt7Ercu8DJRIfVkJ16LhOoGGCo9GIo28pCllSBLdHK5WTUy8vPdvZKIML_FvUijyTmYrcRGV9wfu7fIw0yAb1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdeggddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:X7dmY8U1TrvpWJliqkhluRhisES214OLL2a5XNPSESlBo50hsyCVag>
    <xmx:X7dmYzmne6j59I8m5mrch_WY1kIi6_ChY3YlxYzsj-kNUzkYYp3BuQ>
    <xmx:X7dmY5cFVuyPhFjLZYsAXEhDmAFXDgoAgXeg_xk_D1dTkOAiLTB2ZQ>
    <xmx:X7dmY-vLVzoOJjbesJWr6EbKVx_jYSyR8ksGK4EjsWISHewTLISt5w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Nov 2022 15:19:59 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/2] bus: sunxi-rsb: Support atomic transfers
Date:   Sat,  5 Nov 2022 14:19:53 -0500
Message-Id: <20221105191954.14360-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221105191954.14360-1-samuel@sholland.org>
References: <20221105191954.14360-1-samuel@sholland.org>
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

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/bus/sunxi-rsb.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 17343cd75338..0f0e498d4379 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -267,6 +267,9 @@ EXPORT_SYMBOL_GPL(sunxi_rsb_driver_register);
 /* common code that starts a transfer */
 static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
 {
+	bool timeout;
+	u32 status;
+
 	if (readl(rsb->regs + RSB_CTRL) & RSB_CTRL_START_TRANS) {
 		dev_dbg(rsb->dev, "RSB transfer still in progress\n");
 		return -EBUSY;
@@ -279,8 +282,16 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
 	writel(RSB_CTRL_START_TRANS | RSB_CTRL_GLOBAL_INT_ENB,
 	       rsb->regs + RSB_CTRL);
 
-	if (!wait_for_completion_io_timeout(&rsb->complete,
-					    msecs_to_jiffies(100))) {
+	if (irqs_disabled()) {
+		timeout = readl_poll_timeout_atomic(rsb->regs + RSB_INTS,
+						    status, status, 10, 100000);
+	} else {
+		timeout = !wait_for_completion_io_timeout(&rsb->complete,
+							  msecs_to_jiffies(100));
+		status = rsb->status;
+	}
+
+	if (timeout) {
 		dev_dbg(rsb->dev, "RSB timeout\n");
 
 		/* abort the transfer */
@@ -292,18 +303,18 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
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

