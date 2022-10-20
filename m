Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C36E606A55
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJTVbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJTVax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:30:53 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5C91EA553
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666301440; bh=kSz0GKYwtwvlodtOLhHDydQIyMIvnHNfquDPQLL9jV0=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=G7TjePXY3uBx8l6mJcMzkrDOXjxgCdxrab1XnJmR5maXrEhhJ2npTfW00pldqroTL
         U4Mz5zmIayH16GAVXqU8FLDpQbmQE2PLayl/1W8kbPkPL6QjjjRBrfWy2Xan3/RFuv
         VSqHNIJck+Rr7qwHCnXCzhjFcJ4iRTdmGxQr+hBU=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.206]
        Thu, 20 Oct 2022 23:30:40 +0200 (CEST)
X-EA-Auth: LK14eXzF3qDHiT2C4nFqFyv5YeLhLCwE1pg+UAFgO5CTEIgMa0wTayR1pzMKf1EdkbhkaORuGZ2wVzL7OtNzogZBvRSPk76q
Date:   Fri, 21 Oct 2022 03:00:35 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: [PATCH v4 07/11] staging: r8188eu: Associate pointer symbol with
 parameter name
Message-ID: <d946b69bfdfb44baae3a130e412ed2e217a710a7.1666299151.git.drv@mailo.com>
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

The pointer symbol '*' should be associated with the function parameter
name and not its type. This improves code readability and adheres to the
coding-style guidelines. Address following checkpatch reported error:
	ERROR: "foo *   bar" should be "foo *bar"

While in there, update parameter name at one place to match other function
declarations.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v4:
   -- None.

Changes in v3:
   1. Patch newly added to the patch set.



 drivers/staging/r8188eu/include/rtl8188e_hal.h  |  2 +-
 drivers/staging/r8188eu/include/rtw_cmd.h       | 16 ++++++++--------
 drivers/staging/r8188eu/include/rtw_ioctl_set.h |  4 ++--
 drivers/staging/r8188eu/include/rtw_mlme.h      |  2 +-
 drivers/staging/r8188eu/include/rtw_mlme_ext.h  |  8 ++++----
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 577cd3f4f797..ae33a0f8b5ce 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -167,7 +167,7 @@ void rtl8188e_EfuseParseChnlPlan(struct adapter *padapter, u8 *hwinfo,
 				 bool AutoLoadFail);
 void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter, u8 *PROMContent,
 				 bool AutoLoadFail);
-void Hal_ReadThermalMeter_88E(struct adapter *	dapter, u8 *PROMContent,
+void Hal_ReadThermalMeter_88E(struct adapter *padapter, u8 *PROMContent,
 			      bool AutoloadFail);
 void Hal_EfuseParseXtal_8188E(struct adapter *pAdapter, u8 *hwinfo,
 			      bool AutoLoadFail);
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 8495ce1719ac..61fb523afb08 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -734,25 +734,25 @@ u8 rtw_sitesurvey_cmd(struct adapter *padapter, struct ndis_802_11_ssid *ssid, i
 u8 rtw_createbss_cmd(struct adapter *padapter);
 u8 rtw_setstakey_cmd(struct adapter *padapter, u8 *psta, u8 unicast_key);
 u8 rtw_clearstakey_cmd(struct adapter *padapter, u8 *psta, u8 entry, u8 enqueue);
-u8 rtw_joinbss_cmd(struct adapter *padapter, struct wlan_network* pnetwork);
+u8 rtw_joinbss_cmd(struct adapter *padapter, struct wlan_network *pnetwork);
 u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueue);
 u8 rtw_setopmode_cmd(struct adapter *padapter, enum ndis_802_11_network_infra networktype);
 u8 rtw_setdatarate_cmd(struct adapter *padapter, u8 *rateset);
 u8 rtw_setrfintfs_cmd(struct adapter *padapter, u8 mode);

 u8 rtw_gettssi_cmd(struct adapter *padapter, u8 offset, u8 *pval);
-u8 rtw_setfwdig_cmd(struct adapter*padapter, u8 type);
-u8 rtw_setfwra_cmd(struct adapter*padapter, u8 type);
+u8 rtw_setfwdig_cmd(struct adapter *padapter, u8 type);
+u8 rtw_setfwra_cmd(struct adapter *padapter, u8 type);

-u8 rtw_addbareq_cmd(struct adapter*padapter, u8 tid, u8 *addr);
+u8 rtw_addbareq_cmd(struct adapter *padapter, u8 tid, u8 *addr);

 u8 rtw_dynamic_chk_wk_cmd(struct adapter *adapter);

-u8 rtw_lps_ctrl_wk_cmd(struct adapter*padapter, u8 lps_ctrl_type, u8 enqueue);
-u8 rtw_rpt_timer_cfg_cmd(struct adapter*padapter, u16 minRptTime);
+u8 rtw_lps_ctrl_wk_cmd(struct adapter *padapter, u8 lps_ctrl_type, u8 enqueue);
+u8 rtw_rpt_timer_cfg_cmd(struct adapter *padapter, u16 minRptTime);

-u8 rtw_antenna_select_cmd(struct adapter*padapter, u8 antenna, u8 enqueue);
-u8 rtw_ps_cmd(struct adapter*padapter);
+u8 rtw_antenna_select_cmd(struct adapter *padapter, u8 antenna, u8 enqueue);
+u8 rtw_ps_cmd(struct adapter *padapter);

 u8 rtw_chk_hi_queue_cmd(struct adapter *padapter);

diff --git a/drivers/staging/r8188eu/include/rtw_ioctl_set.h b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
index 7365079c704f..abe460d6504d 100644
--- a/drivers/staging/r8188eu/include/rtw_ioctl_set.h
+++ b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
@@ -10,10 +10,10 @@ typedef u8 NDIS_802_11_PMKID_VALUE[16];

 u8 rtw_set_802_11_authentication_mode(struct adapter *adapt,
 				      enum ndis_802_11_auth_mode authmode);
-u8 rtw_set_802_11_bssid(struct adapter*adapter, u8 *bssid);
+u8 rtw_set_802_11_bssid(struct adapter *adapter, u8 *bssid);
 u8 rtw_set_802_11_add_wep(struct adapter *adapter, struct ndis_802_11_wep *wep);
 u8 rtw_set_802_11_disassociate(struct adapter *adapter);
-u8 rtw_set_802_11_bssid_list_scan(struct adapter*adapter,
+u8 rtw_set_802_11_bssid_list_scan(struct adapter *adapter,
 				  struct ndis_802_11_ssid *pssid,
 				  int ssid_max_num);
 u8 rtw_set_802_11_infrastructure_mode(struct adapter *adapter,
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index b69989cbab21..7658f864136e 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -547,7 +547,7 @@ void _rtw_free_network(struct mlme_priv *pmlmepriv,
 void _rtw_free_network_nolock(struct mlme_priv *pmlmepriv,
 			      struct wlan_network *pnetwork);

-struct wlan_network* _rtw_find_network(struct __queue *scanned_queue, u8 *addr);
+struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr);

 void _rtw_free_network_queue(struct adapter *padapter, u8 isfreeall);

diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index b322d0848db9..be470f913a94 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -479,11 +479,11 @@ void report_survey_event(struct adapter *padapter, struct recv_frame *precv_fram
 void report_surveydone_event(struct adapter *padapter);
 void report_del_sta_event(struct adapter *padapter,
 			  unsigned char *addr, unsigned short reason);
-void report_add_sta_event(struct adapter *padapter, unsigned char* addr,
+void report_add_sta_event(struct adapter *padapter, unsigned char *addr,
 			  int cam_idx);

 void beacon_timing_control(struct adapter *padapter);
-extern u8 set_tx_beacon_cmd(struct adapter*padapter);
+extern u8 set_tx_beacon_cmd(struct adapter *padapter);
 unsigned int setup_beacon_frame(struct adapter *padapter,
 				unsigned char *beacon_frame);
 void update_mgnt_tx_rate(struct adapter *padapter, u8 rate);
@@ -502,7 +502,7 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr);
 void issue_probereq_p2p(struct adapter *padapter, u8 *da);
 void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr,
 				   u8 dialogToken, u8 success);
-void issue_p2p_invitation_request(struct adapter *padapter, u8* raddr);
+void issue_p2p_invitation_request(struct adapter *padapter, u8 *raddr);
 void issue_beacon(struct adapter *padapter, int timeout_ms);
 void issue_probersp(struct adapter *padapter, unsigned char *da,
 		    u8 is_valid_p2p_probereq);
@@ -514,7 +514,7 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta,
 void issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 		    u8 *da);
 s32 issue_probereq_ex(struct adapter *adapter, struct ndis_802_11_ssid *pssid,
-		      u8* da, int try_cnt, int wait_ms);
+		      u8 *da, int try_cnt, int wait_ms);
 int issue_nulldata(struct adapter *padapter, unsigned char *da,
 		   unsigned int power_mode, int try_cnt, int wait_ms);
 int issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
--
2.30.2



