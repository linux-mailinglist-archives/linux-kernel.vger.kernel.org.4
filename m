Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554CC716ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjE3UdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjE3UdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:33:04 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0CF10C0;
        Tue, 30 May 2023 13:32:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 723F63200943;
        Tue, 30 May 2023 16:32:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 May 2023 16:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685478729; x=1685565129; bh=irr2EYlMc/
        ep40A7KRI/xWi2gREEnIhu2G5hCeO8CLU=; b=hURAEgyL29RZKJ+OYcTsErbDM/
        S1Ul5/NUJUPSUYPM5HMp20PXXk0gLiNmvxjoP1CB2io9qAj/T4B/cqHiaSjgGmi8
        0OUe8kLmaoL/YVBAxDpvilMIDBf/Y2qDnpqjA2O6Z1bm6pdtSzAuU8pbwRpb/64E
        t3nTRGtgH4YjIZNDyv9MRjk+yomLwVCQZeoxQogkrfQEBvmCXu28G+w8CDjq/W3w
        Mx9lG3fpLwdz3h+U33/HWIfxkCWVZsJU414cVmYbYoJ0vUv3StWVENMkJBzowoLX
        64xRWpZtQ+yZbqGZ94lNuiuB4ECWPLAOLRd5LUD0psVSjobpmBc7joc+izig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685478729; x=
        1685565129; bh=irr2EYlMc/ep40A7KRI/xWi2gREEnIhu2G5hCeO8CLU=; b=T
        fCfk4e0EN396eUbVOrH0ULWVryoukeqNEcqlz5QS2HXpBrwM99heFQhEMM352iV6
        XAioIqwlM6bC2bcJ15QZDtZssrnTAGcrNi3nu0JQPPTg/gHaMcm2YXhbjbcvIdQQ
        4+3ZjJ25Umxss9+sYsD2GfoZvAZN93/LREI/kYsX68VNvJdeBwv4W88M+K8GvrLk
        GhCudBNacqw+ctxx40im2bofmCkHltz0hoFc6VCGvIwgHePd+PRtAT6qflQL54sH
        rbfRPUaLSDzs1SnGq04bsIi17Eg2y8geLVB1gOhZF3+sb+8P2bG2PY/EzAnSWset
        u/evqcp9ruAl8Jc+bKtNg==
X-ME-Sender: <xms:SF12ZBfctJ2d2A3-iQ6vuwFvKc-UzF9BWiLn3tPIBEP1uqJV2EZD2Q>
    <xme:SF12ZPN76MIg5Z3ePhg_4ZPlgtRhapc1-gsYCO9FC46owA3180B5iHdYrNAPo62vN
    oWvwplncvHil8w>
X-ME-Received: <xmr:SF12ZKhwvdGkK2LUyW4IwEmdeVTIPWynVGVi5FIQTnBHOzVXFjkt47FA_H9DtJrKuR6TbZ-by4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:SF12ZK9To1BBIlpSkbrdLxqawBipD57OWmcgw7ISpIx8hEI3IQzMnw>
    <xmx:SF12ZNufUTatZ7nDNjzUx7u7Yl5dj5WRNOF-DD4z9BYxoBkagB6b1w>
    <xmx:SF12ZJFuKj8OnPlsEzvYl9HNQDX1s7aNCelS_9YCw0_fh0PGW-LdEQ>
    <xmx:SV12ZO_ohIr6Yj_olom9PICipQajdyzC4FPnRS3TPpiafB-36ZwAww>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 16:32:08 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v2 12/16] device-mapper: inform caller about already-existing device
Date:   Tue, 30 May 2023 16:31:12 -0400
Message-Id: <20230530203116.2008-13-demi@invisiblethingslab.com>
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

Not only is this helpful for debugging, it also saves the caller an
ioctl in the case where a device should be used if it exists or created
otherwise.  To ensure existing userspace is not broken, this feature is
only enabled in strict mode.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/md/dm-ioctl.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 17ece816d490b6c40d019da131ade44c9a201dab..44425093d3b908abf80e05e1fc99a26b17e18a42 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -256,11 +256,13 @@ static void free_cell(struct hash_cell *hc)
 	}
 }
 
+static void __dev_status(struct mapped_device *md, struct dm_ioctl *param);
+
 /*
  * The kdev_t and uuid of a device can never change once it is
  * initially inserted.
  */
-static int dm_hash_insert(const char *name, const char *uuid, struct mapped_device *md)
+static int dm_hash_insert(const char *name, const char *uuid, struct mapped_device *md, struct dm_ioctl *param)
 {
 	struct hash_cell *cell, *hc;
 
@@ -277,6 +279,8 @@ static int dm_hash_insert(const char *name, const char *uuid, struct mapped_devi
 	down_write(&_hash_lock);
 	hc = __get_name_cell(name);
 	if (hc) {
+		if (param)
+			__dev_status(hc->md, param);
 		dm_put(hc->md);
 		goto bad;
 	}
@@ -287,6 +291,8 @@ static int dm_hash_insert(const char *name, const char *uuid, struct mapped_devi
 		hc = __get_uuid_cell(uuid);
 		if (hc) {
 			__unlink_name(cell);
+			if (param)
+				__dev_status(hc->md, param);
 			dm_put(hc->md);
 			goto bad;
 		}
@@ -901,12 +907,14 @@ static int dev_create(struct file *filp, struct dm_ioctl *param, size_t param_si
 		m = MINOR(huge_decode_dev(param->dev));
 
 	r = dm_create(m, &md, param->flags & DM_DISABLE_UEVENTS_FLAG);
-	if (r)
+	if (r) {
+		DMERR("Could not create device-mapper device");
 		return r;
+	}
 
 	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
 
-	r = dm_hash_insert(param->name, *param->uuid ? param->uuid : NULL, md);
+	r = dm_hash_insert(param->name, *param->uuid ? param->uuid : NULL, md, param);
 	if (r) {
 		dm_put(md);
 		dm_destroy(md);
@@ -2269,7 +2277,6 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
 		goto out;
 	/* This XOR keeps only the flags validate_params has changed. */
 	old_flags ^= param->flags;
-
 	param->data_size = sloppy_checks(param) ? offsetof(struct dm_ioctl, data) : sizeof(struct dm_ioctl);
 	r = fn(file, param, input_param_size);
 
@@ -2284,9 +2291,14 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
 	param->flags |= old_flags;
 
 	/*
-	 * Copy the results back to userland.
+	 * Copy the results back to userland if either:
+	 *
+	 * - The ioctl succeeded.
+	 * - The ioctl is DM_DEV_CREATE, the return value is -EBUSY,
+	 *   and strict parameter checking is enabled.
 	 */
-	if (!r && copy_to_user(user, param, param->data_size))
+	if ((!r || (!sloppy_checks(param) && cmd == DM_DEV_CREATE_CMD && r == -EBUSY)) &&
+	    copy_to_user(user, param, param->data_size))
 		r = -EFAULT;
 
 out:
@@ -2465,7 +2477,7 @@ int __init dm_early_create(struct dm_ioctl *dmi,
 		return r;
 
 	/* hash insert */
-	r = dm_hash_insert(dmi->name, *dmi->uuid ? dmi->uuid : NULL, md);
+	r = dm_hash_insert(dmi->name, *dmi->uuid ? dmi->uuid : NULL, md, NULL);
 	if (r)
 		goto err_destroy_dm;
 
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

