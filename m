Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD5C7189F0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjEaTQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEaTQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:16:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA2F123;
        Wed, 31 May 2023 12:16:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b02085bf8dso297405ad.0;
        Wed, 31 May 2023 12:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685560603; x=1688152603;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltfS0BB7wJ01OSCaP3DNx6PnS23q4qJcef8LZjDK1NA=;
        b=eFHQWNhnZvTTE1EzR+Qkky5D3rM6kxveg0Kf9c8gw5xGMIpWbsQqKOdNYHi+4TIgaQ
         1mGcyWitcgS3S6k96Qy3D5P6rTNf62pp4N8085jDC8KEyJ1z32vC3jyibsuk03g7GztF
         bP5Y8oLUvaiH815dH0ckfSeW238lf225WwQ/3SATQg9Lx/fct2lgbrZ7keFIHaqJe9Zw
         L+5pwgbLSQzkyAqnZMfV84TEUSQaNOJgZkUWVYqZuHw0fIOg3SwEGPry8UcY9defn2aC
         fgXwxPb6lfysT9naFw1AD2zM5KeQkGf+vrPPq+SH6sB9U8uCGJfIcoFvv8PH3wpqvSmz
         ZafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685560603; x=1688152603;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltfS0BB7wJ01OSCaP3DNx6PnS23q4qJcef8LZjDK1NA=;
        b=YVa751nDgWnmQ70rUqVZ8huOEs/sQfDq41YTK8yxW51JpwawzCtDVgPeZgvGqbs8kv
         yExkMEa0p/U4wZ11t+wJ6ea1NAK9RFCDF6Tz+ZHTozWXuYQKKZ+VtrV77jUO69NnlSd2
         MD+fBFZSGkGwmugnqT1BKQ4jQzx3W+5a9E7puZIua9yuBUTSPJLmavq1qsmm17WacgBg
         4AtGY/UPfg9p8GbuP2UdoqXI2x6fATyp7A/WGUNhfWdoHfcnBtpfpoh2s7Pehph9L5Ux
         EahFlvT50RVDMDPBltF3DTCaHCIHYN+rUoIOIpUquTMQFmwheWHw9VZw6702Mb27OF5x
         F/YQ==
X-Gm-Message-State: AC+VfDwGAH97qbrHy4hthpbupxiCG5mfNKiZpavzaQbC3M6ya/3ApL4h
        oh6uwowcGZ80kXe7BzUvFy4=
X-Google-Smtp-Source: ACHHUZ6nJG5XpFvBudEgkiMwrGyB9Pv9nUCyG25GjlmM7UiqeEqOJsFBEnAMuiu5/HbU6oHec3zsMA==
X-Received: by 2002:a17:903:18c:b0:1ae:50cc:45b with SMTP id z12-20020a170903018c00b001ae50cc045bmr5218924plg.36.1685560602593;
        Wed, 31 May 2023 12:16:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g23-20020a1709029f9700b001b077301b15sm1757956plq.156.2023.05.31.12.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 12:16:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b1d8f851-4e87-333c-229c-b9dc37ea3c40@roeck-us.net>
Date:   Wed, 31 May 2023 12:16:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
References: <20230531151918.105223-1-nick.hawkins@hpe.com>
 <20230531151918.105223-5-nick.hawkins@hpe.com>
 <07b2a2f7-5ddc-0f10-6b1f-184dc21fa580@roeck-us.net>
 <DM4PR84MB19274F575858CBCB2FA5C23E88489@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 4/5] hwmon: (gxp_fan_ctrl) Provide fan info via gpio
In-Reply-To: <DM4PR84MB19274F575858CBCB2FA5C23E88489@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 11:17, Hawkins, Nick wrote:
>> This is not acceptable. It is way too generic for a global variable, and it
>> does not use the gpio API. Besides, the variables would have to be declared
>> in an include file associated with the code introducing them.
> 
>> If you want to use gpio pins in the hwmon driver, use the gpio API
>> ([devm_]gpiod_get() and associated functions). There are lots of examples
>> in the kernel showing how to do that.
> 
> Hi Guenter,
> 
> Thank you for the feedback. I did try and create a driver for both the fan
> and the psu but I had an issue where the host and linux driver both
> need to monitor and access it.
> 
> I made a brief query about it here to the mailing list.
> (Apologies if this is the incorrect way to share a link)
> https://lore.kernel.org/all/DM4PR84MB19274817C2D8A751E3218F4888759@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM/
> 
> I am open for trying a different approach, I am just not sure what is
> the correct way to proceed.
> 
> Is there a way for the driver to temporarily take the GPIO away from the
> Host and return it? The host is wanting to hold the GPIO all the time to

I don't think so.

> monitor for change.
> 

If the host wants to own the fan status from gpio pins, it has to live up to
it and own it entirely. The kernel hwmon driver does not have access in that
case.

In a more "normal" world, the hwmon driver would "own" the gpio pin(s)
and user space would listen to associated hwmon attribute events (presumably
fan_enable and fan_fault), either by listening for sysfs attribute events
or via udev or both. Again, if you don't want to do that, and want user space
to have access to the raw gpio pins, you'll have to live with the consequences.
I don't see the need to bypass existing mechanisms just because user space
programmers want direct access to gpio pins.

> Another thought I had was perhaps having some duplicate I/Os where
> there is one for the host consumption and the other for linux kernel
> driver consumption.
> 

I neither think this is a good idea nor that it is really necessary.
Again, the desire to have direct user space access to gpio pins is
something you _want_, not something that is really needed.

Guenter

