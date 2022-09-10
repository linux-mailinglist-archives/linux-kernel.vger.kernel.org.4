Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2515B4859
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 21:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiIJTsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 15:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiIJTsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 15:48:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5032167F7;
        Sat, 10 Sep 2022 12:48:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y3so11601940ejc.1;
        Sat, 10 Sep 2022 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0gpqeUaUdq1jgASkshCgKRmA+Q1+uZQMqt4GLBoHHR4=;
        b=SwwucSHlXm0YPfeeC4lZlFZ0Z+dOmRGPQkOla56HWKeyOlplorH3zvOV9tOGT3pmgF
         kvpEpOd9jdcY25oRmAec19MKAehbtwqF4/ycOuVjaXqSGUzfJjVbCgHtOEu8FWujUIjs
         /+Ivfh5ZGXeZ49lkWrMCSrY4sTUIgDrBmCrCD6IxYuOi59VWv+BNdWe1YHSTBkGmJFlB
         2KyDVNOxbX4/G+lsR/g5/JKfn3SO7sjiVWxOB9kWgl5iX8/MwMUDSNolWdwZRplv3cFY
         Gm+wmG0ZHynL0mG0Hp8Zb+4VDdU3o9bt1dTGa74Gp8Mvghr7eTk8gV9x+g2zYihY4txV
         ibhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0gpqeUaUdq1jgASkshCgKRmA+Q1+uZQMqt4GLBoHHR4=;
        b=w/TG74Ztig6K/oRVPqSkPXakdOUS4gWyu2QKlJnOJMeFo4jNTU/QJ5TYzvd+BJ+6Xr
         FIkuMHFup9oXQokbDNlIwhm7BL0XWYWEOfMxE3cySFoBO8rhfsRPtwJ8QCg+b9Io/3Ik
         EPh4/vGTzKPq6fnO9AYi0NXPJqDorMlEhHqOS5TdvLQwaRmu2fdYdTTQtuK6qHPdzFPC
         29s4KLaxFVaeiF4VWRdkKf7mfQNBqpi1a8aTVQtSbEpOXUIh54Mh5PrNnGESr3gLJkO2
         2wMV1bhRQhDGP9c5vYkV/BKL0zdf9C0gFrdpIFI74g6ovzVUm6AW/wg3Xf2lFq1euFQp
         TXaQ==
X-Gm-Message-State: ACgBeo3os0pTc6LAHqXMsfTI2nXJeLfS5Kbk/6x8cxNPusvb3qLgWTMQ
        bstN/d7N9g9KmqOToDsg+6M=
X-Google-Smtp-Source: AA6agR7X+LQPt9/yXz/e+j2Vs+LXI3PFWRHgchsO6YkfGoeC9fg48fhlEHAuSGAbjlI8W1ZTcSuhuA==
X-Received: by 2002:a17:907:728c:b0:730:c005:5d93 with SMTP id dt12-20020a170907728c00b00730c0055d93mr14059967ejc.265.1662839286227;
        Sat, 10 Sep 2022 12:48:06 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ly9-20020a170906af4900b0073dde62713asm2090628ejb.89.2022.09.10.12.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 12:48:05 -0700 (PDT)
Message-ID: <1c13181b-8421-69d8-21ee-9742dd5f55dd@gmail.com>
Date:   Sat, 10 Sep 2022 21:48:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 03/11] dt-bindings: pwm: rockchip: add
 rockchip,rk3128-pwm
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de
Cc:     linux-rockchip@lists.infradead.org, philipp.tomsich@vrull.eu,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        kever.yang@rock-chips.com, zhangqing@rock-chips.com,
        linux-kernel@vger.kernel.org, heiko@sntech.de
References: <20220909212543.17428-1-jbx6244@gmail.com>
 <f5dd0ee4-d97e-d878-ffde-c06e9b233e38@gmail.com>
 <1662821635.180247.34700.nullmailer@robh.at.kernel.org>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <1662821635.180247.34700.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduced CC.

Hi Rob,

The rk3328 and rv1108 PWM interrupt is chaired between blocks I think.
For rv1108 the same interrupt is used for all PWM nodes.
For rk3328 only added to one PWM node.
Currently not in use in a Linux drivers??

No consensus yet...on removing or parent node, so it stays as it is...
Maybe if you have ideas things will change. ;)

Johan

===

See discussion:
https://lore.kernel.org/linux-rockchip/20b7c702-9412-93b4-3174-e8633bc413d7@gmail.com/ 

On 9/10/22 16:53, Rob Herring wrote:
> On Sat, 10 Sep 2022 00:02:22 +0200, Johan Jonker wrote:
>> Add rockchip,rk3128-pwm compatible string.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 
> pwm@10280000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/rv1108-elgin-r1.dtb
> 	arch/arm/boot/dts/rv1108-evb.dtb
> 
> pwm@10280010: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/rv1108-elgin-r1.dtb
> 	arch/arm/boot/dts/rv1108-evb.dtb
> 
> pwm@10280020: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/rv1108-elgin-r1.dtb
> 	arch/arm/boot/dts/rv1108-evb.dtb
> 
> pwm@10280030: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/rv1108-elgin-r1.dtb
> 	arch/arm/boot/dts/rv1108-evb.dtb
> 
> pwm@20040000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/rv1108-elgin-r1.dtb
> 	arch/arm/boot/dts/rv1108-evb.dtb
> 
> pwm@20040010: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/rv1108-elgin-r1.dtb
> 	arch/arm/boot/dts/rv1108-evb.dtb
> 
> pwm@20040020: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/rv1108-elgin-r1.dtb
> 	arch/arm/boot/dts/rv1108-evb.dtb
> 
> pwm@20040030: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/rv1108-elgin-r1.dtb
> 	arch/arm/boot/dts/rv1108-evb.dtb
> 
> pwm@ff1b0030: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dtb
> 	arch/arm64/boot/dts/rockchip/rk3328-a1.dtb
> 	arch/arm64/boot/dts/rockchip/rk3328-evb.dtb
> 	arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dtb
> 	arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dtb
> 	arch/arm64/boot/dts/rockchip/rk3328-rock64.dtb
> 	arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dtb
> 	arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dtb
> 
