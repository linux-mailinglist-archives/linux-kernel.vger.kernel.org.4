Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC38360E114
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbiJZMmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiJZMmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:42:31 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF09FA6C1B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:42:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666788125; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=HXV0FMfZ6oUW3z1xoYEwmViemlJbzBwYB6VvaT0neiL0/hNyEUcE1d1KX3uifMPg6d1n2LX9eGg74GYJ/95SuYPymlTjpJfk/+1+snbT9aarNKHUfIN/fBrGX4ef+pqGgq03v8qyEMQqdk9+P/SW4DRJvnG0c2OogrQHk39YJdk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666788125; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=df0mW1Jb9+xh3ALWnyLN9NgJphOGqTv2a+4jnuo89gU=; 
        b=dFnxp/Zyu9EKmRD7xUphKtGQ1RkJmcxH3VuxGUwLDb4hgqySck8QW6RSGULjmeMc99Pg5z/VMDLutS+ZfMY87Ww8QeJxgqd1XpWNVHsn4jgCPvV+nnSNN/3W5tn7azPFJh+AuVf7W0VWHdPo1uzN7t8M2RRRANDkjmJdzZCpE9k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666788125;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=df0mW1Jb9+xh3ALWnyLN9NgJphOGqTv2a+4jnuo89gU=;
        b=CcKEerF9AuW+vc2kCRSI+4W2BjFuq3FCqvr0GFP3HDwCOR7OTlb5Ay7a/CLr0Mc3
        4AURTkp5t8RDx8mc+dj77n3vjZCeNEwsU5utecsIU9QmOTJULHGXUes5NGfbS8zFTJU
        YGoZnzV9QavQv7RLWRrEB0RCiMuJoJnp7fkGBrGQ=
Received: from plymouth (103.47.132.31 [103.47.132.31]) by mx.zohomail.com
        with SMTPS id 1666788124753190.8868367598759; Wed, 26 Oct 2022 05:42:04 -0700 (PDT)
Date:   Wed, 26 Oct 2022 19:41:56 +0700
From:   Aaron Lawrence <t4rmin@zohomail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] staging: rtl8192e: rtllib_crypt_tkip: fixes on
 unbalanced braces
Message-ID: <641d8360c5f86b54efc96d7f8ef70be1371db480.1666787061.git.t4rmin@zohomail.com>
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

Added braces around needed arms of statements which needs them
in accordance with the Linux kernel coding-style regulations.
The issues were found with the help of the checkpatch script.

Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
index 6c98f43f967e..d1b86de76eb2 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
@@ -276,8 +276,9 @@ static int rtllib_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 		}
 		tkip_mixing_phase2(rc4key, tkey->key, tkey->tx_ttak,
 				   tkey->tx_iv16);
-	} else
+	} else {
 		tkey->tx_phase1_done = 1;
+	}
 
 	len = skb->len - hdr_len;
 	pos = skb_push(skb, 8);
@@ -610,10 +611,11 @@ static int rtllib_tkip_set_key(void *key, int len, u8 *seq, void *priv)
 				(seq[3] << 8) | seq[2];
 			tkey->rx_iv16 = (seq[1] << 8) | seq[0];
 		}
-	} else if (len == 0)
+	} else if (len == 0) {
 		tkey->key_set = 0;
-	else
+	} else {
 		return -1;
+	}
 
 	return 0;
 }
-- 
2.38.1

