Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999626989DB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBPBfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBPBfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:35:41 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB47942DF0;
        Wed, 15 Feb 2023 17:35:40 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 940CE1A00990;
        Thu, 16 Feb 2023 09:36:15 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vQiqXFqyimAa; Thu, 16 Feb 2023 09:36:14 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhounan@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 69E6D1A00910;
        Thu, 16 Feb 2023 09:36:14 +0800 (CST)
From:   Zhou nan <zhounan@nfschina.com>
To:     leoyang.li@nxp.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Zhou nan <zhounan@nfschina.com>
Subject: [PATCH v2] usb: fix some spelling mistakes in comment of gadget
Date:   Wed, 15 Feb 2023 17:35:35 -0800
Message-Id: <20230216013535.6399-1-zhounan@nfschina.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb: Fix spelling mistake in comments of gadget.

Signed-off-by: Zhou nan <zhounan@nfschina.com>
---
v2:
- Modify the title and description text.
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index a67873a074b7..da876d09fc01 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -471,7 +471,7 @@ static int dr_ep_get_stall(unsigned char ep_num, unsigned char dir)
 ********************************************************************/
 
 /*------------------------------------------------------------------
-* struct_ep_qh_setup(): set the Endpoint Capabilites field of QH
+* struct_ep_qh_setup(): set the Endpoint Capabilities field of QH
  * @zlt: Zero Length Termination Select (1: disable; 0: enable)
  * @mult: Mult field
  ------------------------------------------------------------------*/
@@ -483,7 +483,7 @@ static void struct_ep_qh_setup(struct fsl_udc *udc, unsigned char ep_num,
 	struct ep_queue_head *p_QH = &udc->ep_qh[2 * ep_num + dir];
 	unsigned int tmp = 0;
 
-	/* set the Endpoint Capabilites in QH */
+	/* set the Endpoint Capabilities in QH */
 	switch (ep_type) {
 	case USB_ENDPOINT_XFER_CONTROL:
 		/* Interrupt On Setup (IOS). for control ep  */
@@ -593,7 +593,7 @@ static int fsl_ep_enable(struct usb_ep *_ep,
 	ep->stopped = 0;
 
 	/* Controller related setup */
-	/* Init EPx Queue Head (Ep Capabilites field in QH
+	/* Init EPx Queue Head (Ep Capabilities field in QH
 	 * according to max, zlt, mult) */
 	struct_ep_qh_setup(udc, (unsigned char) ep_index(ep),
 			(unsigned char) ((desc->bEndpointAddress & USB_DIR_IN)
@@ -1361,7 +1361,7 @@ static void ch9getstatus(struct fsl_udc *udc, u8 request_type, u16 value,
 	udc->ep0_dir = USB_DIR_IN;
 	/* Borrow the per device status_req */
 	req = udc->status_req;
-	/* Fill in the reqest structure */
+	/* Fill in the request structure */
 	*((u16 *) req->req.buf) = cpu_to_le16(tmp);
 
 	req->ep = ep;
-- 
2.27.0

