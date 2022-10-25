Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94B760D4F0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiJYTt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiJYTtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:49:55 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BCF12AEA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:49:50 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id x3so1376413qtj.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U41pkWnztK+i9UJZd7s5z8LIiVyrhcfeu311i/JqJM8=;
        b=ZFG1ze7gQ7pP9QhmCO1qgsX4LR7vZ+Ynt4b8aO3aFFIEKuPT8tgKjsSX7OM/4eTdVC
         ZxvD1/1lu9Bh8KZbEvVZvL2r5tDCA4CSmu5jx4bgYS7ntOiqdtbM8qflPN6ghUGkyWEs
         N5YGlO0vt6YEWRI67ygYiusJcCdF85emAit/aspDfJV1xfNtPt+5z/RNHUSdbNqZUaku
         bUHCqGd/t1nsm1KesFxjIubI7j0YtQKOoIhJqWRVHr3nRisd+ph0qKSgTW8L8UE0RmgR
         n6wdWL02OktzsVki8tx47w9YfJex8dkas7SD9gG8i9CBq2Dw+NBeyeIe/ApVZIT5HP6v
         4JWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U41pkWnztK+i9UJZd7s5z8LIiVyrhcfeu311i/JqJM8=;
        b=IrekvvxO/Z3+94vK9gUWIfbpALSH1v/K0MFRV6pHY/qjjYT2lAaYFyBl0MreNAosOt
         0CbZk6wPSEKHJ3rma26Tv2PIxAjbdJwW+C7EUbMcwsiMMAnX7ZtoBYeH9krco1Cbp0I1
         mTuPQfOuOZwVEl/x5fW1/yvE/lSu8UlWUtdJ0o+E2zE5c2L541OB9b3UHxjLnT3J6fMA
         j5z+72Uozg8RnH8XGnAh6lLLvhHZuEyuNqPUyyj2PCugRLfMmeiJDlIVYuOMwCadQFJW
         0M1rFsdHjmEurZZXjVpKyw17/HoYz/d58t0hu9fdbLvGjgIuUhTP3wLCRR5XfcZwbqdd
         kTgA==
X-Gm-Message-State: ACrzQf1R3wEnwroAcSicyBCP8ntCfJl2fAbzJQEFP2KMzEmUeAEwHIwb
        TAMDz5+ex3UwuC/+3IF6+XsS1w==
X-Google-Smtp-Source: AMsMyM6+s9yLCfeEgg3kbixXLX/jGhSq3bpEZpjwl3Rb1L5e21mSdwAl7KYOL2J9lqP6sxLZLiBvuw==
X-Received: by 2002:ac8:5d93:0:b0:398:3709:945c with SMTP id d19-20020ac85d93000000b003983709945cmr33024036qtx.459.1666727390012;
        Tue, 25 Oct 2022 12:49:50 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id d20-20020ac851d4000000b0035bafecff78sm2023136qtn.74.2022.10.25.12.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 12:49:49 -0700 (PDT)
Message-ID: <5dc85333-b265-ab10-74db-1ed969630813@linaro.org>
Date:   Tue, 25 Oct 2022 15:49:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 2/5] dt-bindings: soc: hpe: Add hpe,gxp-plreg
Content-Language: en-US
To:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
 <20221011185525.94210-3-nick.hawkins@hpe.com>
 <CAL_Jsq+xb2Ltfne4mQMXQAde-eHS7TsO73YZ-vhE7nK1Z_M0gw@mail.gmail.com>
 <DM4PR84MB192795B45639710259E9B19D88229@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <820095a2-3722-5c3a-77fb-5a6b6b44e1c3@linaro.org>
 <DM4PR84MB19275A47D7006BD5664E1AF488319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <d51b7f8d-3681-e19d-3ebb-7e021fc50403@linaro.org>
 <DM4PR84MB19275D8DB8B27CE0D1A05AA588319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <7c9e943a-4806-6339-cee1-9156e7792111@linaro.org>
 <DM4PR84MB192759035B110DE54EA9B63688319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <0b6dd763-365d-6f35-59cb-18c599b73d3a@linaro.org>
 <DM4PR84MB197662C12018090C312AF72DD6319@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DM4PR84MB197662C12018090C312AF72DD6319@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2022 15:39, Verdun, Jean-Marie wrote:
> Hi Krzysztof,
> 
> I think what we try to do is to introduce an abstraction layer between the interfaces and the drivers, as our CPLD interfaces are platform dependents. I mean the Power On control could be at address 0x09 on one platform or 0x119 on another one. We would like to find a way to avoid to have to change the driver code, but just feeding the driver with relevant datas, which could be into a platform dependent include file or through the proposed solution that Nick is promoting.
> 
> If the CPLD memory address space was consistent between platform and generation that would be great but unfortunately that is not the case that is why we try to break down the dependency into the driver code and retrieve the data from another place.
> 
> JM
> ________________________________
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Tuesday, October 25, 2022 12:33 PM
> To: Hawkins, Nick <nick.hawkins@hpe.com>
> Cc: Verdun, Jean-Marie <verdun@hpe.com>; krzysztof.kozlowski+dt@linaro.org <krzysztof.kozlowski+dt@linaro.org>; linux@armlinux.org.uk <linux@armlinux.org.uk>; devicetree@vger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-arm-kernel@lists.infradead.org <linux-arm-kernel@lists.infradead.org>; Rob Herring <robh+dt@kernel.org>
> Subject: Re: [PATCH v1 2/5] dt-bindings: soc: hpe: Add hpe,gxp-plreg
> 
> On 25/10/2022 15:26, Hawkins, Nick wrote:
>>
>>> I don't know exactly what type of devices you represent in that plreg, but in general the fan device would be the respective plreg. The same with other pieces like hwmon, power supply.
>> We were primarily representing the registers that translate to the CPLD input/outputs from our platforms as well as handling the interrupts associated with those inputs/outputs.
> 
> So basically each register (or set of registers) is a device? How is it
> different than any other multi-functional device? Why do you want to
> model it differently?

How is it different, I am asking?

> 
>> When you say "would be the respective plreg" do you mean that each device/controller would need to perform the actions plreg does individually? In that case how should we get information for that register/memory region and interrupts from the dts? Could it be something like this:
>>
>> plreg: plreg@d1000000 {
>>       compatible = "hpe,gxp-plreg";
>>       reg = <0xd1000000 0xFF>;
>>       interrupts = <26>;
>>       interrupt-parent = <&vic0>;
>> };
>>
>> fanctrl: fanctrl@c1000c00 {
>>       compatible = "hpe,gxp-fan-ctrl";
>>       reg = <0xc1000c00 0x200>;
>>       plreg_handle = <&plreg>;
>> };
>>
> 
> No, rather these are one node.
> 
> You insist to represent this all as programmable logic, but why? CPLD,
> FPGA, ASIC, dedicated IC - all are just implementations and for us
> what's matter are the interfaces, inputs and outputs.


And seriously... this is not a chat. Take a bit of time to answer these
questions instead of replying immediately with a same response as yesterday.

Best regards,
Krzysztof

