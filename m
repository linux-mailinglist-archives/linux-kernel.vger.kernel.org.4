Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D12A73CD64
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 01:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjFXXKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 19:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjFXXKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 19:10:03 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D3B1715
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 16:10:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id DF02D32004AE;
        Sat, 24 Jun 2023 19:10:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 24 Jun 2023 19:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1687648201; x=1687734601; bh=dxRbzU1iZA
        ZEi/0QoA6KMOWrU2r13cVV3OFozBagpS0=; b=ZeexDdSUuI5IHYYFhrXNZxn7a2
        B+aCTDQ7OMT6GD3MIDKy17AOzomwaIujUl+Vx5khkgDD2BoC5DMRE/LoPjb0aaSt
        hhwbsC9MAI569TFtX+wlJr4mNFT42SELZHdwLxHs7mEq2iZ/WSVbMLe3eWruvG1b
        2+mj3NHK39YlGFBen4kXwPgjCn9TcAwYNPMyDc46sxYApDDuWpPn/MyFjBuArHbO
        9FDKFqAP7U8TBuglqMzzq3GQZKZHqzL+lhVTLSiPvkN0/yQHn8fExGNB9pziTluG
        2bosoCbXRrYUtW8rqWguxNwVblAdyb44RB878hytsxegleVzQJTeY3cO0BPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687648201; x=
        1687734601; bh=dxRbzU1iZAZEi/0QoA6KMOWrU2r13cVV3OFozBagpS0=; b=j
        d5Lwt0CJn4Mh8nWni6Q1NbN1muziTQf36uinjpOPOOBHCu/GagkQksdaz9iyoCCu
        ThhaLBHxJ0wnk22Grm+6eTpfXQK5Z87NlKsc0K9INhQWjWM/ZwFbDlYLZez0E9R6
        az0TqgFEgpiqJL6IqYXrZleU4HLAiCI50aYchs5nQq6x39oJRRDNHbmvIwtmX5fR
        X4To/t1pWXa+Xz503Z6eN4m0khkP8wr3KS5LiGyvel85SMp0mKVUOalfRqHG5cvW
        cNY3B2DlL6m65b7ptZ443WTje6EMKKUCUMn835oHgIQAPAUvGKLypkNvupqRQGxa
        MrkO/9Bz0NGKka0tBJyKg==
X-ME-Sender: <xms:yXeXZBiRsmlhSJ-cGuCRucqK2VZIK8_2d7S1Qk8ayR4lqjkPnLHKdw>
    <xme:yXeXZGBzeUlGE9ryziWR4rm209PlPwRIRvDtgStkvSoZ9EcuS_99vjLRzvSks_ZUh
    MeVytveAfczB4Y>
X-ME-Received: <xmr:yXeXZBG4Pvo_w3HxlaFoQnpwvpSgGv7r3lSAI-1Ymi-1wf3aSHjuSxA9DpKruNv4NP4R8-SkvHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegkedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:yXeXZGQRo5h7ubzCdHvBBNmnBKnt1lcwtn13z61P0MMZZgLNjGZ1yw>
    <xmx:yXeXZOwDgnvN97Onk1ZOrQjg-qKfstBq4Cq0tvLmF6AzAmbWBkWpNw>
    <xmx:yXeXZM5PWCxy3HVl7-WZtcTW4RN5J7X1cyhidkL4GTCmcwNX0lesyQ>
    <xmx:yXeXZJ8iGY7wy65Ks7_ZAzv8_IXnMjOuCBDOwqnblWGfKGYN9VpYTQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Jun 2023 19:10:00 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dm ioctl: Allow userspace to provide expected diskseq
Date:   Sat, 24 Jun 2023 19:09:45 -0400
Message-ID: <20230624230950.2272-3-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230624230950.2272-1-demi@invisiblethingslab.com>
References: <20230624230950.2272-1-demi@invisiblethingslab.com>
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

This can be used to avoid race conditions in which a device is destroyed
and recreated with the same major/minor, name, or UUID.  diskseqs are
only honored if strict parameter checking is on, to avoid any risk of
breaking old userspace.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/md/dm-ioctl.c         | 41 +++++++++++++++++++++++++++++------
 include/uapi/linux/dm-ioctl.h | 31 ++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index e7693479c0cd974ddde69b3b1c4c67abc2ae3ad6..7abaeec33f1884d4588e8563fb02e9ea1a6782c8 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -878,6 +878,9 @@ static void __dev_status(struct mapped_device *md, struct dm_ioctl *param)
 		}
 		dm_put_live_table(md, srcu_idx);
 	}
+
+	if (param->version[0] >= DM_VERSION_MAJOR_STRICT)
+		dm_set_diskseq(param, disk->diskseq);
 }
 
 static int dev_create(struct file *filp, struct dm_ioctl *param, size_t param_size)
@@ -918,6 +921,9 @@ static int dev_create(struct file *filp, struct dm_ioctl *param, size_t param_si
 static struct hash_cell *__find_device_hash_cell(struct dm_ioctl *param)
 {
 	struct hash_cell *hc = NULL;
+	static_assert(offsetof(struct dm_ioctl, diskseq_high) ==
+		      offsetof(struct dm_ioctl, data) + 3,
+		      "diskseq_high field misplaced");
 
 	if (*param->uuid) {
 		if (*param->name || param->dev) {
@@ -946,6 +952,27 @@ static struct hash_cell *__find_device_hash_cell(struct dm_ioctl *param)
 	} else
 		return NULL;
 
+	if (param->version[0] >= DM_VERSION_MAJOR_STRICT) {
+		u64 expected_diskseq = dm_get_diskseq(param);
+		u64 diskseq;
+		struct mapped_device *md = hc->md;
+
+		if (WARN_ON_ONCE(md->disk == NULL))
+			return NULL;
+		diskseq = md->disk->diskseq;
+		if (WARN_ON_ONCE(diskseq == 0))
+			return NULL;
+		if (expected_diskseq != 0) {
+			if (expected_diskseq != diskseq) {
+				DMERR("Diskseq mismatch: expected %llu actual %llu",
+				      expected_diskseq, diskseq);
+				return NULL;
+			}
+		} else {
+			dm_set_diskseq(param, diskseq);
+		}
+	}
+
 	/*
 	 * Sneakily write in both the name and the uuid
 	 * while we have the cell.
@@ -2139,6 +2166,12 @@ static int validate_params(uint cmd, struct dm_ioctl *param,
 		return 0;
 	}
 
+	if (param->data_size < sizeof(struct dm_ioctl)) {
+		DMERR("Entire struct dm_ioctl (size %zu) must be valid, but only %u was valid",
+		      sizeof(struct dm_ioctl), param->data_size);
+		return -EINVAL;
+	}
+
 	/* Check that strings are terminated */
 	if (!no_non_nul_after_nul(param->name, DM_NAME_LEN, cmd, "Name") ||
 	    !no_non_nul_after_nul(param->uuid, DM_UUID_LEN, cmd, "UUID"))
@@ -2148,7 +2181,7 @@ static int validate_params(uint cmd, struct dm_ioctl *param,
 	 * This also checks the last byte of the UUID field, but that was
 	 * checked to be zero above.
 	 */
-	if (*(const u64 *)((const char *)param + (sizeof(*param) - 8)) != 0) {
+	if (*(const u32 *)((const char *)param + (sizeof(*param) - 8)) != 0) {
 		DMERR("second padding field not zeroed in strict mode (cmd %u)", cmd);
 		return -EINVAL;
 	}
@@ -2159,12 +2192,6 @@ static int validate_params(uint cmd, struct dm_ioctl *param,
 		return -EINVAL;
 	}
 
-	if (param->padding != 0) {
-		DMERR("padding not zeroed in strict mode (got %u, cmd %u)",
-		      param->padding, cmd);
-		return -EINVAL;
-	}
-
 	if (param->open_count != 0) {
 		DMERR("open_count not zeroed in strict mode (got %d, cmd %u)",
 		      param->open_count, cmd);
diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
index 62bfdc95ebccb2f1c20c24496a449fe3e2a76113..1d33109aece2ff9854e752066baa96fdf7d85857 100644
--- a/include/uapi/linux/dm-ioctl.h
+++ b/include/uapi/linux/dm-ioctl.h
@@ -146,16 +146,43 @@ struct dm_ioctl {
 	 * For output, the ioctls return the event number, not the cookie.
 	 */
 	__u32 event_nr;      	/* in/out */
-	__u32 padding;
+
+	union {
+		/* valid if DM_VERSION_MAJOR is used */
+		__u32 padding;		/* padding */
+		/* valid if DM_VERSION_MAJOR_STRICT is used */
+		__u32 diskseq_low;	/* in/out: low 4 bytes of the diskseq */
+	};
 
 	__u64 dev;		/* in/out */
 
 	char name[DM_NAME_LEN];	/* device name */
 	char uuid[DM_UUID_LEN];	/* unique identifier for
 				 * the block device */
-	char data[7];		/* padding or data, must be zero in strict mode */
+	union {
+		/* valid if DM_VERSION_MAJOR is used */
+		char data[7];	/* padding or data */
+		/* valid if DM_VERSION_MAJOR_STRICT is used */
+		struct {
+			char _padding[3];	/* padding, must be zeroed */
+			__u32 diskseq_high;	/* in/out: high 4 bytes of the diskseq */
+		} __attribute__((packed));
+	};
 };
 
+__attribute__((always_inline)) static inline __u64
+dm_get_diskseq(const struct dm_ioctl *_i)
+{
+	return (__u64)_i->diskseq_high << 32 | (__u64)_i->diskseq_low;
+}
+
+__attribute__((always_inline)) static inline void
+dm_set_diskseq(struct dm_ioctl *_i, __u64 _diskseq)
+{
+	_i->diskseq_low = (__u32)(_diskseq & 0xFFFFFFFFU);
+	_i->diskseq_high = (__u32)(_diskseq >> 32);
+}
+
 /*
  * Used to specify tables.  These structures appear after the
  * dm_ioctl.
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

