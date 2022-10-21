Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D36609267
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 13:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiJWLES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 07:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJWLEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 07:04:15 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA392733E8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 04:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666523044; bh=CXFYkS/9I3ecfwQqOB0xh0UmIHm5NvOthOCQ+wQCho4=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=TeJ3SkKVax6heRHLZamZ2Mmo62DLNhNYc5TxC/0rdoGn4kut72/lY6+GaQVBYSYKf
         e/Kou/u3O6zE0sXJRlh1Ij8RHXyF1mQ2MbzvfWnSuopE/D6MRFTG3dOYNcNs6URTy9
         w5dMGaBBAMkxzTtql7EJnY7swAt/++k4hx7T+E5E=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via [213.182.55.206]
        Sun, 23 Oct 2022 13:04:04 +0200 (CEST)
X-EA-Auth: Yjri6/BpUBj1GUUFqZyfaA0i881R5h6QtDnu49t/H5do4HKgbeG8VkdOdzAdzB+pCSYB6zJ2QORaobSbl4yso6Khm2FmV9wY
Date:   Sat, 22 Oct 2022 01:03:42 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: wlan-ng: remove commented debug printk messages
Message-ID: <Y1L0FiKvrM9jjZG9@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

Changes in v2:
   1. Resending as v2 since I incorrectly send multiple emails for the patch
   earlier. Feedback from gregkh@linuxfoundation.org


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



