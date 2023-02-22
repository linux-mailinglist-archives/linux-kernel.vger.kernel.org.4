Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D664A69F0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjBVI7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjBVI7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:59:23 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E37F2887F;
        Wed, 22 Feb 2023 00:59:21 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id by8so2090770ljb.7;
        Wed, 22 Feb 2023 00:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYBLuJf6BcEUWXhCo3wBJ1s4P4dd04MYj6QFSsuW9DE=;
        b=Y/f248EJDz3awMnPMjAtxFAFxQ3ISL9ugI7Ej3L3EZLPtonTiYIu2I65R3XPYr4OkK
         NPFryvloAEqp2PTZrDTIGHKIshUb3bw52dKnmT4Dr2NiALyCa5iBH7pi41m999SsFe+i
         pBWPmIl+AQLYo/27dPlG4eBsGy2x0HpuYN6FS1Z+QuwWIKKK/roCk7YZJ/RxROicc/Sw
         kcIzYhefClN5MDS7XLVLjN4QdM0SG6hU2hdT1FenUnFXruEOo+N2dKZSLw9snarmzdda
         J7hcHUg/WYflih2uhiN55TN4oUDQfnL0mX9kPyDVZNctdax13UVhT+jz0DplAK7IwtLk
         l5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYBLuJf6BcEUWXhCo3wBJ1s4P4dd04MYj6QFSsuW9DE=;
        b=Gr9U+IxpxoJYRrfj0wTOF8Fx0LI8ytqMXa5qibr2XmGZZRcwAtln3De5tLsscN6at9
         v+d0AL5tu/NSsa48mJS+pNJH+PC++jaraHsklrrAg7SToEPRHWFpypL98HNwQzdoNkw1
         oG41PEdj/cheG9S3IPdhgZZHIek6k+YD7NsNlkrqGG7G6zd+vY88yGOzgghcqy/pb+T7
         ObzE7FaTBvsN+mwr4lDHT0Dvhdq1mhpNRb//8VWyiviIdjpDL6Z5NjrmLdjA0s6oIJYo
         ehpB144p1riuOHk9RFeq/BWTyrO0O/6Oy3PqVDLiBag36VuvAyA81r2JJpntmQ6pF/uZ
         Utmg==
X-Gm-Message-State: AO0yUKUtgPihoTQXOXQExjHRtxS7d7o2CogUh1wB3Uy5DWq9eeVj1mF7
        z2r7oOP5uoPZtwog0VVRWmmMDUORNxY=
X-Google-Smtp-Source: AK7set/EzukJccW3HCNq87kiYv0+/nQkkxq54hxg8Ohfj+JjAuwe4M9qswCOn7h/LqqlBhRCHJYEBg==
X-Received: by 2002:a2e:80c7:0:b0:293:4e6d:9194 with SMTP id r7-20020a2e80c7000000b002934e6d9194mr2901827ljg.24.1677056359335;
        Wed, 22 Feb 2023 00:59:19 -0800 (PST)
Received: from [192.168.1.103] ([31.173.81.9])
        by smtp.gmail.com with ESMTPSA id f13-20020a2ea0cd000000b00290716d65dcsm836354ljm.136.2023.02.22.00.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 00:59:18 -0800 (PST)
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
To:     Michael Wu <michael@allwinnertech.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230222013944.31095-1-michael@allwinnertech.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <0b6f1b7b-9275-6947-b1b9-73d60ce095ab@gmail.com>
Date:   Wed, 22 Feb 2023 11:59:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230222013944.31095-1-michael@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 2/22/23 4:39 AM, Michael Wu wrote:

> This patch fixes a problem that USB mouse can't wake up the device that
> enters standby.
> 
> At present, the kernel only checks whether certain USB manufacturers
> support wake-up, which will easily cause inconvenience to the
> development work of other manufacturers and add unnecessary work to the
> maintenance of kernel.
> 
> The USB protocol supports judging whether a usb supports the wake-up
> function, so it should be more reasonable to add a wake-up source by
> directly checking the settings from the USB protocol.
> 
> There was a similar issue on the keyboard before, which was fixed by
> this patch (3d61510f4eca), but now the problem happened on the mouse.
> This patch uses a similar idea to fix this problem.
> 
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>  drivers/hid/usbhid/hid-core.c | 8 ++++++++
>  drivers/hid/usbhid/usbmouse.c | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index be4c731aaa65..d3a6755cca09 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1189,6 +1189,14 @@ static int usbhid_start(struct hid_device *hid)
>  		device_set_wakeup_enable(&dev->dev, 1);
>  	}
>  
> +	/**

   The kernel-doc comments should not be used here in the function body.

> +	 * NOTE: enable remote wakeup by default for all mouse devices
> +	 * supporting the boot protocol.
> +	 */
> +	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
> +	    interface->desc.bInterfaceProtocol == USB_INTERFACE_PROTOCOL_MOUSE)
> +		device_set_wakeup_enable(&dev->dev, 1);
> +
>  	mutex_unlock(&usbhid->mutex);
>  	return 0;
>  
[...]

MBR, Sergey
