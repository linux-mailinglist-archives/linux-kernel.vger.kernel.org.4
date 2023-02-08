Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCC668F6CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjBHSTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjBHSTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:19:34 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2381333475
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:19:32 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id rp23so2169603ejb.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 10:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8j1Bi9kv3dnc4UgTQ2QLvAX5UEkvT1snCnRaL/lrdVc=;
        b=ESo1UeW5CGGyokTezx8utgulMXPoyULquRvBzoZE6ZUKyhj7/BLN6FPAo7DWrGE8Cu
         30xODadrJtq0/H3bx/s6LwBIf3pTNzQSVfWyHsBsAhDSXj4idgkXtceX3qRFDkuYWv/G
         PXQbH7561MWKhaPdcDSxv/R08uhBgRk5gaW500kjUNLqmNu9Ao5yUvbu/GNeKo/X0IDi
         oOfcgn5+k1meX/h65uBRhQHiybcrawHadD6dLoYvwYhQdg+OAKPhCgf53DKgh8E371mk
         ZlWhVezQmkflGYVZ074xFbN4MdTeMVQZ68//EX2lOr3BpXE4ZMpoGp2KnrqbdaqZevRh
         eQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8j1Bi9kv3dnc4UgTQ2QLvAX5UEkvT1snCnRaL/lrdVc=;
        b=ZYAuZRGe06xK8LnvjVEv2iTBfeIriqVyw9YE9f5ruTzeHzerq5tyWZTQEQGPvtTOnb
         GzUM9tJFvze4z01tfhdcWvqMhz7bi1QiAnuHASFvzu8jteM2qKD/TckgrdTiGDybXRKu
         TpsVpEsZAfUMd1i+YQqXcseeA14VLaYl7aODnoVKAW1uRLbIdTg1TGj7SBwMAxs+rnr3
         +MGA/y6kyOe7g+ackPWQyPNRrQT2Jbvwwf1sGPy8T3oKL9aqzZKQZDdi2qtK/89+OPO5
         7ODkFqjkcnOvcVsHIvVGR7CpnrIq4VEez89IyVfTp4iV7mKzR55bKJCnOREfjIL1MW9b
         V3jQ==
X-Gm-Message-State: AO0yUKW9G1LQJV6krbA8WXYCTzSqU7YhbUMnbPEBxiRn/6L5P8Z5hgzj
        5m73iCjDnWQjk+NaJeu8QrD0AQ==
X-Google-Smtp-Source: AK7set+DmXpRl0cOZjV99cvxKq1YbzS7UsUzQtQaOETK5opB59GdKb3+ogZDXDBqqph9fDCnEuRClw==
X-Received: by 2002:a17:906:5fcb:b0:88d:ba89:183e with SMTP id k11-20020a1709065fcb00b0088dba89183emr4035691ejv.15.1675880370645;
        Wed, 08 Feb 2023 10:19:30 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id gh25-20020a170906e09900b008841aa86484sm8645882ejb.211.2023.02.08.10.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 10:19:30 -0800 (PST)
Message-ID: <e1f2a712-c4d1-2cb7-bbb2-e9e1c42e7f7f@linaro.org>
Date:   Wed, 8 Feb 2023 19:19:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sc8280xp-crd: Introduce pmic_glink
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230208034620.2048744-1-quic_bjorande@quicinc.com>
 <20230208034620.2048744-3-quic_bjorande@quicinc.com>
 <229edfec-736f-d94d-23ba-2a0649639556@linaro.org>
 <20230208155720.GA2397622@hu-bjorande-lv.qualcomm.com>
 <e9b6cdcc-079d-497a-6e8b-c2d69a393597@linaro.org>
 <20230208180007.GB2397622@hu-bjorande-lv.qualcomm.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230208180007.GB2397622@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.02.2023 19:00, Bjorn Andersson wrote:
> On Wed, Feb 08, 2023 at 05:40:44PM +0100, Konrad Dybcio wrote:
>> On 8.02.2023 16:57, Bjorn Andersson wrote:
>>> On Wed, Feb 08, 2023 at 09:14:46AM +0100, Konrad Dybcio wrote:
>>>> On 8.02.2023 04:46, Bjorn Andersson wrote:
> [..]
>>>>>  &usb_0_dwc3 {
>>>>> -	/* TODO: Define USB-C connector properly */
>>>>>  	dr_mode = "host";
>>>>> +
>>>>> +	port {
>>>>> +		usb_0_role_switch: endpoint {
>>>>> +			remote-endpoint = <&pmic_glink_con0_hs>;
>>>>> +		};
>>>> This should be defined in the SoC DTSI, it's a standard dwc3 binding
>>>> with usb HS / SS / SBU ports. Especially since we can feed the endpoint
>>>> from any device now, as pmic-glink should work everywhere.
>>>>
>>>
>>> The sa8295p/sa8540p boards, derived from sc8280xp does not implement
>>> pmic_glink, so it seems moving this to the soc.dtsi would be messy.
>>>
>>>> Or /omit-if-no-ref/, I suppose.
>>>>
>>>
>>> Or you're saying I should put the skeleton of the port definition in the
>>> soc.dtsi and then fill it out the remote-endpoint here; and mark it
>>> omit-if-no-ref to avoid binding warnings?
>> I thought omit-if-no-ref actually omits the node before resolving phandles
>> that it references, but it seems to not be the case.. Still, we can define
>> the ports in the SoC DTSI and assign endpoints per-device (like we do with
>> DSI for example).
>>
> 
> You mean move the lines:
> 
> port {
> 	usb_0_role_switch: endpoint {
> 	};
> };
> 
> to sc8280xp.dtsi and then do:
> 
> &usb_0_role_switch {
> 	remote-endpoint = <&pmic_glink_con0_hs>;
> };
> 
> here?
Correct

Konrad
> 
> Regards,
> Bjorn
