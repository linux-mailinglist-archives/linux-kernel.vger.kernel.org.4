Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E2173794F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjFUCoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjFUCoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:44:03 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402FC10FE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:44:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1DA952D5A5;
        Tue, 20 Jun 2023 22:44:01 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        54Z7jJ+Kyotg5skw2+QctgqLVM/dhHJr6W+Kb9NZKTE=; b=fHXL3S2gvtWJGBJp
        DvGLt7b7t5LzqKxDhEqyR+srrMrHCbPx7whpkTQmMLEoCWCGOuBob765oEI72qAm
        C0dsEi9Fy5jgVDCNSnq7dGkb9w63vv2YP99TI3zUwtUVJ9HAekvRpYdSd1lPTdQH
        IuAuNvhTUEqrXl4vTtJ2BVI1okU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 161342D5A4;
        Tue, 20 Jun 2023 22:44:01 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=54Z7jJ+Kyotg5skw2+QctgqLVM/dhHJr6W+Kb9NZKTE=;
 b=UskzF1gPZb/qHBUTzMo2NzPCvqSZjVkrIUVvq/jzTJP7dK4yc7w3CZU4+nY51K0ZTC8DQEIzgYy3v+hjVziDko2C5guKGLiwOWUi76npdRJVL67i9JEbHsNGVUuEG7M76nI24xTGQCv8WNRLWLpOgaILqU0Ui2TqOeHfKOvPwls=
Received: from tacos.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0D0132D5A0;
        Tue, 20 Jun 2023 22:43:58 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Tue, 20 Jun 2023 19:43:52 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        t4rmin@zohomail.com, colin.i.king@gmail.com,
        dan.carpenter@linaro.org
Cc:     tdavies@darkphysics.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v2] staging: rtl8192e: Remove whitespace and blank lines
Message-ID: <ZJJj6Bea1ahxNdr3@tacos.darkphysics>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: 78A6B0A8-0FDD-11EE-8F8D-B31D44D1D7AA-45285927!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up extraneous whitespace for the
struct rt_hi_throughput definition.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Fix subject line and send patch inline.
 drivers/staging/rtl8192e/rtl819x_HT.h | 63 ++++++++++-----------------
 1 file changed, 23 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index f4e9fa849796..f5ab19694f1a 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -96,70 +96,53 @@ enum ht_aggre_mode {
 
 
 struct rt_hi_throughput {
-	u8				enable_ht;
-	u8				bCurrentHTSupport;
-
-	u8				bRegBW40MHz;
-	u8				bCurBW40MHz;
-
-	u8				bRegShortGI40MHz;
-	u8				bCurShortGI40MHz;
-
-	u8				bRegShortGI20MHz;
-	u8				bCurShortGI20MHz;
-
-	u8				bRegSuppCCK;
-	u8				bCurSuppCCK;
-
+	u8 enable_ht;
+	u8 bCurrentHTSupport;
+	u8 bRegBW40MHz;
+	u8 bCurBW40MHz;
+	u8 bRegShortGI40MHz;
+	u8 bCurShortGI40MHz;
+	u8 bRegShortGI20MHz;
+	u8 bCurShortGI20MHz;
+	u8 bRegSuppCCK;
+	u8 bCurSuppCCK;
 	enum ht_spec_ver ePeerHTSpecVer;
-
-
 	struct ht_capab_ele SelfHTCap;
 	struct ht_info_ele SelfHTInfo;
-
-	u8				PeerHTCapBuf[32];
-	u8				PeerHTInfoBuf[32];
-
-
-	u8				bAMSDU_Support;
-	u16				nAMSDU_MaxSize;
-	u8				bCurrent_AMSDU_Support;
-	u16				nCurrent_AMSDU_MaxSize;
-
-	u8				bAMPDUEnable;
-	u8				bCurrentAMPDUEnable;
-	u8				AMPDU_Factor;
-	u8				CurrentAMPDUFactor;
-	u8				MPDU_Density;
+	u8 PeerHTCapBuf[32];
+	u8 PeerHTInfoBuf[32];
+	u8 bAMSDU_Support;
+	u16	nAMSDU_MaxSize;
+	u8 bCurrent_AMSDU_Support;
+	u16	nCurrent_AMSDU_MaxSize;
+	u8 bAMPDUEnable;
+	u8 bCurrentAMPDUEnable;
+	u8 AMPDU_Factor;
+	u8 CurrentAMPDUFactor;
+	u8 MPDU_Density;
 	u8 current_mpdu_density;
-
 	enum ht_aggre_mode ForcedAMPDUMode;
 	u8 forced_ampdu_factor;
 	u8 forced_mpdu_density;
-
 	enum ht_aggre_mode ForcedAMSDUMode;
 	u8 forced_short_gi;
-
 	u8 current_op_mode;
-
 	u8 self_mimo_ps;
 	u8 peer_mimo_ps;
-
 	enum ht_extchnl_offset CurSTAExtChnlOffset;
 	u8 cur_tx_bw40mhz;
 	u8 sw_bw_in_progress;
 	u8 reg_rt2rt_aggregation;
-	u8				RT2RT_HT_Mode;
+	u8 RT2RT_HT_Mode;
 	u8 current_rt2rt_aggregation;
 	u8 current_rt2rt_long_slot_time;
 	u8 sz_rt2rt_agg_buf[10];
-
 	u8 reg_rx_reorder_enable;
 	u8 cur_rx_reorder_enable;
 	u8 rx_reorder_win_size;
 	u8 rx_reorder_pending_time;
 	u16 rx_reorder_drop_counter;
-	u8				IOTPeer;
+	u8 IOTPeer;
 	u32 iot_action;
 	u8 iot_ra_func;
 } __packed;
-- 
2.39.2

