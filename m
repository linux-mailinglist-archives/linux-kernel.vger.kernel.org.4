Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C65A68CBDB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjBGBTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjBGBTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:19:10 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C331E1CB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:19:09 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 8687F320090A;
        Mon,  6 Feb 2023 20:19:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 06 Feb 2023 20:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1675732748; x=1675819148; bh=AHlkp+EDvWtN8qpqD5t39xLQ6Cx8b01B9eJ
        Kee86CLk=; b=BXAZT/zFT53tlxNpcb5s5G19r/2/Mgmk01yp8uB4d8nS1LGG4yO
        88dWH29zbVkgXYdk6XroaPQrJpQwG0ztEcWMXEAsmKQiWMRFmVHBhzPEvRLvOVWw
        mo3nlyrQAwlw/c4vGF9vT5qMixrkfJgKrbMNg2iJXlQoxUCct6o5mtzTHdy7CHGP
        QievxJnXjiulPMzxyxkNIMYgeXp1dbQ0jfYPEaNE+rjy6I1vXhaZvXv5+J+/R2Qv
        DUZFxK1otx9fcdw0L/kMySfSveG+O8JJ9y1RoAW+wMphgLxQ+vKC66EdpVHG+bfV
        9UDOg9J9C0+x4wMLmVtfkOAaRsGO6ArxlLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1675732748; x=1675819148; bh=AHlkp+EDvWtN8
        qpqD5t39xLQ6Cx8b01B9eJKee86CLk=; b=GpPCG//MKEqygcMwbszcpqmGK/zNj
        zNF8Fdam9B1AgYI3TGjJKmtz/i4W5wI4+Gy6ypS3aMn/mIoRA3hlEdYwJG3wm7HQ
        TvLscSSA6nrLWwSXHR+JNggQpa3dbJ7QHgF23zb4hZx5lGk1YJfy06eq7zGRKX6E
        6BuTS4CKmu9n39QaVeTEvp3ezMrhKh8OFQlR3XAznKVNpbRhLQLXc4Hexa5yiZtu
        v8Nwt38grg9Pu/yHaPvz3LQLjelHd4UlPJKlNPeSDXQKAJz8TOmgtqSqHbFlz3/F
        2Yb/RMql7FsYhv38P549rP5BHeDazi58+d8R/e7hJ7G5Is6wciCDd5esQ==
X-ME-Sender: <xms:C6fhYyKANZxcwdzMoquLvp5HuQoTcGeVwKUaqM8E5AEZPSw8jKQ6xg>
    <xme:C6fhY6I2NHfR4ckPtnsr-CL3GXI6sOnhr-cGuTXJfNZaR7vLsKMKHdUawE8D3fWD3
    HX8ZT2B14m03zM>
X-ME-Received: <xmr:C6fhYysnCXuO5JruzFetT53xXoHLBa6l7hUCIT4BDNGrTaFKFtQiX4kIwl9rqAgpQC8MJQ8GXqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegjedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:DKfhY3a7nUY7Nz07xI6dzwJM4K10twQlOZEjzxiZJ1Luq21GSj5PsA>
    <xmx:DKfhY5aZoCh8vec3etP3cW2vUJcKNbaT9Qnb0Ad01VlbFoKM4uLlYg>
    <xmx:DKfhYzDFjMFiUYy0emaKEjItM8FbrenWPGDu1_dfnqpHcLikIPROcQ>
    <xmx:DKfhY9GgNpe75Gt8IAssC4jBlJSINL72LCITTJPLqsfV1WYh2saNzw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Feb 2023 20:19:07 -0500 (EST)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dm-thin: Allow specifying an offset
Date:   Mon,  6 Feb 2023 20:18:49 -0500
Message-Id: <20230207011849.1343-2-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207011849.1343-1-demi@invisiblethingslab.com>
References: <20230207011849.1343-1-demi@invisiblethingslab.com>
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

This allows exposing only part of a thin volume without having to layer
dm-linear.  One use-case is a hypervisor replacing a partition table.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/md/dm-thin.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index d85fdbd782ae5426003c99a4b4bf53818cc85efa..87f14933375b050a950a5f58e98c13b4d28f6af0 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -357,6 +357,7 @@ struct thin_c {
 	 */
 	refcount_t refcount;
 	struct completion can_destroy;
+	u64 offset;
 };
 
 /*----------------------------------------------------------------*/
@@ -1180,9 +1181,9 @@ static void process_prepared_discard_passdown_pt1(struct dm_thin_new_mapping *m)
 	discard_parent = bio_alloc(NULL, 1, 0, GFP_NOIO);
 	discard_parent->bi_end_io = passdown_endio;
 	discard_parent->bi_private = m;
- 	if (m->maybe_shared)
- 		passdown_double_checking_shared_status(m, discard_parent);
- 	else {
+	if (m->maybe_shared)
+		passdown_double_checking_shared_status(m, discard_parent);
+	else {
 		struct discard_op op;
 
 		begin_discard(&op, tc, discard_parent);
@@ -4149,7 +4150,7 @@ static int thin_ctr(struct dm_target *ti, unsigned argc, char **argv)
 
 	mutex_lock(&dm_thin_pool_table.mutex);
 
-	if (argc != 2 && argc != 3) {
+	if (argc < 2 || argc > 4) {
 		ti->error = "Invalid argument count";
 		r = -EINVAL;
 		goto out_unlock;
@@ -4168,7 +4169,8 @@ static int thin_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	bio_list_init(&tc->retry_on_resume_list);
 	tc->sort_bio_list = RB_ROOT;
 
-	if (argc == 3) {
+	/* Use "/" to indicate "no origin device" while providing an offset */
+	if (argc >= 3 && strcmp(argv[2], "/")) {
 		if (!strcmp(argv[0], argv[2])) {
 			ti->error = "Error setting origin device";
 			r = -EINVAL;
@@ -4196,6 +4198,23 @@ static int thin_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		goto bad_common;
 	}
 
+	tc->offset = 0;
+	if (argc > 3) {
+		sector_t sector_offset;
+
+		if (kstrtoull(argv[3], 10, &tc->offset)) {
+			ti->error = "Invalid offset";
+			r = -EINVAL;
+			goto bad_common;
+		}
+
+		if (check_add_overflow(tc->offset, ti->len, &sector_offset)) {
+			ti->error = "Offset + len overflows sector_t";
+			r = -EINVAL;
+			goto bad_common;
+		}
+	}
+
 	pool_md = dm_get_md(tc->pool_dev->bdev->bd_dev);
 	if (!pool_md) {
 		ti->error = "Couldn't get pool mapped device";
@@ -4285,8 +4304,9 @@ static int thin_ctr(struct dm_target *ti, unsigned argc, char **argv)
 
 static int thin_map(struct dm_target *ti, struct bio *bio)
 {
-	bio->bi_iter.bi_sector = dm_target_offset(ti, bio->bi_iter.bi_sector);
+	struct thin_c *tc = ti->private;
 
+	bio->bi_iter.bi_sector = dm_target_offset(ti, bio->bi_iter.bi_sector) + tc->offset;
 	return thin_bio_map(ti, bio);
 }
 
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

