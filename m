Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF63654E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbiLWJJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236165AbiLWJJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:09:05 -0500
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E86BC36C66;
        Fri, 23 Dec 2022 01:09:04 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id C628A1E80D9F;
        Fri, 23 Dec 2022 17:03:54 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DEiGMC8ZSAX4; Fri, 23 Dec 2022 17:03:52 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhoujie@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id E08471E80D96;
        Fri, 23 Dec 2022 17:03:51 +0800 (CST)
From:   Zhou jie <zhoujie@nfschina.com>
To:     mchehab@kernel.org, wangqing@vivo.com, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel.nfschina.com@lists.nfsmail.com,
        Zhou jie <zhoujie@nfschina.com>
Subject: [PATCH] radio/wl128x: remove unnecessary (void*) conversions
Date:   Fri, 23 Dec 2022 17:08:58 +0800
Message-Id: <20221223090858.9109-1-zhoujie@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The void * type pointer does not need to be cast.

Signed-off-by: Zhou jie <zhoujie@nfschina.com>
---
 drivers/media/radio/wl128x/fmdrv_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
index 8a316de70e6c..cbd49dff6d74 100644
--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -1442,7 +1442,7 @@ static long fm_st_receive(void *arg, struct sk_buff *skb)
 {
 	struct fmdev *fmdev;
 
-	fmdev = (struct fmdev *)arg;
+	fmdev = arg;
 
 	if (skb == NULL) {
 		fmerr("Invalid SKB received from ST\n");
-- 
2.18.2

