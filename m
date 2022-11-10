Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E8E623E48
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiKJJJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiKJJJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:09:38 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B52BC0A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:09:36 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id q9so3478624ejd.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pbwPLiliA6qVCCVy57H0oUR5ejruLx9vHLLWXjfA44k=;
        b=M9/SStBP22zAZt9Qfc4yJji/7RWrXPiT/rsr3ScQRavF+T2Ax/bu/J/6gUAWFv14tH
         MoMQ6sm38ajfGjsv+isc8Dq/4B8QPcdnlkxjFcYJt31uyRy0+PLhoF6KaVE4AIDXMSsM
         hGFSyc9vWyMM2G8qgvNrbWDnVQLq6QHf1aKxy8In6JUt2qjr6qdTALlry5m60pDo3+U3
         hqXdYWLrqHem+E1vnlIuFo+ySuX5fPGqvF0Yw63EhF38QzJfMADaIrfeeBF89jTLHWv3
         5Lq/De/sPtmNmcl6HmgBjXUFTFrAeqadMyC6xyzlyPPoemrkEd/X7P3wPshiZqz9PKFm
         7Hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbwPLiliA6qVCCVy57H0oUR5ejruLx9vHLLWXjfA44k=;
        b=mZ/TwyUJ7wUl4JFRQPJDjZf32qeOHArfnhzea0BFlVdyVGOOWw9m/SHh/jFLxqmjlm
         E918yoyWISbIZXy/AlUj3hyWAhBazam9hCPJJU5YEB2LC/3m76e9VWOzt2sWftk3qbY7
         p1X8zCkOIxVIucimZ3GB7/nIrT1KUHsJqhcmwJyNc6P51/Ui0YoJZZGotjBwrcy8W6jo
         fYq8HiArjT9HRcDb6U+TJoBh20l4aq2zJ4Z8gll5cQTA1foJWvxlU/TUryCFPhC6UN6T
         i8N+bkHrgThFySZYnKZ0ul89GS86Bca4sRJR9fisU2zZLsV/l5s+4mE6g68VQSlEXddT
         M2Kg==
X-Gm-Message-State: ACrzQf1L+iLr6EvNg3AzUsOdLNqQe1UK+aMFicJAJ7gv0EsUWONLmdYH
        hByQuwQejY6aeLGPJm1/2zs=
X-Google-Smtp-Source: AMsMyM7tfgmqGyaO/4M7ZOOWiOhu1G8AEc3bygFzpX8AfPEqBDN535bk6oI8cNAFGzjixqFgjbWvlw==
X-Received: by 2002:a17:906:eecb:b0:73c:5bcb:8eb3 with SMTP id wu11-20020a170906eecb00b0073c5bcb8eb3mr59982814ejb.284.1668071374841;
        Thu, 10 Nov 2022 01:09:34 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id m19-20020a056402051300b00459cd13fd34sm8020462edv.85.2022.11.10.01.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 01:09:34 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: rename three functions
Date:   Thu, 10 Nov 2022 10:09:27 +0100
Message-Id: <20221110090927.17274-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Prefix the names of the following functions with the driver name. The
original names are bad for the global namespace. While at it, convert
is_IBSS_empty() to all lower case to follow kernel coding style.

is_client_associated_to_ap()
is_client_associated_to_ibss()
is_IBSS_empty()

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 14 +++++++-------
 drivers/staging/r8188eu/core/rtw_wlan_util.c   |  8 ++++----
 drivers/staging/r8188eu/include/rtw_mlme_ext.h |  6 +++---
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index be33489d3dfd..161cb67f7882 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5831,7 +5831,7 @@ void rtw_mlme_site_survey_done(struct adapter *adapter)
 	int res;
 	u8 reg;
 
-	if ((is_client_associated_to_ap(adapter)) ||
+	if ((r8188eu_is_client_associated_to_ap(adapter)) ||
 	    ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE)) {
 		/* enable to rx data frame */
 		rtw_write16(adapter, REG_RXFLTMAP2, 0xFFFF);
@@ -5982,7 +5982,7 @@ void site_survey(struct adapter *padapter)
 			Restore_DM_Func_Flag(padapter);
 			/* Switch_DM_Func(padapter, DYNAMIC_ALL_FUNC_ENABLE, true); */
 
-			if (is_client_associated_to_ap(padapter))
+			if (r8188eu_is_client_associated_to_ap(padapter))
 				issue_nulldata(padapter, NULL, 0, 3, 500);
 
 			rtw_mlme_site_survey_done(padapter);
@@ -6952,7 +6952,7 @@ void mlmeext_sta_del_event_callback(struct adapter *padapter)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
-	if (is_client_associated_to_ap(padapter) || is_IBSS_empty(padapter)) {
+	if (r8188eu_is_client_associated_to_ap(padapter) || r8188eu_is_ibss_empty(padapter)) {
 		mlme_disconnect(padapter);
 		rtw_set_bssid(padapter, null_addr);
 
@@ -7025,7 +7025,7 @@ void linked_status_chk(struct adapter *padapter)
 
 	rtl8188e_sreset_linked_status_check(padapter);
 
-	if (is_client_associated_to_ap(padapter)) {
+	if (r8188eu_is_client_associated_to_ap(padapter)) {
 		/* linked infrastructure client mode */
 
 		int tx_chk = _SUCCESS, rx_chk = _SUCCESS;
@@ -7097,7 +7097,7 @@ void linked_status_chk(struct adapter *padapter)
 				pmlmeinfo->link_count = 0;
 			}
 		} /* end of if ((psta = rtw_get_stainfo(pstapriv, passoc_res->network.MacAddress)) != NULL) */
-	} else if (is_client_associated_to_ibss(padapter)) {
+	} else if (r8188eu_is_client_associated_to_ibss(padapter)) {
 		/* linked IBSS mode */
 		/* for each assoc list entry to check the rx pkt counter */
 		for (i = IBSS_START_MAC_ID; i < NUM_STA; i++) {
@@ -7415,7 +7415,7 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 	u8 val8;
 	int res;
 
-	if (is_client_associated_to_ap(padapter))
+	if (r8188eu_is_client_associated_to_ap(padapter))
 		issue_deauth_ex(padapter, pnetwork->MacAddress, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms / 100, 100);
 
 	mlme_disconnect(padapter);
@@ -7527,7 +7527,7 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 		pmlmeext->sitesurvey_res.scan_mode = pparm->scan_mode;
 
 		/* issue null data if associating to the AP */
-		if (is_client_associated_to_ap(padapter)) {
+		if (r8188eu_is_client_associated_to_ap(padapter)) {
 			pmlmeext->sitesurvey_res.state = SCAN_TXNULL;
 
 			issue_nulldata(padapter, NULL, 1, 3, 500);
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index c95438a12b59..965bb7da4cce 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -331,7 +331,7 @@ u16 get_beacon_interval(struct wlan_bssid_ex *bss)
 	return le16_to_cpu(val);
 }
 
-bool is_client_associated_to_ap(struct adapter *padapter)
+bool r8188eu_is_client_associated_to_ap(struct adapter *padapter)
 {
 	struct mlme_ext_priv	*pmlmeext;
 	struct mlme_ext_info	*pmlmeinfo;
@@ -348,7 +348,7 @@ bool is_client_associated_to_ap(struct adapter *padapter)
 	return false;
 }
 
-bool is_client_associated_to_ibss(struct adapter *padapter)
+bool r8188eu_is_client_associated_to_ibss(struct adapter *padapter)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
@@ -359,7 +359,7 @@ bool is_client_associated_to_ibss(struct adapter *padapter)
 	return false;
 }
 
-bool is_IBSS_empty(struct adapter *padapter)
+bool r8188eu_is_ibss_empty(struct adapter *padapter)
 {
 	unsigned int i;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
@@ -893,7 +893,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	unsigned short	ht_cap_info;
 	unsigned char	ht_info_infos_0;
 
-	if (!is_client_associated_to_ap(Adapter))
+	if (!r8188eu_is_client_associated_to_ap(Adapter))
 		return true;
 
 	len = packet_len - sizeof(struct ieee80211_hdr_3addr);
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 9c0af4704607..c46fc1a53085 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -431,9 +431,9 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 u8 *get_my_bssid(struct wlan_bssid_ex *pnetwork);
 u16 get_beacon_interval(struct wlan_bssid_ex *bss);
 
-bool is_client_associated_to_ap(struct adapter *padapter);
-bool is_client_associated_to_ibss(struct adapter *padapter);
-bool is_IBSS_empty(struct adapter *padapter);
+bool r8188eu_is_client_associated_to_ap(struct adapter *padapter);
+bool r8188eu_is_client_associated_to_ibss(struct adapter *padapter);
+bool r8188eu_is_ibss_empty(struct adapter *padapter);
 
 unsigned char check_assoc_AP(u8 *pframe, uint len);
 
-- 
2.38.1

