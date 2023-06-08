Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EB87277D6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjFHGws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbjFHGwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:52:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9F3270F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:52:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51669dd574aso61089a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 23:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686207157; x=1688799157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQKW2CDMPBC9N1g2gyQZv/XRpd7ea6cV/0jZn5MOSfA=;
        b=eaxc9/pqjJc6kK1znYKJlr/yH7bGWBt1ysV7mIagQF/Hz+gCfmlLOp5OocMMBG/dfD
         vPW41/fiLorEDUeSh1J2cmBvF6udX1SqsD9QAwG0PKo4QkybO2Q0HzycLMtn+uA2/Jzg
         mdVzGdIvK1CLrkwUp+bIoTwRgCo+jGYHCMF8bo+G8wTvZTDwzQClDcGmh+2q9DgmryUZ
         wLcVsJHqMQA4IsBOh5ufv3xwoddzXta0zypK8jp7OlSnLxcM3lzRbZ4JPNxUTlklis9D
         sbsdxOc18C1NGcCh4eynCpA0D+XC+gqNEQ/bl2dRnTjfjBX8S2X7xWqsVUBGrAEitcg/
         ZbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686207157; x=1688799157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQKW2CDMPBC9N1g2gyQZv/XRpd7ea6cV/0jZn5MOSfA=;
        b=jYMMbw8aPiQHXJRxustPQBi+jVglaGhMPCMM6jhnFWStEwBKhL4kuIn69xC/TLgkpu
         nL8cfBvLdLSfmpGlYqg0iTGFtOqbzDmWwIDlURlpYo2+yYVWJdRptzJEy+T1io617fh7
         n6jBpJxPRHF5t5t6LbljMS5ErwLmdD8Lo8zFOhigFq6/GYEcaW+wPe+HqKQyCIbiHYIP
         TH/BHPGx5khIV+F0gDBJhNc0m9C/DHkAiL8pmPZWyKulowwil8n1LruHY781uOe/+/qJ
         Un1t0v+G1Kzq0EXNzAK11eiEupF6dz1xW5UN1uAophXXEDs9itrM4bZPUduIIBif6eLh
         LVog==
X-Gm-Message-State: AC+VfDyAnRDC1Oj9NgxhEPccQ65YG0deLoBWBLo/1bYkzAeowuWjhLsr
        AKyHqsdJVX/hUjVJPe3ue0Y=
X-Google-Smtp-Source: ACHHUZ7Xiaird4DXuqMeoKDCwKMqKPOplVzbQVoSl1A/rYo8+gtQcAZyOYekDg1rL5Ph9GS3SdWjdQ==
X-Received: by 2002:a05:6402:2810:b0:516:a044:b6d8 with SMTP id h16-20020a056402281000b00516a044b6d8mr4205357ede.4.1686207156787;
        Wed, 07 Jun 2023 23:52:36 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id g16-20020aa7d1d0000000b0050bc4600d38sm182287edp.79.2023.06.07.23.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 23:52:36 -0700 (PDT)
Date:   Thu, 8 Jun 2023 08:52:34 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8192e: Use standard api to calculate channel
 to frequency
Message-ID: <c3a94a403d04ba810cffff8afa734a94a218a4e9.1686166624.git.philipp.g.hortmann@gmail.com>
References: <cover.1686166624.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686166624.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ieee80211_channel_to_freq_khz() to calculate channel to frequency to
omit proprietary code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   |  6 ++++--
 drivers/staging/rtl8192e/rtllib.h            |  2 --
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 13 ++-----------
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 8b656980ee25..3346c4d72c3e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -342,9 +342,11 @@ static int _rtl92e_wx_get_range(struct net_device *dev,
 
 	for (i = 0, val = 0; i < 14; i++) {
 		if ((priv->rtllib->active_channel_map)[i + 1]) {
+			s32 freq_khz;
+
 			range->freq[val].i = i + 1;
-			range->freq[val].m = rtllib_wlan_frequencies[i] *
-					     100000;
+			freq_khz = ieee80211_channel_to_freq_khz(i + 1, NL80211_BAND_2GHZ);
+			range->freq[val].m = freq_khz * 100;
 			range->freq[val].e = 1;
 			val++;
 		}
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index cdd7fdc5befe..87e9169214f6 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2049,8 +2049,6 @@ void TsStartAddBaProcess(struct rtllib_device *ieee,
 void RemovePeerTS(struct rtllib_device *ieee, u8 *Addr);
 void RemoveAllTS(struct rtllib_device *ieee);
 
-extern const long rtllib_wlan_frequencies[];
-
 static inline const char *escape_essid(const char *essid, u8 essid_len)
 {
 	static char escaped[IW_ESSID_MAX_SIZE * 2 + 1];
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 6fd2e94d5f8a..d6d90e6ba2d3 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -15,15 +15,6 @@
 
 #include "rtllib.h"
 #include "dot11d.h"
-/* FIXME: add A freqs */
-
-const long rtllib_wlan_frequencies[] = {
-	2412, 2417, 2422, 2427,
-	2432, 2437, 2442, 2447,
-	2452, 2457, 2462, 2467,
-	2472, 2484
-};
-EXPORT_SYMBOL(rtllib_wlan_frequencies);
 
 int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info *a,
 			     union iwreq_data *wrqu, char *b)
@@ -83,8 +74,8 @@ int rtllib_wx_get_freq(struct rtllib_device *ieee,
 
 	if (ieee->current_network.channel == 0)
 		return -1;
-	fwrq->m = rtllib_wlan_frequencies[ieee->current_network.channel - 1] *
-		  100000;
+	fwrq->m = ieee80211_channel_to_freq_khz(ieee->current_network.channel,
+						NL80211_BAND_2GHZ) * 100;
 	fwrq->e = 1;
 	return 0;
 }
-- 
2.40.1

