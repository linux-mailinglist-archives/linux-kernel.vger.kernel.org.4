Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2E167A550
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbjAXWDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbjAXWDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:03:40 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6BC50849
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:03:32 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t18so2457516wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e3159gyzRYnyKWw0j8EF0nhK1aLDWnlIYkjwkYEv8/0=;
        b=obg3uU8DWV4BQmYLBCIVOFVJxtEtJ/4sLceLV2ZkxWSLZWliGknOA12QmuT99oGa4j
         BDbnqcKyXAiXsmKb+vV8kFq4ZwE8dSvhzeDYPVCJRGBFxnJHjMta4LB5dYzczO+j6JFV
         0PpAGNC3Dgx/b6WfO8orRNTgHVQn3h7+eXPHBCSH18wlk5l5anQle3ZsrM6xkviNbVWC
         OhOB5UewNG/OfTVZlqOnwXXssQaU4PCg1YcDUQbr5njGxdO7yNDtfEEn+WxHW+2qA8ZK
         OSeylPmLYm25mEAVuDBAxhZDsdMznQxUdtnzHb5OLEuVuHg+1K/t4L8MyBZuN+9Wc6NE
         T9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3159gyzRYnyKWw0j8EF0nhK1aLDWnlIYkjwkYEv8/0=;
        b=nslhvBEavNlDg4DnHqv4ulKb3TLEnZPE5p9a7qpwjA/M7wheIaa4/EycmLnhEm9rqf
         zU/rOmC6Zm5OyWN6wwi/6A63H0dQEZP8DhwIgXjv1PQXy+fqmuEArzyeoeQ80X6PkkyB
         UxXTrJlwPTuasIyWiXtnkHIaSoSwHqL6UnooAArcfrw6Cr8DUdpLb7fexf1Dbmc9RIeR
         sUU3Tmygc5PaI6ohsKX/0612WIAw+dXz7xnXSPhvMDJEsRkZD7ZdKcD7Z8Hynbf2Tr2O
         oCTnrQCKLrKuYuzuzFo1TbFyCAQ02ZTLaIqG7JmXNujed1RyixVNAiAMapNEo6pOxrom
         qbBQ==
X-Gm-Message-State: AO0yUKX+1JdNE9s4ly/l+M5qygs+TpJcItc9QEIE8pMsUAnPyHfdTwei
        hOaXtDFWVJZI+GL8mC41/eo=
X-Google-Smtp-Source: AK7set+kvm+g6x3biGcGFqnFJwqFUxNNtUgJDEK758Sfdv7XwtT3WxQtOGQ1YigavNIsAm0KpseP2g==
X-Received: by 2002:adf:d239:0:b0:2bf:b2fe:a2c4 with SMTP id k25-20020adfd239000000b002bfb2fea2c4mr408221wrh.7.1674597811807;
        Tue, 24 Jan 2023 14:03:31 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id bj7-20020a0560001e0700b002bfb5618ee7sm1123210wrb.91.2023.01.24.14.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 14:03:29 -0800 (PST)
Date:   Tue, 24 Jan 2023 23:03:28 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] staging: rtl8192e: Remove unused variables rxcrcerrmin
 and friends
Message-ID: <4c791fbb3559ce15de60b7bdcabbc50b0ee9adb9.1674596722.git.philipp.g.hortmann@gmail.com>
References: <cover.1674596722.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674596722.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rxcrcerrmin, rxcrcerrmax and rxcrcerrmid are initialized and increased
but never read. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 10 ----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   |  3 ---
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 9260d308e68b..e9273dfb638e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1812,7 +1812,6 @@ static void _rtl92e_update_received_rate_histogram_stats(
 bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 			 struct rx_desc *pdesc, struct sk_buff *skb)
 {
-	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rx_fwinfo *pDrvInfo = NULL;
 
 	stats->bICV = pdesc->ICV;
@@ -1825,15 +1824,6 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 
 	if (stats->bHwError) {
 		stats->bShift = false;
-
-		if (pdesc->CRC32) {
-			if (pdesc->Length < 500)
-				priv->stats.rxcrcerrmin++;
-			else if (pdesc->Length > 1000)
-				priv->stats.rxcrcerrmax++;
-			else
-				priv->stats.rxcrcerrmid++;
-		}
 		return false;
 	}
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index f91a6f7a4e0a..167c4aeea44e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -183,9 +183,6 @@ enum reset_type {
 };
 
 struct rt_stats {
-	unsigned long rxcrcerrmin;
-	unsigned long rxcrcerrmid;
-	unsigned long rxcrcerrmax;
 	unsigned long received_rate_histogram[4][32];
 	unsigned long received_preamble_GI[2][32];
 	unsigned long numpacket_matchbssid;
-- 
2.39.1

