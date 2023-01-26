Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8C267C3A3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbjAZDeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjAZDei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:34:38 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726D256EFE;
        Wed, 25 Jan 2023 19:34:22 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id CBD635C0153;
        Wed, 25 Jan 2023 22:34:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 25 Jan 2023 22:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1674704061; x=1674790461; bh=V4qU6xBczXYBxuAJBBtWt5596TfV6Bd4Dyk
        +YpmwRl4=; b=CuRQlVlIShgx+Q3OebmHVhmoUi/3WbvG8C7kvnQPwXe1QU0tnFD
        XmXhEOq6gJBc6ipUhy7jKIip+gM3ffn5Znohlz62xTB8F1yHGTtB13fNiydmxq8e
        2NjBisXqiKFl0vK9uPtshH9lj1xhj6MDUbOxxBL4KbfXVOMP7KwQ4DrSGSnoqz5v
        d6dv73iHBERop8YVJX5LqtEdHvUdr0xm4S09J7FjPLp5bR7H52os2QZqiFTm67i9
        WSyDDhKmA7AG5cp7E0sqeAwVvYFz7eBL5YnZTmc2OuyQSug0g4Q6R7UsbbvzwEBp
        VBXdD9UALLDVFotjfYSfUvP34A7I/PNUiFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674704061; x=1674790461; bh=V4qU6xBczXYBx
        uAJBBtWt5596TfV6Bd4Dyk+YpmwRl4=; b=G9bxwKaZXTcN/J3Y2b7exagftg8il
        c5jEtm6ch7lOIR5yCje41RguRYT6IRbn7gpcD3VHhIl+gCjLBkRtp4h/UAu98A0e
        7H98igegXsNN79gnXc7QzoSxLZLguaUyAYegjyRxUITnysoDIeVqdrWD/iyE9DUJ
        01Hj38zqEP6unZz26qbaMVQ0cu7ymak7KVLI3QeEssr7vVUZp21eJAhutlVu6KV/
        KL9QJ9/r/Mba6IKukxPiuLInp9TnFA58SK240NHNIxaXY2vb4wxe4pklBQI9NGVt
        5avPzNEuaIKk0yRBDDkmAc1gSsTYrCTxsk0OSevDGJ1k8LPKZX83qcDtw==
X-ME-Sender: <xms:vfTRYxA6-Mngv9kVvNeKYFelujd9X3hxqrxnsQQgQoRXnx4akNDqMA>
    <xme:vfTRY_g0kbEZ2GK9NWaXaIW2jukfJa_e8DoKuK0Qs1K8To3jRJqmKJfnAJm8He6OV
    OClK6S6edNa1b0>
X-ME-Received: <xmr:vfTRY8m1auzzdb8jSU39w5zp7FT0b4qePSogOj96JXeuvMIR8ldPIDUslbahgUZ95JUqh_QZYJQn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:vfTRY7xo8bC9Gr4gUIjDd84JXD5A1aGSZY1WcD3a0S1k6pWQFfviyg>
    <xmx:vfTRY2REdgxnXQkrWOt5bdeY1R2H8D3OLGT6Jgnwvyz-LF6f9vLeNg>
    <xmx:vfTRY-aS49RRI1jZpvQNiqfXM3wRVucZ3oNnZ3i3OTk5w4kJRrQnCg>
    <xmx:vfTRYzI9BQbkoretVj3UW_QFpClo_dTyXivnEBXZLbRkgvC5qIZA_A>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 22:34:21 -0500 (EST)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/7] xen/blkback: Inform userspace that device has been opened
Date:   Wed, 25 Jan 2023 22:33:58 -0500
Message-Id: <20230126033358.1880-7-demi@invisiblethingslab.com>
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

This allows userspace to use block devices with delete-on-close
behavior, which is necessary to ensure virtual devices (such as loop or
device-mapper devices) are cleaned up automatically.  Protocol details
are included in comments.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/block/xen-blkback/xenbus.c | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 2c43bfc7ab5ba6954f11d4b949a5668660dbd290..ca8dae05985038da490c5ac93364509913f6b4c7 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -3,6 +3,19 @@
     Copyright (C) 2005 Rusty Russell <rusty@rustcorp.com.au>
     Copyright (C) 2005 XenSource Ltd
 
+In addition to the XenStore nodes required by the Xen block device
+specification, this implementation of blkback uses a new XenStore
+node: "opened".  blkback sets "opened" to "0" before the hotplug script
+is called.  Once the device node has been opened, blkback sets "opened"
+to "1".
+
+"opened" is used exclusively by userspace.  It serves two purposes:
+
+1. It tells userspace that diskseq@major:minor syntax for "physical-device" is
+   supported.
+2. It tells userspace that it can wait for "opened" to be set to 1.  Once
+   "opened" is 1, blkback has a reference to the device, so userspace doesn't
+   need to keep one.
 
 */
 
@@ -698,6 +711,14 @@ static int xen_blkbk_probe(struct xenbus_device *dev,
 	if (err)
 		pr_warn("%s write out 'max-ring-page-order' failed\n", __func__);
 
+	/*
+	 * This informs userspace that the "opened" node will be set to "1" when
+	 * the device has been opened successfully.
+	 */
+	err = xenbus_write(XBT_NIL, dev->nodename, "opened", "0");
+	if (err)
+		goto fail;
+
 	err = xenbus_switch_state(dev, XenbusStateInitWait);
 	if (err)
 		goto fail;
@@ -824,6 +845,19 @@ static void backend_changed(struct xenbus_watch *watch,
 		goto fail;
 	}
 
+	/*
+	 * Tell userspace that the device has been opened and that blkback has a
+	 * reference to it.  Userspace can then close the device or mark it as
+	 * delete-on-close, knowing that blkback will keep the device open as
+	 * long as necessary.
+	 */
+	err = xenbus_write(XBT_NIL, dev->nodename, "opened", "1");
+	if (err) {
+		xenbus_dev_fatal(dev, err, "%s: notifying userspace device has been opened",
+				 dev->nodename);
+		goto free_vbd;
+	}
+
 	err = xenvbd_sysfs_addif(dev);
 	if (err) {
 		xenbus_dev_fatal(dev, err, "creating sysfs entries");
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

