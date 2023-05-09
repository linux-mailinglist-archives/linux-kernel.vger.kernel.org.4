Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9DF6FBC1F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 02:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjEIAsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 20:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjEIAso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 20:48:44 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5096659E8
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 17:48:43 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ac89e6a5a1so45630291fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 17:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683593321; x=1686185321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1lzmlWPoQrGWW/oFjCS6ule6bte9k1/D4wXcMLKMj98=;
        b=Lw3hqCrXauny7MRb6KpT8X5icjyE2GQ2FgZACC1KIrFbogeFB5gXLo1WRVyhmPCDaq
         FNrDzmsI1QyFeiXdUC2iCAYSFaZLXVsiRuXT4dZXAR7hPon2jyjkwZ44cv4iXDGcHvvY
         ZJ8onHUPXH/frl5OnAY/7KQdrr+PILipxcqBMzgcftbmB8WuECICjPS2BKk1VnBYfhud
         QmulsGek8dGWlRv8/Ym6X+etHuE/rrOo+pFnBqvgeL0uvHj/x1r4o73vYQZLeQ5O72NK
         pbE6/Iv8RiLDrbHtEMYqs52Isc3N3xTqsFpn2x9BWhgGtG3pUGTsnTtlpU93OM86mu/d
         Ms6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683593321; x=1686185321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lzmlWPoQrGWW/oFjCS6ule6bte9k1/D4wXcMLKMj98=;
        b=bMwz0NuHq42ICi0eJMjvYpwQtXY/U5PHKqO/xlcWzo14QJDcsMNiF2gmAgtKIvgzCu
         qN6RVJDz7KqxbAu3fvyLcExK4aCT7/Zy4lIsDfUjOMp6Dx1qGcEAqCi9fmAw7ueLKpxb
         8L37YPJuAJx2KSlZGGpDeS1Cv9v4JMq5KSAQ7bLI1n2i1t8TbrU5hN//uAK+RJUBsATO
         tutqLPUt7K8nH9v3QaXULn8B8fHeceYWd/JB1/dgU384+QQ1vFqjvcnAixhMEJp3/WaG
         ywy0BaWoSFQ+VopfDKT8lUr92n3R2eHE5oK/3ChH4BgE7vijhh64cx0mylLh90OgxvVE
         EKxQ==
X-Gm-Message-State: AC+VfDzmRWFE7wuzxYniwqIoiU0XvPU5j1ie4Dgwtdscsv0Ta+H6v1HY
        5xAQhDwL51O83n7Ob2CEXFGr/g==
X-Google-Smtp-Source: ACHHUZ6i07bnhuq04+qehKFZ7QRGgdUS6dRas5Gbp6pbeTQ7xm9zMQ78UveUpoLUc6OsFUtceb5yLA==
X-Received: by 2002:a2e:6e18:0:b0:2ad:9783:bca with SMTP id j24-20020a2e6e18000000b002ad97830bcamr245610ljc.27.1683593321027;
        Mon, 08 May 2023 17:48:41 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id a15-20020a05651c010f00b002ad988efd73sm343073ljb.14.2023.05.08.17.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 17:48:40 -0700 (PDT)
Message-ID: <db0ec6eb-578a-9684-6caa-559abe27015c@linaro.org>
Date:   Tue, 9 May 2023 03:48:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/4] drm/msm/dpu: Add DPU_INTF_DATA_COMPRESS feature
 flag
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230405-add-dsc-support-v2-0-1072c70e9786@quicinc.com>
 <20230405-add-dsc-support-v2-3-1072c70e9786@quicinc.com>
 <i6i2xj2tuy5mcxsj674d77kfdb3ne6immkmrzw5f6u4bfx2sth@ef7fzrhdyypx>
 <1d7ccb5f-55c2-3b3a-df97-2c17beffabfc@quicinc.com>
 <0aa4130d-bb37-4743-10e5-fd518276f4a2@linaro.org>
 <9aad0f0a-f168-5162-68a0-9e9cde21c1f6@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <9aad0f0a-f168-5162-68a0-9e9cde21c1f6@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 03:28, Abhinav Kumar wrote:
> 
> 
> On 5/8/2023 4:08 PM, Dmitry Baryshkov wrote:
>> On 09/05/2023 00:46, Jessica Zhang wrote:
>>>
>>>
>>> On 5/7/2023 9:00 AM, Marijn Suijten wrote:
>>>> On 2023-05-05 14:23:50, Jessica Zhang wrote:
>>>>> Add DATA_COMPRESS feature flag to DPU INTF block.
>>>>>
>>>>> In DPU 7.x and later, DSC/DCE enablement registers have been moved 
>>>>> from
>>>>> PINGPONG to INTF.
>>>>>
>>>>> As core_rev (and related macros) was removed from the dpu_kms 
>>>>> struct, the
>>>>> most straightforward way to indicate the presence of this register 
>>>>> would be
>>>>> to have a feature flag.
>>>>
>>>> Irrelevant.  Even though core_rev was still in mainline until recently,
>>>> we always hardcoded the features in the catalog and only used core_rev
>>>> to select a dpu_mdss_cfg catalog entry.  There is no "if version >= X
>>>> then enable feature Y" logic, this manually-enabled feature flag is the
>>>> only, correct way to do it.
>>>
>>> Hi Marijn,
>>>
>>> Understood. FWIW, if we do find more register bit-level differences 
>>> between HW versions in the future, it might make more sense to keep 
>>> the HW catalog small and bring core_rev back, rather than keep adding 
>>> these kinds of small differences to caps.
>>
>> Let's see how it goes. Abhinav suggested that there might be feature 
>> differences inside the DPU generations (and even inside the single DPU 
>> major/minor combo). So I'm not sure what core_rev will bring us.
>>
> 
> It allows us to have if MDSS_REV() checks which are convenient for some 
> calculations / bit programming which we dont want to expose in the 
> catalog as they cannot be classified as a hw cap as such or atleast we 
> dont want them to be classified as such.
> 
>> Let's land the platforms which are ready (or if there is anything 
>> close to be submitted). I'll post the next proposal for the catalog 
>> cleanups close to -rc4, when the dust settles then we can have one or 
>> two weaks for the discussion and polishing.
>>
>> I'd like to consider:
>> - inlining foo_BLK macros, if that makes adding new features easier
>> - reformat of clk_ctrls
>> - maybe reintroduction of per-generation feature masks instead of 
>> keeping them named after the random SoC
>> - maybe a rework of mdss_irqs / INTFn_INTR. We already have this info 
>> in hw catalog.
>>
>> Comments are appreciated.
>>
> 
> I would say, lets wait for DSC to settle. Atleast the parts already on 
> the list. Continuous rebase of features already on the list is becoming 
> time consuming because of overlapping catalog reworks.

As I wrote, -rc4. Until that time, I'd expect DSC to be settled and 
accepted.

-- 
With best wishes
Dmitry

