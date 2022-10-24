Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F91460C07F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJYBIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiJYBHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:07:44 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CFE2099B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666614377; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=l8sC9awmjCVI9v/FzKehK6+5fUvMJ7TiRufSoVUWNkEQzHI7wTsClkyBiHnhem1vBP2B5lL078Uisaam5r0+rVKvjUSQVygyYnYSCFsU061EdQ5wUEmOkfH+R8ApKKTxKrVeMQak2N1x2Xkrzgul1GrzXD5etc6WBfmfJVD6SFA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666614377; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=O/ZctZOp5DJEpxT2wHcKrtsZzcnD486kQRZL+x3bpaE=; 
        b=ZgDFvK+16CXhhjP2xaiFttVHzW1EQjCcSi99I5QaLKoAZLc/10wqqy7AvpMdt+lm5sSzqUsBDokJh/hsaCSZgsGNW1czcAyeOnqRzWRKbfLMq+AjUcUkTBFMmq58Dat9y78cmm293kethhHiM/JMbquLcncXsvGVN+AVPjwtR+c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666614377;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=O/ZctZOp5DJEpxT2wHcKrtsZzcnD486kQRZL+x3bpaE=;
        b=DAFQJxQrZf7ZyVl6Bx6sx9NVPm+TTkScSDTs6sFmPRRvU/EAegtKa1z2BuzmPnD2
        lMKAt5QlFIYbqQb3y1BxuOfeBdmEt0jeDy5DKDmY0hCir8d0fELVXW09VBJgwouy5vr
        uLoX9w+XNonUeekwTrw9pVlhNzqUeM1hPOJZKxWs=
Received: from plymouth (103.47.132.27 [103.47.132.27]) by mx.zohomail.com
        with SMTPS id 16666143750751016.0298904245373; Mon, 24 Oct 2022 05:26:15 -0700 (PDT)
Date:   Mon, 24 Oct 2022 19:26:07 +0700
From:   Aaron Lawrence <t4rmin@zohomail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Staging: rtl8192e: rtllib_tx: fixed multiple blank lines
Message-ID: <a3e044ff9e5b198af15ebc8b91fd048743881340.1666612946.git.t4rmin@zohomail.com>
References: <cover.1666612946.git.t4rmin@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666612946.git.t4rmin@zohomail.com>
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple blank lines are condensed into a single blank line as per
the Linux kernel coding-style regulations. The issues were flagged
by the checkpatch script.

Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index e307020580a0..abb5b57d142b 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -191,7 +191,6 @@ int rtllib_encrypt_fragment(struct rtllib_device *ieee, struct sk_buff *frag,
 	return 0;
 }
 
-
 void rtllib_txb_free(struct rtllib_txb *txb)
 {
 	if (unlikely(!txb))
@@ -475,7 +474,6 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 	tcb_desc->bRTSBW	= false;
 }
 
-
 static void rtllib_txrate_selectmode(struct rtllib_device *ieee,
 				     struct cb_desc *tcb_desc)
 {
@@ -582,7 +580,6 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 		goto success;
 	}
 
-
 	if (likely(ieee->raw_tx == 0)) {
 		if (unlikely(skb->len < SNAP_SIZE + sizeof(u16))) {
 			netdev_warn(ieee->dev, "skb too small (%d).\n",
@@ -895,7 +892,6 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 				tcb_desc->bTxDisableRateFallBack = 1;
 			}
 
-
 			tcb_desc->RATRIndex = 7;
 			tcb_desc->bTxUseDriverAssingedRate = 1;
 		} else {
@@ -920,7 +916,6 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 					tcb_desc->bTxDisableRateFallBack = 1;
 				}
 
-
 				tcb_desc->RATRIndex = 7;
 				tcb_desc->bTxUseDriverAssingedRate = 1;
 				tcb_desc->bdhcp = 1;
-- 
2.38.1

