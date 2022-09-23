Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266865E8086
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiIWRNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiIWRNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:13:09 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A814F292
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:13:06 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r134so427532iod.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9DspzISYDZdwXe6YW4/byYA4B4SJO5CgwTAfMKjSPDY=;
        b=cXXl+Qhm4rzW23YVb5ud9aHREhljfUeQZFv3VbXEKYSjiKCHXgsYeznaSzobMsdnNn
         xySMV8wGvE7tvRDmx/e+itbgVG31nqeLhYaaBfy6a3GLnCbBkhBXOa5N23yzuIqA1wWS
         bfCMFMWrLc3187LuRN4j+fNuGXMYoqGK7wiws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9DspzISYDZdwXe6YW4/byYA4B4SJO5CgwTAfMKjSPDY=;
        b=XBVdJZdUeDglfALzbi27TuJDnGNeQxdMFN7hkRglqTPLzNvFXlxG7tyfQ2PLTT6Sdc
         TFa272TvJUBOrIXYa0FwR09UJDJSlWuRhJVZDJ+2L1F9uFi9aNj0ihhYug2l8Wk5PLQf
         3e+xRCy+ArOoPZIJO2lOQ0+zJYviWmilgIerbKemCNLa1T/D/DTvJs669azKXYhicRwu
         Adco7ZOl3JTF5/DZcRCZXQXN2+QM+FUUUTRn8NGvYjsJqqDEeuBUULiuoImWcm7GVdwY
         4jspz5wXe9GBG6hv3kQGLQQ25J+AJwGwWuZKVw2WIV9s28u3IvmJaZ6VgDnyHUYlj3Qe
         AVOQ==
X-Gm-Message-State: ACrzQf05L2D9qMszmSk1RhgXiOTbl91nSHsjdrphxDJCvEWkJCuz55ZE
        LNPut00FN+v4402XTBXaFE1jNcVTzsrcyg==
X-Google-Smtp-Source: AMsMyM5me6EzlfwwSH1UTWsbbIFegsamlI7KuYhQ65RdBegvQtSw1yLltqfbQh66RT3g8VPs2lIgkw==
X-Received: by 2002:a05:6602:21d2:b0:6a1:6913:8d33 with SMTP id c18-20020a05660221d200b006a169138d33mr4253378ioc.112.1663953185423;
        Fri, 23 Sep 2022 10:13:05 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id v20-20020a056e020f9400b002eb75fb01dbsm3322217ilo.28.2022.09.23.10.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 10:13:05 -0700 (PDT)
Date:   Fri, 23 Sep 2022 17:13:03 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Mehta, Piyush" <piyush.mehta@amd.com>,
        Marek Vasut <marex@denx.de>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>
Subject: Re: USB companion HUB for usb5744
Message-ID: <Yy3pH7pHQ8H364OE@google.com>
References: <479b13a3-08f6-c7c9-dce3-13831d69da3e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <479b13a3-08f6-c7c9-dce3-13831d69da3e@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Fri, Sep 23, 2022 at 03:08:54PM +0200, Michal Simek wrote:
> Hi Matthias,
> 
> I want to follow up with you on discussion we had couple of months ago
> around usb companion HUB series which is finally merged to the tree.
> We are using USB5744 hub(4 ports), it supports USB3.0 functionality backward
> compatible with USB2.0.
> 
> To generic driver support for regulator and gpio reset was added.
> In our case usb hub has i2c interface connected and hub expects
> initialization via i2c to start to operate.
> 
> In past you mentioned to create new file just for handling hubs itself.

Yes, code that is specific for certain hub models should be separate from
the core driver. As long as the hub specific code isn't too large it
could be an option to host it in a single file for multiple models.

The core driver could invoke an ->init callback if it exists to perform
the hub specific initialization.

> Anyway from DT perspective I discussed description with Rob some time ago
> https://lore.kernel.org/all/CAL_JsqJZBbu+UXqUNdZwg-uv0PAsNg55026PTwhKr5wQtxCjVQ@mail.gmail.com/
> where he wanted to use i2c-bus link.
> 
> It will end up with description like this.
> 
> 	usbhub0_2_0: hub@1 { /* u43 */
> 		compatible = "usb424,2744";
> 		reg = <1>;
> 		i2c-bus = <&usbhub_i2c0>;
> 		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> 		peer-hub = <&usbhub0_3_0>;
> 	};
> 
> 	usbhub0_3_0: hub@2 { /* u43 */
> 		compatible = "usb424,5744";
> 		reg = <2>;
> 		i2c-bus = <&usbhub_i2c0>;
> 		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> 		peer-hub = <&usbhub0_2_0>;
> 	};
> 
> In probe onboard_hub_power_on is called to toggle gpio line which we need
> and then we need to write 16 bits to basic initialization (or more for
> different one).
> Marek also mentioned that he has another chip from Microchip where i2c
> address can be setup. I think it would be good to get any guidance how this
> should be integrated.
> 
> From my perspective i2c address should be described in DT.
> 
> Can we use any description like?
> i2c-bus = <&usbhub_i2c0 0x2d>;

I don't have objections as long as the DT folks are happy with that.

> And initialization sequence via any property with
> uint32-array/uint16-array/uint8-array types.

I very much doubt that you could convince DT maintainers to approve such a
binding. The device tree is supposed to describe the hardware, an
initialization sequence does not do that. Also a sequence of bytes is very
opaque, in source code comments can be added if something is not evident.
IMO the initialization should be done in an ->init callback that is specific
to the USB5744 hub.
