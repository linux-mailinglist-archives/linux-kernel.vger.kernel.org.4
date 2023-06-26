Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEF773EAAD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjFZS6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjFZS57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:57:59 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3033DF2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:57:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f973035d60so4622127e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687805874; x=1690397874;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rCdLkrs2k8/GdjdTwOGaHO7ETa8DMcDvVAQQIXLxcIA=;
        b=rAeakYceWuhKPzsOkodDNmSHj+PzFIRXD01GV65oquCHX+0KTmawSHhTJ/ccJoD23H
         J920HjSqhstqpk+Cax6cRq/oFNe+k1enFlPu2/f+gBaSwJz+3NEXW5AHYOeY3EMXhSeS
         fprGmh0QEZ9xAjv8EzR9+H5JoKs/4ePJaRaLd8BbPAMOoQ/BHVOK0PC3jBB1htLkWZB6
         FLW1fPo/n2Myf/hFURBbP4EjaOSbPO6gvle6a+uGf/eUhkNIpViRlh54r7y1/IY+LU+V
         n+Gbkp1TMWbjw/D18GCy0O/nPEtsC0WAylsr1n51VQArHto0dVK5KielJEtnZgeEmz24
         MZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687805874; x=1690397874;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rCdLkrs2k8/GdjdTwOGaHO7ETa8DMcDvVAQQIXLxcIA=;
        b=hIkTFwJb5L0/Go9N9Km+j1XFQpps/ZYndz7/T8/HGejlSQ1mjkGUKNAGLvGs/Cs/fD
         Xbm4ZOUCvmeUAP8mEM18fniulJSEz9rW/2LlEOUeE/qL+vF5fyBui+3pleH2/JpdbYFv
         xBu98MmQMYy0xD2l5Yt6pgZNTRytWiIe/aBv/CPACzqffPq2gh6QhTPj8uET0ylY5f+e
         QI8347MFCrsfhebHP63ai8UDANoJtNxSmhXtlzZFS9g/V9TvqmssB9t7y4yj9QVAg0Bk
         ERpl4n9DjkGTAwX6GJBfd8gssashUKecMaC4Lrb8YqIapnbhpYHndH5p8HEDlh1T0zz6
         6dTg==
X-Gm-Message-State: AC+VfDxoicfBsH5YSpcPpbrpCFCrvDR1FZwaFmhot1ZXb4/s+4vEN3J6
        vVdBK197ASjX86QKUR5Fdcj7yw==
X-Google-Smtp-Source: ACHHUZ7+UEN56oLxNZpprzEBS8sPcmBjz5c7VRXtZgHtsWgmJKEs9PmiVBr7ZbZW5TN5i3z0lW7Tnw==
X-Received: by 2002:a05:6512:2348:b0:4fb:7592:cc7a with SMTP id p8-20020a056512234800b004fb7592cc7amr2668173lfu.20.1687805874286;
        Mon, 26 Jun 2023 11:57:54 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id u27-20020ac248bb000000b004f861e64f24sm1225513lfg.113.2023.06.26.11.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 11:57:53 -0700 (PDT)
Message-ID: <3daf9990-79da-9adf-af6a-d9007c186557@linaro.org>
Date:   Mon, 26 Jun 2023 20:57:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 06/15] dt-bindings: display/msm: sc7180-dpu: Describe
 SM6125
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-6-1d5a638cebf2@somainline.org>
 <6bbf239f-d530-2f1e-ff52-361f7c9cc951@linaro.org>
 <75d64lixeawfoqbrctm4thzh73cxkvnlmnh5xgbpf277pmh3gz@zthnqvvuxmeq>
 <a6f3906a-98a7-de7a-3e26-4b8c45fe93f7@linaro.org>
 <w3bbdq72thnerbyglb4dyshzg4vu5go2wpsciprk27vah6w2ms@yc4eqclct24a>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <w3bbdq72thnerbyglb4dyshzg4vu5go2wpsciprk27vah6w2ms@yc4eqclct24a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.06.2023 19:54, Marijn Suijten wrote:
> On 2023-06-26 18:16:58, Krzysztof Kozlowski wrote:
>> On 25/06/2023 21:52, Marijn Suijten wrote:
>>> On 2023-06-24 11:12:52, Krzysztof Kozlowski wrote:
>>>> On 24/06/2023 02:41, Marijn Suijten wrote:
>>>>> SM6125 is identical to SM6375 except that while downstream also defines
>>>>> a throttle clock, its presence results in timeouts whereas SM6375
>>>>> requires it to not observe any timeouts.
>>>>
>>>> Then it should not be allowed, so you need either "else:" block or
>>>> another "if: properties: compatible:" to disallow it. Because in current
>>>> patch it would be allowed.
>>>
>>> That means this binding is wrong/incomplete for all other SoCs then.
>>> clock(-name)s has 6 items, and sets `minItems: 6`.  Only for sm6375-dpu
> 
> Of course meant to say that clock(-name)s has **7** items, not 6.
> 
>>> does it set `minItems: 7`, but an else case is missing.
>>
>> Ask the author why it is done like this.
> 
> Konrad, can you clarify why other 
6375 needs the throttle clk and the clock(-names) are strongly ordered
so having minItems: 6 discards the last entry

Konrad
> 
>>> Shall I send a Fixes: ed41005f5b7c ("dt-bindings: display/msm:
>>> sc7180-dpu: Describe SM6350 and SM6375") for that, and should maxItems:
>>> 6 be the default under clock(-name)s or in an else:?
>>
>> There is no bug to fix. Or at least it is not yet known. Whether other
>> devices should be constrained as well - sure, sounds reasonable, but I
>> did not check the code exactly.
> 
> I don't know either, but we need this information to decide whether to
> use `maxItems: 6`:
> 
> 1. Directly on the property;
> 2. In an `else:` case on the current `if: sm6375-dpu` (should have the
>    same effect as 1., afaik);
> 3. In a second `if:` case that lists all SoCS explicitly.
> 
> Since we don't have this information, I think option 3. is the right way
> to go, setting `maxItems: 6` for qcom,sm6125-dpu.
> 
> However, it is not yet understood why downstream is able to use the
> throttle clock without repercussions.
> 
>> We talk here about this patch.
> 
> We used this patch to discover that other SoCs are similarly
> unconstrained.  But if you don't want me to look into it, by all means!
> Saves me a lot of time.  So I will go with option 3.
> 
> - Marijn
