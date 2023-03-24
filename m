Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A03B6C881D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjCXWKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjCXWKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:10:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947E517163
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:10:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y14so3153564wrq.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679695801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfo0BLzIV++drYzkU45P3MSEyypvlv0tFWK+3aZYqRo=;
        b=KtRipMNnMTzFh6YP+ZewZkDVdWFPWdmQNvW2BUoxsf6putKXIz5vH1Jj5xlZl8QlHh
         vpiZ/cKS7qt2tCSA/h4ZGfzMygg1M67OtsNwHsSyNJmjCS89wnFK1l+U+Pt0M1P4gG1l
         /9AKwxX6UroisK+aOB8wompussx6ltDKozwBbVaBqbjE0uFjhCcak1dClPceRKEbpWD4
         HRYHrgvKIFi+3enJOxOKt79mwhd9Xj2eYhfzkOoD4570oLix5hdOCroY8Cb+MUCPNknn
         2dYjaqELlE2ihyeNUHILmUb+aSHthhphWdGiU6ySi7cvlMMkcIXBTpJtTiYMeJaDNk6v
         CyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679695801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfo0BLzIV++drYzkU45P3MSEyypvlv0tFWK+3aZYqRo=;
        b=THf5oCJLAaeb5Vj2P0J2ExBK+s75iszQnX3mFAxGAfeZHfs5OyB6pVoE5Z4QtEo5Mu
         dP1kDKDS1MR0/yK6yi+u3IXuMIrOzPzPm/NMFLRtzhj3M6tnsa+kKIoeM1jHmt1gglcC
         htPdLIglXmYna6mEOh3INXbJDKJE1oVlA6g8YXnGkDuSJgJX0vLKjFJBJ6ORXwQ4qklT
         ufsKRShrTt4/EUQ1+pwWJm/0RMX3s6mMzokMdJ1QYhqb7hBskslcKCmcvYhfmYRg2Mm9
         vAE9zvleCHAygHuwx+hdixpw978NZG/vhxfyb39L/cb4+E8ca8q6U84kDo1qmIj7l2yO
         R5Hg==
X-Gm-Message-State: AAQBX9evwP92r0knsZlWPk+Y3Q9n370Zhl/t48K0YHgO/RsrZGkaXPve
        Ex6v9zrWW/F/FTQieLXkXF0b954cvLfcMvZ3
X-Google-Smtp-Source: AKy350aUi8rQQNrDCDHt6Jzk5bH1w5SVaxnL2V6tvNKMPfg/C7/im46sk7mSayhIKLhrR1SWmGFNZw==
X-Received: by 2002:a5d:4a89:0:b0:2ce:a835:83d4 with SMTP id o9-20020a5d4a89000000b002cea83583d4mr2787755wrq.27.1679695800886;
        Fri, 24 Mar 2023 15:10:00 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id x12-20020a5d650c000000b002c5544b3a69sm19201736wru.89.2023.03.24.15.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 15:10:00 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] staging: rtl8192e: add spaces around binary operators
Date:   Sat, 25 Mar 2023 03:09:50 +0500
Message-Id: <44a545cf8e99ebfdbfc3f5bb314f3828abe98558.1679695111.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679695111.git.kamrankhadijadj@gmail.com>
References: <cover.1679695111.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use spaces around binary operators as suggested by Linux kernel coding
style guidelines.
Issues reported by checkpatch.pl for the following binary operators:
	+ , - , * , | , <<

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 54 ++++++++++++++--------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 7144a0630ea6..f627dfe66d90 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -356,7 +356,7 @@ rtllib_rx_frame_decrypt_msdu(struct rtllib_device *ieee, struct sk_buff *skb,
 }
 
 /* this function is stolen from ipw2200 driver*/
-#define IEEE_PACKET_RETRY_TIME (5*HZ)
+#define IEEE_PACKET_RETRY_TIME (5 * HZ)
 static int is_duplicate_packet(struct rtllib_device *ieee,
 				      struct rtllib_hdr_4addr *header)
 {
@@ -936,7 +936,7 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 
 		if (GetTs(ieee, (struct ts_common_info **)&pRxTS, hdr->addr2,
 			(u8)Frame_QoSTID((u8 *)(skb->data)), RX_DIR, true)) {
-			if ((fc & (1<<11)) && (frag == pRxTS->rx_last_frag_num) &&
+			if ((fc & (1 << 11)) && (frag == pRxTS->rx_last_frag_num) &&
 			    (WLAN_GET_SEQ_SEQ(sc) == pRxTS->rx_last_seq_num))
 				return -1;
 			pRxTS->rx_last_frag_num = frag;
@@ -1619,23 +1619,23 @@ static int rtllib_qos_convert_ac_to_parameters(struct rtllib_qos_parameter_info
 		case 1:
 			/* BIT(0) | BIT(3) */
 			if (acm)
-				qos_data->wmm_acm |= (0x01<<0)|(0x01<<3);
+				qos_data->wmm_acm |= (0x01 << 0) | (0x01 << 3);
 			break;
 		case 2:
 			/* BIT(4) | BIT(5) */
 			if (acm)
-				qos_data->wmm_acm |= (0x01<<4)|(0x01<<5);
+				qos_data->wmm_acm |= (0x01 << 4) | (0x01 << 5);
 			break;
 		case 3:
 			/* BIT(6) | BIT(7) */
 			if (acm)
-				qos_data->wmm_acm |= (0x01<<6)|(0x01<<7);
+				qos_data->wmm_acm |= (0x01 << 6) | (0x01 << 7);
 			break;
 		case 0:
 		default:
 			/* BIT(1) | BIT(2) */
 			if (acm)
-				qos_data->wmm_acm |= (0x01<<1)|(0x01<<2);
+				qos_data->wmm_acm |= (0x01 << 1) | (0x01 << 2);
 			break;
 		}
 
@@ -1979,7 +1979,7 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 	    info_element->data[3] == 0x04) {
 		netdev_dbg(ieee->dev, "MFIE_TYPE_WZC: %d bytes\n",
 			   info_element->len);
-		network->wzc_ie_len = min(info_element->len+2, MAX_WZC_IE_LEN);
+		network->wzc_ie_len = min(info_element->len + 2, MAX_WZC_IE_LEN);
 		memcpy(network->wzc_ie, info_element, network->wzc_ie_len);
 	}
 }
@@ -2139,10 +2139,10 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 			if (info_element->data[2] & 1)
 				network->dtim_data |= RTLLIB_DTIM_MBCAST;
 
-			offset = (info_element->data[2] >> 1)*2;
+			offset = (info_element->data[2] >> 1) * 2;
 
-			if (ieee->assoc_id < 8*offset ||
-			    ieee->assoc_id > 8*(offset + info_element->len - 3))
+			if (ieee->assoc_id < 8 * offset ||
+			    ieee->assoc_id > 8 * (offset + info_element->len - 3))
 				break;
 
 			offset = (ieee->assoc_id / 8) - offset;
@@ -2357,7 +2357,7 @@ static inline int rtllib_network_init(
 	if (rtllib_is_empty_essid(network->ssid, network->ssid_len))
 		network->flags |= NETWORK_EMPTY_ESSID;
 	stats->signal = 30 + (stats->SignalStrength * 70) / 100;
-	stats->noise = rtllib_translate_todbm((u8)(100-stats->signal)) - 25;
+	stats->noise = rtllib_translate_todbm((u8)(100 - stats->signal)) - 25;
 
 	memcpy(&network->stats, stats, sizeof(network->stats));
 
@@ -2545,22 +2545,22 @@ static inline void rtllib_process_probe_response(
 		   "'%s' ( %pM ): %c%c%c%c %c%c%c%c-%c%c%c%c %c%c%c%c\n",
 		   escape_essid(info_element->data, info_element->len),
 		   beacon->header.addr3,
-		   (le16_to_cpu(beacon->capability) & (1<<0xf)) ? '1' : '0',
-		   (le16_to_cpu(beacon->capability) & (1<<0xe)) ? '1' : '0',
-		   (le16_to_cpu(beacon->capability) & (1<<0xd)) ? '1' : '0',
-		   (le16_to_cpu(beacon->capability) & (1<<0xc)) ? '1' : '0',
-		   (le16_to_cpu(beacon->capability) & (1<<0xb)) ? '1' : '0',
-		   (le16_to_cpu(beacon->capability) & (1<<0xa)) ? '1' : '0',
-		   (le16_to_cpu(beacon->capability) & (1<<0x9)) ? '1' : '0',
-		   (le16_to_cpu(beacon->capability) & (1<<0x8)) ? '1' : '0',
-		   (le16_to_cpu(beacon->capability) & (1<<0x7)) ? '1' : '0',
-		   (le16_to_cpu(beacon->capability) & (1<<0x6)) ? '1' : '0',
-		   (le16_to_cpu(beacon->capability) & (1<<0x5)) ? '1' : '0',
-		   (le16_to_cpu(beacon->capability) & (1<<0x4)) ? '1' : '0',
-		   (le16_to_cpu(beacon->capability) & (1<<0x3)) ? '1' : '0',
-		   (le16_to_cpu(beacon->capability) & (1<<0x2)) ? '1' : '0',
-		   (le16_to_cpu(beacon->capability) & (1<<0x1)) ? '1' : '0',
-		   (le16_to_cpu(beacon->capability) & (1<<0x0)) ? '1' : '0');
+		   (le16_to_cpu(beacon->capability) & (1 << 0xf)) ? '1' : '0',
+		   (le16_to_cpu(beacon->capability) & (1 << 0xe)) ? '1' : '0',
+		   (le16_to_cpu(beacon->capability) & (1 << 0xd)) ? '1' : '0',
+		   (le16_to_cpu(beacon->capability) & (1 << 0xc)) ? '1' : '0',
+		   (le16_to_cpu(beacon->capability) & (1 << 0xb)) ? '1' : '0',
+		   (le16_to_cpu(beacon->capability) & (1 << 0xa)) ? '1' : '0',
+		   (le16_to_cpu(beacon->capability) & (1 << 0x9)) ? '1' : '0',
+		   (le16_to_cpu(beacon->capability) & (1 << 0x8)) ? '1' : '0',
+		   (le16_to_cpu(beacon->capability) & (1 << 0x7)) ? '1' : '0',
+		   (le16_to_cpu(beacon->capability) & (1 << 0x6)) ? '1' : '0',
+		   (le16_to_cpu(beacon->capability) & (1 << 0x5)) ? '1' : '0',
+		   (le16_to_cpu(beacon->capability) & (1 << 0x4)) ? '1' : '0',
+		   (le16_to_cpu(beacon->capability) & (1 << 0x3)) ? '1' : '0',
+		   (le16_to_cpu(beacon->capability) & (1 << 0x2)) ? '1' : '0',
+		   (le16_to_cpu(beacon->capability) & (1 << 0x1)) ? '1' : '0',
+		   (le16_to_cpu(beacon->capability) & (1 << 0x0)) ? '1' : '0');
 
 	if (rtllib_network_init(ieee, beacon, network, stats)) {
 		netdev_dbg(ieee->dev, "Dropped '%s' ( %pM) via %s.\n",
-- 
2.34.1

