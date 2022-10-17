Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5082760108A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJQNxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJQNxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:53:19 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A1F2A272
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666014783; bh=HybS8E0BeM5WMbvxAEhVcL9Zbg+CAlIyM/FdRQVadmA=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=V0nd46kDfvvNQW9/BYUiNaqzLisfmayMxJ32LVhGkuWQME6HvaNwszkOY5nGfFnex
         2R3rf7efqsVrSIei9H0jq6xG/cyJdtFG/RbBo+tmtLDGPUnJQHHeyD/NM2ktWD5qDs
         W/e50RHb6p11MoZPOxUvaHPKOGKE2L2ONJsswbfc=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.206]
        Mon, 17 Oct 2022 15:53:03 +0200 (CEST)
X-EA-Auth: WOVB4/nXVafQco/5wnIstFlXmW1pUWZgMbaqWNF0+qTbWPxDQEIECV7poO8kLqFZnvP2ycwsxNtRR8tRYgDBxGafyGWWdKHT
Date:   Mon, 17 Oct 2022 18:53:30 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: [PATCH 3/4] staging: r8188eu: remove {} for single statement blocks
Message-ID: <478d652b9f467d47685c1af72a876f34dd92710f.1666011479.git.drv@mailo.com>
References: <cover.1666011479.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666011479.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the Linux kernel coding-style guidelines, there is no need to
use {} for single statement blocks. Address following checkpatch script
complaint:
	WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 427da7e8ba4c..290affe50d0b 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -655,9 +655,8 @@ void *scdb_findEntry(struct adapter *priv, unsigned char *ip_addr)
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



