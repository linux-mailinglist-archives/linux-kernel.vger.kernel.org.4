Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CFB65CEDA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbjADI4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjADI4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:56:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1415D1F2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:56:16 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id co23so32276241wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 00:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HyeD42ASTohnhG8PBq16ESn0fobcpb8ovKy3Ww5fcDg=;
        b=o2ooXOQ6dPldjaJOtvM1YfYyy2GVA/bJIVJ7cdK+tbjn0eiVvb8FGKjpSg4Y2LdlqU
         M9/n7DThVNQUD2EP6U3Foc7YI7aJ4mp4CggD49gRuu6VeE6FE7IUw6yfLZo57kUKVjcb
         /mnEaODceB/RuzNmitFpSEM5wo4W+lYTlXEr+h11Dv79UVzXC4xnJwKWH1n7egewjqQb
         Gc4IPnBqustj2EmukPNUR4/K8NxuksOV1YVxvBNgAaD1jQQhhGwpN7qy2JUMr3txrovn
         q9SOgPjaW7Jux5nA18LFEDMp027XD2syF1bQV3zJnZXeQd4/3wpzzma96aFTb8biWsqB
         aYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HyeD42ASTohnhG8PBq16ESn0fobcpb8ovKy3Ww5fcDg=;
        b=eiuPawx3O6VX2uaYl8+gFOcY74N8eTBFpIcTMNXjY1gp/Ywf9cEr1qlROqZg+THoYR
         BLCEEgXseKJ4/Rr1Nrd49vO0sUgJSVwxuSQy4ct+dL+lHXZIGNAjogTUU63GZALlPsOJ
         brka+Vbv+Emdco34ifYXBHlWdtM76jwh3nssf9O9UB7K2hECRk3T7S5ew2t+2p0LbXx/
         u2s774AiwmXRsk5NmCYLVYcjfwEFAxMjInpWtnuxDi0mfZ+L4ocfpWEOiEJSkl6vAkpa
         qD9If7fK0skck2msyAdsiTsEV37arzRbW960tG2LboLj2yV88TaM/1txOWK/rMP18dWy
         u9dQ==
X-Gm-Message-State: AFqh2kotto3EAx7ZPrkNM6AUkXOXZWFb+qJyvq2jBX2W0t/hNU65clZ7
        ojGMSPdCnhFAvX3nFbn89WJxPg==
X-Google-Smtp-Source: AMrXdXtxA65BDM8b0iW+0Q1/36Od59YM1bViy4tJKnTuc7uQ1VQ2hVL6/lJdTbF377sRYZBmHqOzQQ==
X-Received: by 2002:a05:6000:136b:b0:27f:85ce:bc9e with SMTP id q11-20020a056000136b00b0027f85cebc9emr23614208wrz.24.1672822574567;
        Wed, 04 Jan 2023 00:56:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:102f:89e:4a9f:68c? ([2a01:e0a:982:cbb0:102f:89e:4a9f:68c])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d42d2000000b00288a3fd9248sm19162392wrr.91.2023.01.04.00.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 00:56:14 -0800 (PST)
Message-ID: <260b70ae-0758-592b-9c4d-90938e8a5b00@linaro.org>
Date:   Wed, 4 Jan 2023 09:56:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 03/11] arm64: dts: amlogic: Used onboard usb hub reset
 on odroid c2
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221228100321.15949-1-linux.amoon@gmail.com>
 <20221228100321.15949-4-linux.amoon@gmail.com>
 <CAFBinCCtJbF6UjG3czQjVy_Zy_B4DO8BkcayOqDirn0OXw3PtQ@mail.gmail.com>
 <CANAwSgTS+j_oRrckwmi60afX6-D=OP0oy05m3eQga_gEZJJ_mg@mail.gmail.com>
 <CANAwSgTc=uGyZ0H_-ZckYoKztMB--DRfx7apBtP9zAbAU1XTvA@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CANAwSgTc=uGyZ0H_-ZckYoKztMB--DRfx7apBtP9zAbAU1XTvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2023 09:13, Anand Moon wrote:
> Hi Martin,
> 
> On Wed, 28 Dec 2022 at 20:14, Anand Moon <linux.amoon@gmail.com> wrote:
>>
>> Hi Martin,
>>
>> On Wed, 28 Dec 2022 at 18:21, Martin Blumenstingl
>> <martin.blumenstingl@googlemail.com> wrote:
>>>
>>> Hi Anand,
>>>
>> Thanks for your review comments.
>>
>>> thank you for working on this topic!
>>>
>>> On Wed, Dec 28, 2022 at 11:05 AM Anand Moon <linux.amoon@gmail.com> wrote:
>>> [...]
>>>> +       usb {
>>>> +               dr_mode = "host";
>>>> +               #address-cells = <1>;
>>>> +               #size-cells = <0>;
>>>> +
>>>> +               hub@1 {
>>>> +                       /* Genesys Logic GL852G-OHG usb hub */
>>>> +                       compatible = "genesys,usb5e3,610";
>>>> +                       reg = <1>;
>>>> +                       vdd-supply = <&usb_otg_pwr>;
>>>> +                       reset-gpio = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
>>>> +               };
>>>> +       };
>>> My understanding is that the hub@1 node should be part of the
>>> corresponding USB controller node, not a new node.
>>> In this case hub@1 should go into the existing &usb1 node. That way we
>>> describe the way the hardware is set up (meaning: hub@1 is connected
>>> to &usb1).
>>>
>>
>> Ok, I will move this code under &usb0 and &usb1 nodes.
>>
>> onboard_usb_hub module just assists in usb hub reset.
>> so these changes are meant to replace the gpio-hog.
>>
>> $ dmesg | grep onboard
>> [    5.405558] usbcore: registered new device driver onboard-usb-hub
>> [    6.383428] onboard-usb-hub 1-1: reset high-speed USB device number
>> 2 using dwc2
>>
>> Here is the boot log of the odroid c2 [0] https://pastebin.com/PFy5waPb
>>
> 
> Moving the usb hub into usb subnode usb0 or usb1 does not work
> on Odroid n2 and c4, we have a combo phys of usb 2.0 and usb 3.0
> so the onboard usb hub reset does not get initialized until both the PHY
> and USB nodes are brought up by the drivers.

Fine, then add a comment before the usb node explaining that.

Thanks,
Neil

> 
> # On Odroid n2 has a combo hub
> alarm@odroid-n2:~$ lsusb -tv
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
>      ID 1d6b:0003 Linux Foundation 3.0 root hub
>      |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 5000M
>          ID 05e3:0620 Genesys Logic, Inc. GL3523 Hub
>          |__ Port 1: Dev 5, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
>              ID 174c:5106 ASMedia Technology Inc. ASM1051 SATA 3Gb/s bridge
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/2p, 480M
>      ID 1d6b:0002 Linux Foundation 2.0 root hub
>      |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
>          ID 05e3:0610 Genesys Logic, Inc. Hub
>          |__ Port 2: Dev 4, If 0, Class=Vendor Specific Class,
> Driver=ax88179_178a, 480M
>              ID 0b95:1790 ASIX Electronics Corp. AX88179 Gigabit Ethernet
> 
> # Odroid C4 also has a combo hub
> 
> alarm@odroid-c4:~$ lsusb -tv
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
>      ID 1d6b:0003 Linux Foundation 3.0 root hub
>      |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 5000M
>          ID 2109:0817 VIA Labs, Inc.
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/2p, 480M
>      ID 1d6b:0002 Linux Foundation 2.0 root hub
>      |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
>          ID 2109:2817 VIA Labs, Inc.
> 
> So I will continue to work with this usb hub node to do a proper reset
> of the USB hub.
> 
>>> In case hub@1 is not detected within &usb1 then you maym need something
>>> like [0] (not tested for your use-case).
>>> If that helps: feel free to include that patch in your series.
>>>
>>
>> Thanks, will check if this is needed in this case. As of now it just
>> reinitializes the hub.
>>
>>>
>>> Best regards,
>>> Martin
>>>
>>>
>>> [0] https://github.com/xdarklight/linux/commit/d8b96e5bc9c20ab2585194e0e59580c3b062c431
>>
>> Thanks
>> -Anand
> 
> Thanks
> -Anand

