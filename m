Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCBE63A616
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiK1KaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiK1KaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:30:06 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A994C2652;
        Mon, 28 Nov 2022 02:30:05 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 9so9996957pfx.11;
        Mon, 28 Nov 2022 02:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5WzP7R2JeezWg+hdV7Tba+xSsA1ik5Dm+MRW5DkF9e0=;
        b=oo6qzQAScY8kGVYAXKK32Is/cCaVa66uXHZDaSQmZr/Hhd/EJkvBIw+I6TTKnFPD4g
         rpAxJ70A3QLcsQgRjI/Ae0OpewommAkpkFRRT0/wMTwUwQBJmBx9SgOJ5MqTnF05Bp1q
         lF2t7G8KbJELoHEncLL0XRY1b0Noj9Q7tkpmes4QLi5Q/YJmJ9zSe0ML/CdlzeiYIFNS
         M6DnCCBQMTxsDUwv2vNpX+3yDnWkIdE2C8jjVlps8giI1f621NbsIokmqgW4rflA2div
         ++iI6URjCndHsPV6QwW68yxDtBJlk1lZkHW3zg7eiioJevvhlLjA8btnKeZAGSLYNgg+
         BCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WzP7R2JeezWg+hdV7Tba+xSsA1ik5Dm+MRW5DkF9e0=;
        b=RqJyOr694jN8zALa1JwMlmIuHENyKlZwwYiNrvBxj64L2emz/Wvd+Ny0YQ/lEPFqj/
         HWm7oZ1CZJoLqjcc4eVGi6cGrPNG1Y1++LAsS26dQmbPQmmtGBAZ5hB4CiF8yKfaH1ir
         OUCOQv3oLBdypSWIpLP0XW0Q0YgGS8HF9iE8IRKjVIRXfbP5QfBC4bJp+cRJ2NdrwLLN
         xVnmqoUZaQEmd9BVmc7oJ9uNRHf5rsWWoF767/j3PojeW5MLTi7GF3vI8icNP30xT8MN
         ukB8xuWtAp58x1C5w1Wfr9FHsBHaAYH6C2U7NkJ4VRpO6GVOQxz6cZw+gPzDqZxFHMJz
         aaJw==
X-Gm-Message-State: ANoB5pl+gx4lmRcASSEJml2UDD2m55gJTLqhB8ggh2uUuj89v+9nn40U
        rjZjlJuHKIYHGLBgZQGS6kk=
X-Google-Smtp-Source: AA0mqf7FESvloU60JlBI3tZKvkhKNAlGtFZmq/3ukpDw+KhHUdJBWFh/014hM6rAO7cBKe8PCTysuw==
X-Received: by 2002:a05:6a00:a88:b0:574:2c5e:b18c with SMTP id b8-20020a056a000a8800b005742c5eb18cmr27847828pfl.10.1669631405115;
        Mon, 28 Nov 2022 02:30:05 -0800 (PST)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id iw14-20020a170903044e00b001869f2120a4sm8519954plb.94.2022.11.28.02.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 02:30:04 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] usb: add usb_set_intfdata() documentation
Date:   Mon, 28 Nov 2022 19:29:54 +0900
Message-Id: <20221128102954.3615579-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB drivers do not need to call usb_set_intfdata(intf, NULL) in their
usb_driver::disconnect callback because the core already does it in [1].

However, this fact is widely unknown, c.f.:

  $ git grep "usb_set_intfdata(.*NULL)" | wc -l
  215

Especially, setting the interface to NULL before all action completed
can result in a NULL pointer dereference. Not calling
usb_set_intfdata() at all in disconnect() is the safest method.

Add documentation to usb_set_intfdata() to clarify this point.

Also remove the call in usb-skeletion's disconnect() not to confuse
the new comers.

[1] function usb_unbind_interface() from drivers/usb/core/driver.c
Link: https://elixir.bootlin.com/linux/v6.0/source/drivers/usb/core/driver.c#L497

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/usb/usb-skeleton.c |  1 -
 include/linux/usb.h        | 12 ++++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
index d87deee3e26e..900a64ad25e4 100644
--- a/drivers/usb/usb-skeleton.c
+++ b/drivers/usb/usb-skeleton.c
@@ -564,7 +564,6 @@ static void skel_disconnect(struct usb_interface *interface)
 	int minor = interface->minor;
 
 	dev = usb_get_intfdata(interface);
-	usb_set_intfdata(interface, NULL);
 
 	/* give back our minor */
 	usb_deregister_dev(interface, &skel_class);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 9ff1ad4dfad1..d4afeeec1e1a 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -265,6 +265,18 @@ static inline void *usb_get_intfdata(struct usb_interface *intf)
 	return dev_get_drvdata(&intf->dev);
 }
 
+/**
+ * usb_set_intfdata() - associate driver-specific data with the interface
+ * @intf: the usb interface
+ * @data: pointer to the device priv structure or %NULL
+ *
+ * Drivers should use this function in their probe() to associate their
+ * driver-specific data with the usb interface.
+ *
+ * When disconnecting, the core will take care of setting @intf back to %NULL,
+ * so no actions are needed on the driver side. The interface should not be set
+ * to %NULL before all actions completed (e.g. no outsanding URB remaining).
+ */
 static inline void usb_set_intfdata(struct usb_interface *intf, void *data)
 {
 	dev_set_drvdata(&intf->dev, data);
-- 
2.25.1

