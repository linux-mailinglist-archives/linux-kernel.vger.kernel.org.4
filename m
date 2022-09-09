Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28B35B31C1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiIIIca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiIIIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:32:27 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FFD1282FA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:32:26 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id bs13so958504ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 01:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Dt/NonODblXlWQZIMmh1TH9Id6Q2KvLS2tY6Rp9x0GE=;
        b=LK4ujKxMCcjrLILoyOq47tOhxHDFHBZJr36EmIG+DL7wfnOuez6UZpUub2DUzmpg8m
         FjHIV2sFUEYAlQ7VZR06DLTacKmluOBeKpMaLpTYMKEy0xvviYoD4PIpIiLLmUMx9p1V
         nXoNlnT0TPTvasr+2RnFNcZEnZF1lSIX/xb7PvEBvyM4Hmhggh0V59I/iQoPVXyk85CG
         JQYe9ZolOTQlu9WNzqOd9SOJ5g+G5gzSp0FjWKqqBuKa8ZwzQDoSL3bDc4qVGRc5K+iW
         JSkqxSxKg/A3VEClnK+mUmQOOGMH9ndOU69dWAfvGNfBLHNOyy0/EP7X3wC2izmSTrzT
         RkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Dt/NonODblXlWQZIMmh1TH9Id6Q2KvLS2tY6Rp9x0GE=;
        b=UpP+Rgnjtc1bh8tigOZGWGHws5YKBT/+Huj+4J2x2xyO20FwDaCmn3BvXtM9tNMRda
         rR2hhhzHuZs0NCMu9DixwhKdmoX5aj5xzyaLuatH42L9lMZRrLh3n/yrv9aEtuAIm0MR
         ZDunuEt8l927Gjzrb2vmTaDYPHS2pXJK+DM+ZOHMcDNfWkpc7hUyc47tyahbp4QbgjO5
         RgZRV48hl6isVKW6jDplXhkTs1MCsC7w4rEuWdHAeb3amveHqBogNIHbFVe9yAbn1AmA
         1It9F1Gu1J7CUV+mO9BDVsnVu8bgWgURGIfrWuVWrymnpFccrCUSduH6yF0JvZiSO6Iy
         X5Ng==
X-Gm-Message-State: ACgBeo2tlBh5u7tPofAFIzZ0dGsLXUGHLr2w9JXTNzSjOjEetcTt9+at
        r3jjWX4KSPBFpMhvD/TQt1sUYda+ZACTbg==
X-Google-Smtp-Source: AA6agR4U5Ig5/kxVx3nY+DEyWJwNAL6wK5OfZHtNrtSiZqTbnHfa42gGKBTceXg6es7hDAr3AFPx1g==
X-Received: by 2002:a2e:9e50:0:b0:261:e3fd:cdc5 with SMTP id g16-20020a2e9e50000000b00261e3fdcdc5mr3594611ljk.56.1662712344803;
        Fri, 09 Sep 2022 01:32:24 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b6-20020a05651c032600b0026acf2ae007sm192764ljp.89.2022.09.09.01.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 01:32:24 -0700 (PDT)
Message-ID: <f8ff6cf5-8ec9-b3f3-bae9-e2690e810f6a@linaro.org>
Date:   Fri, 9 Sep 2022 10:32:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: msm8953: add MDSS
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220906183334.203787-1-luca@z3ntu.xyz>
 <20220906183334.203787-4-luca@z3ntu.xyz>
 <CAA8EJpqjnafKyUrd1ntYFeGTDtRxgEUSu0Mg9wNGxObJ3wF0Kw@mail.gmail.com>
 <12049260.O9o76ZdvQC@g550jk>
 <ab80670a-267a-45d8-92d0-750e7dce5682@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ab80670a-267a-45d8-92d0-750e7dce5682@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 18:13, Dmitry Baryshkov wrote:
>>>>
>>>> +               mdss: mdss@1a00000 {
>>>> +                       compatible = "qcom,mdss";
>>>> +
>>>> +                       reg = <0x1a00000 0x1000>,
>>>> +                             <0x1ab0000 0x1040>;
>>>> +                       reg-names = "mdss_phys",
>>>> +                                   "vbif_phys";
>>>> +
>>>> +                       power-domains = <&gcc MDSS_GDSC>;
>>>> +                       interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>>>> +
>>>> +                       interrupt-controller;
>>>> +                       #interrupt-cells = <1>;
>>>> +
>>>> +                       clocks = <&gcc GCC_MDSS_AHB_CLK>,
>>>> +                                <&gcc GCC_MDSS_AXI_CLK>,
>>>> +                                <&gcc GCC_MDSS_VSYNC_CLK>,
>>>> +                                <&gcc GCC_MDSS_MDP_CLK>;
>>>> +                       clock-names = "iface",
>>>> +                                     "bus",
>>>> +                                     "vsync",
>>>> +                                     "core";
>>>> +
>>>> +                       #address-cells = <1>;
>>>> +                       #size-cells = <1>;
>>>> +                       ranges;
>>>> +
>>>> +                       status = "disabled";
>>>> +
>>>> +                       mdp: mdp@1a01000 {
>>>> +                               compatible = "qcom,mdp5";
>>>
>>> Could you please change this to "qcom,msm8953-mdp5", "qcom,mdp5".
>>
>> This would be the first dtsi using the two compatibles then, correct? Are there
>> any plans to adjust other SoCs?
> 
> Yes, this is a long-going plan. Having just "qcom,mdp5" doesn't allow 
> switching between mdp5 and dpu1 drivers. Thus I'd ask to add per-SoC 
> compat strings.
> 
> It's up to you (and Rob/Krzysztof) whether to leave just one compat 
> string or have both of them: a per-soc one and a generic one.

If device can bind to generic fallback ("qcom,mdp5") and still work
somehow, then the fallback is OK. However if generic "qcom,mdp5" does
not work at all, let's just choose something which is matching current
patterns.

Best regards,
Krzysztof
