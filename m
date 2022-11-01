Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03549614C15
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiKANu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiKANuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:50:51 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F72364CD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667310643; bh=USjeNcCx3bKCWp1/y/3F0YEXlmi+d+xrsqntzQAAIuE=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=ltyc73j5xfmEKOmB0bE/6N77T+aYVv2O2BJYHvKj/RX8v+rGpa6W2dxcjISjgPIg+
         rJH7N4/Trn8utK3XHYPqVUcqnyJfRXHHeKfwfERG4yn1bsu1yG3m4HJBweNHuuJQZm
         H0CdcL3Kx2hOjfd8X2q/YPhE+ELBXk//kB4TnNGo=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Tue,  1 Nov 2022 14:50:43 +0100 (CET)
X-EA-Auth: oXOBPTbXohD6WcpPQ6XB0vpq2jc20zZGMZstWPBGQ1ywl9oI5zOEJoNMBDVYHgNIY9Di6kzuuT9L0+eg/2IoEyioeYgxNjrP
Date:   Tue, 1 Nov 2022 19:20:40 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] staging: wlan-ng: Remove unused structure definitions
Message-ID: <74a79ea400ec26624e445692f3353424fb6fc29e.1667308828.git.drv@mailo.com>
References: <cover.1667308828.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667308828.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove structure definitions that are never used in the code.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Changes in v2:
   1. Patch included in patch set.
   2. The patch changes are compile tested only on X86 arch.


 drivers/staging/wlan-ng/p80211mgmt.h | 232 ---------------------------
 1 file changed, 232 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211mgmt.h b/drivers/staging/wlan-ng/p80211mgmt.h
index da824bc36365..fc23fae5651b 100644
--- a/drivers/staging/wlan-ng/p80211mgmt.h
+++ b/drivers/staging/wlan-ng/p80211mgmt.h
@@ -217,236 +217,4 @@
 #define WLAN_SET_MGMT_CAP_INFO_PBCC(n)		((n) << 6)
 #define WLAN_SET_MGMT_CAP_INFO_AGILITY(n)	((n) << 7)

-/*-- Information Element Types --------------------*/
-/* prototype structure, all IEs start with these members */
-
-struct wlan_ie {
-	u8 eid;
-	u8 len;
-} __packed;
-
-/*-- FH Parameter Set  ----------------------------*/
-struct wlan_ie_fh_parms {
-	u8 eid;
-	u8 len;
-	u16 dwell;
-	u8 hopset;
-	u8 hoppattern;
-	u8 hopindex;
-} __packed;
-
-/*-- DS Parameter Set  ----------------------------*/
-struct wlan_ie_ds_parms {
-	u8 eid;
-	u8 len;
-	u8 curr_ch;
-} __packed;
-
-/*-- CF Parameter Set  ----------------------------*/
-
-struct wlan_ie_cf_parms {
-	u8 eid;
-	u8 len;
-	u8 cfp_cnt;
-	u8 cfp_period;
-	u16 cfp_maxdur;
-	u16 cfp_durremaining;
-} __packed;
-
-/*-- Challenge Text  ------------------------------*/
-struct wlan_ie_challenge {
-	u8 eid;
-	u8 len;
-	u8 challenge[1];
-} __packed;
-
-/*-------------------------------------------------*/
-/*  Frame Types  */
-
-/* prototype structure, all mgmt frame types will start with these members */
-struct wlan_fr_mgmt {
-	u16 type;
-	u16 len;		/* DOES NOT include CRC !!!! */
-	u8 *buf;
-	struct p80211_hdr *hdr;
-	/* used for target specific data, skb in Linux */
-	void *priv;
-	/*-- fixed fields -----------*/
-	/*-- info elements ----------*/
-};
-
-/*-- Beacon ---------------------------------------*/
-struct wlan_fr_beacon {
-	u16 type;
-	u16 len;
-	u8 *buf;
-	struct p80211_hdr *hdr;
-	/* used for target specific data, skb in Linux */
-	void *priv;
-	/*-- fixed fields -----------*/
-	u64 *ts;
-	u16 *bcn_int;
-	u16 *cap_info;
-	/*-- info elements ----------*/
-	struct wlan_ie_fh_parms *fh_parms;
-	struct wlan_ie_ds_parms *ds_parms;
-	struct wlan_ie_cf_parms *cf_parms;
-};
-
-/*-- IBSS ATIM ------------------------------------*/
-struct wlan_fr_ibssatim {
-	u16 type;
-	u16 len;
-	u8 *buf;
-	struct p80211_hdr *hdr;
-	/* used for target specific data, skb in Linux */
-	void *priv;
-
-	/*-- fixed fields -----------*/
-	/*-- info elements ----------*/
-
-	/* this frame type has a null body */
-
-};
-
-/*-- Disassociation -------------------------------*/
-struct wlan_fr_disassoc {
-	u16 type;
-	u16 len;
-	u8 *buf;
-	struct p80211_hdr *hdr;
-	/* used for target specific data, skb in Linux */
-	void *priv;
-	/*-- fixed fields -----------*/
-	u16 *reason;
-
-	/*-- info elements ----------*/
-
-};
-
-/*-- Association Request --------------------------*/
-struct wlan_fr_assocreq {
-	u16 type;
-	u16 len;
-	u8 *buf;
-	struct p80211_hdr *hdr;
-	/* used for target specific data, skb in Linux */
-	void *priv;
-	/*-- fixed fields -----------*/
-	u16 *cap_info;
-	u16 *listen_int;
-	/*-- info elements ----------*/
-
-};
-
-/*-- Association Response -------------------------*/
-struct wlan_fr_assocresp {
-	u16 type;
-	u16 len;
-	u8 *buf;
-	struct p80211_hdr *hdr;
-	/* used for target specific data, skb in Linux */
-	void *priv;
-	/*-- fixed fields -----------*/
-	u16 *cap_info;
-	u16 *status;
-	u16 *aid;
-	/*-- info elements ----------*/
-
-};
-
-/*-- Reassociation Request ------------------------*/
-struct wlan_fr_reassocreq {
-	u16 type;
-	u16 len;
-	u8 *buf;
-	struct p80211_hdr *hdr;
-	/* used for target specific data, skb in Linux */
-	void *priv;
-	/*-- fixed fields -----------*/
-	u16 *cap_info;
-	u16 *listen_int;
-	u8 *curr_ap;
-	/*-- info elements ----------*/
-
-};
-
-/*-- Reassociation Response -----------------------*/
-struct wlan_fr_reassocresp {
-	u16 type;
-	u16 len;
-	u8 *buf;
-	struct p80211_hdr *hdr;
-	/* used for target specific data, skb in Linux */
-	void *priv;
-	/*-- fixed fields -----------*/
-	u16 *cap_info;
-	u16 *status;
-	u16 *aid;
-	/*-- info elements ----------*/
-
-};
-
-/*-- Probe Request --------------------------------*/
-struct wlan_fr_probereq {
-	u16 type;
-	u16 len;
-	u8 *buf;
-	struct p80211_hdr *hdr;
-	/* used for target specific data, skb in Linux */
-	void *priv;
-	/*-- fixed fields -----------*/
-	/*-- info elements ----------*/
-
-};
-
-/*-- Probe Response -------------------------------*/
-struct wlan_fr_proberesp {
-	u16 type;
-	u16 len;
-	u8 *buf;
-	struct p80211_hdr *hdr;
-	/* used for target specific data, skb in Linux */
-	void *priv;
-	/*-- fixed fields -----------*/
-	u64 *ts;
-	u16 *bcn_int;
-	u16 *cap_info;
-	/*-- info elements ----------*/
-	struct wlan_ie_fh_parms *fh_parms;
-	struct wlan_ie_ds_parms *ds_parms;
-	struct wlan_ie_cf_parms *cf_parms;
-};
-
-/*-- Authentication -------------------------------*/
-struct wlan_fr_authen {
-	u16 type;
-	u16 len;
-	u8 *buf;
-	struct p80211_hdr *hdr;
-	/* used for target specific data, skb in Linux */
-	void *priv;
-	/*-- fixed fields -----------*/
-	u16 *auth_alg;
-	u16 *auth_seq;
-	u16 *status;
-	/*-- info elements ----------*/
-	struct wlan_ie_challenge *challenge;
-
-};
-
-/*-- Deauthenication -----------------------------*/
-struct wlan_fr_deauthen {
-	u16 type;
-	u16 len;
-	u8 *buf;
-	struct p80211_hdr *hdr;
-	/* used for target specific data, skb in Linux */
-	void *priv;
-	/*-- fixed fields -----------*/
-	u16 *reason;
-
-	/*-- info elements ----------*/
-
-};
 #endif /* _P80211MGMT_H */
--
2.34.1



