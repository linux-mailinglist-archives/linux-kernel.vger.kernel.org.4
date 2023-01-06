Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4381D65FC61
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 08:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjAFH7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 02:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjAFH7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 02:59:24 -0500
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643837817F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 23:59:23 -0800 (PST)
X-UUID: 3303638f121940a8991f8522d2b9de13-20230106
X-CPASD-INFO: c60b00a0911e4203b017e21d84c564d9@rIZqgl1ij2BlUXOxg3V7bYJhYWeVXlG
        zem6DZWRkkFmVhH5xTV5nX1V9gnNXZF5dXFV3dnBQYmBhXVJ3i3-XblBgXoZgUZB3snhqgmBekQ==
X-CLOUD-ID: c60b00a0911e4203b017e21d84c564d9
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:185.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:65.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5.
        0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-5
        ,AUF:1,DUF:11766,ACD:194,DCD:194,SL:0,EISP:0,AG:0,CFC:0.648,CFSR:0.049,UAT:0,
        RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0
        ,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 3303638f121940a8991f8522d2b9de13-20230106
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 3303638f121940a8991f8522d2b9de13-20230106
X-User: oushixiong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <oushixiong@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 260326710; Fri, 06 Jan 2023 15:59:22 +0800
From:   oushixiong <oushixiong@kylinos.cn>
To:     David Howells <dhowells@redhat.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        oushixiong <oushixiong@kylinos.cn>, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] afs: fix a compilation issue
Date:   Fri,  6 Jan 2023 15:59:17 +0800
Message-Id: <20230106075917.1310103-1-oushixiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix a compilation issue:
error: no return statement in function returning non-void

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: oushixiong <oushixiong@kylinos.cn>
---
 fs/afs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index b7c1f8c84b38..0522fb61b929 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -49,6 +49,7 @@ static bool afs_dir_dirty_folio(struct address_space *mapping,
 		struct folio *folio)
 {
 	BUG(); /* This should never happen. */
+	return false;
 }
 
 const struct file_operations afs_dir_file_operations = {
-- 
2.25.1

