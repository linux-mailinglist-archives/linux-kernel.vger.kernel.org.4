Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A36629F17
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbiKOQa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbiKOQay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:30:54 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2FFB7F9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:30:52 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id a15so18211356ljb.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgmhkilsxspOz5NWRqSMIhLipP/HJEPgQBayMZdWBrw=;
        b=FGIToAWnLxWH/nNXH4Bc8NPARTKs+TGdOcxBxW+NwDA8ogN+41Yy9hAXq6hZYmg5rm
         E5WwGRSzNfdPh4RKw/qzCgAmNx8PB8fXQiJY2BhtgUBmp2Wg7DPDkLXeTQW5jCRBpxUY
         5ZI96mIUE34Ez+kcUW/KBPbPmebd5pme11C81WRfl+TtOWA8AetIBdJ4T/5GXw1AdiD8
         A0t+yrlvyW45uGPQND8zUBzZ4ec5l4T6aWUCCFvntu2dB2D4qP1ff4rpqYZ0Q1cbiNC1
         6tPcToXU5iuwpTLyY1xq8ZYZB7aO47yzHWDD+rngVtDKcK04TfoXgLJvMDDzuW1ExSho
         dvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgmhkilsxspOz5NWRqSMIhLipP/HJEPgQBayMZdWBrw=;
        b=4M8axniWRElBxBxpOItAXCdei916NEuP6o7QjL5h1bbsmGeXtRLSBI9hNA7lucFFZf
         GndicRVc/hscOEl/S9c+dpaH9+Chh9+ViwR8sZQk6EP6jBih+LG5zWHtvI3n7XU2dyr6
         UeX8tvgkCH/s4FPPkVPfOZhdv8HwKHiwY01OXP6M1NJYoUC/ej8CCHomKPbs8VG5dx/+
         IhFBUzSzDb1vUWjRBvv1bfcie81OKdkj49Ewj5Vo7yklZs41hs09viUOj8pjnKMfQUZn
         TOxD539k07nYivKxemEXvqRxSLXGMPw1yfIm0BBiqOPneYazqA/P/AiH4FQXBRjIPU/P
         3PXA==
X-Gm-Message-State: ANoB5pn0KXHoQALixaHTkDaLpBJ1J1nAkDVGplWIF/JU9g4UIxZdr1sC
        g6TQuY5bNfT1Wn3Gp/UFe9OpoQ==
X-Google-Smtp-Source: AA0mqf6Tx5INGoZ78d+9myc+vdTm5mzsmp5rLWprRQV1O1l0dTir56KzqEnejFqId0Li9Ws03Fr7Vw==
X-Received: by 2002:a05:651c:2314:b0:277:2123:120e with SMTP id bi20-20020a05651c231400b002772123120emr6513113ljb.4.1668529850815;
        Tue, 15 Nov 2022 08:30:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v14-20020ac258ee000000b004998d9ccb62sm2262902lfo.99.2022.11.15.08.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 08:30:50 -0800 (PST)
Message-ID: <8e80a8ae-41dd-3f17-b165-eaba5335ae68@linaro.org>
Date:   Tue, 15 Nov 2022 17:30:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 6/7] ARM: dts: r9a06g032: Add the USBF controller node
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
 <20221114111513.1436165-7-herve.codina@bootlin.com>
 <51d42fc2-0492-9077-302d-5c3be4b45cd1@linaro.org>
 <20221115142754.6253881b@bootlin.com> <20221115160917.73e7b4ef@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115160917.73e7b4ef@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 16:09, Herve Codina wrote:
> Hi Krzysztof
> 
> On Tue, 15 Nov 2022 14:27:54 +0100
> Herve Codina <herve.codina@bootlin.com> wrote:
> 
>> Hi Krzysztof,
>>
>> On Tue, 15 Nov 2022 14:16:27 +0100
>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>>> On 14/11/2022 12:15, Herve Codina wrote:  
>>>> Add the USBF controller available in the r9a06g032 SoC.
>>>>
>>>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>>>> ---
>>>>  arch/arm/boot/dts/r9a06g032.dtsi | 12 ++++++++++++
>>>>  1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
>>>> index 563024c9a4ae..a4bb069457a3 100644
>>>> --- a/arch/arm/boot/dts/r9a06g032.dtsi
>>>> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
>>>> @@ -117,6 +117,18 @@ dmamux: dma-router@a0 {
>>>>  			};
>>>>  		};
>>>>  
>>>> +		udc: usb@4001e000 {
>>>> +			compatible = "renesas,r9a06g032-usbf", "renesas,rzn1-usbf";
>>>> +			reg = <0x4001e000 0x2000>;
>>>> +			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
>>>> +			clocks = <&sysctrl R9A06G032_HCLK_USBF>,
>>>> +				 <&sysctrl R9A06G032_HCLK_USBPM>;
>>>> +			clock-names = "hclkf", "hclkpm";
>>>> +			power-domains = <&sysctrl>;
>>>> +			status = "disabled";    
>>>
>>> If you provided all resources (clocks, power domains etc), why disabling it?  
>>
>> Because I forgot to remove the 'status' property ...
>> 'status' will be simply removed in v3.
>> Sorry for this mistake.
>>
>> Thanks for the review,
>> Hervé
>>
> 
> I said something completely wrong for this point.
> 
> status is set disabled because it is a .dtsi and can be
> included by several dts to represent a board.
> This node (USB device) can be wired on some board and not on
> some others.
> So, the node will be enabled in each dts board that has the USBF
> device wired and used.

So it depends on having the connector? Yes, makes sense as well.
Actually my recommendation was about internal parts of OS, which usually
do not require anything from board. I missed the part that it is an USB...

Best regards,
Krzysztof

