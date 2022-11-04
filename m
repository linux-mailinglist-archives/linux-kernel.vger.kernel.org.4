Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EAE619E4A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiKDRQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiKDRQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:16:42 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D253E0AF;
        Fri,  4 Nov 2022 10:16:39 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id v3so4910785pgh.4;
        Fri, 04 Nov 2022 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6xstQC+oWBeL9AwJF0jL3DBXjH1eGPpeBG49uXCkMc=;
        b=Ghil2qaj38t6smkETB1K9BXz0DmrVNVi9yXIXDoDSKDnadi3OpTbUWhA7SK69bzEwI
         DR13bjWvIrDDunwYvpDndcJqX7us7Kr1TeZeh1zQZ5aZgturlor6ik/JoKO21iKmjMCe
         xlUXwuCJwGXHUdW7ZiGS+Xtc9pjxejTiHp7Lhc7aarG4zyDLcgnzR3OO7WN6pn3H8O1s
         a9sVNJnXL7zLxoQUf72YMUa+TzZUF6KiE/UcuNuB0Kn7mRZ8taOImBLNBrDYCj53epsn
         hLuD39Mn1iMLo1eucyN7gX9AgKga2QLoLYEag4Pk7i24p3MglepXq9Dis1lmh5DxFRCb
         Y/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c6xstQC+oWBeL9AwJF0jL3DBXjH1eGPpeBG49uXCkMc=;
        b=FcdbP5DPviT+OcczJwUUiClLh8vz9FkZW+GRNCjzlDjo1rSfY/aF16oDDM8mDzhzUU
         OWhidvy+MjlYIXGASluGrLUjhe5sokJ+gJscPukd0M+5nR2aMVX0oUS3yOVjmyx2bKDF
         kHEzXz166j+ZfVHvOoNUPpoqH+7dWIXBe4lruSuVJ83OsXfPF7COVUpVEHzoPyVKN6RY
         FQUxqqtClcWXaxm4WGnEzvj/NpwcgBw3tSelpeFhp0afaPh3khZDAejQ6TiZM/mLrXO8
         wxswWdY1T4O17h4GwM2GikWgpdo0a7LMd8QAIa5IwLDLn/JF4ZtoKh8spzSNigHCheQp
         ES2A==
X-Gm-Message-State: ACrzQf310acscScZ/DOIQOvh7dGDv8eMq+W7jz+TG0KzVEgEBUqX6fRp
        Z4RxZausvr+ea0BN5mhAvvWPo1m5ISY=
X-Google-Smtp-Source: AMsMyM5sTalN9uMJUZEgasHiM/dXo/Fo6ANaOopl9ap2qtuUp9Yc6AD73GpyzPRE5DF5UvOKz1YyKQ==
X-Received: by 2002:a63:1303:0:b0:46f:b44b:3519 with SMTP id i3-20020a631303000000b0046fb44b3519mr25169879pgl.278.1667582199111;
        Fri, 04 Nov 2022 10:16:39 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090a450f00b00212c27abcaesm1917655pjg.17.2022.11.04.10.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 10:16:38 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 1/3] USB: core: export usb_cache_string()
Date:   Sat,  5 Nov 2022 02:16:02 +0900
Message-Id: <20221104171604.24052-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221104171604.24052-1-mailhol.vincent@wanadoo.fr>
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-1-mailhol.vincent@wanadoo.fr>
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

usb_cache_string() can also be useful for the drivers so export it.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/usb/core/message.c | 1 +
 drivers/usb/core/usb.h     | 1 -
 include/linux/usb.h        | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 4d59d927ae3e..127fac1af676 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1037,6 +1037,7 @@ char *usb_cache_string(struct usb_device *udev, int index)
 	}
 	return smallbuf;
 }
+EXPORT_SYMBOL_GPL(usb_cache_string);
 
 /*
  * usb_get_device_descriptor - (re)reads the device descriptor (usbcore)
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 82538daac8b8..0eac7d4285d1 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -47,7 +47,6 @@ extern int usb_get_device_descriptor(struct usb_device *dev,
 extern int usb_set_isoch_delay(struct usb_device *dev);
 extern int usb_get_bos_descriptor(struct usb_device *dev);
 extern void usb_release_bos_descriptor(struct usb_device *dev);
-extern char *usb_cache_string(struct usb_device *udev, int index);
 extern int usb_set_configuration(struct usb_device *dev, int configuration);
 extern int usb_choose_configuration(struct usb_device *udev);
 extern int usb_generic_driver_probe(struct usb_device *udev);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 9ff1ad4dfad1..d2d2f41052c0 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1829,6 +1829,7 @@ static inline int usb_get_ptm_status(struct usb_device *dev, void *data)
 
 extern int usb_string(struct usb_device *dev, int index,
 	char *buf, size_t size);
+extern char *usb_cache_string(struct usb_device *udev, int index);
 
 /* wrappers that also update important state inside usbcore */
 extern int usb_clear_halt(struct usb_device *dev, int pipe);
-- 
2.37.4

