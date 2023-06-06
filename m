Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9BB723879
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbjFFHMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbjFFHLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:11:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C97C10D4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=9v9tn6lsZgkyyA0di1tqJv1yUJFw46GloDfmVy8ibak=; b=yjkbyeg1LfxpvTDqKDQjrUYNeJ
        zYiloa2MPiHCBurdp6DvUxTkCjQTv0yReNu13sekASz+dkoO/wjcTxPLH4ypXRkzrEJZ7g1Ysyzhn
        oxnpN8Tdzk5iyA7xKZjqP4qbt87prevF+fHKFHUpn0yefP7/GYChSuc+29WLEsZGE3Irsvsv6eHdv
        BkBb/hSWUt78SgJZgw0BnxOxFJPidNCsdtdEhYpSGZjBDpSu/8tWtJPsvs8ns7eCH//9DjO9QJm43
        0Qwm//so7COWTCu5EDupcvmVJAV0L5k8WrVmcGkk6Nrk4d7l1iA8Hl1P421wGrWlcBy9GsZKbbMsB
        DKfL6a+g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6Qr0-000UFZ-1R;
        Tue, 06 Jun 2023 07:11:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
Subject: [PATCH] block: document the holder argument to blkdev_get_by_path
Date:   Tue,  6 Jun 2023 09:11:38 +0200
Message-Id: <20230606071138.147128-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bdev.c b/block/bdev.c
index 5c46ff10770638..4cebda15c55475 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -846,6 +846,7 @@ EXPORT_SYMBOL(blkdev_get_by_dev);
  * @path: path to the block device to open
  * @mode: FMODE_* mask
  * @holder: exclusive holder identifier
+ * @hops: holder operations
  *
  * Open the block device described by the device file at @path.  If @mode
  * includes %FMODE_EXCL, the block device is opened with exclusive access.
-- 
2.39.2

