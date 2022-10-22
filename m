Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA997608E3D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 17:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJVPs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 11:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJVPsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 11:48:40 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3A22502BA
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 08:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666453708; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=JM5T3Zkkm8NPlF/YuZuVcVxOShXJxYdkVcTHatIUERlkPgfbYyq+902z5HK8gxhv+1Qh5vTSCGDhWJu7rKWWBRIKb2jY9+WVap9swV4mQntvcb/bzz7J9tdScwFnFsZrgSZTXW0hU9kDdJsFEsTHbwYzGTOhaVj5fERxfU2DvB8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666453708; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Reply-To:Subject:To; 
        bh=7n3AzGJp+qgI3aXHmFebm/ddxux/JVgU5/J1QYI6m1o=; 
        b=FJEuWY5ilPliQecm/2JjnkOrNKm092lAIV2QMWcR8mhrn/MtxMsBqSO53pVufzKVlYnWxvBRIDmghxIMk5eUwfqtS0GuKDOIqlJfKJCF9SlqOW+vDmHIC4xKkHrzPnPiiPL9+r+rzVjZvuZJ1JOZKYJ5zGoKfTMOWVous0Hcu1s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666453708;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Message-ID:Subject:Subject:From:From:Reply-To:Reply-To:To:To:Cc:Cc:Date:Date:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id;
        bh=7n3AzGJp+qgI3aXHmFebm/ddxux/JVgU5/J1QYI6m1o=;
        b=SlI1PH1/NNhBExf0C7Nzr0iNwrDGAtoOkF+1E2UI1CTMB32OEJk1JFSn4n2e9ju1
        7NMqnrwzVskunkb+m8h0JBFd4Ep8iSrBtRYsrL2QDu0npeaA2KnNcaMvTPG4y3bDr0a
        XOY9v5vIcP+QOqRfdFhQm+4TDlOoAFoC96l4dgcc=
Received: from [192.168.0.106] (101.128.127.165 [101.128.127.165]) by mx.zohomail.com
        with SMTPS id 1666453707105578.6502431092244; Sat, 22 Oct 2022 08:48:27 -0700 (PDT)
Message-ID: <d9fa3773aa414f9eb5f5dcb23de2685a57adc1eb.camel@zohomail.com>
Subject: [PATCH 2/3] Staging: rtl8192e: rtl819x_HTProc: fixed alignment
 matching open parenthesis
From:   Aaron Lawrence <t4rmin@zohomail.com>
Reply-To: cover.1666450553.git.t4rmin@zohomail.com
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Sat, 22 Oct 2022 22:48:22 +0700
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 98c9e764a4447ab550e5615c48f6a98bf6656b0d Mon Sep 17 00:00:00 2001
Message-Id: <98c9e764a4447ab550e5615c48f6a98bf6656b0d.1666450553.git.t4rmin=
@zohomail.com>
In-Reply-To: <cover.1666450553.git.t4rmin@zohomail.com>
References: <cover.1666450553.git.t4rmin@zohomail.com>
From: Aaron Lawrence <t4rmin@zohomail.com>
Date: Sat, 22 Oct 2022 20:48:53 +0700
Subject: [PATCH 2/3] Staging: rtl8192e: rtl819x_HTProc: fixed alignment
 matching open parenthesis

Aligned multiple statements to match open parenthesis as per Linux kernel
coding-style regulations. The issues were flagged by the checkpatch script.

Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 25 ++++++++++++-----------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rt=
l8192e/rtl819x_HTProc.c
index b763cf0ba356..a701be8c2923 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -152,8 +152,8 @@ bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
 (net->ralink_cap_exist))
 retValue =3D true;
 else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
- !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
- !memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ||
+ !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
+ !memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ||
 (net->broadcom_cap_exist))
 retValue =3D true;
 else if (net->bssht.bd_rt2rt_aggregation)
@@ -540,7 +540,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 pPeerHTCap, sizeof(struct ht_capab_ele));
 #endif
 HTSetConnectBwMode(ieee, (enum ht_channel_width)(pPeerHTCap->ChlWidth),
- (enum ht_extchnl_offset)(pPeerHTInfo->ExtChlOffset));
+ (enum ht_extchnl_offset)(pPeerHTInfo->ExtChlOffset));
 pHTInfo->cur_tx_bw40mhz =3D ((pPeerHTInfo->RecommemdedTxWidth =3D=3D 1) ?
 true : false);
@@ -566,9 +566,9 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 pHTInfo->bCurrentAMPDUEnable =3D pHTInfo->bAMPDUEnable;
 if (ieee->rtllib_ap_sec_type &&
- (ieee->rtllib_ap_sec_type(ieee) & (SEC_ALG_WEP | SEC_ALG_TKIP))) {
+ (ieee->rtllib_ap_sec_type(ieee) & (SEC_ALG_WEP | SEC_ALG_TKIP))) {
 if ((pHTInfo->IOTPeer =3D=3D HT_IOT_PEER_ATHEROS) ||
- (pHTInfo->IOTPeer =3D=3D HT_IOT_PEER_UNKNOWN))
+ (pHTInfo->IOTPeer =3D=3D HT_IOT_PEER_UNKNOWN))
 pHTInfo->bCurrentAMPDUEnable =3D false;
 }
@@ -617,7 +617,8 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 else
 pMcsFilter =3D MCS_FILTER_ALL;
 ieee->HTHighestOperaRate =3D HTGetHighestMCSRate(ieee,
- ieee->dot11HTOperationalRateSet, pMcsFilter);
+ ieee->dot11HTOperationalRateSet,
+ pMcsFilter);
 ieee->HTCurrentOperaRate =3D ieee->HTHighestOperaRate;
 pHTInfo->current_op_mode =3D pPeerHTInfo->OptMode;
@@ -644,13 +645,13 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 pHTInfo->CurrentAMPDUFactor =3D pHTInfo->AMPDU_Factor;
 memset((void *)(&(pHTInfo->SelfHTCap)), 0,
- sizeof(pHTInfo->SelfHTCap));
+ sizeof(pHTInfo->SelfHTCap));
 memset((void *)(&(pHTInfo->SelfHTInfo)), 0,
- sizeof(pHTInfo->SelfHTInfo));
+ sizeof(pHTInfo->SelfHTInfo));
 memset((void *)(&(pHTInfo->PeerHTCapBuf)), 0,
- sizeof(pHTInfo->PeerHTCapBuf));
+ sizeof(pHTInfo->PeerHTCapBuf));
 memset((void *)(&(pHTInfo->PeerHTInfoBuf)), 0,
- sizeof(pHTInfo->PeerHTInfoBuf));
+ sizeof(pHTInfo->PeerHTInfoBuf));
 pHTInfo->sw_bw_in_progress =3D false;
@@ -803,8 +804,8 @@ void HTUseDefaultSetting(struct rtllib_device *ieee)
 HTFilterMCSRate(ieee, ieee->Regdot11TxHTOperationalRateSet,
 ieee->dot11HTOperationalRateSet);
 ieee->HTHighestOperaRate =3D HTGetHighestMCSRate(ieee,
- ieee->dot11HTOperationalRateSet,
- MCS_FILTER_ALL);
+ ieee->dot11HTOperationalRateSet,
+ MCS_FILTER_ALL);
 ieee->HTCurrentOperaRate =3D ieee->HTHighestOperaRate;
 } else {
--=20
2.38.1



