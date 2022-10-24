Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73FB60C071
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiJYBGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiJYBGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:06:24 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2881F9F9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666614437; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=mgQv2HB07GEWmnV7TDOi5p+86A/v/ojQ3MlloAg9CpHVbE2WMwkmfH/m9v1Csa2CNz2UYUTAdMXiF7UXVwWkZHFmaaszVh3WRa7tAukIA/aUUsPut7z+uscKAf3hGXbBGiv1CM088Vk5cX0r4jf6PSGxs5U3N+tcAZsgzVZEYLU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666614437; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=5SliVUXs1lS/C+SctY2FnwUUgYlD8yyTbVu9DxM5Z6Y=; 
        b=dPLyQ6T72btWJ+6i4o9UooQpTHOYKwDmfuUDtFf34NDdzi95yRZlyzQdp+1ypx18VBMv5dGis0WVsDfYmFqdUeKevYUYJt6vxVquM+Ox+v5vUor7eSfcwfpwP2aqfTcHTJmK1Af3OzR7FcBkVTcH3/J6PbQeSbVKofY4i1zkT5k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666614437;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=5SliVUXs1lS/C+SctY2FnwUUgYlD8yyTbVu9DxM5Z6Y=;
        b=Vq3TSq0D7R5X4l3Z5AP5aqvaEJLelQwCR7sgPqS5v0GU3nAo/SDbmj4QevlhSqRV
        9+AvStK5MxsF2cjyJmHk8B9iuZb5oPb/dNDNAVV5HCKG2v/cyRwQcUWD1GK8Z0zpSk1
        4FZ5InRgjSF6kKs/Frfk1WiXGWRaO7xXOGBqpfiU=
Received: from plymouth (103.47.132.43 [103.47.132.43]) by mx.zohomail.com
        with SMTPS id 1666614436368274.7867667590755; Mon, 24 Oct 2022 05:27:16 -0700 (PDT)
Date:   Mon, 24 Oct 2022 19:26:59 +0700
From:   Aaron Lawrence <t4rmin@zohomail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] Staging: rtl8192e: rtllib_tx: fixed alignment matching
 open parenthesis
Message-ID: <b9a984cf481018a8ef61e4a579cb307eaf1bdc56.1666612946.git.t4rmin@zohomail.com>
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

Aligned multiple statements to match the open parenthesis on the
line before it as per the Linux kernel coding-style regulations.
The issues were flagged by the checkpatch script.

Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index abb5b57d142b..38dfdcf99fec 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -290,7 +290,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 		return;
 	if (pHTInfo->bCurrentAMPDUEnable) {
 		if (!GetTs(ieee, (struct ts_common_info **)(&pTxTs), hdr->addr1,
-		    skb->priority, TX_DIR, true)) {
+			   skb->priority, TX_DIR, true)) {
 			netdev_info(ieee->dev, "%s: can't get TS\n", __func__);
 			return;
 		}
@@ -306,7 +306,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 			goto FORCED_AGG_SETTING;
 		} else if (!pTxTs->bUsingBa) {
 			if (SN_LESS(pTxTs->TxAdmittedBARecord.ba_start_seq_ctrl.field.seq_num,
-			   (pTxTs->TxCurSeq+1)%4096))
+				    (pTxTs->TxCurSeq+1)%4096))
 				pTxTs->bUsingBa = true;
 			else
 				goto FORCED_AGG_SETTING;
@@ -442,7 +442,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 			u8 HTOpMode = pHTInfo->current_op_mode;
 
 			if ((pHTInfo->bCurBW40MHz && (HTOpMode == 2 ||
-			     HTOpMode == 3)) ||
+						      HTOpMode == 3)) ||
 			     (!pHTInfo->bCurBW40MHz && HTOpMode == 3)) {
 				tcb_desc->rts_rate = MGN_24M;
 				tcb_desc->bRTSEnable = true;
@@ -501,7 +501,7 @@ static u16 rtllib_query_seqnum(struct rtllib_device *ieee, struct sk_buff *skb,
 		struct tx_ts_record *pTS = NULL;
 
 		if (!GetTs(ieee, (struct ts_common_info **)(&pTS), dst,
-		    skb->priority, TX_DIR, true))
+			   skb->priority, TX_DIR, true))
 			return 0;
 		seqnum = pTS->TxCurSeq;
 		pTS->TxCurSeq = (pTS->TxCurSeq+1)%4096;
@@ -618,7 +618,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 					udp = (struct udphdr *)((u8 *)ip +
 					      (ip->ihl << 2));
 					if (((((u8 *)udp)[1] == 68) &&
-					   (((u8 *)udp)[3] == 67)) ||
+					     (((u8 *)udp)[3] == 67)) ||
 					   ((((u8 *)udp)[1] == 67) &&
 					   (((u8 *)udp)[3] == 68))) {
 						bdhcp = true;
@@ -712,11 +712,11 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			/* in case we are a client verify acm is not set for this ac */
 			while (unlikely(ieee->wmm_acm & (0x01 << skb->priority))) {
 				netdev_info(ieee->dev, "skb->priority = %x\n",
-						skb->priority);
+					    skb->priority);
 				if (wme_downgrade_ac(skb))
 					break;
 				netdev_info(ieee->dev, "converted skb->priority = %x\n",
-					   skb->priority);
+					    skb->priority);
 			}
 
 			qos_ctl |= skb->priority;
@@ -813,7 +813,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			if ((qos_activated) && (!bIsMulticast)) {
 				frag_hdr->seq_ctl =
 					 cpu_to_le16(rtllib_query_seqnum(ieee, skb_frag,
-							     header.addr1));
+									 header.addr1));
 				frag_hdr->seq_ctl =
 					 cpu_to_le16(le16_to_cpu(frag_hdr->seq_ctl)<<4 | i);
 			} else {
-- 
2.38.1

