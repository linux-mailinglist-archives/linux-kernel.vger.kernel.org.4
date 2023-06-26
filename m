Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA09573DF1D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjFZM0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjFZM0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:26:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3508C1FCC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:24:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f122ff663eso4079216e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687782263; x=1690374263;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4/usV9SmPrw9YMJ1tZs6M96H3CCg9x93t0YJ04VAnc=;
        b=T4MUSiROjM3/ZBLadiv5trjj35SWBgCW2OFv4YS4Ok6gRz60IZTb2giAG4LtDVulC1
         RyE+IehMmjZnAwz1kffneG+LAlqbR3viyOxpeOmXBT8QNXodae0WagOVh+ukTa1LNcDa
         IZRv8Hsy3HYbVGmLDIhdIE8+86X51eElbNwgQ4CDtgGRtg6hB/r45Yt9XcxLbLYqelEx
         ih/Ap7mtON7ZW5o+JRZFwttRu3Dasox7MyfwIebCTEzqSkEw72Su3/CTt+gZ7/AMGmyg
         17HWXJzGpphht9f1d4IkzDOeDSvDNyOWTyxJmIZs7MPN2ZbGwOXvoTdfQwBE8nG88oeS
         8pSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687782263; x=1690374263;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4/usV9SmPrw9YMJ1tZs6M96H3CCg9x93t0YJ04VAnc=;
        b=fcqXvEUntDJMfFTZmuxcJ2lNkeFa3DFbHYQhFKI7d1AmI8Fk4WYmVL+RDIqXYG534q
         FqkODlzRvIzwxMpksNpiAkT5wO4NDMLsvNffHQzR7GCjM6SXSFQo/PLsTZXaExNNvbxI
         xOwoXEmjVM/vfnDVKOmFgUWYrCgyiQ1iQl0z+jtbblTRYdZmR8TgZ5FqNialQFZpBQ0g
         oHMHeQuJciJPhjQAO8Q+/LQ7OsRSR8QYrYWIXhX89CKGAlfDkBdUkpdiRj39rHMd+fX3
         whMqLW11uavNNmf8YweVDEUp5vJ4pdYVIQhuT1KWg5gXMsXBYHOJgBm4ddrjRuO8JHJL
         eKSg==
X-Gm-Message-State: AC+VfDyyQlf8VddEaqe6kEo78mm1CWbwwxkYAhD5mGVykEZyxldB8TI9
        dDe5qpOPmXzg8KqiSzej8gU8Mw==
X-Google-Smtp-Source: ACHHUZ5UNT258Q+YwaT5EaqCxquyAb6g29zQis0QS1ze04Ukxas719GXXR4yKzh4NMtFyYNf6/IYog==
X-Received: by 2002:a05:6512:2316:b0:4fb:761c:7c18 with SMTP id o22-20020a056512231600b004fb761c7c18mr1402678lfu.61.1687782263272;
        Mon, 26 Jun 2023 05:24:23 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id l7-20020ac24a87000000b004faa82946d8sm850152lfp.178.2023.06.26.05.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 05:24:22 -0700 (PDT)
Message-ID: <af148e01-4026-a086-af78-a1e252fcc724@linaro.org>
Date:   Mon, 26 Jun 2023 14:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, swboyd@chromium.org,
        andersson@kernel.org, broonie@kernel.org, agross@kernel.org
Cc:     robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, judyhsiao@chromium.org,
        quic_visr@quicinc.com,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <20230616103534.4031331-1-quic_mohs@quicinc.com>
 <20230616103534.4031331-7-quic_mohs@quicinc.com>
 <7d2e580e-1861-d22f-e67d-726a2a69043e@linaro.org>
 <3441b3cb-29dd-691c-1e95-5bddd66c684a@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [RESEND v6 6/8] arm64: dts: qcom: sc7280: Modify VA/RX/TX macro
 clock nodes for audioreach solution
In-Reply-To: <3441b3cb-29dd-691c-1e95-5bddd66c684a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.06.2023 13:13, Mohammad Rafi Shaik wrote:
> 
> On 6/16/2023 4:59 PM, Konrad Dybcio wrote:
>> On 16.06.2023 12:35, Mohammad Rafi Shaik wrote:
>>> From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>>
>>> Modify VA, RX and TX macro and lpass_tlmm clock properties and
>>> enable them. For audioreach solution mclk, npl and fsgen clocks
>>> are enabled through the q6prm clock driver.
>>>
>>> Delete the power domain properties from VA, RX and TX macro,
>>> for audioreach solution the macro, dcodec power domains enabled
>>> through the q6prm clock driver.
>>>
>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>>> ---
>> Maybe sc7280-audioreach.dtsi containing all these changes that could be
>> reused by others would be in order?
> Thanks for comment,
> 
> yes, will create a common sc7280-audioreach.dtsi file, which will contain common audioreach changes
> and could be reused by others.
>>>   .../sc7280-herobrine-audioreach-wcd9385.dtsi  | 43 +++++++++++++++++++
>>>   1 file changed, 43 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>>> index 9daea1b25656..c02ca393378f 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
>>> @@ -196,3 +196,46 @@ q6prmcc: clock-controller {
>>>           };
>>>       };
>>>   };
>>> +
>>> +&lpass_rx_macro {
>>> +    /delete-property/ power-domains;
>>> +    /delete-property/ power-domain-names;
>> Surely they shouldn't cause issues, even if the vote would be
>> superfluous? They are still powered by these power domains, I'd assume?
> No, In Audioreach case this macro and decodec clocks are not power by power domains,
> this macro and decodec hw clocks are enrolled by q6prmcc clock voting.
So the same piece of hardware is modeled differently twice?

i.e. the same GDSCs are reached once with register accesses and once
registered as "Q6 vote clocks"?

that sounds like a bit of an overstep to register them with genpd and CCF
depending on what entity controls them.. perhaps the "q6 vote clocks" could
be remodeled as power domains as that's what they're ultimately seem to
be referencing.. Krzysztof should have an opinion.

Konrad
>>> +    clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +         <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +         <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +         <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +         <&lpass_va_macro>;
>>> +    clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
>> The drivers use clk_get with name-based lookup.. you should be able to
>> simply extend the list in the common DTSI. Please test that on both
>> audioreach and the other thing though.
>>
>> Konrad
> The clock names are not a extensions, same set of clocks are used in non ADSP solutions.
> In Audioreach solution these clocks enabling by q6prmcc clock voting.
> 
> Rafi.
>>> +
>>> +    status = "okay";
>>> +};
>>> +
>>> +&lpass_tlmm {
>>> +    clocks = <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +         <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>>> +    clock-names = "core", "audio";
>>> +};
>>> +
>>> +&lpass_tx_macro {
>>> +    /delete-property/ power-domains;
>>> +    /delete-property/ power-domain-names;
>>> +    clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +         <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +         <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +         <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +         <&lpass_va_macro>;
>>> +    clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
>>> +
>>> +    status = "okay";
>>> +};
>>> +
>>> +&lpass_va_macro {
>>> +    /delete-property/ power-domains;
>>> +    /delete-property/ power-domain-names;
>>> +    clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +         <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +         <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>>> +    clock-names = "mclk", "macro", "dcodec";
>>> +
>>> +    status = "okay";
>>> +};
