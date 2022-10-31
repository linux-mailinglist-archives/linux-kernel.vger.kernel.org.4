Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94837613CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiJaR4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiJaR4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:56:16 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297FD12AE6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667238968; bh=aOtt4C+rUZiN07CbINVnZCOezF5iwOq3whPuF7n+d/k=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=gtbneUnhfA+lN3vZB0SRzsDMD9rVk4JkqJTZzCgm9zZayMfq+YYFe/JaTpWKXHRbo
         krfQpWupvMPDHGdOfy2ZqoYeFfbKmHMT0nXWGF5xPiHkL+OkLKAlNC1aykMwFRx8X7
         NvD0Z1JaC03m5MeIr0TeOjqWO7YM7N52TjzJixU8=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.206]
        Mon, 31 Oct 2022 18:56:07 +0100 (CET)
X-EA-Auth: j/FgF5M8s+oz1krS6oB+hT1Y1Zz4ICDzarTe/XqJODSEsIIhQP+pN7ujH5XcAfZOWu/8rMUdAgrjl1nJ9GVCyrzcY+Sm6tTJ
Date:   Mon, 31 Oct 2022 23:26:09 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] staging: rtl8192u: remove redundant macro definition
Message-ID: <3908a0694102793f3130ba1202f1a3580aa9e187.1667237959.git.drv@mailo.com>
References: <cover.1667237959.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667237959.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several ieee80211_* symbol names are extended with _rsl tag using
macros. This is done to avoid a conflict when a similar symbol is
already in use in another part of kernel and may lead to conflicts.
However, most of these base symbol names are not found to being used
anywhere in the code and hence are not useful today. These symbols
are not used outside of the module and hence can be safely removed.
The code continues to use the original symbol names.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v2:
   1. Review other similar macro defines and clean those up as well.
      Suggested by gregkh@linuxfoundation.org
   2. Revise patch log to explain impact of the patch
      Suggested by julia.lawall@inria.fr


 .../staging/rtl8192u/ieee80211/ieee80211.h    | 64 -------------------
 1 file changed, 64 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 00c07455cbb3..a92f847f2394 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -223,72 +223,8 @@ struct cb_desc {
 #define MAX_IE_LEN  0xff

 // added for kernel conflict
-#define ieee80211_crypt_deinit_entries	ieee80211_crypt_deinit_entries_rsl
-#define ieee80211_crypt_deinit_handler	ieee80211_crypt_deinit_handler_rsl
-#define ieee80211_crypt_delayed_deinit	ieee80211_crypt_delayed_deinit_rsl
-#define ieee80211_register_crypto_ops	ieee80211_register_crypto_ops_rsl
-#define ieee80211_unregister_crypto_ops ieee80211_unregister_crypto_ops_rsl
-#define ieee80211_get_crypto_ops	ieee80211_get_crypto_ops_rsl
-
-#define ieee80211_ccmp_null		ieee80211_ccmp_null_rsl
-
-#define free_ieee80211			free_ieee80211_rsl
-#define alloc_ieee80211			alloc_ieee80211_rsl
-
-#define ieee80211_rx			ieee80211_rx_rsl
-#define ieee80211_rx_mgt		ieee80211_rx_mgt_rsl
-
-#define ieee80211_get_beacon		ieee80211_get_beacon_rsl
-#define ieee80211_wake_queue		ieee80211_wake_queue_rsl
-#define ieee80211_stop_queue		ieee80211_stop_queue_rsl
-#define ieee80211_reset_queue		ieee80211_reset_queue_rsl
-#define ieee80211_softmac_stop_protocol	ieee80211_softmac_stop_protocol_rsl
-#define ieee80211_softmac_start_protocol ieee80211_softmac_start_protocol_rsl
-#define ieee80211_is_shortslot		ieee80211_is_shortslot_rsl
-#define ieee80211_is_54g		ieee80211_is_54g_rsl
-#define ieee80211_wpa_supplicant_ioctl	ieee80211_wpa_supplicant_ioctl_rsl
-#define ieee80211_ps_tx_ack		ieee80211_ps_tx_ack_rsl
-#define ieee80211_softmac_xmit		ieee80211_softmac_xmit_rsl
-#define ieee80211_stop_send_beacons	ieee80211_stop_send_beacons_rsl
 #define notify_wx_assoc_event		notify_wx_assoc_event_rsl
 #define SendDisassociation		SendDisassociation_rsl
-#define ieee80211_disassociate		ieee80211_disassociate_rsl
-#define ieee80211_start_send_beacons	ieee80211_start_send_beacons_rsl
-#define ieee80211_stop_scan		ieee80211_stop_scan_rsl
-#define ieee80211_send_probe_requests	ieee80211_send_probe_requests_rsl
-#define ieee80211_softmac_scan_syncro	ieee80211_softmac_scan_syncro_rsl
-#define ieee80211_start_scan_syncro	ieee80211_start_scan_syncro_rsl
-
-#define ieee80211_wx_get_essid		ieee80211_wx_get_essid_rsl
-#define ieee80211_wx_set_essid		ieee80211_wx_set_essid_rsl
-#define ieee80211_wx_set_rate		ieee80211_wx_set_rate_rsl
-#define ieee80211_wx_get_rate		ieee80211_wx_get_rate_rsl
-#define ieee80211_wx_set_wap		ieee80211_wx_set_wap_rsl
-#define ieee80211_wx_get_wap		ieee80211_wx_get_wap_rsl
-#define ieee80211_wx_set_mode		ieee80211_wx_set_mode_rsl
-#define ieee80211_wx_get_mode		ieee80211_wx_get_mode_rsl
-#define ieee80211_wx_set_scan		ieee80211_wx_set_scan_rsl
-#define ieee80211_wx_get_freq		ieee80211_wx_get_freq_rsl
-#define ieee80211_wx_set_freq		ieee80211_wx_set_freq_rsl
-#define ieee80211_wx_set_rawtx		ieee80211_wx_set_rawtx_rsl
-#define ieee80211_wx_get_name		ieee80211_wx_get_name_rsl
-#define ieee80211_wx_set_power		ieee80211_wx_set_power_rsl
-#define ieee80211_wx_get_power		ieee80211_wx_get_power_rsl
-#define ieee80211_wlan_frequencies	ieee80211_wlan_frequencies_rsl
-#define ieee80211_wx_set_rts		ieee80211_wx_set_rts_rsl
-#define ieee80211_wx_get_rts		ieee80211_wx_get_rts_rsl
-
-#define ieee80211_txb_free		ieee80211_txb_free_rsl
-
-#define ieee80211_wx_set_gen_ie		ieee80211_wx_set_gen_ie_rsl
-#define ieee80211_wx_get_scan		ieee80211_wx_get_scan_rsl
-#define ieee80211_wx_set_encode		ieee80211_wx_set_encode_rsl
-#define ieee80211_wx_get_encode		ieee80211_wx_get_encode_rsl
-#define ieee80211_wx_set_mlme		ieee80211_wx_set_mlme_rsl
-#define ieee80211_wx_set_auth		ieee80211_wx_set_auth_rsl
-#define ieee80211_wx_set_encode_ext	ieee80211_wx_set_encode_ext_rsl
-#define ieee80211_wx_get_encode_ext	ieee80211_wx_get_encode_ext_rsl
-

 struct ieee_param {
 	u32 cmd;
--
2.30.2



