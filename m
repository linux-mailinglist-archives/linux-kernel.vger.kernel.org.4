Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2B5606A52
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJTVaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJTVaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:30:04 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D0E72FCC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666301381; bh=PRmp9RO+7G+f1iJA7lhDAZuPIa5KAP9QU1mBwz1D9ck=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=Ueg2Se7cd7h8s2VYW+NWvLpi7Ug/GjM7Ef2jDwlNFGYyuQ21q3+CENLVDWBPblu9r
         qGtoQx35vlqOzg1S0lb+SGzE69EkEWKxAqIXq9sg3ReEiy3zMHcVSRGnRWSbxWfrLj
         i/30HrV3XstW2O3TBkW7btMB6jmr4wEE+Ppw+DiM=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.206]
        Thu, 20 Oct 2022 23:29:41 +0200 (CEST)
X-EA-Auth: +e3VIPMIkTMOgOeTPzlro3gtJpz3w8g2E1iTkIbb5DgGGTm+jupdjhKG5xOlWDyQVidOmqrw9+ZZBQjeuXq2iXd02Ab6KrDl
Date:   Fri, 21 Oct 2022 02:59:37 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: [PATCH v4 05/11] staging: r8188eu: correct misspelled words in
 comments
Message-ID: <00be5f2a97b0c899279bd8f9cd27634186b77b9d.1666299151.git.drv@mailo.com>
References: <cover.1666299151.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666299151.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling mistakes in code comments across the driver.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v4:
   1. Implement corrections provided by dan.carpenter@oracle.com & julia.lawall@inria.fr
   2. Update patch log message to be simple and straight. Feedback from julia.lawall@inria.fr

Changes in v3:
   1. Patch newly added to the patch set.



 drivers/staging/r8188eu/core/rtw_ioctl_set.c  |  2 +-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 36 +++++++++----------
 drivers/staging/r8188eu/core/rtw_recv.c       |  8 ++---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  2 +-
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    |  2 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 16 ++++-----
 .../staging/r8188eu/include/Hal8188EPhyReg.h  |  4 +--
 .../staging/r8188eu/include/rtl8188e_hal.h    |  2 +-
 .../staging/r8188eu/include/rtl8188e_spec.h   |  6 ++--
 drivers/staging/r8188eu/include/rtw_cmd.h     |  4 +--
 drivers/staging/r8188eu/include/rtw_recv.h    |  4 +--
 drivers/staging/r8188eu/include/rtw_xmit.h    |  2 +-
 drivers/staging/r8188eu/include/wifi.h        | 12 +++----
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  6 ++--
 15 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 55e6b0f41dc3..786431826659 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -287,7 +287,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,

 		if ((*pold_state == Ndis802_11Infrastructure) || (*pold_state == Ndis802_11IBSS)) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED))
-				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have chked whether  issue dis-assoc_cmd or not */
+				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have checked whether issue dis-assoc_cmd or not */
 	       }

 		*pold_state = networktype;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 07905e2ae8e0..8d5ee98f0880 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -137,7 +137,7 @@ static struct rt_channel_plan_map	RTW_ChannelPlanMap[RT_CHANNEL_DOMAIN_MAX] = {
 	{0x03},	/* 0x41, RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN_2G */
 };

-static struct rt_channel_plan_map RTW_CHANNEL_PLAN_MAP_REALTEK_DEFINE = {0x03}; /* use the conbination for max channel numbers */
+static struct rt_channel_plan_map RTW_CHANNEL_PLAN_MAP_REALTEK_DEFINE = {0x03}; /* use the combination for max channel numbers */

 /*
  * Search the @param channel_num in given @param channel_set
@@ -1754,7 +1754,7 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
 	p2pie[p2pielen++] = 0x09;	/*	WFA P2P v1.0 */

 	/*	Commented by Albert 20110306 */
-	/*	According to the P2P Specification, the group negoitation request frame should contain 9 P2P attributes */
+	/*	According to the P2P Specification, the group negotiation request frame should contain 9 P2P attributes */
 	/*	1. P2P Capability */
 	/*	2. Group Owner Intent */
 	/*	3. Configuration Timeout */
@@ -2109,7 +2109,7 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 	p2pie[p2pielen++] = 0x09;	/*	WFA P2P v1.0 */

 	/*	Commented by Albert 20100908 */
-	/*	According to the P2P Specification, the group negoitation response frame should contain 9 P2P attributes */
+	/*	According to the P2P Specification, the group negotiation response frame should contain 9 P2P attributes */
 	/*	1. Status */
 	/*	2. P2P Capability */
 	/*	3. Group Owner Intent */
@@ -2405,7 +2405,7 @@ static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
 	p2pie[p2pielen++] = 0x09;	/*	WFA P2P v1.0 */

 	/*	Commented by Albert 20110306 */
-	/*	According to the P2P Specification, the group negoitation request frame should contain 5 P2P attributes */
+	/*	According to the P2P Specification, the group negotiation request frame should contain 5 P2P attributes */
 	/*	1. Status */
 	/*	2. P2P Capability */
 	/*	3. Operating Channel */
@@ -4013,7 +4013,7 @@ struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv)

 /****************************************************************************

-Following are some TX fuctions for WiFi MLME
+Following are some TX functions for WiFi MLME

 *****************************************************************************/

@@ -4615,7 +4615,7 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 	return ret;
 }

-/*  if psta == NULL, indiate we are station(client) now... */
+/*  if psta == NULL, indicate we are station (client) now... */
 void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short status)
 {
 	struct xmit_frame *pmgntframe;
@@ -5014,7 +5014,7 @@ void issue_assocreq(struct adapter *padapter)
 				if (!padapter->registrypriv.wifi_spec) {
 					/* Commented by Kurt 20110629 */
 					/* In some older APs, WPS handshake */
-					/* would be fail if we append vender extensions informations to AP */
+					/* would be fail if we append vendor extension information to AP */
 					if (!memcmp(pIE->data, WPS_OUI, 4))
 						pIE->Length = 14;
 				}
@@ -5169,7 +5169,7 @@ void issue_assocreq(struct adapter *padapter)
 		kfree(pmlmepriv->assoc_req);
 }

-/* when wait_ack is ture, this function shoule be called at process context */
+/* when wait_ack is true, this function should be called at process context */
 static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int power_mode, int wait_ack)
 {
 	int ret = _FAIL;
@@ -5238,7 +5238,7 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned
 	return ret;
 }

-/* when wait_ms > 0 , this function shoule be called at process context */
+/* when wait_ms > 0, this function should be called at process context */
 /* da == NULL for station mode */
 int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int power_mode, int try_cnt, int wait_ms)
 {
@@ -5247,7 +5247,7 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;

-	/* da == NULL, assum it's null data for sta to ap*/
+	/* da == NULL, assume it's null data for sta to ap*/
 	if (!da)
 		da = get_my_bssid(&pmlmeinfo->network);

@@ -5271,7 +5271,7 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 	return ret;
 }

-/* when wait_ack is ture, this function shoule be called at process context */
+/* when wait_ack is true, this function should be called at process context */
 static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int wait_ack)
 {
 	int ret = _FAIL;
@@ -5344,7 +5344,7 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 	return ret;
 }

-/* when wait_ms > 0 , this function shoule be called at process context */
+/* when wait_ms > 0 , this function should be called at process context */
 /* da == NULL for station mode */
 int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int try_cnt, int wait_ms)
 {
@@ -5353,7 +5353,7 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;

-	/* da == NULL, assum it's null data for sta to ap*/
+	/* da == NULL, assume it's null data for sta to ap*/
 	if (!da)
 		da = get_my_bssid(&pmlmeinfo->network);

@@ -5885,7 +5885,7 @@ static void rtw_set_opmode(struct adapter *adapter, u8 mode)

 /****************************************************************************

-Following are some utitity fuctions for WiFi MLME
+Following are some utility functions for WiFi MLME

 *****************************************************************************/

@@ -6058,7 +6058,7 @@ void site_survey(struct adapter *padapter)
 		} else {
 			/*  20100721:Interrupt scan operation here. */
 			/*  For SW antenna diversity before link, it needs to switch to another antenna and scan again. */
-			/*  It compares the scan result and select beter one to do connection. */
+			/*  It compares the scan result and selects a better one to do connection. */
 			if (AntDivBeforeLink8188E(padapter)) {
 				pmlmeext->sitesurvey_res.bss_cnt = 0;
 				pmlmeext->sitesurvey_res.channel_idx = -1;
@@ -6328,7 +6328,7 @@ void start_create_ibss(struct adapter *padapter)
 	/* update wireless mode */
 	update_wireless_mode(padapter);

-	/* udpate capability */
+	/* update capability */
 	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
 	update_capinfo(padapter, caps);
 	if (caps & cap_IBSS) {/* adhoc master */
@@ -6378,7 +6378,7 @@ void start_clnt_join(struct adapter *padapter)
 	/* update wireless mode */
 	update_wireless_mode(padapter);

-	/* udpate capability */
+	/* update capability */
 	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
 	update_capinfo(padapter, caps);
 	if (caps & cap_ESS) {
@@ -6972,7 +6972,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 	/* BCN interval */
 	rtw_write16(padapter, REG_BCN_INTERVAL, pmlmeinfo->bcn_interval);

-	/* udpate capability */
+	/* update capability */
 	update_capinfo(padapter, pmlmeinfo->capability);

 	/* WMM, Update EDCA param */
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index bb5c3b3888e0..4b68a543f68b 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -972,7 +972,7 @@ static void validate_recv_ctrl_frame(struct adapter *padapter,
 			if (psta->sleepq_len == 0) {
 				pstapriv->tim_bitmap &= ~BIT(psta->aid);

-				/* upate BCN for TIM IE */
+				/* update BCN for TIM IE */
 				/* update_BCNTIM(padapter); */
 				update_beacon(padapter, _TIM_IE_, NULL, false);
 			}
@@ -986,7 +986,7 @@ static void validate_recv_ctrl_frame(struct adapter *padapter,

 				pstapriv->tim_bitmap &= ~BIT(psta->aid);

-				/* upate BCN for TIM IE */
+				/* update BCN for TIM IE */
 				/* update_BCNTIM(padapter); */
 				update_beacon(padapter, _TIM_IE_, NULL, false);
 			}
@@ -1984,13 +1984,13 @@ static void rtw_signal_stat_timer_hdl(struct timer_list *t)
 	} else {
 		if (recvpriv->signal_strength_data.update_req == 0) {/*  update_req is clear, means we got rx */
 			avg_signal_strength = recvpriv->signal_strength_data.avg_val;
-			/*  after avg_vals are accquired, we can re-stat the signal values */
+			/*  after avg_vals are acquired, we can re-stat the signal values */
 			recvpriv->signal_strength_data.update_req = 1;
 		}

 		if (recvpriv->signal_qual_data.update_req == 0) {/*  update_req is clear, means we got rx */
 			avg_signal_qual = recvpriv->signal_qual_data.avg_val;
-			/*  after avg_vals are accquired, we can re-stat the signal values */
+			/*  after avg_vals are acquired, we can re-stat the signal values */
 			recvpriv->signal_qual_data.update_req = 1;
 		}

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 525deab10820..60cdfcf80daa 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -69,7 +69,7 @@ void ODM_TxPwrTrackAdjust88E(struct odm_dm_struct *dm_odm, u8 Type,/*  0 = OFDM,
 /*-----------------------------------------------------------------------------
  * Function:	odm_TxPwrTrackSetPwr88E()
  *
- * Overview:	88E change all channel tx power accordign to flag.
+ * Overview:	88E change all channel tx power according to flag.
  *				OFDM & CCK are all different.
  *
  * Input:		NONE
diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index c8a3c521bd60..dd9c8291f025 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -194,7 +194,7 @@ static void odm_HWAntDiv(struct odm_dm_struct *dm_odm)
 	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
 		pEntry = dm_odm->pODM_StaInfo[i];
 		if (IS_STA_VALID(pEntry)) {
-			/* 2 Caculate RSSI per Antenna */
+			/* 2 Calculate RSSI per Antenna */
 			Main_RSSI = (dm_fat_tbl->MainAnt_Cnt[i] != 0) ? (dm_fat_tbl->MainAnt_Sum[i] / dm_fat_tbl->MainAnt_Cnt[i]) : 0;
 			Aux_RSSI = (dm_fat_tbl->AuxAnt_Cnt[i] != 0) ? (dm_fat_tbl->AuxAnt_Sum[i] / dm_fat_tbl->AuxAnt_Cnt[i]) : 0;
 			TargetAnt = (Main_RSSI >= Aux_RSSI) ? MAIN_ANT : AUX_ANT;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 158260547f2b..cc29963f4b49 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -355,7 +355,7 @@ void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 PwrState)
 	if (PwrState) {
 		rtw_write8(pAdapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_ON);

-		/*  1.2V Power: From VDDON with Power Cut(0x0000h[15]), defualt valid */
+		/*  1.2V Power: From VDDON with Power Cut(0x0000h[15]), default valid */
 		res = rtw_read16(pAdapter, REG_SYS_ISO_CTRL, &tmpV16);
 		if (res)
 			return;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 532c63bce0bf..b7f3c7a670fb 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -23,7 +23,7 @@ static u32 phy_calculate_bit_shift(u32 bitmask)
 /**
 * Function:	PHY_QueryBBReg
 *
-* OverView:	Read "sepcific bits" from BB register
+* Overview:	Read "sepcific bits" from BB register
 *
 * Input:
 *			struct adapter *Adapter,
@@ -56,7 +56,7 @@ rtl8188e_PHY_QueryBBReg(
 /**
 * Function:	PHY_SetBBReg
 *
-* OverView:	Write "Specific bits" to BB register (page 8~)
+* Overview:	Write "Specific bits" to BB register (page 8~)
 *
 * Input:
 *			struct adapter *Adapter,
@@ -94,7 +94,7 @@ void rtl8188e_PHY_SetBBReg(struct adapter *Adapter, u32 RegAddr, u32 BitMask, u3
 /**
 * Function:	phy_RFSerialRead
 *
-* OverView:	Read regster from RF chips
+* Overview:	Read register from RF chips
 *
 * Input:
 *			struct adapter *Adapter,
@@ -160,7 +160,7 @@ phy_RFSerialRead(
 /**
 * Function:	phy_RFSerialWrite
 *
-* OverView:	Write data to RF register (page 8~)
+* Overview:	Write data to RF register (page 8~)
 *
 * Input:
 *			struct adapter *Adapter,
@@ -235,7 +235,7 @@ phy_RFSerialWrite(
 /**
 * Function:	PHY_QueryRFReg
 *
-* OverView:	Query "Specific bits" to RF register (page 8~)
+* Overview:	Query "Specific bits" to RF register (page 8~)
 *
 * Input:
 *			struct adapter *Adapter,
@@ -261,7 +261,7 @@ u32 rtl8188e_PHY_QueryRFReg(struct adapter *Adapter, u32 RegAddr, u32 BitMask)
 /**
 * Function:	PHY_SetRFReg
 *
-* OverView:	Write "Specific bits" to RF register (page 8~)
+* Overview:	Write "Specific bits" to RF register (page 8~)
 *
 * Input:
 *			struct adapter *Adapter,
@@ -335,7 +335,7 @@ s32 PHY_MACConfig8188E(struct adapter *Adapter)
 /**
 * Function:	phy_InitBBRFRegisterDefinition
 *
-* OverView:	Initialize Register definition offset for Radio Path A/B/C/D
+* Overview:	Initialize Register definition offset for Radio Path A/B/C/D
 *
 * Input:
 *			struct adapter *Adapter,
@@ -363,7 +363,7 @@ phy_InitBBRFRegisterDefinition(
 	/*  RF Interface (Output and)  Enable */
 	pHalData->PHYRegDef.rfintfe = rFPGA0_XA_RFInterfaceOE; /*  16 MSBs if read 32-bit from 0x860 (16-bit for 0x862) */

-	/* Addr of LSSI. Wirte RF register by driver */
+	/* Addr of LSSI. Write RF register by driver */
 	pHalData->PHYRegDef.rf3wireOffset = rFPGA0_XA_LSSIParameter; /* LSSI Parameter */

 	/*  RF parameter */
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyReg.h b/drivers/staging/r8188eu/include/Hal8188EPhyReg.h
index 8b8c75a1f149..da2329be4474 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyReg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyReg.h
@@ -92,7 +92,7 @@
 #define	rFPGA0_AdDaClockEn		0x888
 #define	rFPGA0_AnalogParameter4		0x88c

-#define	rFPGA0_XA_LSSIReadBack		0x8a0	/*  Tranceiver LSSI Readback */
+#define	rFPGA0_XA_LSSIReadBack		0x8a0	/*  Transceiver LSSI Readback */
 #define	rFPGA0_XB_LSSIReadBack		0x8a4
 #define	rFPGA0_XC_LSSIReadBack		0x8a8
 #define	rFPGA0_XD_LSSIReadBack		0x8ac
@@ -167,7 +167,7 @@

 /* RxIQ DC offset, Rx digital filter, DC notch filter */
 #define	rOFDM0_XARxAFE			0xc10
-#define	rOFDM0_XARxIQImbalance		0xc14  /* RxIQ imblance matrix */
+#define	rOFDM0_XARxIQImbalance		0xc14  /* RxIQ imbalance matrix */
 #define	rOFDM0_XBRxAFE			0xc18
 #define	rOFDM0_XBRxIQImbalance		0xc1c
 #define	rOFDM0_XCRxAFE			0xc20
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index ed4091e7cc7e..25f9200b1151 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -88,7 +88,7 @@ struct txpowerinfo24g {
 /*  9bytes + 1byt + 5bytes and pre 1byte. */
 /*  For worst case: */
 /*  | 2byte|----8bytes----|1byte|--7bytes--| 92D */
-/*  PG data exclude header, dummy 7 bytes frome CP test and reserved 1byte. */
+/*  PG data exclude header, dummy 7 bytes from CP test and reserved 1byte. */
 #define		EFUSE_OOB_PROTECT_BYTES_88E	18

 #define EFUSE_PROTECT_BYTES_BANK	16
diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
index e34619140e33..e34ecdc09688 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -4,7 +4,7 @@
 #ifndef __RTL8188E_SPEC_H__
 #define __RTL8188E_SPEC_H__

-/*        8192C Regsiter offset definition */
+/*        8192C Register offset definition */

 #define		HAL_PS_TIMER_INT_DELAY	50	/*   50 microseconds */
 #define		HAL_92C_NAV_UPPER_UNIT	128	/*  micro-second */
@@ -674,7 +674,7 @@ Current IOREG MAP

 #define REG_USB_HRPWM			0xFE58
 #define REG_USB_HCPWM			0xFE57
-/*        8192C Regsiter Bit and Content definition */
+/*        8192C Register Bit and Content definition */
 /* 	0x0000h ~ 0x00FFh	System Configuration */

 /* 2 SYS_ISO_CTRL */
@@ -1135,7 +1135,7 @@ Current IOREG MAP
 #define EEPROM_Default_CrystalCap_88E		0x20
 #define	EEPROM_Default_ThermalMeter_88E		0x18

-/* New EFUSE deafult value */
+/* New EFUSE default value */
 #define		EEPROM_DEFAULT_24G_INDEX	0x2D
 #define		EEPROM_DEFAULT_24G_HT20_DIFF	0X02
 #define		EEPROM_DEFAULT_24G_OFDM_DIFF	0X04
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 9a76aa85de94..d0d6c53e2aa7 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -455,7 +455,7 @@ struct Tx_Beacon_param

 	mac[0] == 0
 	==> CMD mode, return H2C_SUCCESS.
-	The following condition must be ture under CMD mode
+	The following condition must be true under CMD mode
 		mac[1] == mac[4], mac[2] == mac[3], mac[0]=mac[5]= 0;
 		s0 == 0x1234, s1 == 0xabcd, w0 == 0x78563412, w1 == 0x5aa5def7;
 		s2 == (b1 << 8 | b0);
@@ -508,7 +508,7 @@ struct drvextra_cmd_parm {
 	unsigned char *pbuf;
 };

-/*------------------- Below are used for RF/BB tunning ---------------------*/
+/*------------------- Below are used for RF/BB tuning ---------------------*/

 struct	setantenna_parm {
 	u8	tx_antset;
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index 7768b0c5988c..12026431a3d2 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -92,7 +92,7 @@ struct rx_pkt_attrib {
 	u8	privacy; /* in frame_ctrl field */
 	u8	bdecrypted;
 	u8	encrypt; /* when 0 indicate no encrypt. when non-zero,
-			  * indicate the encrypt algorith */
+			  * indicate the encrypt algorithm */
 	u8	iv_len;
 	u8	icv_len;
 	u8	crc_err;
@@ -175,7 +175,7 @@ struct recv_priv {
 	u8 *precv_buf;    /*  4 alignment */
 	struct __queue free_recv_buf_queue;
 	u32	free_recv_buf_queue_cnt;
-	/* For display the phy informatiom */
+	/* For display the phy information */
 	u8 is_signal_dbg;	/*  for debug */
 	u8 signal_strength_dbg;	/*  for debug */
 	s8 rssi;
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 82efcd54af3f..cff065554608 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -116,7 +116,7 @@ struct pkt_attrib {
 	u32	last_txcmdsz;
 	u8	nr_frags;
 	u8	encrypt;	/* when 0 indicate no encrypt. when non-zero,
-				 * indicate the encrypt algorith */
+				 * indicate the encrypt algorithm */
 	u8	iv_len;
 	u8	icv_len;
 	u8	iv[18];
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 0254310bdf44..381385a7e118 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -701,7 +701,7 @@ struct ADDBA_request {

 #define	P2P_WILDCARD_SSID_LEN			7

-/* default value, used when: (1)p2p disabed or (2)p2p enabled
+/* default value, used when: (1)p2p disabled or (2)p2p enabled
  * but only do 1 scan phase */
 #define	P2P_FINDPHASE_EX_NONE		0
 /*  used when p2p enabled and want to do 1 scan phase and
@@ -766,11 +766,11 @@ enum P2P_STATE {
 	P2P_STATE_TX_PROVISION_DIS_REQ = 6,
 	P2P_STATE_RX_PROVISION_DIS_RSP = 7,
 	P2P_STATE_RX_PROVISION_DIS_REQ = 8,
-	/* Doing the group owner negoitation handshake */
+	/* Doing the group owner negotiation handshake */
 	P2P_STATE_GONEGO_ING = 9,
-	/* finish the group negoitation handshake with success */
+	/* finish the group negotiation handshake with success */
 	P2P_STATE_GONEGO_OK = 10,
-	/* finish the group negoitation handshake with failure */
+	/* finish the group negotiation handshake with failure */
 	P2P_STATE_GONEGO_FAIL = 11,
 	/* receiving the P2P Inviation request and match with the profile. */
 	P2P_STATE_RECV_INVITE_REQ_MATCH = 12,
@@ -790,9 +790,9 @@ enum P2P_STATE {
 	P2P_STATE_RECV_INVITE_REQ_JOIN = 19,
 	/* recveing the P2P Inviation response with failure */
 	P2P_STATE_RX_INVITE_RESP_FAIL = 20,
-	/* receiving p2p negoitation response with information is not available */
+	/* receiving p2p negotiation response with information is not available */
 	P2P_STATE_RX_INFOR_NOREADY = 21,
-	/* sending p2p negoitation response with information is not available */
+	/* sending p2p negotiation response with information is not available */
 	P2P_STATE_TX_INFOR_NOREADY = 22,
 };

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 2de2e1e32738..8516e253bb03 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2647,7 +2647,7 @@ static int rtw_p2p_connect(struct net_device *dev,
 	u32 peer_channel = 0;

 	/*	Commented by Albert 20110304 */
-	/*	The input data contains two informations. */
+	/*	The input data contains two information. */
 	/*	1. First information is the MAC address which wants to formate with */
 	/*	2. Second information is the WPS PINCode or "pbc" string for push button method */
 	/*	Format: 00:E0:4C:00:00:05 */
@@ -2721,7 +2721,7 @@ static void rtw_p2p_invite_req(struct net_device *dev,
 	uint p2pielen = 0, attr_contentlen = 0;
 	struct tx_invite_req_info *pinvite_req_info = &pwdinfo->invitereq_info;

-	/*	The input data contains two informations. */
+	/*	The input data contains two information items. */
 	/*	1. First information is the P2P device address which you want to send to. */
 	/*	2. Second information is the group id which combines with GO's mac address, space and GO's ssid. */
 	/*	Command line sample: iwpriv wlan0 p2p_set invite ="00:11:22:33:44:55 00:E0:4C:00:00:05 DIRECT-xy" */
@@ -2845,7 +2845,7 @@ static void rtw_p2p_prov_disc(struct net_device *dev,
 	u8 *p2pie;
 	uint p2pielen = 0, attr_contentlen = 0;

-	/*	The input data contains two informations. */
+	/*	The input data contains two information items. */
 	/*	1. First information is the MAC address which wants to issue the provisioning discovery request frame. */
 	/*	2. Second information is the WPS configuration method which wants to discovery */
 	/*	Format: 00:E0:4C:00:00:05_display */
--
2.30.2



