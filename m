Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7D466652B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 21:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjAKU7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 15:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbjAKU7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 15:59:02 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89DC60DC;
        Wed, 11 Jan 2023 12:58:58 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id j15so9369993qtv.4;
        Wed, 11 Jan 2023 12:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhiaCs8Yrw8BBKN22ZfMUGXFz70szjaM7XSx2isDBd0=;
        b=nnpV7JTuWnvYOLcgHmuIjXmPhPMZ2gYTcflG39feZhBy0hZWH8kvGvqdU4ks82w6VX
         pmB7MXbNmTHfJgEV+8DI2C8RwlwCnh0cDURpkS488gGBRiZN8U8KNYKoVY17CY/1hCTa
         rrbxqtmQ9glIl51yh5DddycP87OvggdJqsD1Ju25svaWbgtuiIJdVuiyO/X5KHEjW9rV
         X+wcI+Iq3elmugzGol0x47MLu8/8huqIqCMQS1CS0ou0VwpB1CQMTZJn9GrzpyDYBxzF
         zmUksAOOqkNcA7DYzqeyL6wOACws6FWPyXdIK4zPGvSMmWxHgFKtsbdrSBJlyaqOcakg
         R8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GhiaCs8Yrw8BBKN22ZfMUGXFz70szjaM7XSx2isDBd0=;
        b=MavpHZl2VHHSGOxQ78UbqyWSMm8vz5Uhh4b+zzq1WUaOouTr79yv15/1l0W6EC5DXW
         1xnOCuQ4S+c2MWChUOwf71WTYPGP9g/uzuFLf8sUwucWIvuipo1wVLiblUaL1goEuRUx
         3e5JYJUe8n4ML1HP5ritEfXT58fkKqcEstwPQIqbdOyPWijvC/FmK6m4w7NVBBrHuqs+
         EqAiJihHTmeeaQnVxIvAfQMaeP7EJZIu1uk0ztci0vchGZT8s35kyW00Y/iHddAGvewb
         3iYhpuDm6Hxu7/rkXnttP2tLkhd4hvGvjaR+lU6PFrXo9k1OT5qviA7NsFzaxqAijzZf
         TxnQ==
X-Gm-Message-State: AFqh2krO+Nhi7ZtAxjjVZCYsTyM42d6Nvp6mc80wmlq2dEVfY9LhmEcy
        4BmbHM3mgEEjcJnTS2JlUArElFc2txfzZmkl
X-Google-Smtp-Source: AMrXdXtlAX9o/eUB+Hgc0EJbaOqzTjq7QYK4ZUmOcuR18O+C6BGDz1K+7DEPi4ZdaPa39hbI0QtMLw==
X-Received: by 2002:ac8:7216:0:b0:3af:65f5:607b with SMTP id a22-20020ac87216000000b003af65f5607bmr10918197qtp.55.1673470737532;
        Wed, 11 Jan 2023 12:58:57 -0800 (PST)
Received: from [192.168.50.134] (99-176-3-182.lightspeed.brhmal.sbcglobal.net. [99.176.3.182])
        by smtp.gmail.com with ESMTPSA id d15-20020a05620a140f00b006fc92cf4703sm9462260qkj.132.2023.01.11.12.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 12:58:57 -0800 (PST)
Message-ID: <7699e1c6-efe1-ac90-d054-f983d9d46735@gmail.com>
Date:   Wed, 11 Jan 2023 14:58:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>
From:   Walt Holman <waltholman09@gmail.com>
Subject: [PATCH] HID: hid-logitech-hidpp: Add support for Logitech G923 wheel
 Xbox Edition (Take 2)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds support for the Logitech G923 Xbox edition steering wheel. This uses the hid-logitech-hidpp kernel module and from my testing, force feedback and all buttons work. This requires the usb_modeswitch application to setup the device in PC mode with a magic string that is the same as the Logitech 920 wheel.

Signed-off-by: Walt Holman waltholman09@gmail.com

diff -uprN linux-6.2-rc3-source/drivers/hid/hid-ids.h linux-6.2-rc3-target/drivers/hid/hid-ids.h
--- linux-6.2-rc3-source/drivers/hid/hid-ids.h	2023-01-10 15:03:06.000000000 -0600
+++ linux-6.2-rc3-target/drivers/hid/hid-ids.h	2023-01-11 13:19:39.460052754 -0600
@@ -820,6 +820,7 @@
  #define USB_DEVICE_ID_LOGITECH_G510_USB_AUDIO	0xc22e
  #define USB_DEVICE_ID_LOGITECH_G29_WHEEL	0xc24f
  #define USB_DEVICE_ID_LOGITECH_G920_WHEEL	0xc262
+#define USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL	0xc26e
  #define USB_DEVICE_ID_LOGITECH_WINGMAN_F3D	0xc283
  #define USB_DEVICE_ID_LOGITECH_FORCE3D_PRO	0xc286
  #define USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940	0xc287
diff -uprN linux-6.2-rc3-source/drivers/hid/hid-logitech-hidpp.c linux-6.2-rc3-target/drivers/hid/hid-logitech-hidpp.c
--- linux-6.2-rc3-source/drivers/hid/hid-logitech-hidpp.c	2023-01-10 15:03:06.000000000 -0600
+++ linux-6.2-rc3-target/drivers/hid/hid-logitech-hidpp.c	2023-01-11 13:19:39.460052754 -0600
@@ -4347,6 +4347,9 @@ static const struct hid_device_id hidpp_
  	{ /* Logitech G920 Wheel over USB */
  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
  		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
+	{ /* Logitech G923 Wheel (Xbox version) over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL),
+		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS },
  	{ /* Logitech G Pro Gaming Mouse over USB */
  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
  
