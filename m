Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD4771F509
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjFAVtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjFAVsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:48:53 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F21A197;
        Thu,  1 Jun 2023 14:48:35 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7BAED5C01A3;
        Thu,  1 Jun 2023 17:48:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 01 Jun 2023 17:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685656114; x=1685742514; bh=/ceYfrFEiY
        puOEzUpc708tuWKW8Bpfbqx/MGT13F/ic=; b=pEQVwivCtKSIpnnVWyl0qP+rHf
        wPJW/rTpMLu3K1l6wwlXDGP9UX80lL33h6FL1YwNd5pNXE5H+EuMpkNGlny4YEKR
        kfonkVrJqyLi3OO8X17gUfMWD0O23JgH37DrdQAlG3VBrzKFNl0Y+s9xiwsTZADl
        i92YhiGkiJmSVmH8Swd/RHcEDn8MnDnNFjvzqnVpGd7SKPmABkL9pqwmUhbpVOXz
        y7peMFpTOPTp83A9mfL016h9FBDdk6DU3K73c4PBJngqXB5Rgg+agxPu/TiqHfdj
        Bz7H3HmTOvQa2g0s1XnqKwllPkGTn05zgrvWLEZJH3WxDI0W0gSAKSm9Im3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685656114; x=
        1685742514; bh=/ceYfrFEiYpuOEzUpc708tuWKW8Bpfbqx/MGT13F/ic=; b=U
        xIKiEWBCHGFMG5NZxOXdwiJwb3/lK3/JpB9Vv1Hl7fPrCBeS0F99jTphL0PHZjLz
        xUNI2qvB2J2AM54zwE6BoW+k4Q68Ja/ssWGsCPa5BBeFs3V09KHogiQl0v4kRhln
        thQz6IOIKfiDXWejvhMmkwRo/bEe6bDvFu8K6QrW3klEIJq8eSjQ1y5gH+72tVUj
        FHckrqCwUzpDhu2p6u27WxwlxuWz26/mzG+BOBg8VvDttZUM4PCZof29kEqM+iwp
        /kMu+HP1AREYUaPF1JzjGxOrr6rNGELCCEMS3stLBJDq2Wa4hLyZYmUQfTlxGn0Y
        KUxqi3+DjKvNPHlGLCYhA==
X-ME-Sender: <xms:MhJ5ZG2BXSWv30MZ-lYSx-FnJtY2bFX_pYcW9CFzZgXrkKwYrGtvvA>
    <xme:MhJ5ZJEligkQPgY8NIo0VzkgXlcYxsH1m_Y4C6GXmIsQfV9JrcC-4uazqegSTjNPr
    Fr67_CxqYhWZME>
X-ME-Received: <xmr:MhJ5ZO6cnoQk2zNidxQcZ9_i9oPiqEjxSk5dkNpVRrmp9QTpjuUbJjdFkvtDzKVhAH_CJLimU30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelvddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:MhJ5ZH0R0kyNFR9BfneeYqkdFVRfJu-2LyTArB5XymX46XWVO-XRRA>
    <xmx:MhJ5ZJGEpzJ4ZCNg5t-2wQ4s77DneRYcjyOrqXXCT3HqwcCV6iF7Ww>
    <xmx:MhJ5ZA9UAIekEfcs2dKXH2eLECqBUe2ZS6jAaXZ0beZ68z6ZBqZyCQ>
    <xmx:MhJ5ZNjY733Xf8Buyr5R4bW8kBDzi6IDwQR9wWOECti5GchVfbYBRg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 17:48:33 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] xen-blkback: Inform userspace that device has been opened
Date:   Thu,  1 Jun 2023 17:48:23 -0400
Message-Id: <20230601214823.1701-3-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601214823.1701-1-demi@invisiblethingslab.com>
References: <20230601214823.1701-1-demi@invisiblethingslab.com>
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

Set "opened" to "0" before the hotplug script is called.  Once the
device node has been opened, set "opened" to "1".

"opened" is used exclusively by userspace.  It serves two purposes:

1. It tells userspace that the diskseq Xenstore entry is supported.

2. It tells userspace that it can wait for "opened" to be set to 1.
   Once "opened" is 1, blkback has a reference to the device, so
   userspace doesn't need to keep one.

Together, these changes allow userspace to use block devices with
delete-on-close behavior, such as loop devices with the autoclear flag
set.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/block/xen-blkback/xenbus.c | 35 ++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 9c3eb148fbd802c74e626c3d7bcd69dcb09bd921..519a78aa9073d1faa1dce5c1b36e95ae58da534b 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -3,6 +3,20 @@
     Copyright (C) 2005 Rusty Russell <rusty@rustcorp.com.au>
     Copyright (C) 2005 XenSource Ltd
 
+In addition to the Xenstore nodes required by the Xen block device
+specification, this implementation of blkback uses a new Xenstore
+node: "opened".  blkback sets "opened" to "0" before the hotplug script
+is called.  Once the device node has been opened, blkback sets "opened"
+to "1".
+
+"opened" is read exclusively by userspace.  It serves two purposes:
+
+1. It tells userspace that diskseq@major:minor syntax for "physical-device" is
+   supported.
+
+2. It tells userspace that it can wait for "opened" to be set to 1 after writing
+   "physical-device".  Once "opened" is 1, blkback has a reference to the
+   device, so userspace doesn't need to keep one.
 
 */
 
@@ -699,6 +713,14 @@ static int xen_blkbk_probe(struct xenbus_device *dev,
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
@@ -826,6 +848,19 @@ static void backend_changed(struct xenbus_watch *watch,
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

