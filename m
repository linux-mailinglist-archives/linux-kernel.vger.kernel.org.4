Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F34736103
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjFTBOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFTBOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:14:07 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911B4FC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:14:05 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0F7018F078;
        Mon, 19 Jun 2023 21:14:01 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        aS0J1Uw8m29Aa7EWYyWo8GVsTFRzUqH8W+PrIeCFfvg=; b=dXqhzhraXtMUCUqt
        AuqXDfx6iQkvPTwJImUX2G9iwwNfA1ueEVTROZozs01xqevfUhVgKfQfiptYa2Gd
        BQzCl3+oQrkGvWYsXVCG4vLJ88c673YCggWUJlOIidJeXxa92OujxsQCV1cwkiwN
        6NeNF1joVtJCfCTY5Z7eUFRSBSc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E36A418F077;
        Mon, 19 Jun 2023 21:14:01 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=aS0J1Uw8m29Aa7EWYyWo8GVsTFRzUqH8W+PrIeCFfvg=;
 b=U2WJC2STyw10C9GkrouthrA2HFj5FW2iJ8xmJEzwKUgbXR2MkeGzz43wUIzqm/cokpchQ8rm6EdNQEzgXpCZHmgHrgmJltswfkxuln7gnTpCjBbvB6MXUWuhsIlLBfcbc9u1pA5LWX1S1TMMsgVSvQgsDm7ML/OFBnzyBU4lFRI=
Received: from tacos.darkphysics (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A292618F075;
        Mon, 19 Jun 2023 21:14:00 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Mon, 19 Jun 2023 18:13:55 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        t4rmin@zohomail.com, colin.i.king@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/staging/rtl8192e Style guide whitespace cleanup
Message-ID: <ZJD9U6y9RGIpeVDh@tacos.darkphysics>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="QD+4AXfZG5t6pQfx"
Content-Disposition: inline
X-Pobox-Relay-ID: BD54B3C0-0F07-11EE-BD6A-C65BE52EC81B-45285927!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QD+4AXfZG5t6pQfx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


--QD+4AXfZG5t6pQfx
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-drivers-staging-rtl8192e-Style-guide-whitespace-clea.patch"

From 25f4faf714f0e957996b9245f7e8c219080ad69b Mon Sep 17 00:00:00 2001
From: Tree Davies <tdavies@darkphysics.net>
Date: Mon, 19 Jun 2023 17:31:47 -0700
Subject: [PATCH] drivers/staging/rtl8192e Style guide whitespace cleanup

This patch cleans up extraneous whitespace for the
struct rt_hi_throughput definition.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
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


--QD+4AXfZG5t6pQfx--
