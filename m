Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24C46E6115
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjDRMTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjDRMTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:19:08 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28BF1BC0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:19:01 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ec816c9d03so2170763e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681820340; x=1684412340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVUHv9GVSnBcu3oMPdI/NIopRwXK/wuVEPMQDh0yxqo=;
        b=hB4XIbeIGzdz2nJmfFOH4csRbqljl9PFshYQtDP3o1MCra1pA4BGNg8OluZ8TU3TNn
         xXgSQJ5Nb7AyRLY2ITfEGUFJb6Zix98/oulPJM869mgnT9DA8+zoeXoBhNCQ4I/7FzOo
         /0S4fbhRbJMnOx+wPTiQ+OaP7tdXoM+LBXwnlPmp2VWCUDt3wFmhJPZjwFR6fllYiLvH
         mZzvkx+doGa+jTh0/k8f9uAFFyiEKfmR/vpt86TctkLNGmMg1JHtcO3aGi5+Bcxjy5PL
         stO6XDkDloqdG3pIS26wKg4s6NpIjoFkrlFL0O1wugY+HSVKEFAy9dI0ix2lCP9Yy1Pa
         2/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681820340; x=1684412340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVUHv9GVSnBcu3oMPdI/NIopRwXK/wuVEPMQDh0yxqo=;
        b=lxSZwTsS7DEIcaisdxU+Y5eM8cPYyUlPB90I0E7FbdrcWtGEi27D1bSUdCRBni5ACS
         +5StEgyatj94stvV8zU+cJ8qxbqNlz7DMUR0KFI+iuVoAVdrp3cmm18yPYno4SCo1X2b
         5mTIgCn+nU2HsgI4wsqMysqVcwp5wPLsmTq+08/5Z1mGiJydLNMhaVHOZABC2ZapyMef
         bX1ripoAOdq+ozAymtWWtR/g1/0Hhjaw9eBD0s4k6qEJqEl27y4RWHujrhucmCfCSbLF
         MWzYRowltEXT9GnZ63ro8PJvypyjv2/pdH5AHw3xcXQwym5Y57lpfx7J+9ucfpFphkyI
         Xzwg==
X-Gm-Message-State: AAQBX9dbb4XYVqIFA0FOwOuqn4/TC38MF3CARttsdFNQ+7sZlEGJ/PQA
        GIpWc32G2TQ1rNyFS3mQR0ymcQ==
X-Google-Smtp-Source: AKy350ajegjWSo1YL9giSkWPjZI3mF0HFSGVnnXdrLqJeveDadl9IMChqknDvKeDavaiYXOKevOOsw==
X-Received: by 2002:a05:6512:11ce:b0:4eb:d20:b2ad with SMTP id h14-20020a05651211ce00b004eb0d20b2admr3485799lfr.63.1681820339982;
        Tue, 18 Apr 2023 05:18:59 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id 7-20020ac25687000000b004edc2a023ffsm936039lfr.36.2023.04.18.05.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 05:18:59 -0700 (PDT)
Message-ID: <20cdda24-58bc-7439-8bee-e558cf389f5b@linaro.org>
Date:   Tue, 18 Apr 2023 14:18:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 07/17] drm/msm/dpu: Sort INTF registers numerically
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
 <20230411-dpu-intf-te-v2-7-ef76c877eb97@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230411-dpu-intf-te-v2-7-ef76c877eb97@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.04.2023 22:21, Marijn Suijten wrote:
> A bunch of registers were appended at the end in e.g. 91143873a05d
> ("drm/msm/dpu: Add MISR register support for interface") rather than
> being inserted in a place that maintains numerical sorting.  Restore
> that.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index 1d22d7dc99b8..1491568f86fc 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -36,6 +36,10 @@
>  #define INTF_CONFIG2                    0x060
>  #define INTF_DISPLAY_DATA_HCTL          0x064
>  #define INTF_ACTIVE_DATA_HCTL           0x068
> +
> +#define INTF_DSI_CMD_MODE_TRIGGER_EN    0x084
> +#define INTF_PANEL_FORMAT               0x090
> +
>  #define INTF_FRAME_LINE_COUNT_EN        0x0A8
>  #define INTF_FRAME_COUNT                0x0AC
>  #define INTF_LINE_COUNT                 0x0B0
> @@ -44,8 +48,6 @@
>  #define INTF_DEFLICKER_STRNG_COEFF      0x0F4
>  #define INTF_DEFLICKER_WEAK_COEFF       0x0F8
>  
> -#define INTF_DSI_CMD_MODE_TRIGGER_EN    0x084
> -#define INTF_PANEL_FORMAT               0x090
>  #define INTF_TPG_ENABLE                 0x100
>  #define INTF_TPG_MAIN_CONTROL           0x104
>  #define INTF_TPG_VIDEO_CONFIG           0x108
> @@ -57,6 +59,9 @@
>  #define INTF_PROG_FETCH_START           0x170
>  #define INTF_PROG_ROT_START             0x174
>  
> +#define INTF_MISR_CTRL                  0x180
> +#define INTF_MISR_SIGNATURE             0x184
> +
>  #define INTF_MUX                        0x25C
>  #define INTF_STATUS                     0x26C
>  
> @@ -66,9 +71,6 @@
>  #define INTF_CFG2_DATABUS_WIDEN	BIT(0)
>  #define INTF_CFG2_DATA_HCTL_EN	BIT(4)
>  
> -#define INTF_MISR_CTRL			0x180
> -#define INTF_MISR_SIGNATURE		0x184
> -
>  static const struct dpu_intf_cfg *_intf_offset(enum dpu_intf intf,
>  		const struct dpu_mdss_cfg *m,
>  		void __iomem *addr,
> 
