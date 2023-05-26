Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE57712783
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbjEZNaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjEZNao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:30:44 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7867B2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:30:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f4e71a09a7so589678e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685107841; x=1687699841;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfZSE2VrEzidVH5V+y6HSH//6rsyLPAC+IpvXsNaa4g=;
        b=z1TH196jDThDF+K2GrUKJEuvOdehfOAmJup6j2X3Xn8MsxbgsFn3+5y5Qc1z0da8de
         a2mFhxPGcjte7ULSxfoN9L+NWQOq269NUWtzP3W8Sf7d2oRNzRTLe24/437oR4c1hBl4
         QTzewqve2FprL77eVrhDakXF0El2Z9ilBKG3gM80D1XOkzuPBlcvmLha4IbONsffEF+n
         wYPYckrs+KMWyYZ0XQNXFi87180oYl43vgci1GvJP922vZAERxXJ+T0XWbT4gLhccG5G
         0KR+wKOSsy5XvSl49WAeqd+JpYY3Stt5CMSMnX0YBt/kt2b4+/cfRHNHpiAbnHBs0Ojo
         KTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685107841; x=1687699841;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfZSE2VrEzidVH5V+y6HSH//6rsyLPAC+IpvXsNaa4g=;
        b=AY38Rpj3eXntWB5dCusZyBCBSV5my6+sVDUVASOjY9XGM2nJL87kVNj79ZN3fsqP8u
         9ytDjpaq6H+LXxW9qcE2n/8yu5WbxM3WAG9xBo0B8SEHp35PYTXcO8C4uFVRqYl8F5Qo
         le2u0YS4OlB5TD5ZhhKpBEP8AETxObTdEI3aQgX5vc6gTng27g1MnEkMIwLU8BmtmZEW
         zlSEROXxqdV4xIJVJ1HH6jRb7ZUkD9FjFUTDKsI7YhCQKPw1X8kqtnVG5x6ggn890fH4
         hIkFwPLt8AjsU6NbhnEIRi4JfAG2zRKT9TeXcvSgj7EBZ+ehLVzVeMkUBgUEZ5uXl2Qi
         OTEg==
X-Gm-Message-State: AC+VfDxuiMgYpsvF0iOAA+gU+C48yu0g4y/bdmb+E+poD1KSYi/GLZD7
        d3EdmsjaFHxch+NM9hh1RJqyVw==
X-Google-Smtp-Source: ACHHUZ5Dwi5KJ7IYLyb5OYgYCB/qY8JncuCtVCHs3GNzJQ5cJOQO7LIEkCE27eiIwXRd5YmWBvtN9A==
X-Received: by 2002:ac2:529b:0:b0:4f4:c6df:22a0 with SMTP id q27-20020ac2529b000000b004f4c6df22a0mr524702lfm.18.1685107840995;
        Fri, 26 May 2023 06:30:40 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id d12-20020ac241cc000000b004f2529c71c1sm616090lfi.260.2023.05.26.06.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 06:30:40 -0700 (PDT)
Message-ID: <0e703d3c-7ad9-6265-fa71-b62650b96e79@linaro.org>
Date:   Fri, 26 May 2023 15:30:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] arm64: dts: qcom: msm8996: Improve GPU OPP table
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>
References: <20230329-topic-adreno_opp-v1-0-24d34ac6f007@linaro.org>
 <20230329-topic-adreno_opp-v1-3-24d34ac6f007@linaro.org>
 <CAA8EJpprgiXWZC2W3JSgG3jtTZDtbwoeQ6LBK=pqfpk0oMvNRw@mail.gmail.com>
 <bc5dd7d1-e001-8bd2-55c6-b6827c418371@linaro.org>
In-Reply-To: <bc5dd7d1-e001-8bd2-55c6-b6827c418371@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.03.2023 12:57, Konrad Dybcio wrote:
> 
> 
> On 29.03.2023 23:32, Dmitry Baryshkov wrote:
>> On Wed, 29 Mar 2023 at 22:17, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>
>>> Remove the self-explanatory comment about opp-supported-hw contents,
>>> add required-opps to ensure reasonable power domain levels are voted
>>> for (currently we've been piggybacking off of miracles and MDP votes)
>>> and add newlines between each subnode.
>>
>> I'm not sure this is 100% correct. The values that you add are correct
>> for the voltage scaling case. However, based on the vendor kernel
>> sources I think that MX should only be scaled if the voltage is scaled
>> too. I might be wrong here.
> MX must be >= CX (and GX), so this should bring no harm.
> 
> (citation needed, but that seems to hold true..)
With that in mind, would you ack these patches Dmitry?

Konrad
> 
> Konrad
>>
>>>
>>> Fixes: 69cc3114ab0f ("arm64: dts: Add Adreno GPU definitions")
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 18 +++++++++++++-----
>>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>>> index 4dd37f72e018..62ad30e94f40 100644
>>> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>>> @@ -1244,37 +1244,45 @@ gpu: gpu@b00000 {
>>>                         gpu_opp_table: opp-table {
>>>                                 compatible = "operating-points-v2";
>>>
>>> -                               /*
>>> -                                * 624Mhz is only available on speed bins 0 and 3.
>>> -                                * 560Mhz is only available on speed bins 0, 2 and 3.
>>> -                                * All the rest are available on all bins of the hardware.
>>> -                                */
>>>                                 opp-624000000 {
>>>                                         opp-hz = /bits/ 64 <624000000>;
>>> +                                       required-opps = <&rpmpd_opp_turbo>;
>>>                                         opp-supported-hw = <0x09>;
>>>                                 };
>>> +
>>>                                 opp-560000000 {
>>>                                         opp-hz = /bits/ 64 <560000000>;
>>> +                                       required-opps = <&rpmpd_opp_turbo>;
>>>                                         opp-supported-hw = <0x0d>;
>>>                                 };
>>> +
>>>                                 opp-510000000 {
>>>                                         opp-hz = /bits/ 64 <510000000>;
>>> +                                       required-opps = <&rpmpd_opp_nom>;
>>>                                         opp-supported-hw = <0xff>;
>>>                                 };
>>> +
>>>                                 opp-401800000 {
>>>                                         opp-hz = /bits/ 64 <401800000>;
>>> +                                       required-opps = <&rpmpd_opp_nom>;
>>>                                         opp-supported-hw = <0xff>;
>>>                                 };
>>> +
>>>                                 opp-315000000 {
>>>                                         opp-hz = /bits/ 64 <315000000>;
>>> +                                       required-opps = <&rpmpd_opp_svs>;
>>>                                         opp-supported-hw = <0xff>;
>>>                                 };
>>> +
>>>                                 opp-214000000 {
>>>                                         opp-hz = /bits/ 64 <214000000>;
>>> +                                       required-opps = <&rpmpd_opp_svs>;
>>>                                         opp-supported-hw = <0xff>;
>>>                                 };
>>> +
>>>                                 opp-133000000 {
>>>                                         opp-hz = /bits/ 64 <133000000>;
>>> +                                       required-opps = <&rpmpd_opp_svs>;
>>>                                         opp-supported-hw = <0xff>;
>>>                                 };
>>>                         };
>>>
>>> --
>>> 2.40.0
>>>
>>
>>
