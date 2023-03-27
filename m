Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65C76CABAF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjC0RRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjC0RRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:17:01 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6483581
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:16:58 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k2so9071983pll.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679937418;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c4jniGifalHk3jgCmWOViESTHRe1wKM9YHmb9m3c7Ds=;
        b=oUyDh+YV7AZ4MduYscsg4KrMX6ziIZmhVhxo+HUwPhIRIxjRDMM9shdvGXq5BX08iZ
         ZlxMSwIlA1wd2xMYj8bHLBDOGETMTSQZGdwPpki+UgYUHCkMHo5mVgSPlpZnci3fr38e
         fOn67MBn1zzcVTa7IIIErn5Q7cMZrs7WFRVmfpdFNDy4muUwNrf3q+Tkx+0JM65exOMl
         L0eyfgpXMq5u591T9BYmmowwNOhiL+dG2CoSeP3et4aRz3q02DZCin0nNS4o43mF10Vn
         K43ntmpHbunwnKGRsg7U/jG3aEthGKiQUh/7LprEaDpVFppMibBM2fHZ237eTO1YPJR8
         Zc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679937418;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4jniGifalHk3jgCmWOViESTHRe1wKM9YHmb9m3c7Ds=;
        b=zGvSLETUhmJfYj0COYULkd55vhIW1r+k2ZNjhhT33CYbgPD7c9o0Bnvli9jpZVDOsP
         kErGJqCNiFzjqADhgg1t5lrvGtU12c5E2FRBlGEMau5gWxD/Bpm22L+1NReARwHRR1kA
         epBCeU6z3scHPdUbIdLFVLK12nmVvem6MSJQZOcf2K/wOM1rkxg/Q5+QDN1Hhw+uMtuj
         yKk4EenptgOuk+PnDmL517EMIvhWnQIikH8jHPY83Mg43eh5Ux3jHORFieT1yxpSxoAA
         apwS/Y0bVFE0JTFyxMU2n66jZwNRuI9ctBtI7Lil9yZXEhDbELjf4xyIVB5yZHNCWSZy
         7A6g==
X-Gm-Message-State: AO0yUKV6oXHoLRdey/PffIxP8zzjUzvDznFGzjCrets8MiWdVQVeMybE
        F3bCDHKTZpiP5WybpJBDL0s=
X-Google-Smtp-Source: AK7set+G2kqgwZDwoaL6KNUHunRXTnEpy4BLg3BsGlA7AK5w7UARFy0ca+u/kTW2kVjjBlJczyDPBA==
X-Received: by 2002:a05:6a20:811a:b0:d8:161e:46 with SMTP id g26-20020a056a20811a00b000d8161e0046mr10942044pza.58.1679937417893;
        Mon, 27 Mar 2023 10:16:57 -0700 (PDT)
Received: from sumitra.com ([59.89.169.114])
        by smtp.gmail.com with ESMTPSA id n2-20020aa79042000000b00625e885a6ffsm9097830pfo.18.2023.03.27.10.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:16:57 -0700 (PDT)
Date:   Mon, 27 Mar 2023 10:16:53 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8192e: remove extra blank lines
Message-ID: <20230327171653.GA188371@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the extra blank line in accordance with the Linux kernel
coding-style regulations. These issues were reported by checkpatch.pl

"CHECK: Please don't use multiple blank lines"

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 1ce4c29dab13..c1b4e9e7c091 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -308,7 +308,6 @@ enum rt_op_mode {
 	RT_OP_MODE_NO_LINK,
 };
 
-
 #define aSifsTime						\
 	 (((priv->rtllib->current_network.mode == IEEE_A)	\
 	|| (priv->rtllib->current_network.mode == IEEE_N_24G)	\
@@ -653,7 +652,6 @@ struct rtllib_security {
 	u16 flags;
 } __packed;
 
-
 /* 802.11 data frame from AP
  *       ,-------------------------------------------------------------------.
  * Bytes |  2   |  2   |    6    |    6    |    6    |  2   | 0..2312 |   4  |
@@ -984,7 +982,6 @@ static inline u8 Frame_QoSTID(u8 *buf)
 		    (fc & RTLLIB_FCTL_FROMDS)) ? 30 : 24)))->field.tid;
 }
 
-
 struct eapol {
 	u8 snap[6];
 	u16 ethertype;
@@ -1199,8 +1196,6 @@ struct bandwidth_autoswitch {
 	bool bautoswitch_enable;
 };
 
-
-
 #define REORDER_WIN_SIZE	128
 #define REORDER_ENTRY_NUM	128
 struct rx_reorder_entry {
@@ -1372,7 +1367,6 @@ struct rt_intel_promisc_mode {
 	bool fltr_src_sta_frame;
 };
 
-
 /*************** DRIVER STATUS   *****/
 #define STATUS_SCANNING			0
 /*************** DRIVER STATUS   *****/
@@ -1441,7 +1435,6 @@ struct rtllib_device {
 	struct rx_reorder_entry RxReorderEntry[128];
 	struct list_head		RxReorder_Unused_List;
 
-
 	/* Bookkeeping structures */
 	struct net_device_stats stats;
 	struct rtllib_softmac_stats softmac_stats;
@@ -1738,7 +1731,6 @@ struct rtllib_device {
 				     struct rtllib_assoc_response_frame *resp,
 				     struct rtllib_network *network);
 
-
 	/* check whether Tx hw resource available */
 	short (*check_nic_enough_desc)(struct net_device *dev, int queue_index);
 	void (*SetBWModeHandler)(struct net_device *dev,
@@ -1811,7 +1803,6 @@ struct rtllib_device {
  */
 #define IEEE_SOFTMAC_BEACONS (1<<6)
 
-
 static inline void *rtllib_priv(struct net_device *dev)
 {
 	return ((struct rtllib_device *)netdev_priv(dev))->priv;
@@ -1903,7 +1894,6 @@ static inline int rtllib_is_cck_rate(u8 rate)
 	return 0;
 }
 
-
 /* rtllib.c */
 void free_rtllib(struct net_device *dev);
 struct net_device *alloc_rtllib(int sizeof_priv);
@@ -2113,7 +2103,6 @@ static inline const char *escape_essid(const char *essid, u8 essid_len)
 /* fun with the built-in rtllib stack... */
 bool rtllib_MgntDisconnect(struct rtllib_device *rtllib, u8 asRsn);
 
-
 /* For the function is more related to hardware setting, it's better to use the
  * ieee handler to refer to it.
  */
-- 
2.25.1

