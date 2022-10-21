Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE4D607755
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJUMxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiJUMxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:53:51 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF8B26B6D6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:53:49 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id z30so1882991qkz.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/oSeaW5mIul8TIhIXdrPxIKt9VEUuWQxs7k14eD/1Ss=;
        b=sNK2bvtb0ckWlAzBW2zlR/iBOi7oAQTHNcdG3EQDc0gDVdJvQWJSne5nmtCTDeKv01
         LEFxTjBtiZGtP76wki/rZRcTfgMtxgXQ2fIVgTZvHVZxhvQWXGHWV+LR/IHyhLuZburc
         9rUKFqAC+xjzt721U30STNJfbv76tSnlTFjbzuaMOk9wEsDfYJNh3vHB6+BaUvOoG2p5
         OtuPWxE7KbYy7QIy3Y7DKlKwULDiMVgLJTWdUMpntiC6Oih/Lnt7UoaAvTTT28BXeegI
         6d+xkHbZ3qQGW87JffuysvRdnff8FaHQGRcmJjJ51D7lpVozc2ViYex1iqvmZ1ymuZWJ
         X8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/oSeaW5mIul8TIhIXdrPxIKt9VEUuWQxs7k14eD/1Ss=;
        b=8ITrXQoJ3oQiaCdtzYUjHAhSckXupuRPZpqaN5h/hAQIiZA8Z2lPyymEaFVFwnlQV0
         E+EavcFfcXOPdc18zzWNOYxt77p3gx5LoBplpdpvU5u76yBuiD0vdBduAQ6v+V+wzKmY
         tk60jN1db5S86hhbsjDAVwCoGlVaeF3cFTWp9O5zXQ/mgfxJVgIAfjMnzmh8ETYv7qiu
         GuBguB76BAK7YjG82Ic/xRsjlksmQ9VWa0ak4P4efcw1Ty7Dk8FSHzt3Qp6DIiLdj5cP
         ZOq0voVBNMu5e7RVdxdaKF37xbeY+i1P++x3X/XGsfwE/93uU2n1pAd8BVcZC8temNLC
         GL8A==
X-Gm-Message-State: ACrzQf1Yy/Ocn4NVzIgyY1660hB0JqHEB7rsN1KYXbIhQRw3kKXcd88B
        mhJ0wfG9IngPe1DCqKcmBxEblg==
X-Google-Smtp-Source: AMsMyM6L4xxVRWdbLocFykTdac6DlxEUJbXwJLGOhwqvAy4RhLV8T3Niy3e9l/kTxGIuF9J8/g+4jQ==
X-Received: by 2002:a05:620a:2487:b0:6ee:74a7:934b with SMTP id i7-20020a05620a248700b006ee74a7934bmr14077470qkn.625.1666356828594;
        Fri, 21 Oct 2022 05:53:48 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id w27-20020a05620a0e9b00b006cdd0939ffbsm9345492qkm.86.2022.10.21.05.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 05:53:47 -0700 (PDT)
Message-ID: <89340edb-2451-e648-e2e6-94c8f2410084@linaro.org>
Date:   Fri, 21 Oct 2022 08:53:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 6/6] arm64: dts: fsd: Add sound card node for Tesla FSD
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        'Alim Akhtar' <alim.akhtar@samsung.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        rcsekar@samsung.com, aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
 <CGME20221014104915epcas5p12414b87ea127b2d5bf521556bf841b00@epcas5p1.samsung.com>
 <20221014102151.108539-7-p.rajanbabu@samsung.com>
 <00c301d8dfd0$f55ca230$e015e690$@samsung.com>
 <04aa01d8e524$d253f2d0$76fbd870$@samsung.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <04aa01d8e524$d253f2d0$76fbd870$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 04:12, Padmanabhan Rajanbabu wrote:
> 
> 
>> -----Original Message-----
>> From: Alim Akhtar [mailto:alim.akhtar@samsung.com]
>> Sent: 14 October 2022 06:59 PM
>> To: 'Padmanabhan Rajanbabu' <p.rajanbabu@samsung.com>;
>> lgirdwood@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
>> perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
>> rcsekar@samsung.com; aswani.reddy@samsung.com
>> Cc: alsa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org
>> Subject: RE: [PATCH 6/6] arm64: dts: fsd: Add sound card node for Tesla FSD
>>
>>
>>
>>> -----Original Message-----
>>> From: Padmanabhan Rajanbabu [mailto:p.rajanbabu@samsung.com]
>>> Sent: Friday, October 14, 2022 3:52 PM
>>> To: lgirdwood@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
>>> krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
>>> perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
>>> alim.akhtar@samsung.com; rcsekar@samsung.com;
>> aswani.reddy@samsung.com
>>> Cc: alsa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-
>>> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org;
>> Padmanabhan
>>> Rajanbabu <p.rajanbabu@samsung.com>
>>> Subject: [PATCH 6/6] arm64: dts: fsd: Add sound card node for Tesla FSD
>>>
>>> Add device tree node support for sound card on Tesla FSD board
>>>
>>> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
>>> ---
>>> arch/arm64/boot/dts/tesla/fsd-evb.dts | 49
>>> +++++++++++++++++++++++++++
>>> arch/arm64/boot/dts/tesla/fsd.dtsi    |  3 ++
>>> 2 files changed, 52 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts
>>> b/arch/arm64/boot/dts/tesla/fsd-evb.dts
>>> index c0a4509499ab..ecaa3c2e3045 100644
>>> --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
>>> +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
>>> @@ -49,3 +49,52 @@
>>> &tdm_1 {
>>> 	status = "okay";
>>> };
>>> +
>>> +&sound {
>>> +	compatible = "tesla,fsd-sndcard";
>>> +	status = "okay";
>>> +	model = "fsd-i2s";
>>> +	widgets =
>>> +		"Speaker", "MAIN SPK",
>>> +		"Microphone", "MAIN MIC";
>>> +
>>> +	primary-dai-link-0 {
>>> +		link-name = "fsd-primary-0";
>>> +		dai-format = "i2s";
>>> +		tesla,bitclock-master = <&tdm_0>;
>>> +		tesla,frame-master = <&tdm_0>;
>>> +		cpu {
>>> +			sound-dai = <&tdm_0 0>;
>>> +		};
>>> +	};
>>> +
>>> +	secondary-dai-link-0 {
>>> +		link-name = "fsd-secondary-0";
>>> +		dai-format = "i2s";
>>> +		tesla,bitclock-master = <&tdm_0>;
>>> +		tesla,frame-master = <&tdm_0>;
>>> +		cpu {
>>> +			sound-dai = <&tdm_0 1>;
>>> +		};
>>> +	};
>>> +
>>> +	primary-dai-link-1 {
>>> +		link-name = "fsd-primary-1";
>>> +		dai-format = "i2s";
>>> +		tesla,bitclock-master = <&tdm_1>;
>>> +		tesla,frame-master = <&tdm_1>;
>>> +		cpu {
>>> +			sound-dai = <&tdm_1 0>;
>>> +		};
>>> +	};
>>> +
>>> +	secondary-dai-link-1 {
>>> +		link-name = "fsd-secondary-1";
>>> +		dai-format = "i2s";
>>> +		tesla,bitclock-master = <&tdm_1>;
>>> +		tesla,frame-master = <&tdm_1>;
>>> +		cpu {
>>> +			sound-dai = <&tdm_1 1>;
>>> +		};
>>> +	};
>>> +};
>>> diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
>>> b/arch/arm64/boot/dts/tesla/fsd.dtsi
>>> index 5decad45a1b6..fc8931f830a7 100644
>>> --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
>>> +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
>>> @@ -847,6 +847,9 @@
>>> 			status = "disabled";
>>> 		};
>>>
>>> +		sound: sound {
>>> +		};
>>> +
>> Why to have an empty node in dtsi?
> This is required as every node we use in dts should have the same declared in

I see no reason why this is required.

> dtsi. Sound nodes in most of the platform is only declared (dummy node) in
> dtsi and defining only in dts. Thus we are following the same.

Can you point me to Samsung platform doing this?

Keep the code consistent with Exynos style.

Best regards,
Krzysztof

