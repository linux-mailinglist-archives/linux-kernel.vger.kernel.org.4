Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFE8707426
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjEQVYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjEQVX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:23:59 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6C19ED1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:23:32 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ac7de2b72fso13555241fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684358609; x=1686950609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EIEqKwPabef9WSSFqkvljMpDwhrfc8zvSY2jSb3gR3A=;
        b=lQ9+fXGrNYb2F27NPBYOaleD8aX/AyoGQtt7Cdi7uALJmO1s4GWTd4IznmyWp7Mr2h
         E4OROenI/eYJQVWvRL4a/ozz7gepNOnNnh2H2TAUcl5g6FSaxqe/Gt50mm1N4L3QeRAa
         ho+YN8zbovYXr2fNpoCa3pQftVcCWhQ+zGD1Ei2nnmuZqZVMrwJAOvce/OWQ7jUL1Rgd
         P26JhuqHkMJ/nCqrfC0ASpWr+yB9itUiaJkObjLDmOKujbEA2X8CFhdzjIhP2zUN1AlB
         Hqyr0Noz0J2q//RSnaOsH4vBVOt/cjL8vz46iFMS3qFzc56/l7uxJ6aD05Me9ifWjh4Q
         s2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358609; x=1686950609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIEqKwPabef9WSSFqkvljMpDwhrfc8zvSY2jSb3gR3A=;
        b=bozVCZgvdm+i4nJyH9JDCki1yOdI2f+DC+b/YG2ShTm0FURiCQH8e38sKraZsGwIJW
         E95K03P8AUOkNMZ7hcnomyU4BF71D/K2ud202eYKrCusAL3AF9qsJVLX9A1NO0qUqtt9
         9ARVmIPBM58ybHV1w+qSWlz6clP90QqmZSPEkqx3sMQX6HsmyzQH2mZDXv17Eqbq9qdi
         AQLV2t0zERbmqM1RSm3vD1GD9h3HBbHLyHYlvBaqPV9Sm+TqY6MyEEsJlEBX/jmnFqOC
         ZfJ8jCuP/BFgJmQTVSgwdibNO07ZXr82TFiO6SeY36M0juccsaTqBdOBViTfmnCl0hHo
         Jm/w==
X-Gm-Message-State: AC+VfDyi6HTg2/EIAjfhU5jm5DS85CYIo/e4c7uVqwF37knNqF/xm+jS
        u/P3q50mCmYtRUvE1sincIZ+1Q==
X-Google-Smtp-Source: ACHHUZ4001udylTG7mZCZpg+TNsGeE/xtbXjzhS1B/zlUDocbhq/vo/xg/nQTpNYk0+21lTA3mBbVw==
X-Received: by 2002:ac2:491c:0:b0:4f3:792c:289d with SMTP id n28-20020ac2491c000000b004f3792c289dmr556905lfi.20.1684358608722;
        Wed, 17 May 2023 14:23:28 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id h9-20020ac25d69000000b004f00d3d9df9sm5405lft.188.2023.05.17.14.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 14:23:28 -0700 (PDT)
Message-ID: <fc89ff77-08d4-851e-b209-df017285e86a@linaro.org>
Date:   Wed, 17 May 2023 23:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Flush RSC sleep & wake votes
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230512150425.3171122-1-quic_bjorande@quicinc.com>
 <f6ecd66b-e207-0ed9-0ff3-1febfdf5bce9@linaro.org>
 <20230515023828.jqrrqkit5ygovimp@ripper>
 <1ecd0cba-296e-b036-f59e-f679c771ae9f@linaro.org>
 <20230516210143.GB606695@hu-bjorande-lv.qualcomm.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230516210143.GB606695@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.05.2023 23:01, Bjorn Andersson wrote:
> On Mon, May 15, 2023 at 11:34:45AM +0200, Konrad Dybcio wrote:
>>
>>
>> On 15.05.2023 04:38, Bjorn Andersson wrote:
>>> On Sat, May 13, 2023 at 11:09:07AM +0200, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 12.05.2023 17:04, Bjorn Andersson wrote:
>>>>> The rpmh driver will cache sleep and wake votes until the cluster
>>>>> power-domain is about to enter idle, to avoid unnecessary writes. So
>>>>> associate the apps_rsc with the cluster pd, so that it can be notified
>>>>> about this event.
>>>>>
>>>>> Without this, only AMC votes are being commited.
>>>> Ouch.
>>>>
>>>> Should we make this required: in bindings and add it to all
>>>> platforms?
>>>>
>>>
>>> I though this was an optimization and in the absence of this callback
>>> the driver would just write out wake and sleep sets as well. But per the
>>> current implementation (and perhaps some underlying cause?) it is indeed
>>> required, if you care about power consumption.
>> Hm.. since it's not strictly required for operation, would something
>> like this be fitting?:
>>
> 
> I don't think it's required for operation, but the current
> implementation does require it.
> 
> So I think we should either require it in the binding to mimic the
> implementation, or the implementation should handle either case (only
> with a performance impact)
Let's just require it then.

Konrad
> 
>> oneOf:
>>   - required:
>>       [...]
>>       - power-domains
>>
>>   - required:
>>       [...]
>>     deprecated: true
>>
>> (if it even works this way)
> 
> I don't think it's worth supporting the combinations.
> 
> Regards,
> Bjorn
> 
>>
>> Konrad
>>>
>>>>>
>>>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>>>> ---
>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
>>>>
>>>
>>> The Fixes sounds reasonable.
>>>
>>> Thanks,
>>> Bjorn
>>>
>>>> Konrad
>>>>>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>>>> index 8fa9fbfe5d00..5c68f2182c2f 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>>>> @@ -3982,6 +3982,7 @@ apps_rsc: rsc@18200000 {
>>>>>  			qcom,tcs-config = <ACTIVE_TCS  2>, <SLEEP_TCS   3>,
>>>>>  					  <WAKE_TCS    3>, <CONTROL_TCS 1>;
>>>>>  			label = "apps_rsc";
>>>>> +			power-domains = <&CLUSTER_PD>;
>>>>>  
>>>>>  			apps_bcm_voter: bcm-voter {
>>>>>  				compatible = "qcom,bcm-voter";
