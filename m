Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECE06A7AB7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 06:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCBFGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 00:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCBFF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 00:05:59 -0500
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8B80305C6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 21:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Eq/Rx
        q1Y1xnG8+k/i5Dgyr8EfHQ9Urdhx/MumFY0oKk=; b=Yx/2rPmfM05/FSkfB58lS
        K+wba8rMFOaIXPWKjv+Li2uFctERnF72PNIICDWpfdJ5CTyYCR996lG5+eYAD/h7
        vMgI2+Q/5RU4HX0Qhl3VldkzGlpQ9CUkQvVJMNDUvd58IE7B+jyIDuPDO8rlJ4cx
        nuSkklb6vdQKgewj9/RVZA=
Received: from localhost (unknown [122.206.190.60])
        by smtp19 (Coremail) with SMTP id R9xpCgC3sKSfLgBksKIbGA--.49766S2;
        Thu, 02 Mar 2023 13:05:35 +0800 (CST)
From:   Shibo Li <zzutcyha@163.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Shibo Li <zzutcyha@163.com>
Subject: [PATCH v2] staging: rtl8712: Fix some alignment matching open parenthesis issue
Date:   Thu,  2 Mar 2023 05:05:02 +0000
Message-Id: <20230302050502.52356-1-zzutcyha@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230226122820.194074-1-zzutcyha@163.com>
References: <20230226122820.194074-1-zzutcyha@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: R9xpCgC3sKSfLgBksKIbGA--.49766S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3uF17JF1fXr18Gr4UZFWkJFb_yoW8CFW5Ko
        WSqFZrtr18JayUJ3yxKr1xWF1xZr4kWw4Yyws3Cw1DZay29a1UXw43Xw1UAayfXrs0qFyq
        q3Zrt34kXr48tF45n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRGmhrUUUUU
X-Originating-IP: [122.206.190.60]
X-CM-SenderInfo: x22x3ux1kdqiywtou0bp/xtbBRR8mbGI0fTQoGwAAs8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some alignment matching open parenthesis issue.

Signed-off-by: Shibo Li <zzutcyha@163.com>
---
Changes since v2:
 - Undo and fix some bracket misalignment issues.

Changes since v1:
 - Fix some irregular indentation issues.
---
 drivers/staging/rtl8712/rtl871x_mlme.c | 150 +++++++++++++------------
 1 file changed, 76 insertions(+), 74 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index d8af4f370060..a2c34bf0a661 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -51,7 +51,7 @@ int r8712_init_mlme_priv(struct _adapter *padapter)
 	set_scanned_network_val(pmlmepriv, 0);
 	memset(&pmlmepriv->assoc_ssid, 0, sizeof(struct ndis_802_11_ssid));
 	pbuf = kmalloc_array(MAX_BSS_CNT, sizeof(struct wlan_network),
-				GFP_ATOMIC);
+			     GFP_ATOMIC);
 	if (!pbuf)
 		return -ENOMEM;
 	pmlmepriv->free_bss_buf = pbuf;
@@ -59,7 +59,7 @@ int r8712_init_mlme_priv(struct _adapter *padapter)
 	for (i = 0; i < MAX_BSS_CNT; i++) {
 		INIT_LIST_HEAD(&(pnetwork->list));
 		list_add_tail(&(pnetwork->list),
-				&(pmlmepriv->free_bss_pool.queue));
+			      &(pmlmepriv->free_bss_pool.queue));
 		pnetwork++;
 	}
 	pmlmepriv->sitesurveyctrl.last_rx_pkts = 0;
@@ -78,7 +78,7 @@ struct wlan_network *_r8712_alloc_network(struct mlme_priv *pmlmepriv)
 
 	spin_lock_irqsave(&free_queue->lock, irqL);
 	pnetwork = list_first_entry_or_null(&free_queue->queue,
-						struct wlan_network, list);
+					    struct wlan_network, list);
 	if (pnetwork) {
 		list_del_init(&pnetwork->list);
 		pnetwork->last_scanned = jiffies;
@@ -89,7 +89,7 @@ struct wlan_network *_r8712_alloc_network(struct mlme_priv *pmlmepriv)
 }
 
 static void _free_network(struct mlme_priv *pmlmepriv,
-			struct wlan_network *pnetwork)
+			  struct wlan_network *pnetwork)
 {
 	u32 curr_time, delta_time;
 	unsigned long irqL;
@@ -111,7 +111,7 @@ static void _free_network(struct mlme_priv *pmlmepriv,
 }
 
 static void free_network_nolock(struct mlme_priv *pmlmepriv,
-			struct wlan_network *pnetwork)
+				struct wlan_network *pnetwork)
 {
 	struct  __queue *free_queue = &pmlmepriv->free_bss_pool;
 
@@ -220,10 +220,10 @@ int r8712_is_same_ibss(struct _adapter *adapter, struct wlan_network *pnetwork)
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 
 	if ((psecuritypriv->PrivacyAlgrthm != _NO_PRIVACY_) &&
-		(pnetwork->network.Privacy == cpu_to_le32(0)))
+	    (pnetwork->network.Privacy == cpu_to_le32(0)))
 		ret = false;
 	else if ((psecuritypriv->PrivacyAlgrthm == _NO_PRIVACY_) &&
-		(pnetwork->network.Privacy == cpu_to_le32(1)))
+		 (pnetwork->network.Privacy == cpu_to_le32(1)))
 		ret = false;
 	else
 		ret = true;
@@ -232,7 +232,7 @@ int r8712_is_same_ibss(struct _adapter *adapter, struct wlan_network *pnetwork)
 }
 
 static int is_same_network(struct wlan_bssid_ex *src,
-			struct wlan_bssid_ex *dst)
+			   struct wlan_bssid_ex *dst)
 {
 	u16 s_cap, d_cap;
 
@@ -268,8 +268,8 @@ struct	wlan_network *r8712_get_oldest_wlan_network(
 		pwlan = container_of(plist, struct wlan_network, list);
 		if (!pwlan->fixed) {
 			if (!oldest ||
-				time_after((unsigned long)oldest->last_scanned,
-					(unsigned long)pwlan->last_scanned))
+			    time_after((unsigned long)oldest->last_scanned,
+				       (unsigned long)pwlan->last_scanned))
 				oldest = pwlan;
 		}
 		plist = plist->next;
@@ -278,8 +278,8 @@ struct	wlan_network *r8712_get_oldest_wlan_network(
 }
 
 static void update_network(struct wlan_bssid_ex *dst,
-			struct wlan_bssid_ex *src,
-			struct _adapter *padapter)
+			   struct wlan_bssid_ex *src,
+			   struct _adapter *padapter)
 {
 	u32 last_evm = 0, tmpVal;
 	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
@@ -313,23 +313,23 @@ static void update_network(struct wlan_bssid_ex *dst,
 }
 
 static void update_current_network(struct _adapter *adapter,
-				struct wlan_bssid_ex *pnetwork)
+				   struct wlan_bssid_ex *pnetwork)
 {
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
 	if (is_same_network(&(pmlmepriv->cur_network.network), pnetwork)) {
 		update_network(&(pmlmepriv->cur_network.network),
-				pnetwork, adapter);
+			       pnetwork, adapter);
 		r8712_update_protection(adapter,
-				(pmlmepriv->cur_network.network.IEs) +
-				sizeof(struct NDIS_802_11_FIXED_IEs),
-				pmlmepriv->cur_network.network.IELength);
+					(pmlmepriv->cur_network.network.IEs) +
+					sizeof(struct NDIS_802_11_FIXED_IEs),
+					pmlmepriv->cur_network.network.IELength);
 	}
 }
 
 /* Caller must hold pmlmepriv->lock first */
 static void update_scanned_network(struct _adapter *adapter,
-			struct wlan_bssid_ex *target)
+				   struct wlan_bssid_ex *target)
 {
 	struct list_head *plist, *phead;
 
@@ -351,7 +351,7 @@ static void update_scanned_network(struct _adapter *adapter,
 			break;
 		if ((oldest == ((struct wlan_network *)0)) ||
 		    time_after((unsigned long)oldest->last_scanned,
-				(unsigned long)pnetwork->last_scanned))
+			       (unsigned long)pnetwork->last_scanned))
 			oldest = pnetwork;
 
 		plist = plist->next;
@@ -367,7 +367,7 @@ static void update_scanned_network(struct _adapter *adapter,
 			target->Rssi = (pnetwork->network.Rssi +
 					target->Rssi) / 2;
 			memcpy(&pnetwork->network, target,
-				r8712_get_wlan_bssid_ex_sz(target));
+			       r8712_get_wlan_bssid_ex_sz(target));
 			pnetwork->last_scanned = jiffies;
 		} else {
 			/* Otherwise just pull from the free list */
@@ -392,7 +392,7 @@ static void update_scanned_network(struct _adapter *adapter,
 }
 
 static void rtl8711_add_network(struct _adapter *adapter,
-			struct wlan_bssid_ex *pnetwork)
+				struct wlan_bssid_ex *pnetwork)
 {
 	unsigned long irqL;
 	struct mlme_priv *pmlmepriv = &(((struct _adapter *)adapter)->mlmepriv);
@@ -412,7 +412,7 @@ static void rtl8711_add_network(struct _adapter *adapter,
  *			(5) others
  */
 static int is_desired_network(struct _adapter *adapter,
-				struct wlan_network *pnetwork)
+			      struct wlan_network *pnetwork)
 {
 	u8 wps_ie[512];
 	uint wps_ielen;
@@ -421,13 +421,13 @@ static int is_desired_network(struct _adapter *adapter,
 
 	if (psecuritypriv->wps_phase) {
 		if (r8712_get_wps_ie(pnetwork->network.IEs,
-			pnetwork->network.IELength, wps_ie,
-			&wps_ielen))
+				     pnetwork->network.IELength, wps_ie,
+				     &wps_ielen))
 			return true;
 		return false;
 	}
 	if ((psecuritypriv->PrivacyAlgrthm != _NO_PRIVACY_) &&
-		(pnetwork->network.Privacy == 0))
+	    (pnetwork->network.Privacy == 0))
 		bselected = false;
 	if (check_fwstate(&adapter->mlmepriv, WIFI_ADHOC_STATE)) {
 		if (pnetwork->network.InfrastructureMode !=
@@ -484,17 +484,17 @@ void r8712_survey_event_callback(struct _adapter *adapter, u8 *pbuf)
 	/* update IBSS_network 's timestamp */
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
 		if (!memcmp(&(pmlmepriv->cur_network.network.MacAddress),
-		    pnetwork->MacAddress, ETH_ALEN)) {
+			    pnetwork->MacAddress, ETH_ALEN)) {
 			struct wlan_network *ibss_wlan = NULL;
 
 			memcpy(pmlmepriv->cur_network.network.IEs,
-				pnetwork->IEs, 8);
+			       pnetwork->IEs, 8);
 			ibss_wlan = r8712_find_network(
 						&pmlmepriv->scanned_queue,
 						pnetwork->MacAddress);
 			if (ibss_wlan) {
 				memcpy(ibss_wlan->network.IEs,
-					pnetwork->IEs, 8);
+				       pnetwork->IEs, 8);
 				goto exit;
 			}
 		}
@@ -541,9 +541,9 @@ void r8712_surveydone_event_callback(struct _adapter *adapter, u8 *pbuf)
 						adapter->registrypriv.dev_network.MacAddress;
 					pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;
 					memcpy(&pdev_network->Ssid,
-						&pmlmepriv->assoc_ssid,
-						sizeof(struct
-							ndis_802_11_ssid));
+					       &pmlmepriv->assoc_ssid,
+					       sizeof(struct
+						      ndis_802_11_ssid));
 					r8712_update_registrypriv_dev_network
 						(adapter);
 					r8712_generate_random_ibss(pibss);
@@ -577,13 +577,13 @@ void r8712_free_assoc_resources(struct _adapter *adapter)
 	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
 	pwlan = r8712_find_network(&pmlmepriv->scanned_queue,
-				tgt_network->network.MacAddress);
+				   tgt_network->network.MacAddress);
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_AP_STATE)) {
 		struct sta_info *psta;
 
 		psta = r8712_get_stainfo(&adapter->stapriv,
-					tgt_network->network.MacAddress);
+					 tgt_network->network.MacAddress);
 
 		spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL);
 		r8712_free_stainfo(adapter, psta);
@@ -591,7 +591,9 @@ void r8712_free_assoc_resources(struct _adapter *adapter)
 	}
 
 	if (check_fwstate(pmlmepriv,
-		WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE | WIFI_AP_STATE))
+			  WIFI_ADHOC_STATE |
+			  WIFI_ADHOC_MASTER_STATE |
+			  WIFI_AP_STATE))
 		r8712_free_all_stainfo(adapter);
 	if (pwlan)
 		pwlan->fixed = false;
@@ -614,7 +616,7 @@ void r8712_indicate_connect(struct _adapter *padapter)
 	r8712_os_indicate_connect(padapter);
 	if (padapter->registrypriv.power_mgnt > PS_MODE_ACTIVE)
 		mod_timer(&pmlmepriv->dhcp_timer,
-			jiffies + msecs_to_jiffies(60000));
+			  jiffies + msecs_to_jiffies(60000));
 }
 
 /*
@@ -633,7 +635,7 @@ void r8712_ind_disconnect(struct _adapter *padapter)
 	    padapter->registrypriv.power_mgnt) {
 		del_timer(&pmlmepriv->dhcp_timer);
 		r8712_set_ps_mode(padapter, padapter->registrypriv.power_mgnt,
-				padapter->registrypriv.smart_ps);
+				  padapter->registrypriv.smart_ps);
 	}
 }
 
@@ -663,7 +665,7 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 		if (!pnetwork)
 			return;
 		memcpy((u8 *)pnetwork + 16, (u8 *)pbuf + 8,
-			sizeof(struct wlan_network) - 16);
+		       sizeof(struct wlan_network) - 16);
 	} else {
 		pnetwork = (struct wlan_network *)pbuf;
 	}
@@ -918,10 +920,10 @@ void r8712_stadel_event_callback(struct _adapter *adapter, u8 *pbuf)
 			pdev_network = &(adapter->registrypriv.dev_network);
 			pibss = adapter->registrypriv.dev_network.MacAddress;
 			memcpy(pdev_network, &tgt_network->network,
-				r8712_get_wlan_bssid_ex_sz(&tgt_network->network));
+			       r8712_get_wlan_bssid_ex_sz(&tgt_network->network));
 			memcpy(&pdev_network->Ssid,
-				&pmlmepriv->assoc_ssid,
-				sizeof(struct ndis_802_11_ssid));
+			       &pmlmepriv->assoc_ssid,
+			       sizeof(struct ndis_802_11_ssid));
 			r8712_update_registrypriv_dev_network(adapter);
 			r8712_generate_random_ibss(pibss);
 			if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
@@ -1013,7 +1015,7 @@ void _r8712_join_timeout_handler(struct _adapter *adapter)
 	}
 	if (adapter->pwrctrlpriv.pwr_mode != adapter->registrypriv.power_mgnt) {
 		r8712_set_ps_mode(adapter, adapter->registrypriv.power_mgnt,
-				adapter->registrypriv.smart_ps);
+				  adapter->registrypriv.smart_ps);
 	}
 	spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
 }
@@ -1035,7 +1037,7 @@ void _r8712_dhcp_timeout_handler (struct _adapter *adapter)
 		return;
 	if (adapter->pwrctrlpriv.pwr_mode != adapter->registrypriv.power_mgnt)
 		r8712_set_ps_mode(adapter, adapter->registrypriv.power_mgnt,
-			adapter->registrypriv.smart_ps);
+				  adapter->registrypriv.smart_ps);
 }
 
 int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv)
@@ -1070,7 +1072,7 @@ int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv)
 					if (is_same_network(&pmlmepriv->cur_network.network,
 					    &pnetwork->network)) {
 						_clr_fwstate_(pmlmepriv,
-							_FW_UNDER_LINKING);
+							      _FW_UNDER_LINKING);
 						/*r8712_indicate_connect again*/
 						r8712_indicate_connect(adapter);
 						return 2;
@@ -1116,7 +1118,7 @@ int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv)
 }
 
 int r8712_set_auth(struct _adapter *adapter,
-		struct security_priv *psecuritypriv)
+		   struct security_priv *psecuritypriv)
 {
 	struct cmd_priv *pcmdpriv = &adapter->cmdpriv;
 	struct cmd_obj *pcmd;
@@ -1143,8 +1145,8 @@ int r8712_set_auth(struct _adapter *adapter,
 }
 
 int r8712_set_key(struct _adapter *adapter,
-		struct security_priv *psecuritypriv,
-		sint keyid)
+		  struct security_priv *psecuritypriv,
+		  sint keyid)
 {
 	struct cmd_priv *pcmdpriv = &adapter->cmdpriv;
 	struct cmd_obj *pcmd;
@@ -1173,12 +1175,12 @@ int r8712_set_key(struct _adapter *adapter,
 	case _WEP40_:
 		keylen = 5;
 		memcpy(psetkeyparm->key,
-			psecuritypriv->DefKey[keyid].skey, keylen);
+		       psecuritypriv->DefKey[keyid].skey, keylen);
 		break;
 	case _WEP104_:
 		keylen = 13;
 		memcpy(psetkeyparm->key,
-			psecuritypriv->DefKey[keyid].skey, keylen);
+		       psecuritypriv->DefKey[keyid].skey, keylen);
 		break;
 	case _TKIP_:
 		if (keyid < 1 || keyid > 2) {
@@ -1187,7 +1189,7 @@ int r8712_set_key(struct _adapter *adapter,
 		}
 		keylen = 16;
 		memcpy(psetkeyparm->key,
-			&psecuritypriv->XGrpKey[keyid - 1], keylen);
+		       &psecuritypriv->XGrpKey[keyid - 1], keylen);
 		psetkeyparm->grpkey = 1;
 		break;
 	case _AES_:
@@ -1197,7 +1199,7 @@ int r8712_set_key(struct _adapter *adapter,
 		}
 		keylen = 16;
 		memcpy(psetkeyparm->key,
-			&psecuritypriv->XGrpKey[keyid - 1], keylen);
+		       &psecuritypriv->XGrpKey[keyid - 1], keylen);
 		psetkeyparm->grpkey = 1;
 		break;
 	default:
@@ -1222,7 +1224,7 @@ int r8712_set_key(struct _adapter *adapter,
 
 /* adjust IEs for r8712_joinbss_cmd in WMM */
 int r8712_restruct_wmm_ie(struct _adapter *adapter, u8 *in_ie, u8 *out_ie,
-		uint in_len, uint initial_out_len)
+			  uint in_len, uint initial_out_len)
 {
 	unsigned int ielength = 0;
 	unsigned int i, j;
@@ -1268,7 +1270,7 @@ static int SecIsInPMKIDList(struct _adapter *Adapter, u8 *bssid)
 }
 
 sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
-		     u8 *out_ie, uint in_len)
+			   u8 *out_ie, uint in_len)
 {
 	u8 authmode = 0, match;
 	u8 sec_ie[IW_CUSTOM_MAX], uncst_oui[4], bkup_ie[255];
@@ -1318,13 +1320,13 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 			if ((authmode == _WPA_IE_ID_) &&
 			    (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
 				memcpy(&sec_ie[0], &in_ie[cnt],
-					in_ie[cnt + 1] + 2);
+				       in_ie[cnt + 1] + 2);
 				match = true;
 				break;
 			}
 			if (authmode == _WPA2_IE_ID_) {
 				memcpy(&sec_ie[0], &in_ie[cnt],
-					in_ie[cnt + 1] + 2);
+				       in_ie[cnt + 1] + 2);
 				match = true;
 				break;
 			}
@@ -1332,7 +1334,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 			     (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) ||
 			     (authmode == _WPA2_IE_ID_))
 				memcpy(&bkup_ie[0], &in_ie[cnt],
-					in_ie[cnt + 1] + 2);
+				       in_ie[cnt + 1] + 2);
 		}
 		cnt += in_ie[cnt + 1] + 2; /*get next*/
 	}
@@ -1387,7 +1389,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 				if (sec_ie[12] == 0x01) {
 					/*check the unicast encryption type*/
 					if (memcmp(&sec_ie[14],
-					    &uncst_oui[0], 4)) {
+						   &uncst_oui[0], 4)) {
 						match = false;
 						break;
 
@@ -1402,9 +1404,9 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 					memcpy(&sec_ie[14], &uncst_oui[0], 4);
 					/*remove the other unicast suit*/
 					memcpy(&sec_ie[18],
-						&sec_ie[18 + remove_cnt],
-						sec_ie[1] - 18 + 2 -
-						remove_cnt);
+					       &sec_ie[18 + remove_cnt],
+					       sec_ie[1] - 18 + 2 -
+					       remove_cnt);
 					sec_ie[1] = sec_ie[1] - remove_cnt;
 				}
 				break;
@@ -1451,7 +1453,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 				if (sec_ie[8] == 0x01) {
 					/*check the unicast encryption type*/
 					if (memcmp(&sec_ie[10],
-							&uncst_oui[0], 4)) {
+						   &uncst_oui[0], 4)) {
 						match = false;
 						break;
 					} /*else the uncst_oui is match*/
@@ -1465,8 +1467,8 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 					memcpy(&sec_ie[10], &uncst_oui[0], 4);
 					/*remove the other unicast suit*/
 					memcpy(&sec_ie[14],
-						&sec_ie[14 + remove_cnt],
-						(sec_ie[1] - 14 + 2 -
+					       &sec_ie[14 + remove_cnt],
+					       (sec_ie[1] - 14 + 2 -
 						remove_cnt));
 					sec_ie[1] = sec_ie[1] - remove_cnt;
 				}
@@ -1495,7 +1497,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 		ielength = 12;
 		if (psecuritypriv->wps_phase) {
 			memcpy(out_ie + ielength, psecuritypriv->wps_ie,
-				psecuritypriv->wps_ie_len);
+			       psecuritypriv->wps_ie_len);
 			ielength += psecuritypriv->wps_ie_len;
 		}
 	}
@@ -1508,7 +1510,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 		out_ie[ielength] = 0;	/*PMKID count = 0x0100*/
 		ielength++;
 		memcpy(&out_ie[ielength],
-			&psecuritypriv->PMKIDList[iEntry].PMKID, 16);
+		       &psecuritypriv->PMKIDList[iEntry].PMKID, 16);
 		ielength += 16;
 		out_ie[13] += 18;/*PMKID length = 2+16*/
 	}
@@ -1524,7 +1526,7 @@ void r8712_init_registrypriv_dev_network(struct _adapter *adapter)
 
 	memcpy(pdev_network->MacAddress, myhwaddr, ETH_ALEN);
 	memcpy(&pdev_network->Ssid, &pregistrypriv->ssid,
-		sizeof(struct ndis_802_11_ssid));
+	       sizeof(struct ndis_802_11_ssid));
 	pdev_network->Configuration.Length =
 			sizeof(struct NDIS_802_11_CONFIGURATION);
 	pdev_network->Configuration.BeaconPeriod = 100;
@@ -1613,7 +1615,7 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 		if (pqospriv->qos_option == 0) {
 			out_len = *pout_len;
 			r8712_set_ie(out_ie + out_len, WLAN_EID_VENDOR_SPECIFIC,
-					_WMM_IE_Length_, WMM_IE, pout_len);
+				     _WMM_IE_Length_, WMM_IE, pout_len);
 			pqospriv->qos_option = 1;
 		}
 		out_len = *pout_len;
@@ -1627,8 +1629,8 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 		ht_capie.ampdu_params_info = (IEEE80211_HT_AMPDU_PARM_FACTOR &
 				0x03) | (IEEE80211_HT_AMPDU_PARM_DENSITY & 0x00);
 		r8712_set_ie(out_ie + out_len, WLAN_EID_HT_CAPABILITY,
-				sizeof(struct ieee80211_ht_cap),
-				(unsigned char *)&ht_capie, pout_len);
+			     sizeof(struct ieee80211_ht_cap),
+			     (unsigned char *)&ht_capie, pout_len);
 		phtpriv->ht_option = 1;
 	}
 	return phtpriv->ht_option;
@@ -1657,9 +1659,9 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	/*check Max Rx A-MPDU Size*/
 	len = 0;
 	p = r8712_get_ie(pie + sizeof(struct NDIS_802_11_FIXED_IEs),
-				WLAN_EID_HT_CAPABILITY,
-				&len, ie_len -
-				sizeof(struct NDIS_802_11_FIXED_IEs));
+			 WLAN_EID_HT_CAPABILITY,
+			 &len, ie_len -
+			 sizeof(struct NDIS_802_11_FIXED_IEs));
 	if (p && len > 0) {
 		pht_capie = (struct ieee80211_ht_cap *)(p + 2);
 		max_ampdu_sz = (pht_capie->ampdu_params_info &
@@ -1682,7 +1684,7 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 		}
 	}
 	psta = r8712_get_stainfo(&padapter->stapriv,
-				pcur_network->network.MacAddress);
+				 pcur_network->network.MacAddress);
 	if (psta) {
 		for (i = 0; i < 16; i++) {
 			preorder_ctrl = &psta->recvreorder_ctrl[i];
@@ -1692,8 +1694,8 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	}
 	len = 0;
 	p = r8712_get_ie(pie + sizeof(struct NDIS_802_11_FIXED_IEs),
-			WLAN_EID_HT_OPERATION, &len,
-			ie_len - sizeof(struct NDIS_802_11_FIXED_IEs));
+			 WLAN_EID_HT_OPERATION, &len,
+			 ie_len - sizeof(struct NDIS_802_11_FIXED_IEs));
 }
 
 void r8712_issue_addbareq_cmd(struct _adapter *padapter, int priority)
-- 
2.39.2

