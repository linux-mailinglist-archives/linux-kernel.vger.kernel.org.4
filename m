Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F280725514
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbjFGHKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238677AbjFGHKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:10:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB0E19B6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:10:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9745c5fed21so886935966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686121809; x=1688713809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNbd0rV0wgo4TlBHE0Z+HQIt/9tYb3WUn2Xisg5I4Vk=;
        b=UOSj4A+2ZRDTz2ZtgutALrHXYmvxP82XQkIEWX5OyM4RK3+i2hw5jh9/t/vT+D6xP0
         C5jQg/TV6Qk3cOSJgmDaFnNbkCcBkNSheyfauSsdM5ZP4o3gyWe6x85+0Cd2ntOe1kRe
         yiWkhIGIpVEr35zhrEWAYou+0Q5j/0X3PPEkS1AT4MgWBVlHVRnfZdJTGypF0t6EgUIY
         8am/szsW/5k//patGgsMyH3FCAqRqDe6o5tZnVgouzp68VDOppdXE2Jqh3EkIkXkjW6Y
         JGAdMAWsWWRjZOIZ70i3I6JNz7RJtrMtaVaBM57nyZdhRHS3S/NlEJYLdyBVdS1Rp5YD
         Ud9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686121809; x=1688713809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNbd0rV0wgo4TlBHE0Z+HQIt/9tYb3WUn2Xisg5I4Vk=;
        b=dj/odBtP0ArX+PYmUzlh6fTCEuOirhigzvUAWCCNIF1wOB/jz8CNfHxYqI2BAtDEYs
         LX+P8TZ5f7QUtUue4JqKgaSb1NvEsIidpQkkvI3M96NIns79na3y2Aem4TXi7byIXYM6
         src/sLhSzstfKJUQODkSCDd22vTWDPtY53J+WJWWcYLycqLVJRDGyrXIWvO7LO0RvArn
         +cRen/rzsZDo5lsuHkmfbTlqrOqkcx11NTwMDsM4453NwcrZ+K0by6d2fuD8pGachvmI
         32URklFil4s8z3l69Pa17zlYxi6Ly2OJXnys2B6fj+W0x2Z/eayyYx7p8E01T0+8pqtt
         opMQ==
X-Gm-Message-State: AC+VfDwj6u+V8tRNVeKl0gJO1vhlqqRngd+K7ZtyLgNVvU1Q5ssc4zhy
        hfSiA8OB5THT/Mh/6fEzl7EB2w==
X-Google-Smtp-Source: ACHHUZ7aeESog1csl2k7sGYQ2vfcQCGBYNFejR21FOhToVA+9TBvt7DhY+vJamrZ7lva5yKLFFVEcA==
X-Received: by 2002:a17:907:3f9a:b0:96f:8666:5fc4 with SMTP id hr26-20020a1709073f9a00b0096f86665fc4mr6012541ejc.50.1686121809565;
        Wed, 07 Jun 2023 00:10:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id fx4-20020a170906b74400b00977d0f1c5bcsm4203514ejb.69.2023.06.07.00.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 00:10:09 -0700 (PDT)
Message-ID: <742d3161-3a4d-ea77-7bd4-85f6636bf400@linaro.org>
Date:   Wed, 7 Jun 2023 09:10:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [v5 3/5] dt-bindings: mfd: Add aspeed pwm-tach binding
To:     Billy Tsai <billy_tsai@aspeedtech.com>,
        Patrick Williams <patrick@stwcx.xyz>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee@kernel.org" <lee@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-4-billy_tsai@aspeedtech.com>
 <35bf0a69-bcf6-ae35-eb3c-e74cfcf9c571@linaro.org>
 <ZH89fXknZlhGmM_H@heinlein.vulture-banana.ts.net>
 <c28f963e-d13c-6b5c-c389-996e986f81d5@linaro.org>
 <SG2PR06MB33652E18980E9CF8E4F0894D8B53A@SG2PR06MB3365.apcprd06.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SG2PR06MB33652E18980E9CF8E4F0894D8B53A@SG2PR06MB3365.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 08:26, Billy Tsai wrote:
>         On 06/06/2023 16:06, Patrick Williams wrote:
>         >> On Tue, Jun 06, 2023 at 12:49:04PM +0200, Krzysztof Kozlowski wrote:
>         >>
>         >> Hi Krzysztof,
>         >>
>         >> Thank you for reviewing this from Billy.
>         >>
>         >> The Aspeed chip is heavily used by the OpenBMC community and the 2600
>         >> has been used in production systems for almost 2 years now.  Many
>         >> companies are having to carry previous versions of these as patches, and
>         >> some of the APIs changed since the last revision from Billy.  So, I had
>         >> asked him to submit the latest patch set with as many revisions as he
>         >> understood what to change, since the conversation seemed to have died
>         >> since last time he submitted.
>         >>
>         >> I don't believe Billy is intentionally ignoring your feedback and he is
>         >> motivated to get this patch set wrapped up into an acceptable state.
>         >>
>         >>> On 06/06/2023 11:45, Billy Tsai wrote:
>         >>
>         >>> NAK. You got here clear comment. You cannot have simple MFD with
>         >>> resources. It is not simple anymore.
>         >>>
>         >>
>         >> In fairness, Billy asked for clarification from you on this point and didn't
>         >> receive it.
>         >>
>         >> https://lore.kernel.org/lkml/24DD1FEB-95F3-47BE-BE61-8B0E6FBDE20F@aspeedtech.com/
> 
>         > I gave the instruction what Billy should do:
> 
>         > https://lore.kernel.org/lkml/41500a04-b004-0e2c-20a1-3a3092b90e6d@linaro.org/
> 
>         > What about other ignored comments? About subject, quotes and more? Even
>         > if this one was unclear, then why ignoring all the rest?
> 
> It's possible that there was some confusion regarding your message. I apologize for any misunderstanding.
> About the subject: I apologize for the misunderstanding. I just drop the redundant "bindings" in the commit message.

Read entire message, not some parts of it.

"Subject: drop second, redundant "bindings".
Also use proper PATCH prefix."

Where did you drop the bindings in the subject? I still see it, look:
"dt-bindings: mfd: Add aspeed pwm-tach binding"
                                       ^^^^^^^^ what is this?

> About the quotes: I believe the issue was simply related to the order of the patches, and I have resolved it. Did I misunderstand?

I still see them, so how did you solve them?

> About the Missing description:
> 
>> +patternProperties:
>> +  "^fan@[a-z0-9]+$":
>> +    type: object
> 
>> Missing description. But more important - why do you have such child
>> nodes? Your example does not have them. What's the point? Do you expect
>> different number of fans per one device (one compatible)?
> 
> In this patch series, I have included examples and descriptions to provide additional information.
> The child node is used to enable the channel of this tach controller.

You do not need children for this.

> I expect that the dts will include information regarding the number of fans connected to the board and their corresponding channels.

Your example DTS must be complete and nothing like this was there. There
is still no point in the children.

> 
>         >>
>         >> He felt what he was trying to accomplish met the documented
>         >> expectations.  Are there some changes that need to be done in mfd.txt to
>         >> further clarify when to use it and when not to?
> 
>         > I think mfd.txt clearly states:
>         > "For more complex devices, when the nexus driver has to
>         > probe registers to figure out what child devices exist etc, this should
>         > not be used. In the latter case the child devices will be determined by
>         > the operating system."
> 
> About the mfd:
> For our pwm and tach devices, there is no need to check/apply any hardware register from parent to determine child’s existence or functional.
> They don’t have any dependency on the parent node. 

You are joking right? The dependency is clearly visible in the driver.
You are getting parent's node to get its resources. That's the
dependency which is not allowed. Children should take care of their
resources, not parent's!

> In fact, it doesn’t require a specific driver to bind with the "aspeed,ast2600-pwm-tach" label. Their purpose is solely to share the same clock, reset phandle and base address.

That's what the drivers are for, so you need it...

> The main reason for using simple-mfd in this case is because these two independent devices share the same base address. In fact, I can relocate the clock and reset configurations to the child nodes rather than the parent node.

How? These are clocks of parent. Don't create fake DTS to represent
workarounds. Or you want to say that current DTS is fake and does not
match the hardware?

>  In this case, I still can't use simple-mfd?

For the last time: No. You cannot, because you have resources needed for
children.

Best regards,
Krzysztof

