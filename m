Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED2E60B4EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiJXSHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiJXSHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:07:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBCD1735B9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:47:55 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r14so17740880lfm.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=idp4JnfOyED40+ywErCfhlkpwF2VRaHFDjwu98Br8YY=;
        b=skwmlPhXe+NZ4ZKB1fmEvkCHjl/xRuGDW4A1tfNIs0mxctA7wMYOuYYMVRsVDV+C9i
         EgQN2q/uswzmI/N+K3+3nX0eDe/h17vgxHYTpsEZiC5PzEMGzRLh5rIlikmuRsIBg6N4
         M1JYth0GwGWVZ6/GJlVGQLiVfIRH8Q6CY6qcZZ1a6cGJubRSDah73ol/FxqDT63r+yqV
         rIjfC8fZoGSSMOVRqlY0vJ+xls7YRU7dwiRnRl8V8AM/Eoa0f9977GZqWvXlVURuPXFO
         dx8uykfpkXS13nwOVmCaSqWeuC9Wmkajq3vUh48ugiVC1Fso0HCSviAgqnB5rZ+gUvib
         A2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idp4JnfOyED40+ywErCfhlkpwF2VRaHFDjwu98Br8YY=;
        b=S4uOvJ0yAUCyn6+v1EIBTNCeV6Gs3ubCyrjbxt9Etub7jk/6yMAKdYjvj2K/IBg8Rf
         Sh4i5zvJ9p/KsTevgQd2RkAVl+c+oLUPYziQkLzmCjObIxf1EujlI5vlBFYvaZ1OWNa2
         3gbc1mRzWUMFPxJlPQQcTWUgdx3x0oMFpIXdkyXssm7hwf5RS5KsyDKo/ibDJPK0RTkh
         cVbJgwAd1tCdyPoJkhB+GGYFHAmQINWVNzo+7hWrg2kznPlBihtcuJKpLM5KjFk7Xl7k
         TR5F/YxWLf//+gHpNiqie/RSHKBw47lq0NyMxw2b6OtYMIsJyffqAwo0FfR+3PzfHmOI
         HPKA==
X-Gm-Message-State: ACrzQf3e2uDYSys6aVnr5QewfWQV3QaYtn+anKZkpH41oIVnVABzNZi3
        eMOcCLfj9z/yMJHbhhDpE8DkJA==
X-Google-Smtp-Source: AMsMyM6AzX4UKf6q6iEGaYfg+wfLzycQ2rFGHEbZ7ghzT39PtEuDc+eFeNv8Z0fudncjDNKQyU5Vtw==
X-Received: by 2002:a05:6512:20d3:b0:4ac:5217:4c6b with SMTP id u19-20020a05651220d300b004ac52174c6bmr1458509lfr.512.1666629927808;
        Mon, 24 Oct 2022 09:45:27 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k15-20020ac24f0f000000b00498fc3d4d15sm4593326lfr.190.2022.10.24.09.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 09:45:27 -0700 (PDT)
Message-ID: <9f696023-f2b4-ccd0-34a0-6f4d5848e862@linaro.org>
Date:   Mon, 24 Oct 2022 19:45:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 10/13] arm64: dts: qcom: sm8450: add spmi node
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211209103505.197453-1-vkoul@kernel.org>
 <20211209103505.197453-11-vkoul@kernel.org>
 <5035b6a3-164b-afa0-b714-4deb886f9f90@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <5035b6a3-164b-afa0-b714-4deb886f9f90@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 17:56, Krzysztof Kozlowski wrote:
> On 09/12/2021 05:35, Vinod Koul wrote:
>> Add the spmi bus as found in the SM8450 SoC
>>
>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index f75de777f6ea..b80e34fd3fe1 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -645,6 +645,24 @@ pdc: interrupt-controller@b220000 {
>>   			interrupt-controller;
>>   		};
>>   
>> +		spmi_bus: spmi@c42d000 {
>> +			compatible = "qcom,spmi-pmic-arb";
>> +			reg = <0x0 0x0c400000 0x0 0x00003000>,
>> +			      <0x0 0x0c500000 0x0 0x00400000>,
>> +			      <0x0 0x0c440000 0x0 0x00080000>,
>> +			      <0x0 0x0c4c0000 0x0 0x00010000>,
>> +			      <0x0 0x0c42d000 0x0 0x00010000>;
> 
> This is a patch from December 2021. Is there anything blocking it from
> being merged?
> 
> The same applies to several other patches here.

As far as I know, Stephen still didn't pick up the spmi-pmic-arb support 
for the PMIC on the SM8450 platform. Thus we also can not merge the DT 
parts.

-- 
With best wishes
Dmitry

