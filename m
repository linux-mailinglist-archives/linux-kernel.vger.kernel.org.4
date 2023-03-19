Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5816C0255
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 15:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCSOQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 10:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjCSOQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 10:16:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3403D49DA;
        Sun, 19 Mar 2023 07:16:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a16so5383957pjs.4;
        Sun, 19 Mar 2023 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679235397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fofrlve0pl+ic6K67ZryHrzuH/Gn4T8D1dVcL+8p9ZE=;
        b=EQrhPQJzJLs6DekeTg2zcd509dgqJ/FC+3PzLgaRv666cl4ZgwLazu/sGw0+iJgTtw
         ngLGDACi7D9p/E69Ur3GF0XY6HruLhIW8tBW3Fyjr3BTtLy8/Xb2nPMzGX7GUvdWHVZM
         9IeDOIrYBccd9Y2D1yP22CmOqu13REZSI+2jErFkLQdZhEMhxFAq8nq7W/i0blcJtii/
         twJgY/Sw0RQmD6YtldMyBTF1CFLC27KIrea5+0+dFvtI6P2n8PhpSahcVKAqOLUHILBd
         Ps8Up//NHx1OIOehB5MuEWb7PMP2VfnYDmoJCQDY215itObT1UR87bup6ykNaLMWmnTb
         Mnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679235397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fofrlve0pl+ic6K67ZryHrzuH/Gn4T8D1dVcL+8p9ZE=;
        b=TFXpFOx/3YyOEqpzdK5ikItdgbXQq58jkXAuwkMqx3GUDsz0jyDJ7vMahTIlJUKr36
         DNtSy2usi49EuIVjTb9o7pvE3p6NUU1yJIIRTYT4+xWGPbT3FkguPpV5Ys5Xn8GmZFIT
         7gwnnUHLL5kISi1TVQebizf7sIXpj+qLCGKb/ZnJ57ZWM7pd7ovNLxL7lk5if+IQSwL7
         yeUqNFsekJB+bPZZil6rNlw1bvrw1AtxJoCP2K6gVLlN8Pr9VM4y6KNpdb3rn2vTlvzT
         x3/MdeRhy+W99Fr1rI5sQBurewggUdWd5iQ7Q24PfPuZREMu9fdATsIQODDk/n82zChe
         2lvQ==
X-Gm-Message-State: AO0yUKXOFXgjBl81W8GEeZni+Y4I7DLgWj2Wnww7lqZSpiHzSSyoEKQf
        2qO+lWFyQLrjK+I1oTxIFoI=
X-Google-Smtp-Source: AK7set8eZ1H2+CkVyArr75/ApS72a8JfEgQXeSMDYFkA6WnQoXs36QOZBRaawac/KuVMva4709Pbwg==
X-Received: by 2002:a17:902:fb85:b0:19c:da68:337a with SMTP id lg5-20020a170902fb8500b0019cda68337amr12437940plb.31.1679235397565;
        Sun, 19 Mar 2023 07:16:37 -0700 (PDT)
Received: from [192.168.1.101] (1-160-164-133.dynamic-ip.hinet.net. [1.160.164.133])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902b18e00b001a1ccb37847sm601054plr.146.2023.03.19.07.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 07:16:37 -0700 (PDT)
Message-ID: <4e4b6bfd-89b2-e917-6e20-24f3be54606a@gmail.com>
Date:   Sun, 19 Mar 2023 22:16:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 11/15] arm64: dts: nuvoton: Add initial ma35d1 device tree
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-12-ychuang570808@gmail.com>
 <fb4f60a7-011e-3745-cc40-631247735f2b@linaro.org>
 <c902606e-8a1b-6673-02c7-7beea5477795@gmail.com>
 <87171ab8-9c6d-3978-6d34-4ae922361307@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <87171ab8-9c6d-3978-6d34-4ae922361307@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzyszto,


On 2023/3/19 下午 07:06, Krzysztof Kozlowski wrote:
> On 18/03/2023 07:07, Jacky Huang wrote:
>>>> +		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x13) |
>>>> +			      IRQ_TYPE_LEVEL_HIGH)>;
>>>> +	};
>>>> +
>>>> +	uart0:serial@40700000 {
>>>> +		compatible = "nuvoton,ma35d1-uart";
>>>> +		reg = <0x0 0x40700000 0x0 0x100>;
>>>> +		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
>>>> +		clocks = <&clk UART0_GATE>;
>>>> +		status = "okay";
>>> Why? Drop the line... or convert it to disabled. Otherwise, why every
>>> SoC has serial0 enabled? Is it used internally?
>>
>> uart0 is on all the way since this SoC booting from the MaskROM boot code,
>>
>> load arm-trusted-firmware, load bootloader, and finally load linux  kernel.
>>
>> uart0 is also the Linux console.
> Are you sure? Maybe my board has UART0 disconnected.
>
> Best regards,
> Krzysztof


OK, I will have the uart0 disabled in dtsi, and enabled it in dts.


Best regards,

Jacky Huang


