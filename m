Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE44638CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiKYPBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiKYPBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:01:31 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8EC3FB97
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:01:30 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a7so5436412ljq.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94PbW/ltOKOm/qJBLJVRn1IDNTKIsX6g0SVX2b46Dbk=;
        b=qq6Hx88tkfo7+D1qphcXIKQi6NGKUNKUlyVhxeckYhjG19NgOYegoyzQHAX1t/16Xn
         odjqfnFXNiFAoOJ/yr9uWiYnsUOW/QHtIseSSgCZd5S4nKI74bwnidIaUspAmcwQCGiW
         wzD4U7rVQFe2A7ULy073mjTZvk8vBicCulhBsMWn+2k6aUrQirSqWtxkxMaFUOyUE3iL
         KgQe1FH1wAnSUDazZkqc7T5ODIJVyHexjGAg26hctQM5PS3V4u9rF6PLB8ntX86PI6VA
         MqUteFpo5cuSwpc9XlgAwW7MJc0uGiRg56reQElNeaCmNzckPcLLAyflk5MPiLvwPKWT
         jNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94PbW/ltOKOm/qJBLJVRn1IDNTKIsX6g0SVX2b46Dbk=;
        b=4TW08ysPgMsMYFRzEu0YA9d/n2UYOl/lPVbSleVHoNT+wGVHYJwyTUKMm6SVeK8PXO
         aKYr9GhsHgfqoiRgXKObMRdX/AaxzNe/J/pRMcvP1dg2gNhP+Eaukmexhc5g9vRCk3pX
         E8fy9+PaSpzoY8Rj3qT6wl8O9meJRrgI6C9qPVmI/ZIZ/TjOPHHGbQ68JWbMTlmSrmX0
         laRvaMQYcL3Ewq1hSpIPe9XD0Fq9EZRe/ZDnG5qsBQH+1DBNa7PxcwetnhgZMBe078YU
         pvf4T/eD/e/8zWRgYTbj5oduyWmqbSQYwcQLhn10aypTOb01TodvNgncsxskBrl+syg/
         M87Q==
X-Gm-Message-State: ANoB5pnCqLDAqt+vY1Dbucx87yqlQZc6a1j8INxR9JVfx0Q0GH+ThVv7
        LnO08udR/3hssFTQM4h5/rWCVA==
X-Google-Smtp-Source: AA0mqf6N/acKSsSzIeuCEG7rXhNpwGx/2OgTNX8bK8JIQT+L8rh+ICXSSLrw1JdPH6Z3K+/GqZMBWw==
X-Received: by 2002:a05:651c:10af:b0:277:3046:3d1c with SMTP id k15-20020a05651c10af00b0027730463d1cmr11681896ljn.422.1669388488347;
        Fri, 25 Nov 2022 07:01:28 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u27-20020ac258db000000b0049adf925d00sm555433lfo.1.2022.11.25.07.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 07:01:27 -0800 (PST)
Message-ID: <016293da-92b1-16e9-9a8d-ecab34c2f0c6@linaro.org>
Date:   Fri, 25 Nov 2022 16:01:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynos5433
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>
References: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
 <20221125112201.240178-3-krzysztof.kozlowski@linaro.org>
 <CAPLW+4kwFCLaiowajdCnA09eT4emOB-3d-6cbA=ZYyRLwYuCxw@mail.gmail.com>
 <dfd956d5-d62d-52ac-c485-afc71c441df5@linaro.org>
 <CAPLW+4mWq5Q4Ht1Upx2Xw3fMfNvvSK6fEPbLFru1NLpKHLbKOg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPLW+4mWq5Q4Ht1Upx2Xw3fMfNvvSK6fEPbLFru1NLpKHLbKOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 15:57, Sam Protsenko wrote:
> On Fri, 25 Nov 2022 at 08:47, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 25/11/2022 15:22, Sam Protsenko wrote:
>>> On Fri, 25 Nov 2022 at 05:22, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> Exynos5433 has several different SYSREGs, so use dedicated compatibles
>>>> for them.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> ---
>>>>
>>>> Cc: Sriranjani P <sriranjani.p@samsung.com>
>>>> Cc: Chanho Park <chanho61.park@samsung.com>
>>>> Cc: Sam Protsenko <semen.protsenko@linaro.org>
>>>> ---
>>>
>>> Hi Krzysztof,
>>>
>>> Just curious: what is the rationale for adding those more specific
>>> sysregs? AFAIR, e.g. in Exynos850, different SysReg instances have
>>> pretty much the same register layout.
>>>
>>
>> On Exynos5433 all these blocks have different registers. Are you saying
>> that Exynos850 has four (or more) sysregs which are exactly the same?
>> Same registers? Why would they duplicate it?
>>
> 
> Ah, no, you are right. Just checked it, they are different. Just first
> couple of registers are similar between blocks, that's why I memorized
> it wrong.
> 
> So as I understand, adding those new compatibles follows "describe HW,
> not a driver" rule? Because AFAIU, right now it'll fallback to
> "syscon" compatible anyway.

Yes, they describe hardware. Of course all of these sysregs are similar
as they are just bunch of SFR/MMIO-region, but they have different
roles/features. For example some other devices (users) of syscon/sysreg
should reference specific device, not any sysreg.

On several other architectures we use specific compatibles, so I think
for Samsung we should do the same.

Different case was for Exynos 3/4/5 where there was only one SYSREG.

Best regards,
Krzysztof

