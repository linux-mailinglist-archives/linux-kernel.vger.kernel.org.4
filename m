Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939AC67A103
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjAXSQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjAXSQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:16:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830974C6F1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1PL/qo7vlEp7VVnYAZKvGhXbnLuqJa1k+jhaTF5uK/M=; b=0cLuNm/sDhq/MS4cHvb7nBv0T/
        txIpeSpLJZ5dtnJCFQJ7T19OEJKI55EV5WCMej0WwADtO5fW5HEoKS6Ol0rXJcIJP65VoFvKHKLCg
        aseRzw+2ZVyRvySW4xaTqGDwVB6PEC1fVDHVRW/BESDx6HdDmH0TzOdC+0b8Wl0QyeTrWFpibuDt2
        C/qLINTDp1YHJD7xTb+G8Et9zgdXQJMsebFwoYcZnrwEBEOxVMyYS9RWMdcsv6sbg8A/KzxZP9Gmw
        OPzz3ZaQ1Sz6JxxO5EqWmzH4VSnvO7N3Q1cHBqZHFv+biRa8Ot8cpuDbh6Gw/FcPm3bPzzsKesgnc
        Fqvk4CpQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKNqZ-004vYO-33; Tue, 24 Jan 2023 18:16:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] freevxfs: Kconfig: fix spelling
Date:   Tue, 24 Jan 2023 10:16:38 -0800
Message-Id: <20230124181638.15604-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
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

Fix a spello in freevxfs Kconfig.
(reported by codespell)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/freevxfs/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/fs/freevxfs/Kconfig b/fs/freevxfs/Kconfig
--- a/fs/freevxfs/Kconfig
+++ b/fs/freevxfs/Kconfig
@@ -8,7 +8,7 @@ config VXFS_FS
 	  of SCO UnixWare (and possibly others) and optionally available
 	  for Sunsoft Solaris, HP-UX and many other operating systems. However
 	  these particular OS implementations of vxfs may differ in on-disk
-	  data endianess and/or superblock offset. The vxfs module has been
+	  data endianness and/or superblock offset. The vxfs module has been
 	  tested with SCO UnixWare and HP-UX B.10.20 (pa-risc 1.1 arch.)
 	  Currently only readonly access is supported and VxFX versions
 	  2, 3 and 4. Tests were performed with HP-UX VxFS version 3.
