Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A46A5F6538
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiJFL3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiJFL3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:29:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C2F89CC3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 04:29:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n16-20020a05600c4f9000b003c17bf8ddecso703111wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 04:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzBoGlicy3cr5i7Md3OkU8BP9DCvHUCzxRYJ1FITrS8=;
        b=PQPhGGy4X0icS+0U2DZWL+y2oAC8x7qKbdkkA8xEaHD3BL5dHEE+JwcqqDAN1nKEAO
         iz50hZZshHS2CkDbAX3jyQYCov8MtfjxhvS29p4BSpiBCu1MYV4oxOig32UDIuw2/P5W
         jBqZkOhr/2gkwBeIKYx+Ce2HnOT9B4O3eWiICLHSmijTi29KmqUmCqP8anx6cfD66PZc
         NGfcAePJARl7raC0L/ok/65qFgVHyDImjD7i5HkwtxZNCEy8N2PQGf+ySAoC2dlnWb2w
         Sba2uyaMtphhXPQuzYl6pnOHIzttmC9vdEyjNOIyFUBv8OQvnfq5vO9mKUuRgeW7lmJe
         kt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzBoGlicy3cr5i7Md3OkU8BP9DCvHUCzxRYJ1FITrS8=;
        b=NvmEwt6N6H4m8U8cn0olLukzS9EVrta+Dj/L+Pul7TH2cMtb/eb8/CCOu6A4jLng4T
         J4wp2kn5YVTfMeUeLjuctApIFgw/QBnpSQJtOoaV4d9aTZxfzyWCs4vUD3Xa/pG4hFZd
         zdk9jeJXHkYswJlzNAs4oxLVWuCtkI1Hl6UB40z5Tn4RtNhdfSDaDecgbj3VxS9I6mPE
         mon68j0YsH8puanUmlPrs59rohzttv8sGWYbV4hQIpsA7FCUQ0GMEo+G66GORVY2kBcA
         jaMs0bvnUP9x/Gmml3Zjkblqs313cTEhKsADDOKHOPhDPYVnjZaa0itR2VvVRUnIyGP9
         +oUA==
X-Gm-Message-State: ACrzQf0qTHV7mfAvwGE5BRpIp2w2XPY1uh5PdymW5U0u50dEdnKf524J
        krZCfuuLp2ZQdNBIiU6wRvJAHw==
X-Google-Smtp-Source: AMsMyM4D8IVPdtfX1BGMVrLvF4BEJS2QdV3t02qYVEv36AAcuIauZqgZNPTN+8DYtrOHhrsdaVUtlw==
X-Received: by 2002:a05:600c:12c6:b0:3bd:eeec:309 with SMTP id v6-20020a05600c12c600b003bdeeec0309mr6651003wmd.167.1665055769752;
        Thu, 06 Oct 2022 04:29:29 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:86cc:fff3:d44b:9793? ([2a05:6e02:1041:c10:86cc:fff3:d44b:9793])
        by smtp.googlemail.com with ESMTPSA id u8-20020a5d5148000000b0022e04bfa661sm16280780wrt.59.2022.10.06.04.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 04:29:29 -0700 (PDT)
Message-ID: <f66c795b-03e7-083c-e4ba-5b5c150b88df@linaro.org>
Date:   Thu, 6 Oct 2022 13:29:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] arm64: dts: mediatek: mt8183: disable thermal zones
 without trips.
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221004101130.17256-1-aouledameur@baylibre.com>
 <17f3fd40-70c1-2e8d-8002-dfe9690aed88@linaro.org>
 <cdebdf53-d691-41b6-bb8e-f66bb6f56e56@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <cdebdf53-d691-41b6-bb8e-f66bb6f56e56@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2022 13:08, Amjad Ouled-Ameur wrote:
> Hi Daniel,
> 
> Thank you for your feedback.
> 
> On 10/4/22 12:47, Daniel Lezcano wrote:
>>
>> Hi Amjad,
>>
>> On 04/10/2022 12:11, Amjad Ouled-Ameur wrote:
>>> Thermal zones without trip point are not registered by thermal core.
>>>
>>> tzts1 ~ tzts6 zones of mt8183 were intially introduced for test-purpose
>>> only.
>>>
>>> Disable the zones above and keep only cpu_thermal enabled.
>>
>> It does not make sense to disable the thermal zones. Either the 
>> thermal zones are needed or they are not. Keeping them for debug 
>> purpose is not desired.
> As Matthias Brugger mentioned in previous versions, DTS should describe 
> the HW as it is, the sensors are in the HW.

Yes, it is here:

		thermal: thermal@1100b000 {
                         #thermal-sensor-cells = <1>;
                         compatible = "mediatek,mt8183-thermal";
                         reg = <0 0x1100b000 0 0x1000>;
                         clocks = <&infracfg CLK_INFRA_THERM>,
                                  <&infracfg CLK_INFRA_AUXADC>;
	                clock-names = "therm", "auxadc";
                         resets = <&infracfg 
MT8183_INFRACFG_AO_THERM_SW_RST>;
                         interrupts = <0 76 IRQ_TYPE_LEVEL_LOW>;
                         mediatek,auxadc = <&auxadc>;
		        mediatek,apmixedsys = <&apmixedsys>;
                         nvmem-cells = <&thermal_calibration>;
			nvmem-cell-names = "calibration-data";
		};

>> Alternatively to removal, you can:
>>
>>  - remove 'sustainable-power'
>>  - add a passive trip point, optionally a hot trip point and a 
>> critical trip point
> 
> Why removing "sustainable-power" instead of simply disabling the device 
> ? 

Because sustainable-power is wrong. It is probably coming from a 
copy-paste. It does not make sense to have this.

The sustainable-power is for the power allocator governor which is 
limited to CPU and GPU. Here the thermal zones are for different devices.

Especially that, if a user needs to use the sensor

If the thermal zone is disabled, how can it use the sensor?

> in the future, they might not be able to find the right 
> sustainable-power ; thus I think it should remain the way it is.
> 
> As to adding tripping points, MediaTek does not have ones to add for now 
> for those sensors.

Please do this:

Add:

trips {
        threshold : trip1 {
            	temperature = <50000>;
                 type = "passive";
           };
};

And remove all the empty cooling maps and the sustainable power properties.


>> The passive trip point will allow the userspace to set a value in 
>> order to get notified about the devices temperature (writable trip 
>> point). The hot temperature will send a notification to userspace so 
>> it can take a last chance decision to drop the temperature before the 
>> critical temperature.
>>
>> The passive trip point temperature could be a high temperature.
>>
>> The mitigation is also managed from userspace as a whole.
>>
>>
>>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>>> ---
>>>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi 
>>> b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>>> index 9d32871973a2..53f7a0fbaa88 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>>> @@ -1191,6 +1191,7 @@ tzts1: tzts1 {
>>>                   polling-delay = <0>;
>>>                   thermal-sensors = <&thermal 1>;
>>>                   sustainable-power = <5000>;
>>> +                status = "disabled";
>>>                   trips {};
>>>                   cooling-maps {};
>>>               };
>>> @@ -1200,6 +1201,7 @@ tzts2: tzts2 {
>>>                   polling-delay = <0>;
>>>                   thermal-sensors = <&thermal 2>;
>>>                   sustainable-power = <5000>;
>>> +                status = "disabled";
>>>                   trips {};
>>>                   cooling-maps {};
>>>               };
>>> @@ -1209,6 +1211,7 @@ tzts3: tzts3 {
>>>                   polling-delay = <0>;
>>>                   thermal-sensors = <&thermal 3>;
>>>                   sustainable-power = <5000>;
>>> +                status = "disabled";
>>>                   trips {};
>>>                   cooling-maps {};
>>>               };
>>> @@ -1218,6 +1221,7 @@ tzts4: tzts4 {
>>>                   polling-delay = <0>;
>>>                   thermal-sensors = <&thermal 4>;
>>>                   sustainable-power = <5000>;
>>> +                status = "disabled";
>>>                   trips {};
>>>                   cooling-maps {};
>>>               };
>>> @@ -1227,6 +1231,7 @@ tzts5: tzts5 {
>>>                   polling-delay = <0>;
>>>                   thermal-sensors = <&thermal 5>;
>>>                   sustainable-power = <5000>;
>>> +                status = "disabled";
>>>                   trips {};
>>>                   cooling-maps {};
>>>               };
>>> @@ -1236,6 +1241,7 @@ tztsABB: tztsABB {
>>>                   polling-delay = <0>;
>>>                   thermal-sensors = <&thermal 6>;
>>>                   sustainable-power = <5000>;
>>> +                status = "disabled";
>>>                   trips {};
>>>                   cooling-maps {};
>>>               };
>>
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
