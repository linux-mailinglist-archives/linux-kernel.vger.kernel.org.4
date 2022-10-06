Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2E35F64D2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiJFLI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiJFLIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:08:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDD19B862
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 04:08:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id t4so792988wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 04:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CbeeFZ+x3aHj+XaOJLuyuhdGWHomvDtrnGAOISq7ELg=;
        b=Ck8AReTJ9PME9fyJ5bXtOD/KlktSnDb4/OtXx1sJS7huduv7GfLAMWSXKqcIN17UF3
         R7/9ZR5n+M7+mdAm6920py5T4bhkLTORzDBj9I6CIxG5KCWswu7G7S1x119Bj+UzzPJl
         9jnWMDHTL3WMjbMDNwEFczA8NZPaJ2FObPXXb6h8xz8DBDDSIUXoPRwhWsJQ3HG5VgWm
         Avb9Kj4Ip+Jjb2+EbMMGAovxT+wEkgjSWxnw/wkEO5QwGvHYPdg3BTs3tl//OaryYvFo
         C9iHLk5rpOlH14SYUmLC0aIORmgGLquwwfnn96p5hI+L54qSvraQLI3PeV3Eq5PVcqwj
         U15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbeeFZ+x3aHj+XaOJLuyuhdGWHomvDtrnGAOISq7ELg=;
        b=P6OzZpmIP5hmqxEaIR8gDxqmiQj7NzATq9hTdllLkarlHwSIUZHelAT3cYWY5a7XSe
         eEqv9h6NyowGDlRRcCcnS4KsyV5IYeRqpTiNHnreLQmNlLm8qK8F2nPAJdMG6mHZEaFu
         cUq/17HLjgGSFH2y9LJP1xeRgjsN9ywAnk8iqccb+lTvv8MtjgiZj4LSDr6pa7KI9DV9
         vJPwLkIosC8sELECZoGVBWEnvxWd0lM+x18sIBSIHz+hdeMuseEYPThrPwVOJmdKWoUf
         AqzObpjU2iYZP2+uuVPUY1nOpJIyPX9kb1IbWZjFI8KFu2Ui3k2LNR2mLt9LenW3PHlO
         8x7A==
X-Gm-Message-State: ACrzQf2sXXKp7WsmYKg+Nds0LFO22rr9YmvLjrFufDuOO62yJVK6xoZF
        +FyXwMlK4SnJJXm/43ZnZw0jlQ==
X-Google-Smtp-Source: AMsMyM476u1+t4iuw4iTs7clnDHL2LOAoA/r6b7hlBpiXlWfhv4Cgr5efpX+4UWm4OsdqnRY4ViAxQ==
X-Received: by 2002:a05:600c:524b:b0:3b4:8c0c:f3b6 with SMTP id fc11-20020a05600c524b00b003b48c0cf3b6mr6717571wmb.50.1665054501394;
        Thu, 06 Oct 2022 04:08:21 -0700 (PDT)
Received: from [192.168.0.20] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0a5500b003b4e009deb2sm5928180wmq.41.2022.10.06.04.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 04:08:20 -0700 (PDT)
Message-ID: <cdebdf53-d691-41b6-bb8e-f66bb6f56e56@baylibre.com>
Date:   Thu, 6 Oct 2022 13:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3] arm64: dts: mediatek: mt8183: disable thermal zones
 without trips.
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221004101130.17256-1-aouledameur@baylibre.com>
 <17f3fd40-70c1-2e8d-8002-dfe9690aed88@linaro.org>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <17f3fd40-70c1-2e8d-8002-dfe9690aed88@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thank you for your feedback.

On 10/4/22 12:47, Daniel Lezcano wrote:
>
> Hi Amjad,
>
> On 04/10/2022 12:11, Amjad Ouled-Ameur wrote:
>> Thermal zones without trip point are not registered by thermal core.
>>
>> tzts1 ~ tzts6 zones of mt8183 were intially introduced for test-purpose
>> only.
>>
>> Disable the zones above and keep only cpu_thermal enabled.
>
> It does not make sense to disable the thermal zones. Either the thermal zones are needed or they are not. Keeping them for debug purpose is not desired.
As Matthias Brugger mentioned in previous versions, DTS should describe the HW as it is, the sensors are in the HW.
>
> Alternatively to removal, you can:
>
>  - remove 'sustainable-power'
>  - add a passive trip point, optionally a hot trip point and a critical trip point

Why removing "sustainable-power" instead of simply disabling the device ? Especially that, if a user needs to use the sensor

in the future, they might not be able to find the right sustainable-power ; thus I think it should remain the way it is.

As to adding tripping points, MediaTek does not have ones to add for now for those sensors.


Regards,

Amjad

>
> The passive trip point will allow the userspace to set a value in order to get notified about the devices temperature (writable trip point). The hot temperature will send a notification to userspace so it can take a last chance decision to drop the temperature before the critical temperature.
>
> The passive trip point temperature could be a high temperature.
>
> The mitigation is also managed from userspace as a whole.
>
>
>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> index 9d32871973a2..53f7a0fbaa88 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> @@ -1191,6 +1191,7 @@ tzts1: tzts1 {
>>                   polling-delay = <0>;
>>                   thermal-sensors = <&thermal 1>;
>>                   sustainable-power = <5000>;
>> +                status = "disabled";
>>                   trips {};
>>                   cooling-maps {};
>>               };
>> @@ -1200,6 +1201,7 @@ tzts2: tzts2 {
>>                   polling-delay = <0>;
>>                   thermal-sensors = <&thermal 2>;
>>                   sustainable-power = <5000>;
>> +                status = "disabled";
>>                   trips {};
>>                   cooling-maps {};
>>               };
>> @@ -1209,6 +1211,7 @@ tzts3: tzts3 {
>>                   polling-delay = <0>;
>>                   thermal-sensors = <&thermal 3>;
>>                   sustainable-power = <5000>;
>> +                status = "disabled";
>>                   trips {};
>>                   cooling-maps {};
>>               };
>> @@ -1218,6 +1221,7 @@ tzts4: tzts4 {
>>                   polling-delay = <0>;
>>                   thermal-sensors = <&thermal 4>;
>>                   sustainable-power = <5000>;
>> +                status = "disabled";
>>                   trips {};
>>                   cooling-maps {};
>>               };
>> @@ -1227,6 +1231,7 @@ tzts5: tzts5 {
>>                   polling-delay = <0>;
>>                   thermal-sensors = <&thermal 5>;
>>                   sustainable-power = <5000>;
>> +                status = "disabled";
>>                   trips {};
>>                   cooling-maps {};
>>               };
>> @@ -1236,6 +1241,7 @@ tztsABB: tztsABB {
>>                   polling-delay = <0>;
>>                   thermal-sensors = <&thermal 6>;
>>                   sustainable-power = <5000>;
>> +                status = "disabled";
>>                   trips {};
>>                   cooling-maps {};
>>               };
>
>
