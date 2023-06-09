Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0144072A260
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjFISfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjFISfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:35:46 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D89A1FFE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:35:45 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f624daccd1so2610008e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 11:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686335744; x=1688927744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mzHdn1DaLzWURRN7ZYzg7ldO/12Vf7Ax/qC+Hs/RMDw=;
        b=IfM+S68ZeejULF2odiSYoidoZk7h1LBUvvkgGxfC2bGAqKqnCVVRt4v6li4ay+SSW1
         2Zs+NN9SzoX0viWeHrv3EizqXNW1cHwhvj7fVlUWXytkRh5vW8e/y+pI1MvSj0HdVBMa
         aU8RLu/rEExpLKJVsdj4OgAxJYE5fdDWywHheVOnNCFm/Syvzz21JoQdW7YQX8++gCGp
         J7tWp2eQ6F+vqU7kZTkIH4jcT0thLc+Gtvad6p6MDR1tbtww/tLqxlYymlbrkspki5eT
         amd+Bcbu5vyAv8z6H11bJzZiquCXsRhCQ1QqgeRt+meBW1EXwJuRbMT7M33ZRIGwqS+I
         7w6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335744; x=1688927744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzHdn1DaLzWURRN7ZYzg7ldO/12Vf7Ax/qC+Hs/RMDw=;
        b=P8ooFFO4/4EdQj4Ctdc50eq9883Zpwy3zRUHzYB0g2u17bZGd2p9Aogte/lBu/kDjF
         9r9Ja3o4X2GjQutcxw7Tx8rgOv53aURgZIwPulZB2yQkqUTRml+Vhobs4uSP0d0B5ysX
         Ore6HUQJJIzHd/8mSWAjabJ37b1TeS09kj9N0eYZmWZvlnsmMTpHTYMhYBvu9vt0NKV0
         lIbvGfHGljQVkSc+GgeqsXqc99Ek1E0VX08DmA/e/6h55CbPCbK6lHuo2oDUoWVMSGUR
         Z69UCNE8oJFExTJTbUceNe4KmL0GRuNZBKh2cP0QoLDXI4P8MIwvLnDB/Y4b+xmZYXLT
         wBVQ==
X-Gm-Message-State: AC+VfDyYPUNuh4z6nP4U7AGQ7fetAK+sCgK54suvcDqtdEUs3RcSJUOa
        CIIewyrdgbPp2b1s0zwnaufOuA==
X-Google-Smtp-Source: ACHHUZ66uv0L+a3FfUxOdzki0YRk+LVgedzWgi8j8TZxEFYFEkg+/7G9u8TzuQykdO23vnBMk3HWaA==
X-Received: by 2002:a19:5049:0:b0:4f4:4cd4:2586 with SMTP id z9-20020a195049000000b004f44cd42586mr1231188lfj.20.1686335743642;
        Fri, 09 Jun 2023 11:35:43 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id o1-20020a056512050100b004f38267a2f9sm622720lfb.161.2023.06.09.11.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 11:35:43 -0700 (PDT)
Message-ID: <0e3b5d21-24dc-6c44-0984-98d4a33fbe6e@linaro.org>
Date:   Fri, 9 Jun 2023 20:35:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v8 08/18] drm/msm/a6xx: Remove both GBIF and RBBM GBIF
 halt on hw init
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
 <20230223-topic-gmuwrapper-v8-8-69c68206609e@linaro.org>
 <eucocwnrumtpp5obno6dg3vl54wrrflge7cbt34ubfy32czl7d@b3kkk3l7ibfj>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <eucocwnrumtpp5obno6dg3vl54wrrflge7cbt34ubfy32czl7d@b3kkk3l7ibfj>
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



On 9.06.2023 20:25, Akhil P Oommen wrote:
> On Mon, May 29, 2023 at 03:52:27PM +0200, Konrad Dybcio wrote:
>>
>> Currently we're only deasserting REG_A6XX_RBBM_GBIF_HALT, but we also
>> need REG_A6XX_GBIF_HALT to be set to 0.
>>
>> This is typically done automatically on successful GX collapse, but in
>> case that fails, we should take care of it.
>>
>> Also, add a memory barrier to ensure it's gone through before jumping
>> to further initialization.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 083ccb5bcb4e..dfde5fb65eed 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -1003,8 +1003,12 @@ static int hw_init(struct msm_gpu *gpu)
>>  	a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
>>  
>>  	/* Clear GBIF halt in case GX domain was not collapsed */
>> -	if (a6xx_has_gbif(adreno_gpu))
>> +	if (a6xx_has_gbif(adreno_gpu)) {
>> +		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
>>  		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
>> +		/* Let's make extra sure that the GPU can access the memory.. */
>> +		mb();
> This barrier is unnecessary because writel transactions are ordered and
> we don't expect a traffic from GPU immediately after this.
> 
> -Akhil
Right, let's remove it!

Konrad
>> +	}
>>  
>>  	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
>>  
>>
>> -- 
>> 2.40.1
>>
