Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1522631E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKUKgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKUKgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:36:51 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE3F286EE;
        Mon, 21 Nov 2022 02:36:48 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso12403353wme.5;
        Mon, 21 Nov 2022 02:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R611slSDxNRO/QG8lfrrPsckzIVCVuOTAefHH2t0jQQ=;
        b=HXKZvoAP+gEhaxt9XRf+cl+d+FGAWY+FJRkANVTTF3mPW/WAfT2y0IGH9qoyXIr1dO
         Ejl5eWZQWYWOEiTmwx9GuoTcdkX/ALNkXAWwQS/TsKqgQYRSNgxfYhzaJmjmVMvwNgK7
         NDs6KqOqxBC8+Uhuvw6w3ksRJv9Jm0RNIbjYkPGPkvzgxiLbzPxyyH+tgVXQRPApRObS
         OLiHXV3MEV1JLwkIrjBiYafobCVAMOiwsc5I0iCLHYVqwJqEoMhwIcBNGYg3MuwrS6o8
         Kkp22TSaa8CHcFe5Uhhs9xk3itPUooiyMjazqWRU0qUouOIJTLzwyxt4NyfGotdkgbx/
         Xmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R611slSDxNRO/QG8lfrrPsckzIVCVuOTAefHH2t0jQQ=;
        b=7BWU1NIIgkkdjSBVJq2fLLGxFx6+lT4aphwUPltKw4GHf+hAwZ6sEUAdfLhynZiBS9
         uDVTUt1uhuFrz0gVvtn08HRQJK6G3/EaAXtFPzL7sXjDhXlAjCrASamZXb/SvVGJF4yL
         60bzN4bVUpGT13n9wAJqJWr3oWtGgNdGYDw2CQig08/A7WkvM2gtu+RyGmZ6ckrp6/J/
         gWDzubZGeRZlQNqPeCY7OVpZqxVAEZJZr5nPy6uPg3Th4CuzWFVnY/o5Rls59gcVrfb2
         4nYUwXpduVXWIahEhjc/R/mQtVYA7Qq3T5SlVMaz6vgKRBsmj/4QazKybz5QEiSa+uoQ
         ju9Q==
X-Gm-Message-State: ANoB5pnp3q/rM2QVOQ8vdwtS21PzoUi1UCwVgPEA+0iDHFHRt1ik5/cz
        x3omurO+433y0M5EwsCwTsI=
X-Google-Smtp-Source: AA0mqf6FY//xlj2qEIdLRF1cO7s18ksBEebGiYyGw8vW5x3Xe8fSZGRZuq3KgGsv6MaakzZ6aFIM+Q==
X-Received: by 2002:a05:600c:1d9c:b0:3c6:bf1e:ebb9 with SMTP id p28-20020a05600c1d9c00b003c6bf1eebb9mr15311335wms.173.1669027006530;
        Mon, 21 Nov 2022 02:36:46 -0800 (PST)
Received: from [10.32.3.204] ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id s23-20020a1cf217000000b003c6c5a5a651sm13048074wmc.28.2022.11.21.02.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 02:36:45 -0800 (PST)
Date:   Mon, 21 Nov 2022 13:36:37 +0300
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: power: supply: Add DT schema for
 Qualcomm SMBCHG
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
Message-Id: <1H1PLR.S9UFOHIJCU6S@gmail.com>
In-Reply-To: <795deac4-71fe-d40b-a3b6-855eb3875ad1@linaro.org>
References: <20221120154625.57095-1-y.oudjana@protonmail.com>
        <795deac4-71fe-d40b-a3b6-855eb3875ad1@linaro.org>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Nov 21 2022 at 09:26:59 +01:00:00, Krzysztof Kozlowski 
<krzysztof.kozlowski@linaro.org> wrote:
> On 20/11/2022 16:46, Yassine Oudjana wrote:
>>>>  +  interrupts:
>>>>  +    items:
>>>>  +      - description: Charger error
>>>>  +      - description: Charger inhibited
>>>>  +      - description: Charger precharge safety timer timeout
>>>>  +      - description: Charger charge safety timer timeout
>>>>  +      - description: Charger pre to fast charging switch 
>>>> threshold reached
>>>>  +      - description: Charger recharge threshold reached
>>>>  +      - description: Charger taper threshold reached
>>>>  +      - description: Charger charge termination threshold reached
>>>>  +      - description: Battery hot
>>>>  +      - description: Battery warm
>>>>  +      - description: Battery cold
>>>>  +      - description: Battery cool
>>>>  +      - description: Battery overvoltage
>>>>  +      - description: Battery low
>>>>  +      - description: Battery missing
>>>>  +      - description: Battery thermistor missing # unconfirmed
>>>>  +      - description: USB input undervolt
>>>>  +      - description: USB input overvolt
>>>>  +      - description: USB input source detected
>>>>  +      - description: OTG regulator failure
>>>>  +      - description: OTG regulator overcurrent
>>>>  +      - description: Automatic input current limiting done
>>>>  +      - description: USB ID pin changed
>>>>  +      - description: DC input undervolt
>>>>  +      - description: DC input overvolt
>>>>  +      - description: Power OK
>>>>  +      - description: Temperature shutdown
>>>>  +      - description: Watchdog timeout
>>>>  +      - description: Flash failure
>>>>  +      - description: OTST2 # unknown
>>>>  +      - description: OTST3 # unknown
>>> 
>>>  It seems you listed register interrupts, not physical pins. This 
>>> should
>>>  be interrupt lines.
>> 
>>  I'm not sure what I'm supposed to do here. I couldn't find an 
>> interrupt-lines
>>  property used anywhere so that's not what you meant, right?
> 
> Are these physical interrupt lines this device has, register offsets 
> or
> virtual interrupts (e.g. passed via irq_chip)? Definitely not the 
> first
> and rather offsets for qpnpint_irq_domain_translate. Devicetree is not
> for describing register layout of devices. IOW, register layout does 
> not
> change on different boards, because the device is exactly the same, so
> there is no point to put it into DTS.
> 

So how would I describe the interrupts then? Or if you are saying I 
shouldn't have these interrupts in DT at all, how would I get them and 
register handlers for them in the driver? the PMIC arbiter takes 4 
interrupt cells, 3 of which are these offsets specifying the peripheral 
and interrupt. All other PMIC peripherals currently described in DT 
(examples being qcom,pm8916-wcd-analog-codec, qcom,pm8941-pwrkey and 
qcom-wled) have their interrupts (if any) described this way, with the 
only exceptions perhaps being the GPIO and MPP controllers which are 
themselves interrupt controllers. Changing the way PMIC peripheral 
interrupts are described would require changing PMIC arbiter bindings 
and code which I believe is out of the scope of this patch series.


