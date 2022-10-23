Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2626C60920E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJWJpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJWJpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:45:52 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1737538478
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:45:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666518347; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=n0djU2Bcz7eYnsBAcPeKlyvR6aq2jmNAtN8kcNZGqT0FQnuB3hUo7PgkydrmbhUwynC/hF5FncLUpwBWtcOOFQQNxbe3GxlY46bqM+NuVbhCNPfIiYya5Vz74bNieAz8RPRklZkx29XmFzIdORHw1cpsCNz11uKO+ELiqVe6n98=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666518347; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ivNt5vYMgwnw429QXPfXjURSmbe5Iv+xz1tsl5G5fNc=; 
        b=Zsi+X29bOR3VqdU3tO1E5NYMCWi1YlCNJYfiAw3jRcYpXlxrocOG8apnwK0PnOKbzfl44FH6kTKZneXNxtV6ZNmjtv0L3dEy8zlAU44OjyBO7yhgwR5LiJjHxquWiKbdIAZsNYnD/S7p+XGegBhKeyxVWS1G5ts23erUH07KWTc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666518347;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=ivNt5vYMgwnw429QXPfXjURSmbe5Iv+xz1tsl5G5fNc=;
        b=dJG+o16uOV35Bms1qM3STrK1Q/HJyEQGiVIunVe9Ef0yHy60omQktorYDNctpPq5
        uzWSM8ZL9NmoL7cA7qHWyJ97erZWME8qjAtBqpCMElrta9W2D2qvN5ofGllOiDgae5j
        UUahMtngxrsR0XRuK7zD82kJGUSVPuRDviEPlY2c=
Received: from plymouth (101.128.127.165 [101.128.127.165]) by mx.zohomail.com
        with SMTPS id 16665183462521005.4633904721092; Sun, 23 Oct 2022 02:45:46 -0700 (PDT)
Date:   Sun, 23 Oct 2022 16:45:37 +0700
From:   Aaron Lawrence <t4rmin@zohomail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] Staging: rtl8192e: rtl819x_HTProc: fixed unnecessary
 parentheses
Message-ID: <d2168b90726dda2f02279a3483b53b8d9b34cb30.1666502177.git.t4rmin@zohomail.com>
References: <cover.1666502177.git.t4rmin@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666502177.git.t4rmin@zohomail.com>
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

Fixed multiple unnecessary parentheses as per the Linux kernel
coding-style regulations. The issues were flagged by the
checkpatch script.

Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index a701be8c2923..62aa8e893c34 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -285,7 +285,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};
 
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
-		pCapELE = (struct ht_capab_ele *)&(posHTCap[4]);
+		pCapELE = (struct ht_capab_ele *)&posHTCap[4];
 		*len = 30 + 2;
 	} else {
 		pCapELE = (struct ht_capab_ele *)posHTCap;
@@ -644,13 +644,13 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 	pHTInfo->current_mpdu_density = pHTInfo->MPDU_Density;
 	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
 
-	memset((void *)(&(pHTInfo->SelfHTCap)), 0,
+	memset((void *)(&pHTInfo->SelfHTCap), 0,
 	       sizeof(pHTInfo->SelfHTCap));
-	memset((void *)(&(pHTInfo->SelfHTInfo)), 0,
+	memset((void *)(&pHTInfo->SelfHTInfo), 0,
 	       sizeof(pHTInfo->SelfHTInfo));
-	memset((void *)(&(pHTInfo->PeerHTCapBuf)), 0,
+	memset((void *)(&pHTInfo->PeerHTCapBuf), 0,
 	       sizeof(pHTInfo->PeerHTCapBuf));
-	memset((void *)(&(pHTInfo->PeerHTInfoBuf)), 0,
+	memset((void *)(&pHTInfo->PeerHTInfoBuf), 0,
 	       sizeof(pHTInfo->PeerHTInfoBuf));
 
 	pHTInfo->sw_bw_in_progress = false;
@@ -666,7 +666,7 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 	pHTInfo->iot_ra_func = 0;
 
 	{
-		u8 *RegHTSuppRateSets = &(ieee->RegHTSuppRateSet[0]);
+		u8 *RegHTSuppRateSets = &ieee->RegHTSuppRateSet[0];
 
 		RegHTSuppRateSets[0] = 0xFF;
 		RegHTSuppRateSets[1] = 0xFF;
-- 
2.38.1

