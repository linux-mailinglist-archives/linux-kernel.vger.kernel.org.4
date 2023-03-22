Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690746C5946
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjCVWHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCVWHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:07:43 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0701A67B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 15:07:41 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eg48so78808280edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 15:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seecs.edu.pk; s=google; t=1679522860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRIhiCMIYhlzOxpqNUvBzZ/DfwkIA0+Cejq18uIa0y0=;
        b=Vayg/s7IU/T//J5ygUx8W93dQ1yMAPQ6wpM2Kml2UBPoShghd2Q1Adkx1mGiBLsoFF
         8vgEMzcKqQvSI1+sU6tw2/oEXAoFs9eWPhKz4WvITlv3igw6d7xUgfzdeldDQmvJ4bFk
         7srUtmt3rCorsT74+qfCVk4YsUtBPPOaWSI90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679522860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRIhiCMIYhlzOxpqNUvBzZ/DfwkIA0+Cejq18uIa0y0=;
        b=ygMBigkLXXbl6+RlT3zaH2zhrVI4JRLpNmb5Ua0Ufk9Ns08bh+B8hsjCUMui3j/Kwd
         adl0v+3s7UYUZ5GTgnaCDwaRLzHT9ZP51o56LPjUz0d6beHMpA3bnfu4aGDmsHe5857m
         xPAAqTsn6r6aRQ1/Lm+NknyhG7eL3gRj3Qv8y+tK2zcW7jCbrlkD1vdvwwDSW/LG59Hj
         F0xHIG0O4U7BXb+ZZvwuLpoxAhsC+YXxd3gMsRXqIVR35fhLRH2mbLdcFAg+jImdiPy5
         Cqawh4Gq0oqBenqF0tMphM8ncuorwD1s23HfJYGo6fsykODEh0xK2Z9ErjvvV91TXD3l
         JTuw==
X-Gm-Message-State: AO0yUKWbi4T7p4QBIvyd0Z2UHAaEBv8OHMiB5e8aJzuh0RUcmURZKWtB
        O2nDx5d/nfjIb3nQu+N3FY7TPw==
X-Google-Smtp-Source: AK7set9u8/YsDflK7FkGY0lgh0NX2peBT8VOq+aLiQWweYgWgxpaMlUnP2iQj3cQuGG4PHMysrb/1Q==
X-Received: by 2002:a17:907:b0f:b0:930:e634:3d52 with SMTP id h15-20020a1709070b0f00b00930e6343d52mr8203320ejl.24.1679522860416;
        Wed, 22 Mar 2023 15:07:40 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm7787935ejk.114.2023.03.22.15.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 15:07:40 -0700 (PDT)
From:   Khadija Kamran <kkamran.bese16seecs@seecs.edu.pk>
X-Google-Original-From: Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Khadija Kamran <kamrankhadijadj@gmail.com>
Subject: [PATCH 4/4] staging: rtl8192e: remove blank lines after '{'
Date:   Thu, 23 Mar 2023 03:07:04 +0500
Message-Id: <303a41480220a6c31cee91d40ece40b3fae3bddf.1679521517.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679521517.git.kamrankhadijadj@gmail.com>
References: <cover.1679521517.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank lines after an open brace as reported by
checkpatch.pl

"CHECK: Blank lines aren't necessary after an open brace '{'"

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index f627dfe66d90..b649d02dc5c8 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1167,7 +1167,6 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 	if (crypt && !(fc & RTLLIB_FCTL_WEP) && !ieee->open_wep) {
 		if (/*ieee->ieee802_1x &&*/
 		    rtllib_is_eapol_frame(ieee, skb, hdrlen)) {
-
 			/* pass unencrypted EAPOL frames even if encryption is
 			 * configured
 			 */
@@ -1207,7 +1206,6 @@ static void rtllib_rx_check_leave_lps(struct rtllib_device *ieee, u8 unicast,
 				      u8 nr_subframes)
 {
 	if (unicast) {
-
 		if (ieee->state == RTLLIB_LINKED) {
 			if (((ieee->link_detect_info.NumRxUnicastOkInPeriod +
 			    ieee->link_detect_info.NumTxOkInPeriod) > 8) ||
@@ -1552,7 +1550,6 @@ static u8 qos_oui[QOS_OUI_LEN] = { 0x00, 0x50, 0xF2 };
 static int rtllib_verify_qos_info(struct rtllib_qos_information_element
 				     *info_element, int sub_type)
 {
-
 	if (info_element->elementID != QOS_ELEMENT_ID)
 		return -1;
 	if (info_element->qui_subtype != sub_type)
@@ -2696,7 +2693,6 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 		ieee->last_rx_ps_time = jiffies;
 
 	switch (WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl))) {
-
 	case RTLLIB_STYPE_BEACON:
 		netdev_dbg(ieee->dev, "received BEACON (%d)\n",
 			   WLAN_FC_GET_STYPE(le16_to_cpu(header->frame_ctl)));
-- 
2.34.1

