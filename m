Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84D774E3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGKBrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGKBrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:47:10 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF55B6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 18:47:09 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R0Nyy56hXzBHXhh
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:47:06 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689040026; x=1691632027; bh=LYFY2WDG0zIapsZ2YROEas0Ehkx
        KV4EYA8XnurMch/Y=; b=vqadKmLAcmv0jUd9fNwZMg+jZXZ+dy32ehLGBQZvdBL
        RzRIUXA2CxnlU6cpKMnWIkxdFUol2hZrvtSd4t4FlipEPEuTvh93/pBlfbZQraqj
        3sItKBlB09iwomMEr8MGnBwvAz7NZu9iwI4wJDXaaRDqb+a9hVhBd/6Thlu34Yin
        e/90rqnYm3hvzN8poQxA8Uc+0RKQsgVuIiMNDbnZdKgNgxFEVN3WcFXqKn6IOxMq
        Ezx2Ce3UqN1QD6T7n81YsbrcFJUTlFzadSkwqDE76S/RZzrZal0NXGsry+MWBYyV
        If4kRvDmxoOcNPvTacuMU/D/JnRCMQbTlEBsa5n55rg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IXXpjk9-ah_i for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jul 2023 09:47:06 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R0Nyy28tFzBHXh5;
        Tue, 11 Jul 2023 09:47:06 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 11 Jul 2023 09:47:06 +0800
From:   wuyonggang001@208suo.com
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: usbhid: Fix use assignment in if condition
In-Reply-To: <20230711014359.11991-1-zhanglibing@cdjrlc.com>
References: <20230711014359.11991-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <a4ca3852846e220cf378a664cf1c6213@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch error(s):

drivers/hid/usbhid/usbkbd.c:238:240:242:246: ERROR: do not use 
assignment in if condition

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  drivers/hid/usbhid/usbkbd.c | 24 +++++++++++++++++++-----
  1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
index c439ed2f16db..cde7f82b7070 100644
--- a/drivers/hid/usbhid/usbkbd.c
+++ b/drivers/hid/usbhid/usbkbd.c
@@ -235,15 +235,29 @@ static void usb_kbd_close(struct input_dev *dev)

  static int usb_kbd_alloc_mem(struct usb_device *dev, struct usb_kbd 
*kbd)
  {
-    if (!(kbd->irq = usb_alloc_urb(0, GFP_KERNEL)))
+    kbd->irq = usb_alloc_urb(0, GFP_KERNEL)
+
+    if (!kbd->irq)
          return -1;
-    if (!(kbd->led = usb_alloc_urb(0, GFP_KERNEL)))
+
+    kbd->led = usb_alloc_urb(0, GFP_KERNEL)
+
+    if (!kbd->led)
          return -1;
-    if (!(kbd->new = usb_alloc_coherent(dev, 8, GFP_KERNEL, 
&kbd->new_dma)))
+
+    kbd->new = usb_alloc_coherent(dev, 8, GFP_KERNEL, &kbd->new_dma)
+
+    if (!kbd->new)
          return -1;
-    if (!(kbd->cr = kmalloc(sizeof(struct usb_ctrlrequest), 
GFP_KERNEL)))
+
+    kbd->cr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL)
+
+    if (!kbd->cr)
          return -1;
-    if (!(kbd->leds = usb_alloc_coherent(dev, 1, GFP_KERNEL, 
&kbd->leds_dma)))
+
+    kbd->leds = usb_alloc_coherent(dev, 1, GFP_KERNEL, &kbd->leds_dma)
+
+    if (!kbd->leds)
          return -1;

      return 0;
