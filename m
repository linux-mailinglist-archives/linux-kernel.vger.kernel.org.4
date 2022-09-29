Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847F25EF36B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiI2K0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiI2K0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:26:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB88A30566;
        Thu, 29 Sep 2022 03:26:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sb3so1826231ejb.9;
        Thu, 29 Sep 2022 03:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=btW9hAxG6Y4tXj/jMqjRoxtSzkcRFAo4VxBjFE727ts=;
        b=fB30Dvc4wrN0qIKz9b06hxpoQh+dfM6f/i3bIqJqnX12K4Z6G7Q345tTWm6fRbPitH
         /Qj4RssS7DsqFmUGIt17aC3GYClpNkBpNSWY4hwNdK/YNkmwNlEhZo4U5I2BNlu1jgmy
         zJSzwlrkWglJlc4P+3n+tBvQuz42jzN+s/kbILpgVBwx43OsjXJ7nbesEEVUtaIlx9CA
         +35EIFuoj4KcGhOzIRrDo31xNLnv6K4yPxgaphQqQjOboOlcx7ls/BkomkNpCNIK2AJh
         PAr+kqmgevci9CGCUZ4SJl3vCND0my03auKA0C6hd2p0U6p4++x/OygEuIhNreVCe6lw
         0HhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=btW9hAxG6Y4tXj/jMqjRoxtSzkcRFAo4VxBjFE727ts=;
        b=5zIuVkxMsoC9ovxTv5izAs/l9WleRzZD4KgodvxUgdZy7C1LPfgzh6oi6rMHDHZ2gn
         UU1sLERv2V4w7JgjAKDqIcVR61YrvmSzGEU/PTU9nhVFqsVX/Ccb2nIhLd18VV6jJgAI
         P/WcXkE266hPgOY43KVptCHUyQmn9SfGjzEuTpIMCAYFhYmZy8UjNIE12TzSK5sK78Sw
         xFaVvmWT2JF87Q6nQeVOvcPbP08krGF8WoGx/BOwLKsnBBI+nPcgsByEF3/IxxBPKOfc
         BMiH4UUTcXnQZstiTXPNHpgpUSGswzG4dY4oPu+77KjpkJ+aSSQai7J6d4tWzTUCpeti
         ybaA==
X-Gm-Message-State: ACrzQf2mXYkac8c8bQc1VWkTQyLmS3L3zkXvH3b209Pg3dqd6g2zv1ye
        O1njhZV7f0cAZoNChOoyOYk=
X-Google-Smtp-Source: AMsMyM6kdVvs51Cq0ExTA8Vn8DgYKzyBs69shxjd5W7YepZDuzen8GqN5Ks2stY+KME0/OB2K1jf9g==
X-Received: by 2002:a17:907:6297:b0:72f:9aad:fcb with SMTP id nd23-20020a170907629700b0072f9aad0fcbmr2094425ejc.161.1664447199215;
        Thu, 29 Sep 2022 03:26:39 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ky21-20020a170907779500b0073ae9ba9ba8sm3804816ejc.3.2022.09.29.03.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 03:26:38 -0700 (PDT)
Message-ID: <94d829a6-d8c2-2106-2d7d-91a8cd3875ae@gmail.com>
Date:   Thu, 29 Sep 2022 12:26:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 03/11] dt-bindings: pwm: rockchip: add
 rockchip,rk3128-pwm
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, u.kleine-koenig@pengutronix.de,
        linux-rockchip@lists.infradead.org, philipp.tomsich@vrull.eu,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, kever.yang@rock-chips.com,
        zhangqing@rock-chips.com, linux-kernel@vger.kernel.org,
        heiko@sntech.de
References: <20220909212543.17428-1-jbx6244@gmail.com>
 <f5dd0ee4-d97e-d878-ffde-c06e9b233e38@gmail.com>
 <1662821635.180247.34700.nullmailer@robh.at.kernel.org>
 <1c13181b-8421-69d8-21ee-9742dd5f55dd@gmail.com>
 <20220912162159.GA1397560-robh@kernel.org>
 <37fd8d4b-3a66-bc51-c2dc-76c9e756fed8@gmail.com> <YzQ3He2wyD2bgxz1@orome>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <YzQ3He2wyD2bgxz1@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/22 13:59, Thierry Reding wrote:
> On Tue, Sep 13, 2022 at 04:38:32PM +0200, Johan Jonker wrote:
>>
>>
>> On 9/12/22 18:21, Rob Herring wrote:
>>> On Sat, Sep 10, 2022 at 09:48:04PM +0200, Johan Jonker wrote:
>>>> Reduced CC.
>>>>
>>>> Hi Rob,
>>>>
>>>
>>> Seemed like a simple enough warning to fix...
>>
>> Some examples for comment.
>> Let us know what would be the better solution?
>>
>> ===========================================================================
>>
>> option1:
>>
>> 	combpwm0: combpwm0 {
>> 		compatible = "rockchip,rv1108-combpwm";
>> 		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>> 		#address-cells = <2>;
>> 		#size-cells = <2>;
>>
>> 		pwm0: pwm@20040000 {
>> 			compatible = "rockchip,rv1108-pwm";
>> 			reg = <0x20040000 0x10>;
>> 		};
>>
>> 		pwm1: pwm@20040010 {
>> 			compatible = "rockchip,rv1108-pwm";
>> 			reg = <0x20040010 0x10>;
>> 		};
>>
>> 		pwm2: pwm@20040020 {
>> 			compatible = "rockchip,rv1108-pwm";
>> 			reg = <0x20040020 0x10>;
>> 		};
>>
>> 		pwm3: pwm@20040030 {
>> 			compatible = "rockchip,rv1108-pwm";
>> 			reg = <0x20040030 0x10>;
>> 		};
>> 	};
>>
>> PRO:
>> - Existing driver might still work.
>> CON:
>> - New compatible needed to service the combined interrupts.
>> - Driver change needed.
>>
>> ===========================================================================
>> option 2:
>>
>> 	combpwm0: pwm@10280000 {
>> 		compatible = "rockchip,rv1108-pwm";
>> 		reg = <0x10280000 0x40>;
>> 		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
>> 		#address-cells = <1>;
>> 		#size-cells = <0>;
>>
>> 		pwm4: pwm-4@0 {
>> 			reg = <0x0>;
>> 		};
>>
>> 		pwm5: pwm-5@10 {
>> 			reg = <0x10>;
>> 		};
>>
>> 		pwm6: pwm-6@20 {
>> 			reg = <0x20>;
>> 		};
>>
>> 		pwm7: pwm-7@30 {
>> 			reg = <0x30>;
>> 		};
>> 	};
>>
>> CON:
>> - Driver change needed.
>> - Not compatible with current drivers.
>>
>> ===========================================================================
>>
>> Current situation:
>>
>> 	pwm0: pwm@20040000 {
>> 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
>> 		reg = <0x20040000 0x10>;
>> 		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>> 	};
>>
>> 	pwm1: pwm@20040010 {
>> 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
>> 		reg = <0x20040010 0x10>;
>> 		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>> 	};
>>
>> 	pwm2: pwm@20040020 {
>> 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
>> 		reg = <0x20040020 0x10>;
>> 		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>> 	};
>>
>> 	pwm3: pwm@20040030 {
>> 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
>> 		reg = <0x20040030 0x10>;
>> 		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>> 	};
>>
>> CON:
>> - The property "interrupts 39" can only be claimed ones by one probe function at the time.
>> - Has a fall-back string for rk3288, but unknown identical behavior for interrupts ???
> 

> To be honest, all three descriptions look wrong to me. From the above it
> looks like this is simply one PWM controller with four channels, so it
> should really be described as such, i.e.:
> 
> 	pwm@20040030 {
> 		compatible = "rockchip,rv1108-pwm";
> 		reg = <0x20040030 0x40>;
> 		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> 	};
> 

Each PWM channel has it's own pinctrl.
Not all channel pins are always in use for PWM exclusively.
Your proposal would not allow pins to be used for other functions.
More ideas with this interrupt? Please advise.

===

The SoCs PWM are configurable to operate in continuous mode (default mainline) or one-shot mode or capture mode.
Is there any good example for one-shot mode interrupt use?


> Looking through existing Rockchip SoC DTSI files, though, it looks like
> this has been done the wrong way since the beginning, so not sure if you
> still want to fix it up.
> 
> This whole problem of dealing with a shared interrupt wouldn't be a
> problem if this was described properly.
> 
> Thierry
