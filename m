Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334F46D023E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjC3K5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjC3K5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:57:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE6461A4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:57:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g19so10851259lfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680173840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fEeZR+WcM39xhpEXHe4o33Q+UWFLjkaYXxsz/SpALV0=;
        b=ap0PmGpEjOfv2nUrxeYfNyJjPZMDfcKXuBbxzGaRAAPQ+EoUPnXPPUnwvm0mhZIxIp
         wSrcSzDwkPl6zD1gtzkxtoPXsELvPtUhQUKjq/kcGOmfywtmBsWZMdFwtFz6Gkt8jt4X
         1xYqe0jFL1GdN5LP9Cft3qyzy8PrBKYUb4CHwGlGw71FkMYUqx84boxjguNgO9h+t4yu
         FZ4uza72h/VodF59WruDDzowT2xLnGbmJyIS9Zco7JG9H3e5dgAQQzr6RMKhnsgsfuTX
         PZCrbrnV/gy53rwYDueBKk+i88MKJwUme7Pb0fOpvLfPEqPox3g/xHSznD14dUQfZtT7
         OqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680173840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fEeZR+WcM39xhpEXHe4o33Q+UWFLjkaYXxsz/SpALV0=;
        b=BzBYd7dZWRo3ccout43uXYdDa2T+giqHDKD4VftUr4XOQIcC9QjNZBbDEFeuOTuc8D
         RLDlRg31viuuRmsC5u27WzeMnRis3n/M5Hzw3OMqr9D+HxXLzV89xqJyTlAMYHRXTLSG
         M7i2P1E3m9e2Gtq0y4sN0Wiu+iIpp71HisJf1ChC7/CtH9YKMsYsqQirz4bqp+wZ1dOb
         LBhYFtu39V8aSA3Us2dJYA3XzpDHfvE/nwJeMAuLMQ07pKbHYwikXsRG6W80zB0QuCJG
         voTcCsWKeTj/ZDuemE/2piEA2rLVS1UkX1R+fzretJIzOITF2gr0MzWm9r3AU9C6fTpu
         tjbA==
X-Gm-Message-State: AAQBX9eRzUtXq68iCvox0z3hocE1hGuWq42y47g4cvo9WXOaVOE518I8
        dkhwMZmvnwrY3tMLoPF0j/A3JA==
X-Google-Smtp-Source: AKy350ZbNlhbm9DQxukLP3ML+9FgpDYCaeTXB86XDbiFJ0YpbMmqdtHJQxXD09YjvMnEjlF5JuzyAg==
X-Received: by 2002:ac2:50d9:0:b0:4e8:44c1:f170 with SMTP id h25-20020ac250d9000000b004e844c1f170mr6951040lfm.54.1680173840314;
        Thu, 30 Mar 2023 03:57:20 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id t18-20020ac243b2000000b004e92c0ed7a0sm5823486lfl.100.2023.03.30.03.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 03:57:19 -0700 (PDT)
Message-ID: <bc5dd7d1-e001-8bd2-55c6-b6827c418371@linaro.org>
Date:   Thu, 30 Mar 2023 12:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/4] arm64: dts: qcom: msm8996: Improve GPU OPP table
Content-Language: en-US
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpprgiXWZC2W3JSgG3jtTZDtbwoeQ6LBK=pqfpk0oMvNRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.03.2023 23:32, Dmitry Baryshkov wrote:
> On Wed, 29 Mar 2023 at 22:17, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> Remove the self-explanatory comment about opp-supported-hw contents,
>> add required-opps to ensure reasonable power domain levels are voted
>> for (currently we've been piggybacking off of miracles and MDP votes)
>> and add newlines between each subnode.
> 
> I'm not sure this is 100% correct. The values that you add are correct
> for the voltage scaling case. However, based on the vendor kernel
> sources I think that MX should only be scaled if the voltage is scaled
> too. I might be wrong here.
MX must be >= CX (and GX), so this should bring no harm.

(citation needed, but that seems to hold true..)

Konrad
> 
>>
>> Fixes: 69cc3114ab0f ("arm64: dts: Add Adreno GPU definitions")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 18 +++++++++++++-----
>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> index 4dd37f72e018..62ad30e94f40 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> @@ -1244,37 +1244,45 @@ gpu: gpu@b00000 {
>>                         gpu_opp_table: opp-table {
>>                                 compatible = "operating-points-v2";
>>
>> -                               /*
>> -                                * 624Mhz is only available on speed bins 0 and 3.
>> -                                * 560Mhz is only available on speed bins 0, 2 and 3.
>> -                                * All the rest are available on all bins of the hardware.
>> -                                */
>>                                 opp-624000000 {
>>                                         opp-hz = /bits/ 64 <624000000>;
>> +                                       required-opps = <&rpmpd_opp_turbo>;
>>                                         opp-supported-hw = <0x09>;
>>                                 };
>> +
>>                                 opp-560000000 {
>>                                         opp-hz = /bits/ 64 <560000000>;
>> +                                       required-opps = <&rpmpd_opp_turbo>;
>>                                         opp-supported-hw = <0x0d>;
>>                                 };
>> +
>>                                 opp-510000000 {
>>                                         opp-hz = /bits/ 64 <510000000>;
>> +                                       required-opps = <&rpmpd_opp_nom>;
>>                                         opp-supported-hw = <0xff>;
>>                                 };
>> +
>>                                 opp-401800000 {
>>                                         opp-hz = /bits/ 64 <401800000>;
>> +                                       required-opps = <&rpmpd_opp_nom>;
>>                                         opp-supported-hw = <0xff>;
>>                                 };
>> +
>>                                 opp-315000000 {
>>                                         opp-hz = /bits/ 64 <315000000>;
>> +                                       required-opps = <&rpmpd_opp_svs>;
>>                                         opp-supported-hw = <0xff>;
>>                                 };
>> +
>>                                 opp-214000000 {
>>                                         opp-hz = /bits/ 64 <214000000>;
>> +                                       required-opps = <&rpmpd_opp_svs>;
>>                                         opp-supported-hw = <0xff>;
>>                                 };
>> +
>>                                 opp-133000000 {
>>                                         opp-hz = /bits/ 64 <133000000>;
>> +                                       required-opps = <&rpmpd_opp_svs>;
>>                                         opp-supported-hw = <0xff>;
>>                                 };
>>                         };
>>
>> --
>> 2.40.0
>>
> 
> 
