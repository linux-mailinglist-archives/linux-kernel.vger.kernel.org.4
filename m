Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142F2605939
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJTIAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJTIAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:00:24 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B08F7B79C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666252803; bh=KZogcX23PzzPa1tx6zdFOcH2ZnPUvNt/ThaGDD/8Dyw=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=mHjOBXz/STV3tvgxgwPcCdLl2UdXNDPSBwRY5qHlveCvq+lAp7cUfq4B7wLjBzk96
         A6EZx8FLSNoCV47Men1RL1MIfB17EAXJBYoRbZVevam4ZyS7mTfwvJSp4hG+JeZ+A0
         oS6DR2F4eCEL7QeA/WTQEy7k8RGmMhblpKlARHXs=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.206]
        Thu, 20 Oct 2022 10:00:03 +0200 (CEST)
X-EA-Auth: kEbeVOkRIzsClWki16rMN3tDT4Gwd8JyyJxmSCJmHoIL/4lrk7GZcHTzqeVzNQ6YO3R6GGG/FpmuFiBFvoOGmDY6OomUcqP7
Date:   Thu, 20 Oct 2022 13:29:58 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: [PATCH v3 10/10] staging: r8188eu: Correct missing or extra space in
 the statements
Message-ID: <f400fa71f29ffb3a684ce415a054fc1fc9efe7c0.1666249716.git.drv@mailo.com>
References: <cover.1666249715.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666249715.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly spacing out code statements/instructions improves code
readability. Add missing or remove extra space as necessary according
to the Linux Kernel coding-style guidelines. Following errors reported
by checkpatch script for inconsistent code spacing:
	ERROR: space prohibited before that close parenthesis ')'
	ERROR: space prohibited before that ',' (ctx:WxW)
	CHECK: spaces preferred around that '&' (ctx:VxV)

Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v3:
   1. Patch newly added to the patch set.



 .../staging/r8188eu/include/rtl8188e_spec.h    | 12 ++++++------
 drivers/staging/r8188eu/include/rtw_mlme.h     | 18 +++++++++---------
 drivers/staging/r8188eu/include/rtw_mlme_ext.h |  2 +-
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
index e34ecdc09688..3fa3b3e5dd64 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -900,12 +900,12 @@ Current IOREG MAP
 #define HQSEL_HIQ			BIT(5)

 /*  For normal driver, 0x10C */
-#define _TXDMA_HIQ_MAP(x)		(((x)&0x3) << 14)
-#define _TXDMA_MGQ_MAP(x)		(((x)&0x3) << 12)
-#define _TXDMA_BKQ_MAP(x)		(((x)&0x3) << 10)
-#define _TXDMA_BEQ_MAP(x)		(((x)&0x3) << 8 )
-#define _TXDMA_VIQ_MAP(x)		(((x)&0x3) << 6 )
-#define _TXDMA_VOQ_MAP(x)		(((x)&0x3) << 4 )
+#define _TXDMA_HIQ_MAP(x)		(((x) & 0x3) << 14)
+#define _TXDMA_MGQ_MAP(x)		(((x) & 0x3) << 12)
+#define _TXDMA_BKQ_MAP(x)		(((x) & 0x3) << 10)
+#define _TXDMA_BEQ_MAP(x)		(((x) & 0x3) << 8)
+#define _TXDMA_VIQ_MAP(x)		(((x) & 0x3) << 6)
+#define _TXDMA_VOQ_MAP(x)		(((x) & 0x3) << 4)

 #define QUEUE_LOW			1
 #define QUEUE_NORMAL			2
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index ebf7168a7ef9..ca539c652f26 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -101,17 +101,17 @@ struct rt_link_detect {

 struct profile_info {
 	u8	ssidlen;
-	u8	ssid[ WLAN_SSID_MAXLEN ];
-	u8	peermac[ ETH_ALEN ];
+	u8	ssid[WLAN_SSID_MAXLEN];
+	u8	peermac[ETH_ALEN];
 };

 struct tx_invite_req_info {
 	u8	token;
 	u8	benable;
-	u8	go_ssid[ WLAN_SSID_MAXLEN ];
+	u8	go_ssid[WLAN_SSID_MAXLEN];
 	u8	ssidlen;
-	u8	go_bssid[ ETH_ALEN ];
-	u8	peer_macaddr[ ETH_ALEN ];
+	u8	go_bssid[ETH_ALEN];
+	u8	peer_macaddr[ETH_ALEN];
 	u8	operating_ch;	/* This information will be set by using the
 				 * p2p_set op_ch=x */
 	u8	peer_ch;	/* The listen channel for peer P2P device */
@@ -154,9 +154,9 @@ struct tx_nego_req_info {
 };

 struct group_id_info {
-	u8	go_device_addr[ ETH_ALEN ];	/* The GO's device address of
+	u8	go_device_addr[ETH_ALEN];	/* The GO's device address of
 						 * this P2P group */
-	u8	ssid[ WLAN_SSID_MAXLEN ];	/* The SSID of this P2P group */
+	u8	ssid[WLAN_SSID_MAXLEN];	/* The SSID of this P2P group */
 };

 struct scan_limit_info {
@@ -459,7 +459,7 @@ static inline void set_fwstate(struct mlme_priv *pmlmepriv, int state)
 {
 	pmlmepriv->fw_state |= state;
 	/* FOR HW integration */
-	if (_FW_UNDER_SURVEY==state)
+	if (_FW_UNDER_SURVEY == state)
 		pmlmepriv->bScanInProcess = true;
 }

@@ -467,7 +467,7 @@ static inline void _clr_fwstate_(struct mlme_priv *pmlmepriv, int state)
 {
 	pmlmepriv->fw_state &= ~state;
 	/* FOR HW integration */
-	if (_FW_UNDER_SURVEY==state)
+	if (_FW_UNDER_SURVEY == state)
 		pmlmepriv->bScanInProcess = false;
 }

diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 413b94e38744..66aa8b497aa1 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -729,7 +729,7 @@ enum rtw_c2h_event {
 	GEN_EVT_CODE(_Survey),	 /*8*/
 	GEN_EVT_CODE(_SurveyDone),	 /*9*/

-	GEN_EVT_CODE(_JoinBss) , /*10*/
+	GEN_EVT_CODE(_JoinBss), /*10*/
 	GEN_EVT_CODE(_AddSTA),
 	GEN_EVT_CODE(_DelSTA),
 	GEN_EVT_CODE(_AtimDone),
--
2.30.2



