Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345A160BE85
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJXX0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiJXX02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:26:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0361A20B7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:47:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h14so9097603pjv.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n5jAN6aAU3RzLlMd12ST0udCOc22IuWhKNJXj46agJg=;
        b=StPg4UH1wObvG+qyHgVe7O3a3/9bnpjvO+2kQfPfZnjeV5KACE3CuPVB/Xzsgwu9m1
         v5njRZuaW2iltnSGgNy8Ocke8BJROi1J/gL+EIhuiAYtCpTYjRnpSZmSebM0BOdz25Iy
         B9lPTLXeDctVWpV1teqa7WFV7u8Xxv0Kptd/LyDz6haB1aPuc9kWBPRx5QJy38X238mN
         rJSujovihqxRfp2Od56zKFwngzB/8fOFKZGARjgPohQwHCF8sy1+UTsFKRmQfFVSENzZ
         92wL21ddob8I2wLQ0V0f9mdOzDRovIdGbydoBJcWvhEQ7Qhx9/TzKITLJtkwTfzz1a9A
         iWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5jAN6aAU3RzLlMd12ST0udCOc22IuWhKNJXj46agJg=;
        b=whWG0zat31nLufZUHglbzQffAkI5TB4EGU4G0VaK9La72fmqCu71ILoDvWD0VBeEIx
         E/+qXk9+iJR8Gvc5N2f6cfKQfKnXmA/FfwwEakfYfD06FD+/8M8WNTmp6mT7tp2LoE9d
         xsNhEfYUgbWBSkDw2ybwkUaw4XXFFD+aQ9bfqPK5ishE7gW3JlJkh0JrTTYbxNyEMiZE
         R0JnuF+6/ZKMKFKIXZXusChJ4Rkk5VyxOqX0TX088w1wQzPMjjh9nO/PBhA/yIxPRNe0
         cXy+rso5KdSSp60q99/fGEq3mpI2dSH04zJT/gAqGvL4/pxGipYceBr4Edk3jSpAzS8l
         Jbsg==
X-Gm-Message-State: ACrzQf2Q9PYmbFTu0XCImebdth2ERCCa9bmS5EV88k4n+P1zE4sT2O2Y
        yXA2mzu93Qc4hB01NGw/a4s=
X-Google-Smtp-Source: AMsMyM7x8BFQOC1jBaroOKc2EA0AIm4qqSqyuU2JYYjuFcF7j+yKUFlakBBLlbitrQjlG2J5lU52SA==
X-Received: by 2002:a17:90a:4888:b0:203:6d42:ccae with SMTP id b8-20020a17090a488800b002036d42ccaemr41204641pjh.166.1666648048665;
        Mon, 24 Oct 2022 14:47:28 -0700 (PDT)
Received: from marshmallow (192-184-163-51.fiber.dynamic.sonic.net. [192.184.163.51])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b0017a04542a45sm171641plf.159.2022.10.24.14.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 14:47:28 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:47:25 -0700
From:   Emily Peri <eperi1024@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Fix indentation in conditional statements
Message-ID: <Y1cH7br3mMcT4Dm5@marshmallow>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove/add tabs in block statements in rtl8723bs/core to fix checkpatch
warnings for suspect code indent for conditionals.

Signed-off-by: Emily Peri <eperi1024@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 30 +++++++++----------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  2 +-
 drivers/staging/rtl8723bs/core/rtw_recv.c     |  6 ++--
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  |  2 +-
 4 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 6498fd17e1d3..c6fd6cf741ef 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -389,7 +389,7 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
 	__le16 tmps, tmpd;
 
 	if (rtw_bug_check(dst, src, &s_cap, &d_cap) == false)
-			return false;
+		return false;
 
 	memcpy((u8 *)&tmps, rtw_get_capability_from_ie(src->ies), 2);
 	memcpy((u8 *)&tmpd, rtw_get_capability_from_ie(dst->ies), 2);
@@ -669,7 +669,7 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 		uint ie_len = 0;
 
 		if ((desired_encmode == Ndis802_11EncryptionDisabled) && (privacy != 0))
-	    bselected = false;
+			bselected = false;
 
 		if (psecuritypriv->ndisauthtype == Ndis802_11AuthModeWPA2PSK) {
 			p = rtw_get_ie(pnetwork->network.ies + _BEACON_IE_OFFSET_, WLAN_EID_RSN, &ie_len, (pnetwork->network.ie_length - _BEACON_IE_OFFSET_));
@@ -795,7 +795,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			pmlmepriv->to_join = false;
 			s_ret = rtw_select_and_join_from_scanned_queue(pmlmepriv);
 			if (s_ret == _SUCCESS) {
-			     _set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
+				_set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
 			} else if (s_ret == 2) {/* there is no need to wait for join */
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 				rtw_indicate_connect(adapter);
@@ -2010,8 +2010,8 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 
 		if (in_ie[i] == 0xDD && in_ie[i+2] == 0x00 && in_ie[i+3] == 0x50  && in_ie[i+4] == 0xF2 && in_ie[i+5] == 0x02 && i+5 < in_len) { /* WMM element ID and OUI */
 			for (j = i; j < i + 9; j++) {
-					out_ie[ielength] = in_ie[j];
-					ielength++;
+				out_ie[ielength] = in_ie[j];
+				ielength++;
 			}
 			out_ie[initial_out_len + 1] = 0x07;
 			out_ie[initial_out_len + 6] = 0x00;
@@ -2064,15 +2064,13 @@ static int rtw_append_pmkid(struct adapter *Adapter, int iEntry, u8 *ie, uint ie
 
 	if (ie[13] <= 20) {
 		/*  The RSN IE didn't include the PMK ID, append the PMK information */
-			ie[ie_len] = 1;
-			ie_len++;
-			ie[ie_len] = 0;	/* PMKID count = 0x0100 */
-			ie_len++;
-			memcpy(&ie[ie_len], &psecuritypriv->PMKIDList[iEntry].PMKID, 16);
-
-			ie_len += 16;
-			ie[13] += 18;/* PMKID length = 2+16 */
-
+		ie[ie_len] = 1;
+		ie_len++;
+		ie[ie_len] = 0;	/* PMKID count = 0x0100 */
+		ie_len++;
+		memcpy(&ie[ie_len], &psecuritypriv->PMKIDList[iEntry].PMKID, 16);
+		ie_len += 16;
+		ie[13] += 18;/* PMKID length = 2+16 */
 	}
 	return ie_len;
 }
@@ -2091,9 +2089,9 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
 	memcpy(out_ie, in_ie, 12);
 	ielength = 12;
 	if ((ndisauthmode == Ndis802_11AuthModeWPA) || (ndisauthmode == Ndis802_11AuthModeWPAPSK))
-			authmode = WLAN_EID_VENDOR_SPECIFIC;
+		authmode = WLAN_EID_VENDOR_SPECIFIC;
 	if ((ndisauthmode == Ndis802_11AuthModeWPA2) || (ndisauthmode == Ndis802_11AuthModeWPA2PSK))
-			authmode = WLAN_EID_RSN;
+		authmode = WLAN_EID_RSN;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
 		memcpy(out_ie+ielength, psecuritypriv->wps_ie, psecuritypriv->wps_ie_len);
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 8e74b4f47b94..1148c9829890 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5447,7 +5447,7 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 	u8 val8;
 
 	if (is_client_associated_to_ap(padapter))
-			issue_deauth_ex(padapter, pnetwork->mac_address, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms/100, 100);
+		issue_deauth_ex(padapter, pnetwork->mac_address, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms/100, 100);
 
 	if (((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)) {
 		/* Stop BCN */
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 2825375bff94..7c7b6495965f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -161,7 +161,7 @@ int rtw_free_recvframe(union recv_frame *precvframe, struct __queue *pfree_recv_
 
 	if (padapter) {
 		if (pfree_recv_queue == &precvpriv->free_recv_queue)
-				precvpriv->free_recvframe_cnt++;
+			precvpriv->free_recvframe_cnt++;
 	}
 	spin_unlock_bh(&pfree_recv_queue->lock);
 	return _SUCCESS;
@@ -691,8 +691,8 @@ static signed int sta2sta_data_frame(struct adapter *adapter, union recv_frame *
 		if (bmcast) {
 			/*  For AP mode, if DA == MCAST, then BSSID should be also MCAST */
 			if (!IS_MCAST(pattrib->bssid)) {
-					ret = _FAIL;
-					goto exit;
+				ret = _FAIL;
+				goto exit;
 			}
 		} else { /*  not mc-frame */
 			/*  For AP mode, if DA is non-MCAST, then it must be BSSID, and bssid == BSSID */
diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index beb11d89db18..c7de81f21bec 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -551,7 +551,7 @@ u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr)
 	else if (pacl_list->mode == 2)/* deny unless in accept list */
 		res = match;
 	else
-		 res = true;
+		res = true;
 
 	return res;
 }
-- 
2.34.1

