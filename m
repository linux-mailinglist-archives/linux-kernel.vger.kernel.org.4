Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203BA71F5EB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjFAW1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjFAW1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:27:02 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D40133;
        Thu,  1 Jun 2023 15:27:01 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 917AE5C00E9;
        Thu,  1 Jun 2023 18:27:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 01 Jun 2023 18:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1685658420; x=1685744820; bh=iy/GUaaPPTaS6rwFy0PBDtNgCO5kwW/eHTt
        pnmc0zuM=; b=Z4CU56AmPFLmSjNIWicm+SUnvn06uYZdblO+4TbIMCkPjvv3Ln1
        PUGtE16bSWofN22Vt+X2zZGIJGkuyouG/D5XPX8FvyTvcTrnvhzAuXCfY6ReCRCg
        DiP6PNnaBxDU3OKY+F4z5pvJd1q5JvD5Kro6Nm/M3m6hYgGN7smjJSFilEt8t4zB
        COaptwSpXohvxx2Gtb4UQ9U3UD7gU6gielaRyN58klN5CzFW+a4rUrI76DvkM/tR
        wZV1J7+zVS+99LLzT780Rgd8aVgzRUqggLcsEDZyEIBXZ/5V9Vfr0VueVc3fKVGe
        Rr1JnCq40cUvesA+lXIWJiE4XaxF4hbYslQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685658420; x=1685744820; bh=iy/GUaaPPTaS6
        rwFy0PBDtNgCO5kwW/eHTtpnmc0zuM=; b=Scu4bR1SCTs286aPBJ/DD1KjDzD/I
        8RxwId/3DCAKrMCzel/o2GuBy11qjd0/saTJzkxC9YQ7W5i1HQkQgsZYDNDkhKCc
        1ktSFIQWP/HgA3TwfskAKrmbngIVbgpj58M3qeHRQw/8A+6Fuszl+N0TNADd2cOS
        DmYiSHJgB/XGiYuIRG7aUyOQWrU5IQ6B0gutiBrATt9WODw73zImss9wLnbj43ow
        Hxb7d9FRjkaeHWMu4VA+TXX273Q2GbSvRIEuOMqeNbRbRW+FXLCND3HiDlQdGQSJ
        fPyGd0o/NyhaV82tXsUsGqbTlPt20GIaDtNlTHL5YZlq9YMXvOtJmdiAg==
X-ME-Sender: <xms:NBt5ZOa1I9p2HrXSxmQ3PBPozIP2-Cing6xVgtVvXLwfBtpDazriSg>
    <xme:NBt5ZBYzn2JCOnrKyXy0zUnn4QQyZC8xHzl7HcUQu0-5UYkHk8wf-ybaZX44NjKXk
    cihMOnejmeWDWA>
X-ME-Received: <xmr:NBt5ZI_cVimzQC8DvwhLNzjI5VxDhKfONe3kogA74XzI3DZgRkDUzmLe8ybYu_0Jgqd6EFrPT3o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelvddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgvmhhiucfo
    rghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhnghhslh
    grsgdrtghomheqnecuggftrfgrthhtvghrnhepvdefgeekvdekgfffgeekhfeijedtffek
    hefhleehfeejueetgfelgefgtdevieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgr
    sgdrtghomh
X-ME-Proxy: <xmx:NBt5ZArP2z5ceXGfT-WnNAic88zSfXGiefzY0w7GCi8gY__mgqfqPg>
    <xmx:NBt5ZJrnFQUM_pwfKg91jPfqXOgvhvtJ3e4MtUgG6qzzFfJBiMuZnw>
    <xmx:NBt5ZOSURmcj3xPqFh8zXkD4AAFuGtgGFoRa5CV93AzUfZgyGNmmaA>
    <xmx:NBt5ZKDxtd3dhzdgCmQxN2-98JyvDX0oo8PKnvrFn3_v8qjit326dA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 18:26:59 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block, loop: Increment diskseq when releasing a loop device
Date:   Thu,  1 Jun 2023 18:26:56 -0400
Message-Id: <20230601222656.2062-1-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch for checking diskseq in blkback is not enough to
prevent the following race:

1. Program X opens a loop device
2. Program X gets the diskseq of the loop device.
3. Program X associates a file with the loop device.
4. Program X passes the loop device major, minor, and diskseq to
   something.
5. Program X exits.
6. Program Y detaches the file from the loop device.
7. Program Y attaches a different file to the loop device.
8. The opener finally gets around to opening the loop device and checks
   that the diskseq is what it expects it to be.  Even though the
   diskseq is the expected value, the result is that the opener is
   accessing the wrong file.

To prevent this race condition, increment the diskseq of a loop device
when it is detached from its file descriptor.  This causes blkback (or
any other program, for that matter) to fail at step 8.  Export the
inc_diskseq() function to make this possible.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
I considered destroying the loop device altogether instead of bumping
its diskseq, but was not able to accomplish that.  Suggestions welcome.
---
 block/genhd.c        | 1 +
 drivers/block/loop.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 1cb489b927d50ab06a84a4bfd6913ca8ba7318d4..c0ca2c387732171321555cd57565fbc606768505 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1502,3 +1502,4 @@ void inc_diskseq(struct gendisk *disk)
 {
 	disk->diskseq = atomic64_inc_return(&diskseq);
 }
+EXPORT_SYMBOL(inc_diskseq);
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bc31bb7072a2cb7294d32066f5d0aa14130349b4..05ea5fb41508b4106f184dd6b4c37942716bdcac 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1205,6 +1205,12 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	if (!part_shift)
 		set_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 	mutex_lock(&lo->lo_mutex);
+
+	/*
+	 * Increment the disk sequence number, so that userspace knows this
+	 * device now points to something else.
+	 */
+	inc_diskseq(lo->lo_disk);
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
 
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

