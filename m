Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE9969EA60
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjBUWoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjBUWoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:44:08 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A668CC670;
        Tue, 21 Feb 2023 14:44:05 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 5F93232000D7;
        Tue, 21 Feb 2023 17:44:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 21 Feb 2023 17:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677019441; x=1677105841; bh=6ba+iTlkGR
        nTAvHG6IlOQ+VtO9z8w6dNOvGsiQT6koA=; b=PK374boaIC2nboJQrGsdhl81Dw
        oU5/zqSKJl9W5matBS/LbfAmOwGZOJgDTwy0OjhoZBc2M0P47naGcGNxOnYCBfBq
        mD5Y+BHEJEbVtAxkeTPjOASjyMAmb8B7qJn+yWsyHJ6C22LgOvwwbzDq2vh9aiTl
        sxR9yT1WJI2FNo/qrnxyY24hV+OGYXnUVpdfb+eby5ooz+pmN8IJgywAL12oCxJU
        ACqYZGR30drFFRZ4avafQDFNuTLAlUptft1w6bq6pZMY18ggPCF6uMSVulFAyZci
        hjVQJWFcttj4rcQR2whFB5pa5FiSMcyO9Mz+22f7OTJIKM/rNKVsg4HIbZiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677019441; x=1677105841; bh=6ba+iTlkGRnTA
        vHG6IlOQ+VtO9z8w6dNOvGsiQT6koA=; b=Sc924GMUv02w4yXcaZIMHQNgWDhlS
        RK+uEymWJfTATA8YF1ZCDeNySPdBJpcghFUVFFiDzI6X0zX0mnQZdNCI7qgbnijs
        T0X8vKywP9Y0yXUA+5aSrgRcTgKTEZm0CY0+bEPASxF05HGzC87MC6q9gSPaYvEb
        /yC2/grScwmipTN7QfGY8Y8I2UsQL89ALQR3ARSUK0IGjGQmhTvBEmYnaf5Ntlpw
        1HpVhXnN2xEpplGtF0wn1K/ZjX82D/hv8upjKb5eCmZ55VwcXnKLKV59EqeeyfzX
        YfxlCfySefTyg2y50WGDJRfZlO6AhgweUgbGvJysr4xPCfLBJxIun0fPg==
X-ME-Sender: <xms:MUn1Y1VvNwc9YIgacLRyeJBUEM2CBE-9gyW8TpWGU7SQMhp665295A>
    <xme:MUn1Y1nh8oDWSb6tcayhmA1t9O_bSgvoU2zipvWiFVPHqcaNz-2FquuYJZuoEN6-e
    A0AA-k8r9Lpd79Xbg>
X-ME-Received: <xmr:MUn1YxZBTAEY0tK3L32lmRl7mXz_lfo0-8cMmTCoyE1pZckrk7fQl5ol5WXLv-oUvLKeFdF41vHlbhoG2H1DnRT7HSPZe7gDLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejkedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeetlhihshhs
    rgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeejfe
    ehffehjeejgfdtffetkedtgfefgfefjeegffekjeejgedtveejleehleelhfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihssh
    grrdhish
X-ME-Proxy: <xmx:MUn1Y4XmHGk8HTvhiL3YLBwE__JNc08YF4mrxUzOFpqhJNTqaWzE6w>
    <xmx:MUn1Y_loSc0B6Bumg8JqLZX5wf5dyo6rfbQ0hoHX98wJ2cBKtDyq5g>
    <xmx:MUn1Y1cEBJHAy6tRW7SRgPcMC8aCdJzXpHDJ10ObJDsZmx4OhL5DWQ>
    <xmx:MUn1Y0w8cZ6-KHaS6FVsFe5fqmAnZUQWaBye88zAC-PDwM0o_VMtfw>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 17:44:01 -0500 (EST)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id 006241389C; Tue, 21 Feb 2023 22:43:58 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Martijn Coenen <maco@android.com>,
        Alyssa Ross <hi@alyssa.is>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] loop: LOOP_CONFIGURE: send uevents for partitions
Date:   Tue, 21 Feb 2023 22:28:51 +0000
Message-Id: <20230221222847.607096-1-hi@alyssa.is>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

LOOP_CONFIGURE is, as I understand it, supposed to be a way to combine
LOOP_SET_FD and LOOP_SET_STATUS64 into a single syscall.  When using
LOOP_SET_FD+LOOP_SET_STATUS64, a single uevent would be sent for each
partition found on the loop device during LOOP_SET_STATUS64, but when
using LOOP_CONFIGURE, no such uevent was being sent.

In the old setup, uevents are disabled for LOOP_SET_FD, but not for
LOOP_SET_STATUS64.  This makes sense, as it prevents uevents being
sent for a partially configured device during LOOP_SET_FD — they're
only sent at the end of LOOP_SET_STATUS64.  But for LOOP_CONFIGURE,
uevents were disabled for the entire operation, so that final
notification was never issued.  To fix this, I've moved the
loop_reread_partitions() call, which causes the uevents to be issued,
to after uevents are re-enabled, matching the behaviour of the
LOOP_SET_FD+LOOP_SET_STATUS64 combination.

I noticed this because Busybox's losetup program recently changed from
using LOOP_SET_FD+LOOP_SET_STATUS64 to LOOP_CONFIGURE, and this broke
my setup, for which I want a notification from the kernel any time a
new partition becomes available.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
Fixes: 3448914e8cc5 ("loop: Add LOOP_CONFIGURE ioctl")
---

I've marked this as an RFC because there's still a problem with this
patch that I'd be grateful for advice on how to solve: this change
accidentally makes LOOP_SET_FD emit uevents as well if max_part is
configured.  There are a few ways I could imagine resolving this:

 - Have loop_configure distinguish between LOOP_SET_FD and
   LOOP_CONFIGURE somehow.

 - Have loop_configure take a bool argument specifying whether uevents
   should be reenabled before or after the loop_reread_partitions()
   call.

 - Move re-enabling the uevent and calling loop_reread_partitions()
   out of loop_configure().

All of these have drawbacks for the understandability of the code
though, so I wanted to ask what the best way to proceed would be.

 drivers/block/loop.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 5f04235e4ff7..d8063dbf5ec1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1110,15 +1110,19 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 
 	loop_global_unlock(lo, is_loop);
-	if (partscan)
-		loop_reread_partitions(lo);
 	if (!(mode & FMODE_EXCL))
 		bd_abort_claiming(bdev, loop_configure);
 
+	/*
+	 * Now that we are done, reread the partitions with uevent
+	 * re-enabled to let userspace know about the changes.
+	 */
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
+	if (partscan)
+		loop_reread_partitions(lo);
+
 	error = 0;
 done:
-	/* enable and uncork uevent now that we are done */
-	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
 	return error;
 
 out_unlock:
@@ -1130,6 +1134,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	fput(file);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
 	goto done;
 }
 
-- 
2.37.1

