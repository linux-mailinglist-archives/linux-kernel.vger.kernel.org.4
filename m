Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8AD6F18C1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346108AbjD1NEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346098AbjD1ND7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:03:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E753FBA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:03:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f19b9d5358so76199615e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682687036; x=1685279036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4MbMbUlATowXc/GzzFK/6qJA+BvJceVnEgx9z4d/BqQ=;
        b=GQp4dAAxlfimW0+Et26rBMrNuOs8/Gx5NMF9vQB0oOIv9hb4B38fGYJwVPzfMeTOU2
         U1XfhZtkKfzCJqo7jx2/Rfq0AHkXS34VIESGwxSKxCMAsuYS5NQfg2l2uVIpYH6ShYxh
         u2DpVEXIvGQVATVj+SP849by97JEM4gYwbdY7rl3aOaWYULXfTNd18OYi6MFHyyLEf5r
         BQB86G9IFvFPIPFIGW2iu78MlbBunY/LZlnpnn21d77mqpl/XjUvhftynd1xTVewrCCB
         LszQ6dRzPi2SstoXczR97SZUJxkHtsChbF2XF+W+zo56VpJSqv0PA8hQmkCoF2JDbVuI
         Jmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682687036; x=1685279036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4MbMbUlATowXc/GzzFK/6qJA+BvJceVnEgx9z4d/BqQ=;
        b=lVQV4YyuoS1LA6zYygCnevva6g5qnRWzCp9CETR5T3R5OWn8bFxKYDON1rCVNtwfdP
         AOFJ5zebtdB1cbBVBM2zch3VWDeuHP/KznktYnmtaXyZSZ5pG/Ureur0WxiEa+pq1aO5
         RK5/bbslj2qmuZJxrMkL7reTkYBPAs8RmXlme9T12aarY1M8zCE7U145gBePLpdC0CFF
         VhaUeRBCjjAsUpWWVpaxu3jE+BkddKGiNwg5HLHCuLDTyv6QJcWlAK3hLttDrpxOUJ9U
         WUeoj6M/1zhw6mhO3up7XH6cm+E8DvK/8oLIstCxFyiAHzhzHk0UdJzwBij9QAtqXTkz
         p5jQ==
X-Gm-Message-State: AC+VfDxiPkG2Ka86p4lpo/pAwFBaVOr45v4IqLQrLjC247qIvzx1npXI
        jrRRKoJjjIKSd3INKSK91JSnag==
X-Google-Smtp-Source: ACHHUZ5endThDS00P6ln9T3nn6TybpccCQT4dI8fMsO8gyLFTiuj00nOgyEw/vNPvZ1PDE+TEK7inQ==
X-Received: by 2002:a05:600c:d7:b0:3f2:51e7:f110 with SMTP id u23-20020a05600c00d700b003f251e7f110mr3715783wmm.32.1682687036381;
        Fri, 28 Apr 2023 06:03:56 -0700 (PDT)
Received: from [172.23.2.5] ([31.221.30.162])
        by smtp.gmail.com with ESMTPSA id k25-20020a05600c081900b003f17122587bsm27702230wmp.36.2023.04.28.06.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 06:03:55 -0700 (PDT)
Message-ID: <bfed3b0a-9672-fa59-5591-27ad17f5e96c@linaro.org>
Date:   Fri, 28 Apr 2023 16:03:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 07/13] drm/msm/dpu: Add SM6350 support
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
 <20230411-topic-straitlagoon_mdss-v2-7-5def73f50980@linaro.org>
 <k25jg7cez2kimpxr4ztbdzjr2adq6a2vjknyvfe5frxujtogfg@vhfdyt45unv6>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <k25jg7cez2kimpxr4ztbdzjr2adq6a2vjknyvfe5frxujtogfg@vhfdyt45unv6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2023 18:37, Marijn Suijten wrote:
> On 2023-04-21 00:31:16, Konrad Dybcio wrote:
>> Add SM6350 support to the DPU1 driver to enable display output.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> After addressing the comments from Dmitry (CURSOR0->DMA1 and
> CURSOR1->DMA2), this is:
> 
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> 
> See below for some nits.
> 
>> ---
>>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h | 191 +++++++++++++++++++++
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   3 +
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>>   4 files changed, 196 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h
>> new file mode 100644
>> index 000000000000..687a508cbaa6
>> --- /dev/null
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h
>> @@ -0,0 +1,191 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022. Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2015-2018, 2020 The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023, Linaro Limited
>> + */
>> +
>> +#ifndef _DPU_6_4_SM6350_H
>> +#define _DPU_6_4_SM6350_H
>> +
>> +static const struct dpu_caps sm6350_dpu_caps = {
>> +	.max_mixer_width = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
>> +	.max_mixer_blendstages = 0x7,
>> +	.qseed_type = DPU_SSPP_SCALER_QSEED4,
> 
> I thought it was QSEED3LITE, but doesn't really matter as both are
> handled similarly.  It'll anyway change when I resubmit:

If I understood correctly, we mixed two things: hw stuff and the 
userspace library. QSEEDv2 was a hardware scaler. "qseedv3/v3lite/v4" 
are software library names that are used with the scalers newer than 
QSEED2. From the driver point we can ignore that and use scaler's hw 
version (which mostly but not always corresponds to the 3/3lite/4).

> 
> https://lore.kernel.org/linux-arm-msm/20230215-sspp-scaler-version-v1-0-416b1500b85b@somainline.org/T/#u
> 
> which should hardcode the register value directly, making this field
> superfluous.
> 
>> +	.has_src_split = true,
>> +	.has_dim_layer = true,
>> +	.has_idle_pc = true,
>> +	.max_linewidth = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
>> +	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
>> +};

-- 
With best wishes
Dmitry

