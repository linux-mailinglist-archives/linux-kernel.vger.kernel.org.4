Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764C4608542
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJVGrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJVGra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:47:30 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984842A686F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 23:47:28 -0700 (PDT)
X-QQ-mid: bizesmtp75t1666421232tpc6h6wr
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:47:11 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: 6ArnuSDJ+imHYHENxMzAz/e5e0MSyxAleQnz0MFlV97xLvydnBQUaOuoPlSkw
        sUDowsASjyZ65kiAN66/GrrPyKbePVYoQ5Os8ibGVtt/UKbp1EiJ4Lz0+iY1C1sU9GQ0aNo
        N6xUT5EOiS/To38vasA3mRgp5Dvlz0wP/GZ5rig6ZHQXt/QeK5vpqA6X0dbzdEQx1PAsPSq
        aXvSVdDda0aAR3a7cJw4m8djPGZPeMJJdn+1BDmmpi4FMVRYLNenHG+OUmFNXIvUlVrNUN6
        9KNFLoThdAy8EHsk0mlFxkPTUB34+HhO5Bb2aWea7AaOqA2BnmXU+RBHlWAxvnrrQ29IGGI
        91eaYe3Kx81juOW8+iLBS6MmzON16/LuPQEw7gW5I0u+WgxJys=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     dhowells@redhat.com, marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] fs/afs: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:47:04 +0800
Message-Id: <20221022064704.36326-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 fs/afs/flock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index c4210a3964d8..801fe305878f 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -152,7 +152,7 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
 }
 
 /*
- * Kill off all waiters in the the pending lock queue due to the vnode being
+ * Kill off all waiters in the pending lock queue due to the vnode being
  * deleted.
  */
 static void afs_kill_lockers_enoent(struct afs_vnode *vnode)
-- 
2.36.1

