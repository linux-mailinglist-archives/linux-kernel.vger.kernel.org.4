Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEEA6F65B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjEDH0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjEDH0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:26:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE613596
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:26:27 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc22805d3so140006a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 00:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683185186; x=1685777186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Veea/UdjGX427jFOli9vB9D6CHqmWA/T+0M7h9xVaJE=;
        b=Cb16lGCLHN1QqCy5MTQ6fwtjmgT/VdffV3xWOGUsBe8guwFY8wzvsY6Q6QwA5GQ66t
         A3Jgg64o5Fbr8KT8F4BO7Tb2NxUPsgAtNSBUUQH1dPh51+R71M3TUbMLyYZJN5eNqqb9
         p2dwFabC7DG7jPueCR4PS+pXJZ3ZO92/t4lKijJqloJ5YTYJBzUBw0wjsUvDxCAjvLQe
         IWN+P5WA6Psary2jwEJ7ZWIAl6Xw3qp8iu4WY9xK606iUK3rEQzt1dn75cpES0EIKj1r
         dwV8e+GHmtEAmqLIDhLCnREyST9qFEErCz1yQAA2D6jy03Sn4ALsk267Wd/zJgLVs/k8
         0ktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683185186; x=1685777186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Veea/UdjGX427jFOli9vB9D6CHqmWA/T+0M7h9xVaJE=;
        b=RvZS9RicT9TWqXKqNsvJvOhdwtmSyVnOzMj1KZQBOHWqDltmi06J2mATFK8YS7eEhc
         dbZG8+7iF7Vlhaj90a4GfBu2UWSwpqCg4MzEL850iHl2ZkS7fpetIQfp0YiJ+kzV+T/n
         QNWgSYk8HM75GbwBIvL7EfIf1+RLdx7R8mIAUR0OwyqiM9N9LVvLiwf6MEPHSWHfj8z4
         XQj+B7x1XHsENIJNoRVMMkrHjL9dwBzQC63wKgbtJ1xJxEPhANmjbFxddid0hJnaD3+C
         yDM7u2JX8OpJNcDSUETk+V51zX4vIfVVB1bSHVoX7MzypgnUR2RYgYRklxk2qREN/Oix
         hI9A==
X-Gm-Message-State: AC+VfDzjfuruOaXrk+FW7ZqEbLKm3ToMv8TQIfj9I+L38skgnuQ3w/70
        t2XTKO3wksQba7Nbe8bhu9O/+w==
X-Google-Smtp-Source: ACHHUZ6x7SMojw1hUma3+8M6WtWKOixbNJW5a+nedr/mf1YnHqtTnFcwCnsf9OGKAF/fwPEKoE65Lw==
X-Received: by 2002:a17:907:360a:b0:94f:c72:1ddf with SMTP id bk10-20020a170907360a00b0094f0c721ddfmr5234499ejc.41.1683185186192;
        Thu, 04 May 2023 00:26:26 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id gz9-20020a170907a04900b00965a52d2bf6sm598741ejc.88.2023.05.04.00.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 00:26:25 -0700 (PDT)
Message-ID: <1ac26c1a-1726-515d-6598-849a07ed0b86@linaro.org>
Date:   Thu, 4 May 2023 09:26:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RESEND v2 1/6] dt-bindings: power: Add JH7110 AON PMU support
To:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org
References: <20230419-labored-camper-644d51a7ca96@spud>
 <1a5b15fa-4f20-51c2-2ba1-a04a2911a694@starfivetech.com>
 <20230424-baffle-punch-ec73098f2b6a@spud>
 <d685a1d4-c07d-7dfa-f1fb-b35ceb2aa0eb@starfivetech.com>
 <20230425-unquote-eligible-09f743d81981@wendy>
 <a7cdfabf-2312-eaf3-f462-5bda7f0a120d@starfivetech.com>
 <68cb565d-bf39-10b0-9e3e-35ba7f54b90b@linaro.org>
 <0988495f-b87a-7f69-f222-37c67d6eae23@starfivetech.com>
 <20230425-resale-footrest-de667778c4fe@wendy>
 <663e9933-b9b3-a48f-98b6-2207215a8ed7@starfivetech.com>
 <20230425-commotion-prewashed-876247bed4ab@spud>
 <0b0f9187-ad6b-a1d9-6ec4-beb8989ca731@starfivetech.com>
 <3ed72340-accc-4ad1-098f-4a2eb6448828@linaro.org>
 <482e812a-05dd-105c-189c-e926b4be9d28@starfivetech.com>
 <089e24d1-588a-4a56-f00b-0b35d1d99295@linaro.org>
 <ea5b5534-8fc2-7c84-a011-c1b42c6ed7a0@starfivetech.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ea5b5534-8fc2-7c84-a011-c1b42c6ed7a0@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 09:20, Changhuang Liang wrote:
> 
> 
> On 2023/5/4 15:04, Krzysztof Kozlowski wrote:
>> On 04/05/2023 08:53, Changhuang Liang wrote:
>>>>> 	};
>>>>> };
>>>>>
>>>>> Add a "regmap" property which is phandle. And it can keep the present child-node
>>>>> structure. This is more consistent with our soc design.
>>>>
>>>> Adding property from child to parent does not make any sense. Didn't you
>>>> already receive comment on this?
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> Krzysztof,
>>>
>>> I am confused about what to do next. How to add this power-controller's
>>> node in device tree?
>>>
>>
>> You just move power-domain-cells up.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Like this? 
> 
> aon_syscon: syscon@17010000 {
> 	compatible = "starfive,jh7110-aon-syscon", "syscon", "starfive,jh7110-aon-pmu";
> 	reg = <0x0 0x17010000 0x0 0x1000>;
> 	#power-domain-cells = <1>;
> };
> 
> If right? I will tell the syscon patch's owner delete the "simple-mfd" in aon_syscon node.

Yes, but your compatibles are now wrong. Just compatible =
"starfive,jh7110-aon-syscon", "syscon".

Best regards,
Krzysztof

