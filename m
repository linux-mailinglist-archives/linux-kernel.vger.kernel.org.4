Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83508605070
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiJSTbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiJSTbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:31:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E3E172502
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:31:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ez6so241735pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+QM1RVijKOjtLzd+GJ+CVT6xe047a5u1xhBsLiuogqI=;
        b=GIxNBmtFP0FYW2Kws+nZniM3JJX2TCfuwct7Nj0h08LRD8PVgwPBQrJEbW5QZGCQmH
         I5Mp52dZBT9/xHAXVVYEywCF1qF4WtWa07MmMlPAdks7OvyUHeNj2tYgJNlNqw1IJd2L
         9XEWY30nzAtFWzgq+RrDax4ACOTKo4eYSonIfhEA0apNHaTHkW8ysEdzDPZvtivtqQnJ
         sDasXhFi0435UK7B8RGlcWYJOTgL1AKpfsF3K9s2o2JtG58ncs/qutc3wTYzR+WY10YY
         R5DFZWQVxrlLxENYdB1lROQ2aRHbT/yYQ44TEKdZ2HmZuwOmzgXhBV+dhYOD5jiAvc23
         azEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+QM1RVijKOjtLzd+GJ+CVT6xe047a5u1xhBsLiuogqI=;
        b=Yhaqn6ckpX04RNHtUETPuD0yozggov+E3Iqr/fzDBN662cc8rVBilK7spfMrfzFzSr
         hBf4EU4lHRN9RNSKF6nVL9289ZDP6PFP2WtAsum70TYUZ54vhxot1FBLbyAqEPaFyuah
         TsGvASQNR40w+Tv0yPphqpTwz2hOM2VgBaOP9bOSiFRrDT5Ei3AZDEK589CICXLbcWH8
         TmXi+yflhIJ6E8TcdJIu9t95iWtYTDHagOK3NtxY5Qb2qGZ6VSeQTFY6ZZynYnSZwf3b
         P6zdLqQD5Ln67vbPP/9wWmpudbsFje5By9JUlXC2CjJwH+IY4/NTTBQZhVGz+IKgyTd5
         I1dw==
X-Gm-Message-State: ACrzQf1FWwLK0VsxQor73zTKbemS0HVShoJfsh84LDYazBn1KHc28t+I
        ow1HOaRfd47StFKfmFyBKTI=
X-Google-Smtp-Source: AMsMyM4k0YO+I0kmDM92aBNf8vpquGWSy+QJYPjTVZoGdTtbOmF+Bi5apjDhoyDjR0d9HY3hwBdzGQ==
X-Received: by 2002:a17:90b:3b50:b0:20d:93f3:9c8d with SMTP id ot16-20020a17090b3b5000b0020d93f39c8dmr44983053pjb.150.1666207872673;
        Wed, 19 Oct 2022 12:31:12 -0700 (PDT)
Received: from marshmallow (192-184-163-51.fiber.dynamic.sonic.net. [192.184.163.51])
        by smtp.gmail.com with ESMTPSA id y126-20020a62ce84000000b0056885e0b273sm1902020pfg.8.2022.10.19.12.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 12:31:12 -0700 (PDT)
Date:   Wed, 19 Oct 2022 12:31:10 -0700
From:   Emily Peri <eperi1024@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Removed extra tabs in conditional
 statements
Message-ID: <Y1BQfiwOXzAZpCCa@marshmallow>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch found extra tabs in two conditional statements in
rtw_ieee80211.c. Should be one tab instead of two.

Signed-off-by: Emily Peri <eperi1024@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 3d8a64f69448..30e7457a9c31 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1063,18 +1063,18 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 	/* parsing HT_CAP_IE */
 	p = rtw_get_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, WLAN_EID_HT_CAPABILITY, &len, pnetwork->network.ie_length - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
-			pht_cap = (struct ieee80211_ht_cap *)(p + 2);
-			pnetwork->bcn_info.ht_cap_info = le16_to_cpu(pht_cap->cap_info);
+		pht_cap = (struct ieee80211_ht_cap *)(p + 2);
+		pnetwork->bcn_info.ht_cap_info = le16_to_cpu(pht_cap->cap_info);
 	} else {
-			pnetwork->bcn_info.ht_cap_info = 0;
+		pnetwork->bcn_info.ht_cap_info = 0;
 	}
 	/* parsing HT_INFO_IE */
 	p = rtw_get_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, WLAN_EID_HT_OPERATION, &len, pnetwork->network.ie_length - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
-			pht_info = (struct HT_info_element *)(p + 2);
-			pnetwork->bcn_info.ht_info_infos_0 = pht_info->infos[0];
+		pht_info = (struct HT_info_element *)(p + 2);
+		pnetwork->bcn_info.ht_info_infos_0 = pht_info->infos[0];
 	} else {
-			pnetwork->bcn_info.ht_info_infos_0 = 0;
+		pnetwork->bcn_info.ht_info_infos_0 = 0;
 	}
 }
 
-- 
2.34.1

