Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED33160B605
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiJXSqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiJXSp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:45:26 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A357E275D8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:27:02 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id d13so6493677qko.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oAek37vjg533E+KXPzY6NiIkzeTs3RqdU5uNmYRrEtA=;
        b=p549pJ0NuAmrlP8tHip6YdpFYJF7V3yQHxw7sVh2dps44znq07mbsyxPQg0RIaNS+o
         /CJCFmqsEw9ZgH1i3nj5ujTW4YqwEi9MW/0BSk99bMiPctODH/ivRDdyY6421Km7hq8r
         5ELCkddoUcHVOg2irPUpEy9oRkrZcBZbfnn1Obr5zaaIB1VFAWyDLnDAuv2pPrXY84jn
         +bMuFwTlyTrJzdPmSGavspdLJmF2gOFDU9yb7qnGl0eo7PPDKbxRgKtZPHBq3i1ivUz3
         9Xsk9naz9xEi8U3R7cWBIuPh/6zE15bDS21Sy3oUDcWB2OYrgUF7gTWUme1XwqC/af2i
         PydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAek37vjg533E+KXPzY6NiIkzeTs3RqdU5uNmYRrEtA=;
        b=Oy4jpCeS2AsFGjUxQ+o2ErGTADLnuhFzHc8FV92MEauVF0X5n8s2broxaYtjNzvEE5
         7K9nSdShmJTzbrF1eNNiQIr1sHcv6MAbKqxw2uWkzneVH8krY8oKOZJVuvuxcL1cqG19
         EZKBDc7AEPDKgOMA8SD2mNyGhauWMpUSOOW5/ZhVdbQCDsu6Bm3E73be7/K+ZhAgJ5bF
         vJhQmHhx/4Lka1WOtGRQDPh3VUu45aXE3yQsq+GT7lJ4fenJlWjC/qjaH/SuQMEpdLfS
         mC5QeEQmRYj3NY6kzDU+GaH3foYjXXukWp7EyfGzE2kL+4sWn/HfGjG/mcmCbK0KTgDW
         O7Xw==
X-Gm-Message-State: ACrzQf14cz6ZR3r7n4z9qyQ1czjRQJhg/Til/6FV3soPOPbx9H4OYwvr
        /9VgtMuADDNXkOxQQGpm9JphTfEM5ay2fw==
X-Google-Smtp-Source: AMsMyM4i3Tok78vyl1Hyu/01vM/hhkn6bFwNErMqMACO8TAgdDPI63KC6R9LizL8jbsxO/d/T3YyyA==
X-Received: by 2002:a05:622a:450:b0:39d:9a0:3b with SMTP id o16-20020a05622a045000b0039d09a0003bmr20592217qtx.213.1666630004301;
        Mon, 24 Oct 2022 09:46:44 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id j19-20020a05620a411300b006cfaee39ccesm228706qko.114.2022.10.24.09.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 09:46:43 -0700 (PDT)
Message-ID: <8c1428a6-f268-cb03-3e55-887d30236924@linaro.org>
Date:   Mon, 24 Oct 2022 12:46:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 10/13] arm64: dts: qcom: sm8450: add spmi node
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
 <9f696023-f2b4-ccd0-34a0-6f4d5848e862@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9f696023-f2b4-ccd0-34a0-6f4d5848e862@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 12:45, Dmitry Baryshkov wrote:
> On 24/10/2022 17:56, Krzysztof Kozlowski wrote:
>> On 09/12/2021 05:35, Vinod Koul wrote:
>>> Add the spmi bus as found in the SM8450 SoC
>>>
>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 18 ++++++++++++++++++
>>>   1 file changed, 18 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> index f75de777f6ea..b80e34fd3fe1 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> @@ -645,6 +645,24 @@ pdc: interrupt-controller@b220000 {
>>>   			interrupt-controller;
>>>   		};
>>>   
>>> +		spmi_bus: spmi@c42d000 {
>>> +			compatible = "qcom,spmi-pmic-arb";
>>> +			reg = <0x0 0x0c400000 0x0 0x00003000>,
>>> +			      <0x0 0x0c500000 0x0 0x00400000>,
>>> +			      <0x0 0x0c440000 0x0 0x00080000>,
>>> +			      <0x0 0x0c4c0000 0x0 0x00010000>,
>>> +			      <0x0 0x0c42d000 0x0 0x00010000>;
>>
>> This is a patch from December 2021. Is there anything blocking it from
>> being merged?
>>
>> The same applies to several other patches here.
> 
> As far as I know, Stephen still didn't pick up the spmi-pmic-arb support 
> for the PMIC on the SM8450 platform. Thus we also can not merge the DT 
> parts.

Why we cannot merge DTS? How is DTS with new nodes depending on any
driver changes?

Just like I replied to Konrad - if that's true, bindings are simply
wrong and should be fixed.

Best regards,
Krzysztof

