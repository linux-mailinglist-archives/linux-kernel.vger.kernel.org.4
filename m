Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF1D6D2B8F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 01:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjCaXBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 19:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCaXA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:00:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A14F191FF
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 16:00:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n14so6849762plc.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 16:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680303657;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2mmMqFiAumzcpbbntPymlIf8Np9wiownjUZMtsJues=;
        b=Gf+pDUGM0BbEJ6NakQ2q0wy2cvDiJHEgSyfeWbWMUKRQCsK9uE/giv9fduE1LMyq8I
         9YATutxzd5ejWpOrABBqe87S3QZelq2baM11SXb4u54+iHpdVjLiNyVP9Lgsjni9EgNx
         FBI7pgBHk1ggfbBWDnlNXtb49wR1fj38ovCENgk1ObS/39rWgf6DJET/ibaEP3wvhdTz
         mMCx/gUCb70qmzfoVmO/sKO3/3zBLsT/Zglz0Z5WTp70gt7qogjxs6nuhMEy6RPqHuAG
         +ZF11wPtBaXIkjOBREHplrk9PLS50LGLrnAyfR/UddJPDhUwL98YGqnOdQs+FeMPIP09
         fvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680303657;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2mmMqFiAumzcpbbntPymlIf8Np9wiownjUZMtsJues=;
        b=ffHZcSCaoy/jMDLOZNMWzSC7i2LitDzYOkyvOqOI7MYSro5etupYtlfVA6hqhHqCIg
         WrEj2o2C6JhaAKNlAJ2PwjjCnITzAHSLwh/+qgQvVpPqfkdXsTZ6vBsbMxMlL9u/zLef
         4F8KkF492NQMZS7WKUgxdF5MSow8ZwKrX4zQN2Dlz7tyUw3FDBWYUIsZ8uLfqQ/Ot092
         pzTjRfId1UfMPNLIfQ1k/0ru9JMyMgKTojC7xwz5bBOSbci75GJYxH/FlE1TSMNMWuQ7
         uA9NUUigtLUO98FEvb8/v2Z03qGPiZlFeyeYPf9Tx+w+tm6Cri1tDCZHE1JGNaAljDvk
         AnaA==
X-Gm-Message-State: AAQBX9fAwXSDzSmm2f2hKPtGkpoZZ55n5mnzXtJRnen+i06kdULIs76D
        jKwSTydH/5HFTQBwH47WFOsZ0EO0GcI=
X-Google-Smtp-Source: AKy350bd8XnjczUSt5srF8tRLRsoHz3erZ4xCviClGGawdNEt0UtnGoZcmno2M2f/VtXRuQYJBc6bw==
X-Received: by 2002:a17:902:e74e:b0:19d:1674:c04d with SMTP id p14-20020a170902e74e00b0019d1674c04dmr32945454plf.61.1680303657395;
        Fri, 31 Mar 2023 16:00:57 -0700 (PDT)
Received: from trent-reznor (c-67-169-174-96.hsd1.ca.comcast.net. [67.169.174.96])
        by smtp.gmail.com with ESMTPSA id m8-20020a170902768800b001a1a9a639c2sm2044288pll.134.2023.03.31.16.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 16:00:56 -0700 (PDT)
Date:   Fri, 31 Mar 2023 16:00:24 -0700
From:   Daniel Watson <ozzloy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: indent with tab, align with space
Message-ID: <ZCdmCBIdabBGqm11@trent-reznor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tabs to indent code and spaces to align in order to make the code
consistent and easier to read.

Signed-off-by: Daniel Watson <ozzloy@gmail.com>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 49 ++++++++++---------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 9041d8dc5fb1d..1098b02092003 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -174,7 +174,7 @@ struct ieee_param {
 			u8 reserved[32];
 			u8 data[];
 		} wpa_ie;
-	        struct{
+		struct{
 			int command;
 			int reason_code;
 		} mlme;
@@ -271,10 +271,10 @@ struct eapol {
 #define P80211_OUI_LEN 3
 
 struct ieee80211_snap_hdr {
-        u8    dsap;   /* always 0xAA */
-        u8    ssap;   /* always 0xAA */
-        u8    ctrl;   /* always 0x03 */
-        u8    oui[P80211_OUI_LEN];    /* organizational universal id */
+	u8    dsap;   /* always 0xAA */
+	u8    ssap;   /* always 0xAA */
+	u8    ctrl;   /* always 0x03 */
+	u8    oui[P80211_OUI_LEN];    /* organizational universal id */
 } __attribute__ ((packed));
 
 #define SNAP_SIZE sizeof(struct ieee80211_snap_hdr)
@@ -342,12 +342,13 @@ struct ieee80211_snap_hdr {
 #define IEEE80211_OFDM_RATE_48MB_MASK		(1<<10)
 #define IEEE80211_OFDM_RATE_54MB_MASK		(1<<11)
 
-#define IEEE80211_CCK_RATES_MASK	        0x0000000F
+#define IEEE80211_CCK_RATES_MASK		0x0000000F
 #define IEEE80211_CCK_BASIC_RATES_MASK	(IEEE80211_CCK_RATE_1MB_MASK | \
 	IEEE80211_CCK_RATE_2MB_MASK)
-#define IEEE80211_CCK_DEFAULT_RATES_MASK	(IEEE80211_CCK_BASIC_RATES_MASK | \
-        IEEE80211_CCK_RATE_5MB_MASK | \
-        IEEE80211_CCK_RATE_11MB_MASK)
+#define IEEE80211_CCK_DEFAULT_RATES_MASK	\
+	(IEEE80211_CCK_BASIC_RATES_MASK |	\
+	 IEEE80211_CCK_RATE_5MB_MASK |		\
+	 IEEE80211_CCK_RATE_11MB_MASK)
 
 #define IEEE80211_OFDM_RATES_MASK		0x00000FF0
 #define IEEE80211_OFDM_BASIC_RATES_MASK	(IEEE80211_OFDM_RATE_6MB_MASK | \
@@ -359,8 +360,9 @@ struct ieee80211_snap_hdr {
 	IEEE80211_OFDM_RATE_36MB_MASK | \
 	IEEE80211_OFDM_RATE_48MB_MASK | \
 	IEEE80211_OFDM_RATE_54MB_MASK)
-#define IEEE80211_DEFAULT_RATES_MASK (IEEE80211_OFDM_DEFAULT_RATES_MASK | \
-                                IEEE80211_CCK_DEFAULT_RATES_MASK)
+#define IEEE80211_DEFAULT_RATES_MASK		\
+	(IEEE80211_OFDM_DEFAULT_RATES_MASK |	\
+	 IEEE80211_CCK_DEFAULT_RATES_MASK)
 
 #define IEEE80211_NUM_OFDM_RATES	    8
 #define IEEE80211_NUM_CCK_RATES	            4
@@ -509,7 +511,7 @@ Total: 28-2340 bytes
 
 static inline int is_multicast_mac_addr(const u8 *addr)
 {
-        return ((addr[0] != 0xff) && (0x01 & addr[0]));
+	return ((addr[0] != 0xff) && (0x01 & addr[0]));
 }
 
 static inline int is_broadcast_mac_addr(const u8 *addr)
@@ -612,17 +614,18 @@ enum {
  * @RTW_IEEE80211_CHAN_NO_HT40MINUS: extension channel below this channel
  *      is not permitted.
  */
-  enum rtw_ieee80211_channel_flags {
-          RTW_IEEE80211_CHAN_DISABLED         = 1<<0,
-          RTW_IEEE80211_CHAN_PASSIVE_SCAN     = 1<<1,
-          RTW_IEEE80211_CHAN_NO_IBSS          = 1<<2,
-          RTW_IEEE80211_CHAN_RADAR            = 1<<3,
-          RTW_IEEE80211_CHAN_NO_HT40PLUS      = 1<<4,
-          RTW_IEEE80211_CHAN_NO_HT40MINUS     = 1<<5,
-  };
-
-  #define RTW_IEEE80211_CHAN_NO_HT40 \
-          (RTW_IEEE80211_CHAN_NO_HT40PLUS | RTW_IEEE80211_CHAN_NO_HT40MINUS)
+enum rtw_ieee80211_channel_flags {
+	RTW_IEEE80211_CHAN_DISABLED         = 1<<0,
+	RTW_IEEE80211_CHAN_PASSIVE_SCAN     = 1<<1,
+	RTW_IEEE80211_CHAN_NO_IBSS          = 1<<2,
+	RTW_IEEE80211_CHAN_RADAR            = 1<<3,
+	RTW_IEEE80211_CHAN_NO_HT40PLUS      = 1<<4,
+	RTW_IEEE80211_CHAN_NO_HT40MINUS     = 1<<5,
+};
+
+#define RTW_IEEE80211_CHAN_NO_HT40	  \
+	(RTW_IEEE80211_CHAN_NO_HT40PLUS | \
+	 RTW_IEEE80211_CHAN_NO_HT40MINUS)
 
 /* Represent channel details, subset of ieee80211_channel */
 struct rtw_ieee80211_channel {
-- 
2.34.1

