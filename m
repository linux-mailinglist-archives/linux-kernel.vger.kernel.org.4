Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634517314CE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245611AbjFOKFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245296AbjFOKE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:04:59 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D52D270E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:04:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so10261960e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686823495; x=1689415495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w71Feb6Cuie6QHDgJApc5h5mlpn+n4W2328NsDSJrHk=;
        b=w7TTtIbqEwS+lO03AQCyTZ5gF/Zk2bZU2d0IgH14c/dJh3aJhel2YjHeRnE99bfCc7
         gt8DDhA6rK7TfyPkezRHrTqEDfryeY/spojWe0gahCOlH4RZe2kGHZDVECu3UJGAMD6t
         g+iy2RVZIGYkV/ehonSR7qe/F2Gq+ySQ0R2eMK1MSSVKHB8gcqA2yKZjOS0KMIbYh2qk
         00HhN77UmJ4pa3JDmC9DN+fttYMKw7+l1kowRYJCoqpD/FheLebFnNMsdbicsjo3kZSK
         DyyqPs0UuBCMEUNghkg+P62eRLb0sQqIG7AtKIFiK3NMuRYHlRG4G+wJ5ikewXsxj/nf
         FGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686823495; x=1689415495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w71Feb6Cuie6QHDgJApc5h5mlpn+n4W2328NsDSJrHk=;
        b=EbsraozH5qafkcnb05eG8azAzrIuuLZvLbUuHVZ0JZFUbTD1eL1qVPzb8nIT06a+GG
         WGYMRr1R8z9cXoX5Abt9g/oYn2sFDx/IMaGVquGbTrXjVudVB78/mcl5mtSZJftX36OU
         E1o9tw06svUQPWgNL/rWEIXnZF1fSUNGsp8IfmoOxPkecHvvMRuPmGUNPxFdowjIsrJQ
         tewyV3X6cDMVdG6r6chUzwFxIhQB9k3RdNvTMXlEoAEHWYPgQCzbrEFJe4GohLdLJau3
         OISREHL2B/iDw5D5HDfVHs+ig3TRoRC302tslGKsk46YPVMx5LTYTePTnEAmz/1VgZlX
         fRhg==
X-Gm-Message-State: AC+VfDyhh6P6U+K8RUA6edkstec7w33AVn0fnvT4Iw2lRJWU+31RDsyF
        LBdhRRuuHVMFvy5LPVMHBGjiOA==
X-Google-Smtp-Source: ACHHUZ5UBxMW0AQyojgBT4IQQWC20Ws7BKhekIK2zj1FC1TIWAJeA5VveEU90Ngd+06SYgJerxRUHg==
X-Received: by 2002:a19:3819:0:b0:4f7:457e:a457 with SMTP id f25-20020a193819000000b004f7457ea457mr6316363lfa.53.1686823495457;
        Thu, 15 Jun 2023 03:04:55 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id x27-20020ac259db000000b004f612780b75sm2520269lfn.49.2023.06.15.03.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 03:04:55 -0700 (PDT)
Message-ID: <f0261f2a-76d9-fcbf-2a3e-edae14f77604@linaro.org>
Date:   Thu, 15 Jun 2023 12:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v8 18/18] drm/msm/a6xx: Add A610 speedbin support
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
 <20230223-topic-gmuwrapper-v8-18-69c68206609e@linaro.org>
 <ab2yzsjp65t53wp5nytjuc7eb74zklkb6i342bc5edhm45j3qm@kpyq52is7tde>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ab2yzsjp65t53wp5nytjuc7eb74zklkb6i342bc5edhm45j3qm@kpyq52is7tde>
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

On 14.06.2023 22:18, Akhil P Oommen wrote:
> On Mon, May 29, 2023 at 03:52:37PM +0200, Konrad Dybcio wrote:
>>
>> A610 is implemented on at least three SoCs: SM6115 (bengal), SM6125
>> (trinket) and SM6225 (khaje). Trinket does not support speed binning
>> (only a single SKU exists) and we don't yet support khaje upstream.
>> Hence, add a fuse mapping table for bengal to allow for per-chip
>> frequency limiting.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index d046af5f6de2..c304fa118cff 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -2098,6 +2098,30 @@ static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
>>  	return progress;
>>  }
>>  
>> +static u32 a610_get_speed_bin(u32 fuse)
>> +{
>> +	/*
>> +	 * There are (at least) three SoCs implementing A610: SM6125 (trinket),
>> +	 * SM6115 (bengal) and SM6225 (khaje). Trinket does not have speedbinning,
>> +	 * as only a single SKU exists and we don't support khaje upstream yet.
>> +	 * Hence, this matching table is only valid for bengal and can be easily
>> +	 * expanded if need be.
>> +	 */
>> +
>> +	if (fuse == 0)
>> +		return 0;
>> +	else if (fuse == 206)
>> +		return 1;
>> +	else if (fuse == 200)
>> +		return 2;
>> +	else if (fuse == 157)
>> +		return 3;
>> +	else if (fuse == 127)
>> +		return 4;
>> +
>> +	return UINT_MAX;
>> +}
>> +
>>  static u32 a618_get_speed_bin(u32 fuse)
>>  {
>>  	if (fuse == 0)
>> @@ -2195,6 +2219,9 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_gpu *adreno_gpu, u3
>>  {
>>  	u32 val = UINT_MAX;
>>  
>> +	if (adreno_is_a610(adreno_gpu))
>> +		val = a610_get_speed_bin(fuse);
>> +
> 
> Didn't you update here to convert to 'else if' in one of the earlier
> patches??
Right, missed this one!

Konrad
> 
> Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> 
> -Akhil.
>>  	if (adreno_is_a618(adreno_gpu))
>>  		val = a618_get_speed_bin(fuse);
>>  
>>
>> -- 
>> 2.40.1
>>
