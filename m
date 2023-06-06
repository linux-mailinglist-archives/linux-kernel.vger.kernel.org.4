Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F0A723849
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbjFFG7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjFFG7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:59:37 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB953B2;
        Mon,  5 Jun 2023 23:59:36 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-565e6beb7aaso72403317b3.2;
        Mon, 05 Jun 2023 23:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686034776; x=1688626776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vd6K83zCBIqUJb+/7JQBPZMdIFhiBUSwrG2VrCB9t8o=;
        b=Ti5tJ/GQM2WjplhKZWFOlrvFDfGPaixk5c+KGFkRoZXWh4cVBdNYI2kA/zVq41Hk8+
         XW3+BIrHuDDD+i2A8nXGL/MDmjislrVFJZnb3bpauxDN9oBRal67CTGtbIxYaaM5sEEF
         yF1XXdjFOY0hTQm64MGWo5rgsR8CwXhj+DmhwJk0hIel5c6OwTi76GShhlpmbYvduF6X
         6VQDy77yAkNchHPBFZZcwOILvQfd6c2AF5P+o3kgLMbZFuwE30A2+rMwjAaJB++CqsLx
         FU/4yHjQdoNpbSZ+M8ThpvOhfCT0DFSMyHB3W9WzmzRQ3qzWR/nQ9ZVdxVasmcagQd4D
         /Wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686034776; x=1688626776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vd6K83zCBIqUJb+/7JQBPZMdIFhiBUSwrG2VrCB9t8o=;
        b=Yhypvr5Cel+XSUP0PGz0m7pLgwhQwDX8PMbESJ+E6UMrVxxWoJuEtasjZdMJkKPFjr
         KteVH6aQO+25HsTwYMkepeHKviFmaMf97VRTQ9WbTUrMcfuoCcCP9AJvrfa1viYastIr
         3n2iKKB97M4QjkIEuz0+RBz4cunba9zQD72C9rXYdXuhvpPplIwUw8H+Kf5Cj0ZnK1Da
         wLuWcWSCTqU3ExKMJwmNvGvT7U/XGds0wjTMGCOtAiMlRnFfvtlMfkViTzI3xb2xq6Bp
         kiIXUbKLpCE63wSOFwNssOQff5UusdZJRm92SVNoZzyNyuWnVKI+RDqkeKFKnn4LAQtP
         UqPw==
X-Gm-Message-State: AC+VfDwq2cZVDuTcz83eMy9UsNOIREq0K1zPpozK5EEzm9Evs6o3FMUp
        6V8OCSyAH1tUEhEPQS7qiII=
X-Google-Smtp-Source: ACHHUZ4Iw8Nyeow3An48f79JbOHWmw7akeCKFpL6ByRMj7NqUoSExInscafI+EziWfMyJtd5VRySUA==
X-Received: by 2002:a81:74c2:0:b0:565:eacf:a58d with SMTP id p185-20020a8174c2000000b00565eacfa58dmr1233399ywc.38.1686034776030;
        Mon, 05 Jun 2023 23:59:36 -0700 (PDT)
Received: from devbox.. ([103.165.115.136])
        by smtp.gmail.com with ESMTPSA id e24-20020a62aa18000000b0065da94fe921sm2007664pff.50.2023.06.05.23.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 23:59:35 -0700 (PDT)
From:   Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
To:     b-liu@ti.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
Subject: [PATCH] drivers: usb: musb: musb_gadget: fixed coding style issues and removed unneeded code
Date:   Tue,  6 Jun 2023 12:29:21 +0530
Message-Id: <20230606065921.997102-1-neelchakrabortykernelwork@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a few coding style issues
Removed the static int musb_gadget_vbus_session function as it was
doing nothing.

Signed-off-by: Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
---
 drivers/usb/musb/musb_gadget.c | 38 +++++++++++-----------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 31c44325e828..ac5f9d325f71 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -521,7 +521,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	struct usb_request	*request = &req->request;
 	struct musb_ep		*musb_ep;
 	void __iomem		*epio = musb->endpoints[epnum].regs;
-	unsigned		len = 0;
+	unsigned int		len = 0;
 	u16			fifo_count;
 	u16			csr = musb_readw(epio, MUSB_RXCSR);
 	struct musb_hw_ep	*hw_ep = &musb->endpoints[epnum];
@@ -657,7 +657,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 					musb_writew(epio, MUSB_RXCSR, csr);
 
 					transfer_size = min(request->length - request->actual,
-							(unsigned)fifo_count);
+							(unsigned int)fifo_count);
 					musb_ep->dma->desired_mode = 0;
 				}
 
@@ -695,7 +695,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 					transfer_size = min_t(unsigned int,
 							request->length -
 							request->actual,
-							(unsigned)fifo_count);
+							(unsigned int)fifo_count);
 
 				csr &= ~MUSB_RXCSR_DMAMODE;
 				csr |= (MUSB_RXCSR_DMAENAB |
@@ -728,7 +728,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 					fifo_count, len,
 					musb_ep->packet_sz);
 
-			fifo_count = min_t(unsigned, len, fifo_count);
+			fifo_count = min_t(unsigned int, len, fifo_count);
 
 			if (tusb_dma_omap(musb)) {
 				struct dma_controller *c = musb->dma_controller;
@@ -870,9 +870,8 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 		if ((request->actual < request->length)
 				&& (musb_ep->dma->actual_len
 					== musb_ep->packet_sz)) {
-			/* In double buffer case, continue to unload fifo if
- 			 * there is Rx packet in FIFO.
- 			 **/
+			// In double buffer case, continue to unload fifo if
+			// there is Rx packet in FIFO.
 			csr = musb_readw(epio, MUSB_RXCSR);
 			if ((csr & MUSB_RXCSR_RXPKTRDY) &&
 				hw_ep->rx_double_buffered)
@@ -916,7 +915,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	void __iomem	*mbase;
 	u8		epnum;
 	u16		csr;
-	unsigned	tmp;
+	unsigned int	tmp;
 	int		status = -EINVAL;
 
 	if (!ep || !desc)
@@ -1132,7 +1131,7 @@ struct usb_request *musb_alloc_request(struct usb_ep *ep, gfp_t gfp_flags)
 	struct musb_ep		*musb_ep = to_musb_ep(ep);
 	struct musb_request	*request = NULL;
 
-	request = kzalloc(sizeof *request, gfp_flags);
+	request = kzalloc(sizeof(*request), gfp_flags);
 	if (!request)
 		return NULL;
 
@@ -1161,7 +1160,7 @@ static LIST_HEAD(buffers);
 struct free_record {
 	struct list_head	list;
 	struct device		*dev;
-	unsigned		bytes;
+	unsigned int		bytes;
 	dma_addr_t		dma;
 };
 
@@ -1343,7 +1342,7 @@ static int musb_gadget_set_halt(struct usb_ep *ep, int value)
 
 	spin_lock_irqsave(&musb->lock, flags);
 
-	if ((USB_ENDPOINT_XFER_ISOC == musb_ep->type)) {
+	if (USB_ENDPOINT_XFER_ISOC == musb_ep->type) {
 		status = -EINVAL;
 		goto done;
 	}
@@ -1612,21 +1611,8 @@ static void musb_pullup(struct musb *musb, int is_on)
 	musb_writeb(musb->mregs, MUSB_POWER, power);
 }
 
-#if 0
-static int musb_gadget_vbus_session(struct usb_gadget *gadget, int is_active)
-{
-	musb_dbg(musb, "<= %s =>\n", __func__);
-
-	/*
-	 * FIXME iff driver's softconnect flag is set (as it is during probe,
-	 * though that can clear it), just musb_pullup().
-	 */
-
-	return -EINVAL;
-}
-#endif
 
-static int musb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
+static int musb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned int mA)
 {
 	struct musb	*musb = gadget_to_musb(gadget);
 
@@ -1744,7 +1730,7 @@ static inline void musb_g_init_endpoints(struct musb *musb)
 {
 	u8			epnum;
 	struct musb_hw_ep	*hw_ep;
-	unsigned		count = 0;
+	unsigned int		count = 0;
 
 	/* initialize endpoint list just once */
 	INIT_LIST_HEAD(&(musb->g.ep_list));
-- 
2.40.1

