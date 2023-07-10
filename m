Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ECD74CC2B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGJFX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjGJFXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:23:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C44D7
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 22:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=b4wp0T94ukygtF3+ZxeOKxtu70Cl8ugqjCLk5Qld0yw=; b=YgFnHSjwCvvwxrl+b2hHUq+/rR
        DOzNFg59vjjd3TGu3ibWVTT0HIvzmzL6DTMPAQeNs+JIpr1RL3HFxRZVvnHPWKyg1i/4a1PlWvazI
        tLqZ4Hii7nKQ9u3KebBFgIPh4v2fXBMV3w6Hx9ky1sIVDEFiDbabDekAHCrMlOmWkZbdm+L89ElYK
        GAHGZcdhJ8fk4aNQ4k1Kb3o0zD+COciCHHx6muWLOYqXCKTcWWFxTVIUA3aqvanTWBiCwTc3Utahc
        qM4xf8XtYcsDhgEy4Ijrj1m7BKz7dpXRF5j/dHasfzNM9as3uUx7z/miORdutE15/8ddZGoDFcH5Z
        qkC/tK1w==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIjMr-00AT15-0I;
        Mon, 10 Jul 2023 05:23:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Yangtao Li <frank.li@vivo.com>,
        Konstantin Vyshetsky <vkon@google.com>
Subject: [PATCH] f2fs: fix spelling in ABI documentation
Date:   Sun,  9 Jul 2023 22:23:24 -0700
Message-ID: <20230710052324.2857-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems as identified by codespell.

Fixes: 9e615dbba41e ("f2fs: add missing description for ipu_policy node")
Fixes: b2e4a2b300e5 ("f2fs: expose discard related parameters in sysfs")
Fixes: 846ae671ad36 ("f2fs: expose extension_list sysfs entry")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: Yangtao Li <frank.li@vivo.com>
Cc: Konstantin Vyshetsky <vkon@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -- a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -54,9 +54,9 @@ Description:	Controls the in-place-updat
 		0x00  DISABLE         disable IPU(=default option in LFS mode)
 		0x01  FORCE           all the time
 		0x02  SSR             if SSR mode is activated
-		0x04  UTIL            if FS utilization is over threashold
+		0x04  UTIL            if FS utilization is over threshold
 		0x08  SSR_UTIL        if SSR mode is activated and FS utilization is over
-		                      threashold
+		                      threshold
 		0x10  FSYNC           activated in fsync path only for high performance
 		                      flash storages. IPU will be triggered only if the
 		                      # of dirty pages over min_fsync_blocks.
@@ -117,7 +117,7 @@ Date:		December 2021
 Contact:	"Konstantin Vyshetsky" <vkon@google.com>
 Description:	Controls the number of discards a thread will issue at a time.
 		Higher number will allow the discard thread to finish its work
-		faster, at the cost of higher latency for incomming I/O.
+		faster, at the cost of higher latency for incoming I/O.
 
 What:		/sys/fs/f2fs/<disk>/min_discard_issue_time
 Date:		December 2021
@@ -334,7 +334,7 @@ Description:	This indicates how many GC
 		state. 2048 trials is set by default.
 
 What:		/sys/fs/f2fs/<disk>/extension_list
-Date:		Feburary 2018
+Date:		February 2018
 Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:	Used to control configure extension list:
 		- Query: cat /sys/fs/f2fs/<disk>/extension_list
