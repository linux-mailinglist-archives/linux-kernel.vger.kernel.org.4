Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE8660BCF0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiJXWBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiJXWA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:00:57 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56334C2CAE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666614489; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bCO05Frd3l1e7GFMj0QStWxMEIZ0L4MrT2j5UxWfTdfzpr5a9C/XjGmPhNDFSOQZca+zDu1ZrqlELF9qg5ZUi3zywXL4eu+A5TtXn8ELE8T5v53RVUuF6nl5/nga3zufjOjImC4HkXmXwQ5OXxMpCxvS7SNFyam23SDLEbWxECg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666614489; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=9FpZ4A5T7voqbOtb74gaWvMXsMoiVeckh6eEapcdOwU=; 
        b=PZNWBc9JFLzfHFbdpKwREoE6VSKVQiXuhTVr/PHXXv7z+Jiwn7n2D7JEf7NDeOi+MgKo6vGZOsTKHhRfGC6ezBDc1Y8hhBMi9HH+P37M1BwUjlvBhF/3GL4ZtS5jpgpjIxFa2SKiDpC1MlPVNyYMvomLxI4AM5xib0nV2RV3U08=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666614489;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=9FpZ4A5T7voqbOtb74gaWvMXsMoiVeckh6eEapcdOwU=;
        b=W1ykPqzAGRqfxLV2PBrSthno0U6ApUtPqg7cDRDiD51Ie8Bnxdzw3LmdeA9caYS1
        HfoRqlt5b74MTDBDMalQuWkpBMZ8lA7RyFrqPDBq0V5vuxLqgfeOgnevaFlvj3/KlgT
        02ftWHqw64jqlR2Xmlux+I1SSS5p+J6xxby5T2h4=
Received: from plymouth (103.47.132.32 [103.47.132.32]) by mx.zohomail.com
        with SMTPS id 1666614488843482.68623945604725; Mon, 24 Oct 2022 05:28:08 -0700 (PDT)
Date:   Mon, 24 Oct 2022 19:27:59 +0700
From:   Aaron Lawrence <t4rmin@zohomail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Staging: rtl8192e: rtllib_tx: added spaces around
 operators
Message-ID: <b8bf422436ff4b2d9b530c61ebf814582ab8836a.1666612946.git.t4rmin@zohomail.com>
References: <cover.1666612946.git.t4rmin@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666612946.git.t4rmin@zohomail.com>
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added multiple spaces around operators which needs it as per the
Linux kernel coding-style regulations. The issues were flagged by
the checkpatch script.

Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 38dfdcf99fec..fa998cd76917 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -306,7 +306,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 			goto FORCED_AGG_SETTING;
 		} else if (!pTxTs->bUsingBa) {
 			if (SN_LESS(pTxTs->TxAdmittedBARecord.ba_start_seq_ctrl.field.seq_num,
-				    (pTxTs->TxCurSeq+1)%4096))
+				    (pTxTs->TxCurSeq + 1) % 4096))
 				pTxTs->bUsingBa = true;
 			else
 				goto FORCED_AGG_SETTING;
@@ -403,7 +403,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 	if (tcb_desc->bBroadcast || tcb_desc->bMulticast)
 		return;
 
-	if (is_broadcast_ether_addr(skb->data+16))
+	if (is_broadcast_ether_addr(skb->data + 16))
 		return;
 
 	if (ieee->mode < IEEE_N_24G) {
@@ -504,7 +504,7 @@ static u16 rtllib_query_seqnum(struct rtllib_device *ieee, struct sk_buff *skb,
 			   skb->priority, TX_DIR, true))
 			return 0;
 		seqnum = pTS->TxCurSeq;
-		pTS->TxCurSeq = (pTS->TxCurSeq+1)%4096;
+		pTS->TxCurSeq = (pTS->TxCurSeq + 1) % 4096;
 		return seqnum;
 	}
 	return 0;
@@ -611,7 +611,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 		if (skb->len > 282) {
 			if (ether_type == ETH_P_IP) {
 				const struct iphdr *ip = (struct iphdr *)
-					((u8 *)skb->data+14);
+					((u8 *)skb->data + 14);
 				if (ip->protocol == IPPROTO_UDP) {
 					struct udphdr *udp;
 
@@ -815,10 +815,10 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 					 cpu_to_le16(rtllib_query_seqnum(ieee, skb_frag,
 									 header.addr1));
 				frag_hdr->seq_ctl =
-					 cpu_to_le16(le16_to_cpu(frag_hdr->seq_ctl)<<4 | i);
+					 cpu_to_le16(le16_to_cpu(frag_hdr->seq_ctl) << 4 | i);
 			} else {
 				frag_hdr->seq_ctl =
-					 cpu_to_le16(ieee->seq_ctrl[0]<<4 | i);
+					 cpu_to_le16(ieee->seq_ctrl[0] << 4 | i);
 			}
 			/* Put a SNAP header on the first fragment */
 			if (i == 0) {
-- 
2.38.1

