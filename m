Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECA267C39F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbjAZDef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbjAZDeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:34:21 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0753266010;
        Wed, 25 Jan 2023 19:34:16 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 695895C0153;
        Wed, 25 Jan 2023 22:34:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 25 Jan 2023 22:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1674704055; x=1674790455; bh=z0ynB5y0JUWTzScYTn7Q3OC3bp6u5sO9TqW
        4X6XkP2I=; b=hDNnUBhGT+NH0/s8SzP4A/3FBNKtiCW9hYWlUgoQd/BgGqFxmBw
        T+0KEanvu5FC+5O92YvKLmMsPEXXNFyNawzj0hha/x36KwNWzZWXlW/uegUZR0Rz
        UPdQL6Lr0w21Hua7wVFE4b3GlOvehj17ZeT8WkntOH1Ky5rlufJZHBXw+nm3bekX
        F4MdItj5G2q3DUnlj23e6vNfzs8LU7G0Roy/hJxJ1Yf2ty3OAv7FW3167lWjCaB1
        0cfltfv/ikJqKZoZ4v+u8LkUO8Z8qgxpvpQmzV95N+Dy3VF2UCL3B84Ubrj1tIBu
        Alo7F8zKTdhI7u7YcaQlOStO+1Lwk8jEAcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674704055; x=1674790455; bh=z0ynB5y0JUWTz
        ScYTn7Q3OC3bp6u5sO9TqW4X6XkP2I=; b=UwYtMTzIn2dV76r8isxyffojuG/6+
        xpE20r3t5Tb0AA+fr1wsYXnZVK9V1cj0DE+DY0wgKbssMvWz1a0VK9v64km05Pt4
        dgkcU2wcGDbA3YMTHkA7ofwKICbXPw1Ll4eryaKXva6VqGJNX1gPUABv1RogXQLN
        cFpiq6bY9ehiJL0e0WnTt4oTgdMY6Psd5Q+K42+k8T1nlLOsibi3ySD5qEgo0nl5
        VcHAhqRbmwBSw2KwPhfj6caZ5jKDvg5sVbEnH8uu39ZqRzraxrZOehrpqOTeOKQc
        Aw4Qlr+3RUfs1mzUjB2f/5vStJaDB2HwFgMgRWG7qiXfzjtCSLoyw2obw==
X-ME-Sender: <xms:t_TRY-C8VzjuCrpaxahsD9jchnH2Yn5cFHmMHRVWVBzoVp5LF4vjrw>
    <xme:t_TRY4jHgnfEriSPkBdn4ynaM2h3WXMm6FF49hSth18jXOLbszyGts-K7oU9Arqdk
    nl3buXIJlY7u6A>
X-ME-Received: <xmr:t_TRYxl9szq2Bjjyt4rfE0tQj_6iJTZoUGxU86qTsXFJqERIGxx8R4rSnio6q7-7L4duPmtbOqJ3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:t_TRY8wlwIauC_-siedOv58Hb6pSldjjqc0HhSibwjHuo0Uwn53mkw>
    <xmx:t_TRYzQkGf7B14BEKzoJJk0WzpQUfA6kyIgkUaAt8SUaOGURMYPkSg>
    <xmx:t_TRY3a-EcA7jufoWYy265kkfCMFQG6Hbekz7E1Xp2Tb7SqENfn_6g>
    <xmx:t_TRY-cDCaMLPmtEIger0OJ8VFpXP-hYgNOiy5Bg93MCIr5XkK-5_w>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 22:34:14 -0500 (EST)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/7] Increment diskseq when releasing a loop device
Date:   Wed, 25 Jan 2023 22:33:56 -0500
Message-Id: <20230126033358.1880-5-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126033358.1880-1-demi@invisiblethingslab.com>
References: <20230126033358.1880-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ensures that userspace is aware that the device may now point to
something else.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 block/genhd.c        | 1 +
 drivers/block/loop.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 23cf83b3331cdea5c916fbf01cb5b92aeb2f7cf8..5bf7664273c66d04b40730434f17f7b65fbfe101 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1490,3 +1490,4 @@ void inc_diskseq(struct gendisk *disk)
 {
 	disk->diskseq = atomic64_inc_return(&diskseq);
 }
+EXPORT_SYMBOL(inc_diskseq);
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1518a6423279bc890221e8184a8f2e420cb16715..f862b0ab1dce43b3617b1381be8e2de3aab828b1 100644
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
