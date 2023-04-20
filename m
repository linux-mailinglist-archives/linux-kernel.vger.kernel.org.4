Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52716E8749
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 03:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjDTBOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 21:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjDTBOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 21:14:39 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5B42716
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:14:37 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a10so1034187ljr.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681953275; x=1684545275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bs3T4CoT9dcZGpM4NSaYLbZwM4ao6CkSlWOs854SEP0=;
        b=jvziNZEKWKFcemyK4qjPHfbBwlZp5vj2rQqNeL6rkXzcvr/wW3qsNVZ1+jrMtDGv6G
         TNmcpWu6v2MR4aHHiakWDo9fVyJSR5zKuaDOjmhhB6M9D8JklnYoO1MU1XazxKlA8Uz/
         cZi32nzJJX2EUMQu2gMjkYr0T2NVG2t7gsJbVUl9G6jnxpPPS6iMkewVcYjr5tlgdl7N
         9rorAKtaszGsOV4s0X7hvZI7sGkrGZGfQ1Sj+65gmY6stvxpuMaUxd2K8ZYxJv3KBFVU
         NCQDtX8tKtH3kUCwp5/b6o4LxcvigSyuDPLBtm4hszdEu/LXkivSs6Fj7kt5QdPNQoYK
         DnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681953275; x=1684545275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bs3T4CoT9dcZGpM4NSaYLbZwM4ao6CkSlWOs854SEP0=;
        b=asmLBqaYIagS3mMDJd4ANOD0T1eBxBhbQM7iBDi53J0YdhhbrpPcij7e0iCkGWTJFQ
         fJuMcPxjBtwUfWKHdOaiLdTx7V8SlK9hCNe9nOKPzVot/Uf4PaXWoJaEh0KpzTWCi/RH
         jCzU0N/ov1PbryFaUmSATiFEtTzNDVv13QLcrFtppx2be46yMhKX+ObikYlmg9Xmnc2w
         Yr6km8/gGHFmWeM77bGiMVcZzYm4Kna58HqzARZj2X0DoqtY3ULkHhN6Fdre84t5swjU
         b0I5l4OJBvjVOfrTGTUA6iV38klj51h6CtRM2sjq1dLXUDbanqPUyQMBJFsnBmGsrddF
         WxAw==
X-Gm-Message-State: AAQBX9cwbLAaelhxq2rQRKo+9UKXFKevSKtMbN5afleV5IkSMObhjeQR
        zFk09ZadTnN7x8iCo1Dx67ISGw==
X-Google-Smtp-Source: AKy350bBIAueDX7yZiBWXI0I+IiG4Q+5dFV0CHAv3I6r6BoS3JFZzMzJcF2idvVkrCZSsQdYBq6yWA==
X-Received: by 2002:a2e:9159:0:b0:2a8:d146:12cd with SMTP id q25-20020a2e9159000000b002a8d14612cdmr2726556ljg.17.1681953275668;
        Wed, 19 Apr 2023 18:14:35 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id g24-20020a2e9cd8000000b002a8bce7ce0dsm27182ljj.107.2023.04.19.18.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 18:14:35 -0700 (PDT)
Message-ID: <c31bc489-6f5d-d5c7-2b8d-328a20a17b81@linaro.org>
Date:   Thu, 20 Apr 2023 04:14:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 16/17] drm/msm/dpu: Implement tearcheck support on INTF
 block
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Adam Skladowski <a39.skl@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Archit Taneja <architt@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
References: <20230411-dpu-intf-te-v2-0-ef76c877eb97@somainline.org>
 <20230411-dpu-intf-te-v2-16-ef76c877eb97@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-dpu-intf-te-v2-16-ef76c877eb97@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 23:21, Marijn Suijten wrote:
> Since DPU 5.0.0 the TEARCHECK registers and interrupts moved out of the
> PINGPONG block and into the INTF.  Implement the necessary callbacks in
> the INTF block, and use these callbacks together with the INTF_TEAR
> interrupts.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  11 ++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h   |  10 +-
>   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   | 160 +++++++++------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        | 214 +++++++++++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |  25 +++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   2 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h          |  14 ++
>   7 files changed, 378 insertions(+), 58 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

