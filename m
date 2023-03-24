Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B166C8866
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjCXWco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjCXWce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:32:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE2F17163
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:32:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r29so3154532wra.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679697102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmc+Yh3XTUiALV4q5vVltlntUVE9IZwmAKsrbcMIn8E=;
        b=TOehl8DELE79NdFccOToF+06ibX42eREC2NRuACv6k+1L5EILYAaJ7eaGX9WtfZZxg
         uH1lZE6QJMgtcXHVjDgZX7zSSBfw/3S1nfZWPB/PN2n97Omf9frrDP07axSF+nsSqDPI
         D8/wzXBg+IZsIfSQ0KvQ6KAuNXjD5CYIAf0JmUIO3fvPNuJb6f3HDwvull2tHzh2Qrg1
         QMmEemNJgr3lGUqPE+jlAh4LTFuBBCvI8fga+jlnSSy1f8j03ZU1boQoE47EgQUYTFqJ
         jEGJ4b5t5CyKAZYJJHcGzY/iJErLw+VbUUtFG0IWQc9N12pxwFu3cpXH4ylBgbfSH6gC
         zihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679697102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmc+Yh3XTUiALV4q5vVltlntUVE9IZwmAKsrbcMIn8E=;
        b=wRGFVCOk8VUZj2ma/Yd+OK4XbqYjAuXgbbh9Jywck37PlQoaDtnjaNUKRQdMLPzgII
         XKCQOwBQDhLHr0FkymtvTYlPUtv9JUb7Q7pkGt95Jwq4GYACfhQ636N81dWrIeUVrwWB
         4eqUbSzJTRf5DLfAlHX8qQuMwpvwAcZYA8JL/F0mpfBw+ICpyasu6ickPzSKA9q++IbB
         sEaADIGwxJlRmpOYcacU5lie5dysc0dsojl84AvTRhjlZxMPsDL48CJi0xpJ/4MSg+zk
         tP1qt7f6ERhIu9w5MsXAJGFH27VPkVsIrt12dIREqb4WbrziIFqXhrDdpV2Dy8Ks7cv+
         DGyg==
X-Gm-Message-State: AAQBX9cBJK0Uze2GH7pHP/+1u2tyKuc5KSzz7FXJWeoffFLn+kQFCB1R
        0en7fuuKHIi6USnAeGsWWq8=
X-Google-Smtp-Source: AKy350YW+ObTwB8qFEBil0ujwjLpj3qCbbiuQ6mZyifEicheKw+4GJ68D+e0FKPwPpuhRJ62pVsF/g==
X-Received: by 2002:adf:e683:0:b0:2ce:ae5b:27a2 with SMTP id r3-20020adfe683000000b002ceae5b27a2mr3107845wrm.17.1679697101860;
        Fri, 24 Mar 2023 15:31:41 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id d7-20020adffbc7000000b002d5a8d8442asm14984138wrs.37.2023.03.24.15.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 15:31:41 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] staging: rtl8192e: remove blank lines after '{'
Date:   Sat, 25 Mar 2023 03:31:31 +0500
Message-Id: <e7cd8152e6986d361f81289868040889224bd1bf.1679696777.git.kamrankhadijadj@gmail.com>
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

