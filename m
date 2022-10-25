Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A9460C16C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiJYBvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiJYBv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:51:26 -0400
X-Greylist: delayed 2794 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Oct 2022 18:50:21 PDT
Received: from gateway36.websitewelcome.com (gateway36.websitewelcome.com [192.185.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951BC3BB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:50:20 -0700 (PDT)
Received: from atl1wswcm03.websitewelcome.com (unknown [50.6.129.164])
        by atl3wswob06.websitewelcome.com (Postfix) with ESMTP id 3894A97FA7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:03:45 +0000 (UTC)
Received: from br984.hostgator.com.br ([162.241.203.37])
        by cmsmtp with ESMTP
        id n8M4oU53VPUI8n8M4odBhp; Tue, 25 Oct 2022 01:03:45 +0000
X-Authority-Reason: nr=8
Received: from [177.194.67.221] (port=43054 helo=arch-avell.meuintelbras.local)
        by br984.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <pedro.guilherme@espectro.eng.br>)
        id 1on8M4-001BYl-76;
        Mon, 24 Oct 2022 22:03:44 -0300
From:   Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
To:     laurent.pinchart@ideasonboard.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pedro Guilherme Siqueira Moreira 
        <pedro.guilherme@espectro.eng.br>
Subject: [PATCH 1/3] media: uvc_driver: fix missing newline after declarations
Date:   Mon, 24 Oct 2022 22:03:01 -0300
Message-Id: <20221025010303.570815-1-pedro.guilherme@espectro.eng.br>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br984.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - espectro.eng.br
X-BWhitelist: no
X-Source-IP: 177.194.67.221
X-Source-L: No
X-Exim-ID: 1on8M4-001BYl-76
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (arch-avell.meuintelbras.local) [177.194.67.221]:43054
X-Source-Auth: pedro.guilherme@espectro.eng.br
X-Email-Count: 1
X-Source-Cap: ZXNwZWN0ODU7ZXNwZWN0ODU7YnI5ODQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfC3NzepG6MiC+UzNpUGi4VMBqIjE4JCZ7pXHkIz7xwbSSEtfH6gNpCQOkweuiVielZjgU4zXI3AORxiDpJwxIM8rKXHiny8UJ5NhiGul+ydiIlQNa3Wz
 de+q4TgDnQEJDs/e5c3do3sdQi5qiX1JcFToeW1GQDp/8joFxp+KcX3VIhY8/aKP3aJ0j6qH2iQw4Ai8ehmRSZjoFo5csA2ngCM4tiiVmP8v9D5rydyoUSBQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
---
 drivers/media/usb/uvc/uvc_driver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 215fb483efb0..b591ad823c66 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -732,6 +732,7 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 	/* Parse the alternate settings to find the maximum bandwidth. */
 	for (i = 0; i < intf->num_altsetting; ++i) {
 		struct usb_host_endpoint *ep;
+
 		alts = &intf->altsetting[i];
 		ep = uvc_find_endpoint(alts,
 				streaming->header.bEndpointAddress);
@@ -1859,12 +1860,14 @@ static void uvc_delete(struct kref *kref)
 
 	list_for_each_safe(p, n, &dev->chains) {
 		struct uvc_video_chain *chain;
+
 		chain = list_entry(p, struct uvc_video_chain, list);
 		kfree(chain);
 	}
 
 	list_for_each_safe(p, n, &dev->entities) {
 		struct uvc_entity *entity;
+
 		entity = list_entry(p, struct uvc_entity, list);
 #ifdef CONFIG_MEDIA_CONTROLLER
 		uvc_mc_cleanup_entity(entity);
@@ -1874,6 +1877,7 @@ static void uvc_delete(struct kref *kref)
 
 	list_for_each_safe(p, n, &dev->streams) {
 		struct uvc_streaming *streaming;
+
 		streaming = list_entry(p, struct uvc_streaming, list);
 		usb_driver_release_interface(&uvc_driver.driver,
 			streaming->intf);
-- 
2.38.1

