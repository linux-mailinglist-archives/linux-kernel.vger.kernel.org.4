Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E220654F50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLWKuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiLWKuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:50:06 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC452EFAC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:50:05 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id x11so6692511lfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WtagtrjVyMLvccSqt3I+WkfzIk+UO6YPIaRsEP+rBLY=;
        b=tSt927mP1h9N5fflQwy+3M1COdivv/3rLlaRfJr0FQ9I3BisLoiYywvm/95jk4Fssk
         6E0GkdulnQMr5wV4k04uyjWQM1CgC7q6bymUdvKO8IYj1//m9BkCxf5XQRS0IMvn0enj
         tFACx7Da24rDGaqCjOxxHDhPekEOOagUh34s3yyRiEIzMNxJY7+08+xWfVGRIWRJ/XBC
         E9gdHf6bJBFAlG6Ng/praFU1adVu82inVAdiSoV9i9Rno3lQoOoNF6dpDoz1/0PRIzm7
         0oUsBuKai7k6FcdiT60O+BF4PcqvxPPGVFlK3aR7FVubLSTjAVKR608jCWVJZrWu4oQP
         qrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtagtrjVyMLvccSqt3I+WkfzIk+UO6YPIaRsEP+rBLY=;
        b=fxscmcPpTKih7QlhieOLu2nhqaJOM/e1gCq/2d4iMazxwFug8ndiAAb82viefgcwCo
         Q4WY1wc7WsdH7hfIa5EJIcslqelMvuGgyehwSiLm2WNozRwOFUl1RMqrDkiImhOlXaUd
         uRcqDXZ0Kt6obfBF/yOJuubjJs4q2/Vknl55woU9RDpAwa+mgC/pVOkIQty0P4F3RxOS
         nj56SwlJZSfIIH9fth6E06/n4GtsaJtK5jl5CuYhCpXBuuVGe33A+8zamov300CJ+tts
         o2EcduH6yBd/7Z5A0TK23CFhA7Rz570L3HyqlPPwmxXMBCsc5XcEtSa0o1T6KdiglCW9
         AV9g==
X-Gm-Message-State: AFqh2kpYrL+Gg09/QC6s8pKKJFmDpnmzsegOKuqaoomor7dXz12LbJdb
        7ujbiXI4KD6J27ppJXXqtOhIvA==
X-Google-Smtp-Source: AMrXdXtUV6jVBYU35M5fl+1l/dWPFQQjjpmybPBcN29GIflG/xU5nRArG+ztoYILdH0vx8K2RCdBdw==
X-Received: by 2002:ac2:4317:0:b0:4b5:834b:9f82 with SMTP id l23-20020ac24317000000b004b5834b9f82mr3518276lfh.58.1671792603447;
        Fri, 23 Dec 2022 02:50:03 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u18-20020ac258d2000000b004c89b9fb1fdsm479107lfo.68.2022.12.23.02.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 02:50:03 -0800 (PST)
Message-ID: <4d00cf12-917b-32ba-5293-2337c21f1a0f@linaro.org>
Date:   Fri, 23 Dec 2022 12:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v14 1/5] arm64: dts: qcom: add data-lanes and
 link-freuencies into dp_out endpoint
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, airlied@gmail.com
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1671217893-17496-1-git-send-email-quic_khsieh@quicinc.com>
 <1671217893-17496-2-git-send-email-quic_khsieh@quicinc.com>
 <1a5cc3d3-ac2d-52c8-79f4-b13252a4bb86@linaro.org>
 <54bd8b85-8b68-4b28-ec68-28edf9a8a097@quicinc.com>
 <f8ed0927-a97e-9395-1297-addb57ecd855@linaro.org>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <f8ed0927-a97e-9395-1297-addb57ecd855@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/2022 09:57, Krzysztof Kozlowski wrote:
> On 22/12/2022 17:22, Kuogee Hsieh wrote:
>>
>> On 12/22/2022 2:47 AM, Krzysztof Kozlowski wrote:
>>> On 16/12/2022 20:11, Kuogee Hsieh wrote:
>>>> Move data-lanes property from mdss_dp node to dp_out endpoint. Also
>>>> add link-frequencies property into dp_out endpoint as well. The last
>>>> frequency specified at link-frequencies will be the max link rate
>>>> supported by DP.
>>>>
>>>> Changes in v5:
>>>> -- revert changes at sc7180.dtsi and sc7280.dtsi
>>>> -- add &dp_out to sc7180-trogdor.dtsi and sc7280-herobrine.dtsi
>>>>
>>>> Changes in v6:
>>>> -- add data-lanes and link-frequencies to yaml
>>>>
>>>> Changes in v7:
>>>> -- change 160000000 to 1620000000
>>>> -- separate yaml to different patch
>>>>
>>>> Changes in v8:
>>>> -- correct Bjorn mail address to kernel.org
>>>>
>>>> Changes in v9:
>>>> -- use symbol rate (hz) for link-frequencies at dp_out at sc7180_trogdor.dtsi
>>>>
>>>> Changes in v13:
>>>> -- delete an extra space at data-lanes
>>>>
>>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi   | 6 +++++-
>>>>    arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 4 ++++
>>>>    2 files changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>>>> index eae22e6..e2783dd 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>>>> @@ -814,7 +814,11 @@ hp_i2c: &i2c9 {
>>>>    	status = "okay";
>>>>    	pinctrl-names = "default";
>>>>    	pinctrl-0 = <&dp_hot_plug_det>;
>>>> -	data-lanes = <0 1>;
>>>> +};
>>>> +
>>>> +&dp_out {
>>>> +    data-lanes = <0 1>;
>>>> +    link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000>;
>>> Messed order of nodes.
>>
>> can you please give me more details and how should i fixed it?
> 
> Node overrides/extends are more or less ordered by name. dp should not
> be around mdp, but for example dsi.

I think it would be better to also rename dp_out to mdss_dp_out. To keep 
all mdss entries nearby.

-- 
With best wishes
Dmitry

