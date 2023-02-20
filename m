Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC4869C746
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjBTJF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjBTJFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:05:23 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10F1215560
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KUShO
        kQQF9ezx+BI/un0S+7TqkVtnB7XSo+4qSoC63o=; b=jLRbnG9hLqCjfMYFFK8k5
        yGmNMhVQFXWMcaEQZlnSasCkIfIyQtX1BzqvMfF7H0cTTQBqV2UKms+/wMCsKoW3
        Vylj/yl+BOhfqthvza6Fymyh9N1miaxtjAbhZ/1h/bjUJEatleX39+55W+Hfs7Ll
        ZtvBfE1c0X5L5Ouhyo9HO0=
Received: from localhost (unknown [122.206.190.60])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wBHWiimN_Njfb_yAQ--.1472S2;
        Mon, 20 Feb 2023 17:04:39 +0800 (CST)
From:   Shibo Li <zzutcyha@163.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Shibo Li <zzutcyha@163.com>
Subject: [PATCH] staging: rtl8712: Remove extra spaces
Date:   Mon, 20 Feb 2023 09:04:30 +0000
Message-Id: <20230220090430.19589-1-zzutcyha@163.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHWiimN_Njfb_yAQ--.1472S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF1UKF1fKF45JFW5AF1xAFb_yoW3ZFyfpF
        Z8uF17Jr4UWw1Yqa1DJFyrWr1rGF1kKF9xGw12vasY9F1Fyry5urs0q34xXr4UGr9xXr15
        Ar1Utw45tw45ur7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUev3UUUUUU=
X-Originating-IP: [122.206.190.60]
X-CM-SenderInfo: x22x3ux1kdqiywtou0bp/1tbiVgocbFqzwek+HgABsM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the problem of irregular indentation

Signed-off-by: Shibo Li <zzutcyha@163.com>
---
 drivers/staging/rtl8712/rtl871x_mlme.c | 93 +++++++++++++-------------
 1 file changed, 47 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index cc47c1cedd4e..fccfa0915a02 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -663,7 +663,7 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 		if (!pnetwork)
 			return;
 		memcpy((u8 *)pnetwork + 16, (u8 *)pbuf + 8,
-		       sizeof(struct wlan_network) - 16);
+			sizeof(struct wlan_network) - 16);
 	} else {
 		pnetwork = (struct wlan_network *)pbuf;
 	}
@@ -674,36 +674,36 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 	pnetwork->network_type = le32_to_cpu(pnetwork->network_type);
 	pnetwork->network.Length = le32_to_cpu(pnetwork->network.Length);
 	pnetwork->network.Ssid.SsidLength =
-		 le32_to_cpu(pnetwork->network.Ssid.SsidLength);
+		le32_to_cpu(pnetwork->network.Ssid.SsidLength);
 	pnetwork->network.Privacy = le32_to_cpu(pnetwork->network.Privacy);
 	pnetwork->network.Rssi = le32_to_cpu(pnetwork->network.Rssi);
 	pnetwork->network.NetworkTypeInUse =
-		 le32_to_cpu(pnetwork->network.NetworkTypeInUse);
+		le32_to_cpu(pnetwork->network.NetworkTypeInUse);
 	pnetwork->network.Configuration.ATIMWindow =
-		 le32_to_cpu(pnetwork->network.Configuration.ATIMWindow);
+		le32_to_cpu(pnetwork->network.Configuration.ATIMWindow);
 	pnetwork->network.Configuration.BeaconPeriod =
-		 le32_to_cpu(pnetwork->network.Configuration.BeaconPeriod);
+		le32_to_cpu(pnetwork->network.Configuration.BeaconPeriod);
 	pnetwork->network.Configuration.DSConfig =
-		 le32_to_cpu(pnetwork->network.Configuration.DSConfig);
+		le32_to_cpu(pnetwork->network.Configuration.DSConfig);
 	pnetwork->network.Configuration.FHConfig.DwellTime =
-		 le32_to_cpu(pnetwork->network.Configuration.FHConfig.DwellTime);
+		le32_to_cpu(pnetwork->network.Configuration.FHConfig.DwellTime);
 	pnetwork->network.Configuration.FHConfig.HopPattern =
-		 le32_to_cpu(pnetwork->network.Configuration.FHConfig.HopPattern);
+		le32_to_cpu(pnetwork->network.Configuration.FHConfig.HopPattern);
 	pnetwork->network.Configuration.FHConfig.HopSet =
-		 le32_to_cpu(pnetwork->network.Configuration.FHConfig.HopSet);
+		le32_to_cpu(pnetwork->network.Configuration.FHConfig.HopSet);
 	pnetwork->network.Configuration.FHConfig.Length =
-		 le32_to_cpu(pnetwork->network.Configuration.FHConfig.Length);
+		le32_to_cpu(pnetwork->network.Configuration.FHConfig.Length);
 	pnetwork->network.Configuration.Length =
-		 le32_to_cpu(pnetwork->network.Configuration.Length);
+		le32_to_cpu(pnetwork->network.Configuration.Length);
 	pnetwork->network.InfrastructureMode =
-		 le32_to_cpu(pnetwork->network.InfrastructureMode);
+		le32_to_cpu(pnetwork->network.InfrastructureMode);
 	pnetwork->network.IELength = le32_to_cpu(pnetwork->network.IELength);
 #endif
 
 	the_same_macaddr = !memcmp(pnetwork->network.MacAddress,
-				   cur_network->network.MacAddress, ETH_ALEN);
+				cur_network->network.MacAddress, ETH_ALEN);
 	pnetwork->network.Length =
-		 r8712_get_wlan_bssid_ex_sz(&pnetwork->network);
+		r8712_get_wlan_bssid_ex_sz(&pnetwork->network);
 	spin_lock_irqsave(&pmlmepriv->lock, irqL);
 	if (pnetwork->network.Length > sizeof(struct wlan_bssid_ex))
 		goto ignore_joinbss_callback;
@@ -713,24 +713,24 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 				if (the_same_macaddr) {
 					ptarget_wlan =
-					    r8712_find_network(&pmlmepriv->scanned_queue,
-					    cur_network->network.MacAddress);
+						r8712_find_network(&pmlmepriv->scanned_queue,
+						cur_network->network.MacAddress);
 				} else {
 					pcur_wlan =
-					     r8712_find_network(&pmlmepriv->scanned_queue,
-					     cur_network->network.MacAddress);
+						r8712_find_network(&pmlmepriv->scanned_queue,
+						cur_network->network.MacAddress);
 					if (pcur_wlan)
 						pcur_wlan->fixed = false;
 
 					pcur_sta = r8712_get_stainfo(pstapriv,
-					     cur_network->network.MacAddress);
+						cur_network->network.MacAddress);
 					spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL2);
 					r8712_free_stainfo(adapter, pcur_sta);
 					spin_unlock_irqrestore(&(pstapriv->sta_hash_lock), irqL2);
 
 					ptarget_wlan =
-						 r8712_find_network(&pmlmepriv->scanned_queue,
-						 pnetwork->network.MacAddress);
+						r8712_find_network(&pmlmepriv->scanned_queue,
+						pnetwork->network.MacAddress);
 					if (ptarget_wlan)
 						ptarget_wlan->fixed = true;
 				}
@@ -745,7 +745,7 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 				if (check_fwstate(pmlmepriv,
 					_FW_UNDER_LINKING))
 					pmlmepriv->fw_state ^=
-						 _FW_UNDER_LINKING;
+						_FW_UNDER_LINKING;
 				goto ignore_joinbss_callback;
 			}
 
@@ -753,16 +753,16 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 				if (the_same_macaddr) {
 					ptarget_sta =
-						 r8712_get_stainfo(pstapriv,
-						 pnetwork->network.MacAddress);
+						r8712_get_stainfo(pstapriv,
+						pnetwork->network.MacAddress);
 					if (!ptarget_sta)
 						ptarget_sta =
-						 r8712_alloc_stainfo(pstapriv,
-						 pnetwork->network.MacAddress);
+						r8712_alloc_stainfo(pstapriv,
+						pnetwork->network.MacAddress);
 				} else {
 					ptarget_sta =
-						 r8712_alloc_stainfo(pstapriv,
-						 pnetwork->network.MacAddress);
+						r8712_alloc_stainfo(pstapriv,
+						pnetwork->network.MacAddress);
 				}
 				if (ptarget_sta) /*update ptarget_sta*/ {
 					ptarget_sta->aid = pnetwork->join_res;
@@ -776,24 +776,25 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 						ptarget_sta->XPrivacy =
 							adapter->securitypriv.PrivacyAlgrthm;
 						memset((u8 *)&ptarget_sta->x_UncstKey,
-							 0,
-							 sizeof(union Keytype));
+							0,
+							sizeof(union Keytype));
 						memset((u8 *)&ptarget_sta->tkiprxmickey,
-							 0,
-							 sizeof(union Keytype));
+							0,
+							sizeof(union Keytype));
 						memset((u8 *)&ptarget_sta->tkiptxmickey,
-							 0,
-							 sizeof(union Keytype));
-						memset((u8 *)&ptarget_sta->txpn, 0,
-							 sizeof(union pn48));
-						memset((u8 *)&ptarget_sta->rxpn, 0,
-							 sizeof(union pn48));
+							0,
+							sizeof(union Keytype));
+						memset((u8 *)&ptarget_sta->txpn,
+							0,
+							sizeof(union pn48));
+						memset((u8 *)&ptarget_sta->rxpn,
+							0,
+							sizeof(union pn48));
 					}
 				} else {
-					if (check_fwstate(pmlmepriv,
-					    _FW_UNDER_LINKING))
+					if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
 						pmlmepriv->fw_state ^=
-							 _FW_UNDER_LINKING;
+							_FW_UNDER_LINKING;
 					goto ignore_joinbss_callback;
 				}
 			}
@@ -815,12 +816,12 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 				break;
 			}
 			r8712_update_protection(adapter,
-					  (cur_network->network.IEs) +
-					  sizeof(struct NDIS_802_11_FIXED_IEs),
-					  (cur_network->network.IELength));
+				(cur_network->network.IEs) +
+				sizeof(struct NDIS_802_11_FIXED_IEs),
+				(cur_network->network.IELength));
 			/*TODO: update HT_Capability*/
 			update_ht_cap(adapter, cur_network->network.IEs,
-				      cur_network->network.IELength);
+				cur_network->network.IELength);
 			/*indicate connect*/
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 				r8712_indicate_connect(adapter);
@@ -831,7 +832,7 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 	} else {
 		if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
 			mod_timer(&pmlmepriv->assoc_timer,
-				  jiffies + msecs_to_jiffies(1));
+				jiffies + msecs_to_jiffies(1));
 			_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 		}
 	}
-- 
2.39.2

