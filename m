Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A93A6A2F69
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 13:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBZMaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 07:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZMaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 07:30:10 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D70183F7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 04:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+GocC
        XNAulzHnBCvrkGq95PKq7mswgq9OerG/Y+xvWg=; b=LPOxYnvut08UdKW9NKy+l
        5zXWpFpKO6mBj4Yz0q9/FBvc7kKIim15/CuI3EumKblOKYZeJpew7HV6x4IVW94D
        2yS6ULoUaks/0k/v7HREatDq0We57cU4emtYVrvwoo0YpWOwEdsMv5ehWHCKDdBO
        MyfHObGJWAfl0FxOejJcjE=
Received: from localhost (unknown [122.206.190.60])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wD3EgR7UPtjscwZBQ--.1048S2;
        Sun, 26 Feb 2023 20:28:43 +0800 (CST)
From:   Shibo Li <zzutcyha@163.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Shibo Li <zzutcyha@163.com>
Subject: [PATCH] staging: rtl8712: Fixes the problem of irregular indentation
Date:   Sun, 26 Feb 2023 12:28:20 +0000
Message-Id: <20230226122820.194074-1-zzutcyha@163.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3EgR7UPtjscwZBQ--.1048S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfKry8Ww47Gw4fWFy8ur15Arb_yoW8tr18Zo
        WSqFZFyr18JayUt3yxtr15WF4xZr4kWw4Yyw4xCwn8Zay7C3WUXw4aq345AayxXr4YqFyq
        qa4Dt34kXr18JF48n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRtIDwDUUUU
X-Originating-IP: [122.206.190.60]
X-CM-SenderInfo: x22x3ux1kdqiywtou0bp/1tbiGAcebFv2k50oeAACsc
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the problem of irregular indentation

Signed-off-by: Shibo Li <zzutcyha@163.com>
---
 drivers/staging/rtl8712/rtl871x_mlme.c | 182 ++++++++++++-------------
 1 file changed, 91 insertions(+), 91 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index fccfa0915a02..d8af4f370060 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -51,7 +51,7 @@ int r8712_init_mlme_priv(struct _adapter *padapter)
 	set_scanned_network_val(pmlmepriv, 0);
 	memset(&pmlmepriv->assoc_ssid, 0, sizeof(struct ndis_802_11_ssid));
 	pbuf = kmalloc_array(MAX_BSS_CNT, sizeof(struct wlan_network),
-			     GFP_ATOMIC);
+				GFP_ATOMIC);
 	if (!pbuf)
 		return -ENOMEM;
 	pmlmepriv->free_bss_buf = pbuf;
@@ -59,7 +59,7 @@ int r8712_init_mlme_priv(struct _adapter *padapter)
 	for (i = 0; i < MAX_BSS_CNT; i++) {
 		INIT_LIST_HEAD(&(pnetwork->list));
 		list_add_tail(&(pnetwork->list),
-				 &(pmlmepriv->free_bss_pool.queue));
+				&(pmlmepriv->free_bss_pool.queue));
 		pnetwork++;
 	}
 	pmlmepriv->sitesurveyctrl.last_rx_pkts = 0;
@@ -78,7 +78,7 @@ struct wlan_network *_r8712_alloc_network(struct mlme_priv *pmlmepriv)
 
 	spin_lock_irqsave(&free_queue->lock, irqL);
 	pnetwork = list_first_entry_or_null(&free_queue->queue,
-					    struct wlan_network, list);
+						struct wlan_network, list);
 	if (pnetwork) {
 		list_del_init(&pnetwork->list);
 		pnetwork->last_scanned = jiffies;
@@ -89,7 +89,7 @@ struct wlan_network *_r8712_alloc_network(struct mlme_priv *pmlmepriv)
 }
 
 static void _free_network(struct mlme_priv *pmlmepriv,
-			  struct wlan_network *pnetwork)
+			struct wlan_network *pnetwork)
 {
 	u32 curr_time, delta_time;
 	unsigned long irqL;
@@ -111,7 +111,7 @@ static void _free_network(struct mlme_priv *pmlmepriv,
 }
 
 static void free_network_nolock(struct mlme_priv *pmlmepriv,
-			  struct wlan_network *pnetwork)
+			struct wlan_network *pnetwork)
 {
 	struct  __queue *free_queue = &pmlmepriv->free_bss_pool;
 
@@ -209,7 +209,7 @@ void r8712_free_mlme_priv(struct mlme_priv *pmlmepriv)
 	kfree(pmlmepriv->free_bss_buf);
 }
 
-static struct	wlan_network *alloc_network(struct mlme_priv *pmlmepriv)
+static struct wlan_network *alloc_network(struct mlme_priv *pmlmepriv)
 {
 	return _r8712_alloc_network(pmlmepriv);
 }
@@ -220,10 +220,10 @@ int r8712_is_same_ibss(struct _adapter *adapter, struct wlan_network *pnetwork)
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 
 	if ((psecuritypriv->PrivacyAlgrthm != _NO_PRIVACY_) &&
-		    (pnetwork->network.Privacy == cpu_to_le32(0)))
+		(pnetwork->network.Privacy == cpu_to_le32(0)))
 		ret = false;
 	else if ((psecuritypriv->PrivacyAlgrthm == _NO_PRIVACY_) &&
-		 (pnetwork->network.Privacy == cpu_to_le32(1)))
+		(pnetwork->network.Privacy == cpu_to_le32(1)))
 		ret = false;
 	else
 		ret = true;
@@ -232,7 +232,7 @@ int r8712_is_same_ibss(struct _adapter *adapter, struct wlan_network *pnetwork)
 }
 
 static int is_same_network(struct wlan_bssid_ex *src,
-			   struct wlan_bssid_ex *dst)
+			struct wlan_bssid_ex *dst)
 {
 	u16 s_cap, d_cap;
 
@@ -244,8 +244,8 @@ static int is_same_network(struct wlan_bssid_ex *src,
 			((!memcmp(src->MacAddress, dst->MacAddress,
 			ETH_ALEN))) &&
 			((!memcmp(src->Ssid.Ssid,
-			  dst->Ssid.Ssid,
-			  src->Ssid.SsidLength))) &&
+				dst->Ssid.Ssid,
+				src->Ssid.SsidLength))) &&
 			((s_cap & WLAN_CAPABILITY_IBSS) ==
 			(d_cap & WLAN_CAPABILITY_IBSS)) &&
 			((s_cap & WLAN_CAPABILITY_ESS) ==
@@ -268,8 +268,8 @@ struct	wlan_network *r8712_get_oldest_wlan_network(
 		pwlan = container_of(plist, struct wlan_network, list);
 		if (!pwlan->fixed) {
 			if (!oldest ||
-			    time_after((unsigned long)oldest->last_scanned,
-				       (unsigned long)pwlan->last_scanned))
+				time_after((unsigned long)oldest->last_scanned,
+					(unsigned long)pwlan->last_scanned))
 				oldest = pwlan;
 		}
 		plist = plist->next;
@@ -278,8 +278,8 @@ struct	wlan_network *r8712_get_oldest_wlan_network(
 }
 
 static void update_network(struct wlan_bssid_ex *dst,
-			   struct wlan_bssid_ex *src,
-			   struct _adapter *padapter)
+			struct wlan_bssid_ex *src,
+			struct _adapter *padapter)
 {
 	u32 last_evm = 0, tmpVal;
 	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
@@ -289,20 +289,20 @@ static void update_network(struct wlan_bssid_ex *dst,
 		if (padapter->recvpriv.signal_qual_data.total_num++ >=
 		    PHY_LINKQUALITY_SLID_WIN_MAX) {
 			padapter->recvpriv.signal_qual_data.total_num =
-				   PHY_LINKQUALITY_SLID_WIN_MAX;
+				PHY_LINKQUALITY_SLID_WIN_MAX;
 			last_evm = sqd->elements[sqd->index];
 			padapter->recvpriv.signal_qual_data.total_val -=
-				 last_evm;
+				last_evm;
 		}
 		padapter->recvpriv.signal_qual_data.total_val += src->Rssi;
 
 		sqd->elements[sqd->index++] = src->Rssi;
 		if (padapter->recvpriv.signal_qual_data.index >=
-		    PHY_LINKQUALITY_SLID_WIN_MAX)
+			PHY_LINKQUALITY_SLID_WIN_MAX)
 			padapter->recvpriv.signal_qual_data.index = 0;
 		/* <1> Showed on UI for user, in percentage. */
 		tmpVal = padapter->recvpriv.signal_qual_data.total_val /
-			 padapter->recvpriv.signal_qual_data.total_num;
+			padapter->recvpriv.signal_qual_data.total_num;
 		padapter->recvpriv.signal = (u8)tmpVal;
 
 		src->Rssi = padapter->recvpriv.signal;
@@ -313,23 +313,23 @@ static void update_network(struct wlan_bssid_ex *dst,
 }
 
 static void update_current_network(struct _adapter *adapter,
-				   struct wlan_bssid_ex *pnetwork)
+				struct wlan_bssid_ex *pnetwork)
 {
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
 	if (is_same_network(&(pmlmepriv->cur_network.network), pnetwork)) {
 		update_network(&(pmlmepriv->cur_network.network),
-			       pnetwork, adapter);
+				pnetwork, adapter);
 		r8712_update_protection(adapter,
-			       (pmlmepriv->cur_network.network.IEs) +
-			       sizeof(struct NDIS_802_11_FIXED_IEs),
-			       pmlmepriv->cur_network.network.IELength);
+				(pmlmepriv->cur_network.network.IEs) +
+				sizeof(struct NDIS_802_11_FIXED_IEs),
+				pmlmepriv->cur_network.network.IELength);
 	}
 }
 
 /* Caller must hold pmlmepriv->lock first */
 static void update_scanned_network(struct _adapter *adapter,
-			    struct wlan_bssid_ex *target)
+			struct wlan_bssid_ex *target)
 {
 	struct list_head *plist, *phead;
 
@@ -392,7 +392,7 @@ static void update_scanned_network(struct _adapter *adapter,
 }
 
 static void rtl8711_add_network(struct _adapter *adapter,
-			 struct wlan_bssid_ex *pnetwork)
+			struct wlan_bssid_ex *pnetwork)
 {
 	unsigned long irqL;
 	struct mlme_priv *pmlmepriv = &(((struct _adapter *)adapter)->mlmepriv);
@@ -421,13 +421,13 @@ static int is_desired_network(struct _adapter *adapter,
 
 	if (psecuritypriv->wps_phase) {
 		if (r8712_get_wps_ie(pnetwork->network.IEs,
-		    pnetwork->network.IELength, wps_ie,
-		    &wps_ielen))
+			pnetwork->network.IELength, wps_ie,
+			&wps_ielen))
 			return true;
 		return false;
 	}
 	if ((psecuritypriv->PrivacyAlgrthm != _NO_PRIVACY_) &&
-		    (pnetwork->network.Privacy == 0))
+		(pnetwork->network.Privacy == 0))
 		bselected = false;
 	if (check_fwstate(&adapter->mlmepriv, WIFI_ADHOC_STATE)) {
 		if (pnetwork->network.InfrastructureMode !=
@@ -458,23 +458,23 @@ void r8712_survey_event_callback(struct _adapter *adapter, u8 *pbuf)
 	pnetwork->Rssi = le32_to_cpu(pnetwork->Rssi);
 	pnetwork->NetworkTypeInUse = le32_to_cpu(pnetwork->NetworkTypeInUse);
 	pnetwork->Configuration.ATIMWindow =
-		 le32_to_cpu(pnetwork->Configuration.ATIMWindow);
+		le32_to_cpu(pnetwork->Configuration.ATIMWindow);
 	pnetwork->Configuration.BeaconPeriod =
-		 le32_to_cpu(pnetwork->Configuration.BeaconPeriod);
+		le32_to_cpu(pnetwork->Configuration.BeaconPeriod);
 	pnetwork->Configuration.DSConfig =
-		 le32_to_cpu(pnetwork->Configuration.DSConfig);
+		le32_to_cpu(pnetwork->Configuration.DSConfig);
 	pnetwork->Configuration.FHConfig.DwellTime =
-		 le32_to_cpu(pnetwork->Configuration.FHConfig.DwellTime);
+		le32_to_cpu(pnetwork->Configuration.FHConfig.DwellTime);
 	pnetwork->Configuration.FHConfig.HopPattern =
-		 le32_to_cpu(pnetwork->Configuration.FHConfig.HopPattern);
+		le32_to_cpu(pnetwork->Configuration.FHConfig.HopPattern);
 	pnetwork->Configuration.FHConfig.HopSet =
-		 le32_to_cpu(pnetwork->Configuration.FHConfig.HopSet);
+		le32_to_cpu(pnetwork->Configuration.FHConfig.HopSet);
 	pnetwork->Configuration.FHConfig.Length =
-		 le32_to_cpu(pnetwork->Configuration.FHConfig.Length);
+		le32_to_cpu(pnetwork->Configuration.FHConfig.Length);
 	pnetwork->Configuration.Length =
-		 le32_to_cpu(pnetwork->Configuration.Length);
+		le32_to_cpu(pnetwork->Configuration.Length);
 	pnetwork->InfrastructureMode =
-		 le32_to_cpu(pnetwork->InfrastructureMode);
+		le32_to_cpu(pnetwork->InfrastructureMode);
 	pnetwork->IELength = le32_to_cpu(pnetwork->IELength);
 #endif
 	len = r8712_get_wlan_bssid_ex_sz(pnetwork);
@@ -533,22 +533,22 @@ void r8712_surveydone_event_callback(struct _adapter *adapter, u8 *pbuf)
 
 				if (!r8712_select_and_join_from_scan(pmlmepriv)) {
 					mod_timer(&pmlmepriv->assoc_timer, jiffies +
-						  msecs_to_jiffies(MAX_JOIN_TIMEOUT));
+						msecs_to_jiffies(MAX_JOIN_TIMEOUT));
 				} else {
 					struct wlan_bssid_ex *pdev_network =
 					  &(adapter->registrypriv.dev_network);
 					u8 *pibss =
-						 adapter->registrypriv.dev_network.MacAddress;
+						adapter->registrypriv.dev_network.MacAddress;
 					pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;
 					memcpy(&pdev_network->Ssid,
 						&pmlmepriv->assoc_ssid,
 						sizeof(struct
-							 ndis_802_11_ssid));
+							ndis_802_11_ssid));
 					r8712_update_registrypriv_dev_network
 						(adapter);
 					r8712_generate_random_ibss(pibss);
 					pmlmepriv->fw_state =
-						 WIFI_ADHOC_MASTER_STATE;
+						WIFI_ADHOC_MASTER_STATE;
 					pmlmepriv->to_join = false;
 				}
 			}
@@ -557,7 +557,7 @@ void r8712_surveydone_event_callback(struct _adapter *adapter, u8 *pbuf)
 			set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 			if (!r8712_select_and_join_from_scan(pmlmepriv))
 				mod_timer(&pmlmepriv->assoc_timer, jiffies +
-					  msecs_to_jiffies(MAX_JOIN_TIMEOUT));
+					msecs_to_jiffies(MAX_JOIN_TIMEOUT));
 			else
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 		}
@@ -577,21 +577,21 @@ void r8712_free_assoc_resources(struct _adapter *adapter)
 	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
 	pwlan = r8712_find_network(&pmlmepriv->scanned_queue,
-				   tgt_network->network.MacAddress);
+				tgt_network->network.MacAddress);
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_AP_STATE)) {
 		struct sta_info *psta;
 
 		psta = r8712_get_stainfo(&adapter->stapriv,
-					 tgt_network->network.MacAddress);
+					tgt_network->network.MacAddress);
 
 		spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL);
-		r8712_free_stainfo(adapter,  psta);
+		r8712_free_stainfo(adapter, psta);
 		spin_unlock_irqrestore(&pstapriv->sta_hash_lock, irqL);
 	}
 
 	if (check_fwstate(pmlmepriv,
-	    WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE | WIFI_AP_STATE))
+		WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE | WIFI_AP_STATE))
 		r8712_free_all_stainfo(adapter);
 	if (pwlan)
 		pwlan->fixed = false;
@@ -614,7 +614,7 @@ void r8712_indicate_connect(struct _adapter *padapter)
 	r8712_os_indicate_connect(padapter);
 	if (padapter->registrypriv.power_mgnt > PS_MODE_ACTIVE)
 		mod_timer(&pmlmepriv->dhcp_timer,
-			  jiffies + msecs_to_jiffies(60000));
+			jiffies + msecs_to_jiffies(60000));
 }
 
 /*
@@ -633,7 +633,7 @@ void r8712_ind_disconnect(struct _adapter *padapter)
 	    padapter->registrypriv.power_mgnt) {
 		del_timer(&pmlmepriv->dhcp_timer);
 		r8712_set_ps_mode(padapter, padapter->registrypriv.power_mgnt,
-				  padapter->registrypriv.smart_ps);
+				padapter->registrypriv.smart_ps);
 	}
 }
 
@@ -847,7 +847,7 @@ void r8712_stassoc_event_callback(struct _adapter *adapter, u8 *pbuf)
 	unsigned long irqL;
 	struct sta_info *psta;
 	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
-	struct stassoc_event *pstassoc	= (struct stassoc_event *)pbuf;
+	struct stassoc_event *pstassoc = (struct stassoc_event *)pbuf;
 
 	/* to do: */
 	if (!r8712_access_ctrl(&adapter->acl_list, pstassoc->macaddr))
@@ -936,7 +936,7 @@ void r8712_stadel_event_callback(struct _adapter *adapter, u8 *pbuf)
 void r8712_cpwm_event_callback(struct _adapter *adapter, u8 *pbuf)
 {
 	struct reportpwrstate_parm *preportpwrstate =
-			 (struct reportpwrstate_parm *)pbuf;
+			(struct reportpwrstate_parm *)pbuf;
 
 	preportpwrstate->state |= (u8)(adapter->pwrctrlpriv.cpwm_tog + 0x80);
 	r8712_cpwm_int_hdl(adapter, preportpwrstate);
@@ -953,16 +953,16 @@ void r8712_cpwm_event_callback(struct _adapter *adapter, u8 *pbuf)
  */
 void r8712_got_addbareq_event_callback(struct _adapter *adapter, u8 *pbuf)
 {
-	struct	ADDBA_Req_Report_parm *pAddbareq_pram =
-			 (struct ADDBA_Req_Report_parm *)pbuf;
-	struct	sta_info *psta;
-	struct	sta_priv *pstapriv = &adapter->stapriv;
-	struct	recv_reorder_ctrl *precvreorder_ctrl = NULL;
+	struct ADDBA_Req_Report_parm *pAddbareq_pram =
+			(struct ADDBA_Req_Report_parm *)pbuf;
+	struct sta_info *psta;
+	struct sta_priv *pstapriv = &adapter->stapriv;
+	struct recv_reorder_ctrl *precvreorder_ctrl = NULL;
 
 	psta = r8712_get_stainfo(pstapriv, pAddbareq_pram->MacAddress);
 	if (psta) {
 		precvreorder_ctrl =
-			 &psta->recvreorder_ctrl[pAddbareq_pram->tid];
+			&psta->recvreorder_ctrl[pAddbareq_pram->tid];
 		/* set the indicate_seq to 0xffff so that the rx reorder
 		 * can store any following data packet.
 		 */
@@ -979,15 +979,15 @@ void r8712_wpspbc_event_callback(struct _adapter *adapter, u8 *pbuf)
 void _r8712_sitesurvey_ctrl_handler(struct _adapter *adapter)
 {
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
-	struct sitesurvey_ctrl	*psitesurveyctrl = &pmlmepriv->sitesurveyctrl;
-	struct registry_priv	*pregistrypriv = &adapter->registrypriv;
+	struct sitesurvey_ctrl *psitesurveyctrl = &pmlmepriv->sitesurveyctrl;
+	struct registry_priv *pregistrypriv = &adapter->registrypriv;
 	u64 current_tx_pkts;
 	uint current_rx_pkts;
 
 	current_tx_pkts = (adapter->xmitpriv.tx_pkts) -
-			  (psitesurveyctrl->last_tx_pkts);
+			(psitesurveyctrl->last_tx_pkts);
 	current_rx_pkts = (adapter->recvpriv.rx_pkts) -
-			  (psitesurveyctrl->last_rx_pkts);
+			(psitesurveyctrl->last_rx_pkts);
 	psitesurveyctrl->last_tx_pkts = adapter->xmitpriv.tx_pkts;
 	psitesurveyctrl->last_rx_pkts = adapter->recvpriv.rx_pkts;
 	if ((current_tx_pkts > pregistrypriv->busy_thresh) ||
@@ -1013,7 +1013,7 @@ void _r8712_join_timeout_handler(struct _adapter *adapter)
 	}
 	if (adapter->pwrctrlpriv.pwr_mode != adapter->registrypriv.power_mgnt) {
 		r8712_set_ps_mode(adapter, adapter->registrypriv.power_mgnt,
-				  adapter->registrypriv.smart_ps);
+				adapter->registrypriv.smart_ps);
 	}
 	spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
 }
@@ -1035,7 +1035,7 @@ void _r8712_dhcp_timeout_handler (struct _adapter *adapter)
 		return;
 	if (adapter->pwrctrlpriv.pwr_mode != adapter->registrypriv.power_mgnt)
 		r8712_set_ps_mode(adapter, adapter->registrypriv.power_mgnt,
-			    adapter->registrypriv.smart_ps);
+			adapter->registrypriv.smart_ps);
 }
 
 int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv)
@@ -1116,9 +1116,9 @@ int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv)
 }
 
 int r8712_set_auth(struct _adapter *adapter,
-		   struct security_priv *psecuritypriv)
+		struct security_priv *psecuritypriv)
 {
-	struct cmd_priv	*pcmdpriv = &adapter->cmdpriv;
+	struct cmd_priv *pcmdpriv = &adapter->cmdpriv;
 	struct cmd_obj *pcmd;
 	struct setauth_parm *psetauthparm;
 
@@ -1143,8 +1143,8 @@ int r8712_set_auth(struct _adapter *adapter,
 }
 
 int r8712_set_key(struct _adapter *adapter,
-		  struct security_priv *psecuritypriv,
-		  sint keyid)
+		struct security_priv *psecuritypriv,
+		sint keyid)
 {
 	struct cmd_priv *pcmdpriv = &adapter->cmdpriv;
 	struct cmd_obj *pcmd;
@@ -1162,10 +1162,10 @@ int r8712_set_key(struct _adapter *adapter,
 	}
 	if (psecuritypriv->AuthAlgrthm == 2) { /* 802.1X */
 		psetkeyparm->algorithm =
-			 (u8)psecuritypriv->XGrpPrivacy;
+			(u8)psecuritypriv->XGrpPrivacy;
 	} else { /* WEP */
 		psetkeyparm->algorithm =
-			 (u8)psecuritypriv->PrivacyAlgrthm;
+			(u8)psecuritypriv->PrivacyAlgrthm;
 	}
 	psetkeyparm->keyid = (u8)keyid;
 
@@ -1222,7 +1222,7 @@ int r8712_set_key(struct _adapter *adapter,
 
 /* adjust IEs for r8712_joinbss_cmd in WMM */
 int r8712_restruct_wmm_ie(struct _adapter *adapter, u8 *in_ie, u8 *out_ie,
-		    uint in_len, uint initial_out_len)
+		uint in_len, uint initial_out_len)
 {
 	unsigned int ielength = 0;
 	unsigned int i, j;
@@ -1451,7 +1451,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 				if (sec_ie[8] == 0x01) {
 					/*check the unicast encryption type*/
 					if (memcmp(&sec_ie[10],
-						     &uncst_oui[0], 4)) {
+							&uncst_oui[0], 4)) {
 						match = false;
 						break;
 					} /*else the uncst_oui is match*/
@@ -1495,7 +1495,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 		ielength = 12;
 		if (psecuritypriv->wps_phase) {
 			memcpy(out_ie + ielength, psecuritypriv->wps_ie,
-			       psecuritypriv->wps_ie_len);
+				psecuritypriv->wps_ie_len);
 			ielength += psecuritypriv->wps_ie_len;
 		}
 	}
@@ -1526,7 +1526,7 @@ void r8712_init_registrypriv_dev_network(struct _adapter *adapter)
 	memcpy(&pdev_network->Ssid, &pregistrypriv->ssid,
 		sizeof(struct ndis_802_11_ssid));
 	pdev_network->Configuration.Length =
-			 sizeof(struct NDIS_802_11_CONFIGURATION);
+			sizeof(struct NDIS_802_11_CONFIGURATION);
 	pdev_network->Configuration.BeaconPeriod = 100;
 	pdev_network->Configuration.FHConfig.Length = 0;
 	pdev_network->Configuration.FHConfig.HopPattern = 0;
@@ -1537,13 +1537,13 @@ void r8712_init_registrypriv_dev_network(struct _adapter *adapter)
 void r8712_update_registrypriv_dev_network(struct _adapter *adapter)
 {
 	int sz = 0;
-	struct registry_priv	*pregistrypriv = &adapter->registrypriv;
-	struct wlan_bssid_ex	*pdev_network = &pregistrypriv->dev_network;
-	struct security_priv	*psecuritypriv = &adapter->securitypriv;
-	struct wlan_network	*cur_network = &adapter->mlmepriv.cur_network;
+	struct registry_priv *pregistrypriv = &adapter->registrypriv;
+	struct wlan_bssid_ex *pdev_network = &pregistrypriv->dev_network;
+	struct security_priv *psecuritypriv = &adapter->securitypriv;
+	struct wlan_network *cur_network = &adapter->mlmepriv.cur_network;
 
 	pdev_network->Privacy = cpu_to_le32(psecuritypriv->PrivacyAlgrthm
-					    > 0 ? 1 : 0); /* adhoc no 802.1x */
+					> 0 ? 1 : 0); /* adhoc no 802.1x */
 	pdev_network->Rssi = 0;
 	switch (pregistrypriv->wireless_mode) {
 	case WIRELESS_11B:
@@ -1576,8 +1576,8 @@ void r8712_update_registrypriv_dev_network(struct _adapter *adapter)
 void r8712_joinbss_reset(struct _adapter *padapter)
 {
 	int i;
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv		*phtpriv = &pmlmepriv->htpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	/* todo: if you want to do something io/reg/hw setting before join_bss,
 	 * please add code here
@@ -1613,22 +1613,22 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 		if (pqospriv->qos_option == 0) {
 			out_len = *pout_len;
 			r8712_set_ie(out_ie + out_len, WLAN_EID_VENDOR_SPECIFIC,
-				     _WMM_IE_Length_, WMM_IE, pout_len);
+					_WMM_IE_Length_, WMM_IE, pout_len);
 			pqospriv->qos_option = 1;
 		}
 		out_len = *pout_len;
 		memset(&ht_capie, 0, sizeof(struct ieee80211_ht_cap));
 		ht_capie.cap_info = cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
-				    IEEE80211_HT_CAP_SGI_20 |
-				    IEEE80211_HT_CAP_SGI_40 |
-				    IEEE80211_HT_CAP_TX_STBC |
-				    IEEE80211_HT_CAP_MAX_AMSDU |
-				    IEEE80211_HT_CAP_DSSSCCK40);
+					IEEE80211_HT_CAP_SGI_20 |
+					IEEE80211_HT_CAP_SGI_40 |
+					IEEE80211_HT_CAP_TX_STBC |
+					IEEE80211_HT_CAP_MAX_AMSDU |
+					IEEE80211_HT_CAP_DSSSCCK40);
 		ht_capie.ampdu_params_info = (IEEE80211_HT_AMPDU_PARM_FACTOR &
 				0x03) | (IEEE80211_HT_AMPDU_PARM_DENSITY & 0x00);
 		r8712_set_ie(out_ie + out_len, WLAN_EID_HT_CAPABILITY,
-			     sizeof(struct ieee80211_ht_cap),
-			     (unsigned char *)&ht_capie, pout_len);
+				sizeof(struct ieee80211_ht_cap),
+				(unsigned char *)&ht_capie, pout_len);
 		phtpriv->ht_option = 1;
 	}
 	return phtpriv->ht_option;
@@ -1682,7 +1682,7 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 		}
 	}
 	psta = r8712_get_stainfo(&padapter->stapriv,
-				 pcur_network->network.MacAddress);
+				pcur_network->network.MacAddress);
 	if (psta) {
 		for (i = 0; i < 16; i++) {
 			preorder_ctrl = &psta->recvreorder_ctrl[i];
@@ -1692,8 +1692,8 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	}
 	len = 0;
 	p = r8712_get_ie(pie + sizeof(struct NDIS_802_11_FIXED_IEs),
-		   WLAN_EID_HT_OPERATION, &len,
-		   ie_len - sizeof(struct NDIS_802_11_FIXED_IEs));
+			WLAN_EID_HT_OPERATION, &len,
+			ie_len - sizeof(struct NDIS_802_11_FIXED_IEs));
 }
 
 void r8712_issue_addbareq_cmd(struct _adapter *padapter, int priority)
-- 
2.39.2

