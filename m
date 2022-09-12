Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B165B58F4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiILLDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiILLD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:03:26 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1082526579
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 04:03:25 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id p5so10065655ljc.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 04:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=G7P5hA9wOSLBXqSdRwPeUlAgDG4lwQwhL2nJLwjQams=;
        b=XtLnQuvrPx9A+MFrRCcOUcy5fG/hvXnkzzoVvVsH1p1rEdt4zGs4GDwxW8BUaZOQQg
         u3WLqIPJorOUnyBG7o7hNO+hYycaIcvhEHBMXwjsPr9B+c79I3O8Ief0U9MGAwAN2doL
         gM8rCPDKVCbKlp32u/OpdGirsuM7AUrGLUVPHSrGN0J1ftNf3Q1wYx4odD5xTn7ziQTF
         94GZ+zDNfIsULo5G117cjBIo7NnMLEuVjCQHd22/IFwaus95yaYytR6ZHwaRZifUoYUe
         2veOfmpV8GAcJ9yI1XhoF5710X4Xvnz/UYajKdZgnCRljMLHwG6+z+nsxpyzzQ/Rg4Dx
         /mPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=G7P5hA9wOSLBXqSdRwPeUlAgDG4lwQwhL2nJLwjQams=;
        b=cypnzxviJNqKdUhHjz2aphHCS1ipHaBfcdhZzooc0sj71eIDo4B2ayLMDOVMJrHmLl
         ILBUfAY8efD6j2ee9RQfM6TPB0MRCb0eseRhVJs1sZfWGkGk7Bf9b9uRgfVceimmin5z
         t+AX35viULmwCzaby//4YGZ88SOmQkNrS3Yu3E8P+yG7wuGMtV9WV0D0ahhzD8d1lZAZ
         tKXMd/DSOAWxPCWUugGs32OACcCol7O5+qzYDwd/WeoxeaOm3S/+z0bUxffqXPGvWEsd
         nBB4TAuJXW4px6KrJaICQ2J83RiD37QibEa1fnsgaNmmkpBU+Z/EPoenLGe8/21aYh6Q
         s96Q==
X-Gm-Message-State: ACgBeo2xhbbbQIbkOYoRkOVa5fTEOgqzWhg8kg5g9coZaMsZbAs6Z/CI
        GevU+4KdTOCHxG9cPVOat/Utlw==
X-Google-Smtp-Source: AA6agR730B3CFYUgs1dVi5uDB6Aw0n6UU9CaEwfSOINZu0psxKmo9L85hcMqZ1/m71geee8z8vXp/A==
X-Received: by 2002:a2e:bd12:0:b0:264:7373:3668 with SMTP id n18-20020a2ebd12000000b0026473733668mr7029636ljq.18.1662980603279;
        Mon, 12 Sep 2022 04:03:23 -0700 (PDT)
Received: from [10.129.96.84] ([109.232.243.34])
        by smtp.gmail.com with ESMTPSA id x28-20020a2ea99c000000b0026bfadf87e3sm776339ljq.20.2022.09.12.04.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 04:03:22 -0700 (PDT)
Message-ID: <eea8e746-6561-71ca-12f0-d010a0672edf@linaro.org>
Date:   Mon, 12 Sep 2022 13:03:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RESEND PATCH v9 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Content-Language: en-US
To:     Kavyasree.Kotagiri@microchip.com, robh@kernel.org
Cc:     Claudiu.Beznea@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, krzysztof.kozlowski+dt@linaro.org,
        Nicolas.Ferre@microchip.com, lee@kernel.org, robh+dt@kernel.org,
        Sergiu.Moga@microchip.com
References: <20220908150658.1839520-1-kavyasree.kotagiri@microchip.com>
 <20220908150658.1839520-2-kavyasree.kotagiri@microchip.com>
 <1662671776.565921.3355400.nullmailer@robh.at.kernel.org>
 <SA2PR11MB48742AF8A0C9BC6D32D57A2892439@SA2PR11MB4874.namprd11.prod.outlook.com>
 <CO1PR11MB48654A4239AB7A760193497992449@CO1PR11MB4865.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CO1PR11MB48654A4239AB7A760193497992449@CO1PR11MB4865.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2022 10:16, Kavyasree.Kotagiri@microchip.com wrote:
>>> flexcom@fc018000: spi@400: Unevaluated properties are not allowed
>> ('dma-
>>> names', 'dmas' were unexpected)
>>>         arch/arm/boot/dts/at91-kizbox3-hs.dtb
>>>         arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
>>>         arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
>>>         arch/arm/boot/dts/at91-sama5d2_icp.dtb
>>>         arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
>>>         arch/arm/boot/dts/at91-sama5d2_xplained.dtb
>>
>> dma properties for spi node is already being covered by Sergiu in below
>> patch:
>> https://lore.kernel.org/lkml/b4625526-8f9b-ada8-f854-
>> 751a48545576@linaro.org/
>>
> Hi Rob, Please let me know your comments.

this means it cannot be currently tested. Are you sure that there are no
warnings in all DTBs with your patches?


Best regards,
Krzysztof
