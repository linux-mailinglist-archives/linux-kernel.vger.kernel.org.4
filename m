Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56E86C5947
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCVWHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjCVWHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:07:41 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4486A1A4BA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 15:07:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h8so78888953ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 15:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seecs.edu.pk; s=google; t=1679522859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weAoEEZiI2mKD//rUNwkb5TZGAcwsmwF1BER0SC0aPA=;
        b=IXWt4G2ZA3GukJB/z5rnjE2Wa9BXVCQGEfpPTDAh13aVrCWjr6FuvXKVggBShCxYkN
         Yntj9unSvSiwAnyCu1Xl+TGTotq2cx0ZwN3Cjk8y+Mgk2NL77R6qAyvSkUE27T9NR1Ef
         sy20YsS0BcXlyJXKeWjaVcXcVy8220hDcIAEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679522859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weAoEEZiI2mKD//rUNwkb5TZGAcwsmwF1BER0SC0aPA=;
        b=UlffYmMq2rfF2cgJb+Co/SygZu0CoYxTFSqFR/v73SEnvIG7zqYfBKA6kCNxvhSzOd
         jqoPSwgqb/aW+3p3M4RQbf22ZC/EOr3SxHJP+goAfM6aiPP4reFeoZgX1mskHO3ndmJn
         aG9ZE8+atWGYUDRBrvGCXmJUggNeh6bBD1QthWIMd66LLjDZZqRqbLLhChn+WshW4ETv
         Flu8hN2c+MJFVZgEUE7OEwXfKkl6RXQBPJRuHGUQ7LPcvJsVls+Vsi1B7qhbeXW9gRf8
         BH2gJPIf95xpd+2j+ZkdKbm2HKUmOGa+1M8EZMuCxhG8IU7nq8xEvbl9wj8jg0evGdIT
         Ua5Q==
X-Gm-Message-State: AO0yUKVKQ2PGqxkeHF5ra1Pi17P3/J2yiH0FxQkCCx1wo93iu0l2QTT5
        7VZYBoFZDbZugHKbFlM8zrmxVruwaPISCIma5IM=
X-Google-Smtp-Source: AK7set9mL7YFAbWNwcmS+drZUv7tSXxh/dqipCJRAzWc5sIUbkUEH1mhKIxWJhGALWQSn4Lowox+9A==
X-Received: by 2002:a17:907:765a:b0:8b1:7684:dfab with SMTP id kj26-20020a170907765a00b008b17684dfabmr9659463ejc.38.1679522858718;
        Wed, 22 Mar 2023 15:07:38 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm7787935ejk.114.2023.03.22.15.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 15:07:38 -0700 (PDT)
From:   Khadija Kamran <kkamran.bese16seecs@seecs.edu.pk>
X-Google-Original-From: Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Khadija Kamran <kamrankhadijadj@gmail.com>
Subject: [PATCH 3/4] staging: rtl8192e: add spaces around binary operators
Date:   Thu, 23 Mar 2023 03:07:03 +0500
Message-Id: <fe0a146fd5164a5105d71c3931ac334c9062327a.1679521517.git.kamrankhadijadj@gmail.com>
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

Use spaces around binary operators as suggested by Linux kernel coding
style.
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

