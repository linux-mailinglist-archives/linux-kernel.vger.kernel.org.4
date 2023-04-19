Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A57A6E821D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjDSTtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDSTs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:48:59 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354B830EA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:48:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2a8ad872ea5so409001fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681933735; x=1684525735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZTyNKupNsXf2g+91PrPeU2a11PGoDFN20zA7SNUiqa0=;
        b=MMVV0oI5iZoLMSWrFHuxhrPHwJWEwWo9NDFSTsUMvnDuxZ+ftMo4+2t6pSqxU/9zmJ
         mJUFGHmFF2pV4n4Id8zA4IIb3ilQOlhiHMhX4mMxPIQyKQaeGNNvWKtP4PurPzpIhTkn
         oGTsuccZQM1EF0j7uvUbWVrUbGLhXq+13He/orOkcSzXMNoCNX4xK1SIjK2NMhusK+Na
         JuMFlyaJAEtG1hhtBW4em31/vbbQoD8sJTaRcZd9vMMXPU90sQBJ0HmV2B5gsod0c75t
         O9WgpZXhUexEQm42tyn8FN+8KiCi6gKXsDTSA+f7JNwh6Cks81lze41j4B8dxyWx5E1/
         J5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681933735; x=1684525735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTyNKupNsXf2g+91PrPeU2a11PGoDFN20zA7SNUiqa0=;
        b=HMin9i60TEWfivZ610jAJkSODqJ1yuc0SgggbGHi1Bi35sd3xP+QG9oDRJbqxp8Q+d
         knFadf7B4M1keEQ2NW0cxzajNv6BpIa1tJsSppiMvWMRlRW8pdW2N9z0GQdoQyWExAB1
         1Uw+gMhH2eIsE2Tbq/js45LQGV3mw/r7ZcIlnDIBJsU6WOlmg2hejVazZ59QnVeBVens
         WeffRb+Rx0871KyyyozQPT8cV1VqNYwcKsiGPpGr3bFngbDYEUxQvVF6i/rt50aVa7t5
         ZmZWWoeTFUm2XisFGzeaaCaQ5uClfu8fxXP4MlVhlSFAE17Z1V1xQyu2xQZLKuzMpDnf
         9wJw==
X-Gm-Message-State: AAQBX9cBm/aMJ5aJmuzO/UzuNokrmRVy6k3lZxCugddRFB4zuS8UoyJX
        nuwWSf8VLxt8EWidvmQcFcEatw==
X-Google-Smtp-Source: AKy350YKG23tnDYXxO75yYLkS8XJe3vIMC1X4eB1eASmgz1L1is/D1f87aLJjfvgYP27+NZxb0G9wg==
X-Received: by 2002:a19:740a:0:b0:4ec:92e4:e0c3 with SMTP id v10-20020a19740a000000b004ec92e4e0c3mr4073568lfe.62.1681933735325;
        Wed, 19 Apr 2023 12:48:55 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id 7-20020ac25687000000b004edc2a023ffsm1351395lfr.36.2023.04.19.12.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 12:48:54 -0700 (PDT)
Message-ID: <e15ec005-ef52-c14c-bdeb-faaca207d39b@linaro.org>
Date:   Wed, 19 Apr 2023 21:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [Freedreno] [PATCH 5/5] drm/msm/dpu1: Handle the reg bus ICC path
Content-Language: en-US
To:     Jeykumar Sankaran <quic_jeykumar@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        freedreno@lists.freedesktop.org
References: <20230417-topic-dpu_regbus-v1-0-06fbdc1643c0@linaro.org>
 <20230417-topic-dpu_regbus-v1-5-06fbdc1643c0@linaro.org>
 <11c72462-b256-d0db-a666-9615da4420f6@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <11c72462-b256-d0db-a666-9615da4420f6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.04.2023 21:06, Jeykumar Sankaran wrote:
> 
> 
> On 4/17/2023 8:30 AM, Konrad Dybcio wrote:
>> Apart from the already handled data bus (MAS_MDP_Pn<->DDR), there's
>> another path that needs to be handled to ensure MDSS functions properly,
>> namely the "reg bus", a.k.a the CPU-MDSS interconnect.
>>
>> Gating that path may have a variety of effects.. from none to otherwise
>> inexplicable DSI timeouts..
>>
>> On the DPU side, we need to keep the bus alive. The vendor driver
>> kickstarts it to max (300Mbps) throughput on first commit, but in
>> exchange for some battery life in rare DPU-enabled-panel-disabled
>> usecases, we can request it at DPU init and gate it at suspend.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 22 ++++++++++++++++++++--
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h |  1 +
>>   2 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> index dd6c1c40ab9e..d1f77faebbc0 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> @@ -384,15 +384,17 @@ static int dpu_kms_global_obj_init(struct dpu_kms *dpu_kms)
>>       return 0;
>>   }
>>   -static int dpu_kms_parse_data_bus_icc_path(struct dpu_kms *dpu_kms)
>> +static int dpu_kms_parse_icc_paths(struct dpu_kms *dpu_kms)
>>   {
>>       struct icc_path *path0;
>>       struct icc_path *path1;
>> +    struct icc_path *reg_bus_path;
>>       struct drm_device *dev = dpu_kms->dev;
>>       struct device *dpu_dev = dev->dev;
>>         path0 = msm_icc_get(dpu_dev, "mdp0-mem");
>>       path1 = msm_icc_get(dpu_dev, "mdp1-mem");
>> +    reg_bus_path = msm_icc_get(dpu_dev, "cpu-cfg");
>>         if (IS_ERR_OR_NULL(path0))
>>           return PTR_ERR_OR_ZERO(path0);
>> @@ -404,6 +406,10 @@ static int dpu_kms_parse_data_bus_icc_path(struct dpu_kms *dpu_kms)
>>           dpu_kms->mdp_path[1] = path1;
>>           dpu_kms->num_mdp_paths++;
>>       }
>> +
>> +    if (!IS_ERR_OR_NULL(reg_bus_path))
>> +        dpu_kms->reg_bus_path = reg_bus_path;
>> +
>>       return 0;
>>   }
>>   @@ -1039,7 +1045,7 @@ static int dpu_kms_hw_init(struct msm_kms *kms)
>>           DPU_DEBUG("REG_DMA is not defined");
>>       }
>>   -    dpu_kms_parse_data_bus_icc_path(dpu_kms);
>> +    dpu_kms_parse_icc_paths(dpu_kms);
>>         rc = pm_runtime_resume_and_get(&dpu_kms->pdev->dev);
>>       if (rc < 0)
>> @@ -1241,6 +1247,9 @@ static int __maybe_unused dpu_runtime_suspend(struct device *dev)
>>       for (i = 0; i < dpu_kms->num_mdp_paths; i++)
>>           icc_set_bw(dpu_kms->mdp_path[i], 0, 0);
>>   +    if (dpu_kms->reg_bus_path)
>> +        icc_set_bw(dpu_kms->reg_bus_path, 0, 0);
>> +
>>       return 0;
>>   }
>>   @@ -1261,6 +1270,15 @@ static int __maybe_unused dpu_runtime_resume(struct device *dev)
>>           return rc;
>>       }
>>   +    /*
>> +     * The vendor driver supports setting 76.8 / 150 / 300 Mbps on this
> How do you arrive at these distint BW values? Are they provided by the ICC fwk for the given path?
They're hardcoded in the SDE driver.

Konrad
>> +     * path, but it seems to go for the highest level when display output
>> +     * is enabled and zero otherwise. For simplicity, we can assume that
>> +     * DPU being enabled and running implies that.
>> +     */
>> +    if (dpu_kms->reg_bus_path)
>> +        icc_set_bw(dpu_kms->reg_bus_path, 0, MBps_to_icc(300));
>> +
>>       dpu_vbif_init_memtypes(dpu_kms);
>>         drm_for_each_encoder(encoder, ddev)
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
>> index d5d9bec90705..c332381d58c4 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
>> @@ -111,6 +111,7 @@ struct dpu_kms {
>>       atomic_t bandwidth_ref;
>>       struct icc_path *mdp_path[2];
>>       u32 num_mdp_paths;
>> +    struct icc_path *reg_bus_path;
>>   };
>>     struct vsync_info {
>>
