Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437D9716EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjE3Ubr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjE3Ubm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:31:42 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56394F7;
        Tue, 30 May 2023 13:31:41 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 26C5032005C1;
        Tue, 30 May 2023 16:31:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 30 May 2023 16:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685478699; x=1685565099; bh=aSjkzE25S8
        BxmyJfHmxx2kjK812O0BGlmJS9UYp63Y4=; b=iK+uxXhV6X4xM7zdOsRLRNl7Rl
        GeCaXb9nofcQLJMH5PYa8rM5mPH1np/a+6qzHLKH/xgr4kR4IXAg30xdIqri75uf
        f/HA4WZkCSFcOo7cNqUyy8XM/mAA5BKtkkdZ1PCLM6dnhelU1vC8pavl7AWFfugt
        4sRiOO97mcVcpXj5MGvFR7i96rhwtfyMeXrQMUlsQduztFxlYcDLQG/EDvZSk3wq
        x92Oroq+S25UkVnqRiLhrdY1NyoS9E0KaGS1k185wNunE+FkLZv0bi0cekflq7QK
        YcsOdasoRS8hfC8B5I4G2Y5doOhecSPGwC5fQwkbDtySEHXq8JzjTicIZO5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685478699; x=
        1685565099; bh=aSjkzE25S8BxmyJfHmxx2kjK812O0BGlmJS9UYp63Y4=; b=f
        Zri7GXfSSveOOtYOhvOUEtsANsXmWURASgkB/lbtLP/WL+xtmXsMnGdWCIJvHxk9
        3P4owz460lQ0tIW2GadrRZrHamxcLGygApj4txw8+S26mwTJy70Xa5MgAmR7OD28
        3BQxHlhnew0PgxDnyK6jr8OsOqZ89aJi5/efdD/8P7nMYdHdPt9KGKs8Fpq9Gt2K
        0fZnUTtGA/5zoxj5fzQ1MjgpSQTy7yTSwtJplgo44KMf2SM3jJ6mFQ4hQbuicwEG
        2NH0Z9/cMmeK3OtsVQ7bqYjG2KfdqSm8iVBn9slACvUrWPUr7xWilidlX88F519A
        zhCVORCXIU4SPKqCtRt2A==
X-ME-Sender: <xms:K112ZNLdk7wSJASVb91a04jG4oflO_XcOFaiSvkBTykdbHCVNggo6w>
    <xme:K112ZJI6zgUEzXAHeDV5KaRENmzmZJKK0SSdpBSaQmgoSdJ5yLXrxeq7Hsavz2EHD
    3MPAtXfus4r32E>
X-ME-Received: <xmr:K112ZFt0ZlOK8gkZQh9dbasyotJ1vU7m9y9SUbnCFXx7UUbjsnujiJQOQn0pH30DleIzc3IrecY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:K112ZOa48AE4ZVOlNQI--xrDOF3nPXzQfahOf1ELK_GIz23fXPAnHA>
    <xmx:K112ZEYi6T0TChdOca6-6colnmqEJiG9Bi3CTwZBPyClLrhgw-QmZw>
    <xmx:K112ZCAYfZ5lmE6T25N3tVSR69c_BbGJ6sC2B9IpBSRuupCOGSXAdQ>
    <xmx:K112ZKMp1wowIzo5DcMQ7w40nQAFGFn6_yoXvmSQVFYk44IdGB8nAA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 16:31:38 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        stable@vger.kernel.org
Subject: [PATCH v2 02/16] device-mapper: Avoid pointer arithmetic overflow
Date:   Tue, 30 May 2023 16:31:02 -0400
Message-Id: <20230530203116.2008-3-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530203116.2008-1-demi@invisiblethingslab.com>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
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

Especially on 32-bit systems, it is possible for the pointer arithmetic
to overflow and cause a userspace pointer to be dereferenced in the
kernel.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
---
 drivers/md/dm-ioctl.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 34fa74c6a70db8aa67aaba3f6a2fc4f38ef736bc..64e8f16d344c47057de5e2d29e3d63202197dca0 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1396,6 +1396,25 @@ static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
 {
 	static_assert(_Alignof(struct dm_target_spec) <= 8,
 		      "struct dm_target_spec has excessive alignment requirements");
+	static_assert(offsetof(struct dm_ioctl, data) >= sizeof(struct dm_target_spec),
+		      "struct dm_target_spec too big");
+
+	/*
+	 * Number of bytes remaining, starting with last. This is always
+	 * sizeof(struct dm_target_spec) or more, as otherwise *last was
+	 * out of bounds already.
+	 */
+	size_t remaining = (char *)end - (char *)last;
+
+	/*
+	 * There must be room for both the next target spec and the
+	 * NUL-terminator of the target itself.
+	 */
+	if (remaining - sizeof(struct dm_target_spec) <= next) {
+		DMERR("Target spec extends beyond end of parameters");
+		return -EINVAL;
+	}
+
 	if (next % 8) {
 		DMERR("Next target spec (offset %u) is not 8-byte aligned", next);
 		return -EINVAL;
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

