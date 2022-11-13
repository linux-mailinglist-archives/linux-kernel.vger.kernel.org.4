Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60275626DB1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 05:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiKMEfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 23:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbiKMEfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 23:35:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0266012D2E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:35:31 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bs21so11619567wrb.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+xSpqv/MkVFvfAJFl0bb4h6TCaeJGIx/kL5+ZcR/XYY=;
        b=KCHCCF+fs7xSAHId4LUhcGUtbge3q7a3kRbhnRfcT00F36IOJW8a5/VrJ2si8vw/d9
         kwEz8zdxD7p49ttNY/gu49Jix1LJyjemTo4iOTDHc0HHh2upleGJL14+1qdLSXg9p4PJ
         NSOYu/fQLM7VU5f1D1YwTC+yaAvQMWiy8XfALuTp7tdtZdy16r76RgWUsG5y0CaV6XvK
         Rx6ANOswaqztthW5VthKBbNK0hiouqedAacaqg4rB0vNBRkazmqGK3IEn591q9zuQF9g
         lX3vN/4Wp0saojKK2VJxH0lSAyZag6HqzwU8o+U8hV3bZPo0nHhqRgnyAkuz4H9aQ3Oo
         sGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xSpqv/MkVFvfAJFl0bb4h6TCaeJGIx/kL5+ZcR/XYY=;
        b=CaHb3i4mbrIEaZvzkwDiHLdFY7ImgBUKTfq8W8RtjhCB8TqONRxssKuTEuIhuTtKEH
         RPr/zcTE28XgnLNx/ahHwsXgKsSZHI3rLMV6shrpnyfYMbMd+Smg1fnK+dyO5fdfQ+sE
         C9kqwiLIMES4kniLobnPCPj4bJkH2QEMmx2ejPmFbrOuuoo0qKsFKiQGP5fUk9dWOf6h
         wm6Z+UpVV+ryySpyvGikvnpmCfIY4CI4k8HCE52G2TzBAcKXg81l6u1jBsIPTwux7dXO
         ORD159a7oYCvTDOHO4PmDmgGA0LmgQqO8lBTVxq67KYI6jBzjOMlhSq8UT6Wr28a+M3N
         OH8A==
X-Gm-Message-State: ANoB5pmjPcq9/d0YhyBPWHUVMeYWs0SNVywBlzMopc8rWvyAV+bYOvrw
        bPr+ij960/Bs90ufik++oHb7sZDPRnM=
X-Google-Smtp-Source: AA0mqf7yfxn2zSlaA4ryJjS6to7i+1FvQKyp0PZ4KbD8a5QuLOpEA6hIR4tP04xu27gaH5KebROWRQ==
X-Received: by 2002:a5d:4144:0:b0:236:6f90:3edb with SMTP id c4-20020a5d4144000000b002366f903edbmr4396723wrq.20.1668314129456;
        Sat, 12 Nov 2022 20:35:29 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id l1-20020a5d6741000000b002365cd93d05sm5768090wrw.102.2022.11.12.20.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 20:35:29 -0800 (PST)
Date:   Sun, 13 Nov 2022 05:35:27 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] staging: rtl8192e: Rename Regdot11TxHT..,
 dot11HTOpera.. and RegHTSuppRa..
Message-ID: <0c87e7ffc94be1c26f6400f5e12419f2df0418a3.1668313325.git.philipp.g.hortmann@gmail.com>
References: <cover.1668313325.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668313325.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable Regdot11TxHTOperationalRateSet to
reg_dot11tx_ht_oper_rate_set, dot11HTOperationalRateSet to
dot11ht_oper_rate_set and RegHTSuppRateSet to reg_ht_supp_rate_set to
avoid CamelCase which is not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   |  6 +++---
 drivers/staging/rtl8192e/rtl819x_HTProc.c      | 14 +++++++-------
 drivers/staging/rtl8192e/rtllib.h              |  6 +++---
 drivers/staging/rtl8192e/rtllib_softmac.c      | 10 +++++-----
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 39aac83d8960..bbaf20fbfde0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1958,7 +1958,7 @@ void rtl92e_update_ratr_table(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rtllib_device *ieee = priv->rtllib;
-	u8 *pMcsRate = ieee->dot11HTOperationalRateSet;
+	u8 *pMcsRate = ieee->dot11ht_oper_rate_set;
 	u32 ratr_value = 0;
 	u16 rate_config = 0;
 	u8 rate_index = 0;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 16e15b8e1b7a..d5eec6d6b644 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -608,9 +608,9 @@ static void _rtl92e_refresh_support_rate(struct r8192_priv *priv)
 	if (ieee->mode == WIRELESS_MODE_N_24G ||
 	    ieee->mode == WIRELESS_MODE_N_5G) {
 		memcpy(ieee->reg_dot11ht_oper_rate_set,
-		       ieee->RegHTSuppRateSet, 16);
-		memcpy(ieee->Regdot11TxHTOperationalRateSet,
-		       ieee->RegHTSuppRateSet, 16);
+		       ieee->reg_ht_supp_rate_set, 16);
+		memcpy(ieee->reg_dot11tx_ht_oper_rate_set,
+		       ieee->reg_ht_supp_rate_set, 16);
 
 	} else {
 		memset(ieee->reg_dot11ht_oper_rate_set, 0, 16);
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 52f41562dd82..2092ebf717a1 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -489,7 +489,7 @@ static u8 HTFilterMCSRate(struct rtllib_device *ieee, u8 *pSupportMCS,
 	u8 i;
 
 	for (i = 0; i <= 15; i++)
-		pOperateMCS[i] = ieee->Regdot11TxHTOperationalRateSet[i] &
+		pOperateMCS[i] = ieee->reg_dot11tx_ht_oper_rate_set[i] &
 				 pSupportMCS[i];
 
 	HT_PickMCSRate(ieee, pOperateMCS);
@@ -604,7 +604,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 
 	HTIOTActDetermineRaFunc(ieee, ((pPeerHTCap->MCS[1]) != 0));
 
-	HTFilterMCSRate(ieee, pPeerHTCap->MCS, ieee->dot11HTOperationalRateSet);
+	HTFilterMCSRate(ieee, pPeerHTCap->MCS, ieee->dot11ht_oper_rate_set);
 
 	pHTInfo->peer_mimo_ps = pPeerHTCap->MimoPwrSave;
 	if (pHTInfo->peer_mimo_ps == MIMO_PS_STATIC)
@@ -612,7 +612,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	else
 		pMcsFilter = MCS_FILTER_ALL;
 	ieee->HTHighestOperaRate = HTGetHighestMCSRate(ieee,
-						       ieee->dot11HTOperationalRateSet,
+						       ieee->dot11ht_oper_rate_set,
 						       pMcsFilter);
 	ieee->HTCurrentOperaRate = ieee->HTHighestOperaRate;
 
@@ -661,7 +661,7 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 	pHTInfo->iot_ra_func = 0;
 
 	{
-		u8 *RegHTSuppRateSets = &ieee->RegHTSuppRateSet[0];
+		u8 *RegHTSuppRateSets = &ieee->reg_ht_supp_rate_set[0];
 
 		RegHTSuppRateSets[0] = 0xFF;
 		RegHTSuppRateSets[1] = 0xFF;
@@ -796,10 +796,10 @@ void HTUseDefaultSetting(struct rtllib_device *ieee)
 
 		pHTInfo->current_mpdu_density = pHTInfo->current_mpdu_density;
 
-		HTFilterMCSRate(ieee, ieee->Regdot11TxHTOperationalRateSet,
-				ieee->dot11HTOperationalRateSet);
+		HTFilterMCSRate(ieee, ieee->reg_dot11tx_ht_oper_rate_set,
+				ieee->dot11ht_oper_rate_set);
 		ieee->HTHighestOperaRate = HTGetHighestMCSRate(ieee,
-							       ieee->dot11HTOperationalRateSet,
+							       ieee->dot11ht_oper_rate_set,
 							       MCS_FILTER_ALL);
 		ieee->HTCurrentOperaRate = ieee->HTHighestOperaRate;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index d80883b211ce..487aa337eafa 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1436,9 +1436,9 @@ struct rtllib_device {
 
 	spinlock_t reorder_spinlock;
 	u8	reg_dot11ht_oper_rate_set[16];
-	u8	Regdot11TxHTOperationalRateSet[16];
-	u8	dot11HTOperationalRateSet[16];
-	u8	RegHTSuppRateSet[16];
+	u8	reg_dot11tx_ht_oper_rate_set[16];
+	u8	dot11ht_oper_rate_set[16];
+	u8	reg_ht_supp_rate_set[16];
 	u8	HTCurrentOperaRate;
 	u8	HTHighestOperaRate;
 	u8	tx_dis_rate_fallback;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 498febc88b15..09cc3b3068cc 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1532,7 +1532,7 @@ static void rtllib_associate_complete_wq(void *data)
 			    "Successfully associated, ht not enabled(%d, %d)\n",
 			    ieee->pHTInfo->bCurrentHTSupport,
 			    ieee->pHTInfo->bEnableHT);
-		memset(ieee->dot11HTOperationalRateSet, 0, 16);
+		memset(ieee->dot11ht_oper_rate_set, 0, 16);
 	}
 	ieee->LinkDetectInfo.SlotNum = 2 * (1 +
 				       ieee->current_network.beacon_interval /
@@ -1728,7 +1728,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 					netdev_info(ieee->dev,
 						    "Using B rates\n");
 				}
-				memset(ieee->dot11HTOperationalRateSet, 0, 16);
+				memset(ieee->dot11ht_oper_rate_set, 0, 16);
 				ieee->state = RTLLIB_LINKED;
 			}
 		}
@@ -2988,9 +2988,9 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 	ieee->reg_dot11ht_oper_rate_set[1] = 0xff;
 	ieee->reg_dot11ht_oper_rate_set[4] = 0x01;
 
-	ieee->Regdot11TxHTOperationalRateSet[0] = 0xff;
-	ieee->Regdot11TxHTOperationalRateSet[1] = 0xff;
-	ieee->Regdot11TxHTOperationalRateSet[4] = 0x01;
+	ieee->reg_dot11tx_ht_oper_rate_set[0] = 0xff;
+	ieee->reg_dot11tx_ht_oper_rate_set[1] = 0xff;
+	ieee->reg_dot11tx_ht_oper_rate_set[4] = 0x01;
 
 	ieee->FirstIe_InScan = false;
 	ieee->actscanning = false;
-- 
2.37.3

