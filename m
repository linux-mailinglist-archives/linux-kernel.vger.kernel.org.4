Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3732360592C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiJTH6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJTH6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:58:50 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB024175342
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666252719; bh=SqZuFyjJC7di7e2XPERExNiYOgjV7EsBBdk+AwWNaE8=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=MQIABmT5paoM3pID3TAUNR8C1frey0uTf1F3MOjm31C9UbxIhW2IcgdR67L6XlhAb
         Wb782TNhsTc+Sf376HNOFdBUJ8kRaPYyDz6ZuP3+So1yf5yyIlwE1KhRIUQBEt9BYU
         iFKfj8sA1WUYhrn4fkE/E1FGuI0zu1KG/uQMKBRI=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.206]
        Thu, 20 Oct 2022 09:58:39 +0200 (CEST)
X-EA-Auth: 3PYDFahn/RJ75ztIUT7XmWzhQm04A/pBHpBUbh3kO4yyEX5Y6hUPcMrgcvr9k1a0xAIkPSDmd6Fz/Nbwbe2tSxGR5Aaq8mfo
Date:   Thu, 20 Oct 2022 13:28:34 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: [PATCH v3 08/10] staging: r8188eu: replace leading spaces by tabs
Message-ID: <a350fdf9e3017d1f0ecc7b33f11af31985107ad3.1666249716.git.drv@mailo.com>
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

Spaces are prohibited as per the Linux coding style guidelines. Replace
those by tabs wherever possible to improve code alignment. Error
reported by checkpatch script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v3:
   1. Patch newly added in the patch set.


 drivers/staging/r8188eu/include/rtw_cmd.h      | 10 +++++-----
 drivers/staging/r8188eu/include/rtw_mlme.h     |  2 +-
 drivers/staging/r8188eu/include/rtw_mlme_ext.h |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index ff6ed4f2a1d8..d8e6bdb1cf45 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -592,14 +592,14 @@ struct setratable_parm {
 };

 struct getratable_parm {
-                uint rsvd;
+	uint rsvd;
 };

 struct getratable_rsp {
-        u8 ss_ForceUp[NumRates];
-        u8 ss_ULevel[NumRates];
-        u8 ss_DLevel[NumRates];
-        u8 count_judge[NumRates];
+	u8 ss_ForceUp[NumRates];
+	u8 ss_ULevel[NumRates];
+	u8 ss_DLevel[NumRates];
+	u8 count_judge[NumRates];
 };

 /* to get TX,RX retry count */
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 7658f864136e..ebf7168a7ef9 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -528,7 +528,7 @@ void rtw_indicate_scan_done(struct adapter *padapter);
 int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie,
 			uint in_len);
 int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie,
-		        uint in_len, uint initial_out_len);
+			uint in_len, uint initial_out_len);
 void rtw_init_registrypriv_dev_network(struct adapter *adapter);

 void rtw_update_registrypriv_dev_network(struct adapter *adapter);
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index be470f913a94..413b94e38744 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -449,7 +449,7 @@ void ERP_IE_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE);
 void VCS_update(struct adapter *padapter, struct sta_info *psta);

 void update_beacon_info(struct adapter *padapter, u8 *pframe, uint len,
-		        struct sta_info *psta);
+			struct sta_info *psta);
 int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len);
 void update_IOT_info(struct adapter *padapter);
 void update_capinfo(struct adapter *adapter, u16 updatecap);
--
2.30.2



