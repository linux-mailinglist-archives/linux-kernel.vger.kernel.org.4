Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920206D3557
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 05:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjDBDNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 23:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDBDNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 23:13:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2313A1B7DD
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 20:13:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u10so25029203plz.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 20:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680405183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WBn8FWyIBGPoaocuNnuzNDzQNus3aBXXJi3F94yzU7g=;
        b=dDbXy/ksBOsAuiljfaQBgfcBvYmVdwu2Pr1XaPN9vcLDju09h47KAhxxSFt9WUjzcc
         Ffcc7CatnyquBrd6kATdczwiHtzAKq3GQqAn0KHUvzc5YLeHTkL4bXv31iEv/CrJFUuJ
         N9/VLsdrngXMLtx6YA46/m4t3xyVZeHLgLR1kpleCVxKC+opblEDxcylieMPvuWaa0+h
         7lD61whHb6szJddnayZyQYEA9DhKK67Qi8Cbzn0ZGSuU+Y0L3MbFvpF5ERbr7oiS0lyj
         bqaUVT3fjpTj0lULhF9RTE6zRNgNCx+te1BITlDZa5dZrf6/WVDRA2tz9rv/wcVmCTSu
         mczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680405183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBn8FWyIBGPoaocuNnuzNDzQNus3aBXXJi3F94yzU7g=;
        b=0gG1bZoUg2IU9Xc2auVEQzeLwt6cX2kgSUO3IA750f72mT2yBRkyTa0/5kxQ61eCFS
         ZDjFT3r4y6ko7KfKwmtf0Rr4HjRjvxU8+lU7BXId1pIvWpGbKhNa5vMwnFbblXQqLaML
         v1p9t2yBdMNNrDWoHQFojH0YqlWi1paOJltb/TfDbMARhGtHDNxzdE1J6JFv37s1YueD
         4OJlxsOjTfAO85qEsodPtCMI40jAIHGbLkh5wBZ9u1hOq25x3KfiCBpVCF1v4BYI7zEa
         78tLSt/m5y/lKX0k2VL0I+oLAIDY9u6HZfMu2CSUBF1hF/ou3CuZhL9Ffm8WKDoWCyzC
         1qXw==
X-Gm-Message-State: AAQBX9dYclmZxgEW/NdnP7WzhysaM9VT6+3WTJ7jH5E0CVXF0V9CvLrd
        wUBS+zxJunDZmFVTB3fatjmpYEh8Ge0SpXGY
X-Google-Smtp-Source: AKy350aw4KcPF03eEMSTE5Kgg3lOoy2cfLY1pa/n1CEHAeEjLcZ9eOykVUDcpE63SYFq7F3Ac7WhMw==
X-Received: by 2002:a17:903:687:b0:19e:8688:86fe with SMTP id ki7-20020a170903068700b0019e868886femr29894686plb.42.1680405183454;
        Sat, 01 Apr 2023 20:13:03 -0700 (PDT)
Received: from DESKTOP-B5TBVBT.localdomain ([175.117.51.71])
        by smtp.gmail.com with ESMTPSA id x6-20020a1709028ec600b001a1ea1d6d65sm3974309plo.272.2023.04.01.20.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 20:13:02 -0700 (PDT)
From:   Yohan Joung <jyh429@gmail.com>
X-Google-Original-From: Yohan Joung <yohan.joung@sk.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yohan Joung <jyh429@gmail.com>,
        Yohan Joung <yohan.joung@sk.com>
Subject: [PATCH v2] f2fs: fix align check for npo2
Date:   Sun,  2 Apr 2023 12:12:59 +0900
Message-Id: <20230402031259.286-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yohan Joung <jyh429@gmail.com>

Fix alignment check to be correct in npo2 as well

Signed-off-by: Yohan Joung <yohan.joung@sk.com>
---
 fs/f2fs/segment.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 055e70e77aa2..c1525168f265 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1842,6 +1842,7 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 	sector_t sector, nr_sects;
 	block_t lblkstart = blkstart;
 	int devi = 0;
+	u64 remainder = 0;
 
 	if (f2fs_is_multi_device(sbi)) {
 		devi = f2fs_target_device_index(sbi, blkstart);
@@ -1857,9 +1858,9 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 	if (f2fs_blkz_is_seq(sbi, devi, blkstart)) {
 		sector = SECTOR_FROM_BLOCK(blkstart);
 		nr_sects = SECTOR_FROM_BLOCK(blklen);
+		div64_u64_rem(sector, bdev_zone_sectors(bdev), &remainder);
 
-		if (sector & (bdev_zone_sectors(bdev) - 1) ||
-				nr_sects != bdev_zone_sectors(bdev)) {
+		if (remainder || nr_sects != bdev_zone_sectors(bdev)) {
 			f2fs_err(sbi, "(%d) %s: Unaligned zone reset attempted (block %x + %x)",
 				 devi, sbi->s_ndevs ? FDEV(devi).path : "",
 				 blkstart, blklen);
-- 
2.25.1

