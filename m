Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49B37314C4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbjFOKCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbjFOKCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:02:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5BE270F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:02:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so10250490e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686823333; x=1689415333;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=241/LCI0tJnJrhN7t+2MKXz8CDBrwuKWaGtpTG19kxQ=;
        b=XLGeS1zDWw09I5qUtyPSdRR9UuGGJRM17OsL2QA00oqMmvfUSsqQhbR7WXT1+ZQuRs
         0j3Y8pBtMVt50+q6owajUGE1ozWu1oWeFY1ltdfFoRcky9BA9cAjMdre6JqOadvp1w3I
         2nIARVUHEeYv7PdtslSOLpgEuIAiBGCtH9lIeLmkPGLwMVkumWvLJ0Et7DOsrE+zrHnv
         vm5Yq5BmjngYssHK/CZk9a/zKmGrCnOOFHHtjxBt0Lh/YpB4tIxYstOeYDkrL8pkxE0A
         6UR+wujYTV5JO4VSHaCrcJ+Lr1gE/Oyp2I21z1luFPsbT3WkB/tO7eLo+GQI912McAKe
         3n2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686823333; x=1689415333;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=241/LCI0tJnJrhN7t+2MKXz8CDBrwuKWaGtpTG19kxQ=;
        b=Cde2WTucOIu3d9xCp9tTQQ2OhyTMIsUEObFEZRKMONyUxWafES/pF3e4jOwGfk0dcb
         +GlhkJsh6Pib4Q0VN6CKI3LVzpdD3n0RIrrpZlJ0VdtFC/1mN6vicVkH/r2F2hx3dBo+
         oYIyR+R+90h4QBt6CBjr5NK56F+9Yr6gZrmb+ETHssHZOTjmkAxXG2bif9GVSmVzWVYI
         dn7WA1wUcFF8uZpS4ZK9TyrAi8sr3RGBdBLs67Ae63zue9UD1La4xSCXyLN/HzR2pA25
         ps1vjlRacqzEsRV+ZeVt6YFl+oHfx6+RJxXVKm11+8bdvXdtZIdJBXQsJDm+VS7Jpz/g
         8tDg==
X-Gm-Message-State: AC+VfDxz6+Stpp40WBP+XkE6rYH6xkNjcuqdytNiGrfPuvTRJ1UtR4r4
        drcrIKttfLqKhG/OKf827KlB4w==
X-Google-Smtp-Source: ACHHUZ53Inb1s5Pri+XMSWq3WfKiizBfV2gWuzOuf2FxAeLvuBJX5PVbpvqFNEGHwD2nF3yQKRsZMQ==
X-Received: by 2002:ac2:4d96:0:b0:4ec:7b87:931a with SMTP id g22-20020ac24d96000000b004ec7b87931amr9712886lfe.13.1686823332999;
        Thu, 15 Jun 2023 03:02:12 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id y13-20020ac255ad000000b004f842478f9asm230834lfg.88.2023.06.15.03.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 03:02:12 -0700 (PDT)
Message-ID: <5139ceac-085e-1e41-d709-210942ddede6@linaro.org>
Date:   Thu, 15 Jun 2023 12:02:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230223-topic-gmuwrapper-v8-0-69c68206609e@linaro.org>
 <20230223-topic-gmuwrapper-v8-13-69c68206609e@linaro.org>
 <c23tj7vsumzpggo3qbzbf4oiwpx3v2sfdu64znqzifod5q4ngh@o7g75qt4tjm5>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v8 13/18] drm/msm/a6xx: Add A610 support
In-Reply-To: <c23tj7vsumzpggo3qbzbf4oiwpx3v2sfdu64znqzifod5q4ngh@o7g75qt4tjm5>
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

On 14.06.2023 21:41, Akhil P Oommen wrote:
> On Mon, May 29, 2023 at 03:52:32PM +0200, Konrad Dybcio wrote:
>>
>> A610 is one of (if not the) lowest-tier SKUs in the A6XX family. It
>> features no GMU, as it's implemented solely on SoCs with SMD_RPM.
>> What's more interesting is that it does not feature a VDDGX line
>> either, being powered solely by VDDCX and has an unfortunate hardware
>> quirk that makes its reset line broken - after a couple of assert/
>> deassert cycles, it will hang for good and will not wake up again.
>>
>> This GPU requires mesa changes for proper rendering, and lots of them
>> at that. The command streams are quite far away from any other A6XX
>> GPU and hence it needs special care. This patch was validated both
>> by running an (incomplete) downstream mesa with some hacks (frames
>> rendered correctly, though some instructions made the GPU hangcheck
>> which is expected - garbage in, garbage out) and by replaying RD
>> traces captured with the downstream KGSL driver - no crashes there,
>> ever.
>>
>> Add support for this GPU on the kernel side, which comes down to
>> pretty simply adding A612 HWCG tables, altering a few values and
>> adding a special case for handling the reset line.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 101 +++++++++++++++++++++++++----
>>  drivers/gpu/drm/msm/adreno/adreno_device.c |  12 ++++
>>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |   8 ++-
>>  3 files changed, 108 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index bb04f65e6f68..c0d5973320d9 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -252,6 +252,56 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>>  	a6xx_flush(gpu, ring);
>>  }
>>  
>> +const struct adreno_reglist a612_hwcg[] = {
>> +	{REG_A6XX_RBBM_CLOCK_CNTL_SP0, 0x22222222},
>> +	{REG_A6XX_RBBM_CLOCK_CNTL2_SP0, 0x02222220},
>> +	{REG_A6XX_RBBM_CLOCK_DELAY_SP0, 0x00000081},
>> +	{REG_A6XX_RBBM_CLOCK_HYST_SP0, 0x0000f3cf},
>> +	{REG_A6XX_RBBM_CLOCK_CNTL_TP0, 0x22222222},
>> +	{REG_A6XX_RBBM_CLOCK_CNTL2_TP0, 0x22222222},
>> +	{REG_A6XX_RBBM_CLOCK_CNTL3_TP0, 0x22222222},
>> +	{REG_A6XX_RBBM_CLOCK_CNTL4_TP0, 0x00022222},
>> +	{REG_A6XX_RBBM_CLOCK_DELAY_TP0, 0x11111111},
>> +	{REG_A6XX_RBBM_CLOCK_DELAY2_TP0, 0x11111111},
>> +	{REG_A6XX_RBBM_CLOCK_DELAY3_TP0, 0x11111111},
>> +	{REG_A6XX_RBBM_CLOCK_DELAY4_TP0, 0x00011111},
>> +	{REG_A6XX_RBBM_CLOCK_HYST_TP0, 0x77777777},
>> +	{REG_A6XX_RBBM_CLOCK_HYST2_TP0, 0x77777777},
>> +	{REG_A6XX_RBBM_CLOCK_HYST3_TP0, 0x77777777},
>> +	{REG_A6XX_RBBM_CLOCK_HYST4_TP0, 0x00077777},
>> +	{REG_A6XX_RBBM_CLOCK_CNTL_RB0, 0x22222222},
>> +	{REG_A6XX_RBBM_CLOCK_CNTL2_RB0, 0x01202222},
>> +	{REG_A6XX_RBBM_CLOCK_CNTL_CCU0, 0x00002220},
>> +	{REG_A6XX_RBBM_CLOCK_HYST_RB_CCU0, 0x00040f00},
>> +	{REG_A6XX_RBBM_CLOCK_CNTL_RAC, 0x05522022},
>> +	{REG_A6XX_RBBM_CLOCK_CNTL2_RAC, 0x00005555},
>> +	{REG_A6XX_RBBM_CLOCK_DELAY_RAC, 0x00000011},
>> +	{REG_A6XX_RBBM_CLOCK_HYST_RAC, 0x00445044},
>> +	{REG_A6XX_RBBM_CLOCK_CNTL_TSE_RAS_RBBM, 0x04222222},
>> +	{REG_A6XX_RBBM_CLOCK_MODE_VFD, 0x00002222},
>> +	{REG_A6XX_RBBM_CLOCK_MODE_GPC, 0x02222222},
>> +	{REG_A6XX_RBBM_CLOCK_DELAY_HLSQ_2, 0x00000002},
>> +	{REG_A6XX_RBBM_CLOCK_MODE_HLSQ, 0x00002222},
>> +	{REG_A6XX_RBBM_CLOCK_DELAY_TSE_RAS_RBBM, 0x00004000},
>> +	{REG_A6XX_RBBM_CLOCK_DELAY_VFD, 0x00002222},
>> +	{REG_A6XX_RBBM_CLOCK_DELAY_GPC, 0x00000200},
>> +	{REG_A6XX_RBBM_CLOCK_DELAY_HLSQ, 0x00000000},
>> +	{REG_A6XX_RBBM_CLOCK_HYST_TSE_RAS_RBBM, 0x00000000},
>> +	{REG_A6XX_RBBM_CLOCK_HYST_VFD, 0x00000000},
>> +	{REG_A6XX_RBBM_CLOCK_HYST_GPC, 0x04104004},
>> +	{REG_A6XX_RBBM_CLOCK_HYST_HLSQ, 0x00000000},
>> +	{REG_A6XX_RBBM_CLOCK_CNTL_UCHE, 0x22222222},
>> +	{REG_A6XX_RBBM_CLOCK_HYST_UCHE, 0x00000004},
>> +	{REG_A6XX_RBBM_CLOCK_DELAY_UCHE, 0x00000002},
>> +	{REG_A6XX_RBBM_ISDB_CNT, 0x00000182},
>> +	{REG_A6XX_RBBM_RAC_THRESHOLD_CNT, 0x00000000},
>> +	{REG_A6XX_RBBM_SP_HYST_CNT, 0x00000000},
>> +	{REG_A6XX_RBBM_CLOCK_CNTL_GMU_GX, 0x00000222},
>> +	{REG_A6XX_RBBM_CLOCK_DELAY_GMU_GX, 0x00000111},
>> +	{REG_A6XX_RBBM_CLOCK_HYST_GMU_GX, 0x00000555},
>> +	{},
>> +};
>> +
>>  /* For a615 family (a615, a616, a618 and a619) */
>>  const struct adreno_reglist a615_hwcg[] = {
>>  	{REG_A6XX_RBBM_CLOCK_CNTL_SP0,  0x02222222},
>> @@ -602,6 +652,8 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
>>  
>>  	if (adreno_is_a630(adreno_gpu))
>>  		clock_cntl_on = 0x8aa8aa02;
>> +	else if (adreno_is_a610(adreno_gpu))
>> +		clock_cntl_on = 0xaaa8aa82;
>>  	else
>>  		clock_cntl_on = 0x8aa8aa82;
>>  
>> @@ -612,13 +664,15 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
>>  		return;
>>  
>>  	/* Disable SP clock before programming HWCG registers */
>> -	gmu_rmw(gmu, REG_A6XX_GPU_GMU_GX_SPTPRAC_CLOCK_CONTROL, 1, 0);
>> +	if (!adreno_is_a610(adreno_gpu))
>> +		gmu_rmw(gmu, REG_A6XX_GPU_GMU_GX_SPTPRAC_CLOCK_CONTROL, 1, 0);
>>  
>>  	for (i = 0; (reg = &adreno_gpu->info->hwcg[i], reg->offset); i++)
>>  		gpu_write(gpu, reg->offset, state ? reg->value : 0);
>>  
>>  	/* Enable SP clock */
>> -	gmu_rmw(gmu, REG_A6XX_GPU_GMU_GX_SPTPRAC_CLOCK_CONTROL, 0, 1);
>> +	if (!adreno_is_a610(adreno_gpu))
>> +		gmu_rmw(gmu, REG_A6XX_GPU_GMU_GX_SPTPRAC_CLOCK_CONTROL, 0, 1);
>>  
>>  	gpu_write(gpu, REG_A6XX_RBBM_CLOCK_CNTL, state ? clock_cntl_on : 0);
>>  }
>> @@ -806,6 +860,13 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>>  	/* Unknown, introduced with A640/680 */
>>  	u32 amsbc = 0;
>>  
>> +	if (adreno_is_a610(adreno_gpu)) {
>> +		/* HBB = 14 */
>> +		hbb_lo = 1;
>> +		min_acc_len = 1;
>> +		ubwc_mode = 1;
>> +	}
>> +
>>  	/* a618 is using the hw default values */
>>  	if (adreno_is_a618(adreno_gpu))
>>  		return;
>> @@ -1073,13 +1134,13 @@ static int hw_init(struct msm_gpu *gpu)
>>  	a6xx_set_hwcg(gpu, true);
>>  
>>  	/* VBIF/GBIF start*/
>> -	if (adreno_is_a640_family(adreno_gpu) ||
>> +	if (adreno_is_a610(adreno_gpu) ||
>> +	    adreno_is_a640_family(adreno_gpu) ||
>>  	    adreno_is_a650_family(adreno_gpu)) {
>>  		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE0, 0x00071620);
>>  		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE1, 0x00071620);
>>  		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE2, 0x00071620);
>>  		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE3, 0x00071620);
>> -		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE3, 0x00071620);
>>  		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x3);
>>  	} else {
>>  		gpu_write(gpu, REG_A6XX_RBBM_VBIF_CLIENT_QOS_CNTL, 0x3);
>> @@ -1107,18 +1168,26 @@ static int hw_init(struct msm_gpu *gpu)
>>  	gpu_write(gpu, REG_A6XX_UCHE_FILTER_CNTL, 0x804);
>>  	gpu_write(gpu, REG_A6XX_UCHE_CACHE_WAYS, 0x4);
>>  
>> -	if (adreno_is_a640_family(adreno_gpu) ||
>> -	    adreno_is_a650_family(adreno_gpu))
>> +	if (adreno_is_a640_family(adreno_gpu) || adreno_is_a650_family(adreno_gpu)) {
>>  		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x02000140);
>> -	else
>> +		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_1, 0x8040362c);
>> +	} else if (adreno_is_a610(adreno_gpu)) {
>> +		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x00800060);
>> +		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_1, 0x40201b16);
>> +	} else {
>>  		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x010000c0);
>> -	gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_1, 0x8040362c);
>> +		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_1, 0x8040362c);
>> +	}
>>  
>>  	if (adreno_is_a660_family(adreno_gpu))
>>  		gpu_write(gpu, REG_A6XX_CP_LPAC_PROG_FIFO_SIZE, 0x00000020);
>>  
>>  	/* Setting the mem pool size */
>> -	gpu_write(gpu, REG_A6XX_CP_MEM_POOL_SIZE, 128);
>> +	if (adreno_is_a610(adreno_gpu)) {
>> +		gpu_write(gpu, REG_A6XX_CP_MEM_POOL_SIZE, 48);
>> +		gpu_write(gpu, REG_A6XX_CP_MEM_POOL_DBG_ADDR, 47);
>> +	} else
>> +		gpu_write(gpu, REG_A6XX_CP_MEM_POOL_SIZE, 128);
>>  
>>  	/* Setting the primFifo thresholds default values,
>>  	 * and vccCacheSkipDis=1 bit (0x200) for A640 and newer
>> @@ -1129,6 +1198,8 @@ static int hw_init(struct msm_gpu *gpu)
>>  		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00200200);
>>  	else if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
>>  		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300200);
>> +	else if (adreno_is_a610(adreno_gpu))
>> +		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00080000);
>>  	else
>>  		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00180000);
>>  
>> @@ -1144,8 +1215,10 @@ static int hw_init(struct msm_gpu *gpu)
>>  	a6xx_set_ubwc_config(gpu);
>>  
>>  	/* Enable fault detection */
>> -	gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL,
>> -		(1 << 30) | 0x1fffff);
>> +	if (adreno_is_a610(adreno_gpu))
>> +		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x3ffff);
>> +	else
>> +		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x1fffff);
>>  
>>  	gpu_write(gpu, REG_A6XX_UCHE_CLIENT_PF, 1);
>>  
>> @@ -1675,7 +1748,7 @@ void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_
>>  	struct msm_gpu *gpu = &adreno_gpu->base;
>>  
>>  	if (adreno_is_a619_holi(adreno_gpu)) {
>> -		gpu_write(gpu, 0x18, GPR0_GBIF_HALT_REQUEST);
>> +		gpu_write(gpu, REG_A6XX_RBBM_GPR0_CNTL, GPR0_GBIF_HALT_REQUEST);
> 
> This looks like an unrelated change.
Right, wrong commit.

> 
>>  		spin_until((gpu_read(gpu, REG_A6XX_RBBM_VBIF_GX_RESET_STATUS) &
>>  				(VBIF_RESET_ACK_MASK)) == VBIF_RESET_ACK_MASK);
>>  	} else if (!a6xx_has_gbif(adreno_gpu)) {
>> @@ -1709,6 +1782,10 @@ void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_
>>  
>>  void a6xx_gpu_sw_reset(struct msm_gpu *gpu, bool assert)
>>  {
>> +	/* 11nm chips (e.g. ones with A610) have hw issues with the reset line! */
>> +	if (adreno_is_a610(to_adreno_gpu(gpu)))
>> +		return;
>> +
>>  	gpu_write(gpu, REG_A6XX_RBBM_SW_RESET_CMD, assert);
>>  	/* Add a barrier to avoid bad surprises */
>>  	mb();
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> index b133755a56c4..2c2cdbdada4d 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> @@ -253,6 +253,18 @@ static const struct adreno_info gpulist[] = {
>>  		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
>>  		.init = a5xx_gpu_init,
>>  		.zapfw = "a540_zap.mdt",
>> +	}, {
>> +		.rev = ADRENO_REV(6, 1, 0, ANY_ID),
>> +		.revn = 610,
>> +		.name = "A610",
>> +		.fw = {
>> +			[ADRENO_FW_SQE] = "a630_sqe.fw",
>> +		},
>> +		.gmem = (SZ_128K + SZ_4K),
>> +		.inactive_period = 500,
> 
> You really want such a long inactive period?
Whoooooops! I confused this with gdsc timeout.. Thanks for spotting
this!

Konrad

> 
>> +		.init = a6xx_gpu_init,
>> +		.zapfw = "a610_zap.mdt",
>> +		.hwcg = a612_hwcg,
>>  	}, {
>>  		.rev = ADRENO_REV(6, 1, 8, ANY_ID),
>>  		.revn = 618,
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> index 432fee5c1516..7a5d595d4b99 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
>> @@ -55,7 +55,8 @@ struct adreno_reglist {
>>  	u32 value;
>>  };
>>  
>> -extern const struct adreno_reglist a615_hwcg[], a630_hwcg[], a640_hwcg[], a650_hwcg[], a660_hwcg[];
>> +extern const struct adreno_reglist a612_hwcg[], a615_hwcg[], a630_hwcg[], a640_hwcg[], a650_hwcg[];
>> +extern const struct adreno_reglist a660_hwcg[];
>>  
>>  struct adreno_info {
>>  	struct adreno_rev rev;
>> @@ -242,6 +243,11 @@ static inline int adreno_is_a540(struct adreno_gpu *gpu)
>>  	return gpu->revn == 540;
>>  }
>>  
>> +static inline int adreno_is_a610(struct adreno_gpu *gpu)
>> +{
>> +	return gpu->revn == 610;
>> +}
>> +
>>  static inline int adreno_is_a618(struct adreno_gpu *gpu)
>>  {
>>  	return gpu->revn == 618;
>>
>> -- 
>> 2.40.1
>>
> 
> Minor nits, but looks good to me.
> 
> -Akhil.
