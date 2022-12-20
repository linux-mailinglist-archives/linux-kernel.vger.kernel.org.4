Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CE3652931
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 23:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiLTWwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 17:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiLTWwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 17:52:11 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76021F2C8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 14:52:09 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id tz12so32757077ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 14:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A+s91cNikbCmUympaj0zn/R/D4VCLupmyCFlgATkzu8=;
        b=QPK3UgMPen4VNOV9F949K5vtIoCz025W+UMP6wGYFo3XfVnOQ5KYPXpNWzEDMApYOk
         +s0u+IENdFf6y6qjpG0GnMggKprb4dDqJCD3KTjjGO5bXkUUd556l2X3Q0PXirMnROd3
         WeAWoAmVY0WhmAXDyQ+6vMsJBsDtrvTd8pe7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+s91cNikbCmUympaj0zn/R/D4VCLupmyCFlgATkzu8=;
        b=bCcSmy/lnujrzhBeBdPNeFDTEGk8T5k7aF4/8RVvmdSwmK7jemIg/MWClVVBh5kfQk
         lfxI1khSHkz+OP1KrG58ttgnd1EkLJqAvENhnTd0CXit151asQCaHt9AeIQs/3qOUxIN
         3XqKkcIYfaDwIuduVnhxKuGaWqmxVKHgFC9BGidwD4FqaEmj+P+gFZs4x0UJGYW/7k46
         7iHYyxRYaJgQqWg0CUW7x+eq4EUj342OZZCocBHSxHfzTglG/cFwEenRGt9eBJXOFNs6
         f83OTccuIIpliJC5DPHc8ymcekH42xmpVSpkYnR0j9tCSr3i1PaUm0hIBWeODWVMNzoF
         nY4Q==
X-Gm-Message-State: AFqh2kpTMqjqEpziQK/EFJdaQ39nUkvlEakbAR1y6VE63yuIjaoiAbfT
        2zXzLCPs2me4mBZmpIgux3MN4w==
X-Google-Smtp-Source: AMrXdXvbTDsbwHhoG6BtPm7MP0wLA2CyTkEj7UpcauFIpuzF0fZH+HfwnteymwH+pK/zoNuIjkV8tg==
X-Received: by 2002:a17:906:8447:b0:7c8:9f04:ae7e with SMTP id e7-20020a170906844700b007c89f04ae7emr3038732ejy.22.1671576728539;
        Tue, 20 Dec 2022 14:52:08 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id r18-20020a17090609d200b007be301a1d51sm6176494eje.211.2022.12.20.14.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 14:52:08 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Dec 2022 23:52:03 +0100
Subject: [PATCH] USB: Improve usb_fill_* documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221220-usb-dmadoc-v1-0-28386d2eb6cd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Christoph Hellwig <hch@lst.de>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Ricardo Ribalda <ribalda@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=4666; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=Fm1wjAu2tpXMJ7r7AJYyOC60wItutOtoAsZzXKfKUUs=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjojyVwwQ7gOgmK3EGIWA2mRmmAwR2rS2U5MvjZpXe
 iLm0JZeJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6I8lQAKCRDRN9E+zzrEiBLnD/
 4yqHU8rEFkzt2+2DnfLPlhRQwCKPk8IWziMMKMbpfbFksrpnICQWuH30JI7y5wwnMxFXB6vxqjQMHN
 Dw+poGLqdFASQx+FCs0j3QxAJ1lA4wfPH7iZxLFVXq1N+JwRJGX/X5WzdJ7l+tDLUEtar4rk9vusRq
 lu6bbV8DSGLvNr7F9drSGbkXD+VJpFI4uZFUB6uBwZWLi8Vjgos5GHBLEU0OvBlk8ugWdf+44jWnq1
 lJseR3fJHQq/oYB8T0/SzDHBewwRThuEPR3TQ10N3UmEeJE8GnWWNUspRkDPn4TjY/FncqmyDPcyeh
 uXAb+wvfrZxdh7p/aVVsMXfW3ImiWHAa4okbJ86tl9YOPVwtk4Xmw9ROMTnOMT4r/rZ86fM26KGje3
 M3fI/Ra/P64QUdQQ/h+oqO7iloVc0aFCDdnBGMeIpDjk09k05pCGApRdGPkWYpz9jRQ5Nw9QB9NYt+
 +jStOA38CRk1thcouAYkm/YwkAeXnQ9Z4a0Be8e2A43Thzij+WtXbkTc8yI3uLSSxs/Lc37eDdbcE6
 npvQ7PIZCBJVs+WUoXLS2CUi9jmr0zOmLi1/gZqeRn7C3JnMu2P2R/4EKJRxUDOOurjlD2rhjbZp5B
 kdKWNFT0vDNvdYjN8pC3gmDctGommf4yW4qibvVGnwFezJGf+9pik87AVzsA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the developer aware of the requirements of transfer buffer.

The buffer must be DMAble, if the developer uses an invalid buffer, data
corruption might happen.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
USB: Improve usb_fill_* documentation

After trying to "cleanup" the uvc code, I was patiently explained about
the requirements of the urb transfer buffers.

Lets make this explicit, so other developers do not make the same mistake.

To: Alan Stern <stern@rowland.harvard.edu>
To: Christoph Hellwig <hch@lst.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/usb.h | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index 7d5325d47c45..033ca69b563d 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1627,13 +1627,20 @@ struct urb {
  * @dev: pointer to the struct usb_device for this urb.
  * @pipe: the endpoint pipe
  * @setup_packet: pointer to the setup_packet buffer
- * @transfer_buffer: pointer to the transfer buffer
+ * @transfer_buffer: pointer to the transfer buffer. Must be suitable for DMA.
  * @buffer_length: length of the transfer buffer
  * @complete_fn: pointer to the usb_complete_t function
  * @context: what to set the urb context to.
  *
  * Initializes a control urb with the proper information needed to submit
  * it to a device.
+ *
+ * The transfer buffer might be filled via DMA. The simplest way to get
+ * a buffer that can be DMAed to, is allocatiing it via kmalloc() or
+ * equivalent, even for very small buffers. If transfer_buffer is embedded
+ * in a bigger structure, there is a risk that the previous and following
+ * fields are left in a corrupted state by the DMA engine, if the platform
+ * is not cache coherent.
  */
 static inline void usb_fill_control_urb(struct urb *urb,
 					struct usb_device *dev,
@@ -1658,13 +1665,20 @@ static inline void usb_fill_control_urb(struct urb *urb,
  * @urb: pointer to the urb to initialize.
  * @dev: pointer to the struct usb_device for this urb.
  * @pipe: the endpoint pipe
- * @transfer_buffer: pointer to the transfer buffer
+ * @transfer_buffer: pointer to the transfer buffer. Must be suitable for DMA.
  * @buffer_length: length of the transfer buffer
  * @complete_fn: pointer to the usb_complete_t function
  * @context: what to set the urb context to.
  *
  * Initializes a bulk urb with the proper information needed to submit it
  * to a device.
+ *
+ * The transfer buffer might be filled via DMA. The simplest way to get
+ * a buffer that can be DMAed to, is allocatiing it via kmalloc() or
+ * equivalent, even for very small buffers. If transfer_buffer is embedded
+ * in a bigger structure, there is a risk that the previous and following
+ * fields are left in a corrupted state by the DMA engine, if the platform
+ * is not cache coherent.
  */
 static inline void usb_fill_bulk_urb(struct urb *urb,
 				     struct usb_device *dev,
@@ -1687,7 +1701,7 @@ static inline void usb_fill_bulk_urb(struct urb *urb,
  * @urb: pointer to the urb to initialize.
  * @dev: pointer to the struct usb_device for this urb.
  * @pipe: the endpoint pipe
- * @transfer_buffer: pointer to the transfer buffer
+ * @transfer_buffer: pointer to the transfer buffer. Must be suitable for DMA.
  * @buffer_length: length of the transfer buffer
  * @complete_fn: pointer to the usb_complete_t function
  * @context: what to set the urb context to.
@@ -1697,6 +1711,13 @@ static inline void usb_fill_bulk_urb(struct urb *urb,
  * Initializes a interrupt urb with the proper information needed to submit
  * it to a device.
  *
+ * The transfer buffer might be filled via DMA. The simplest way to get
+ * a buffer that can be DMAed to, is allocatiing it via kmalloc() or
+ * equivalent, even for very small buffers. If transfer_buffer is embedded
+ * in a bigger structure, there is a risk that the previous and following
+ * fields are left in a corrupted state by the DMA engine, if the platform
+ * is not cache coherent.
+ *
  * Note that High Speed and SuperSpeed(+) interrupt endpoints use a logarithmic
  * encoding of the endpoint interval, and express polling intervals in
  * microframes (eight per millisecond) rather than in frames (one per

---
base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
change-id: 20221220-usb-dmadoc-29384acebd48

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
