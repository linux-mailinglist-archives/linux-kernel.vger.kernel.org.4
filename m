Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBD760E112
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiJZMmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiJZMmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:42:16 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D148CEC1E9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:41:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666788082; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=nR587+sAzj/nSGmJKUbHMJtXGauiUY93OQ0xneYGgdnwLiw3Vc7EqCZu3VJwzG5N+sRGE/lhhcXYXPy318tdN2HiC2lZelteZ7xSucIlY27rHrupNsKiVm6JhmbBhC6+x4l94710O3hGY4hgYYHuxAVrGtZn0+SMhfqzua4Rt9I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666788082; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=EnEvUgX/cg7EkNND7kN2OeHnLSvX3S1JlCRvtSnaMjE=; 
        b=Lu9QhhTe1wpgKAbZ3KOo2oUPkxV7PcMKzOuWChnwYmBkrO20j4iT1I6bIw1QvXqdQ5kgCoJ8zUQFbivace9Dyx+hc2pIyMTmHmTwfyIsIn7K7X/AM03PNNs0Ri8sk4kvKEBEkJJ5lQs2HW5CR7REIcMjL/uAMoGrauewH++hE0k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666788082;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=EnEvUgX/cg7EkNND7kN2OeHnLSvX3S1JlCRvtSnaMjE=;
        b=OyyNlnwQjaMQrcc193eKi32nfmS+6a18V32WoVAqV+SHAaPshbPWpy/nWFR+dMnC
        7qZRDU3S4mteTPLUPjQRa6NR62nf8VQLC9tDtgNYWd0HkmraxlGKZKHrYI+w9bQgZ/3
        ptLrXVfVmCxuagwiIy0+bENE8yjcDtwuYMNYjLhA=
Received: from plymouth (103.47.132.43 [103.47.132.43]) by mx.zohomail.com
        with SMTPS id 1666788081516748.8350874300916; Wed, 26 Oct 2022 05:41:21 -0700 (PDT)
Date:   Wed, 26 Oct 2022 19:41:08 +0700
From:   Aaron Lawrence <t4rmin@zohomail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] staging: rtl8192e: rtllib_crypt_tkip: fixed alignment
 matching open parentheses
Message-ID: <4253b94d6b7d94713afb02fa63d0a98686e77cc1.1666787061.git.t4rmin@zohomail.com>
References: <cover.1666787061.git.t4rmin@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666787061.git.t4rmin@zohomail.com>
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

Aligned multiple lines to be at the same indentation of open
parentheses before it in accordance with the Linux kernel
coding-style regulations. The issues were found by running the
checkpatch script on the file.

Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
index 40930c9b0017..6c98f43f967e 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
@@ -271,7 +271,7 @@ static int rtllib_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	if (!tcb_desc->bHwSec) {
 		if (!tkey->tx_phase1_done) {
 			tkip_mixing_phase1(tkey->tx_ttak, tkey->key, hdr->addr2,
-					tkey->tx_iv32);
+					   tkey->tx_iv32);
 			tkey->tx_phase1_done = 1;
 		}
 		tkip_mixing_phase2(rc4key, tkey->key, tkey->tx_ttak,
@@ -372,8 +372,8 @@ static int rtllib_tkip_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 
 	if (!tcb_desc->bHwSec || (skb->cb[0] == 1)) {
 		if ((iv32 < tkey->rx_iv32 ||
-		    (iv32 == tkey->rx_iv32 && iv16 <= tkey->rx_iv16)) &&
-		    tkey->initialized) {
+		     (iv32 == tkey->rx_iv32 && iv16 <= tkey->rx_iv16)) &&
+		     tkey->initialized) {
 			if (net_ratelimit()) {
 				netdev_dbg(skb->dev,
 					   "Replay detected: STA= %pM previous TSC %08x%04x received TSC %08x%04x\n",
@@ -513,7 +513,7 @@ static int rtllib_michael_mic_add(struct sk_buff *skb, int hdr_len, void *priv)
 		tkey->tx_hdr[12] = *(skb->data + hdr_len - 2) & 0x07;
 	pos = skb_put(skb, 8);
 	if (michael_mic(tkey->tx_tfm_michael, &tkey->key[16], tkey->tx_hdr,
-	    skb->data + hdr_len, skb->len - 8 - hdr_len, pos))
+			skb->data + hdr_len, skb->len - 8 - hdr_len, pos))
 		return -1;
 
 	return 0;
-- 
2.38.1

