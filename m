Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8546A0C35
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjBWOvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBWOvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:51:38 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AD459424
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:51:36 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m7so13979881lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cKP/YloJ0OTk1Xglp3NOzzCGaVgg7YFxQB7FIhSRxwQ=;
        b=gnuyw/43I9lW3uSoOmMTHB9/YkkCpbjw21JM58EHCFJLWthALpGuPkCXFguNsij/yu
         PUSnyr0KT4lK5RxcBbxBB/IByddBj+P3hdyl0bA6PW3BLjbDYhRDB8T/8TQbHwVujvNU
         JIfZn0vnE/sfwKnEKEqRz8W3TWmKVWDcuK4MNuo7diYXMlAiJaQQZq71VDIMgn09qsN4
         jDSHw1ew1lB1mruDtK8SCfYVGxtuSgOjlUVctPZDwcgppzmG27Jxn9FUFU5S9JZhRjtY
         +YczytkQAd6G1l4TdaqeD/3RQZACwgAV2nTzlnaKl8WhUF2gG6WHo6dXT1Tj6pWFmZhu
         9MeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cKP/YloJ0OTk1Xglp3NOzzCGaVgg7YFxQB7FIhSRxwQ=;
        b=OOEkF9+QuwPuGwocGa4hs/K9+oeZD4FEW8MHe8eHt9elA++IT0H4uBH51E/j+0cfuB
         bueuDiVpqpZf6gk2epz23h6ag7Qd9bfoZytKLDzHTvbGV9CrlE+KPD+Wj1zhbNchZRF/
         z63gERAeZ00FhETt6zv6G+WFtxe/Vnq2/mf4LsAo003s4jnhCHyAa/b1penUcNMJcG51
         4kpHxUPDR3j0c3pnpyHuPBDxxLqdr61e37DmbGShEQVgdS7FOsgwi138XeP3/3Swalye
         tWdPA1Cqm6AexzhdErYRSP9P6nxiY6ehGOzeyUYABl64Y8lV4uoLe5EFrp+j85vA+tip
         9FJQ==
X-Gm-Message-State: AO0yUKWelKRZU3mv1HTMy3ikBcmXV+ZAlqlYJ84QyNrkoLS+WY0JrZxx
        H00kopSvuxxtZc6rHv4LiEUA6g==
X-Google-Smtp-Source: AK7set/JzmQxNYhoYOGR53AF3yyANHsb8TETRVoVhpKbUAMZWOA/GJaFtTbLDT5T7avOgrAT5PuOUA==
X-Received: by 2002:a19:ac4d:0:b0:4cb:64:ba93 with SMTP id r13-20020a19ac4d000000b004cb0064ba93mr3774850lfc.36.1677163895158;
        Thu, 23 Feb 2023 06:51:35 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id u8-20020ac25188000000b004dda02f5e42sm337967lfi.298.2023.02.23.06.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 06:51:34 -0800 (PST)
Message-ID: <b39f63ce-7f88-ba68-df46-de9470d63a4e@linaro.org>
Date:   Thu, 23 Feb 2023 15:51:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 10/15] drm/msm/a6xx: Fix A680 highest bank bit value
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>
References: <20230223-topic-gmuwrapper-v3-0-5be55a336819@linaro.org>
 <20230223-topic-gmuwrapper-v3-10-5be55a336819@linaro.org>
 <CAA8EJppi45K0hQ=1fZvf+Mps+4uEkXmLFeqdmyk-yk31CNvUsw@mail.gmail.com>
 <761e0aba-9364-557a-e6e5-e21494597dbc@linaro.org>
 <CAA8EJppvmojWnvwB1aKJ1M7CcoFHk9BLFR0U7CQGR9GexQckdw@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJppvmojWnvwB1aKJ1M7CcoFHk9BLFR0U7CQGR9GexQckdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.02.2023 15:48, Dmitry Baryshkov wrote:
> On Thu, 23 Feb 2023 at 15:49, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 23.02.2023 14:06, Dmitry Baryshkov wrote:
>>> On Thu, 23 Feb 2023 at 14:07, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>
>>>> According to the vendor sources, it's equal to 16, which makes hbb_lo
>>>> equal to 3.
>>>
>>> I think we might be stricken with the ddr kind difference here, but I
>>> would not bet on it.
>> It totally is, but it also seems to be SoC-dependent..
>> I think all 8180x devices shipped with LPDDR4X FWIW
> 
> I think so too. However sdmshrike dts uses LPDDR5.
Yeah.. it may be better to skip this patch; it should be
possible to apply this series without this one.

Konrad
> 
>>
>> Konrad
>>>
>>>>
>>>> Fixes: 840d10b64dad ("drm: msm: Add 680 gpu to the adreno gpu list")
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 8 +++++++-
>>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> index b5017c56fa1b..2c4afecdd213 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> @@ -885,12 +885,18 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>>>>                 hbb_lo = 2;
>>>>         }
>>>>
>>>> -       if (adreno_is_a640_family(adreno_gpu)) {
>>>> +       if (adreno_is_a640(adreno_gpu)) {
>>>>                 amsbc = 1;
>>>>                 /* HBB = 15 */
>>>>                 hbb_lo = 2;
>>>>         }
>>>>
>>>> +       if (adreno_is_a680(adreno_gpu)) {
>>>> +               amsbc = 1;
>>>> +               /* HBB = 16 */
>>>> +               hbb_lo = 3;
>>>> +       }
>>>> +
>>>>         if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu)) {
>>>>                 amsbc = 1;
>>>>                 /* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
>>>>
>>>> --
>>>> 2.39.2
>>>>
>>>
>>>
> 
> 
> 
