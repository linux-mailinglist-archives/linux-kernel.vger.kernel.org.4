Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A151760E101
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiJZMkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiJZMjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:39:48 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DDA240A1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666787978; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=NQLOs/sNpkyQaEw+Uv1jlWXuOVJLnh65dxGlU9ZSgeYq/3WUOe9+PVQDkWYKs8KuzVi6ih8Jghg6BE8IEtFhisS7aBjHHhWG4kk+3FVsQvdwJ2gnvEzA6bGk3Tvu3QFFbdcJopDcZDzJ5W5c9v4fqjHgfFtUSU+oOiSRYQU4vww=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666787978; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0LLkN2jkAwe4zdgwogVVzq5cDse5Taypry86b9Wf73s=; 
        b=WxE2LOx9gTfazoCajhtmBpGYBNP5+KJ+n7OhWPBJqyUX+LFHzFaWumclNDBca6/Z1r5w2THlLY6mN3UK69t1MXJgtyWXktUfefj8D/8F7fBSU3xb7VJh/M32rR/L/bSq9wW0UnzU3AG26zKw62g6a3XQo2nzTBEs0Ouqe+FU5go=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666787978;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=0LLkN2jkAwe4zdgwogVVzq5cDse5Taypry86b9Wf73s=;
        b=XEShc9chnvCdq0ib0zLpbi3H+RUk49h7HsKz47lcxh+jEpNGkYhnlX+NZECWnRk8
        /eGdUBh3DWMu2TyVy2LH3b69y2UUxosYSk2Rwc4TO66u6Y9f1NadbjkjpPhft3va37d
        hCSPbbcId87rc6IC/ZhppI5Y6AmiK7b4tm5uXAYs=
Received: from plymouth (103.47.132.7 [103.47.132.7]) by mx.zohomail.com
        with SMTPS id 1666787977517374.34762759246007; Wed, 26 Oct 2022 05:39:37 -0700 (PDT)
Date:   Wed, 26 Oct 2022 19:39:28 +0700
From:   Aaron Lawrence <t4rmin@zohomail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] staging: rtl8192e: rtllib_crypt_tkip: multiple blank
 lines removal
Message-ID: <f2103758c23f37b61fcbe14f8ed0da8d6b31f5c6.1666787061.git.t4rmin@zohomail.com>
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

Removed multiple unnecessary blank lines in accordance with the
Linux kernel coding-style regulations. The issues were reported by
the checkpatch script.

Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c | 24 --------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
index 8bc95651e384..468f28f48eba 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
@@ -91,7 +91,6 @@ static void *rtllib_tkip_init(int key_idx)
 	return NULL;
 }
 
-
 static void rtllib_tkip_deinit(void *priv)
 {
 	struct rtllib_tkip_data *_priv = priv;
@@ -103,49 +102,41 @@ static void rtllib_tkip_deinit(void *priv)
 	kfree_sensitive(priv);
 }
 
-
 static inline u16 RotR1(u16 val)
 {
 	return (val >> 1) | (val << 15);
 }
 
-
 static inline u8 Lo8(u16 val)
 {
 	return val & 0xff;
 }
 
-
 static inline u8 Hi8(u16 val)
 {
 	return val >> 8;
 }
 
-
 static inline u16 Lo16(u32 val)
 {
 	return val & 0xffff;
 }
 
-
 static inline u16 Hi16(u32 val)
 {
 	return val >> 16;
 }
 
-
 static inline u16 Mk16(u8 hi, u8 lo)
 {
 	return lo | (hi << 8);
 }
 
-
 static inline u16 Mk16_le(u16 *v)
 {
 	return *v;
 }
 
-
 static const u16 Sbox[256] = {
 	0xC6A5, 0xF884, 0xEE99, 0xF68D, 0xFF0D, 0xD6BD, 0xDEB1, 0x9154,
 	0x6050, 0x0203, 0xCEA9, 0x567D, 0xE719, 0xB562, 0x4DE6, 0xEC9A,
@@ -181,17 +172,14 @@ static const u16 Sbox[256] = {
 	0x82C3, 0x29B0, 0x5A77, 0x1E11, 0x7BCB, 0xA8FC, 0x6DD6, 0x2C3A,
 };
 
-
 static inline u16 _S_(u16 v)
 {
 	u16 t = Sbox[Hi8(v)];
 	return Sbox[Lo8(v)] ^ ((t << 8) | (t >> 8));
 }
 
-
 #define PHASE1_LOOP_COUNT 8
 
-
 static void tkip_mixing_phase1(u16 *TTAK, const u8 *TK, const u8 *TA, u32 IV32)
 {
 	int i, j;
@@ -213,7 +201,6 @@ static void tkip_mixing_phase1(u16 *TTAK, const u8 *TK, const u8 *TA, u32 IV32)
 	}
 }
 
-
 static void tkip_mixing_phase2(u8 *WEPSeed, const u8 *TK, const u16 *TTAK,
 			       u16 IV16)
 {
@@ -263,7 +250,6 @@ static void tkip_mixing_phase2(u8 *WEPSeed, const u8 *TK, const u16 *TTAK,
 #endif
 }
 
-
 static int rtllib_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 {
 	struct rtllib_tkip_data *tkey = priv;
@@ -293,7 +279,6 @@ static int rtllib_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	} else
 		tkey->tx_phase1_done = 1;
 
-
 	len = skb->len - hdr_len;
 	pos = skb_push(skb, 8);
 	memmove(pos, pos + 8, hdr_len);
@@ -337,7 +322,6 @@ static int rtllib_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 		return ret;
 	return 0;
 
-
 }
 
 static int rtllib_tkip_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
@@ -453,7 +437,6 @@ static int rtllib_tkip_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	return keyidx;
 }
 
-
 static int michael_mic(struct crypto_shash *tfm_michael, u8 *key, u8 *hdr,
 		       u8 *data, size_t data_len, u8 *mic)
 {
@@ -511,7 +494,6 @@ static void michael_mic_hdr(struct sk_buff *skb, u8 *hdr)
 	hdr[13] = hdr[14] = hdr[15] = 0; /* reserved */
 }
 
-
 static int rtllib_michael_mic_add(struct sk_buff *skb, int hdr_len, void *priv)
 {
 	struct rtllib_tkip_data *tkey = priv;
@@ -539,7 +521,6 @@ static int rtllib_michael_mic_add(struct sk_buff *skb, int hdr_len, void *priv)
 	return 0;
 }
 
-
 static void rtllib_michael_mic_failure(struct net_device *dev,
 				       struct rtllib_hdr_4addr *hdr,
 				       int keyidx)
@@ -609,7 +590,6 @@ static int rtllib_michael_mic_verify(struct sk_buff *skb, int keyidx,
 	return 0;
 }
 
-
 static int rtllib_tkip_set_key(void *key, int len, u8 *seq, void *priv)
 {
 	struct rtllib_tkip_data *tkey = priv;
@@ -640,7 +620,6 @@ static int rtllib_tkip_set_key(void *key, int len, u8 *seq, void *priv)
 	return 0;
 }
 
-
 static int rtllib_tkip_get_key(void *key, int len, u8 *seq, void *priv)
 {
 	struct rtllib_tkip_data *tkey = priv;
@@ -671,7 +650,6 @@ static int rtllib_tkip_get_key(void *key, int len, u8 *seq, void *priv)
 	return TKIP_KEY_LEN;
 }
 
-
 static void rtllib_tkip_print_stats(struct seq_file *m, void *priv)
 {
 	struct rtllib_tkip_data *tkip = priv;
@@ -713,13 +691,11 @@ static struct lib80211_crypto_ops rtllib_crypt_tkip = {
 	.owner			= THIS_MODULE,
 };
 
-
 static int __init rtllib_crypto_tkip_init(void)
 {
 	return lib80211_register_crypto_ops(&rtllib_crypt_tkip);
 }
 
-
 static void __exit rtllib_crypto_tkip_exit(void)
 {
 	lib80211_unregister_crypto_ops(&rtllib_crypt_tkip);
-- 
2.38.1

