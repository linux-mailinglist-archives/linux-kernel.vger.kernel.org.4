Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8696B661FFE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbjAII3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjAII2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:28:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F4C13F29
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:28:06 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso5971790wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 00:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ZCewxmSxLwjuTUJjEP99Um0ViA3Vm33HjXmtOQ3d/o=;
        b=jitoHFJbmjiTIgBjF94+6C4mHCdkBTWpEBDFRG+XnntFVfdzHO6T7D1eTrh+7TM2/y
         Vvugxax3ToI1qdUcBuGahhS7fbScrkCCKAWEnVBugBrjN4tw31/zXEF43PJNNg3mJE8v
         dI9OImeuaVWxgYsIlZbiELfYd1buuZZogSKQjUORsfkQJefdNbtw0lAhiICXOza2CK1H
         0XfShVdC/8tI7JsCjhcFyn7k/7KHtIrIt0hoApyDqtOcER7HwkZVN6/bNtX/8oTVDtwg
         qelTOd47vaFwIs07eN6K95FnTG8P1jZidrczdEME93VoX5Poftl+5kmelWRxEdvYutuf
         CUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZCewxmSxLwjuTUJjEP99Um0ViA3Vm33HjXmtOQ3d/o=;
        b=bGnm71/V0BCNpicOWovo3kWiSgqU7IYDgJmZ5OGAvyRw3Xe2RWz3M66f7+siHqNEnp
         7KHtTW+kYTNJ3pLuzLonIp4E2tZZWFK+ReW1wRxA//AfZENXWhglWxytf3H7vFTbOcp3
         o6JAdCLITodQNWpV/U9jN4bHg3GYYUFoHUEzjkeleUntqmnWG4zr10OO6JkvA3IuVq5E
         oDQW+qIaZdJCchZAfF7MoA4cB7JkA2nP564sTbOTssWlzW/jyWjOcnZUdUtQxMrNxCjn
         LM9a3hNtURxe6KQlIv4AqXv4JyHRHhgpQbrz+0zZCTSrl8Xt1TyLlw81m0ud/SjGsYv5
         HISA==
X-Gm-Message-State: AFqh2kr4tVTzIUs97VEqLOHENYA0JOpCvPMZ6zPoDaum0vkFsx39Mtks
        uCRkIyi104uoqFXzpaD2gRF0Rg==
X-Google-Smtp-Source: AMrXdXsW4Y6VQtOfBMg1ixd+skEs/6VaeQjIOiffrpDts1lV+k5r/dn+S5QZUFVgYhyTLtDMaIsXqA==
X-Received: by 2002:a05:600c:4fc6:b0:3d3:4a47:52e9 with SMTP id o6-20020a05600c4fc600b003d34a4752e9mr45041342wmq.15.1673252885142;
        Mon, 09 Jan 2023 00:28:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b003d04e4ed873sm16855748wmq.22.2023.01.09.00.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 00:28:04 -0800 (PST)
Message-ID: <a0c06803-450c-eb44-8789-8a48c577389d@linaro.org>
Date:   Mon, 9 Jan 2023 09:28:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 5/5] arm64: dts: fsd: Add sound card node for Tesla FSD
Content-Language: en-US
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20230103045613.100309-1-p.rajanbabu@samsung.com>
 <CGME20230103045706epcas5p14f2f951d162899234c7f5f7a0998ab6b@epcas5p1.samsung.com>
 <20230103045613.100309-6-p.rajanbabu@samsung.com>
 <2c6950c9-3489-c2d4-2ca8-cb723195f75b@linaro.org>
 <051601d923df$a0e7b840$e2b728c0$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <051601d923df$a0e7b840$e2b728c0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 05:05, Padmanabhan Rajanbabu wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>> Sent: 03 January 2023 04:43 PM
>> To: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>;
>> lgirdwood@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
>> perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
>> alim.akhtar@samsung.com; rcsekar@samsung.com;
>> aswani.reddy@samsung.com
>> Cc: alsa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org
>> Subject: Re: [PATCH v2 5/5] arm64: dts: fsd: Add sound card node for Tesla
>> FSD
>>
>> On 03/01/2023 05:56, Padmanabhan Rajanbabu wrote:
>>> Add device tree node support for sound card on Tesla FSD board
>>>
>>> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
>>> ---
>>>  arch/arm64/boot/dts/tesla/fsd-evb.dts | 37
>>> +++++++++++++++++++++++++++
>>>  1 file changed, 37 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts
>>> b/arch/arm64/boot/dts/tesla/fsd-evb.dts
>>> index e2fd49774f15..ce726bddfb50 100644
>>> --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
>>> +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
>>> @@ -29,6 +29,43 @@
>>>  		device_type = "memory";
>>>  		reg = <0x0 0x80000000 0x2 0x00000000>;
>>>  	};
>>> +
>>> +	sound {
>>> +		compatible = "simple-audio-card";
>>> +
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +
>>> +		simple-audio-card,name = "FSD Audio Card";
>>> +		simple-audio-card,widgets =
>>> +			"Line", "Line Out",
>>
>> I don't think you need to break the line after '='.
> 
> Okay, will change the same in the next patch set.
> 
>>
>>> +			"Line", "Line In";
>>> +		simple-audio-card,routing =
>>> +			"Line Out", "LLOUT",
>>> +			"Line Out", "RLOUT",
>>> +			"MIC2L", "Line In",
>>> +			"MIC2R", "Line In";
>>> +
>>> +		status = "okay";
>>
>> Why?
> 
> Okay, I understood that if there is no status entry, it is
> treated as "okay". I'll update the same in the next
> patch set.
> 
>>
>>> +
>>> +		simple-audio-card,dai-link@0 {
>>> +			reg = <0>;
>>> +			format = "i2s";
>>> +			bitclock-master = <&tlv320aic3x>;
>>> +			frame-master = <&tlv320aic3x>;
>>> +
>>> +			cpu0 {
>>
>> Does not look like you tested the DTS against bindings. Please run `make
>> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
>> for instructions).
> 
> I did not encounter any error while running dtbs_check for fsd-evb.dts
> 
> This is the command I executed
> make dtbs_check > output.txt 2>&1
> 
> dt-mk-schema --version: 2022.11
> 
> Please let me know if I'm missing anything here.

You are right. I misread the pattern in simple-card.yaml. I'll fix the
file, so let's make these nodes: cpu-0 and cpu-1.

Best regards,
Krzysztof

