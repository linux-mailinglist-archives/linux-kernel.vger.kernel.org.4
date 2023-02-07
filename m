Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AF268D4F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjBGK6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjBGK6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:58:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EE739CC7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:58:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D2DDA2094E;
        Tue,  7 Feb 2023 10:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675767486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S52gvDVDpuxXjvCZBUSuvNe2DoZ5QUEdbyRGbf0sq4c=;
        b=G9FxuYjyYcprbVyHfNWEVPVS//PziFvxXHGtlbahZd6YiN8UiYIY31GjJMCwzbcTDLG0ra
        ZwvVGkdVfj59zUx0PsIg0/7tDyvFkhMbmg5HFezizwvOVy2t8PGi3715zVRmw+H8qwFzM8
        uUJSVOt2/2/Gi2G7CdTnpYgF3aOX+zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675767486;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S52gvDVDpuxXjvCZBUSuvNe2DoZ5QUEdbyRGbf0sq4c=;
        b=n+uZSVGeOk0e0iJGUD5sJcavzgWY24pEpeUcdwvDbC+i506cjKruZYzruFlk+9ErA8kk63
        lTcN4J89Z8qL5SAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C448213467;
        Tue,  7 Feb 2023 10:58:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lEjgL74u4mOXMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 07 Feb 2023 10:58:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2F0CBA06D5; Tue,  7 Feb 2023 11:58:06 +0100 (CET)
Date:   Tue, 7 Feb 2023 11:58:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Vladislav Efanov <VEfanov@ispras.ru>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] udf: Check consistency of Space Bitmap Descriptor
Message-ID: <20230207105806.2dutvnknkmnsh2jw@quack3>
References: <20230124084303.pn7glett53qh6pcp@quack3>
 <20230202140456.1908875-1-VEfanov@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="c7cwgdf5kbfqcbkh"
Content-Disposition: inline
In-Reply-To: <20230202140456.1908875-1-VEfanov@ispras.ru>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c7cwgdf5kbfqcbkh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 02-02-23 17:04:56, Vladislav Efanov wrote:
> Bits, which are related to Bitmap Descriptor logical blocks,
> are not reset when buffer headers are allocated for them. As the
> result, these logical blocks can be treated as free and
> be used for other blocks.This can cause usage of one buffer header
> for several types of data. UDF issues WARNING in this situation:
> 
> WARNING: CPU: 0 PID: 2703 at fs/udf/inode.c:2014
>   __udf_add_aext+0x685/0x7d0 fs/udf/inode.c:2014
> 
> RIP: 0010:__udf_add_aext+0x685/0x7d0 fs/udf/inode.c:2014
> Call Trace:
>  udf_setup_indirect_aext+0x573/0x880 fs/udf/inode.c:1980
>  udf_add_aext+0x208/0x2e0 fs/udf/inode.c:2067
>  udf_insert_aext fs/udf/inode.c:2233 [inline]
>  udf_update_extents fs/udf/inode.c:1181 [inline]
>  inode_getblk+0x1981/0x3b70 fs/udf/inode.c:885
> 
> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
> ---
> v2: Do not clear bits related to Bitmap Descriptor logical blocks,
> but return -EFSCORRUPTED error instead.
>  fs/udf/balloc.c  | 24 ++++++++++++++++++++++++
>  fs/udf/udfdecl.h |  1 +
>  2 files changed, 25 insertions(+)

Thanks for the fix!

>  	bitmap->s_block_bitmap[bitmap_nr] = bh;
> +	/* Check consistency of Space Bitmap buffer. */
> +	if (bh) {
> +		max_bits_others = sb->s_blocksize * 8;
> +		max_bits_1st = max_bits_others - (sizeof(struct spaceBitmapDesc) << 3);
> +		rest_bits = (bitmap->s_nr_groups > max_bits_1st) ?
> +					bitmap->s_nr_groups - max_bits_1st : 0;
> +		if (!bitmap_nr)
> +			max_bits = min(max_bits_1st, bitmap->s_nr_groups);
> +		else if (bitmap_nr < rest_bits / max_bits_others + 1)
> +			max_bits = max_bits_others;

So this should be using DIV_ROUND_UP() instead of plain division and + 1
AFAICT. Anyway, I've somewhat simplified these conditions to make things a
bit more obvious and applied your patch. The result is attached for your
reference.

> +		else if (bitmap_nr == rest_bits / max_bits_others + 1)
> +			max_bits = rest_bits % max_bits_others;
> +		for (i = 0; i < max_bits; i++) {
> +			if (udf_test_bit(i + (bitmap_nr ? 0 :
> +				(sizeof(struct spaceBitmapDesc) << 3)),
> +				 bh->b_data))
> +				return -EFSCORRUPTED;
> +		}
> +	}


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--c7cwgdf5kbfqcbkh
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-udf-Check-consistency-of-Space-Bitmap-Descriptor.patch"

From 1e0d4adf17e7ef03281d7b16555e7c1508c8ed2d Mon Sep 17 00:00:00 2001
From: Vladislav Efanov <VEfanov@ispras.ru>
Date: Thu, 2 Feb 2023 17:04:56 +0300
Subject: [PATCH] udf: Check consistency of Space Bitmap Descriptor

Bits, which are related to Bitmap Descriptor logical blocks,
are not reset when buffer headers are allocated for them. As the
result, these logical blocks can be treated as free and
be used for other blocks.This can cause usage of one buffer header
for several types of data. UDF issues WARNING in this situation:

WARNING: CPU: 0 PID: 2703 at fs/udf/inode.c:2014
  __udf_add_aext+0x685/0x7d0 fs/udf/inode.c:2014

RIP: 0010:__udf_add_aext+0x685/0x7d0 fs/udf/inode.c:2014
Call Trace:
 udf_setup_indirect_aext+0x573/0x880 fs/udf/inode.c:1980
 udf_add_aext+0x208/0x2e0 fs/udf/inode.c:2067
 udf_insert_aext fs/udf/inode.c:2233 [inline]
 udf_update_extents fs/udf/inode.c:1181 [inline]
 inode_getblk+0x1981/0x3b70 fs/udf/inode.c:885

Found by Linux Verification Center (linuxtesting.org) with syzkaller.

[JK: Somewhat cleaned up the boundary checks]

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/balloc.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index cdf90928b7f2..14b9db4c80f0 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -36,18 +36,41 @@ static int read_block_bitmap(struct super_block *sb,
 			     unsigned long bitmap_nr)
 {
 	struct buffer_head *bh = NULL;
-	int retval = 0;
+	int i;
+	int max_bits, off, count;
 	struct kernel_lb_addr loc;
 
 	loc.logicalBlockNum = bitmap->s_extPosition;
 	loc.partitionReferenceNum = UDF_SB(sb)->s_partition;
 
 	bh = sb_bread(sb, udf_get_lb_pblock(sb, &loc, block));
+	bitmap->s_block_bitmap[bitmap_nr] = bh;
 	if (!bh)
-		retval = -EIO;
+		return -EIO;
 
-	bitmap->s_block_bitmap[bitmap_nr] = bh;
-	return retval;
+	/* Check consistency of Space Bitmap buffer. */
+	max_bits = sb->s_blocksize * 8;
+	if (!bitmap_nr) {
+		off = sizeof(struct spaceBitmapDesc) << 3;
+		count = min(max_bits - off, bitmap->s_nr_groups);
+	} else {
+		/*
+		 * Rough check if bitmap number is too big to have any bitmap
+ 		 * blocks reserved.
+		 */
+		if (bitmap_nr >
+		    (bitmap->s_nr_groups >> (sb->s_blocksize_bits + 3)) + 2)
+			return 0;
+		off = 0;
+		count = bitmap->s_nr_groups - bitmap_nr * max_bits +
+				(sizeof(struct spaceBitmapDesc) << 3);
+		count = min(count, max_bits);
+	}
+
+	for (i = 0; i < count; i++)
+		if (udf_test_bit(i + off, bh->b_data))
+			return -EFSCORRUPTED;
+	return 0;
 }
 
 static int __load_block_bitmap(struct super_block *sb,
-- 
2.35.3


--c7cwgdf5kbfqcbkh--
