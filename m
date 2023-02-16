Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E887698CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBPGbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBPGbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:31:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756313D094
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 22:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vaOelGrYOIfKvGKbHmzxTVGA7Wqk7L4b0gnvGkiXHHc=; b=yeCNwBn68wp235BwpRPYrLjNf8
        nxVe/+rIpKj9VcdbEBZlawVPdfDdB5dvPv3IakTDF30QVCzjGPATtOJDJEOHa09HW0T0ejwN3GC5d
        lragGwgyAKiXPyKRuUKGP9sr9NfjS2cnozItb9SL8IRqDelkW9YjQwPiKiUuiZ3AsGFYSDln8KQH5
        7fq44CjQ9ZuvHwRpN7SLspWBep5MUvav22ZcbLjj4RRNKoEcBX9LYUl2sV1NNy1iF+ztY/nXQDpaP
        KhUKU6VmlUgso6D0e12s49x16k1GPxmurco+8EVrDS7chDNYG6HC5ubyaC05Ue5NO6/xRC9AE19lD
        AXey7W3g==;
Received: from [2001:4bb8:181:6771:37af:42b9:3236:81df] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSXnU-008gYo-Ro; Thu, 16 Feb 2023 06:31:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     torvalds@linux-foundation.org, andy@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] stop mainaining UUID
Date:   Thu, 16 Feb 2023 07:31:10 +0100
Message-Id: <20230216063110.2152087-1-hch@lst.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uuid code is very low maintainance now that the major overhaul
has completed, and doesn't need it's own tree.  All the recent work
has been done by Andy who'd like to stay on as a reviewer without an
explicit tree.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 225c3ce347a217..6a47510d15920f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21818,11 +21818,9 @@ W:	http://en.wikipedia.org/wiki/Util-linux
 T:	git git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
 
 UUID HELPERS
-M:	Christoph Hellwig <hch@lst.de>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-T:	git git://git.infradead.org/users/hch/uuid.git
 F:	include/linux/uuid.h
 F:	include/uapi/linux/uuid.h
 F:	lib/test_uuid.c
-- 
2.39.1

