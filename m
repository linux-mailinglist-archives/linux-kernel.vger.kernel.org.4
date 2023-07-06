Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEED74939D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 04:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjGFCQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 22:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFCQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 22:16:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3C4FC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 19:16:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF69D19C07;
        Wed,  5 Jul 2023 22:16:47 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        fQRURmtGU9+VkKlIsI3Hm+nfj5STTvRmot52VrL0YUQ=; b=hnKFr1ieuENSMhAc
        F0VMd8F/kHo+CZQ/TSPS/CPgAeQabXMKlDWZV8p3suL+em2+ViOGixoYj2Z8Ez88
        xOFRsgIwGQHm/89kEGentVt8/eFhk4F9MMv3G9U5lMaWsRrKCGWGt/h+THQ8u4nz
        CKOMUjCpFHgBnW2/skl2wrGY6Ts=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D687619C06;
        Wed,  5 Jul 2023 22:16:47 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=fQRURmtGU9+VkKlIsI3Hm+nfj5STTvRmot52VrL0YUQ=;
 b=j6xrx9aL4Z97iylqOFSGe5VwFVyCTFNba3/x/ADAqqAfDYRDKYS1zzKwtE9CKdFDETFyaxKHWb+A9vTenteLCUce7saYYeL9X2NMT30AbrjiZHhlZ/GtIi+C8xtkuljq/Je6xafFu1NVRc7hmLM8UzoDBl1S/uS7x7j/MaZe1fs=
Received: from kimchi.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 63C7319C04;
        Wed,  5 Jul 2023 22:16:44 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Wed, 5 Jul 2023 19:16:38 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        dan.carpenter@linaro.org
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Rename variable bRegShortGI40MHz
Message-ID: <ZKYkBlqcydh26zSo@kimchi.darkphysics>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: 271BBBDA-1BA3-11EE-BDD1-B31D44D1D7AA-45285927!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames variable bRegShortGI40MHz to breg_short_gi_40MHz
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 2bbd01048561..07102ce5ef5d 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -96,7 +96,7 @@ struct rt_hi_throughput {
 	u8 bCurrentHTSupport;
 	u8 bRegBW40MHz;
 	u8 bCurBW40MHz;
-	u8 bRegShortGI40MHz;
+	u8 breg_short_gi_40MHz;
 	u8 bCurShortGI40MHz;
 	u8 bRegShortGI20MHz;
 	u8 bCurShortGI20MHz;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f9fa3f2bb728..1844098a4308 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -72,7 +72,7 @@ void HTUpdateDefaultSetting(struct rtllib_device *ieee)
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
 	ht_info->bRegShortGI20MHz = 1;
-	ht_info->bRegShortGI40MHz = 1;
+	ht_info->breg_short_gi_40MHz = 1;
 
 	ht_info->bRegBW40MHz = 1;
 
@@ -545,7 +545,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	ht_info->bCurShortGI20MHz = ((ht_info->bRegShortGI20MHz) ?
 				    ((pPeerHTCap->ShortGI20Mhz == 1) ?
 				    true : false) : false);
-	ht_info->bCurShortGI40MHz = ((ht_info->bRegShortGI40MHz) ?
+	ht_info->bCurShortGI40MHz = ((ht_info->breg_short_gi_40MHz) ?
 				     ((pPeerHTCap->ShortGI40Mhz == 1) ?
 				     true : false) : false);
 
@@ -781,7 +781,7 @@ void HTUseDefaultSetting(struct rtllib_device *ieee)
 		ht_info->bCurBW40MHz = ht_info->bRegBW40MHz;
 		ht_info->bCurShortGI20MHz = ht_info->bRegShortGI20MHz;
 
-		ht_info->bCurShortGI40MHz = ht_info->bRegShortGI40MHz;
+		ht_info->bCurShortGI40MHz = ht_info->breg_short_gi_40MHz;
 
 		if (ieee->iw_mode == IW_MODE_ADHOC)
 			ieee->current_network.qos_data.active =
-- 
2.30.2

