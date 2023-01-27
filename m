Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDA367F0E1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjA0WGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjA0WGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:06:50 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAED468F;
        Fri, 27 Jan 2023 14:06:48 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id s66so5289533oib.7;
        Fri, 27 Jan 2023 14:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDolccbyviYWRHRADLhQqX8cIwCJYGkq4bB0PFopkh8=;
        b=kbPiAPK/vpfOO8jg3cwnQZ50wKsPjaNC5CxiUcrrizvGSAV3vmz566lZK+txWlA2E9
         DeEWVzWjSfhGZ3ztpYJGpQGLHgwGKPQPGDcjs2F8deSDvLtzZRbiM3tdUu8NzthHmv28
         ZoLdnjCzk+uFqGhKJS6MSO5lbN5TRqRSGEjTqbGAHW4X4098WVGPm0stbkDzrw0k6GYq
         u8uC863a4v3BJAvpaR1IRfFHJPmSqlCDdqiT4vFuPodla/EElomnJXPjJo31McpCJgxb
         9k1pyzC6wiCfJyJlkQHPLmNvg6br4EsWmJcMhTTtfkw91/aNVRsdHG7JaxNBSBZQqWKV
         Of8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDolccbyviYWRHRADLhQqX8cIwCJYGkq4bB0PFopkh8=;
        b=CzWTpjeWyAclfGLnG0PBKbPayGErv8/uWF/SddzT/mD783QGdfJI3GOK4bF2LXrbUy
         OQh8CBdT0ixb3jwffwXUHV6laKjcsa/MXTkPDuDBlDYYi6WAuZfTpleYOz+NmxTq+sqC
         oziDIYGGTizjQBX9GgsmCiZLdbdIIIMwwTA8+JpjExMHi3kLZQ7mnVZcS6bNo5FgjKJN
         7/trUKGBloSjw6krgSsB13mPogpkVVYMwsN2ODnzyAEEqxLWh7mjq/aoxcGTOC1mXugP
         uQ1/P1zYO8ESOXWnSLfaa+NC5rR5wuyQ3oGMJUU5Y2ueX+eoqQAxstMCz5cKEYBFz6B2
         M7iQ==
X-Gm-Message-State: AO0yUKWDt7S0hg55kngrk0wXggLdtrDjf7r62T653pcXog2Y1E+VdsqX
        211GxXOcYjjEVT8oexmwrw4yiaWvfzTh/WyO
X-Google-Smtp-Source: AK7set9RqN688S7fkIeiywT2MHiCrEz0VRsUvqqo1k7CbcpgaSMqdyKbE1eHCHdSyKc8CHdwNY/yFQ==
X-Received: by 2002:a54:440b:0:b0:364:7618:8d1e with SMTP id k11-20020a54440b000000b0036476188d1emr3117165oiw.34.1674857207258;
        Fri, 27 Jan 2023 14:06:47 -0800 (PST)
Received: from [192.168.50.134] (99-176-3-182.lightspeed.brhmal.sbcglobal.net. [99.176.3.182])
        by smtp.gmail.com with ESMTPSA id v66-20020acade45000000b00369ec58932csm2059424oig.45.2023.01.27.14.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 14:06:46 -0800 (PST)
Message-ID: <4fc782ec-e1f7-3b89-5be9-d5b7bab5c4d3@gmail.com>
Date:   Fri, 27 Jan 2023 16:06:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] HID: quirks: Add quirk for Logitech G923 Xbox steering
 wheel
From:   Walt Holman <waltholman09@gmail.com>
To:     linux-input <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
References: <823df262-aa1d-4340-666f-07b991fce64b@gmail.com>
Content-Language: en-US
In-Reply-To: <823df262-aa1d-4340-666f-07b991fce64b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/23 16:03, Walt Holman wrote:
> Hello,
> 
> This patch adds support for the Logitech G923 Xbox edition steering
> wheel.
> 
> -Walt
> 
> diff -uprN linux-master-source/drivers/hid/hid-ids.h linux-master-target/drivers/hid/hid-ids.h
> --- linux-master-source/drivers/hid/hid-ids.h    2023-01-27 15:18:14.000000000 -0600
> +++ linux-master-target/drivers/hid/hid-ids.h    2023-01-27 15:50:24.077639994 -0600
> @@ -819,6 +819,7 @@
>   #define USB_DEVICE_ID_LOGITECH_G510_USB_AUDIO    0xc22e
>   #define USB_DEVICE_ID_LOGITECH_G29_WHEEL    0xc24f
>   #define USB_DEVICE_ID_LOGITECH_G920_WHEEL    0xc262
> +#define USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL    0xc26e
>   #define USB_DEVICE_ID_LOGITECH_WINGMAN_F3D    0xc283
>   #define USB_DEVICE_ID_LOGITECH_FORCE3D_PRO    0xc286
>   #define USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940    0xc287
> diff -uprN linux-master-source/drivers/hid/hid-logitech-hidpp.c linux-master-target/drivers/hid/hid-logitech-hidpp.c
> --- linux-master-source/drivers/hid/hid-logitech-hidpp.c    2023-01-27 15:18:14.000000000 -0600
> +++ linux-master-target/drivers/hid/hid-logitech-hidpp.c    2023-01-27 15:50:24.077639994 -0600
> @@ -4347,6 +4347,9 @@ static const struct hid_device_id hidpp_
>       { /* Logitech G920 Wheel over USB */
>         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
>           .driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
> +    { /* Logitech G923 Wheel (Xbox version) over USB */
> +      HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL),
> +        .driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS },
>       { /* Logitech G Pro Gaming Mouse over USB */
>         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
> 
Signed off by: Walt Holman (waltholman09@gmail.com)

