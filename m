Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86072688B72
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjBCAGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjBCAFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:05:54 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEED86EBB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 16:05:38 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id lu11so10959599ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 16:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ElCEgzYJT7w+JdKbabLIuYeTly0I88jzwy4ftNw2528=;
        b=bPzO2GfbJB2CNez7PNGdkg7AoLTlCZRmr17pX5m9Ypdq05V3vJHYsyF3LdnaKZyuaE
         pGckIiQCXVWHPe5uKNIbUg3v7hjITymrqsIPKsMYwEbGney4seroDS/V+OiTW4XbpgPj
         alPjEHIdPSsoDFdwE8OSjxHgE3kWOK+OINKuP0GyJbIBzwCsZ3JuvT+j+RX47QdN7TUv
         9sQ0ZEiSVpmvJcMXl/YuBZZiqEfV8c8vMr+/GuavAgjUUTz9fOU4oo7UE1jWIy53BqNA
         1HIO18xDkhAlpM8DidNYsO7nm/f4UoN2prAf7dxLvee/HVpuZ9CcAXP6e+Q30GFMaKuB
         AcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElCEgzYJT7w+JdKbabLIuYeTly0I88jzwy4ftNw2528=;
        b=yJtHgj48Gaig/oonlN0jdmO8PFxTuAWHHqJ643Y+GVsO2tFDcD2pHGuMAuswDzT8VM
         Xt78Jl6iEEOwdj+SXHhymIl8/D6UPgwTL8qkbtUG58jbK/D7rWHTBSGlYXMeKy5txWtu
         96OMI65D9Vgb4rpN8vP4QlJxp47lcblgkVLNov2Z7j/+lMePMvu2/GjDsIIlM/2LUNyE
         vJt+jnuMvDphmHtXLAy3uS/DAua7jhola9tvTdK7zLQDR7iSMOL7sPwLjjCOCzJpaUe6
         TtXzxbiUDMWvLjf+Kw0BfAWx80DCtmTm6AgTFZwrDEExbTLLD97xuU8Q+8+CyxvZYxjd
         4aQw==
X-Gm-Message-State: AO0yUKXFn9dSypmL8g3NzeFTFHt+suItS6xw3/8b3Y/3ph9GKnkC/YWC
        SZ1X+cZrpGw7LaiF33Zb1rivRQ==
X-Google-Smtp-Source: AK7set/uggTDOGIuG47jwyXDAZcTSBJndaTKT0EGAw6dBWIDnBKj6XYxSX2Ysyg0qY/bxXleleAsdg==
X-Received: by 2002:a17:906:94cb:b0:879:ec1a:4ac with SMTP id d11-20020a17090694cb00b00879ec1a04acmr7197812ejy.76.1675382737042;
        Thu, 02 Feb 2023 16:05:37 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id j5-20020a1709062a0500b0087be1055f83sm475393eje.206.2023.02.02.16.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 16:05:36 -0800 (PST)
Message-ID: <1319a973-26ae-8c11-d967-8720aaf894df@linaro.org>
Date:   Fri, 3 Feb 2023 01:05:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RFT PATCH 05/14] arm64: dts: qcom: sc8280xp: correct TLMM
 gpio-ranges
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230201155105.282708-1-krzysztof.kozlowski@linaro.org>
 <20230201155105.282708-6-krzysztof.kozlowski@linaro.org>
 <Y9xAEoc0QXe222D0@x1> <25f5a750-b51c-7d7b-0d50-5b2f78de8512@linaro.org>
 <Y9xOeZjAQmQqLOa1@x1>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <Y9xOeZjAQmQqLOa1@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.02.2023 00:59, Brian Masney wrote:
> On Fri, Feb 03, 2023 at 12:45:49AM +0100, Konrad Dybcio wrote:
>> On 2.02.2023 23:58, Brian Masney wrote:
>>> On Wed, Feb 01, 2023 at 04:50:56PM +0100, Krzysztof Kozlowski wrote:
>>>> Correct the number of GPIOs in TLMM pin controller.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>>> index fa2d0d7d1367..17e8c26a9ae6 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>>> @@ -3533,7 +3533,7 @@ tlmm: pinctrl@f100000 {
>>>>  			#gpio-cells = <2>;
>>>>  			interrupt-controller;
>>>>  			#interrupt-cells = <2>;
>>>> -			gpio-ranges = <&tlmm 0 0 230>;
>>>> +			gpio-ranges = <&tlmm 0 0 228>;
>> Won't that kill the UFS pins?
> 
> For others quick reference, Konrad is talking about this line from
> sa8540p-ride.dts:
> 
> 	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
> 
> I noticed that earlier but assumed this was one based. However, looking
> at pinctrl-sc8280xp.c I see gpio0..gpio227 defined.
+ gpio229 is the reset pin for the UFS card slot

Konrad
> 
> Brian
> 
