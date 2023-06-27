Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E90373F437
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjF0GHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjF0GHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:07:00 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BF012B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:06:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18D1E199795;
        Tue, 27 Jun 2023 02:06:57 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        vjszVLPOYJWQd7LQDozHI8ls+XVn3VGrAb2lTD4svG4=; b=HaTR0R9Wk75/on9B
        SZT3i7gY3X1WFGLqkIqAL0YZ+4sEiOIdww1aVRGoKYTbGbGacD+azOCdAPuFo/ei
        sWP1Si2bTjkzsax0LAGFWtsby/rQZMveCpepXg0iUgahYWNn8O10nCDs3nCl01IV
        nux+pdOwjGQZKtW7DGyWGzOf1tw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F815199794;
        Tue, 27 Jun 2023 02:06:57 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=vjszVLPOYJWQd7LQDozHI8ls+XVn3VGrAb2lTD4svG4=;
 b=ILZJR7aQTcOaC9iz+wj+mYcc1RZrsx8zTM8ZQe8aNep2tS53RzFsfAvYy7cqsoB9H4feocC2lu7+txWeNHtpiVhbYZrNNoKemaqrJ/iRHtictWJFQMoR9/dRvZRHL5H3y76OmMNFCAbuiE+b0s9tlJvx2KZgXhUvtBa3rMLPCkw=
Received: from tacos.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DFFD3199793;
        Tue, 27 Jun 2023 02:06:55 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Mon, 26 Jun 2023 23:06:42 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        dan.carpenter@linaro.org
Cc:     tdavies@darkphysics.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v2] staging: rtl8192e: Rename function IsHTHalfNmodeAPs to
 is_ht_half_nmode_aps
Message-ID: <ZJp8cug8OwyvcLbD@tacos.darkphysics>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: D1EDD31C-14B0-11EE-95D4-307A8E0A682E-45285927!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function IsHTHalfNmodeAPs to is_ht_half_nmode_aps in order to
fix checkpatch warning: Avoid CamelCase

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
v2: Rename is_ht_half_nmode_a_ps -> is_ht_half_nmode_aps
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f9fa3f2bb728..d09342dde61d 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -139,7 +139,7 @@ u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate)
 	return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate & 0xf];
 }
 
-bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
+bool is_ht_half_nmode_aps(struct rtllib_device *ieee)
 {
 	bool			retValue = false;
 	struct rtllib_network *net = &ieee->current_network;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index e3ce4431d460..293eb9315d99 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2003,7 +2003,7 @@ extern u8 MCS_FILTER_ALL[];
 extern u16 MCS_DATA_RATE[2][2][77];
 u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame);
 void HTResetIOTSetting(struct rt_hi_throughput *ht_info);
-bool IsHTHalfNmodeAPs(struct rtllib_device *ieee);
+bool is_ht_half_nmode_aps(struct rtllib_device *ieee);
 u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate);
 int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 425d4acbcdf0..05740e90d1c6 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2224,7 +2224,7 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 		ieee->softmac_stats.rx_auth_rs_ok++;
 		if (!(ieee->ht_info->iot_action & HT_IOT_ACT_PURE_N_MODE)) {
 			if (!ieee->GetNmodeSupportBySecCfg(ieee->dev)) {
-				if (IsHTHalfNmodeAPs(ieee)) {
+				if (is_ht_half_nmode_aps(ieee)) {
 					bSupportNmode = true;
 					bHalfSupportNmode = true;
 				} else {
-- 
2.39.2

