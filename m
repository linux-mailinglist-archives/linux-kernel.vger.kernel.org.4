Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2930073602D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 01:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjFSXky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 19:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFSXkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:40:52 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43132FA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:40:51 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 745911A77F5;
        Mon, 19 Jun 2023 19:40:50 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        aAAVxZt3OcAzJzT3Vw4BIH/WePaWHP+313cOi4esorA=; b=gFTEalDnxItYfpEz
        OWntFEV9HAbWk1M+R3th2o4D5x2EPAZ/Zr0MoelKKby6r6gdzrDW3GWAwNkmK/l2
        OdQdFpcv8UWQYdDn+pQ/nnTYDlR1OpJYqNH9V9+q7BhB0PKeo3/sO2/7qv9BimBE
        zzLNARABWC+5XTgiEKpy3aGxhEg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C5721A77F3;
        Mon, 19 Jun 2023 19:40:50 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=aAAVxZt3OcAzJzT3Vw4BIH/WePaWHP+313cOi4esorA=;
 b=UgrziEdMRxCAEQ5lh2gunMGCHscB0/1jwOd9emUGqB4SIyG2m/ItcSkF4MglkPb0iS7YSUKbTwD22zw9ZW4eZ5pqa6xVzfFm3K2TEXrvwqgwXrT02hjUV8xrjpH05crL6E+b/Y1sXZFLdvnsgkPltOd+7locgaqoNziSpzRQbI0=
Received: from tacos.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3F5CC1A77F2;
        Mon, 19 Jun 2023 19:40:49 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Mon, 19 Jun 2023 16:40:42 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        t4rmin@zohomail.com, colin.i.king@gmail.com
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/staging/rtl8192e Fix camelcased function name
Message-ID: <ZJDnetEcwdG1ffrK@tacos.darkphysics>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BAfVaLZhwQdzqTy9"
Content-Disposition: inline
X-Pobox-Relay-ID: B8AE49A6-0EFA-11EE-8AC3-307A8E0A682E-45285927!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BAfVaLZhwQdzqTy9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


--BAfVaLZhwQdzqTy9
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-drivers-staging-rtl8192e-Fix-camelcased-function-nam.patch"

From b66f420d2129bb45e0dc79128e517524607cf3b3 Mon Sep 17 00:00:00 2001
From: Tree Davies <tdavies@darkphysics.net>
Date: Mon, 19 Jun 2023 14:06:33 -0700
Subject: [PATCH] drivers/staging/rtl8192e Fix camelcased function name

This fixes style issue for function name
HTUpdateDefaultSetting -> ht_update_default_setting

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_module.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index fe30a291e64c..117b675a210d 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -67,7 +67,7 @@ static u8 CISCO_BROADCOM[3] = {0x00, 0x17, 0x94};
 
 static u8 LINKSYS_MARVELL_4400N[3] = {0x00, 0x14, 0xa4};
 
-void HTUpdateDefaultSetting(struct rtllib_device *ieee)
+void ht_update_default_setting(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 6e665e866f1f..48b3c832affa 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2037,7 +2037,7 @@ int rtllib_wx_get_rts(struct rtllib_device *ieee, struct iw_request_info *info,
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


--BAfVaLZhwQdzqTy9--
