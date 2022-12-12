Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD9064AB7D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiLLXT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbiLLXTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:19:17 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA6A1C427
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:19:16 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bx10so13950058wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iT8jy7hXGuLdSI3WnW19MAFpxEEAB5GqxCDkyx7KpM4=;
        b=cUahQ40RcUDkGUzRGkxzHyHQU7mw0Dw/6lFS2ZdFZshj40n6//A1f7WpfMrYcEg8io
         qsVU3XNft8MalTR85qKf178Mn8jLwJATYgo3PfF4ir4BX5DLEpBsG1XwvpNsgZj3KW8B
         8zRTZLdvyYWmqNgOjqXfoXhIiG5sO9HSFsOxRur4kl41LxyIJAqG47zTpP/cOtK6KBzK
         Y2lHkzVBk+E8T7u1sRMQK4YYLd7hfdEfzEl4l1NWdLs8F2MbShL8WrdkyrOHIh6+LLx+
         vjXQwKAriwqXC7Sg+PscaDXfAkkqS8w2HsXC6KqMo8OdD67AbR6J3i1+EOo7mqbeJX7f
         jZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iT8jy7hXGuLdSI3WnW19MAFpxEEAB5GqxCDkyx7KpM4=;
        b=ILFzFmzOI9K/Ra5c0TyEbELTafef5jnSnSrDy3Ox2zx51TgnkbQxfXGpKIJUebJ6lj
         P+UUpsHko/mlGKpyQy1K4TvotZn1obYYcdeFIvDSXFxY3SV6jBZ7p8p4hP3yAlxdh3q/
         4fgN6NkO7mARW+aKGGdIetEGETdD8ItD4m4KM+BMo+7OplKAv9tfJOd86oEx/ElEO2wN
         REn9tlXB/Yza4NcDle5TIguP8Lee7ZksPAChPibOdRCfWVLV2J3IXAfHFy/iASXkXiXQ
         2U/Tvm2u+2b9LsDicfYUhNzfD9z8cHu4kMvKOR39pnTAiYAlSYfIc0Jpwk1KmO5L/Zrf
         sDpw==
X-Gm-Message-State: ANoB5plIc92gDzB44+6CiSB5uuh3B7PdwR79PYV1I4Xa3ptTkDSI9Src
        s4JvQTUdrb5qPOM3LygKAtY=
X-Google-Smtp-Source: AA0mqf5N4fUgLDL34+mtGBJX8uZcuRRYfH6gX+nt/hy2RO6nSEL62gRREzTDrpa19f0VQuGKBiWtwg==
X-Received: by 2002:a5d:5a8b:0:b0:250:90fa:3da with SMTP id bp11-20020a5d5a8b000000b0025090fa03damr2318521wrb.29.1670887154645;
        Mon, 12 Dec 2022 15:19:14 -0800 (PST)
Received: from localhost.localdomain (host-79-41-27-125.retail.telecomitalia.it. [79.41.27.125])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d6103000000b002423edd7e50sm9964304wrt.32.2022.12.12.15.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 15:19:13 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 1/3] fs/ufs: Use the offset_in_page() helper
Date:   Tue, 13 Dec 2022 00:19:04 +0100
Message-Id: <20221212231906.19424-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212231906.19424-1-fmdefrancesco@gmail.com>
References: <bpf@vger.kernel.org,linux-fsdevel@vger.kernel.org>
 <20221212231906.19424-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the offset_in_page() helper because it is more suitable than doing
explicit subtractions between pointers to directory entries and kernel
virtual addresses of mapped pages.

Cc: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/ufs/dir.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 391efaf1d528..69f78583c9c1 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -87,8 +87,7 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 		  struct page *page, struct inode *inode,
 		  bool update_times)
 {
-	loff_t pos = page_offset(page) +
-			(char *) de - (char *) page_address(page);
+	loff_t pos = page_offset(page) + offset_in_page(de);
 	unsigned len = fs16_to_cpu(dir->i_sb, de->d_reclen);
 	int err;
 
@@ -371,8 +370,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	return -EINVAL;
 
 got_it:
-	pos = page_offset(page) +
-			(char*)de - (char*)page_address(page);
+	pos = page_offset(page) + offset_in_page(de);
 	err = ufs_prepare_chunk(page, pos, rec_len);
 	if (err)
 		goto out_unlock;
@@ -497,8 +495,8 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 {
 	struct super_block *sb = inode->i_sb;
 	char *kaddr = page_address(page);
-	unsigned from = ((char*)dir - kaddr) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
-	unsigned to = ((char*)dir - kaddr) + fs16_to_cpu(sb, dir->d_reclen);
+	unsigned int from = offset_in_page(dir) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
+	unsigned int to = offset_in_page(dir) + fs16_to_cpu(sb, dir->d_reclen);
 	loff_t pos;
 	struct ufs_dir_entry *pde = NULL;
 	struct ufs_dir_entry *de = (struct ufs_dir_entry *) (kaddr + from);
@@ -522,7 +520,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 		de = ufs_next_entry(sb, de);
 	}
 	if (pde)
-		from = (char*)pde - (char*)page_address(page);
+		from = offset_in_page(pde);
 
 	pos = page_offset(page) + from;
 	lock_page(page);
-- 
2.38.1

