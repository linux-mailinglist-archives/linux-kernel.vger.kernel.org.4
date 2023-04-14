Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E0A6E2231
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDNLaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjDNLaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:30:11 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38CA90
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:29:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id j17so35105557ejs.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681471780; x=1684063780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0+Edrx0IM9690oJV8Q5R/N22PJKrT3awy24PGbymbg=;
        b=iEpoZfnjMjWNe/FxgVABg/VGFxzuvc5MIzmMp5t/+o3/cdZaHLhmurtA60Tgz6hrDI
         P7Qw5OW6143M9PNO87mSQjXbu1e5RgseQKFsonNHrdg0G625+tFh0DMEfWP4W1R+6eOT
         Sqrq7cjLBbP+eXnAFMsJ1tmA1HqnCSF8WUuYEQaz1m3g3qr1Spt3ho4y50HUnduAgN7B
         SOj6pCWILzHlg7vk663+HvPWSY25UVc4JpM1U3dAzGYVppOSORERjTbhLFE1qRMCfXHE
         JmEpI9WHshZDwy1XuBsvVyNZxrcy7clbKREvNVrxm8GEo407wqUmJnQvCmvXLSwWCb2v
         92Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681471780; x=1684063780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0+Edrx0IM9690oJV8Q5R/N22PJKrT3awy24PGbymbg=;
        b=kPmjIbz4nsVsm8f2O+fub3Kzzw6aImRjWGS/T0npKXLQ72fqQ780dOKcmEsnmA5E3Q
         xYQrD8Hyt028R4ES5Cxr0A2eyWB91DdteHuba8e2cOh+NTA35qtq9rX3AFpYNW/RG6po
         jLKMUbW2w7odwkKcRtjH7ptvfYAEm4GWDgdAIqrponlklOJks4e9HzXYDn4L6KjVzrVN
         NnBH/ZhY+cB/yx/4YrVFMcHr1j3+nbEGEeN7HPbXnVYxH9xgU2NFg7uLwEz+AqVxttll
         QWXh1oESkmL6cPUVGtCX1iP+6mWkAJbOkOxZ6NrbHta0sCjJkHlwxIcTGhRxXxjhkpJ3
         7+eA==
X-Gm-Message-State: AAQBX9dcTlsYUNYNCND+sAXlCAndRXQFBOFnBwcAIP3AH1PrPazUtY2f
        7smrbysr3ZL2ak453GLTMs8VuA==
X-Google-Smtp-Source: AKy350ZIlAwLnIME/qmELmFYpYuNLEsNvTy22tLzGhqysgrUd2eT9uwUn/0SUdgGv9Xc+5fCGwgB4A==
X-Received: by 2002:a17:906:7b4a:b0:8a0:7158:15dc with SMTP id n10-20020a1709067b4a00b008a0715815dcmr5088574ejo.74.1681471779819;
        Fri, 14 Apr 2023 04:29:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:40b9:8c57:b112:651d? ([2a02:810d:15c0:828:40b9:8c57:b112:651d])
        by smtp.gmail.com with ESMTPSA id a5-20020a170906684500b0094d7bc8e9aasm2332787ejs.94.2023.04.14.04.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 04:29:39 -0700 (PDT)
Message-ID: <b75a846c-63be-9f30-e786-f34292cfeaf4@linaro.org>
Date:   Fri, 14 Apr 2023 13:29:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add vdd_cpu_big regulators to
 rk3588-rock-5b
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230414093411.113787-1-cristian.ciocaltea@collabora.com>
 <20230414093411.113787-4-cristian.ciocaltea@collabora.com>
 <0cbafc31-9b46-54df-f569-810a8781743c@linaro.org>
 <36d8050b-0636-2b30-f3fc-7f7d96bec253@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <36d8050b-0636-2b30-f3fc-7f7d96bec253@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 12:40, Cristian Ciocaltea wrote:
> On 4/14/23 13:27, Krzysztof Kozlowski wrote:
>> On 14/04/2023 11:34, Cristian Ciocaltea wrote:
>>> The RK8602 and RK8603 voltage regulators on the Rock 5B board provide
>>> the power lines vdd_cpu_big0 and vdd_cpu_big1, respectively.
>>>
>>> Add the necessary device tree nodes and bind them to the corresponding
>>> CPU big core nodes.
>>>
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>>  .../boot/dts/rockchip/rk3588-rock-5b.dts      | 56 +++++++++++++++++++
>>>  1 file changed, 56 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> index 8cc97d146a73..3e4aee8f70c1 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> @@ -53,6 +53,62 @@ vcc5v0_sys: vcc5v0-sys-regulator {
>>>  	};
>>>  };
>>>  
>>> +&cpu_b0 {
>>> +	cpu-supply = <&vdd_cpu_big0_s0>;
>>> +};
>>> +
>>> +&cpu_b1 {
>>> +	cpu-supply = <&vdd_cpu_big0_s0>;
>>> +};
>>> +
>>> +&cpu_b2 {
>>> +	cpu-supply = <&vdd_cpu_big1_s0>;
>>> +};
>>> +
>>> +&cpu_b3 {
>>> +	cpu-supply = <&vdd_cpu_big1_s0>;
>>> +};
>>> +
>>> +&i2c0 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&i2c0m2_xfer>;
>>> +	status = "okay";
>>> +
>>> +	vdd_cpu_big0_s0: regulator@42 {
>>> +		compatible = "rockchip,rk8602";
>>
>> Looking at your next node, this is surprising... Double check if you
>> have correct compatibles everywhere.
>>
>>> +		reg = <0x42>;
>>> +		fcs,suspend-voltage-selector = <1>;
>>
>> Does not look like you tested the DTS against bindings. Please run `make
>> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
>> for instructions).
>>
>>> +		regulator-name = "vdd_cpu_big0_s0";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt = <550000>;
>>> +		regulator-max-microvolt = <1050000>;
>>> +		regulator-ramp-delay = <2300>;
>>> +		vin-supply = <&vcc5v0_sys>;
>>> +
>>> +		regulator-state-mem {
>>> +			regulator-off-in-suspend;
>>> +		};
>>> +	};
>>> +
>>> +	vdd_cpu_big1_s0: regulator@43 {
>>> +		compatible = "rockchip,rk8603", "rockchip,rk8602";
>>> +		reg = <0x43>;
>>> +		fcs,suspend-voltage-selector = <1>;
>>
>> Does not look like you tested the DTS against bindings. Please run `make
>> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
>> for instructions).
> 
> I mentioned in the cover letter that the support for the RK860X 
> regulators has been recently merged via [1]. The patches in this 
> series have been verified on next-20230413.

OK. The question about compatibles still stays - but maybe you have
indeed 8603 and 8602 in the same time.

Best regards,
Krzysztof

