Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8BB65B9AC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 04:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjACD2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 22:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACD2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 22:28:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F742BDD;
        Mon,  2 Jan 2023 19:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ux9UnHOgyeIy1oLWAlSjkONnvKezh1R0/E+bBd7rlO8=; b=PqjVZgWZAGt+ihvnPlJpDTJnMA
        6o3UcuSpkL2m6EfFdBRj9hcDVvNEK5dycLHKfMNGlJvcekxRgq760Ef4DBUZALijaJ4lUVBLWfbep
        QRoc73NuXAfsfHb7PO+OQ/qigHFoCX14sK7fTSj4HG2Zzf8E/m4Fpt1Uk5XhJjhg9/LadjhAdJUIT
        Xo+UiIZUGXZQ+T9Vo4MWR/5LqAcGMBHX4U8ZC83m6qAuA3vqn4II6LCDH+QfiEwatC9+dP92kbO3Y
        +1/VKPBpLXinufJzQzFnNxzwmJF3xVyDeDB9rn8ExxvkePjq/nVrBESJfJgir4u0GYcqnfe30XeaC
        QVnU/N9g==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCXyl-00G5RC-1M; Tue, 03 Jan 2023 03:28:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH] PM: hibernate: swap: don't use /** for non-kernel-doc comments
Date:   Mon,  2 Jan 2023 19:28:40 -0800
Message-Id: <20230103032840.12265-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel-doc complains about multiple occurrences of "/**" being used
for something that is not a kernel-doc comment, so change all of these
to just use "/*" comment style.

The warning message for all of these is:

FILE:LINE: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

kernel/power/swap.c:585: warning: ...
Structure used for CRC32.
kernel/power/swap.c:600: warning: ...
 * CRC32 update function that runs in its own thread.
kernel/power/swap.c:627: warning: ...
 * Structure used for LZO data compression.
kernel/power/swap.c:644: warning: ...
 * Compression function that runs in its own thread.
kernel/power/swap.c:952: warning: ...
 *      The following functions allow us to read data using a swap map
kernel/power/swap.c:1111: warning: ...
 * Structure used for LZO data decompression.
kernel/power/swap.c:1127: warning: ...
 * Decompression function that runs in its own thread.

Also correct one spello/typo.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
---
 kernel/power/swap.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff -- a/kernel/power/swap.c b/kernel/power/swap.c
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -581,7 +581,7 @@ static int save_image(struct swap_map_ha
 	return ret;
 }
 
-/**
+/*
  * Structure used for CRC32.
  */
 struct crc_data {
@@ -596,7 +596,7 @@ struct crc_data {
 	unsigned char *unc[LZO_THREADS];          /* uncompressed data */
 };
 
-/**
+/*
  * CRC32 update function that runs in its own thread.
  */
 static int crc32_threadfn(void *data)
@@ -623,7 +623,7 @@ static int crc32_threadfn(void *data)
 	}
 	return 0;
 }
-/**
+/*
  * Structure used for LZO data compression.
  */
 struct cmp_data {
@@ -640,7 +640,7 @@ struct cmp_data {
 	unsigned char wrk[LZO1X_1_MEM_COMPRESS];  /* compression workspace */
 };
 
-/**
+/*
  * Compression function that runs in its own thread.
  */
 static int lzo_compress_threadfn(void *data)
@@ -948,9 +948,9 @@ out_finish:
 	return error;
 }
 
-/**
+/*
  *	The following functions allow us to read data using a swap map
- *	in a file-alike way
+ *	in a file-like way.
  */
 
 static void release_swap_reader(struct swap_map_handle *handle)
@@ -1107,7 +1107,7 @@ static int load_image(struct swap_map_ha
 	return ret;
 }
 
-/**
+/*
  * Structure used for LZO data decompression.
  */
 struct dec_data {
@@ -1123,7 +1123,7 @@ struct dec_data {
 	unsigned char cmp[LZO_CMP_SIZE];          /* compressed buffer */
 };
 
-/**
+/*
  * Decompression function that runs in its own thread.
  */
 static int lzo_decompress_threadfn(void *data)
