Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D401652F38
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiLUKQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiLUKQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:16:03 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E312BFC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 02:15:45 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c17so21259732edj.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 02:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s8TQ65XghkOPiAq/wiBW7MGAtx2Yz5vWTOYzTpQiFwY=;
        b=VgWqM7n/+2TECRS+UTktIX1FMswAitsWrjyjPRSkEMnUUqIGIPghBosp75x9v8x7OG
         MeR+gRg/9fWOhzwRKNBW3/n0EH8yiFVuqB8JH5/jj0U1PFl0hecohvgitD8RbHyusIG7
         i2brmILMQgvdZYi+hiWWF1137V78NczGOEqQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s8TQ65XghkOPiAq/wiBW7MGAtx2Yz5vWTOYzTpQiFwY=;
        b=DqMQoXatGbQh/2CP2fwypxI4gE+DvQ7kAh7taU/8Etd8eUYTT3jd1d4RlFgc+k58P2
         g34S4cfzgoiwLNP0a8bYmznFHw7mNCbXIrC027WlzMAScA+JBr9K5C+2I7uw/IoynCRm
         6gAq469MU/leoNCU63VjyEsN2QEPpaTUD+2qPPSJAQGijrqzY4wRWgzE9GDQBuMedv+x
         564fi83XA2YQWBD56d8PqpFKjAPNsp2VxSu5gvQ0iI4XKngTeVAnOJuAdFG8VdmsDDl6
         0V4opmngSiKEqCW3ZTPpsBftJk29BLt3qgywDdrCHsLtDeFrKMO0CYlmatoE+m5UplVJ
         7dkg==
X-Gm-Message-State: AFqh2krOUGy7FLi0D0D0NyRfUOH+WxUvHPGHHgpLn7N0vEW1i19DDQQo
        AxIBPsmMjGSMpcTGjADWtzlVMcxZ1Q6RAAwuts8=
X-Google-Smtp-Source: AMrXdXtX8WKMYQWAG6na2BVhiJzYxEfsqA2gp4cThpQXe9mYmybIpM3Wr3K0cRBMA96HWT3TwfQncQ==
X-Received: by 2002:a05:6402:40c5:b0:473:ae62:40d0 with SMTP id z5-20020a05640240c500b00473ae6240d0mr6025354edb.7.1671617744514;
        Wed, 21 Dec 2022 02:15:44 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:39e5:d0e8:4943:9f63])
        by smtp.gmail.com with ESMTPSA id o15-20020aa7c7cf000000b0046f77031d40sm6680086eds.10.2022.12.21.02.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 02:15:43 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Dec 2022 11:15:14 +0100
Subject: [PATCH v3] USB: Improve usb_fill_* documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221220-usb-dmadoc-v3-0-6009f4d27631@chromium.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Christoph Hellwig <hch@lst.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=4774; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=0PXjFPGPwH2AHv79/k4M21SMY9pAk4iVw/gw7Yt85yU=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjoty2Nfhz5hV1squR5H/i2T+GfYp2ZQ7DUFsziPez
 ExeaB6uJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6LctgAKCRDRN9E+zzrEiAoYD/
 4gt7LATKt7Ac0fAFxGLSQ97lUhoz6fjFk7pf8W3JLm3+6T6v309U7ppiUe8iS2RVpjKMQu+jkIe9VB
 WnQBXuFIqr/gNjNznMgFaCF+J/gmT2EEaCAK2w0Tgf/Vx+1TV2LsnrN/08yUzLLHzhyA9Td8Hlbm6w
 TOSa50No/yR1RxahaNsDkbaYjspJHFtlyktb1sPA7xFxTvtQ/QW2Iouk0eRM7LYoqtz8LsM5crftO3
 sP7TihCemyoodP8c73fGNXHIC6no/YSqqTwfoUTiRsuLj4rjquaHr93PbWT8o2Slr0O9GWscNsAHDk
 xRZ8C+wNKSi+2KXFpMbmQZmR+YDrMrKZc5snwrcTOlbHvYYytGqfd/z4uqHhFqw7gdjaJl7bhMmgfk
 ln4ma0C+qUwn3D4ZC2qK+D+7zK7PHtwXnPDRzpCzuhyCLUWy3Ih95dWKeIr+d4cnfz3+8HdzcoY7Li
 9z2RY5CCCP7J8ps2NELSdcgTTfKd/S/DrUL469D+fEvRyrN7DzqouPjL7VFEStXbCOTGlF+QWAzRBr
 cmqlvIaImxhgm+6+i3E6nEfa9NbUJgKDozDlEHjJZU8o7r1fCwSC9MpQi3pAN+tXn+Q2sQ4GkLKZF5
 Hg8IJP40VRCFqTE+6QlGBBjUCFXN62Jd6dEy33DCVZLJ6Cmy83pkYNmXKSRg==
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

Document the transfer buffer requirement. That is, the buffer must be
DMAble - otherwise data corruption might occur.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
USB: Improve usb_fill_* documentation

After trying to "cleanup" the uvc code, I was patiently explained about
the requirements of the urb transfer buffers.

Lets make this explicit, so other developers do not make the same mistake.

To: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
To: Alan Stern <stern@rowland.harvard.edu>
To: Christoph Hellwig <hch@lst.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes in v3:
- Improve commit message. Thanks Bagas!
- Improve field description. Thanks Alan!
- Link to v2: https://lore.kernel.org/r/20221220-usb-dmadoc-v2-0-4dd4f198113e@chromium.org

Changes in v2:
- s/allocatiing/allocating/ Thanks Randy
- Link to v1: https://lore.kernel.org/r/20221220-usb-dmadoc-v1-0-28386d2eb6cd@chromium.org
---
 include/linux/usb.h | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index 7d5325d47c45..06cde9ddca97 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1626,14 +1626,25 @@ struct urb {
  * @urb: pointer to the urb to initialize.
  * @dev: pointer to the struct usb_device for this urb.
  * @pipe: the endpoint pipe
- * @setup_packet: pointer to the setup_packet buffer
- * @transfer_buffer: pointer to the transfer buffer
+ * @setup_packet: pointer to the setup_packet buffer. The buffer must be
+ *	suitable for DMA.
+ * @transfer_buffer: pointer to the transfer buffer. The buffer must be
+ *	suitable for DMA.
  * @buffer_length: length of the transfer buffer
  * @complete_fn: pointer to the usb_complete_t function
  * @context: what to set the urb context to.
  *
  * Initializes a control urb with the proper information needed to submit
  * it to a device.
+ *
+ * The transfer buffer and the setup_packet buffer will most likely be filled
+ * via DMA. The simplest way to get a buffer that can be DMAed to is
+ * allocating it via kmalloc() or equivalent, even for very small buffers.
+ * If the buffers are embedded in a bigger structure, there is a risk that
+ * the buffer itself, the previous field and/or the next field are corrupted
+ * due to cache incoherencies; or slowed down if they are evicted from the
+ * cache.
+ *
  */
 static inline void usb_fill_control_urb(struct urb *urb,
 					struct usb_device *dev,
@@ -1658,13 +1669,17 @@ static inline void usb_fill_control_urb(struct urb *urb,
  * @urb: pointer to the urb to initialize.
  * @dev: pointer to the struct usb_device for this urb.
  * @pipe: the endpoint pipe
- * @transfer_buffer: pointer to the transfer buffer
+ * @transfer_buffer: pointer to the transfer buffer. The buffer must be
+ *	suitable for DMA.
  * @buffer_length: length of the transfer buffer
  * @complete_fn: pointer to the usb_complete_t function
  * @context: what to set the urb context to.
  *
  * Initializes a bulk urb with the proper information needed to submit it
  * to a device.
+ *
+ * Please refer to usb_fill_control_urb() for a description of the
+ * requirements for transfer_buffer.
  */
 static inline void usb_fill_bulk_urb(struct urb *urb,
 				     struct usb_device *dev,
@@ -1687,7 +1702,8 @@ static inline void usb_fill_bulk_urb(struct urb *urb,
  * @urb: pointer to the urb to initialize.
  * @dev: pointer to the struct usb_device for this urb.
  * @pipe: the endpoint pipe
- * @transfer_buffer: pointer to the transfer buffer
+ * @transfer_buffer: pointer to the transfer buffer. The buffer must be
+ *	suitable for DMA.
  * @buffer_length: length of the transfer buffer
  * @complete_fn: pointer to the usb_complete_t function
  * @context: what to set the urb context to.
@@ -1697,6 +1713,9 @@ static inline void usb_fill_bulk_urb(struct urb *urb,
  * Initializes a interrupt urb with the proper information needed to submit
  * it to a device.
  *
+ * Please refer to usb_fill_control_urb() for a description of the
+ * requirements for transfer_buffer.
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
