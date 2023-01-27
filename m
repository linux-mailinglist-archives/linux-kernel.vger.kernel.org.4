Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8BD67E113
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjA0KIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjA0KIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:08:48 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006C84C6DE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:08:46 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so5041280wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MWUMgBP7Oku5gYGzZWSP5y1RRsNvwdyRcB7eFWAwTU0=;
        b=MPwJxKjWcAbrgBbFXgrvHR4wjhwuS/a56htKBR+RaxHq0WjuafurnQKOkQK+iODchE
         Jm9X06UK46r8ATa2Ka+fLTrWTr0i1CF6XfPb+CLB22s9omYlHZC5sagsIJfR/yV31lhx
         XeN9qvL6WaJwd/SgTpTxY63h6wFb3GvQrxYBoEJ4XLfa731msqxegoKzyhwAmgbv3tOo
         Sgct7aDGKV4wqWKoysLhpw267DqOb7cBIxUE8T22ymUX7LVfAeBcPX9gNEKK5kt9qxro
         4HMiwiHGJM3ZifyWOEfzZ0U7y+M52O/pmD3hqU1TRAGB4vy4PbBP5T2rzW96in3Fpd32
         hG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWUMgBP7Oku5gYGzZWSP5y1RRsNvwdyRcB7eFWAwTU0=;
        b=68Myp1L17v4HmRSoJOtyUl5PCmdoiSDA+TuFRs6h5AgC1qkb6OjAiaaRoOPjUdxLLH
         Y1gvRGOmU6E3gzHC4qX+BzThDAxI8PGDc+IalDd7YtenU8P88DXhas4aFc0aEKYCdYfU
         /9iMOT6Zw2/i52kzNggot1IfON/8lo7FAqRM3zDvDlgcVVa5sE3ttSvJx1S87SIYfJbn
         ofh3KxJk4MYakXDGt5YDfBQTqwiZLU+COdKQ9W9SCznI0ZLK2AVSrsnSomGPkFX8En4n
         HBCOIY41mWbFLjdipVXBL35KkyDXwaKyL+irlrCFFP3PCFoCD0V74a4yDtnIz6+m1ZZs
         t5xg==
X-Gm-Message-State: AFqh2kp9pMFEpFgVh7OkfWKZYWwA2LBqsk9a9+okj+Vpu4ROfmj5Asdb
        tQVdPtDvDy01WWRJsfBM6Dut6g==
X-Google-Smtp-Source: AMrXdXtulVyKLYucU9uL1ZxqVBbI4su9SJiwmNAknR7BQz1SBzbCEYaJrMSTQLQhzCzL3+o6kD1VAg==
X-Received: by 2002:a05:600c:3ba5:b0:3da:ff66:e3cc with SMTP id n37-20020a05600c3ba500b003daff66e3ccmr37585096wms.21.1674814125540;
        Fri, 27 Jan 2023 02:08:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:d4ec:15ea:873c:61e6? ([2a01:e0a:982:cbb0:d4ec:15ea:873c:61e6])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d6b81000000b002bdc39849d1sm3475326wrx.44.2023.01.27.02.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 02:08:45 -0800 (PST)
Message-ID: <8e7700df-32dd-61ad-93a0-74749751e531@linaro.org>
Date:   Fri, 27 Jan 2023 11:08:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 4/4] arm64: dts: meson: add support for BananaPi M2-Pro
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230127100236.3385154-1-christianshewitt@gmail.com>
 <20230127100236.3385154-5-christianshewitt@gmail.com>
 <a35f7f09-eb19-6cfc-2053-c6b340f10cbd@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <a35f7f09-eb19-6cfc-2053-c6b340f10cbd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 11:06, Krzysztof Kozlowski wrote:
> On 27/01/2023 11:02, Christian Hewitt wrote:
>> BPI-M2-PRO is based upon the BPI-M5 design except for a different
>> physical board layout and the following changes:
>>
>> - USB 3.0 ports reduced from 4x to 2x
>> - 3.5mm Combined CVBS/Audio Jack removed
>> - RTL8821BU WiFi/BT module (internal USB connected)
>>
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>>   .../dts/amlogic/meson-sm1-bananapi-m2-pro.dts | 98 +++++++++++++++++++
>>   2 files changed, 99 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>> index 97b42e2100e0..644451794aca 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -60,6 +60,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-wetek-core2.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-s4-s805x2-aq222.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-a95xf3-air-gbit.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-a95xf3-air.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m2-pro.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m5.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-h96-max.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
>> new file mode 100644
>> index 000000000000..4890d5d9a4f7
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
>> @@ -0,0 +1,98 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2021 BayLibre SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "meson-sm1-bananapi.dtsi"
>> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>> +
>> +/ {
>> +	compatible = "bananapi,bpi-m2-pro", "amlogic,sm1";
>> +	model = "Banana Pi BPI-M2-PRO";
>> +
>> +	sound {
>> +		compatible = "amlogic,axg-sound-card";
>> +		model = "BPI-M2-PRO";
>> +		audio-aux-devs = <&tdmout_b>;
>> +		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
>> +				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
>> +				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
>> +				"TDM_B Playback", "TDMOUT_B OUT";
>> +
>> +		assigned-clocks = <&clkc CLKID_MPLL2>,
>> +				  <&clkc CLKID_MPLL0>,
>> +				  <&clkc CLKID_MPLL1>;
>> +		assigned-clock-parents = <0>, <0>, <0>;
>> +		assigned-clock-rates = <294912000>,
>> +				       <270950400>,
>> +				       <393216000>;
>> +		status = "okay";
> 
> It's by default. Did any DTSI disable the sound node?

It's a leftover we keep copying onto new boards, I'll send a patch top remove all those.

Neil

> 
> 
> 
> Best regards,
> Krzysztof
> 

