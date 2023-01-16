Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED5066B9FD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjAPJPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjAPJOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:14:39 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327F713D62
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:14:37 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v10so38633325edi.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XD8R6KSRXSrAMFQ28g15vWx+7evq6kq5Ndl6EQERPMQ=;
        b=DTjCGii7ePDb7Y0xU20aar/RKW18t1mNHdNYR6RSFUVTYFb4OVYVLY/zTddNY2bHZm
         ucO+GDgjfA4n0l6EZUR3A+8e0mDfbhAI/gb4wqy+rcmAb3ChXMuO/3n6+7Iy0Zpp9OUy
         GWc+/j/q/6s+JjUMeB9nkl1KobAe6GhPTiWqQQqwzCcDVq+poYmX6210EJ3eK7/M2tL9
         c0a1Y5oaSHsh2UgacLBSAgOwgIORkSnWtQEyuvPWvGjiOUX1Wx6n0Hz7fXO+fviUW/fZ
         zydmAJS7X9Yek9SJgPzn7Txx4vKuU/EOYkb1LGcIyeCXpXqs5HcmDhIGl0x9udOgC2vZ
         I5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XD8R6KSRXSrAMFQ28g15vWx+7evq6kq5Ndl6EQERPMQ=;
        b=umSwNaBEy3nQnwrg0bsZE2jt+7glhROaEFH/ywxl+aOcqA0Bi6/6KgTzSqGGiz09/R
         2wbEqhS3RVg0kzY0x+O0iAIhfh6/CDVPdGp+rkWmUk1zEogAagY+ySJWAQQ2hpnBmGZ/
         ErfgM0aqhz2YB7/+PLE1XKGJ9ql+GjkihOblRoW+KY8+1xNK5Ib2NEHZ3mIlC3Qx02ZU
         1ff2ItFoCXHAGa+cVT3dIkXh0732KM5THzWasxM90CmCuXf7qv/fH9RDoFq4T54fMemH
         lgV3G8k5GnFFqf6i7Z8kILJqlqSRXtII9NZXNq2uKp1OE1OYx0yJvm3Y9OPEVslcljY4
         XjQw==
X-Gm-Message-State: AFqh2kpHK3CnNzaYbZ4p27cgN4W8AMyEvlRHdLzN4GnDTDF8TFY7ndOo
        dIXVS2kQCt5LJ9oUl8Eay0WfBA==
X-Google-Smtp-Source: AMrXdXvnbXFShYdOval9Ul8ytyMGsGof5b2hWy22b4i8Tr4ErSn0wcjrwogcCAfUdvSn7EylfMYVrA==
X-Received: by 2002:a05:6402:390b:b0:465:f6a9:cb7b with SMTP id fe11-20020a056402390b00b00465f6a9cb7bmr80004456edb.12.1673860475810;
        Mon, 16 Jan 2023 01:14:35 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v22-20020aa7d816000000b0049dd7eec977sm2452195edq.41.2023.01.16.01.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 01:14:35 -0800 (PST)
Message-ID: <1b5613ad-6d0d-0979-ddd0-4677ade7beb9@linaro.org>
Date:   Mon, 16 Jan 2023 10:14:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] ARM: dts: imx6qdl: support child mfd cells for the
 reset controller
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Bastian Krause <bst@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230113-syscon-child-mfd-v1-0-0dd31b7de373@pengutronix.de>
 <20230113-syscon-child-mfd-v1-2-0dd31b7de373@pengutronix.de>
 <392f6e9d-b7c2-37df-2067-f7d967a20f10@linaro.org>
 <12080bf5-2cc4-e215-555e-5438ed1bd851@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <12080bf5-2cc4-e215-555e-5438ed1bd851@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 09:27, Ahmad Fatoum wrote:
> Hello Krzysztof,
> 
> On 16.01.23 09:20, Krzysztof Kozlowski wrote:
>> On 13/01/2023 18:32, Bastian Krause wrote:
>>> The actual syscon-reboot-mode child node can be added by a board
>>> device-tree or fixed up by the bootloader. For the child node to be
>>> probed, the compatible needs to include simple-mfd. The binding now
>>> specifies this, so have the SoC dtsi adhere to it.
>>>
>>> Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>>> Signed-off-by: Bastian Krause <bst@pengutronix.de>
>>> ---
>>>  arch/arm/boot/dts/imx6qdl.dtsi | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
>>> index ff1e0173b39be..b16be39458aa6 100644
>>> --- a/arch/arm/boot/dts/imx6qdl.dtsi
>>> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
>>> @@ -865,7 +865,8 @@ epit2: epit@20d4000 { /* EPIT2 */
>>>  			};
>>>  
>>>  			src: reset-controller@20d8000 {
>>> -				compatible = "fsl,imx6q-src", "fsl,imx51-src";
>>> +				compatible = "fsl,imx6q-src", "fsl,imx51-src",
>>> +					     "syscon", "simple-mfd";
>>
>> You need children here. Otherwise simple-mfd does not make sense. If you
>> expect something else to add children (I don't understand why, usually
>> reboot capability is fixed per SoC and only sometimes extended with some
>> other means), then this "else" will also change compatible.
> 
> It's about syscon-reboot-mode, not syscon-reboot. Such modes are board-
> not soc-specific. 

syscon-reboot-mode is also mostly SoC specific. What exactly would
differ on different boards? Register offsets of SoC component? Register
values used by SoC power management unit?

Anyway, the binding is then not correct - it does not allow
syscon-reboot-mode child. I'll comment there.


Best regards,
Krzysztof

