Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B653260E116
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiJZMnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiJZMnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:43:10 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7F81A209
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666788185; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=VhtDcv9QqQmhe/+i5FaDmjXoI0uKRy68wpAEUQRBht5dkLyf3K5uAzW1kJPHgDBLkDTZw7Yn+4v+patub59VWkqJHG8TP1ai9Q+4MRZlSfOAVLtCiHcO1W83SHAtm+YtxNfbxicqurQhRxRNEfXOwR15iBO4ZKHBq3GlXloxEGA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666788185; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=gn9CWmy4W7rmZ/rwXWSEgHAWya2y6DKl9JZAkcJcx+8=; 
        b=BcpmUA4XhoyhPWGwznGP6pqWGJhg9xzD4iVpNj0vlqnLslAhqZsSvOdt7oOn9O05obyRzEE/ZHjCcg+9PwH7qdOuscOAmuO+AG2FrE10VAA524eA7moNzDnbJawrzEPyOiUY+4WiZV9+/j/tOVWCzd5s/6uCJAFWn7mk95Kq1I4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666788185;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=gn9CWmy4W7rmZ/rwXWSEgHAWya2y6DKl9JZAkcJcx+8=;
        b=OlIEGgpfjt8ftu+jBMfBvsLDv6mv06kzsJ82KAy3RBNwKnWDb814hQO7FBLP4u9A
        Nx/vsnJJ9WOkGAtHfMc5qWZmsCblatKWL3vHIvkIxsv5t6i+G2iCGa9q6s06jqC9/Bp
        eIaVC2+4ftbSehWN/LJNYrX4Mqcmr/OA6VKkrJqE=
Received: from plymouth (103.47.132.34 [103.47.132.34]) by mx.zohomail.com
        with SMTPS id 1666788184977888.9014581744829; Wed, 26 Oct 2022 05:43:04 -0700 (PDT)
Date:   Wed, 26 Oct 2022 19:42:55 +0700
From:   Aaron Lawrence <t4rmin@zohomail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] staging: rtl8192e: rtllib_crypt_tkip: split multiple
 assignments
Message-ID: <a9ab257d0042afd3b3231eefe4f58c0c3ac7649f.1666787061.git.t4rmin@zohomail.com>
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

Split a multiple assignments statement to individual assignments
on different lines in accordance with the Linux kernel coding-style
regulations. Also repositioned comments on it and the statement
before for increased legibility. The multiple assignments issue
was found by the checkpatch script, with the comments legibility
issue were through direct observation.

Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
index d1b86de76eb2..b8a52b9f9d07 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
@@ -488,9 +488,13 @@ static void michael_mic_hdr(struct sk_buff *skb, u8 *hdr)
 		break;
 	}
 
-	hdr[12] = 0; /* priority */
+	/* priority */
+	hdr[12] = 0;
 
-	hdr[13] = hdr[14] = hdr[15] = 0; /* reserved */
+	/* reserved */
+	hdr[13] = 0;
+	hdr[14] = 0;
+	hdr[15] = 0;
 }
 
 static int rtllib_michael_mic_add(struct sk_buff *skb, int hdr_len, void *priv)
-- 
2.38.1

