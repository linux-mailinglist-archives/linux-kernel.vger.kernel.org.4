Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239816E6104
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjDRMSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjDRMSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:18:36 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1D119B4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:18:33 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id j11so17690214ljq.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681820312; x=1684412312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5cxVw9YSikx002hly9GEAsV567PP+kQP1sM6EfB2Co=;
        b=Tp2K1BX9OOUuGPhWUAu5PjFgtrEl6eOyccDkPCEAvfIa/2kgX8zh1hZWroSUnek4qO
         UjR2/u4yCP1MiWVBiG8kD9X0pyVfWIiW4b8XSEpQarcFTvRKZmeCD2dRcFE4HGE05c+p
         5mTyzCZD/XlsEfyN35kFfT09IeqVU7/oWojfy6Ol75sJAGLfuoBrjbjtn1/mM40nUiXD
         15mzuraHRGr0pMlBy5S5ni056qyM+8KZCMRXVKZfGHYukAuScJI4fR1iJNIhBY8CEcrM
         wA7B4SJRjaE8ZvXKmgM3qEbnQtZ6AOvnKNMC7kJVLyQRU3adS7Jj/qP36pwowxGGMN3h
         /VfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681820312; x=1684412312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5cxVw9YSikx002hly9GEAsV567PP+kQP1sM6EfB2Co=;
        b=SYWT/y9S6Bp2bQRKV8uS3KdrrnaX1OYXuV291nvI2SJeDVFLL+6BvIK2yLHjpgvOYh
         Xeju8xpBwPrnlsirBcWTdv9vb0UIQ+fKCHpbfutI/9sxuSlqn2/XycOboJePR73rpoZg
         JN+je/kT+kTUMHYv1rp5HO56bRSg11A11BWe5wWjFVzZ4MCWblzF9xSltt/97vRII4kK
         afIT8sgPyGjXCsaNdFCMeEFuxub18zt/T5L3vKu5PFwdSKbXAqqQhrhNNMZY2uzas2b/
         7tz3zXB3q6D/6YbLl8meaFuLKCbeQt/DXXNdWQJryqWhZOo1veQSkK2+ibwgA1l9kwdX
         Y51Q==
X-Gm-Message-State: AAQBX9cddiRuiluE4jop5g8yf8BgiRbj4kb2Cxt/C/ediyjp9ru2maXg
        oQEnVXyqBKuQfDyxfGRvwfhfeg==
X-Google-Smtp-Source: AKy350av1XJ3jXQfSMjdRIlffK92NsVOt67SJ0ygIdBrTmoPvuEK8mAfNV5QJh2WF6ITbgmeWh0s2g==
X-Received: by 2002:a2e:8799:0:b0:2a7:9690:ca01 with SMTP id n25-20020a2e8799000000b002a79690ca01mr667734lji.18.1681820311894;
        Tue, 18 Apr 2023 05:18:31 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id z21-20020a2e8e95000000b002a634bfa224sm2557662ljk.40.2023.04.18.05.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 05:18:31 -0700 (PDT)
Message-ID: <38478a18-d60f-924f-f8cd-3ba44d0f1c65@linaro.org>
Date:   Tue, 18 Apr 2023 14:18:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 06/17] drm/msm/dpu: Remove extraneous register define
 indentation
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
 <20230411-dpu-intf-te-v2-6-ef76c877eb97@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230411-dpu-intf-te-v2-6-ef76c877eb97@somainline.org>
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
> A bunch of registers are indented with two extra spaces, looking as if
> these are values corresponding to the previous register which is not the
> case, rather these are simply also register offsets and should only have
> a single space separating them and the #define keyword.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 41 +++++++++++++++--------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index b9dddf576c02..1d22d7dc99b8 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -38,26 +38,27 @@
>  #define INTF_ACTIVE_DATA_HCTL           0x068
>  #define INTF_FRAME_LINE_COUNT_EN        0x0A8
>  #define INTF_FRAME_COUNT                0x0AC
> -#define   INTF_LINE_COUNT               0x0B0
> -
> -#define   INTF_DEFLICKER_CONFIG         0x0F0
> -#define   INTF_DEFLICKER_STRNG_COEFF    0x0F4
> -#define   INTF_DEFLICKER_WEAK_COEFF     0x0F8
> -
> -#define   INTF_DSI_CMD_MODE_TRIGGER_EN  0x084
> -#define   INTF_PANEL_FORMAT             0x090
> -#define   INTF_TPG_ENABLE               0x100
> -#define   INTF_TPG_MAIN_CONTROL         0x104
> -#define   INTF_TPG_VIDEO_CONFIG         0x108
> -#define   INTF_TPG_COMPONENT_LIMITS     0x10C
> -#define   INTF_TPG_RECTANGLE            0x110
> -#define   INTF_TPG_INITIAL_VALUE        0x114
> -#define   INTF_TPG_BLK_WHITE_PATTERN_FRAMES   0x118
> -#define   INTF_TPG_RGB_MAPPING          0x11C
> -#define   INTF_PROG_FETCH_START         0x170
> -#define   INTF_PROG_ROT_START           0x174
> -#define   INTF_MUX                      0x25C
> -#define   INTF_STATUS                   0x26C
> +#define INTF_LINE_COUNT                 0x0B0
> +
> +#define INTF_DEFLICKER_CONFIG           0x0F0
> +#define INTF_DEFLICKER_STRNG_COEFF      0x0F4
> +#define INTF_DEFLICKER_WEAK_COEFF       0x0F8
> +
> +#define INTF_DSI_CMD_MODE_TRIGGER_EN    0x084
> +#define INTF_PANEL_FORMAT               0x090
> +#define INTF_TPG_ENABLE                 0x100
> +#define INTF_TPG_MAIN_CONTROL           0x104
> +#define INTF_TPG_VIDEO_CONFIG           0x108
> +#define INTF_TPG_COMPONENT_LIMITS       0x10C
> +#define INTF_TPG_RECTANGLE              0x110
> +#define INTF_TPG_INITIAL_VALUE          0x114
> +#define INTF_TPG_BLK_WHITE_PATTERN_FRAMES 0x118
> +#define INTF_TPG_RGB_MAPPING            0x11C
> +#define INTF_PROG_FETCH_START           0x170
> +#define INTF_PROG_ROT_START             0x174
> +
> +#define INTF_MUX                        0x25C
> +#define INTF_STATUS                     0x26C
>  
>  #define INTF_CFG_ACTIVE_H_EN	BIT(29)
>  #define INTF_CFG_ACTIVE_V_EN	BIT(30)
> 
