Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A22716ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjE3Ucu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjE3Ucd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:32:33 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDB8E4A;
        Tue, 30 May 2023 13:31:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CFA993200344;
        Tue, 30 May 2023 16:31:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 May 2023 16:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685478717; x=1685565117; bh=BECTYLtMds
        TyiT4uJYQfU+Mj8zJcihG/8pwIemyERcA=; b=BykYK4wdtoBrIVjSpxxaRPRuTr
        MGlY8mwYSF1nHQ3142m3NqrwVH/EijYHPymM56mLBuX227aHbQ5F2PW5DWZe4u7U
        lg8XpJpFzf5qQ9+uusq9GdBCE1en27c6fJjqiCBAmOvo5OlNdjA8tBsW+mrUjfCA
        i1VUPE3DVLVEEMqpNIzK/oylyXHY1ECWck487vgg36SRTL69g96Tmj2WP4WDhRDh
        YNZvRk872QnPn4w1V/NYR4fwDxLVOwskMoaUGoK62UfRSFaRcP0Nn2L5GVVeNhGI
        Mpu4eTYXCdD6V6NuJeZKduMF5daf+4pRdw20W2896KNxKazcdsRNJffWFNqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685478717; x=
        1685565117; bh=BECTYLtMdsTyiT4uJYQfU+Mj8zJcihG/8pwIemyERcA=; b=s
        1U5rNqdd3Uckhl+Jago2iM9Gf3UuVkhxSSUEaHhOfU7d6pLz10aattbKXvAzKLeQ
        p1y5pQ1q5M00Eb5JYCPaur978/NUoipGyMmasqpMjNPg+sH8guBmsx8gQC0lwOro
        MY4VFHjl8LbuDVnyVN2fMFbfJceUfRG9ptJUJYBiPSq9qQUzYzkfHdW5LQwKwknv
        96fbB4tjlsJ8Yaw7xsE64N4Kn6Ygh34s6DgbFGBnQuD99EyXiIgJjQHQLcg36Bvw
        KrOCQFa/X5wdDAAOODfQIkmoW8hRj7E40BSZhiPyo5FnrEg0N/s3wQacji9NgkkI
        38DoAfhisfRspgBJoSDkw==
X-ME-Sender: <xms:PV12ZIVF4XPa7vIfh95cZrTywjn8VZD4NyR1CTBdML7zBZS2OQ0OCg>
    <xme:PV12ZMkz8m_rPSIhxv_rMuxKobm9-zYx_FK6lU8br5aJB3NAksWPvPvzYNZSVPKrL
    8tt4fS9m_JgihU>
X-ME-Received: <xmr:PV12ZMb6UkdCD8vCp-byAOWnuf9MDLOmpVrsZt8uOG51rWcoEfGitxi_avKN2K4JLBHhcokC1KE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedvne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:PV12ZHUWDhP7wugXqpeBlzXBDQksonnz5X2q5g8xJmd9-TvmhVV3cQ>
    <xmx:PV12ZClyTCts34PN4tBkcQghm4JynLn6RCdKMJJB878uR0m85eus7w>
    <xmx:PV12ZMcN0GoE-Y5NGUx_8gB2vH4zuAqBUwFoamms2hdSBsmZ6pnCrA>
    <xmx:PV12ZEVCZBpjvTGgpOo1SkHD80xPv9iLaEtVk4dz0Sca4ECSJjxkrA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 16:31:56 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v2 08/16] device-mapper: Allow userspace to provide expected diskseq
Date:   Tue, 30 May 2023 16:31:08 -0400
Message-Id: <20230530203116.2008-9-demi@invisiblethingslab.com>
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

This can be used to avoid race conditions in which a device is destroyed
and recreated with the same major/minor, name, or UUID.  diskseqs are
only honored if strict parameter checking is on, to avoid any risk of
breaking old userspace.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/md/dm-ioctl.c         | 48 ++++++++++++++++++++++++++++-------
 include/uapi/linux/dm-ioctl.h | 33 +++++++++++++++++++++---
 2 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index cf752e72ef6a2d8f8230e5bd6d1a6dc817a4f597..01cdf57bcafbf7f3e1b8304eec28792c6b24642d 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -871,6 +871,9 @@ static void __dev_status(struct mapped_device *md, struct dm_ioctl *param)
 		}
 		dm_put_live_table(md, srcu_idx);
 	}
+
+	if (param->version[0] >= DM_VERSION_MAJOR_STRICT)
+		dm_set_diskseq(param, disk->diskseq);
 }
 
 static int dev_create(struct file *filp, struct dm_ioctl *param, size_t param_size)
@@ -889,6 +892,8 @@ static int dev_create(struct file *filp, struct dm_ioctl *param, size_t param_si
 	if (r)
 		return r;
 
+	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
+
 	r = dm_hash_insert(param->name, *param->uuid ? param->uuid : NULL, md);
 	if (r) {
 		dm_put(md);
@@ -909,6 +914,7 @@ static int dev_create(struct file *filp, struct dm_ioctl *param, size_t param_si
 static struct hash_cell *__find_device_hash_cell(struct dm_ioctl *param)
 {
 	struct hash_cell *hc = NULL;
+	static_assert(offsetof(struct dm_ioctl, diskseq_high) == offsetof(struct dm_ioctl, data) + 3);
 
 	if (*param->uuid) {
 		if (*param->name || param->dev) {
@@ -937,6 +943,27 @@ static struct hash_cell *__find_device_hash_cell(struct dm_ioctl *param)
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
@@ -2088,7 +2115,6 @@ static int validate_params(uint cmd, struct dm_ioctl *param,
 			   uint32_t ioctl_flags, uint32_t supported_flags)
 {
 	static_assert(__same_type(param->flags, supported_flags));
-	u64 zero = 0;
 
 	if (cmd == DM_DEV_CREATE_CMD) {
 		if (!*param->name) {
@@ -2112,14 +2138,24 @@ static int validate_params(uint cmd, struct dm_ioctl *param,
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
 	    !no_non_nul_after_nul(param->uuid, DM_UUID_LEN, cmd, "UUID")) {
 		return -EINVAL;
 	}
 
-	if (memcmp(param->data, &zero, sizeof(param->data)) != 0) {
-		DMERR("second padding field not zeroed in strict mode (cmd %u)", cmd);
+	/*
+	 * This also reads the NUL terminator of the UUID, but that has already been
+	 * checked to be zero by no_non_nul_after_nul().
+	 */
+	if (*(const u32 *)((const char *)param + sizeof(struct dm_ioctl) - 8) != 0) {
+		DMERR("padding field not zeroed in strict mode (cmd %u)", cmd);
 		return -EINVAL;
 	}
 
@@ -2129,12 +2165,6 @@ static int validate_params(uint cmd, struct dm_ioctl *param,
 		return -EINVAL;
 	}
 
-	if (param->padding) {
-		DMERR("padding not zeroed in strict mode (got %u, cmd %u)",
-		      param->padding, cmd);
-		return -EINVAL;
-	}
-
 	if (param->open_count != 0) {
 		DMERR("open_count not zeroed in strict mode (got %d, cmd %u)",
 		      param->open_count, cmd);
diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
index 81103e1dcdac3015204e9c05d73037191e965d59..5647b218f24b626f5c1cefe8bec18dc04373c3d0 100644
--- a/include/uapi/linux/dm-ioctl.h
+++ b/include/uapi/linux/dm-ioctl.h
@@ -136,16 +136,43 @@ struct dm_ioctl {
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
-	char data[7];		/* padding or data */
+	union {
+		/* valid if DM_VERSION_MAJOR is used */
+		char data[7];	/* padding or data */
+		/* valid if DM_VERSION_MAJOR_STRICT is used */
+		struct {
+			char _padding[3];	/* padding */
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
@@ -402,6 +429,6 @@ enum {
  * If DM_VERSION_MAJOR_STRICT is used, these flags are reserved and
  * must be zeroed.
  */
-#define DM_STRICT_ONLY_FLAGS ((__u32)0xFFF00004)
+#define DM_STRICT_ONLY_FLAGS ((__u32)(~((1UL << 19) - 1) | 1 << 9 | 1 << 7))
 
 #endif				/* _LINUX_DM_IOCTL_H */
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

