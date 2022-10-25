Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B5460CA40
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiJYKof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiJYKoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:44:30 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB31DC2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666694663; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=IGYGDLwQfvSHeLbPF+KYIytnG/XuDn1g2kQRvxX3AYd7y3lGLEkSeabbHRGvbRcRE9hjwzh3TtVJ7uWvXo0Cvr44OZsaTAtc0kZ5AXI01O4XAJNbv2myNehACgy4xuuVtGwnnX1DcSTl/TIMW7QstQxsE7ZUXQ3iQoIiYJ8YiQM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666694663; h=Content-Type:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=G/sAQGzMUEcTbBKnSJYTt9As3/GXRHrq9BFPQudSOEA=; 
        b=QJQ7WSuqNKj3W9SRQkawA8XAarg3eYTbX5soc863nqDJkDzlgOsEP9cNiArSVSYu5UwTo9rwx98y8oC0ScnC+PQpk0xhJncmhuk7XSEFI233czSzonA31aF8FSiQVEo0mWhERo9Y/xLsg8XlFx3yE/dO8W0coEcvXuwBVENKMXY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666694663;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
        bh=G/sAQGzMUEcTbBKnSJYTt9As3/GXRHrq9BFPQudSOEA=;
        b=KRTYNJhM2/hofDNHwGhMmVnKmUUEM+gALMJ1aJuQQdiDB1q37TW3eHzcY6I6E/eG
        ix3e1c2r/ndVEFeWDLr63RxWlrbY1WQ7/Lye9Xm7RvBnEozp1Yn0mdtm4MWAJU8U80R
        t2uOafcvW8pwMhfZUT+R1IJjDLuCLfWfwXNtUzEE=
Received: from plymouth (103.47.132.21 [103.47.132.21]) by mx.zohomail.com
        with SMTPS id 1666694662247981.0480791515864; Tue, 25 Oct 2022 03:44:22 -0700 (PDT)
Date:   Tue, 25 Oct 2022 17:44:02 +0700
From:   Aaron Lawrence <t4rmin@zohomail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: rtllib_crypt_wep: multiple blank lines
 removal
Message-ID: <20221025104402.xvbfobi7sdnwlqs2@plymouth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Removal of multiple unnecessary blank lines in accordance with the
Linux kernel coding-style regulations. Said issues ware detected on
this file by the checkpatch script.

Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_wep.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_wep.c b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
index 7790271a6a40..062285e4d939 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_wep.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
@@ -27,7 +27,6 @@ struct prism2_wep_data {
 	struct arc4_ctx tx_ctx_arc4;
 };
 
-
 static void *prism2_wep_init(int keyidx)
 {
 	struct prism2_wep_data *priv;
@@ -46,7 +45,6 @@ static void *prism2_wep_init(int keyidx)
 	return priv;
 }
 
-
 static void prism2_wep_deinit(void *priv)
 {
 	kfree_sensitive(priv);
@@ -120,7 +118,6 @@ static int prism2_wep_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	return 0;
 }
 
-
 /* Perform WEP decryption on given struct buffer. Buffer includes whole WEP
  * part of the frame: IV (4 bytes), encrypted payload (including SNAP header),
  * ICV (4 bytes). len includes both IV and ICV.
@@ -180,7 +177,6 @@ static int prism2_wep_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	return 0;
 }
 
-
 static int prism2_wep_set_key(void *key, int len, u8 *seq, void *priv)
 {
 	struct prism2_wep_data *wep = priv;
@@ -194,7 +190,6 @@ static int prism2_wep_set_key(void *key, int len, u8 *seq, void *priv)
 	return 0;
 }
 
-
 static int prism2_wep_get_key(void *key, int len, u8 *seq, void *priv)
 {
 	struct prism2_wep_data *wep = priv;
@@ -207,7 +202,6 @@ static int prism2_wep_get_key(void *key, int len, u8 *seq, void *priv)
 	return wep->key_len;
 }
 
-
 static void prism2_wep_print_stats(struct seq_file *m, void *priv)
 {
 	struct prism2_wep_data *wep = priv;
@@ -231,13 +225,11 @@ static struct lib80211_crypto_ops rtllib_crypt_wep = {
 	.owner			= THIS_MODULE,
 };
 
-
 static int __init rtllib_crypto_wep_init(void)
 {
 	return lib80211_register_crypto_ops(&rtllib_crypt_wep);
 }
 
-
 static void __exit rtllib_crypto_wep_exit(void)
 {
 	lib80211_unregister_crypto_ops(&rtllib_crypt_wep);
-- 
2.38.1

