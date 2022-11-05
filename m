Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B34E61DBA9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiKEPb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiKEPbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:31:55 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D482FA180
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 08:31:52 -0700 (PDT)
X-QQ-mid: bizesmtp74t1667662306ts5cm2wq
Received: from localhost.localdomain ( [182.148.13.29])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Nov 2022 23:31:37 +0800 (CST)
X-QQ-SSF: 01000000002000D0E000B00A0000000
X-QQ-FEAT: LG+NUo/f6sG/IBwguO3kMFgA3MSXT0Wx0LQGJTp8HbtfaMzKSTalZL5XaoXH+
        TnXTLr5caQNFzKJfe29ea5KJ/Q+Bjrxfy73gILer/e5j2CsT4JqlLdjwGDmgQBAdgME2360
        p1QRlNS8zZhzkH9JXKkk6hu5d2NdSJl9yE1PLtBi44+y/iRLsVBMD+OmXCiK4SvKnrgDbHd
        fRyBC3qlaGRGk7DwtCihkpDNFItgiEb8JRIxXumDurDxZ6bBG/VHzJYXBfVqiFHCWjPMplC
        LqpBjiKNXO8crdG+oXccK4AYvBjGxkdLKMfh+R+IxWIDHc6iw5P1n0s7HoGHKvoulTj9WRc
        HpHxmI/oEfISUfnXBWtH8nymKt1C+B9OElXLMtptJ3/HJbYyYY=
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] ntfs: Remove unneeded semicolon
Date:   Sat,  5 Nov 2022 11:31:35 -0400
Message-Id: <20221105153135.5975-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unneeded semicolon after curly braces.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 fs/ntfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 001f4e053c85..6165fe7d0ac6 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1612,7 +1612,7 @@ static bool load_and_init_attrdef(ntfs_volume *vol)
 		memcpy((u8*)vol->attrdef + (index++ << PAGE_SHIFT),
 				page_address(page), size);
 		ntfs_unmap_page(page);
-	};
+	}
 	if (size == PAGE_SIZE) {
 		size = i_size & ~PAGE_MASK;
 		if (size)
@@ -1681,7 +1681,7 @@ static bool load_and_init_upcase(ntfs_volume *vol)
 		memcpy((char*)vol->upcase + (index++ << PAGE_SHIFT),
 				page_address(page), size);
 		ntfs_unmap_page(page);
-	};
+	}
 	if (size == PAGE_SIZE) {
 		size = i_size & ~PAGE_MASK;
 		if (size)
-- 
2.35.1

