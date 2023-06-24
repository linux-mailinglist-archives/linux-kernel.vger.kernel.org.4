Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC7073CD5A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 00:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjFXWx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 18:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjFXWxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 18:53:54 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3D01710
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 15:53:53 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3492919AB93;
        Sat, 24 Jun 2023 18:53:49 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        1r5wGj+iTmjM6vRykrc6iY+IAD/mzB7x6qwzLAUQE6c=; b=Vr4PxkWOHBdgkbfc
        0MOXAtx0W1TIe5Svxn9lILxPpXGNaAPiFyBDWjKwHAw1+crhjbBCJlcqIChgJePO
        IicMaqnIQgKR+01p7Z+kJIcu2aQzX1Wg36GvdpyrM361z/UWLfKoXt+8PbU93nQi
        onNahAa5nD2ICkz47F2fzWdHP7g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CAD519AB92;
        Sat, 24 Jun 2023 18:53:49 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=1r5wGj+iTmjM6vRykrc6iY+IAD/mzB7x6qwzLAUQE6c=;
 b=nS60ygNpLoF5wTKg/inoxL4ffRwgR5AcxoWtZ+OsZ+q7Mm7RdSJ7fQ351bnXn1W/RZhv2GPuuedFO3QlD88U6DBJx3hMp9C8V+PH6sOS7sMDzQChZzDw3lFtZ1L+X0DZRwuj1/OK/p83Em2PH5vFjA0qlZYKTgUae7WoqnfRcdw=
Received: from tacos.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C1A119AB91;
        Sat, 24 Jun 2023 18:53:48 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Sat, 24 Jun 2023 15:53:42 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        dan.carpenter@linaro.org
Cc:     tdavies@darkphysics.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH] staging: rtl8192e: Rename function IsHTHalfNmodeAPs to
 is_ht_half_nmode_a_ps
Message-ID: <ZJdz9oWjPuE3xZ8Y@tacos.darkphysics>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: FB2CC614-12E1-11EE-88C6-C65BE52EC81B-45285927!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function IsHTHalfNmodeAPs to is_ht_half_nmode_a_ps in order to
fix checkpatch warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f9fa3f2bb728..6f9d79582519 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -139,7 +139,7 @@ u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate)
 	return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate & 0xf];
 }
 
-bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
+bool is_ht_half_nmode_a_ps(struct rtllib_device *ieee)
 {
 	bool			retValue = false;
 	struct rtllib_network *net = &ieee->current_network;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index e3ce4431d460..0b33f993077d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2003,7 +2003,7 @@ extern u8 MCS_FILTER_ALL[];
 extern u16 MCS_DATA_RATE[2][2][77];
 u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame);
 void HTResetIOTSetting(struct rt_hi_throughput *ht_info);
-bool IsHTHalfNmodeAPs(struct rtllib_device *ieee);
+bool is_ht_half_nmode_a_ps(struct rtllib_device *ieee);
 u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate);
 int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 425d4acbcdf0..589015caa7b0 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2224,7 +2224,7 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 		ieee->softmac_stats.rx_auth_rs_ok++;
 		if (!(ieee->ht_info->iot_action & HT_IOT_ACT_PURE_N_MODE)) {
 			if (!ieee->GetNmodeSupportBySecCfg(ieee->dev)) {
-				if (IsHTHalfNmodeAPs(ieee)) {
+				if (is_ht_half_nmode_a_ps(ieee)) {
 					bSupportNmode = true;
 					bHalfSupportNmode = true;
 				} else {
-- 
2.39.2

