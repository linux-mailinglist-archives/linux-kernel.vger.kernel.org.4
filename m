Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA2F6029BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJRK5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJRK5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:57:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8961BEB3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:57:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b2so13458601plc.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QzfJcaZqJM8gijo1yGAnNoGwiJWkBnyXW/8Y3V4x0Gs=;
        b=XYk+9mx4fqsREc9EWI4zFPbcjlpIE1vFc02QouNaKkJSsDbldsjvArWtsgvZ2Ihp4a
         Li3NKHoskjmtI/UTymIk3AxLmq/g97B78RbPTSjCtTDqq3rcitZf+6wWPwSwNfDP3CMt
         KPVP05qKLRhH3bef4hEzf5svy1UsgdDsk6QUVn83MsuJU1GtdlUzNkL6ePCTyuMTQKli
         EDrADNFfDqalBE+m/xQnoY5IwcQCmR5YMDmfHzXv74C7Jg6Rkh8NvLBR0nfH3oL85ki+
         0oE0hEoibsQ6dSHLX7GR5M4gaAKU8jcMBIUuLBg2L7L9qNuq3uht369fZWLPzoTJ3xp3
         nIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzfJcaZqJM8gijo1yGAnNoGwiJWkBnyXW/8Y3V4x0Gs=;
        b=wpPdOGNL2Aa9pU5YSqqZ4rYD3moMl5bMaH3t6HMlRfRNxWDaP2krLocEmaZfiZJHfO
         V2K98vE0YilJ7USycRk+441xzEGvx5r465FFGjjau97wgSjZajusBwl9+9YRAdBIhG5t
         2dQPdOnwr6MgBDzO7OKIjw5aDhOv2ZUtsyx6YfaX3rNWvrfUlc1pdUvwNPAr+cuWPG08
         vTUT/FrENzPqGLdpI/fTtL/Kw7wHcQ1i6CrVW8eKKHMh1PQOQKv4+K3wI/0o6wKiK33K
         sU8Xy5BfG7CiEsEMMl4Vla2YKcs3fQHymL017WP+fCwmy6o1Pl88QV31Udmt1Gr0VUni
         R+FA==
X-Gm-Message-State: ACrzQf30SOH4igud1wJN2YjmDq7Sz6il5nOdYSy7kCkqxD3s9j+GV6Kq
        GWwjjSJFUDxymetUrwSmokoVUsWfTFcEg544
X-Google-Smtp-Source: AMsMyM5DTeBJecJpkywiCd8GrfSLdz0Rmb1xKE3n37ImFcPpPh6zkLl16mHzADDobqe9inhQfrkMqw==
X-Received: by 2002:a17:902:aa8b:b0:178:8f1d:6936 with SMTP id d11-20020a170902aa8b00b001788f1d6936mr2458576plr.168.1666090620857;
        Tue, 18 Oct 2022 03:57:00 -0700 (PDT)
Received: from jacob-Ubuntu (126.224.215.218.sta.wbroadband.net.au. [218.215.224.126])
        by smtp.gmail.com with ESMTPSA id v124-20020a622f82000000b005627ddbc7a4sm8915216pfv.191.2022.10.18.03.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:57:00 -0700 (PDT)
From:   Jacob Bai <jacob.bai.au@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Jacob Bai <jacob.bai.au@gmail.com>
Subject: [PATCH] staging: r8188eu: replace IEs with ies
Date:   Tue, 18 Oct 2022 21:54:10 +1100
Message-Id: <20221018105409.18331-1-jacob.bai.au@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace wlan_bssid_ex struct member IEs to ies.
CamelCase issue found by checkpatch.

Signed-off-by: Jacob Bai <jacob.bai.au@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c         |  6 +-
 drivers/staging/r8188eu/core/rtw_cmd.c        | 14 ++---
 drivers/staging/r8188eu/core/rtw_ieee80211.c  | 28 ++++-----
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  |  2 +-
 drivers/staging/r8188eu/core/rtw_mlme.c       | 26 ++++----
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 62 +++++++++----------
 drivers/staging/r8188eu/core/rtw_p2p.c        |  4 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 22 +++----
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  8 +--
 drivers/staging/r8188eu/include/ieee80211.h   |  2 +-
 drivers/staging/r8188eu/include/rtw_p2p.h     |  2 +-
 drivers/staging/r8188eu/include/wlan_bssdef.h |  2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 38 ++++++------
 13 files changed, 108 insertions(+), 108 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 24eb8dce9bfe..e34763308f86 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -54,7 +54,7 @@ static void update_BCNTIM(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex *pnetwork_mlmeext = &pmlmeinfo->network;
-	unsigned char *pie = pnetwork_mlmeext->IEs;
+	unsigned char *pie = pnetwork_mlmeext->ies;
 	u8 *p, *dst_ie, *premainder_ie = NULL;
 	u8 *pbackup_remainder_ie = NULL;
 	__le16 tim_bitmap_le;
@@ -535,7 +535,7 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
-	unsigned char *p, *ie = pnetwork->IEs;
+	unsigned char *p, *ie = pnetwork->ies;
 	u32 len = 0;
 
 	if (!pmlmeinfo->ERP_enable)
@@ -570,7 +570,7 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
-	unsigned char *ie = pnetwork->IEs;
+	unsigned char *ie = pnetwork->ies;
 	u32 ielen = pnetwork->IELength;
 
 	pwps_ie = rtw_get_wps_ie(ie + _FIXED_IE_LENGTH_, ielen - _FIXED_IE_LENGTH_, NULL, &wps_ielen);
diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 3fadace33de6..18a30ee62188 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -430,7 +430,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 		res = _FAIL;
 		goto exit;
 	}
-	/* for IEs is fix buf size */
+	/* for ies is fix buf size */
 	t_len = sizeof(struct wlan_bssid_ex);
 
 	/* for hidden ap to set fw_state here */
@@ -463,9 +463,9 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	psecuritypriv->authenticator_ie[0] = (unsigned char)psecnetwork->IELength;
 
 	if (psecnetwork->IELength - 12 < 255)
-		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], psecnetwork->IELength - 12);
+		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], psecnetwork->IELength - 12);
 	else
-		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], 255);
+		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->ies[12], 255);
 
 	psecnetwork->IELength = 0;
 	/*  Added by Albert 2009/02/18 */
@@ -476,14 +476,14 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	if (!pmlmepriv->assoc_by_bssid)
 		memcpy(&pmlmepriv->assoc_bssid[0], &pnetwork->network.MacAddress[0], ETH_ALEN);
 
-	psecnetwork->IELength = rtw_restruct_sec_ie(padapter, &pnetwork->network.IEs[0], &psecnetwork->IEs[0], pnetwork->network.IELength);
+	psecnetwork->IELength = rtw_restruct_sec_ie(padapter, &pnetwork->network.ies[0], &psecnetwork->ies[0], pnetwork->network.IELength);
 
 	pqospriv->qos_option = 0;
 
 	if (pregistrypriv->wmm_enable) {
 		u32 tmp_len;
 
-		tmp_len = rtw_restruct_wmm_ie(padapter, &pnetwork->network.IEs[0], &psecnetwork->IEs[0], pnetwork->network.IELength, psecnetwork->IELength);
+		tmp_len = rtw_restruct_wmm_ie(padapter, &pnetwork->network.ies[0], &psecnetwork->ies[0], pnetwork->network.IELength, psecnetwork->IELength);
 
 		if (psecnetwork->IELength != tmp_len) {
 			psecnetwork->IELength = tmp_len;
@@ -502,12 +502,12 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 		    (padapter->securitypriv.dot11PrivacyAlgrthm != _WEP104_) &&
 		    (padapter->securitypriv.dot11PrivacyAlgrthm != _TKIP_)) {
 			/* rtw_restructure_ht_ie */
-			rtw_restructure_ht_ie(padapter, &pnetwork->network.IEs[0], &psecnetwork->IEs[0],
+			rtw_restructure_ht_ie(padapter, &pnetwork->network.ies[0], &psecnetwork->ies[0],
 									pnetwork->network.IELength, &psecnetwork->IELength);
 		}
 	}
 
-	pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pnetwork->network.IEs, pnetwork->network.IELength);
+	pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pnetwork->network.ies, pnetwork->network.IELength);
 
 	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_TENDA)
 		padapter->pwrctrlpriv.smart_ps = 0;
diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index bc8543ea2e66..ae6cd04d310a 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -213,7 +213,7 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	u8	wireless_mode;
 	int	sz = 0, rateLen;
 	struct wlan_bssid_ex *pdev_network = &pregistrypriv->dev_network;
-	u8 *ie = pdev_network->IEs;
+	u8 *ie = pdev_network->ies;
 
 	/* timestamp will be inserted by hardware */
 	sz += 8;
@@ -518,8 +518,8 @@ u8 rtw_is_wps_ie(u8 *ie_ptr, uint *wps_ielen)
 }
 
 /**
- * rtw_get_wps_ie - Search WPS IE from a series of IEs
- * @in_ie: Address of IEs to search
+ * rtw_get_wps_ie - Search WPS IE from a series of ies
+ * @in_ie: Address of ies to search
  * @in_len: Length limit from in_ie
  * @wps_ie: If not NULL and WPS IE is found, WPS IE will be copied to the buf starting from wps_ie
  * @wps_ielen: If not NULL and WPS IE is found, will set to the length of the entire WPS IE
@@ -708,7 +708,7 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 
 /**
  * ieee802_11_parse_elems - Parse information elements in management frames
- * @start: Pointer to the start of IEs
+ * @start: Pointer to the start of ies
  * @len: Length of IE buffer in octets
  * @elems: Data structure for parsed elements
  * @show_errors: Whether to show parsing errors in debug log
@@ -865,8 +865,8 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 }
 
 /**
- * rtw_get_p2p_ie - Search P2P IE from a series of IEs
- * @in_ie: Address of IEs to search
+ * rtw_get_p2p_ie - Search P2P IE from a series of ies
+ * @in_ie: Address of ies to search
  * @in_len: Length limit from in_ie
  * @p2p_ie: If not NULL and P2P IE is found, P2P IE will be copied to the buf starting from p2p_ie
  * @p2p_ielen: If not NULL and P2P IE is found, will set to the length of the entire P2P IE
@@ -1027,13 +1027,13 @@ void rtw_wlan_bssid_ex_remove_p2p_attr(struct wlan_bssid_ex *bss_ex, u8 attr_id)
 	u8 *p2p_ie;
 	uint p2p_ielen, p2p_ielen_ori;
 
-	p2p_ie = rtw_get_p2p_ie(bss_ex->IEs + _FIXED_IE_LENGTH_, bss_ex->IELength - _FIXED_IE_LENGTH_, NULL, &p2p_ielen_ori);
+	p2p_ie = rtw_get_p2p_ie(bss_ex->ies + _FIXED_IE_LENGTH_, bss_ex->IELength - _FIXED_IE_LENGTH_, NULL, &p2p_ielen_ori);
 	if (p2p_ie) {
 		p2p_ielen = rtw_p2p_attr_remove(p2p_ie, p2p_ielen_ori, attr_id);
 		if (p2p_ielen != p2p_ielen_ori) {
 			u8 *next_ie_ori = p2p_ie + p2p_ielen_ori;
 			u8 *next_ie = p2p_ie + p2p_ielen;
-			uint remain_len = bss_ex->IELength - (next_ie_ori - bss_ex->IEs);
+			uint remain_len = bss_ex->IELength - (next_ie_ori - bss_ex->ies);
 
 			memcpy(next_ie, next_ie_ori, remain_len);
 			memset(next_ie + remain_len, 0, p2p_ielen_ori - p2p_ielen);
@@ -1049,7 +1049,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 	int group_cipher = 0, pairwise_cipher = 0, is8021x = 0;
 	int ret = _FAIL;
 
-	pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength - 12);
+	pbuf = rtw_get_wpa_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.IELength - 12);
 
 	if (pbuf && (wpa_ielen > 0)) {
 		if (rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is8021x) == _SUCCESS) {
@@ -1059,7 +1059,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 			ret = _SUCCESS;
 		}
 	} else {
-		pbuf = rtw_get_wpa2_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength - 12);
+		pbuf = rtw_get_wpa2_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.IELength - 12);
 
 		if (pbuf && (wpa_ielen > 0)) {
 			if (rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is8021x) == _SUCCESS) {
@@ -1085,7 +1085,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 	unsigned int		len;
 	unsigned char		*p;
 
-	memcpy(&le_tmp, rtw_get_capability_from_ie(pnetwork->network.IEs), 2);
+	memcpy(&le_tmp, rtw_get_capability_from_ie(pnetwork->network.ies), 2);
 	cap = le16_to_cpu(le_tmp);
 	if (cap & WLAN_CAPABILITY_PRIVACY) {
 		bencrypt = 1;
@@ -1093,7 +1093,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 	} else {
 		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_OPENSYS;
 	}
-	rtw_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength, NULL, &rsn_len, NULL, &wpa_len);
+	rtw_get_sec_ie(pnetwork->network.ies, pnetwork->network.IELength, NULL, &rsn_len, NULL, &wpa_len);
 
 	if (rsn_len > 0) {
 		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WPA2;
@@ -1107,7 +1107,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 
 	/* get bwmode and ch_offset */
 	/* parsing HT_CAP_IE */
-	p = rtw_get_ie(pnetwork->network.IEs + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, pnetwork->network.IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, pnetwork->network.IELength - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 			pht_cap = (struct ieee80211_ht_cap *)(p + 2);
 			pnetwork->BcnInfo.ht_cap_info = le16_to_cpu(pht_cap->cap_info);
@@ -1115,7 +1115,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 			pnetwork->BcnInfo.ht_cap_info = 0;
 	}
 	/* parsing HT_INFO_IE */
-	p = rtw_get_ie(pnetwork->network.IEs + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, pnetwork->network.IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, pnetwork->network.IELength - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 			pht_info = (struct HT_info_element *)(p + 2);
 			pnetwork->BcnInfo.ht_info_infos_0 = pht_info->infos[0];
diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 55e6b0f41dc3..ab6854cadc59 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -449,7 +449,7 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 		return 0;
 
 	if (pmlmeext->cur_wireless_mode & (WIRELESS_11_24N)) {
-		p = rtw_get_ie(&pcur_bss->IEs[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->IELength - 12);
+		p = rtw_get_ie(&pcur_bss->ies[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->IELength - 12);
 		if (p && ht_ielen > 0) {
 			pht_capie = (struct ieee80211_ht_cap *)(p + 2);
 
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 5ca03d6cac32..b9551b767db5 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -177,7 +177,7 @@ u16 rtw_get_capability(struct wlan_bssid_ex *bss)
 {
 	__le16	val;
 
-	memcpy((u8 *)&val, rtw_get_capability_from_ie(bss->IEs), 2);
+	memcpy((u8 *)&val, rtw_get_capability_from_ie(bss->ies), 2);
 
 	return le16_to_cpu(val);
 }
@@ -362,8 +362,8 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst)
 	u16 s_cap, d_cap;
 	__le16 le_scap, le_dcap;
 
-	memcpy((u8 *)&le_scap, rtw_get_capability_from_ie(src->IEs), 2);
-	memcpy((u8 *)&le_dcap, rtw_get_capability_from_ie(dst->IEs), 2);
+	memcpy((u8 *)&le_scap, rtw_get_capability_from_ie(src->ies), 2);
+	memcpy((u8 *)&le_dcap, rtw_get_capability_from_ie(dst->ies), 2);
 
 	s_cap = le16_to_cpu(le_scap);
 	d_cap = le16_to_cpu(le_dcap);
@@ -455,7 +455,7 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 	if (check_fwstate(pmlmepriv, _FW_LINKED) &&
 	    is_same_network(&pmlmepriv->cur_network.network, pnetwork)) {
 		update_network(&pmlmepriv->cur_network.network, pnetwork, adapter, true);
-		rtw_update_protection(adapter, (pmlmepriv->cur_network.network.IEs) + sizeof(struct ndis_802_11_fixed_ie),
+		rtw_update_protection(adapter, (pmlmepriv->cur_network.network.ies) + sizeof(struct ndis_802_11_fixed_ie),
 				      pmlmepriv->cur_network.network.IELength);
 	}
 
@@ -591,7 +591,7 @@ static bool rtw_is_desired_network(struct adapter *adapter, struct wlan_network
 	privacy = pnetwork->network.Privacy;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
-		if (rtw_get_wps_ie(pnetwork->network.IEs + _FIXED_IE_LENGTH_, pnetwork->network.IELength - _FIXED_IE_LENGTH_, NULL, &wps_ielen))
+		if (rtw_get_wps_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, pnetwork->network.IELength - _FIXED_IE_LENGTH_, NULL, &wps_ielen))
 			return true;
 		else
 			return false;
@@ -603,7 +603,7 @@ static bool rtw_is_desired_network(struct adapter *adapter, struct wlan_network
 		if ((desired_encmode == Ndis802_11EncryptionDisabled) && (privacy != 0))
 			bselected = false;
 		if (psecuritypriv->ndisauthtype == Ndis802_11AuthModeWPA2PSK) {
-			p = rtw_get_ie(pnetwork->network.IEs + _BEACON_IE_OFFSET_,
+			p = rtw_get_ie(pnetwork->network.ies + _BEACON_IE_OFFSET_,
 				       _RSN_IE_2_, &ie_len,
 				       (pnetwork->network.IELength -
 				       _BEACON_IE_OFFSET_));
@@ -643,11 +643,11 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress, pnetwork->MacAddress, ETH_ALEN)) {
 			struct wlan_network *ibss_wlan = NULL;
 
-			memcpy(pmlmepriv->cur_network.network.IEs, pnetwork->IEs, 8);
+			memcpy(pmlmepriv->cur_network.network.ies, pnetwork->ies, 8);
 			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 			ibss_wlan = rtw_find_network(&pmlmepriv->scanned_queue,  pnetwork->MacAddress);
 			if (ibss_wlan) {
-				memcpy(ibss_wlan->network.IEs, pnetwork->IEs, 8);
+				memcpy(ibss_wlan->network.ies, pnetwork->ies, 8);
 				spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 				goto exit;
 			}
@@ -1009,9 +1009,9 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 
 	/*  why not use ptarget_wlan?? */
 	memcpy(&cur_network->network, &pnetwork->network, pnetwork->network.Length);
-	/*  some IEs in pnetwork is wrong, so we should use ptarget_wlan IEs */
+	/*  some ies in pnetwork is wrong, so we should use ptarget_wlan ies */
 	cur_network->network.IELength = ptarget_wlan->network.IELength;
-	memcpy(&cur_network->network.IEs[0], &ptarget_wlan->network.IEs[0], MAX_IE_SZ);
+	memcpy(&cur_network->network.ies[0], &ptarget_wlan->network.ies[0], MAX_IE_SZ);
 
 	cur_network->aid = pnetwork->join_res;
 
@@ -1038,10 +1038,10 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 		break;
 	}
 
-	rtw_update_protection(padapter, (cur_network->network.IEs) +
+	rtw_update_protection(padapter, (cur_network->network.ies) +
 			      sizeof(struct ndis_802_11_fixed_ie),
 			      (cur_network->network.IELength));
-	rtw_update_ht_cap(padapter, cur_network->network.IEs, cur_network->network.IELength);
+	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.IELength);
 }
 
 /* Notes: the function could be > passive_level (the same context as Rx tasklet) */
@@ -1650,7 +1650,7 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	return res;
 }
 
-/* adjust IEs for rtw_joinbss_cmd in WMM */
+/* adjust ies for rtw_joinbss_cmd in WMM */
 int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_len, uint initial_out_len)
 {
 	unsigned	int ielength = 0;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 07905e2ae8e0..c9e1a26b950d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -4189,17 +4189,17 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 		/*  for P2P : Primary Device Type & Device Name */
 		u32 wpsielen = 0, insert_len = 0;
 		u8 *wpsie = NULL;
-		wpsie = rtw_get_wps_ie(cur_network->IEs + _FIXED_IE_LENGTH_, cur_network->IELength - _FIXED_IE_LENGTH_, NULL, &wpsielen);
+		wpsie = rtw_get_wps_ie(cur_network->ies + _FIXED_IE_LENGTH_, cur_network->IELength - _FIXED_IE_LENGTH_, NULL, &wpsielen);
 
 		if (rtw_p2p_chk_role(pwdinfo, P2P_ROLE_GO) && wpsie && wpsielen > 0) {
 			uint wps_offset, remainder_ielen;
 			u8 *premainder_ie, *pframe_wscie;
 
-			wps_offset = (uint)(wpsie - cur_network->IEs);
+			wps_offset = (uint)(wpsie - cur_network->ies);
 			premainder_ie = wpsie + wpsielen;
 			remainder_ielen = cur_network->IELength - wps_offset - wpsielen;
 			pframe_wscie = pframe + wps_offset;
-			memcpy(pframe, cur_network->IEs, wps_offset + wpsielen);
+			memcpy(pframe, cur_network->ies, wps_offset + wpsielen);
 			pframe += (wps_offset + wpsielen);
 			pattrib->pktlen += (wps_offset + wpsielen);
 
@@ -4252,7 +4252,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 			pattrib->pktlen += remainder_ielen;
 		} else {
 			int len_diff;
-			memcpy(pframe, cur_network->IEs, cur_network->IELength);
+			memcpy(pframe, cur_network->ies, cur_network->IELength);
 			len_diff = update_hidden_ssid(
 				pframe + _BEACON_IE_OFFSET_
 				, cur_network->IELength - _BEACON_IE_OFFSET_
@@ -4295,14 +4295,14 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 	/*  beacon interval: 2 bytes */
 
-	memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->IEs)), 2);
+	memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->ies)), 2);
 
 	pframe += 2;
 	pattrib->pktlen += 2;
 
 	/*  capability info: 2 bytes */
 
-	memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->IEs)), 2);
+	memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->ies)), 2);
 
 	pframe += 2;
 	pattrib->pktlen += 2;
@@ -4401,20 +4401,20 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 		return;
 
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
-		pwps_ie = rtw_get_wps_ie(cur_network->IEs + _FIXED_IE_LENGTH_, cur_network->IELength - _FIXED_IE_LENGTH_, NULL, &wps_ielen);
+		pwps_ie = rtw_get_wps_ie(cur_network->ies + _FIXED_IE_LENGTH_, cur_network->IELength - _FIXED_IE_LENGTH_, NULL, &wps_ielen);
 
 		/* inerset & update wps_probe_resp_ie */
 		if (pmlmepriv->wps_probe_resp_ie && pwps_ie && wps_ielen > 0) {
 			uint wps_offset, remainder_ielen;
 			u8 *premainder_ie;
 
-			wps_offset = (uint)(pwps_ie - cur_network->IEs);
+			wps_offset = (uint)(pwps_ie - cur_network->ies);
 
 			premainder_ie = pwps_ie + wps_ielen;
 
 			remainder_ielen = cur_network->IELength - wps_offset - wps_ielen;
 
-			memcpy(pframe, cur_network->IEs, wps_offset);
+			memcpy(pframe, cur_network->ies, wps_offset);
 			pframe += wps_offset;
 			pattrib->pktlen += wps_offset;
 
@@ -4431,7 +4431,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 				pattrib->pktlen += remainder_ielen;
 			}
 		} else {
-			memcpy(pframe, cur_network->IEs, cur_network->IELength);
+			memcpy(pframe, cur_network->ies, cur_network->IELength);
 			pframe += cur_network->IELength;
 			pattrib->pktlen += cur_network->IELength;
 		}
@@ -4442,14 +4442,14 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 
 		/*  beacon interval: 2 bytes */
 
-		memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->IEs)), 2);
+		memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->ies)), 2);
 
 		pframe += 2;
 		pattrib->pktlen += 2;
 
 		/*  capability info: 2 bytes */
 
-		memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->IEs)), 2);
+		memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->ies)), 2);
 
 		pframe += 2;
 		pattrib->pktlen += 2;
@@ -4755,7 +4755,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
-	u8 *ie = pnetwork->IEs;
+	u8 *ie = pnetwork->ies;
 	__le16 lestatus, leval;
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
@@ -4919,7 +4919,7 @@ void issue_assocreq(struct adapter *padapter)
 
 	/* caps */
 
-	memcpy(pframe, rtw_get_capability_from_ie(pmlmeinfo->network.IEs), 2);
+	memcpy(pframe, rtw_get_capability_from_ie(pmlmeinfo->network.ies), 2);
 
 	pframe += 2;
 	pattrib->pktlen += 2;
@@ -4975,13 +4975,13 @@ void issue_assocreq(struct adapter *padapter)
 	}
 
 	/* RSN */
-	p = rtw_get_ie((pmlmeinfo->network.IEs + sizeof(struct ndis_802_11_fixed_ie)), _RSN_IE_2_, &ie_len, (pmlmeinfo->network.IELength - sizeof(struct ndis_802_11_fixed_ie)));
+	p = rtw_get_ie((pmlmeinfo->network.ies + sizeof(struct ndis_802_11_fixed_ie)), _RSN_IE_2_, &ie_len, (pmlmeinfo->network.IELength - sizeof(struct ndis_802_11_fixed_ie)));
 	if (p)
 		pframe = rtw_set_ie(pframe, _RSN_IE_2_, ie_len, p + 2, &pattrib->pktlen);
 
 	/* HT caps */
 	if (padapter->mlmepriv.htpriv.ht_option) {
-		p = rtw_get_ie((pmlmeinfo->network.IEs + sizeof(struct ndis_802_11_fixed_ie)), _HT_CAPABILITY_IE_, &ie_len, (pmlmeinfo->network.IELength - sizeof(struct ndis_802_11_fixed_ie)));
+		p = rtw_get_ie((pmlmeinfo->network.ies + sizeof(struct ndis_802_11_fixed_ie)), _HT_CAPABILITY_IE_, &ie_len, (pmlmeinfo->network.IELength - sizeof(struct ndis_802_11_fixed_ie)));
 		if (p && !is_ap_in_tkip(padapter)) {
 			memcpy(&pmlmeinfo->HT_caps, p + 2, sizeof(struct HT_caps_element));
 
@@ -5004,7 +5004,7 @@ void issue_assocreq(struct adapter *padapter)
 
 	/* vendor specific IE, such as WPA, WMM, WPS */
 	for (i = sizeof(struct ndis_802_11_fixed_ie); i < pmlmeinfo->network.IELength;) {
-		pIE = (struct ndis_802_11_var_ie *)(pmlmeinfo->network.IEs + i);
+		pIE = (struct ndis_802_11_var_ie *)(pmlmeinfo->network.ies + i);
 
 		switch (pIE->ElementID) {
 		case _VENDOR_SPECIFIC_IE_:
@@ -5653,7 +5653,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 
 			pbss_network = (struct wlan_bssid_ex *)&pnetwork->network;
 
-			p = rtw_get_ie(pbss_network->IEs + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, pbss_network->IELength - _FIXED_IE_LENGTH_);
+			p = rtw_get_ie(pbss_network->ies + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, pbss_network->IELength - _FIXED_IE_LENGTH_);
 			if (!p || len == 0) { /* non-HT */
 				if ((pbss_network->Configuration.DSConfig <= 0) || (pbss_network->Configuration.DSConfig > 14))
 					continue;
@@ -6150,7 +6150,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 
 	/* below is to copy the information element */
 	bssid->IELength = len;
-	memcpy(bssid->IEs, (pframe + sizeof(struct ieee80211_hdr_3addr)), bssid->IELength);
+	memcpy(bssid->ies, (pframe + sizeof(struct ieee80211_hdr_3addr)), bssid->IELength);
 
 	/* get the signal strength */
 	bssid->Rssi = precv_frame->attrib.phy_info.recvpower; /*  in dBM.raw data */
@@ -6159,7 +6159,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 	bssid->PhyInfo.Optimum_antenna = rtw_current_antenna(padapter);
 
 	/*  checking SSID */
-	p = rtw_get_ie(bssid->IEs + ie_offset, _SSID_IE_, &len, bssid->IELength - ie_offset);
+	p = rtw_get_ie(bssid->ies + ie_offset, _SSID_IE_, &len, bssid->IELength - ie_offset);
 	if (!p)
 		return _FAIL;
 
@@ -6176,7 +6176,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 
 	/* checking rate info... */
 	i = 0;
-	p = rtw_get_ie(bssid->IEs + ie_offset, _SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
+	p = rtw_get_ie(bssid->ies + ie_offset, _SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
 	if (p) {
 		if (len > NDIS_802_11_LENGTH_RATES_EX)
 			return _FAIL;
@@ -6184,7 +6184,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 		i = len;
 	}
 
-	p = rtw_get_ie(bssid->IEs + ie_offset, _EXT_SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
+	p = rtw_get_ie(bssid->ies + ie_offset, _EXT_SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
 	if (p) {
 		if (len > (NDIS_802_11_LENGTH_RATES_EX - i))
 			return _FAIL;
@@ -6198,7 +6198,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 		return _FAIL;
 
 	/*  Checking for DSConfig */
-	p = rtw_get_ie(bssid->IEs + ie_offset, _DSSET_IE_, &len, bssid->IELength - ie_offset);
+	p = rtw_get_ie(bssid->ies + ie_offset, _DSSET_IE_, &len, bssid->IELength - ie_offset);
 
 	bssid->Configuration.DSConfig = 0;
 	bssid->Configuration.Length = 0;
@@ -6207,7 +6207,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 		bssid->Configuration.DSConfig = *(p + 2);
 	} else {/*  In 5G, some ap do not have DSSET IE */
 		/*  checking HT info for channel */
-		p = rtw_get_ie(bssid->IEs + ie_offset, _HT_ADD_INFO_IE_, &len, bssid->IELength - ie_offset);
+		p = rtw_get_ie(bssid->ies + ie_offset, _HT_ADD_INFO_IE_, &len, bssid->IELength - ie_offset);
 		if (p) {
 			struct HT_info_element *HT_info = (struct HT_info_element *)(p + 2);
 			bssid->Configuration.DSConfig = HT_info->primary_channel;
@@ -6216,7 +6216,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 		}
 	}
 
-	memcpy(&le32_tmp, rtw_get_beacon_interval_from_ie(bssid->IEs), 2);
+	memcpy(&le32_tmp, rtw_get_beacon_interval_from_ie(bssid->ies), 2);
 	bssid->Configuration.BeaconPeriod = le32_to_cpu(le32_tmp);
 
 	val16 = rtw_get_capability((struct wlan_bssid_ex *)bssid);
@@ -6239,7 +6239,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 	/* 20/40 BSS Coexistence check */
 	if ((pregistrypriv->wifi_spec == 1) && (!pmlmeinfo->bwmode_updated)) {
 		struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-		p = rtw_get_ie(bssid->IEs + ie_offset, _HT_CAPABILITY_IE_, &len, bssid->IELength - ie_offset);
+		p = rtw_get_ie(bssid->ies + ie_offset, _HT_CAPABILITY_IE_, &len, bssid->IELength - ie_offset);
 		if (p && len > 0) {
 			struct HT_caps_element	*pHT_caps;
 			pHT_caps = (struct HT_caps_element *)(p + 2);
@@ -6503,7 +6503,7 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 		u8 noc; /*  number of channel */
 		u8 j, k;
 
-		ie = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _COUNTRY_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+		ie = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, _COUNTRY_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
 		if (!ie)
 			return;
 		if (len < 6)
@@ -7401,7 +7401,7 @@ u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 		if (pnetwork->IELength > MAX_IE_SZ)/* Check pbuf->IELength */
 			return H2C_PARAMETERS_ERROR;
 
-		memcpy(pnetwork->IEs, ((struct wlan_bssid_ex *)pbuf)->IEs, pnetwork->IELength);
+		memcpy(pnetwork->ies, ((struct wlan_bssid_ex *)pbuf)->ies, pnetwork->IELength);
 
 		start_create_ibss(padapter);
 	}
@@ -7458,12 +7458,12 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	if (pnetwork->IELength > MAX_IE_SZ)/* Check pbuf->IELength */
 		return H2C_PARAMETERS_ERROR;
 
-	memcpy(pnetwork->IEs, ((struct wlan_bssid_ex *)pbuf)->IEs, pnetwork->IELength);
+	memcpy(pnetwork->ies, ((struct wlan_bssid_ex *)pbuf)->ies, pnetwork->IELength);
 
 	/* Check AP vendor to move rtw_joinbss_cmd() */
 
 	for (i = sizeof(struct ndis_802_11_fixed_ie); i < pnetwork->IELength;) {
-		pIE = (struct ndis_802_11_var_ie *)(pnetwork->IEs + i);
+		pIE = (struct ndis_802_11_var_ie *)(pnetwork->ies + i);
 
 		switch (pIE->ElementID) {
 		case _VENDOR_SPECIFIC_IE_:/* Get WMM IE. */
@@ -7816,7 +7816,7 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 
 	memcpy(&ptxBeacon_parm->network, &pmlmeinfo->network, sizeof(struct wlan_bssid_ex));
 
-	len_diff = update_hidden_ssid(ptxBeacon_parm->network.IEs + _BEACON_IE_OFFSET_,
+	len_diff = update_hidden_ssid(ptxBeacon_parm->network.ies + _BEACON_IE_OFFSET_,
 				      ptxBeacon_parm->network.IELength - _BEACON_IE_OFFSET_,
 				      pmlmeinfo->hidden_ssid_mode);
 	ptxBeacon_parm->network.IELength += len_diff;
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index dc159e58f428..a18f1f491acb 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -1503,7 +1503,7 @@ void p2p_protocol_wk_hdl(struct adapter *padapter, int intCmdType)
 
 }
 
-void process_p2p_ps_ie(struct adapter *padapter, u8 *IEs, u32 IELength)
+void process_p2p_ps_ie(struct adapter *padapter, u8 *ie, u32 IELength)
 {
 	u8 *ies;
 	u32 ies_len;
@@ -1521,7 +1521,7 @@ void process_p2p_ps_ie(struct adapter *padapter, u8 *IEs, u32 IELength)
 	if (IELength <= _BEACON_IE_OFFSET_)
 		return;
 
-	ies = IEs + _BEACON_IE_OFFSET_;
+	ies = ie + _BEACON_IE_OFFSET_;
 	ies_len = IELength - _BEACON_IE_OFFSET_;
 
 	p2p_ie = rtw_get_p2p_ie(ies, ies_len, NULL, &p2p_ielen);
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index e50631848cab..ee6d72bedb3e 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -326,7 +326,7 @@ __inline u8 *get_my_bssid(struct wlan_bssid_ex *pnetwork)
 u16 get_beacon_interval(struct wlan_bssid_ex *bss)
 {
 	__le16 val;
-	memcpy((unsigned char *)&val, rtw_get_beacon_interval_from_ie(bss->IEs), 2);
+	memcpy((unsigned char *)&val, rtw_get_beacon_interval_from_ie(bss->ies), 2);
 
 	return le16_to_cpu(val);
 }
@@ -917,11 +917,11 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 
 	/* below is to copy the information element */
 	bssid->IELength = len;
-	memcpy(bssid->IEs, (pframe + sizeof(struct ieee80211_hdr_3addr)), bssid->IELength);
+	memcpy(bssid->ies, (pframe + sizeof(struct ieee80211_hdr_3addr)), bssid->IELength);
 
 	/* check bw and channel offset */
 	/* parsing HT_CAP_IE */
-	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 		pht_cap = (struct ieee80211_ht_cap *)(p + 2);
 		ht_cap_info = le16_to_cpu(pht_cap->cap_info);
@@ -929,7 +929,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 		ht_cap_info = 0;
 	}
 	/* parsing HT_INFO_IE */
-	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 			pht_info = (struct HT_info_element *)(p + 2);
 			ht_info_infos_0 = pht_info->infos[0];
@@ -946,11 +946,11 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	}
 
 	/* Checking for channel */
-	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _DSSET_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, _DSSET_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
 	if (p) {
 			bcn_channel = *(p + 2);
 	} else {/* In 5G, some ap do not have DSSET IE checking HT info for channel */
-			p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+			p = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
 			if (pht_info)
 				bcn_channel = pht_info->primary_channel;
 			else /* we don't find channel IE, so don't check it */
@@ -960,7 +960,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 		goto _mismatch;
 
 	/* checking SSID */
-	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _SSID_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, _SSID_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
 	if (!p)
 		hidden_ssid = true;
 	else
@@ -992,7 +992,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	if (cur_network->network.Privacy != bssid->Privacy)
 		goto _mismatch;
 
-	rtw_get_sec_ie(bssid->IEs, bssid->IELength, NULL, &rsn_len, NULL, &wpa_len);
+	rtw_get_sec_ie(bssid->ies, bssid->IELength, NULL, &rsn_len, NULL, &wpa_len);
 
 	if (rsn_len > 0) {
 		encryp_protocol = ENCRYP_PROTOCOL_WPA2;
@@ -1007,11 +1007,11 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 		goto _mismatch;
 
 	if (encryp_protocol == ENCRYP_PROTOCOL_WPA || encryp_protocol == ENCRYP_PROTOCOL_WPA2) {
-		pbuf = rtw_get_wpa_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength - 12);
+		pbuf = rtw_get_wpa_ie(&bssid->ies[12], &wpa_ielen, bssid->IELength - 12);
 		if (pbuf && (wpa_ielen > 0)) {
 			rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is_8021x);
 		} else {
-			pbuf = rtw_get_wpa2_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength - 12);
+			pbuf = rtw_get_wpa2_ie(&bssid->ies[12], &wpa_ielen, bssid->IELength - 12);
 
 			if (pbuf && (wpa_ielen > 0))
 				rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is_8021x);
@@ -1073,7 +1073,7 @@ bool is_ap_in_tkip(struct adapter *padapter)
 
 	if (rtw_get_capability((struct wlan_bssid_ex *)cur_network) & WLAN_CAPABILITY_PRIVACY) {
 		for (i = sizeof(struct ndis_802_11_fixed_ie); i < pmlmeinfo->network.IELength;) {
-			pIE = (struct ndis_802_11_var_ie *)(pmlmeinfo->network.IEs + i);
+			pIE = (struct ndis_802_11_var_ie *)(pmlmeinfo->network.ies + i);
 
 			switch (pIE->ElementID) {
 			case _VENDOR_SPECIFIC_IE_:
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 8310d7f53982..c346e576ce4b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -229,20 +229,20 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	pktlen += 8;
 
 	/*  beacon interval: 2 bytes */
-	memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->IEs)), 2);
+	memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->ies)), 2);
 
 	pframe += 2;
 	pktlen += 2;
 
 	/*  capability info: 2 bytes */
-	memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->IEs)), 2);
+	memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->ies)), 2);
 
 	pframe += 2;
 	pktlen += 2;
 
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 		pktlen += cur_network->IELength - sizeof(struct ndis_802_11_fixed_ie);
-		memcpy(pframe, cur_network->IEs + sizeof(struct ndis_802_11_fixed_ie), pktlen);
+		memcpy(pframe, cur_network->ies + sizeof(struct ndis_802_11_fixed_ie), pktlen);
 
 		goto _ConstructBeacon;
 	}
@@ -404,7 +404,7 @@ static void ConstructProbeRsp(struct adapter *adapt, u8 *pframe, u32 *pLength, u
 	if (cur_network->IELength > MAX_IE_SZ)
 		return;
 
-	memcpy(pframe, cur_network->IEs, cur_network->IELength);
+	memcpy(pframe, cur_network->ies, cur_network->IELength);
 	pframe += cur_network->IELength;
 	pktlen += cur_network->IELength;
 
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index e7a4f8af497a..01b90662af3a 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -777,7 +777,7 @@ u8 *rtw_get_wps_attr_content(u8 *wps_ie, uint wps_ielen, u16 target_attr_id,
 			     u8 *buf_content, uint *len_content);
 
 /**
- * for_each_ie - iterate over continuous IEs
+ * for_each_ie - iterate over continuous ies
  * @ie:
  * @buf:
  * @buf_len:
diff --git a/drivers/staging/r8188eu/include/rtw_p2p.h b/drivers/staging/r8188eu/include/rtw_p2p.h
index b91322a1fe10..6538a6d288fb 100644
--- a/drivers/staging/r8188eu/include/rtw_p2p.h
+++ b/drivers/staging/r8188eu/include/rtw_p2p.h
@@ -33,7 +33,7 @@ u8 process_p2p_group_negotation_confirm(struct wifidirect_info *pwdinfo,
 u8 process_p2p_presence_req(struct wifidirect_info *pwdinfo, u8 *pframe,
 			    uint len);
 void p2p_protocol_wk_hdl(struct adapter *padapter, int intcmdtype);
-void process_p2p_ps_ie(struct adapter *padapter, u8 *ies, u32 ielength);
+void process_p2p_ps_ie(struct adapter *padapter, u8 *ie, u32 ielength);
 void p2p_ps_wk_hdl(struct adapter *padapter, u8 p2p_ps_state);
 u8 p2p_ps_wk_cmd(struct adapter *padapter, u8 p2p_ps_state, u8 enqueue);
 void reset_global_wifidirect_info(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/include/wlan_bssdef.h b/drivers/staging/r8188eu/include/wlan_bssdef.h
index 81bda91a4136..878d76084788 100644
--- a/drivers/staging/r8188eu/include/wlan_bssdef.h
+++ b/drivers/staging/r8188eu/include/wlan_bssdef.h
@@ -239,7 +239,7 @@ struct wlan_bssid_ex {
 	unsigned char SupportedRates[NDIS_802_11_LENGTH_RATES_EX];
 	struct wlan_phy_info	PhyInfo;
 	u32  IELength;
-	u8  IEs[MAX_IE_SZ];	/* timestamp, beacon interval, and
+	u8  ies[MAX_IE_SZ];	/* timestamp, beacon interval, and
 				 * capability information) */
 } __packed;
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 2de2e1e32738..ba9cbda9804b 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -104,11 +104,11 @@ static char *translate_scan(struct adapter *padapter,
 
 			if (pnetwork->network.Reserved[0] == 2) {/*  Probe Request */
 				/*	Verifying the P2P IE */
-				if (rtw_get_p2p_ie(pnetwork->network.IEs, pnetwork->network.IELength, NULL, &p2pielen))
+				if (rtw_get_p2p_ie(pnetwork->network.ies, pnetwork->network.IELength, NULL, &p2pielen))
 					blnGotP2PIE = true;
 			} else {/*  Beacon or Probe Respones */
 				/*	Verifying the P2P IE */
-				if (rtw_get_p2p_ie(&pnetwork->network.IEs[12], pnetwork->network.IELength - 12, NULL, &p2pielen))
+				if (rtw_get_p2p_ie(&pnetwork->network.ies[12], pnetwork->network.IELength - 12, NULL, &p2pielen))
 					blnGotP2PIE = true;
 			}
 		}
@@ -131,7 +131,7 @@ static char *translate_scan(struct adapter *padapter,
 	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.Ssid.Ssid);
 
 	/* parsing HT_CAP_IE */
-	p = rtw_get_ie(&pnetwork->network.IEs[12], _HT_CAPABILITY_IE_, &ht_ielen, pnetwork->network.IELength - 12);
+	p = rtw_get_ie(&pnetwork->network.ies[12], _HT_CAPABILITY_IE_, &ht_ielen, pnetwork->network.IELength - 12);
 
 	if (p && ht_ielen > 0) {
 		struct ieee80211_ht_cap *pht_capie;
@@ -168,7 +168,7 @@ static char *translate_scan(struct adapter *padapter,
 
 	  /* Add mode */
 	iwe.cmd = SIOCGIWMODE;
-	memcpy(&le_tmp, rtw_get_capability_from_ie(pnetwork->network.IEs), 2);
+	memcpy(&le_tmp, rtw_get_capability_from_ie(pnetwork->network.ies), 2);
 
 	cap = le16_to_cpu(le_tmp);
 
@@ -254,7 +254,7 @@ static char *translate_scan(struct adapter *padapter,
 			kfree(wpa_ie);
 			goto exit;
 		}
-		rtw_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength, rsn_ie, &rsn_len, wpa_ie, &wpa_len);
+		rtw_get_sec_ie(pnetwork->network.ies, pnetwork->network.IELength, rsn_ie, &rsn_len, wpa_ie, &wpa_len);
 
 		if (wpa_len > 0) {
 			p = buf;
@@ -299,7 +299,7 @@ static char *translate_scan(struct adapter *padapter,
 		u8 *wpsie_ptr = NULL;
 		uint wps_ielen = 0;
 
-		u8 *ie_ptr = pnetwork->network.IEs + _FIXED_IE_LENGTH_;
+		u8 *ie_ptr = pnetwork->network.ies + _FIXED_IE_LENGTH_;
 		total_ielen = pnetwork->network.IELength - _FIXED_IE_LENGTH_;
 
 		while (cnt < total_ielen) {
@@ -627,7 +627,7 @@ static int rtw_wx_get_name(struct net_device *dev,
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
 		/* parsing HT_CAP_IE */
-		p = rtw_get_ie(&pcur_bss->IEs[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->IELength - 12);
+		p = rtw_get_ie(&pcur_bss->ies[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->IELength - 12);
 		if (p && ht_ielen > 0)
 			ht_cap = true;
 
@@ -1986,13 +1986,13 @@ static int rtw_get_ap_info(struct net_device *dev,
 
 		if (!memcmp(bssid, pnetwork->network.MacAddress, ETH_ALEN)) {
 			/* BSSID match, then check if supporting wpa/wpa2 */
-			pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength - 12);
+			pbuf = rtw_get_wpa_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.IELength - 12);
 			if (pbuf && (wpa_ielen > 0)) {
 				pdata->flags = 1;
 				break;
 			}
 
-			pbuf = rtw_get_wpa2_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength - 12);
+			pbuf = rtw_get_wpa2_ie(&pnetwork->network.ies[12], &wpa_ielen, pnetwork->network.IELength - 12);
 			if (pbuf && (wpa_ielen > 0)) {
 				pdata->flags = 2;
 				break;
@@ -2314,7 +2314,7 @@ static int rtw_p2p_get_wps_configmethod(struct net_device *dev,
 			__be16 be_tmp;
 
 			/*  The mac address is matched. */
-			wpsie = rtw_get_wps_ie(&pnetwork->network.IEs[12], pnetwork->network.IELength - 12, NULL, &wpsie_len);
+			wpsie = rtw_get_wps_ie(&pnetwork->network.ies[12], pnetwork->network.IELength - 12, NULL, &wpsie_len);
 			if (wpsie) {
 				rtw_get_wps_attr_content(wpsie, wpsie_len, WPS_ATTR_CONF_METHOD, (u8 *)&be_tmp, &attr_contentlen);
 				if (attr_contentlen) {
@@ -2380,7 +2380,7 @@ static int rtw_p2p_get_go_device_address(struct net_device *dev,
 			/*	Match the device address located in the P2P IE */
 			/*	This is for the case that the P2P device address is not the same as the P2P interface address. */
 
-			p2pie = rtw_get_p2p_ie(&pnetwork->network.IEs[12], pnetwork->network.IELength - 12, NULL, &p2pielen);
+			p2pie = rtw_get_p2p_ie(&pnetwork->network.ies[12], pnetwork->network.IELength - 12, NULL, &p2pielen);
 			if (p2pie) {
 				while (p2pie) {
 					/*	The P2P Device ID attribute is included in the Beacon frame. */
@@ -2398,7 +2398,7 @@ static int rtw_p2p_get_go_device_address(struct net_device *dev,
 					}
 
 					/* Get the next P2P IE */
-					p2pie = rtw_get_p2p_ie(p2pie + p2pielen, pnetwork->network.IELength - 12 - (p2pie - &pnetwork->network.IEs[12] + p2pielen), NULL, &p2pielen);
+					p2pie = rtw_get_p2p_ie(p2pie + p2pielen, pnetwork->network.IELength - 12 - (p2pie - &pnetwork->network.ies[12] + p2pielen), NULL, &p2pielen);
 				}
 			}
 	     }
@@ -2460,7 +2460,7 @@ static int rtw_p2p_get_device_type(struct net_device *dev,
 
 		/*	The mac address is matched. */
 
-			wpsie = rtw_get_wps_ie(&pnetwork->network.IEs[12],
+			wpsie = rtw_get_wps_ie(&pnetwork->network.ies[12],
 					       pnetwork->network.IELength - 12,
 					       NULL, &wpsie_len);
 			if (wpsie) {
@@ -2533,7 +2533,7 @@ static int rtw_p2p_get_device_name(struct net_device *dev,
 			uint wpsie_len = 0;
 
 			/*	The mac address is matched. */
-			wpsie = rtw_get_wps_ie(&pnetwork->network.IEs[12], pnetwork->network.IELength - 12, NULL, &wpsie_len);
+			wpsie = rtw_get_wps_ie(&pnetwork->network.ies[12], pnetwork->network.IELength - 12, NULL, &wpsie_len);
 			if (wpsie) {
 				rtw_get_wps_attr_content(wpsie, wpsie_len, WPS_ATTR_DEVICE_NAME, dev_name, &dev_len);
 				if (dev_len) {
@@ -2599,7 +2599,7 @@ static int rtw_p2p_get_invitation_procedure(struct net_device *dev,
 			/*	Match the device address located in the P2P IE */
 			/*	This is for the case that the P2P device address is not the same as the P2P interface address. */
 
-			p2pie = rtw_get_p2p_ie(&pnetwork->network.IEs[12], pnetwork->network.IELength - 12, NULL, &p2pielen);
+			p2pie = rtw_get_p2p_ie(&pnetwork->network.ies[12], pnetwork->network.IELength - 12, NULL, &p2pielen);
 			if (p2pie) {
 				while (p2pie) {
 					if (rtw_get_p2p_attr_content(p2pie, p2pielen, P2P_ATTR_CAPABILITY, attr_content, &attr_contentlen)) {
@@ -2609,7 +2609,7 @@ static int rtw_p2p_get_invitation_procedure(struct net_device *dev,
 					}
 
 					/* Get the next P2P IE */
-					p2pie = rtw_get_p2p_ie(p2pie + p2pielen, pnetwork->network.IELength - 12 - (p2pie - &pnetwork->network.IEs[12] + p2pielen), NULL, &p2pielen);
+					p2pie = rtw_get_p2p_ie(p2pie + p2pielen, pnetwork->network.IELength - 12 - (p2pie - &pnetwork->network.ies[12] + p2pielen), NULL, &p2pielen);
 				}
 			}
 		}
@@ -2758,7 +2758,7 @@ static void rtw_p2p_invite_req(struct net_device *dev,
 		/*	Match the device address located in the P2P IE */
 		/*	This is for the case that the P2P device address is not the same as the P2P interface address. */
 
-		p2pie = rtw_get_p2p_ie(&pnetwork->network.IEs[12], pnetwork->network.IELength - 12, NULL, &p2pielen);
+		p2pie = rtw_get_p2p_ie(&pnetwork->network.ies[12], pnetwork->network.IELength - 12, NULL, &p2pielen);
 		if (p2pie) {
 			/*	The P2P Device ID attribute is included in the Beacon frame. */
 			/*	The P2P Device Info attribute is included in the probe response frame. */
@@ -2894,7 +2894,7 @@ static void rtw_p2p_prov_disc(struct net_device *dev,
 		/*	Match the device address located in the P2P IE */
 		/*	This is for the case that the P2P device address is not the same as the P2P interface address. */
 
-		p2pie = rtw_get_p2p_ie(&pnetwork->network.IEs[12], pnetwork->network.IELength - 12, NULL, &p2pielen);
+		p2pie = rtw_get_p2p_ie(&pnetwork->network.ies[12], pnetwork->network.IELength - 12, NULL, &p2pielen);
 		if (p2pie) {
 			while (p2pie) {
 				/*	The P2P Device ID attribute is included in the Beacon frame. */
@@ -2915,7 +2915,7 @@ static void rtw_p2p_prov_disc(struct net_device *dev,
 				}
 
 				/* Get the next P2P IE */
-				p2pie = rtw_get_p2p_ie(p2pie + p2pielen, pnetwork->network.IELength - 12 - (p2pie - &pnetwork->network.IEs[12] + p2pielen), NULL, &p2pielen);
+				p2pie = rtw_get_p2p_ie(p2pie + p2pielen, pnetwork->network.IELength - 12 - (p2pie - &pnetwork->network.ies[12] + p2pielen), NULL, &p2pielen);
 			}
 		}
 
-- 
2.34.1

