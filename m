Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD72605915
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJTHyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiJTHyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:54:31 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5842B260B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666252447; bh=GOHbeyhbpiWqUIeLgoO3djV5sPwClY/EXzZLrrc0xgI=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=Q+uXmpkedC+0AAd9mJ0G79pngGlKQwiIkaAzEkYVSEwQ8TuKCeP/1LsK/TzbXauSk
         0SJYVyrnNtI84JTYdyEMeGs38LSZqyoJlbR8f+cfLdYp6JT/cUk2XlysYkZhC+2qV1
         Tmjix8qcWtA4fTn7WMYlB39xZqIvm5nvhwc3iE5U=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.206]
        Thu, 20 Oct 2022 09:54:07 +0200 (CEST)
X-EA-Auth: lBtzwUmq7xiKtOzyvHN69sq3v1ryWUyhapouZYaD82HQ6FHSZOZkFlSjW6wztT01LluNiNa6J2ce0Io+iiJpDuLvD0DLFBJR
Date:   Thu, 20 Oct 2022 13:24:03 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: [PATCH v3 03/10] staging: r8188eu: remove {} for single statement
 blocks
Message-ID: <0e18149144533a749e30d97b0051cff384016cf1.1666249716.git.drv@mailo.com>
References: <cover.1666249715.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666249715.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the Linux kernel coding-style guidelines, there is no need to
use {} for single statement blocks. Issue flagged by checkpatch script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v3:
   -- None.

Changes in v1 [actually v2]:
   1. Improve patch description language to make it simpler. Feedback received
      from julia.lawall@inria.fr

 drivers/staging/r8188eu/core/rtw_br_ext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 8b1c9fdf6ed2..14797c2d6d76 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -652,9 +652,8 @@ void *scdb_findEntry(struct adapter *priv, unsigned char *ip_addr)
 	hash = __nat25_network_hash(network_addr);
 	db = priv->nethash[hash];
 	while (db) {
-		if (!memcmp(db->networkAddr, network_addr, MAX_NETWORK_ADDR_LEN)) {
+		if (!memcmp(db->networkAddr, network_addr, MAX_NETWORK_ADDR_LEN))
 			return (void *)db;
-		}

 		db = db->next_hash;
 	}
--
2.30.2



