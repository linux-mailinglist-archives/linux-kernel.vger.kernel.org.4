Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91F872F8A8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243872AbjFNJGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241554AbjFNJGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:06:17 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D96918E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:06:16 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qh00527KJzBQgnn
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:06:13 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686733573; x=1689325574; bh=77WYnPP9SBJKj7/by1xRn/9zhdv
        h9Iodss2P+zlBrJg=; b=lDCAmTV21kfYS8s/Yq9gQmK4WO6E+GC1UGoYa+H632g
        yyedOSCEYUwpL8C0BGtTk3JGf6IifIPrtEXgcRgeU+TnLxqHjnd4Bmce6tjLgpxR
        8L4+O1QiJTjl4ck4zQFD+NVhzHuC6N+2WDuLGO5UM5/4w+2gUCPNiQvgEnT+FSNr
        hj5115urciGgorC/67Awj47kVT1IMUhWdOqFbf2pCIHtnx+tVwuKJcj+eLnjV21R
        UdBohJLH9tzs4P8gcHBMfI2M0Y4SKNCFtb0bsWZiZzcbWLGtYoTXvSnk1+zTmaBP
        WxiM8ElV4nFHaiK4xElX29tjLE8aDxbnrLGv0gWwGAQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xV5dyNRxVG7Z for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 17:06:13 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qh0046lg0zBJJD0;
        Wed, 14 Jun 2023 17:06:12 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 17:06:12 +0800
From:   hexingwei001@208suo.com
To:     djwong@kernel.org, dchinner@redhat.com,
        allison.henderson@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] fs/xfs/libxfs/xfs_bmap.c: space required after that ','
 and spaces required around that '='
In-Reply-To: <20230614090248.90219-1-panzhiai@cdjrlc.com>
References: <20230614090248.90219-1-panzhiai@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <3d224c797c33a98a3d2d1d888d00cb0d@208suo.com>
X-Sender: hexingwei001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing spaces to clear checkpatch errors:

fs/xfs/libxfs/xfs_bmap.c:519: ERROR: space required after that ',' 
(ctx:VxV).
fs/xfs/libxfs/xfs_bmap.c:519: ERROR: space required after that ',' 
(ctx:VxV).
fs/xfs/libxfs/xfs_bmap.c:519: ERROR: space required after that ',' 
(ctx:VxV).
fs/xfs/libxfs/xfs_bmap.c:519: ERROR: space required after that ',' 
(ctx:VxV).
fs/xfs/libxfs/xfs_bmap.c:519: ERROR: space required after that ',' 
(ctx:VxV).
fs/xfs/libxfs/xfs_bmap.c:1421: ERROR: spaces required around that '=' 
(ctx:VxV).
fs/xfs/libxfs/xfs_bmap.c:1425: ERROR: spaces required around that '='  
(ctx:VxV).
fs/xfs/libxfs/xfs_bmap.c:1972: ERROR: spaces required around that '=' 
(ctx:VxV).
fs/xfs/libxfs/xfs_bmap.c:2499: ERROR: spaces required around that '=' 
(ctx:VxV).
fs/xfs/libxfs/xfs_bmap.c:2500: ERROR: spaces required around that '=' 
(ctx:VxV).
fs/xfs/libxfs/xfs_bmap.c:2648: ERROR: spaces required around that '=' 
(ctx:VxV).
fs/xfs/libxfs/xfs_bmap.c:3054: ERROR: space required after that ',' 
(ctx:VxV).
fs/xfs/libxfs/xfs_bmap.c:3089: ERROR: spaces required around that '=' 
(ctx:VxV).
fs/xfs/libxfs/xfs_bmap.c:3091: ERROR: spaces required around that '=' 
(ctx:VxV).
fs/xfs/libxfs/xfs_bmap.c:5012: ERROR: spaces required around that '=' 
(ctx:VxV).

Signed-off-by: Xingwei He <hexingwei001@208suo.com>
---
  fs/xfs/libxfs/xfs_bmap.c | 18 +++++++++---------
  1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 9cabcd3768e5..24fe1568c9d2 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -1418,11 +1418,11 @@ xfs_bmap_add_extent_delay_real(
      xfs_fileoff_t        new_endoff;    /* end offset of new entry */
      xfs_bmbt_irec_t        r[3];    /* neighbor extent entries */
                      /* left is 0, right is 1, prev is 2 */
-    int            rval= 0 ;    /* return value (logging flags) */
+    int            rval = 0 ;    /* return value (logging flags) */
      uint32_t        state = xfs_bmap_fork_to_state(whichfork);
      xfs_filblks_t        da_new; /* new count del alloc blocks used */
      xfs_filblks_t        da_old; /* old count del alloc blocks used */
-    xfs_filblks_t        temp= 0 ;    /* value for da_new calculations 
*/
+    xfs_filblks_t        temp = 0 ;    /* value for da_new calculations 
*/
      int            tmp_rval;    /* partial logging flags */
      struct xfs_bmbt_irec    old;

@@ -1969,7 +1969,7 @@ xfs_bmap_add_extent_unwritten_real(
      xfs_fileoff_t        new_endoff;    /* end offset of new entry */
      xfs_bmbt_irec_t        r[3];    /* neighbor extent entries */
                      /* left is 0, right is 1, prev is 2 */
-    int            rval= 0 ;    /* return value (logging flags) */
+    int            rval = 0 ;    /* return value (logging flags) */
      uint32_t        state = xfs_bmap_fork_to_state(whichfork);
      struct xfs_mount    *mp = ip->i_mount;
      struct xfs_bmbt_irec    old;
@@ -2496,8 +2496,8 @@ xfs_bmap_add_extent_hole_delay(
  {
      struct xfs_ifork    *ifp;    /* inode fork pointer */
      xfs_bmbt_irec_t        left;    /* left neighbor extent entry */
-    xfs_filblks_t        newlen= 0 ;    /* new indirect size */
-    xfs_filblks_t        oldlen= 0 ;    /* old indirect size */
+    xfs_filblks_t        newlen = 0 ;    /* new indirect size */
+    xfs_filblks_t        oldlen = 0 ;    /* old indirect size */
      xfs_bmbt_irec_t        right;    /* right neighbor extent entry */
      uint32_t        state = xfs_bmap_fork_to_state(whichfork);
      xfs_filblks_t        temp;     /* temp for indirect calculations */
@@ -2645,7 +2645,7 @@ xfs_bmap_add_extent_hole_real(
      int            i;    /* temp state */
      xfs_bmbt_irec_t        left;    /* left neighbor extent entry */
      xfs_bmbt_irec_t        right;    /* right neighbor extent entry */
-    int            rval= 0 ;    /* return value (logging flags) */
+    int            rval = 0 ;    /* return value (logging flags) */
      uint32_t        state = xfs_bmap_fork_to_state(whichfork);
      struct xfs_bmbt_irec    old;

@@ -3086,9 +3086,9 @@ xfs_bmap_adjacent(
       */
      else if (!ap->eof) {
          xfs_fsblock_t    gotbno;        /* right side block number */
-        xfs_fsblock_t    gotdiff= 0 ;    /* right side difference */
+        xfs_fsblock_t    gotdiff = 0 ;    /* right side difference */
          xfs_fsblock_t    prevbno;    /* left side block number */
-        xfs_fsblock_t    prevdiff= 0 ;    /* left side difference */
+        xfs_fsblock_t    prevdiff = 0 ;    /* left side difference */

          /*
           * If there's a previous (left) block, select a requested
@@ -5009,7 +5009,7 @@ xfs_bmap_del_extent_real(
      int            whichfork, /* data or attr fork */
      uint32_t        bflags)    /* bmapi flags */
  {
-    xfs_fsblock_t        del_endblock= 0;    /* first block past del */
+    xfs_fsblock_t        del_endblock = 0;    /* first block past del 
*/
      xfs_fileoff_t        del_endoff;    /* first offset past del */
      int            do_fx;    /* free extent at end of routine */
      int            error;    /* error return value */
