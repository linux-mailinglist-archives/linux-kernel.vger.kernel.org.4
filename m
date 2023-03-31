Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1D56D265C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjCaQ6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjCaQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:58:37 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015D0CC32
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:58:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h25so29742254lfv.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680281913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hg1hXo3YKH/4ZXl0Bdlyb1YGCLWHlTSlPb8rJUV/Kbo=;
        b=vjtUojPefRyqY+EWHbk0JjeTGM/N6xkAxTRRmYSI9XFQN/RSvrW/Ikqn3Eo/iFr5nd
         oXDcgkPdtUorydkQgDPDs486K6MfxJXIMVOh+er2U3LOl1Vwy1CY2V9Vwr2K8fYKvFup
         kA6p2zjiEAUhQkyFH74s3051Ryh3cCIET1sY486KCEcs9sXXjyoLgrtlClsSS9miNvSv
         hCoHzL0DK5hankH/kLs0DJaiETHAc9IsOOR6OMuDR8mYlV6kDtCVCyzHUFBNMJgeCLtb
         zPjMEu64v8haYCu2BJE1zkIfevKcQfnkykDu30Td7t3gU5j3GTL4XO2Sjjke9W9Wp44s
         YleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680281913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hg1hXo3YKH/4ZXl0Bdlyb1YGCLWHlTSlPb8rJUV/Kbo=;
        b=DgOHtjJMJKzz2h7pe4Nuh6P5krrBb0WOa8NGSDpTGONrt4NqrBGUVsgWQSYVs/ZgJY
         xGgygrQPv7lh1mmM5Rb7sglxUdf9JqRjXjH2h0qU4OSa6NHml526rh6MeK2lob7PFmBO
         bEJEZlT3PhQuo5fUtcrYw8VkCqHg8zEj/Qw+USprKLWwVp5j54VhDKzWgKmYuQl/AIRt
         Mfpur+qd7yCZZy22JwGPFHh+/wOD/EFW9Bjwu1Ocz/h00KkghRdPEQMztP69EU4cSY82
         st2jYPUNOBkl+5q7p6Owtcc/NsoYVfyw+YhDqwvKMbvx4n6BdP3iybTECi5mbMkqSvjG
         e/tQ==
X-Gm-Message-State: AAQBX9dvr2VlhuDGupOR2meBG0NwaHmBgxnasGENsaRmuFQalYcWpo8h
        6dZKvCVEyiK12BBwsHMzJrU/bw==
X-Google-Smtp-Source: AKy350ZrZLcTT2PuvoFqTFyfP0UYsKgVGSDG9xR3i4dZoLnDzfY2hfB9nbLERhwWRrcK9lXv+TMYrQ==
X-Received: by 2002:a19:ad07:0:b0:4e8:c81b:1a11 with SMTP id t7-20020a19ad07000000b004e8c81b1a11mr7746310lfc.49.1680281913169;
        Fri, 31 Mar 2023 09:58:33 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id w15-20020ac25d4f000000b004e81c9bb65csm440732lfd.282.2023.03.31.09.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 09:58:32 -0700 (PDT)
Message-ID: <8f0d4b5b-211c-ac53-798e-70d2f2b3ab37@linaro.org>
Date:   Fri, 31 Mar 2023 18:58:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/4] dts: arm64: qcom: sdm845: add SLPI FastRPC support
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230330165322.118279-1-me@dylanvanassche.be>
 <20230330165322.118279-3-me@dylanvanassche.be>
 <f9a4a2de-42f8-676a-ae6d-d20391206f83@linaro.org>
 <e7b73a24b8ba76cb6dc9921f73c47632a749b93f.camel@dylanvanassche.be>
 <e43e944c-9f65-cde5-5d8c-a76f33f99b44@linaro.org>
 <603ef0bf04b9c4f7f8e94e2ccece97ffa1b0582b.camel@dylanvanassche.be>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <603ef0bf04b9c4f7f8e94e2ccece97ffa1b0582b.camel@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.03.2023 15:14, Dylan Van Assche wrote:
> On Fri, 2023-03-31 at 14:20 +0200, Konrad Dybcio wrote:
>>
>>
>> On 31.03.2023 11:36, Dylan Van Assche wrote:
>>> Hi Konrad,
>>>
>>> On Fri, 2023-03-31 at 04:03 +0200, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 30.03.2023 18:53, Dylan Van Assche wrote:
>>>>> Qualcomm SDM845 SoC features a SLPI DSP which uses FastRPC
>>>>> through
>>>>> an allocated memory region to load files from the host
>>>>> filesystem
>>>>> such as sensor configuration files.
>>>>>
>>>>> Add a FastRPC node at /dev/fastrpc-sdsp and a DMA region,
>>>>> similar
>>>>> to
>>>>> downstream, to allow userspace to communicate with the SLPI via
>>>>> the
>>>>> FastRPC interface for initializing the sensors on the SLPI.
>>>>>
>>>>> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 24
>>>>> ++++++++++++++++++++++++
>>>>>  1 file changed, 24 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>> index 3b547cb7aeb8..8ea4944f3ad6 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>> @@ -878,6 +878,14 @@ mdata_mem: mpss-metadata {
>>>>>                         size = <0 0x4000>;
>>>>>                         no-map;
>>>>>                 };
>>>>> +
>>>>> +               fastrpc_mem: fastrpc {
>>>>> +                       compatible = "shared-dma-pool";
>>>>> +                       reusable;
>>>> Please move it last to get a nice reverse-Christmas-tree layout.
>>>>
>>>
>>> Will fix in v4.
>>>
>>>>> +                       alloc-ranges = <0 0x00000000 0
>>>>> 0xffffffff>;
>>>> Would there be any issues with it starting over (1<<31 - 1)?
>>>>
>>>
>>> You mean a bigger region then, like the whole CMA region then?
>>> AFAIK,
>>> the SLPI always use the same region expecting it to be in this
>>> range.
>>> However, I cannot confirm more, as I have no insights in the
>>> firmware
>>> running on there, this all comes from finding out what it exactly
>>> does
>>> on downstream.
>> I was asking about the <.. 0 0xfff.f> part specifically, as that
>> means
>> it can't be allocated above 4 gigs. But I guess it's just how qcom
>> envisioned it.
>>
> 
> I think it is limited by qcom, but I cannot be entirely sure :)
> In any case, for v4, do I keep 0xffffffff?
Yep, let's not stray into the unknown..

Konrad
> 
>> Also, please use 0x0 in alloc-ranges as well, this is all addresses/
>> reg sizes.
>>
>> Konrad
> 
> Yes, will use 0x0 instead of 0.
> 
> Dylan
> 
>>>
>>>>> +                       alignment = <0 0x400000>;
>>>> Please use 0x0 for the 0 here, as it's essentially reg.size with
>>>> size-cells = 2
>>>
>>> Will fix in v4.
>>>
>>>>
>>>>> +                       size = <0 0x1000000>;
>>>> Ditto
>>>
>>> Will fix in v4.
>>>
>>>>
>>>>> +               };
>>>>>         };
>>>>>  
>>>>>         adsp_pas: remoteproc-adsp {
>>>>> @@ -3344,6 +3352,22 @@ glink-edge {
>>>>>                                 label = "dsps";
>>>>>                                 qcom,remote-pid = <3>;
>>>>>                                 mboxes = <&apss_shared 24>;
>>>>> +
>>>>> +                               fastrpc {
>>>>> +                                       compatible =
>>>>> "qcom,fastrpc";
>>>>> +                                       qcom,glink-channels =
>>>>> "fastrpcglink-apps-dsp";
>>>>> +                                       label = "sdsp";
>>>>> +                                       qcom,non-secure-domain;
>>>>> +                                       qcom,vmids = <0x3 0xF
>>>>> 0x5
>>>>> 0x6>;
>>>> Please use the recently-introduced header and depend on (and
>>>> make a patch atop)
>>>>
>>>> https://lore.kernel.org/linux-arm-msm/8685b710-b74d-556a-815d-0ffef2b0eeff@linaro.org/T/#t
>>>>
>>>> Konrad
>>>>
>>>>> +                                       memory-region =
>>>>> <&fastrpc_mem>;
>>>>> +                                       #address-cells = <1>;
>>>>> +                                       #size-cells = <0>;
>>>>> +
>>>>> +                                       compute-cb@0 {
>>>>> +                                               compatible =
>>>>> "qcom,fastrpc-compute-cb";
>>>>> +                                               reg = <0>;
>>>>> +                                       };
>>>>> +                               };
>>>>>                         };
>>>>>                 };
>>>>>  
>>>
>>> Kind regards,
>>> Dylan
> 
