Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E515C73CCD7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 23:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjFXV5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 17:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFXV5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 17:57:06 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4115E6B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 14:57:04 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B11E2B553;
        Sat, 24 Jun 2023 17:57:04 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        HtyGkaX63IukexMf6HGIeT2EEzI9A0nt1AneQdVQiwc=; b=NA4KTVy//ONfjzN+
        JuZWdtGJOthF5SXSRoLu9LgJaqbKxClXwDPB2sAtw+qT8Auq7vbO3EerMi4IlDA2
        lav2zmeHJ32Fu/u/h5PHmhcJDRGhQw4/T19cDndDbdzZalVzMqoC691B479CXlxn
        puwXzhcesfrw2Qk0kSM0uVWseNg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 531812B551;
        Sat, 24 Jun 2023 17:57:04 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=HtyGkaX63IukexMf6HGIeT2EEzI9A0nt1AneQdVQiwc=;
 b=Y/QtsQNeKNmiq9DYVa+KGwFN7aHD7dF9j7MRHhfGONUNWBHdS4rh82NbJMWl0U6OUbGeyDSMb16Fjd0uWlADpTiABGuLbDQ14CtkYuKzPXpWWTDYVTpsAi7RphT32Q1Gkj200iRej1Om9lEwyHzQFx3QtfOxBsPUcwRqdvZ8ef8=
Received: from tacos.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6C32F2B54F;
        Sat, 24 Jun 2023 17:57:01 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Sat, 24 Jun 2023 14:56:55 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        dan.carpenter@linaro.org
Cc:     tdavies@darkphysics.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH] staging: rtl8192e: Rename function HTUpdateDefaultSetting to
 ht_update_default_setting
Message-ID: <ZJdmp3PAOAIqC3Zo@tacos.darkphysics>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: 0C6574E2-12DA-11EE-8AE5-B31D44D1D7AA-45285927!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename HTUpdateDefaultSetting to ht_update_default_setting in order to
Fix checkpatch warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_module.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f9fa3f2bb728..f526d04839bf 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -67,7 +67,7 @@ static u8 CISCO_BROADCOM[3] = {0x00, 0x17, 0x94};
 
 static u8 LINKSYS_MARVELL_4400N[3] = {0x00, 0x14, 0xa4};
 
-void HTUpdateDefaultSetting(struct rtllib_device *ieee)
+void ht_update_default_setting(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index e3ce4431d460..405033c7ed77 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1982,7 +1982,7 @@ int rtllib_wx_get_rts(struct rtllib_device *ieee, struct iw_request_info *info,
 void HTSetConnectBwMode(struct rtllib_device *ieee,
 			enum ht_channel_width bandwidth,
 			enum ht_extchnl_offset Offset);
-void HTUpdateDefaultSetting(struct rtllib_device *ieee);
+void ht_update_default_setting(struct rtllib_device *ieee);
 void HTConstructCapabilityElement(struct rtllib_device *ieee,
 				  u8 *posHTCap, u8 *len,
 				  u8 isEncrypt, bool bAssoc);
diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index d6a4d6b4ec57..841300e3a8bc 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -129,7 +129,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
 	if (!ieee->ht_info)
 		goto free_softmac;
 
-	HTUpdateDefaultSetting(ieee);
+	ht_update_default_setting(ieee);
 	HTInitializeHTInfo(ieee);
 	TSInitialize(ieee);
 	for (i = 0; i < IEEE_IBSS_MAC_HASH_SIZE; i++)
-- 
2.39.2

