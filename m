Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE0867B8A0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbjAYRbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjAYRbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:31:50 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3339914E9C;
        Wed, 25 Jan 2023 09:31:48 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id u8so9017344ilq.13;
        Wed, 25 Jan 2023 09:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NtTqLiJvxwVV55x1IGiHg4bkp14WzNiHGHlvSCBuiY0=;
        b=YOSZ3WeL5e1yj/iFO7N6GwJsD5cOGS41sDZINhA2LatEiHahcSbRN5SdjHDr30CR59
         4bOB3fn0N06UVMRJPwlraOw3hfaWxLepH/Y5edHPCfiqwrwWFeQRqw7XQ0SggvVQZRzr
         nJ5x00Age2sB3I2hjxu+sdqvU70a3R2NBQDRSm71oqXKbla52VH7+l2PJTTjhSbJsYfV
         aqArXreHAGCtx+B+st+KimPS8mbU2x5xNa0whm8ZLc/xPHhBknkKP+0bV4/tbSTR3fBB
         f9nZtCEi9FoB3g3QbZL+DHFu7uxEhddwJKBI/G6h2+MIlYEZXA+rHJ/GFtrA92rbWAY4
         tLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NtTqLiJvxwVV55x1IGiHg4bkp14WzNiHGHlvSCBuiY0=;
        b=wohs0CUV1izwKoxV+6AlJS3NkYPkQt+0eOC0c6O50oCTTVKhhRCb0ld6vTH0iAuqbs
         mXu0VHQQt2asgSk0YTBHvonNnCI9Wo9z1bB39mdefVitaWrwzIXWcw+o7WQRjvSUQTXV
         eyOlr/ECONTfILnN+gt6eZwrtDud/of/p/WGdSjehVdV1yukynSJnijkurySmMSayPJv
         qnydz4rFVo1OStsVakV0EyFPan0QD6mepJzsRfrcTLPyj2pABUW2XvqUsgrwnkuYgsTO
         tn0tG3f0X83K3Ihl7akiwI2eb2fxLtumE2dW7D8zw/o7h/PO0YsaZge2fLLh8dzbrjfq
         l4uA==
X-Gm-Message-State: AO0yUKVIe5W2PVTNisR6giWrP9VIb0sb3TA+V+4NHUbL+s9fItpNnDQv
        t9rFvpGkxjUytnmFEE5nkEYFMLM9OQp6E2aNstRQw22z7SM=
X-Google-Smtp-Source: AK7set9HHiqePNy4b+qndL8Ur702tQb8cpO4DAFf9iYo1OEEnaCUYHdsA0CAOCNh+Z+aVC1BArxwpg1cr/uCEqUKF4g=
X-Received: by 2002:a92:503:0:b0:310:a1f1:8e09 with SMTP id
 q3-20020a920503000000b00310a1f18e09mr393180ile.180.1674667907378; Wed, 25 Jan
 2023 09:31:47 -0800 (PST)
MIME-Version: 1.0
References: <20230125143425.85268-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230125143425.85268-1-andriy.shevchenko@linux.intel.com>
From:   =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>
Date:   Wed, 25 Jan 2023 18:31:36 +0100
Message-ID: <CAMUOyH2Kc6hL4564sYDZdGRjiJJYmDA5WXEsF92p_xN8iZGMsg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] usb: gadget: Use correct APIs and data types for
 UUID handling
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 3:34 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> We have two types for UUIDs depending on the byte ordering.
> Instead of explaining how bytes should go over the wire,
> use dedicated APIs and data types. This removes a confusion
> over the byte ordering.

Thanks for pointing this out. I was unaware of the exact UUID
functions, as I'm still quite a newbie here.

I compiled and tested your patch in my test setup and it works perfectly.

>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/usb/gadget/composite.c | 4 ++--
>  include/linux/usb/webusb.h     | 9 +++------
>  2 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index 8e2603688016..fa7dd6cf014d 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -829,7 +829,7 @@ static int bos_desc(struct usb_composite_dev *cdev)
>         if (cdev->use_webusb) {
>                 struct usb_plat_dev_cap_descriptor *webusb_cap;
>                 struct usb_webusb_cap_data *webusb_cap_data;
> -               uuid_t webusb_uuid = WEBUSB_UUID;
> +               guid_t webusb_uuid = WEBUSB_UUID;
>
>                 webusb_cap = cdev->req->buf + le16_to_cpu(bos->wTotalLength);
>                 webusb_cap_data = (struct usb_webusb_cap_data *) webusb_cap->CapabilityData;
> @@ -841,7 +841,7 @@ static int bos_desc(struct usb_composite_dev *cdev)
>                 webusb_cap->bDescriptorType = USB_DT_DEVICE_CAPABILITY;
>                 webusb_cap->bDevCapabilityType = USB_PLAT_DEV_CAP_TYPE;
>                 webusb_cap->bReserved = 0;
> -               export_uuid(webusb_cap->UUID, &webusb_uuid);
> +               export_guid(webusb_cap->UUID, &webusb_uuid);
>
>                 if (cdev->bcd_webusb_version != 0)
>                         webusb_cap_data->bcdVersion = cpu_to_le16(cdev->bcd_webusb_version);
> diff --git a/include/linux/usb/webusb.h b/include/linux/usb/webusb.h
> index b430d84357f3..fe43020b4a48 100644
> --- a/include/linux/usb/webusb.h
> +++ b/include/linux/usb/webusb.h
> @@ -11,15 +11,12 @@
>  #include "uapi/linux/usb/ch9.h"
>
>  /*
> - * little endian PlatformCapablityUUID for WebUSB
> + * Little Endian PlatformCapablityUUID for WebUSB
>   * 3408b638-09a9-47a0-8bfd-a0768815b665
> - * to identify Platform Device Capability descriptors as referring to WebUSB
> - *
> - * the UUID above MUST be sent over the wire as the byte sequence:
> - * {0x38, 0xB6, 0x08, 0x34, 0xA9, 0x09, 0xA0, 0x47, 0x8B, 0xFD, 0xA0, 0x76, 0x88, 0x15, 0xB6, 0x65}.

This is actually explicitly spelled out this way in the specification:
https://wicg.github.io/webusb/#webusb-platform-capability-descriptor

But I agree, the way you rewrote it is much clearer!

> + * to identify Platform Device Capability descriptors as referring to WebUSB.
>   */
>  #define WEBUSB_UUID \
> -       UUID_INIT(0x38b60834, 0xa909, 0xa047, 0x8b, 0xfd, 0xa0, 0x76, 0x88, 0x15, 0xb6, 0x65)
> +       GUID_INIT(0x3408b638, 0x09a9, 0x47a0, 0x8b, 0xfd, 0xa0, 0x76, 0x88, 0x15, 0xb6, 0x65)

Yes, this is definitely more readable.

>
>  /*
>   * WebUSB Platform Capability data
> --
> 2.39.0
>
