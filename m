Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC206C881E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjCXWKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjCXWKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:10:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEC51F5C1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:10:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i9so3160804wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679695802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmc+Yh3XTUiALV4q5vVltlntUVE9IZwmAKsrbcMIn8E=;
        b=bNPlIuYIBzrqhtaoy7xHmivpmU2OfSBWDYwRCu1ODldBBcHsmid5AeRgr7TiYc6p0H
         ZsiQFUqvyW9lYRiLcARM4JpKj6backof5tP9hyFQ72Db/gtBmusvPj57j+c0tfDGRJiO
         gp7nI9A5/sOHYU8x7D8WdiN4jFXM5/GpI6uhqPBMXik+LVROMKCXK1zTFIoRpfYEyUAD
         iBXhnXQGucRLIfx867s1r7vrrJmiUxtB1YxKrdXVJANyXMVTqxaFek+ArcBq/FsI+6Bm
         6cyFRw6NicPPYaCjNaMJDCMCw2OOCNN0vxDQRRgrlmLFlU1/EgXhmw3hiqgCvdt2ZXl0
         Y3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679695802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmc+Yh3XTUiALV4q5vVltlntUVE9IZwmAKsrbcMIn8E=;
        b=0hUHgJGXFJALFKabL2a/XP7T0fF/b024yWkazWV4e0FPpcDBPIxltRvk7wC9RoIoK/
         HhNNkTfBtjyzS2ouYb6Hd3+HJIyzpBDATkboe9W/dAmn7YOYI2SLGjTQGuw3ud6dvu91
         xmBNvAwNh1fDOOGPxkC4ye71zNfzNTQFXZDRroWgM0Oa+kBcdNj5Co0ygRwdDNR3/bhX
         E5qzyCQBusavYdituzIdEzVf1xWs8gBTCNPbLRVbnl7EFEHvbkdnGe2cuT7dM79FP6q8
         iK4pLG//SJv8/RbE7a3fGiy9hviXpsYND1AoZtZugA0GINSrz9A9O8MTd46WYSYf2vHD
         Ep2A==
X-Gm-Message-State: AAQBX9cN1JYTOtHPSzg8EkLY8znxBMqtmYD6RIxf12ASiSEFFS0HUqqd
        V0LZ0rmQoI4JsPTzzXWjTLY=
X-Google-Smtp-Source: AKy350Yk6TS348ocuPvtjqqhydMRLE5llnNXAN4RasfwNkcS/+7lIDOzkZt6YHeIH7cxc7jtilwDhA==
X-Received: by 2002:adf:f887:0:b0:2ce:a9e9:4905 with SMTP id u7-20020adff887000000b002cea9e94905mr3875825wrp.34.1679695802535;
        Fri, 24 Mar 2023 15:10:02 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id x12-20020a5d650c000000b002c5544b3a69sm19201736wru.89.2023.03.24.15.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 15:10:02 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] staging: rtl8192e: remove blank lines after '{'
Date:   Sat, 25 Mar 2023 03:09:51 +0500
Message-Id: <e7cd8152e6986d361f81289868040889224bd1bf.1679695111.git.kamrankhadijadj@gmail.com>
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

Remove unnecessary blank lines after an open brace to adhere to the
Linux kernel coding-style guidelines. These issues are reported by
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

