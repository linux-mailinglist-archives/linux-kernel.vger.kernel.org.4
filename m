Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5829A6E60F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjDRMRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjDRMRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:17:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6370E1FFE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:16:55 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso2171434e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681820213; x=1684412213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cSPjkwXrQ/5Q2DOZIZBvyFYJuatqkXIjg6jGdvedRys=;
        b=LUCVOcv6DmUDBjQ4R+22BPhUOHNtFxSlaq/NsdorfkSxJVX8jkPYEjVzroC6ZG6Z6R
         Qrrd3ef/WSCCYaWwayqF8N7yWYiieAlQTpnB4JOkdUebbvDvTIFHuRT6hWie9eQ6ru5i
         wRhwvXIX3mXm8v57oGoY2VP7+Q1FnlDP9oY1QkE4e+VqSLKyLPomfA0nWPPAQUM/KDG0
         cmQ1Ab77/W0AcszA0V3L6EXPFp/5BkCG4kmzB9aGKxb4oaATbImSsUn0vaDre2u13KYZ
         dGqo0Wzzif+aGaKm/kCS3wGM/4tjmPjqRzLGmiW565Dh4ZDEevNHLT2jLa2i30GsjHsQ
         DBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681820213; x=1684412213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cSPjkwXrQ/5Q2DOZIZBvyFYJuatqkXIjg6jGdvedRys=;
        b=MLJi8G/wiONv1dKtd+uLrB/6lDQA9Hv5U2QQS7xA/f3S7wtlYX4ncGwJFyzdAxJffC
         8qbHsbaWHRGp67Yk//U9FJ85dRK8pzB2rg2mrHIN2AlyYFdm3jb8GUCxiNBhCQ7OU/in
         lhgVH9b103DQPnC8QTnmHt8Jyr6TF3/Y8toJbfbIAuQy7VAEXRCoOKt+z9CA5d9ExRMX
         bXTk/vuTtKqSCl5KitQpACOtdQ/Xly8Iv8vs7DqUm2DGAulppGYmHw8QxMOVIcrYih+B
         jQvF/EG78sE/B6zNy3dqXBVHRC94OwCNkdToeuLVbhG2HGIZxUMTXjbqIrF0fZDChoVZ
         D8Vg==
X-Gm-Message-State: AAQBX9fWww5aEVs28wodR9RaS+LPGR+6PDK2ijlTweCx6raO7/wxwVBl
        519YJpSskaFvXWLX2ualyoxP7w==
X-Google-Smtp-Source: AKy350a4RukmMdttuvhLrku73yObrOs3Usaj340YEO08FQAohtiLVmAMrXDJpWdpc1sd1o8FMewzJA==
X-Received: by 2002:a19:ac48:0:b0:4dd:cb1d:b3cc with SMTP id r8-20020a19ac48000000b004ddcb1db3ccmr2789051lfc.11.1681820213659;
        Tue, 18 Apr 2023 05:16:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id a13-20020ac2520d000000b004edc72be17csm522583lfl.2.2023.04.18.05.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 05:16:53 -0700 (PDT)
Message-ID: <ac2ea79a-c20b-c50d-11b6-2785e1cecfc5@linaro.org>
Date:   Tue, 18 Apr 2023 14:16:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 03/17] drm/msm/dpu: Move non-MDP_TOP INTF_INTR offsets
 out of hwio header
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Archit Taneja <architt@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
References: <20230411-dpu-intf-te-v2-0-ef76c877eb97@somainline.org>
 <20230411-dpu-intf-te-v2-3-ef76c877eb97@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230411-dpu-intf-te-v2-3-ef76c877eb97@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.04.2023 22:21, Marijn Suijten wrote:
> These offsets do not fall under the MDP TOP block and do not fit the
> comment right above.  Move them to dpu_hw_interrupts.c next to the
> repsective MDP_INTF_x_OFF interrupt block offsets.
> 
> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 5 ++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h          | 3 ---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> index 53326f25e40e..85c0bda3ff90 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> @@ -15,7 +15,7 @@
>  
>  /*
>   * Register offsets in MDSS register file for the interrupt registers
> - * w.r.t. to the MDP base
> + * w.r.t. the MDP base
>   */
>  #define MDP_SSPP_TOP0_OFF		0x0
>  #define MDP_INTF_0_OFF			0x6A000
> @@ -24,6 +24,9 @@
>  #define MDP_INTF_3_OFF			0x6B800
>  #define MDP_INTF_4_OFF			0x6C000
>  #define MDP_INTF_5_OFF			0x6C800
> +#define INTF_INTR_EN			0x1c0
> +#define INTF_INTR_STATUS		0x1c4
> +#define INTF_INTR_CLEAR			0x1c8
>  #define MDP_AD4_0_OFF			0x7C000
>  #define MDP_AD4_1_OFF			0x7D000
>  #define MDP_AD4_INTR_EN_OFF		0x41c
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h
> index feb9a729844a..5acd5683d25a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h
> @@ -21,9 +21,6 @@
>  #define HIST_INTR_EN                    0x01c
>  #define HIST_INTR_STATUS                0x020
>  #define HIST_INTR_CLEAR                 0x024
> -#define INTF_INTR_EN                    0x1C0
> -#define INTF_INTR_STATUS                0x1C4
> -#define INTF_INTR_CLEAR                 0x1C8
>  #define SPLIT_DISPLAY_EN                0x2F4
>  #define SPLIT_DISPLAY_UPPER_PIPE_CTRL   0x2F8
>  #define DSPP_IGC_COLOR0_RAM_LUTN        0x300
> 
