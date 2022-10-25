Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAD460C338
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJYF02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJYF0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:26:25 -0400
X-Greylist: delayed 1280 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Oct 2022 22:26:25 PDT
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com [192.185.46.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321B3BBE1D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:26:24 -0700 (PDT)
Received: from atl1wswcm04.websitewelcome.com (unknown [50.6.129.165])
        by atl1wswob02.websitewelcome.com (Postfix) with ESMTP id 268911B394
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:05:01 +0000 (UTC)
Received: from br984.hostgator.com.br ([162.241.203.37])
        by cmsmtp with ESMTP
        id nC7Yomv9ZgEOMnC7YoEZka; Tue, 25 Oct 2022 05:05:01 +0000
X-Authority-Reason: nr=8
Received: from [177.194.67.221] (port=44582 helo=arch-avell.meuintelbras.local)
        by br984.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <pedro.guilherme@espectro.eng.br>)
        id 1onC7X-001KDW-TL;
        Tue, 25 Oct 2022 02:05:00 -0300
From:   Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
To:     laurent.pinchart@ideasonboard.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pedro Guilherme Siqueira Moreira 
        <pedro.guilherme@espectro.eng.br>
Subject: [PATCH v2 1/3] media: uvc_driver: fix missing newline after declarations
Date:   Tue, 25 Oct 2022 02:04:48 -0300
Message-Id: <20221025050450.1743072-1-pedro.guilherme@espectro.eng.br>
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
X-Exim-ID: 1onC7X-001KDW-TL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (arch-avell.meuintelbras.local) [177.194.67.221]:44582
X-Source-Auth: pedro.guilherme@espectro.eng.br
X-Email-Count: 1
X-Source-Cap: ZXNwZWN0ODU7ZXNwZWN0ODU7YnI5ODQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPqS8vGiHVTShZo100c4PoQMv60P+fklr+y0GGnHEJMyercji0iSNI+UOFnAksNRdkXxefRMbbFusTImqIpMqhmA0pmCjnS8HmreA5RzA7IKMO+yhcP4
 vkGNDDaH+IaStK75BH/J9YlMCjs9a49FW+xgL/M3txYqCyMMEmH9kcTbc3UJ+jFZvP/Mx04LypPOVVpJZvRBS5zcIDinIaWGULJUOOy5kt0S0/OQQnZdW4ij
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes 'Missing a blank line after declarations' warning issued by
scripts/checkpatch.pl on drivers/media/usb/uvc/uvc_driver.c

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

