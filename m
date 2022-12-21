Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FB3653713
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiLUTfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiLUTfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:35:01 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0EF240B4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:35:00 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m19so23417876edj.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZoaqwFfMJRYS6bjyWuTQdFret4zs82sAsNZ5sch7lg=;
        b=l8dSNhnqny8nMc5DjJfLRtvsmGg0ME7hV5iYRvg5w+eNZuDHHr4w0UEDd/9UQHDJof
         z3tGovwwNokBETmuD975+QLTOQB7s1p2vVrZKMpNi9/M67j13B5CVOedFbYouSsFxrqv
         zWDCb7nGV4QJXYD0HgitE0NWZjkMwCXeMoS4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZoaqwFfMJRYS6bjyWuTQdFret4zs82sAsNZ5sch7lg=;
        b=KnMwXjFL9UPve55yY1NbLwe0l7RQ3BXRkrgUK0sd6jjCT6V065YfKzFy+MJKMGfVmU
         wwMQvygMoWMPA/jhG/xdJ8hjJP1D+3OTVr96Bs33cXI5GRsXqMVUwho6qhiyfmvCUIle
         ZTiycQayJQ5k2A1fns8GxyzFr55F+DHkZa4I+SsQ9iME8VsrxzqrwFjuQAbiBDyL8a6/
         +BEMR70LhIQSE1ix+U2sWa166r1Sm5s1hAJhDmW+Hj+Ty1MUqIIFZWM3rvXDQ5Ho9Vc6
         TtB9NYI/O0fpT1t8BPrOp8svxxrgmDPPTxuWctQiNGHBATNPYbWpZbA5D4jUHacBmGOn
         Zf2w==
X-Gm-Message-State: AFqh2kqFzUyiOtEVZw/9C+VfqginCiXMvoZz2DrIf1R1SKBRuWqVMEqY
        qbv2/3T6MEfCyFF9iX26PAo71g==
X-Google-Smtp-Source: AMrXdXsi8t74Lm0ZkbpdGHxAtDQYMa5Relc63SBgfq5cCxhE4rxGmq+t4JAXA1mqzydpBqnP30uxog==
X-Received: by 2002:a05:6402:12d4:b0:45c:835c:c6d3 with SMTP id k20-20020a05640212d400b0045c835cc6d3mr2450625edx.4.1671651298986;
        Wed, 21 Dec 2022 11:34:58 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090618aa00b0082ddfb47d06sm3763748ejf.148.2022.12.21.11.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 11:34:58 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Dec 2022 20:34:51 +0100
Subject: [PATCH v4] USB: Improve usb_fill_* documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221220-usb-dmadoc-v4-0-74a045bf14f4@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Randy Dunlap <rdunlap@infradead.org>, linux-usb@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=5121; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=cwCTpwzbfFoWlRwkZxXRWPyS41WSzHGFXVWqG5IZyoI=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjo1/ct4dOAygrudSidqVGmm16+h6sFFIRGhBig1RD
 sHtuJiyJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6Nf3AAKCRDRN9E+zzrEiHitD/
 0QSyX7XZR1OgyrL0jRhCfZcbYreo8xbF84BlXTrq/KjfWcvCpyXYYHR+QETCxl+Qbi8amteAuwbWIh
 yHGu59apOeN7QQ6NwrvnfnfrEsqLQte6Y8k4FuOJ+paIeo27Rhp4Zzu3XDMZHwnWdK3f9QW2B0eZnJ
 cKtbbl1S4ptqShFzcKQsh020TMXwh7PsY13TubimzAxfOIB98lepw5EkhyRLxDJIhT1VqTNsIMt5oq
 m+y+/MibTOy1YBYwtC179qbF2DWvqtL0tRkzKypIdbFeDQf/nKNdb7HclOTTgU6xEmBytZp7B6a1Ek
 hrSFdQU4CzKBHdo7+wJPaSL2HB0GZJUI1QPg0X4tEXDgPy3kzyyHE989FlmlGH3G9v0ugBnl9hJWke
 Oc54L5kLhUgJzcCCofO5cZR4p/L3lybDdR0ZEfpaX09jfL+3ETG2xatA7i9urGVN3xHRDkkygDlifR
 o86ntB0zducsVZWKcSEJJ39isMzHHYmSL2/6gZz3C5uNo5Q7CjVPkllBNk3//adG2im3KXbPQV/JX1
 xTxil2N6AyfpvdBzOA8IG8viEw+RIA7XYLAKd7cUyDufrokP/fFPMmA+EZUmZ/5llrbojF7Q+KBnMv
 shl0fvxyCFdtCLEj1Gvc5s4GGUJ0lV87q1qkK+9WYu3GPJocqAwhC4fwF2DQ==
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Changes in v4:
- Unpolite version :P. Thanks Laurent!
- Make explicit reference to DMA in/out. Thanks Alan!
- Reference struct urb. Thanks Alan!
- Link to v3: https://lore.kernel.org/r/20221220-usb-dmadoc-v3-0-6009f4d27631@chromium.org

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
index 7d5325d47c45..4e98ebacec96 100644
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
+ * or read via DMA. The simplest way to get a buffer that can be DMAed to is
+ * allocating it via kmalloc() or equivalent, even for very small buffers.
+ * If the buffers are embedded in a bigger structure, there is a risk that
+ * the buffer itself, the previous fields and/or the next fields are corrupted
+ * due to cache incoherencies; or slowed down if they are evicted from the
+ * cache. For more information, check &struct urb.
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
+ * Refer to usb_fill_control_urb() for a description of the requirements for
+ * transfer_buffer.
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
+ * Refer to usb_fill_control_urb() for a description of the requirements for
+ * transfer_buffer.
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
