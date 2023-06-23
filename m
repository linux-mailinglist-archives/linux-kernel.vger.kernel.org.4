Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5114F73BCF8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjFWQr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjFWQrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:47:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B2C2139
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:47:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so1096495e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687538840; x=1690130840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OBUMS6+Ixu1UXqr8YNawSIcwQonUlT827pYdb6QYXzM=;
        b=Eq2l7Fk3m2lCefTcxvs3+qQRjgFuhPqfZXhyz91WenXW4qaDYW7tL3o4sqmvx9/h9j
         LogKawFNSl8qmE2Hp9FS+L9O/1GgBEo4JVyOpq3EKMcdeaWTG4uCKlac7Bn3QrDpm948
         DKGLo8OFoRAEn+dxZUeyzTNaVFZAq6hgkaXEcvzuRcj+Ko4n1I/3R85b1h6U5XBH0kG4
         OG5XPKRxqTSdkMjATUKVBw5mn8z9gKEj7Svy62GCTLJno5ItYalw+YgijGwaGjKP7Ji/
         ilV5ajz2eBLuT06wt+aqdJTX4kcI8NTfuQYEUs1h+0PBk/aUWrEV1IGibRteyY3l9WBz
         SjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538840; x=1690130840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBUMS6+Ixu1UXqr8YNawSIcwQonUlT827pYdb6QYXzM=;
        b=BcxX4e/XV6n/0f48eX+vrSlZ25QyQ+L5F4mFw0Y8j5QoAyLLm7G9x11XPW+xRzsALf
         hwVu89S+ScfLFKyg1hmjZ9kypnZybkBoczKWlHl1PdvBqhzGU3Fx5oNLyol8YYhKHM1q
         ZhJCDx72ZpRBs2lWHE0VrwNWaD1/lbsTM2xJlYhH/K6cKWa1pyDKufO79znV7GS+GPst
         vq8wilEe+EYSw0lsZIbzWfgMcsKuGYtSCWmr+zoUkxy4MB2Dh47e05yFTMLfPe8/Pymd
         SXDEU4pYLbq/VXjUnPnypKuFVPpgHOL+0aIv6B+i1hzErOaqZItYzqTKkYdOhZYVjl0T
         fMwA==
X-Gm-Message-State: AC+VfDw04kjB9ACwwIBhIkM52hZjBLO4J+NPun0PXeNbkmeCJP9a8W+J
        U0/pbpebZSQVwytkOrcg5xOUxi3daSn+7wvgisk=
X-Google-Smtp-Source: ACHHUZ4mTr8TfarXPNlaSuduTiF2uA8iz5vlWI4LEQ7eCH/nJ1M2G9BvOXl8zA6zlbqA6FLWYDfDmA==
X-Received: by 2002:a19:670f:0:b0:4f8:7513:8cac with SMTP id b15-20020a19670f000000b004f875138cacmr9096198lfc.48.1687538839814;
        Fri, 23 Jun 2023 09:47:19 -0700 (PDT)
Received: from [192.168.1.101] (abyk30.neoplus.adsl.tpnet.pl. [83.9.30.30])
        by smtp.gmail.com with ESMTPSA id l30-20020ac24a9e000000b004f86c43d615sm1481013lfp.295.2023.06.23.09.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 09:47:19 -0700 (PDT)
Message-ID: <d0c08de9-0506-d430-4928-4a441d8102a4@linaro.org>
Date:   Fri, 23 Jun 2023 18:47:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V4 4/4] arm64: dts: qcom: sm8550: Add camera clock
 controller
Content-Language: en-US
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230609115058.9059-1-quic_jkona@quicinc.com>
 <20230609115058.9059-5-quic_jkona@quicinc.com>
 <8d1ead23-8361-7943-baba-baf20d16cbe5@linaro.org>
 <a3652f67-3e48-db33-1dd2-c17abdbdae41@quicinc.com>
 <CAA8EJpqjAkdnU+WXoPJs2m4OSZQe10D=Y8nUAofEoEfV139VjA@mail.gmail.com>
 <bb149870-ed5a-3587-f85a-1080fd6ca03e@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <bb149870-ed5a-3587-f85a-1080fd6ca03e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.2023 18:45, Jagadeesh Kona wrote:
> 
> 
> On 6/14/2023 5:45 PM, Dmitry Baryshkov wrote:
>> On Wed, 14 Jun 2023 at 14:56, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>>
>>>
>>>
>>> On 6/9/2023 6:22 PM, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 9.06.2023 13:50, Jagadeesh Kona wrote:
>>>>> Add device node for camera clock controller on Qualcomm
>>>>> SM8550 platform.
>>>>>
>>>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>> ---
>>>>> Changes since V3:
>>>>>    - No changes
>>>>> Changes since V2:
>>>>>    - No changes
>>>>> Changes since V1:
>>>>>    - Padded non-zero address part to 8 hex digits
>>>>>
>>>>>    arch/arm64/boot/dts/qcom/sm8550.dtsi | 15 +++++++++++++++
>>>>>    1 file changed, 15 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>>>>> index 75cd374943eb..4d2d610fc66a 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>>>>> @@ -5,6 +5,7 @@
>>>>>
>>>>>    #include <dt-bindings/clock/qcom,rpmh.h>
>>>>>    #include <dt-bindings/clock/qcom,sm8450-videocc.h>
>>>>> +#include <dt-bindings/clock/qcom,sm8550-camcc.h>
>>>>>    #include <dt-bindings/clock/qcom,sm8550-gcc.h>
>>>>>    #include <dt-bindings/clock/qcom,sm8550-gpucc.h>
>>>>>    #include <dt-bindings/clock/qcom,sm8550-tcsr.h>
>>>>> @@ -2419,6 +2420,20 @@ videocc: clock-controller@aaf0000 {
>>>>>                       #power-domain-cells = <1>;
>>>>>               };
>>>>>
>>>>> +            camcc: clock-controller@ade0000 {
>>>>> +                    compatible = "qcom,sm8550-camcc";
>>>>> +                    reg = <0 0x0ade0000 0 0x20000>;
>>>>> +                    clocks = <&gcc GCC_CAMERA_AHB_CLK>,
>>>>> +                             <&bi_tcxo_div2>,
>>>>> +                             <&bi_tcxo_ao_div2>,
>>>>> +                             <&sleep_clk>;
>>>>> +                    power-domains = <&rpmhpd SM8550_MMCX>;
>>>> I see that both MMCX ("mmcx.lvl") and MXC ("mxc.lvl") (and MX, FWIW)
>>>> are consumed on msm-5.15, with the latter one powering camcc PLLs..
>>>>
>>>> How are they related? Is that resolved internally or does it need
>>>> manual intervention?
>>>>
>>>> Konrad
>>>
>>> These are just different voltage rails, camcc clocks are powered by MMCX
>>> rail and camcc pll's are powered by MXC rail. Consumer drivers need to
>>> take care of voting on these rails properly based on the frequency of
>>> clocks requested.
>>
>> Which rail powers registers of the camcc? Which rail is required to
>> read PLL registers?
>>
> MMCX rail is required to access camcc registers, both MMCX and MXC are required to read PLL registers. MXC rail should be left ON from bootloaders during bootup and hence does not require explicit voting.
That's a bad approach. We have a sync_state callback in rpmhpd that kills
unused-from-linux-POV power rails, so Linux should be made aware of any
and all requirements there.

Konrad
> 
> Thanks,
> Jagadeesh
> 
>>>
>>> Thanks,
>>> Jagadeesh
>>>
>>>>> +                    required-opps = <&rpmhpd_opp_low_svs>;
>>>>> +                    #clock-cells = <1>;
>>>>> +                    #reset-cells = <1>;
>>>>> +                    #power-domain-cells = <1>;
>>>>> +            };
>>>>> +
>>>>>               mdss: display-subsystem@ae00000 {
>>>>>                       compatible = "qcom,sm8550-mdss";
>>>>>                       reg = <0 0x0ae00000 0 0x1000>;
>>
>>
>>
