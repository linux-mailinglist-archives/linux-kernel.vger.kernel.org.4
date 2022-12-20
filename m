Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA67B6529A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 00:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiLTXNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 18:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLTXNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 18:13:16 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D0D18B1E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 15:13:15 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id x22so32804991ejs.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 15:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fAOA0PDOHi+BjeL4QEeop8pzYpBAD5JtsJhUbERR1iY=;
        b=FUUAAbmnfozJJTu4DbXslNuGUTxQh/acvp4I7KmcrCgkAhzf8PC9uzxN4tYLnH1o3Z
         UT6CiFCLferA02ghb7GNWx1E57w95ZtYpteSiDdw3TrspoA/PmXdw+7M04+tvKwZK70w
         8dyGNI4I8jAc0lb6l3+6RH9gtjXFXr5R//PmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAOA0PDOHi+BjeL4QEeop8pzYpBAD5JtsJhUbERR1iY=;
        b=Uihpu/IbX8U555Nxi8T2yb+hVna8Qhb2a5xqP2B6Y32tM7OvwriOhyjLvmJgW+NFk7
         t34adT24CMwRVpXKbniUTh1gWlYlgwOKEV6a86ZwxmG+dyOuopc6UfW+POibdjjs66dx
         5LccHcJvkUb5diy13WqWWmyYzwpZ8wsZRiMCWmHKKg8urSh1OtHWfunzKXwntqugtito
         wI5PKe2UwMF/78IwY2CzJjMt6cG51r3do5ccHgAHmp2P9N9on1jOoADAe9wa25IxRjiX
         DanMdHl/77JhL38tVPXthYyabhR0FX1TKoawR+hIuwlPbxqVjgNR2zo7ozBA8MQSQhIX
         kZgA==
X-Gm-Message-State: AFqh2koijOBXBaS73ErODY0MLE4EI/y+i/XFBeJIHxOaN061VuSAvfWE
        HVcSK03VSKcrdn+8C990/Pivng==
X-Google-Smtp-Source: AMrXdXu4b7pTl3FriTtPGeLVV+LXvWkpoUuAX1IYb6dCRvknH8QDzZ+0W6zfdpm3GHu3zQHOENKZAw==
X-Received: by 2002:a17:906:68e:b0:7e2:ca68:6715 with SMTP id u14-20020a170906068e00b007e2ca686715mr3264294ejb.63.1671577994091;
        Tue, 20 Dec 2022 15:13:14 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id ky22-20020a170907779600b0073c8d4c9f38sm6371846ejc.177.2022.12.20.15.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 15:13:13 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Dec 2022 00:13:08 +0100
Subject: [PATCH v2] USB: Improve usb_fill_* documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221220-usb-dmadoc-v2-0-4dd4f198113e@chromium.org>
To:     Christoph Hellwig <hch@lst.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-usb@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=4860; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=2o9zktt47eUe3jUWuontctt1l3KcYtWrvN2LN5rBG0g=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjokGFLQGUYY4ddm8vZ7PK5RVZDK8+1OucUSrdeOb/
 Iva10IOJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6JBhQAKCRDRN9E+zzrEiCvTEA
 CJgo1BWYm++VnjAbDzuk45N2tk/qUiUbvJMLjMBymfvok3B2MUetKRejUJWazxoDVt7BI1aqyuMLB6
 WSHLT/P6MEm3OtgzXY1quouvrzyEkGHZ6+hKP5ubHc/4249wUHh97RpsDZeZTf4vwLB7Ee1Urv9hYf
 yNdmaHeX/aqAAJ84pssp0CAolji1g3YbuAuAR8xJMd77xdesTfXRIBtDrG1RBp9gtDKjz+U3a3u1Tb
 R7GuFuxkq29HCzKvZZHfVkTe9eBMMf7Yw8QODYj/sbAeIMf2RyE2Guh5qfZFDPEfBSrbnHr3gEhWpK
 LpoCbQLfNyYc55GfuiLLmEp6Ddgyy2SmsSgHtjvAbk7c5dPV/KTa/lFTt6MHpmzc0wpEOSP8SRxZP7
 OadMfvIu8OUJ/4Y1zqjNVk8tgQmkqxAoGW+32v+7CL10dDYzK2QyVdxP8J8FfUkdqKd8F3c/eGpR7K
 oFPKrqvx8aDclVnEAbZkVjwoYdoClE68sZfcROqL1B7QdCPQApeL8QCauE/SN8EkLqx3SehMErBEWr
 ngwdaOK0Wbdn16Xmi8cv3TTOI89Cy0nD6Kze0yxoHHd/ysIJ5qP73HwTGXpOjohNmEPzV9VClMwV+S
 9zNk6hNbCBkj4KApiZRZQ+FUuxym6U010NUwg0Qw1LQI2xqCtMdaEaT5srfg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

To: Randy Dunlap <rdunlap@infradead.org>
To: Alan Stern <stern@rowland.harvard.edu>
To: Christoph Hellwig <hch@lst.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes in v2:
- s/allocatiing/allocating/ Thanks Randy
- Link to v1: https://lore.kernel.org/r/20221220-usb-dmadoc-v1-0-28386d2eb6cd@chromium.org
---
 include/linux/usb.h | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index 7d5325d47c45..1144ef6e4151 100644
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
+ * a buffer that can be DMAed to, is allocating it via kmalloc() or
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
+ * a buffer that can be DMAed to, is allocating it via kmalloc() or
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
+ * a buffer that can be DMAed to, is allocating it via kmalloc() or
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
