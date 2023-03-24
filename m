Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037866C8864
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjCXWce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjCXWcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:32:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C919218A85
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:32:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q19so118247wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679697097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHW/CyCQWbbVJjXUcNnqunHcb5Z7BkaW2HblBqM5Qy8=;
        b=lF8aSnuGs07w78dFpM5Y6jST1Xi8c2bJH0TU6U2bR0GpNl/vttBD48nkPPnVw31uhS
         sYUEMi3JHyIR510+aG+zQdNEQXgmsG8KXejsdESjn0yjg/u5Cpxs9yr2K3qZWG3m3+gQ
         F3gb29BXkefGJkGuZbgcq2uH6GTjo2t4QkD9LCmzs6Uhh7MQ+58GeTdGyFJAKRA0gtPa
         6+P9Chh87JvAWFjivD7Ok0j+8IChbVdcGsGQHQRDYTKgI6dwQ7P6Z7Xu62OBtz8BhbJ2
         kiUIDbjVM43ayevoxDSl6hD9CjoHmMi48wOkij9ZmyPnT+wgMdQUnGd6YuQcY21fi4L2
         UVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679697097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHW/CyCQWbbVJjXUcNnqunHcb5Z7BkaW2HblBqM5Qy8=;
        b=ax5W9vVyL40eVqAIESAs22vPjVtlxg0S9PEujcRGKSZFVSmd46ykWLXTfmn38KDb8Y
         /jlco0wxPUJL1dGyouvbDLw+ymBVak65NgOviV9SHdwYsZ1x47N/XOfsnQjGwcUhvyUH
         IrxwZRqcbjsLBOQ/u4m2R9aLg1GrzOc+39C6DR+ULfeXcrLyWR9MNsTmqT6Vu2pL31DD
         nIIwaiXw4kvDvpSTy3NqZAGQhGXlMk4zILigG51c7J6/i3J2XYvoipuh9ZiptNCcFGg/
         jLnT5bVtru1zEFwaQvtrKPEEoa/+peimTDGDieCDGpn2NqSNq+DB5ujrOLJT2UwPEUFq
         gPcw==
X-Gm-Message-State: AAQBX9e90znf9hgGclNGKkaus6iBrGWvNR25ZAZ9OvwctfMOOQ8qe46D
        ylg/tIc9uKV5v+iBPccR5MXPU/gDl/JVHA==
X-Google-Smtp-Source: AKy350a9UZDIiX005q9r6mmPw0t9DeoHB2kKoOS1rKdhV8GyhxQSNi8TEYKOWPPpLVUub2VqkoUk4g==
X-Received: by 2002:adf:dccc:0:b0:2d2:29a4:4457 with SMTP id x12-20020adfdccc000000b002d229a44457mr3436258wrm.13.1679697096706;
        Fri, 24 Mar 2023 15:31:36 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id d7-20020adffbc7000000b002d5a8d8442asm14984138wrs.37.2023.03.24.15.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 15:31:36 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] staging: rtl8192e: remove extra blank lines
Date:   Sat, 25 Mar 2023 03:31:28 +0500
Message-Id: <6d7388f944e8296227269c7472a462ea7c94149c.1679696777.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679696777.git.kamrankhadijadj@gmail.com>
References: <cover.1679696777.git.kamrankhadijadj@gmail.com>
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

Remove the extra blank line in accordance with the Linux kernel
coding-style regulations. These issues were reported by checkpatch.pl

"CHECK: Please don't use multiple blank lines"

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index c394c21beefb..c6114d99829b 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -154,7 +154,6 @@ rtllib_frag_cache_get(struct rtllib_device *ieee,
 	return skb;
 }
 
-
 /* Called only as a tasklet (software IRQ) */
 static int rtllib_frag_cache_invalidate(struct rtllib_device *ieee,
 					   struct rtllib_hdr_4addr *hdr)
@@ -318,7 +317,6 @@ rtllib_rx_frame_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 	return res;
 }
 
-
 /* Called only as a tasklet (software IRQ), by rtllib_rx */
 static inline int
 rtllib_rx_frame_decrypt_msdu(struct rtllib_device *ieee, struct sk_buff *skb,
@@ -355,7 +353,6 @@ rtllib_rx_frame_decrypt_msdu(struct rtllib_device *ieee, struct sk_buff *skb,
 	return 0;
 }
 
-
 /* this function is stolen from ipw2200 driver*/
 #define IEEE_PACKET_RETRY_TIME (5*HZ)
 static int is_duplicate_packet(struct rtllib_device *ieee,
@@ -887,7 +884,6 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 	return rxb->nr_subframes;
 }
 
-
 static size_t rtllib_rx_get_hdrlen(struct rtllib_device *ieee,
 				   struct sk_buff *skb,
 				   struct rtllib_rx_stats *rx_stats)
@@ -1569,7 +1565,6 @@ static int rtllib_verify_qos_info(struct rtllib_qos_information_element
 	return 0;
 }
 
-
 /* Parse a QoS parameter element */
 static int rtllib_read_qos_param_element(
 			struct rtllib_qos_parameter_info *element_param,
@@ -1599,7 +1594,6 @@ static int rtllib_read_qos_info_element(
 	return rtllib_verify_qos_info(element_info, QOS_OUI_INFO_SUB_TYPE);
 }
 
-
 /* Write QoS parameters from the ac parameters. */
 static int rtllib_qos_convert_ac_to_parameters(struct rtllib_qos_parameter_info *param_elm,
 					       struct rtllib_qos_data *qos_data)
@@ -1843,7 +1837,6 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 		}
 	}
 
-
 	if (*tmp_htinfo_len == 0) {
 		if (info_element->len >= 4 &&
 		    info_element->data[0] == 0x00 &&
@@ -1932,7 +1925,6 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 	    info_element->data[2] == 0x96)
 		network->cisco_cap_exist = true;
 
-
 	if (info_element->len >= 3 &&
 	    info_element->data[0] == 0x00 &&
 	    info_element->data[1] == 0x0a &&
@@ -2142,13 +2134,11 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 
 			network->dtim_data = RTLLIB_DTIM_VALID;
 
-
 			if (info_element->data[2] & 1)
 				network->dtim_data |= RTLLIB_DTIM_MBCAST;
 
 			offset = (info_element->data[2] >> 1)*2;
 
-
 			if (ieee->assoc_id < 8*offset ||
 			    ieee->assoc_id > 8*(offset + info_element->len - 3))
 				break;
@@ -2203,7 +2193,6 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 						 &tmp_htcap_len);
 			break;
 
-
 		case MFIE_TYPE_HT_INFO:
 			netdev_dbg(ieee->dev, "MFIE_TYPE_HT_INFO: %d bytes\n",
 				   info_element->len);
@@ -2392,7 +2381,6 @@ static inline int is_same_network(struct rtllib_network *src,
 		(dst->capability & WLAN_CAPABILITY_ESS)));
 }
 
-
 static inline void update_network(struct rtllib_device *ieee,
 				  struct rtllib_network *dst,
 				  struct rtllib_network *src)
@@ -2580,7 +2568,6 @@ static inline void rtllib_process_probe_response(
 		goto free_network;
 	}
 
-
 	if (!rtllib_legal_channel(ieee, network->channel))
 		goto free_network;
 
-- 
2.34.1

