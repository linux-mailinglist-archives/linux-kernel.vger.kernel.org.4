Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45E07266C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjFGRI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjFGRIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:08:54 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7E11BF1;
        Wed,  7 Jun 2023 10:08:51 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 94B245C0114;
        Wed,  7 Jun 2023 13:08:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 07 Jun 2023 13:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686157730; x=1686244130; bh=OKyh78clxdjUBYWd2RtYdS/EeUQhHG5NkHJ
        Jd2T0ITE=; b=RPkXP4UqXwqtzc4+CXRx9FxVrOrEZzqZmfOzTAiQ+taGvOmATQN
        rj+aO8Xk1QGMQ7j3XoSZBCw8CSp/tvb7LF28DRnVJBtTuypN1Sw+C2fXhVag3Jhk
        /AgsNFzQA7EvlpgH2RFC+DVczoLAm2C3a6edP6BQ00Yu3VbAR/4BG3p3X9CgdWI9
        EhijfUujWe3M0JLYcencH4B6liJgxTIdeFFrA79rnv/zeuasZjrPUyjbS6VbYWQj
        r1TDdpikdqjz8X2NrCVBtBWWAwipFetp6T+fRXXIUxhbk/SDMCfmvXACFZC9farX
        FIqC9OJaDO/uuV0UJnuZ+6ihPz2hkoAB1yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686157730; x=1686244130; bh=OKyh78clxdjUB
        YWd2RtYdS/EeUQhHG5NkHJJd2T0ITE=; b=cdQ6mHvF+jJeoSE1SIIJc0G+qRe32
        sxQMAprznL3aEwzR58XPYUuhV5XU7rSXl4+/NQfl8jpoJtyHTOEFK6zbIwz1M47p
        8VOuXCUpORa5Vg5p/t18yU9QY3b/s3TTbak01SZB4RYbgBmDdWbfvhHET2Ibqykh
        gdiol4bOmq/aP4S5ECQWAHomQA9wFda6uexs5UeyrjTL9mXC+4g4tM8Hr5VLopnv
        rB7v4ikQgiNURCk6I7mvGxYxFtYcVQBQTqk2oWUuArq7OLTaR65I7nrpJIwxOjf8
        HBX1c91L2DW3I+i7xByD0GI5cjiYqHMvCRwB6AWOiznDllN7A1uCwxrHg==
X-ME-Sender: <xms:obmAZPRtFAlz8_WGzi3fOAUhg0_V4VKXtv-5rFSc-7F0iow9ICtk4w>
    <xme:obmAZAwlYnVRgGojcw5gy3wPXjEObii0isJMyOu1ZnEPSFtD2kilBlUcL1_g0iM-P
    xYbDrDlbYCGHrg>
X-ME-Received: <xmr:obmAZE3mgq4zImQGj0w7FdEaKzfeiRmaZFzl9W8z3UK15QqQjLFlnp3JNxHa_NXJ15G0Zz6VMqc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtgedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffvghmihcu
    ofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgsh
    hlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvfeegkedvkefgffegkefhieejtdff
    keehhfelheefjeeutefgleeggfdtveeileenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhgshhl
    rggsrdgtohhm
X-ME-Proxy: <xmx:ormAZPCohEKhhsuy2IFxVUXjQE3jI2EykAWgmlTPBgiUHjAFaUDmNA>
    <xmx:ormAZIhSx5s4oUcYwnGdRAPUCHvTGc-z11VU7IB5PfM4EnTLXs69Uw>
    <xmx:ormAZDrwSu6oZ28lrMWuMqR6WY79roL2h5s-9jwVw7kz8Mbcb8gGZg>
    <xmx:ormAZBtj5-aHoXYFn2X5DltgszFvVNJVfhOAmYreCtZnjr-5POUpuQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jun 2023 13:08:49 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, stable@vger.kernel.org
Subject: [PATCH] block: increment diskseq on all media change events
Date:   Wed,  7 Jun 2023 13:08:37 -0400
Message-Id: <20230607170837.1559-1-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, associating a loop device with a different file descriptor
does not increment its diskseq.  This allows the following race
condition:

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

From discussions with Christoph Hellwig, it appears that
disk_force_media_change() was supposed to call inc_diskseq(), but in
fact it does not.  Adding a Fixes: tag to indicate this.  Christoph's
Reported-by is because he stated that disk_force_media_change()
calls inc_diskseq(), which is what led me to discover that it should but
does not.

Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Fixes: e6138dc12de9 ("block: add a helper to raise a media changed event")
Cc: stable@vger.kernel.org # 5.15+
---
 block/disk-events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/disk-events.c b/block/disk-events.c
index aee25a7e1ab7de8cc82b3c3774e83489d3a86ff9..450c2cbe23d56cc0fa8fa40db9866cdae0e7a626 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -307,6 +307,7 @@ bool disk_force_media_change(struct gendisk *disk, unsigned int events)
 	if (!(events & DISK_EVENT_MEDIA_CHANGE))
 		return false;
 
+	inc_diskseq(disk);
 	if (__invalidate_device(disk->part0, true))
 		pr_warn("VFS: busy inodes on changed media %s\n",
 			disk->disk_name);
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab
