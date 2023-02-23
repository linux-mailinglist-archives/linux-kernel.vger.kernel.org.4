Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF786A0C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjBWOqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjBWOqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:46:43 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEA5584B6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:46:41 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id b13so12015502ljf.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ewkJKpLhRlkUZJac6/QgsQf+dTNESz/tP/HEthoezNg=;
        b=wwKEAZH73fcxc3cFcceI7bFOwqIhiqICwzOOFLpbwh6vs1vFMZML6cS3Z/n+YWlTL7
         HOc64fe8HuF5JHogri+aYVEuMho/Wb49HzkrRCGrXjoScHxK4NaYfL2agF/Jmih7d2yQ
         N2LRAI221j7iaVJbtNJ56rdnvVhOc3OKfiAvqVUS8g2LyLjCF3DKm49qZ0CKHzFnRMsN
         14Qq2dxcbXoxw3rBrazhTLuzOkZH3A07PpZusxXmf7Tw+Y/AUJFrITR7++tAYAr88sUh
         YSOZwoAge6iGRfGTGXfw+vW05WXEt2T0u/wiu1cmo/TuDSUEW9Pt+bvi+QP1DlT8oBkQ
         13dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewkJKpLhRlkUZJac6/QgsQf+dTNESz/tP/HEthoezNg=;
        b=2KUPw44YpPkclHBZvk678jFPBhZS5WgO+a/OkQOJQrmHUk2jyUTfdTp300n0edDC8Q
         NMoKaL1b6dWjqQa2uK0Ko6HtE4P9mAvuY4XeKxgjFrJmkBF5jwSOrLmWN4vTccCsIpF+
         rCaemsIL7WBvnyg0YUOzP0f7dIHOzwSqKXiqGMZNDIP0QK3mnKD3vivHqMBZaRLIsIOO
         1vYEipY1sS3bbebqt6Xrl7h2ZeaP7jL6W6H1YQyWu6b2EmSoDhkFtWFccBotCdukP1xq
         JORnUayPjMlCkIJmG93d5zSokyUQFlJMPVb/beXZTu+L7bpyKUHFyBphRlv+AiMjlERO
         qHsQ==
X-Gm-Message-State: AO0yUKUjcejtUJS7g0emZnFLkIVdsZy6jDOGIC1HWlV6Xje0hcqxfQTt
        6gzpXh+80SfG0LNat2c12rXVaA==
X-Google-Smtp-Source: AK7set857JU/kQ9OKvktp7r/yAkvD19eRshon2vEqyBgqmVBw9pVvGBGUJ1nugOI/JaMGMecVgSqBg==
X-Received: by 2002:a2e:1551:0:b0:293:2d4d:7e00 with SMTP id 17-20020a2e1551000000b002932d4d7e00mr4257204ljv.12.1677163599764;
        Thu, 23 Feb 2023 06:46:39 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id b12-20020ac25e8c000000b004dc4cb4f9c4sm538605lfq.35.2023.02.23.06.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 06:46:39 -0800 (PST)
Message-ID: <20042c70-b89d-add7-bcdb-1e28932c4e4a@linaro.org>
Date:   Thu, 23 Feb 2023 15:46:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 05/15] drm/msm/a6xx: Introduce GMU wrapper support
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
 <20230223-topic-gmuwrapper-v3-5-5be55a336819@linaro.org>
 <CAA8EJpptwvxahDL34HCo59Lh9nNjFwiyhru-jYmVHJOLQ7yC7g@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpptwvxahDL34HCo59Lh9nNjFwiyhru-jYmVHJOLQ7yC7g@mail.gmail.com>
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



On 23.02.2023 15:43, Dmitry Baryshkov wrote:
> On Thu, 23 Feb 2023 at 14:06, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> Some (particularly SMD_RPM, a.k.a non-RPMh) SoCs implement A6XX GPUs
>> but don't implement the associated GMUs. This is due to the fact that
>> the GMU directly pokes at RPMh. Sadly, this means we have to take care
>> of enabling & scaling power rails, clocks and bandwidth ourselves.
>>
>> Reuse existing Adreno-common code and modify the deeply-GMU-infused
>> A6XX code to facilitate these GPUs. This involves if-ing out lots
>> of GMU callbacks and introducing a new type of GMU - GMU wrapper (it's
>> the actual name that Qualcomm uses in their downstream kernels).
>>
>> This is essentially a register region which is convenient to model
>> as a device. We'll use it for managing the GDSCs. The register
>> layout matches the actual GMU_CX/GX regions on the "real GMU" devices
>> and lets us reuse quite a bit of gmu_read/write/rmw calls.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c       |  53 +++++-
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c       | 244 +++++++++++++++++++++++++---
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h       |   1 +
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  14 +-
>>  drivers/gpu/drm/msm/adreno/adreno_gpu.h     |   6 +
>>  5 files changed, 282 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> index 90e636dcdd5b..b2c56561cde6 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> 
> [skipped]
> 
>>  struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>>  {
>>         struct msm_drm_private *priv = dev->dev_private;
>> @@ -2063,18 +2235,36 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>>
>>         adreno_gpu->registers = NULL;
>>
>> +       /* Check if there is a GMU phandle and set it up */
>> +       node = of_parse_phandle(pdev->dev.of_node, "qcom,gmu", 0);
>> +       /* FIXME: How do we gracefully handle this? */
>> +       BUG_ON(!node);
> 
> I thought that we should fix it, but then I noticed that this code was
> just moved from the part below.
I suppose we could return einval instead of calling BUG_ON,
but this would belong to a separate patch (possibly outside
this series).

> 
>> +
>> +       adreno_gpu->gmu_is_wrapper = of_device_is_compatible(node, "qcom,adreno-gmu-wrapper");
>> +
>>         /*
>>          * We need to know the platform type before calling into adreno_gpu_init
>>          * so that the hw_apriv flag can be correctly set. Snoop into the info
>>          * and grab the revision number
>>          */
>>         info = adreno_info(config->rev);
>> -
>> -       if (info && (info->revn == 650 || info->revn == 660 ||
>> -                       adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), info->rev)))
> 
> Are we losing A635 here? I don't see it in the condition below.
a660_family takes care of it

Konrad

> 
>> +       if (!info)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       /* Assign these early so that we can use the is_aXYZ helpers */
>> +       /* Numeric revision IDs (e.g. 630) */
>> +       adreno_gpu->revn = info->revn;
>> +       /* New-style ADRENO_REV()-only */
>> +       adreno_gpu->rev = info->rev;
>> +       /* Quirk data */
>> +       adreno_gpu->info = info;
>> +
>> +       if (adreno_is_a650(adreno_gpu) || adreno_is_a660_family(adreno_gpu))
>>                 adreno_gpu->base.hw_apriv = true;
>>
>> -       a6xx_llc_slices_init(pdev, a6xx_gpu);
>> +       /* No LLCC on non-RPMh (and by extension, non-GMU) SoCs */
>> +       if (!adreno_has_gmu_wrapper(adreno_gpu))
>> +               a6xx_llc_slices_init(pdev, a6xx_gpu);
>>
>>         ret = a6xx_set_supported_hw(&pdev->dev, config->rev);
>>         if (ret) {
>> @@ -2082,7 +2272,10 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>>                 return ERR_PTR(ret);
>>         }
>>
>> -       ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 1);
>> +       if (adreno_has_gmu_wrapper(adreno_gpu))
>> +               ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs_gmuwrapper, 1);
>> +       else
>> +               ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 1);
>>         if (ret) {
>>                 a6xx_destroy(&(a6xx_gpu->base.base));
>>                 return ERR_PTR(ret);
>> @@ -2095,13 +2288,10 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>>         if (adreno_is_a618(adreno_gpu) || adreno_is_7c3(adreno_gpu))
>>                 priv->gpu_clamp_to_idle = true;
>>
>> -       /* Check if there is a GMU phandle and set it up */
>> -       node = of_parse_phandle(pdev->dev.of_node, "qcom,gmu", 0);
>> -
>> -       /* FIXME: How do we gracefully handle this? */
>> -       BUG_ON(!node);
>> -
>> -       ret = a6xx_gmu_init(a6xx_gpu, node);
>> +       if (adreno_has_gmu_wrapper(adreno_gpu))
>> +               ret = a6xx_gmu_wrapper_init(a6xx_gpu, node);
>> +       else
>> +               ret = a6xx_gmu_init(a6xx_gpu, node);
>>         of_node_put(node);
>>         if (ret) {
>>                 a6xx_destroy(&(a6xx_gpu->base.base));
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> index eea2e60ce3b7..51a7656072fa 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>> @@ -76,6 +76,7 @@ int a6xx_gmu_set_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state);
>>  void a6xx_gmu_clear_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state);
>>
>>  int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
>> +int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
>>  void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu);
>>
>>  void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
>> index b7e217d00a22..e11e8a02ac22 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
>> @@ -1041,16 +1041,18 @@ struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
>>         /* Get the generic state from the adreno core */
>>         adreno_gpu_state_get(gpu, &a6xx_state->base);
>>
>> -       a6xx_get_gmu_registers(gpu, a6xx_state);
>> +       if (!adreno_has_gmu_wrapper(adreno_gpu)) {
>> +               a6xx_get_gmu_registers(gpu, a6xx_state);
>>
>> -       a6xx_state->gmu_log = a6xx_snapshot_gmu_bo(a6xx_state, &a6xx_gpu->gmu.log);
>> -       a6xx_state->gmu_hfi = a6xx_snapshot_gmu_bo(a6xx_state, &a6xx_gpu->gmu.hfi);
>> -       a6xx_state->gmu_debug = a6xx_snapshot_gmu_bo(a6xx_state, &a6xx_gpu->gmu.debug);
>> +               a6xx_state->gmu_log = a6xx_snapshot_gmu_bo(a6xx_state, &a6xx_gpu->gmu.log);
>> +               a6xx_state->gmu_hfi = a6xx_snapshot_gmu_bo(a6xx_state, &a6xx_gpu->gmu.hfi);
>> +               a6xx_state->gmu_debug = a6xx_snapshot_gmu_bo(a6xx_state, &a6xx_gpu->gmu.debug);
>>
>> -       a6xx_snapshot_gmu_hfi_history(gpu, a6xx_state);
>> +               a6xx_snapshot_gmu_hfi_history(gpu, a6xx_state);
>> +       }
>>
>>         /* If GX isn't on the rest of the data isn't going to be accessible */
>> -       if (!a6xx_gmu_gx_is_on(&a6xx_gpu->gmu))
>> +       if (!adreno_has_gmu_wrapper(adreno_gpu) && !a6xx_gmu_gx_is_on(&a6xx_gpu->gmu))
>>                 return &a6xx_state->base;
>>
>>         /* Get the banks of indexed registers */
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> index b4f9b1343d63..2c0f0ef094cb 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> @@ -115,6 +115,7 @@ struct adreno_gpu {
>>          * code (a3xx_gpu.c) and stored in this common location.
>>          */
>>         const unsigned int *reg_offsets;
>> +       bool gmu_is_wrapper;
>>  };
>>  #define to_adreno_gpu(x) container_of(x, struct adreno_gpu, base)
>>
>> @@ -145,6 +146,11 @@ struct adreno_platform_config {
>>
>>  bool adreno_cmp_rev(struct adreno_rev rev1, struct adreno_rev rev2);
>>
>> +static inline bool adreno_has_gmu_wrapper(struct adreno_gpu *gpu)
>> +{
>> +       return gpu->gmu_is_wrapper;
>> +}
>> +
>>  static inline bool adreno_is_a2xx(struct adreno_gpu *gpu)
>>  {
>>         return (gpu->revn < 300);
>>
>> --
>> 2.39.2
>>
> 
> 
