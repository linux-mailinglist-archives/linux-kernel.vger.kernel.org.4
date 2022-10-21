Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B544A6074FE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiJUKbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiJUKa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:30:56 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC151C25F0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666348248; bh=jtnn88d1QPB9a8mRoXuB6CbwtjfRDKBhxTxl4zKQrP4=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=HeLbNfrFAqlt4VrX/p16fHl0VxuqpFPrzI4F4XAnYpC4U7fa3w32DZYt2OGnTpabU
         68tFio7t55EcbVF9qv5TBW5d5zN2LiMz/E9QDMNTvxFg3ExBRJ5J3DJF3o7j019ZKh
         9tkb1D+trVoHLdmj8lwd1oSb+I/6aJ8LAA4KWG6I=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.206]
        Fri, 21 Oct 2022 12:30:48 +0200 (CEST)
X-EA-Auth: XTE0cHlHiFPu0Grh051zZPg/T10f6Lv7jpO0dfQPpzSSA5nlFWt/T6Q08N+I8jkXf48XFgOrLbVKAmCewc5zNb7NJ5jgj0bW
Date:   Fri, 21 Oct 2022 07:15:24 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: remove commented debug printk messages
Message-ID: <Y1H5tJXjMZqiB6rh@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk messages are added for program flow tracing and are left
commented. These commented log messages should be removed as they
are no more useful for program execution.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/wlan-ng/p80211netdev.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
index e04fc666d218..6bef419e8ad0 100644
--- a/drivers/staging/wlan-ng/p80211netdev.c
+++ b/drivers/staging/wlan-ng/p80211netdev.c
@@ -881,55 +881,42 @@ static int p80211_rx_typedrop(struct wlandevice *wlandev, u16 fc)
 		wlandev->rx.mgmt++;
 		switch (fstype) {
 		case WLAN_FSTYPE_ASSOCREQ:
-			/* printk("assocreq"); */
 			wlandev->rx.assocreq++;
 			break;
 		case WLAN_FSTYPE_ASSOCRESP:
-			/* printk("assocresp"); */
 			wlandev->rx.assocresp++;
 			break;
 		case WLAN_FSTYPE_REASSOCREQ:
-			/* printk("reassocreq"); */
 			wlandev->rx.reassocreq++;
 			break;
 		case WLAN_FSTYPE_REASSOCRESP:
-			/* printk("reassocresp"); */
 			wlandev->rx.reassocresp++;
 			break;
 		case WLAN_FSTYPE_PROBEREQ:
-			/* printk("probereq"); */
 			wlandev->rx.probereq++;
 			break;
 		case WLAN_FSTYPE_PROBERESP:
-			/* printk("proberesp"); */
 			wlandev->rx.proberesp++;
 			break;
 		case WLAN_FSTYPE_BEACON:
-			/* printk("beacon"); */
 			wlandev->rx.beacon++;
 			break;
 		case WLAN_FSTYPE_ATIM:
-			/* printk("atim"); */
 			wlandev->rx.atim++;
 			break;
 		case WLAN_FSTYPE_DISASSOC:
-			/* printk("disassoc"); */
 			wlandev->rx.disassoc++;
 			break;
 		case WLAN_FSTYPE_AUTHEN:
-			/* printk("authen"); */
 			wlandev->rx.authen++;
 			break;
 		case WLAN_FSTYPE_DEAUTHEN:
-			/* printk("deauthen"); */
 			wlandev->rx.deauthen++;
 			break;
 		default:
-			/* printk("unknown"); */
 			wlandev->rx.mgmt_unknown++;
 			break;
 		}
-		/* printk("\n"); */
 		drop = 2;
 		break;

@@ -943,35 +930,27 @@ static int p80211_rx_typedrop(struct wlandevice *wlandev, u16 fc)
 		wlandev->rx.ctl++;
 		switch (fstype) {
 		case WLAN_FSTYPE_PSPOLL:
-			/* printk("pspoll"); */
 			wlandev->rx.pspoll++;
 			break;
 		case WLAN_FSTYPE_RTS:
-			/* printk("rts"); */
 			wlandev->rx.rts++;
 			break;
 		case WLAN_FSTYPE_CTS:
-			/* printk("cts"); */
 			wlandev->rx.cts++;
 			break;
 		case WLAN_FSTYPE_ACK:
-			/* printk("ack"); */
 			wlandev->rx.ack++;
 			break;
 		case WLAN_FSTYPE_CFEND:
-			/* printk("cfend"); */
 			wlandev->rx.cfend++;
 			break;
 		case WLAN_FSTYPE_CFENDCFACK:
-			/* printk("cfendcfack"); */
 			wlandev->rx.cfendcfack++;
 			break;
 		default:
-			/* printk("unknown"); */
 			wlandev->rx.ctl_unknown++;
 			break;
 		}
-		/* printk("\n"); */
 		drop = 2;
 		break;

@@ -1007,7 +986,6 @@ static int p80211_rx_typedrop(struct wlandevice *wlandev, u16 fc)
 			wlandev->rx.cfack_cfpoll++;
 			break;
 		default:
-			/* printk("unknown"); */
 			wlandev->rx.data_unknown++;
 			break;
 		}
--
2.30.2



