Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAED664E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjAJVl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjAJVlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:41:44 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FFE392C6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673386889; bh=6nop0OBRob5Z/iRPg9Z11D2mpsio5bT53ye1lNuCTMA=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=Kry3PLtBqQq7pCJENXSkf3/z+qjQZfdx4S90qzOEJLRSNewlI0yBXjCzxH+tjvZjr
         SGs7BM6s0OXd5RPi2WQus7aREwbvcyl89Dt+YNyxucfyyWiKUY2+hU93fc4SdORjo0
         o08JPe5zCO6kP4+6hj8BbXVJeMSclipawKJRl0Sk=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 10 Jan 2023 22:41:29 +0100 (CET)
X-EA-Auth: knPYGnacJT0lXIppOOUrbjh7wpqS0rH5RVuWRIAqscHyipc0nXTrwwLkyUDbltSIbFUlZVR4cHWiNX0Rr5ZdGH179UidTJft
Date:   Wed, 11 Jan 2023 03:11:24 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH] staging: wlan-ng: Remove unused code
Message-ID: <Y73bhE1VwQ5IfFyt@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several structs are defined but never used. Remove such dead code.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Note: Change compile tested only.

 drivers/staging/wlan-ng/hfa384x.h | 171 ------------------------------
 1 file changed, 171 deletions(-)

diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
index 0611e37df6ac..e33dd1b9c40e 100644
--- a/drivers/staging/wlan-ng/hfa384x.h
+++ b/drivers/staging/wlan-ng/hfa384x.h
@@ -904,40 +904,6 @@ union hfa384x_usbin {
  *--------------------------------------------------------------------
  */
 
-struct hfa384x_pdr_pcb_partnum {
-	u8 num[8];
-} __packed;
-
-struct hfa384x_pdr_pcb_tracenum {
-	u8 num[8];
-} __packed;
-
-struct hfa384x_pdr_nic_serial {
-	u8 num[12];
-} __packed;
-
-struct hfa384x_pdr_mkk_measurements {
-	double carrier_freq;
-	double occupied_band;
-	double power_density;
-	double tx_spur_f1;
-	double tx_spur_f2;
-	double tx_spur_f3;
-	double tx_spur_f4;
-	double tx_spur_l1;
-	double tx_spur_l2;
-	double tx_spur_l3;
-	double tx_spur_l4;
-	double rx_spur_f1;
-	double rx_spur_f2;
-	double rx_spur_l1;
-	double rx_spur_l2;
-} __packed;
-
-struct hfa384x_pdr_nic_ramsize {
-	u8 size[12];		/* units of KB */
-} __packed;
-
 struct hfa384x_pdr_mfisuprange {
 	u16 id;
 	u16 variant;
@@ -959,150 +925,13 @@ struct hfa384x_pdr_nicid {
 	u16 minor;
 } __packed;
 
-struct hfa384x_pdr_refdac_measurements {
-	u16 value[0];
-} __packed;
-
-struct hfa384x_pdr_vgdac_measurements {
-	u16 value[0];
-} __packed;
-
-struct hfa384x_pdr_level_comp_measurements {
-	u16 value[0];
-} __packed;
-
-struct hfa384x_pdr_mac_address {
-	u8 addr[6];
-} __packed;
-
-struct hfa384x_pdr_mkk_callname {
-	u8 callname[8];
-} __packed;
-
-struct hfa384x_pdr_regdomain {
-	u16 numdomains;
-	u16 domain[5];
-} __packed;
-
-struct hfa384x_pdr_allowed_channel {
-	u16 ch_bitmap;
-} __packed;
-
-struct hfa384x_pdr_default_channel {
-	u16 channel;
-} __packed;
-
-struct hfa384x_pdr_privacy_option {
-	u16 available;
-} __packed;
-
-struct hfa384x_pdr_temptype {
-	u16 type;
-} __packed;
-
-struct hfa384x_pdr_refdac_setup {
-	u16 ch_value[14];
-} __packed;
-
-struct hfa384x_pdr_vgdac_setup {
-	u16 ch_value[14];
-} __packed;
-
-struct hfa384x_pdr_level_comp_setup {
-	u16 ch_value[14];
-} __packed;
-
-struct hfa384x_pdr_trimdac_setup {
-	u16 trimidac;
-	u16 trimqdac;
-} __packed;
-
-struct hfa384x_pdr_ifr_setting {
-	u16 value[3];
-} __packed;
-
-struct hfa384x_pdr_rfr_setting {
-	u16 value[3];
-} __packed;
-
-struct hfa384x_pdr_hfa3861_baseline {
-	u16 value[50];
-} __packed;
-
-struct hfa384x_pdr_hfa3861_shadow {
-	u32 value[32];
-} __packed;
-
-struct hfa384x_pdr_hfa3861_ifrf {
-	u32 value[20];
-} __packed;
-
-struct hfa384x_pdr_hfa3861_chcalsp {
-	u16 value[14];
-} __packed;
-
-struct hfa384x_pdr_hfa3861_chcali {
-	u16 value[17];
-} __packed;
-
-struct hfa384x_pdr_hfa3861_nic_config {
-	u16 config_bitmap;
-} __packed;
-
-struct hfa384x_pdr_hfo_delay {
-	u8 hfo_delay;
-} __packed;
-
-struct hfa384x_pdr_hfa3861_manf_testsp {
-	u16 value[30];
-} __packed;
-
-struct hfa384x_pdr_hfa3861_manf_testi {
-	u16 value[30];
-} __packed;
-
-struct hfa384x_pdr_end_of_pda {
-	u16 crc;
-} __packed;
-
 struct hfa384x_pdrec {
 	__le16 len;		/* in words */
 	__le16 code;
 	union pdr {
-		struct hfa384x_pdr_pcb_partnum pcb_partnum;
-		struct hfa384x_pdr_pcb_tracenum pcb_tracenum;
-		struct hfa384x_pdr_nic_serial nic_serial;
-		struct hfa384x_pdr_mkk_measurements mkk_measurements;
-		struct hfa384x_pdr_nic_ramsize nic_ramsize;
 		struct hfa384x_pdr_mfisuprange mfisuprange;
 		struct hfa384x_pdr_cfisuprange cfisuprange;
 		struct hfa384x_pdr_nicid nicid;
-		struct hfa384x_pdr_refdac_measurements refdac_measurements;
-		struct hfa384x_pdr_vgdac_measurements vgdac_measurements;
-		struct hfa384x_pdr_level_comp_measurements level_compc_measurements;
-		struct hfa384x_pdr_mac_address mac_address;
-		struct hfa384x_pdr_mkk_callname mkk_callname;
-		struct hfa384x_pdr_regdomain regdomain;
-		struct hfa384x_pdr_allowed_channel allowed_channel;
-		struct hfa384x_pdr_default_channel default_channel;
-		struct hfa384x_pdr_privacy_option privacy_option;
-		struct hfa384x_pdr_temptype temptype;
-		struct hfa384x_pdr_refdac_setup refdac_setup;
-		struct hfa384x_pdr_vgdac_setup vgdac_setup;
-		struct hfa384x_pdr_level_comp_setup level_comp_setup;
-		struct hfa384x_pdr_trimdac_setup trimdac_setup;
-		struct hfa384x_pdr_ifr_setting ifr_setting;
-		struct hfa384x_pdr_rfr_setting rfr_setting;
-		struct hfa384x_pdr_hfa3861_baseline hfa3861_baseline;
-		struct hfa384x_pdr_hfa3861_shadow hfa3861_shadow;
-		struct hfa384x_pdr_hfa3861_ifrf hfa3861_ifrf;
-		struct hfa384x_pdr_hfa3861_chcalsp hfa3861_chcalsp;
-		struct hfa384x_pdr_hfa3861_chcali hfa3861_chcali;
-		struct hfa384x_pdr_hfa3861_nic_config nic_config;
-		struct hfa384x_pdr_hfo_delay hfo_delay;
-		struct hfa384x_pdr_hfa3861_manf_testsp hfa3861_manf_testsp;
-		struct hfa384x_pdr_hfa3861_manf_testi hfa3861_manf_testi;
-		struct hfa384x_pdr_end_of_pda end_of_pda;
 
 	} data;
 } __packed;
-- 
2.34.1



