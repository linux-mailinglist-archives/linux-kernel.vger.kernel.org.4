Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930EE7485DC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjGEOT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGEOT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:19:27 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0BC12A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:19:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99342a599e9so492715066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688566764; x=1691158764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zzg1Rcs4/REQbUAnr+xfpofd5U46nBqWnDZ+dmUTDMg=;
        b=WRgmBEXA3L6lrnXfNKzwl17gLX243dbZg1O0xaa5KobN6rRNevuYsXqPM1MJ52uENv
         IqOLTLZgratN6oGZ0J49GnKdK+LUgZmmcWlMvttMyjglkJfNE2SVgthNySLIFbqcy6oH
         3KDgA7goUatdTGsx2kSJDM3bXxBHKNsRihhm8IyNs5tFunkmevU/a0jqLhSSigRwrlds
         UOGcxKtLnl2ZeAZfX0PZJRthu44Bc94u7P8GAIwTDXsNl6h2EQZajU7MuzV7VmedUw03
         inoMViAWywfL13yfVDiC52Zp+vSleNVvf5N3EC2M0DzeFQ+miu2el869eo+QEKuSJjZM
         LlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688566764; x=1691158764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzg1Rcs4/REQbUAnr+xfpofd5U46nBqWnDZ+dmUTDMg=;
        b=ih9lYitciGa5w132S6oDUEDj0yUZEv3Pqt6vmqMj5OVVgH8uGW9VZ255tRirDbt1Zz
         4vMu4KkbVeAfLnViXufR2RMexIAxgBYlCQ0Wm6TPqnkVK1C4iQvZYuUUXTOcx+RaNT/1
         Is17O2n5pJd+VVWCAPx8yWA5FvaYs9xJZrVDKuYwasJ3UWNnxPc0ZW5GMCsofUKH7uxw
         PlPnVBdS4z88VG3Gtiygs3ZXNi0vyyX5wSVj02IDG0FiBDQLTYXS29NyOJGbLVCcOgMj
         5JE8w8wpZiEeOoZaWBOamoIlcJvAMbiLi7OtYlb1PII93zuvG/dEgXqeIBEnrsPdg3cr
         BA3A==
X-Gm-Message-State: ABy/qLZhAE5nHvnVqtTb47bFivK2upnCOBmTqcWdF4JYdnYjOdIT5NlF
        OT27rRih6SMlEAl0t3SqmIK+IA==
X-Google-Smtp-Source: ACHHUZ4eDxk7lH1bbt75+5Z/GkSrqU3s5olRDPv3Ik55v2et8HE8B31Znv4eN2zZg8AXfxdAZBmCUA==
X-Received: by 2002:a17:906:90d4:b0:991:fef4:bb9 with SMTP id v20-20020a17090690d400b00991fef40bb9mr13117765ejw.58.1688566764162;
        Wed, 05 Jul 2023 07:19:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id xa10-20020a170907b9ca00b00977c7566ccbsm14739232ejc.164.2023.07.05.07.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 07:19:23 -0700 (PDT)
Message-ID: <3acd3f26-831d-898f-e3f0-731814eb09b6@linaro.org>
Date:   Wed, 5 Jul 2023 16:19:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: qdu1000-idp: Update reserved memory
 region
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230705053914.9759-1-quic_kbajaj@quicinc.com>
 <20230705053914.9759-2-quic_kbajaj@quicinc.com>
 <CAA8EJpo406gV-5H8+y4SJbbRqnWFRo5wrR6a9KJ2arbN61tS2Q@mail.gmail.com>
 <db283531-36a2-0535-4fe2-d1571b3fa8cb@quicinc.com>
 <CAA8EJpotQs_C_b+qvR1gXcasOtcw6SA8hCgJfuHFa7PnvPeobQ@mail.gmail.com>
 <e285a22e-4943-4c9e-50d6-2dcac30703d3@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e285a22e-4943-4c9e-50d6-2dcac30703d3@linaro.org>
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

On 05/07/2023 13:08, Konrad Dybcio wrote:
> On 5.07.2023 11:42, Dmitry Baryshkov wrote:
>> On Wed, 5 Jul 2023 at 10:06, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>>>
>>>
>>>
>>> On 7/5/2023 11:19 AM, Dmitry Baryshkov wrote:
>>>> On Wed, 5 Jul 2023 at 08:40, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>>>>> Add missing reserved regions as described in QDU1000 memory map.
>>>>>
>>>>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>>>>> ---
>>>>>   arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 26 ++++++++++++++++++++++++
>>>>>   1 file changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>>>> index 1d22f87fd238..3f5512ec0a90 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>>>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>>>> @@ -448,6 +448,32 @@ &qupv3_id_0 {
>>>>>          status = "okay";
>>>>>   };
>>>>>
>>>>> +&reserved_memory{
>>>>> +       #address-cells = <2>;
>>>>> +       #size-cells = <2>;
>>>>> +       ranges;
>>>>> +
>>>>> +       ecc_meta_data_reserved_mem:ecc_meta_data_reserved_region@e0000000{
>>>> no_underscores_in_node_names. Ever.
>>>>
>>>> Also, if you have checked other platforms, you'd have seen that other
>>>> platforms use a much more generic node name for 'memory' nodes (which
>>>> you should have used too).
>>>
>>> These memory nodes are new to QDU platform, so will it be okay if I keep
>>> these names without region suffix?
>>
>> Just use 'memory@abcd'.
> Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> 
>   Following the generic-names recommended practice, node names should
>   reflect the purpose of the node (ie. "framebuffer" or "dma-pool").
>   Unit address (@<address>) should be appended to the name if the node
>   is a static allocation.
> 

Yeah, two minutes too late :)

Best regards,
Krzysztof

