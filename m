Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEAB6EB676
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 02:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjDVA0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 20:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDVAZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 20:25:57 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC07D11C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 17:25:55 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ec8ce03818so2370866e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 17:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682123154; x=1684715154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OQWCpIJTAP1Ry3VsEerFVkfg5+LmukA8mKwvl4J2fQ=;
        b=hofCmIcOQV7vmT+uSPYmfnrarP9ImgW5VOyXN/GBZPHRTClLSUmQQ5VItaKz/ze67Y
         qrb2AYoT3SpmTopHd4nYKj9jNmsLi1Gh8BvkUuCMoaUp5wz63YJVAXiiFJcAIdClRuFm
         ep3L+zrUOGDG4VLjFzcxdLuoKld/BIvyKl8k7Ie9CG1cTFlz80h304tWXZSp4bEuWzqK
         okE+GJ8I6hVdyf5kGsVivUiqlUe/qhbtpo0hxqFyXpStaLbsWkv5LwdYpHaNuEOkz0cc
         zcRXhZZR7N+eXS04m7hbG0D66fXmPGXcHd5LniBhF1KFT5zv4Bpjsz+YvFL1Mi12QKqn
         q3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682123154; x=1684715154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OQWCpIJTAP1Ry3VsEerFVkfg5+LmukA8mKwvl4J2fQ=;
        b=UlvCE1hwT62Ihq0w4l6uwfA9P0pNnLeBDPuj44v7UxcF8FcB/9ovX/Ywl0h/HNzOST
         BVNoFcsXb0i6JNV1Q26UlqbnE5z6ri8P9KtSl2vyaVkYXBUGzVcqhAp++ykwTUMBJh2j
         /GHDiOiAkwUsd97UHFPg6VeBw4aF+UYwi5Pq+gMeZurGPJgGpVveh4tMAXaD+YePfh4z
         B4wDQoPIg3Sz5f7zcsOPCrLNiDa0EpcJj5bZ076KPiw4S8Xjf3/vy7W+r0JHBdcFPxIR
         AaYzSIqH+xWGrV0SQGDlivieCHNcB5DFML2lEIHqMKycs78Ae8Ve5dxVp6hV+NKTbKMI
         nFEQ==
X-Gm-Message-State: AAQBX9fH8BCG8tm7Yg+2kFuPkZSiybgT5r9fEJ4cy7F+Hhe4fvhV+kE4
        cPPKLzmVXoHNFhiWedqXaYeJQA==
X-Google-Smtp-Source: AKy350ZWdFxJ2/AmpEAZfXikVOlUeKDpM+FXXIRP9U3RhsWAlAboixbX9MLOQe98xCfm16NMrQahCw==
X-Received: by 2002:ac2:59dc:0:b0:4eb:2d47:602 with SMTP id x28-20020ac259dc000000b004eb2d470602mr1762343lfn.59.1682123154123;
        Fri, 21 Apr 2023 17:25:54 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c19-20020ac244b3000000b004eed68a68efsm708285lfm.280.2023.04.21.17.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 17:25:53 -0700 (PDT)
Message-ID: <6a4bd978-14e4-4e15-49b4-6ce3e0e5d1a5@linaro.org>
Date:   Sat, 22 Apr 2023 03:25:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/5] drm/msm/dpu: add support for DSC encoder v1.2
 engine
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1682033114-28483-1-git-send-email-quic_khsieh@quicinc.com>
 <1682033114-28483-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1682033114-28483-2-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2023 02:25, Kuogee Hsieh wrote:
> Add support for DSC 1.2 by providing the necessary hooks to program
> the DPU DSC 1.2 encoder.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/Makefile                   |   1 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |  38 ++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h     |  17 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c | 388 +++++++++++++++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c         |   7 +-
>   5 files changed, 444 insertions(+), 7 deletions(-)
>   create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c
> 

[skipped]

> +static inline void _dsc_subblk_offset(struct dpu_hw_dsc *hw_dsc, int s_id,
> +		u32 *offset)
> +{
> +	const struct dpu_dsc_sub_blks *sblk;
> +
> +	sblk = hw_dsc->caps->sblk;
> +
> +	if (s_id == DPU_DSC_ENC)
> +		*offset = sblk->enc.base;
> +	else if (s_id == DPU_DSC_CTL)
> +		*offset = sblk->ctl.base;
> +	else
> +		DPU_ERROR("invalid DSC sub block=%d\n", s_id);
> +}

I have just sent a patchset removing the _sspp_subblk_offset. Could you 
please inline this function too?

> +
> +static void dpu_hw_dsc_disable_1_2(struct dpu_hw_dsc *hw_dsc)
> +{
> +	struct dpu_hw_blk_reg_map *hw;
> +	u32 offset;
> +
> +	if (!hw_dsc)
> +		return;
> +
> +	_dsc_subblk_offset(hw_dsc, DPU_DSC_CTL, &offset);
> +
> +	hw = &hw_dsc->hw;
> +	DPU_REG_WRITE(hw, offset + DSC_CFG, 0);
> +
> +	_dsc_subblk_offset(hw_dsc, DPU_DSC_ENC, &offset);
> +
> +	DPU_REG_WRITE(hw, offset + ENC_DF_CTRL, 0);
> +	DPU_REG_WRITE(hw, offset + DSC_MAIN_CONF, 0);
> +}
> +

-- 
With best wishes
Dmitry

