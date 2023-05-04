Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D6B6F65BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjEDHcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEDHb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:31:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBFC2D40
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:31:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-965a68abfd4so20561366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 00:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683185514; x=1685777514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=miV7b+SshaQlHrD2jqZS3Us38P+QM+iYksIAvVacfxk=;
        b=zrOnMPWAnce687JSlYUR27AdFML+XzKEnjg24lepkBzDlxOuyi3iCF94+CVHNcGGKs
         lbXyiVZDtuS8IUgcJgu7OiGb83e5sdTyVPckDjZEbTMc/nDUE4uut1PTq3AG/LfFMsjH
         EsOOLyqLdr9SJUTjkVs639ivEC8fcHxnbi4SUeCrY4+BZmnLOt+AIX+Us8tCVr1yT/zI
         ad1vNzBMrw9FzOZCULvuW7r54MzVSTE8fZEfGidkqlSlCjx/CFvjsPfuFYAQx6rv0HdX
         1QnoktYzMkCxavN8ICrSmAgMhors+DxbQp2t2O+xF/zVbX3nCgCKNBdf+Zj0/5JeUUr4
         b4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683185514; x=1685777514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miV7b+SshaQlHrD2jqZS3Us38P+QM+iYksIAvVacfxk=;
        b=IChqD1Ghn9A6buyTisqLCu7YAAh/oiOETHanzrC2EyecJddh9eQYlH34EVLuxzAARu
         eHRh4JUVPXh2gj54K7AcNJSbdGtIq0RMBsQ71WF9nsFiQGwpFiZp+de0/LQavbDjOno7
         +8R8+A7fWU1SocYiSfZPFgW2HFqsssg5QSIPZ/6hkh17skXaC9paZq2qypvvJoz7AriS
         mSibUKtDFaQ/A1GziijIWixkN88jCTSPlVG6maTOvbfjhS5GaFiMGyTIeAPnPFbNvTJe
         pX35Ruu4xgKOYNUjT7fULBf8PURkGgjRzwVo5njOPHryT2sWhlntdutds6iDUkmSqLyV
         RoLA==
X-Gm-Message-State: AC+VfDyVJCfxz4+mB0/4Qi1OTXn13qCLUJ7S2O6LqdCzAWiHvCMKA+yt
        z1rRNGybtEALuU/YP7VlXR5pIA==
X-Google-Smtp-Source: ACHHUZ7pAW7s9g3po57k0AkL6h6LbDWiYlNgz4s2ncT/hDscFpRG5nwoXCfZhtRy6isyrcLNBlpahw==
X-Received: by 2002:a17:907:3209:b0:94e:8d26:f610 with SMTP id xg9-20020a170907320900b0094e8d26f610mr4773457ejb.28.1683185514476;
        Thu, 04 May 2023 00:31:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id u13-20020a170906c40d00b0094aa087578csm18626016ejz.171.2023.05.04.00.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 00:31:54 -0700 (PDT)
Message-ID: <d5763073-3aaa-8a7f-1336-337c125b1a0e@linaro.org>
Date:   Thu, 4 May 2023 09:31:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] dt-bindings: usb: Add binding for Microchip usb5744 hub
 controller
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com,
        ilias.apalodimas@linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <cca068980ae0b902168a9a9b78cab4efb43157a8.1683121150.git.michal.simek@amd.com>
 <4aa7adbf-f89e-6819-64d2-5942a456528a@linaro.org>
 <eb325b2a-d265-d8bb-8e98-9eef8f03355a@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <eb325b2a-d265-d8bb-8e98-9eef8f03355a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 09:25, Michal Simek wrote:
> 
> 
> On 5/4/23 08:46, Krzysztof Kozlowski wrote:
>> On 03/05/2023 15:39, Michal Simek wrote:
>>> The Microchip usb5744 is a SS/HS USB 3.0 hub controller with 4 ports.
>>> The binding describes USB related aspects of the USB5744 hub, it as
>>> well cover the option of connecting the controller as an i2c slave.
>>> When i2c interface is connected hub needs to be initialized first.
>>> Hub itself has fixed i2c address 0x2D but hardcoding address is not good
>>> idea because address can be shifted by i2c address translator in the
>>> middle.
>>>
>>> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>> It looks like that usb8041 has also an optional i2c interface which is not
>>> covered. But it is mentioned at commit 40e58a8a7ca6 ("dt-bindings: usb:
>>> Add binding for TI USB8041 hub controller").
>>>
>>> i2c-bus name property was suggested by Rob at
>>> https://lore.kernel.org/all/CAL_JsqJedhX6typpUKbnzV7CLK6UZVjq3CyG9iY_j5DLPqvVdw@mail.gmail.com/
>>> and
>>> https://lore.kernel.org/all/CAL_JsqJZBbu+UXqUNdZwg-uv0PAsNg55026PTwhKr5wQtxCjVQ@mail.gmail.com/
>>>
>>> the question is if adding address like this is acceptable.
>>> But it must be specified.
>>
>> Why? phandle points it explicitly.
> 
> Ok it means just list usb hub on i2c with label and point to it. Works for me.

Right. I missed you want the address of the hub but phandle goes to the
bus. I think listing it on I2C bus (see
arch/arm/boot/dts/vf610-zii-scu4-aib.dts) should work. I think we can
have I2C devices without compatibles.

The problem is that property should have only one definition/type and
i2c-bus is already used in other cases as just "phandle". If we go with
your phandle+address approach, then this should be phandle-array with
items and then we have two different types.

Best regards,
Krzysztof

