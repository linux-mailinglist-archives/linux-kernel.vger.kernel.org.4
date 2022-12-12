Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F57E649AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiLLJT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiLLJSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:18:50 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE59F2180
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:18:47 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z4so11827899ljq.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ggI8e2BgfqzIWbaGZ/F99vrbDjpdGoe4ym2ciQJhAQ=;
        b=JTeteBqyTIYiNC2voMJWr6Idt1NfbaVrgXTl3Jk/7CP2KNv0z3Ts2tLZG76/wFfpJJ
         feaS4FSUGo8EHy/laqAd+ShHTuBh1AF0MX7AcOuMmf2uaEizceXhBLFTaycfhxBknJUg
         0y2uTChdwx8BNhh3I11WG+z/A2q7UPleCXW3gp0xinPGgyvDFPAYOrVLdWTYKjqiL+cs
         1xd9kQSlSpjQDbfeO90ZWhzIHpiell5ymE7GWByj/uyDkNxtuDxsEhUL35Cc2lkjGaaT
         2QVg1yUEvI+NYzQHdSn54Nv9mL6VQ+HN/23tOWiyCKE4o30GB/jekU7QjOGYGpnEbV3C
         tWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ggI8e2BgfqzIWbaGZ/F99vrbDjpdGoe4ym2ciQJhAQ=;
        b=XEsvlVCfMo/GU8SfYIGhxF5Fq1pW8qgkPSRwg1ZD4lzStxX06AYlA22KbGlDrg121/
         XIZu/fkP8O6ad6Sq3uFAzHS/qcLDC5Wz5zBmdc2+yC8D8tGF36lYY71OtpKQ/zhQF0Oe
         THMZuCL6hz4lQYKm/p2W75t7AQM8ykc7m+ys5yKZPBuTbkKZ2odnFFdmq9l3lRLlsnNd
         VASRqLQdC1O2JgmCCPTfLCWo+zBSOOLe2DQbQnACFyvwtrGG0kW+CgKi+yCRu+X61J+2
         pemunqvRaOSJ5aRfcCDDPFMHivOuWhHgVnkcu+CtioJAgyPRDMUlB+GIzkdTWkcAiPaz
         W3Kg==
X-Gm-Message-State: ANoB5pk31LmO8NmOdufEvbpNp/DWgX9Q5Nhq6L+LeWWfKrSgrNiHxVGm
        yyMW9e50sChs4DK9j5O9BvtKAiYu8PQji7PC
X-Google-Smtp-Source: AA0mqf6xd9QV3xLzdLkYl7FNu8uJrQ1kpNPqC0V/YJJeWLXw6lxOAUoOj9YwIaW8tfc3b/hEqdBGDw==
X-Received: by 2002:a05:651c:887:b0:26f:db35:6043 with SMTP id d7-20020a05651c088700b0026fdb356043mr3543633ljq.14.1670836726352;
        Mon, 12 Dec 2022 01:18:46 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id d9-20020a2e3309000000b0027a00aab48fsm1109322ljc.66.2022.12.12.01.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 01:18:46 -0800 (PST)
Message-ID: <6df8fc01-9fa1-d63d-25fb-ffa6683f4cb6@linaro.org>
Date:   Mon, 12 Dec 2022 10:18:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc7180: move QUP and QSPI opp
 tables out of SoC node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
 <f38f0bfd-858e-1995-167c-de747e57597b@linaro.org>
 <77246ee3-8ff5-1049-6b2a-d8925bc87b33@linaro.org>
 <4522aa1d-99fd-66ad-70bb-d39d9f5ca878@linaro.org>
 <2cf2eae9-9f32-05c5-c802-1d8cec9b4802@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2cf2eae9-9f32-05c5-c802-1d8cec9b4802@linaro.org>
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



On 12.12.2022 10:17, Krzysztof Kozlowski wrote:
> On 12/12/2022 10:15, Konrad Dybcio wrote:
>>>>> +
>>>>> +	qup_opp_table: opp-table-qup {
>>>>> +		compatible = "operating-points-v2";
>>>>> +
>>>>> +		opp-75000000 {
>>>>> +			opp-hz = /bits/ 64 <75000000>;
>>>>> +			required-opps = <&rpmhpd_opp_low_svs>;
>>>>> +		};
>>>>> +
>>>>> +		opp-100000000 {
>>>>> +			opp-hz = /bits/ 64 <100000000>;
>>>>> +			required-opps = <&rpmhpd_opp_svs>;
>>>>> +		};
>>>>> +
>>>>> +		opp-128000000 {
>>>>> +			opp-hz = /bits/ 64 <128000000>;
>>>>> +			required-opps = <&rpmhpd_opp_nom>;
>>>>> +		};
>>>>> +	};
>>>>> +
>>>>>  	memory@80000000 {
>>>> Sidenote: memory@ should be moved above opp-*, alphabetically
>>>>
>>>> For this:
>>>>
>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>
>>> You sure? Because before there is already opp for cpu...
>> Which are called opp-table-cpuN and not cpuN-opp-table, 'm' comes
>> before 'o'.
> 
> So you want to have broken order?
> opp-table-cpu
> memory
> opp-table-qup
> ?
> 
> They are at least all together in my patch.
No, I meant:

memory
opp-table-cpu
opp-table-qup

Konrad
> 
> Best regards,
> Krzysztof
> 
