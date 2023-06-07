Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8BD726587
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241577AbjFGQMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbjFGQMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:12:01 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C365199D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 09:11:59 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977ed383b8aso501861566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686154318; x=1688746318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7CTLJ85SO40P+6T5lFDwMelrcGu/os7DzoU6F/bozQU=;
        b=uNQR41pAUvu9ySqUcIp6c98cuPiYcZiCG1PKzQ2msjmPuFJTD5kSX0DWEqeatZPi4A
         ZSc7whT72OSG99sxGuADoLhG011npd0FLeeWXBQ+Xcj8LgbIMKSsnLAtoaM0jncLPYh8
         JvcLPd1k670eIU5ByuSYGLoDy41iDOJn931uMmf+acQtpryqGviRrpSK/arB0Pf+quPb
         voF/9V4++UXo97A0v5H3G8wOZcV83HW8NKyXuLCLatTM7qqKbeF2UFB/12rfykKanrpU
         0p8qMJ2G7IuUH8oV4z9WvWY3dHhaCBiJ8qF1k1bkAzo2f9Lxrtn/X6hqc017cg4WDAw7
         hBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686154318; x=1688746318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CTLJ85SO40P+6T5lFDwMelrcGu/os7DzoU6F/bozQU=;
        b=aPGIAjaSUFyXTI40C+Yvu+DlPlMo9LjI7LUHW7ArlgPBAmjR6PEJo8QBz9FYxTofCQ
         axZbxQaaiUBuBbCi0vtnFYW03aUJoi8yRUeLZAX0OvbrWNYQiCCuBT+++scn2Jr8ic+O
         EPcIbI56wT9xVUwZGzu8JnjQy1Jj2PRHICLoZX5Rn2ygfArStqDgb7VHOKsXpyevEUUI
         D4A4UwcAelqO5Y6xkkPDCOawWLwrPM1yZVhQKWmHmSTLgDLUzhrd0Z9Pc9uYv+PMDg22
         0C46EzvOzdRgnEzw8TVFJWdHddPfql7AVtnBLgNUBSWNhHZe8wAKvGntbGAHe1PuIF90
         T3yQ==
X-Gm-Message-State: AC+VfDw2AIO+41NTzcrdnasE7vnkMDoAH5V39r5ay16fVJKvDO8CjIwv
        tBJt1O0yVsDMkplKgvXYOFqFlg==
X-Google-Smtp-Source: ACHHUZ5z5lAgGpxbWfyVlmv2tAEIz6cRQ+OoTg1Q+IlD0paYIHTQMtNksmOnrQMAuBaGNveZcyyttQ==
X-Received: by 2002:a17:907:2d10:b0:96a:928c:d391 with SMTP id gs16-20020a1709072d1000b0096a928cd391mr7109018ejc.4.1686154317780;
        Wed, 07 Jun 2023 09:11:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id f10-20020a170906494a00b00969f25b96basm6948862ejt.204.2023.06.07.09.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 09:11:57 -0700 (PDT)
Message-ID: <4673281c-0281-6fc5-97c3-b4ec821c81d5@linaro.org>
Date:   Wed, 7 Jun 2023 18:11:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 2/3] media: dt-bindings: alvium: add document YAML
 binding
Content-Language: en-US
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>,
        Shawn Tu <shawnx.tu@intel.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230607131936.382406-1-tomm.merciai@gmail.com>
 <20230607131936.382406-3-tomm.merciai@gmail.com>
 <17971357-523c-f907-13a9-8f7abce90c24@linaro.org>
 <ZICgPUDv+GjK4C5t@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZICgPUDv+GjK4C5t@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 17:20, Tommaso Merciai wrote:
> Hi Krzysztof,
> 
> On Wed, Jun 07, 2023 at 04:18:48PM +0200, Krzysztof Kozlowski wrote:
>> On 07/06/2023 15:19, Tommaso Merciai wrote:
>>> Add documentation of device tree in YAML schema for the ALVIUM
>>> Camera from Allied Vision Inc.
>>>
>>> References:
>>>  - https://www.alliedvision.com/en/products/embedded-vision-solutions
>>>
>>> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>> ---
>>> Changes since v1:
>>>  - Fixed build error as suggested by RHerring bot
>>>
>>> Changes since v2:
>>>  - Fixed License as suggested by KKozlowski/CDooley
>>>  - Removed rotation property as suggested by CDooley/LPinchart
>>>  - Fixed example node name as suggested by CDooley
>>>  - Fixed title as suggested by LPinchart
>>>  - Fixed compatible name as suggested by LPinchart
>>>  - Removed clock as suggested by LPinchart
>>>  - Removed gpios not as suggested by LPinchart
>>>  - Renamed property name streamon-delay into alliedvision,lp2hs-delay-us
>>>  - Fixed vendor prefix, unit append as suggested by KKozlowski
>>>  - Fixed data-lanes
>>>  - Fixed blank space + example indentation (from 6 -> 4 space) as suggested by KKozlowski
>>>  - Dropped status into example  as suggested by KKozlowski
>>>  - Added vcc-ext-in supply as suggested by LPinchart
>>>  - Dropped pinctrl into example as suggested by LPinchart
>>>
>>> Changes since v3:
>>>  - Fixed vcc-ext-in-supply description as suggested by LPinchart
>>>  - Fixed alliedvision,lp2hs-delay-us description as suggested by LPinchart
>>>  - Added maximum to alliedvision,lp2hs-delay-us as suggested by LPinchart
>>>  - Collected Reviewed-by tag from LPinchart
>>
>> You still did not test it before sending. Four versions of which none
>> were tested :(
> 
> You are right.. my bad. :'(
> 
> After fixing id, as suggested by Laurent/bot into:
> 
> $id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium-csi2.yaml#
> 
> I'm running the following test:
> 
> make dt_binding_check DT_SCHEMA_FILES=alliedvision,alvium-csi2.yaml
> 
> With the following result:
> 
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> /home/tom/work/mainline/linux/Documentation/devicetree/bindings/media/i2c/.alliedvision,alvium-csi2.example.dts.pre.yaml: ignoring, error parsing file
>   DTEX    Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.example.dts
>   DTC_CHK Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.example.dtb
> 
> Is that correct?

No, it doesn't look correct. You have error parsing your file. Check
your yaml file and its example DTSI.

Be sure you have also yamlling installed.

Best regards,
Krzysztof

