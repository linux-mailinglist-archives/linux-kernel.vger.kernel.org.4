Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF327099B1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjESO3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjESO3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:29:08 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CBB116
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:29:05 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f13bfe257aso3673723e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684506544; x=1687098544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXSWp9UT1nFmnhqm3B5R8YXXasDWmGa7xqzY3bdTr7A=;
        b=kwgATlkhkJ4dpLP5u471YE6mmR19bPExUHdjGal9FiBa7R6o+oSZL+4RnDlhNr6rG+
         ZBg+fTcrx53sT/mK7GMwZTZP/Np9fiqVxc4O0FfRFGTitrNigCpLb9LPZnTgUBvJPR/S
         MctcdvBpb9KpbHMWDu8XyEHKPtTur3zxrte8OohbJH7O/giAGZixo7Hd+p7LhLAdQ+3c
         uHt51bdM/EEISau7rcH0k2u+BDlx0Mvsjsfd5KnOLrX2xNVaOnRAqhk7FW0m1ywKn3Hk
         /eKpXOsMkVNKTjzqZi3B5wGXQDep9OvqyEnUEvmiT/Ku0mOws+C0JixM6wDb1WCJmjuF
         +szA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684506544; x=1687098544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXSWp9UT1nFmnhqm3B5R8YXXasDWmGa7xqzY3bdTr7A=;
        b=F8P53Ipu3+DNUtCRkNXXE4IyA3lzpp0oY2ZQTvo8fMWF7x6uX+2INu7T5/lZSPwgLs
         PeWs9+6y+JvWFOJSGvEGBLvzS+GdgX+ov6gKjwmhngMMH0KybJQvQvoAiiLEsUU7vhJ0
         Q1U3maxur7lN83V/j25XdmpK/6SYmQasBbHou+DZKD2zicBwGnZ3uz8Fop+6idbYDzFP
         yRaXdJxrBsTT+8VtWsOJalEXBLmSswh6c/db7FrCHV0P6DegL36fk7xt1ujuX9lV3Dc1
         r2KKvs9MOfsWigk+SkhDQshx8ky2pUc8JzCa9KwLwaKdSUvHX1We1iwYqePz/gJb65pS
         siQA==
X-Gm-Message-State: AC+VfDwJor93l4EB4KPId4N0yFmAY2OrEuccPvmiiORWXrp7A7YaTVga
        ueacNL3HD6EUCakzwPwE0AKYJA==
X-Google-Smtp-Source: ACHHUZ6w05g//15CVJcp2ZhyzGhk5MPjyJqW3b/KEHwqEqs+F7QYpnESM/ah/J7f/bBWLjs6GgWeTQ==
X-Received: by 2002:a05:6512:945:b0:4e9:74a8:134c with SMTP id u5-20020a056512094500b004e974a8134cmr763720lft.43.1684506544001;
        Fri, 19 May 2023 07:29:04 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d6-20020ac25ec6000000b004f14ecc03f1sm609354lfq.100.2023.05.19.07.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 07:29:03 -0700 (PDT)
Message-ID: <1678a177-f9a3-9673-d837-0ec82a4f5c1a@linaro.org>
Date:   Fri, 19 May 2023 17:29:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/msm/dpu: Use V4.0 PCC DSPP sub-block in SC7[12]80
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>
References: <20230518-dpu-sc7180-pcc-version-v1-1-ec9ca4949e3e@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230518-dpu-sc7180-pcc-version-v1-1-ec9ca4949e3e@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2023 00:29, Marijn Suijten wrote:
> According to various downstream sources the PCC sub-block inside DSPP is
> version 4.0 since DPU 4.0 and higher, including SC7[12]80 at DPU version
> 6.2 and 7.2 respectively.  After correcting the version this struct
> becomes identical to sm8150_dspp_sblk which is used all across the
> catalog: replace uses of sc7180_dspp_sblk with that and remove
> the struct definition for sc7180_dspp_sblk entirely.
> 
> Fixes: 4259ff7ae509e ("drm/msm/dpu: add support for pcc color block in dpu driver")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h | 2 +-
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h | 2 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c         | 5 -----
>   3 files changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

