Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE866EB590
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 01:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjDUXKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 19:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjDUXJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 19:09:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0042702
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 16:09:46 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ec817060cdso2387777e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 16:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682118585; x=1684710585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MBHd1gKWaWHZRcJ+IDDu5qaiPRlR0iYD3UI1a4NgnfA=;
        b=jCS43GrUjtfz1056k3fY1II9WNVWqeit31A7Xw4HORm/9Gx8tHGRLM1dc7sKf5jW5/
         1mq/mHmEDt2yVGtwzHoGk4uUbxvOrUH4b9Ozc5c3Ro0VVGnpKFO55g8qRRa77J8AGnzG
         Kzx1gB9jcSNqF+12Lx75qERgclIj/g2O+BzyUsnaLuRzJg4cyUvpUjCIGJxA+/PMO2Ep
         QsxlyrCv/+7ekDd35mDv3nzT5w4FOk/iMn/sSN3APz3zPvrdWKaoGNiLs6kFxEFXs/1f
         JmVWjR0QPznYp5v1rk1WoZMBPPsVrloy2vqMKRsRBk8IZE9Wl9EmquXA775rQpXIq2r8
         uPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682118585; x=1684710585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBHd1gKWaWHZRcJ+IDDu5qaiPRlR0iYD3UI1a4NgnfA=;
        b=Y9Xk1OxUu3PjTxo/VNVGS06yS0cIQ2YEUYQGmdrx3LCix8fB352u/eETIw2ZF9M+uG
         bYm1Hx4RekJhAicvhZeXVOypcf5gip7oJazurz/g1W1ZDm5w1voJmODGSYgNXl5mx4Nr
         nl+hbZSTZJtJzEkV0bDZnNLy+y7U4AEZvRCrd4XikYA6v4pDuUiJ5X53y7oaVtQ9CpXn
         Pw6dxdHfXBYEoS2UlURBnBZu/l6vF7OrYaueaVM7IQ6xwHNyDUBE83Aj/zDgOf9w4vx1
         t0DCkk+KEF2rS3OzgKXvTo4gl6IpTS082LUJOo1zxcTI0lgm9GKAa6hq5xiPE9Xmdjc2
         fTfw==
X-Gm-Message-State: AAQBX9e7Xks39kkoZZwWrlr1w8SxDYTIVlXwnOW5riY1KTjw3y6c4ZI2
        wICQhI1BRYkBamXk3z530RKa1Q==
X-Google-Smtp-Source: AKy350ZpYUuUjnqy++sLsWhjdTBb+T9UNo/712URdiL+KK7Xt1VeebkM/WEdVxlUHYDS/yJn7EYM8A==
X-Received: by 2002:ac2:5611:0:b0:4e8:3fc7:9483 with SMTP id v17-20020ac25611000000b004e83fc79483mr1801853lfd.23.1682118585004;
        Fri, 21 Apr 2023 16:09:45 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id r4-20020a19ac44000000b004cb0dd2367fsm699255lfc.308.2023.04.21.16.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 16:09:44 -0700 (PDT)
Message-ID: <5b389840-e736-5924-b88c-242ecdd1c179@linaro.org>
Date:   Sat, 22 Apr 2023 02:09:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] drm/msm/dpu: remove DPU_DSPP_GC handling in dspp
 flush
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230421224721.12738-1-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230421224721.12738-1-quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2023 01:47, Abhinav Kumar wrote:
> Gamma correction blocks (GC) are not used today so lets remove
> the usage of DPU_DSPP_GC in the dspp flush to make it easier
> to remove GC from the catalog.
> 
> We can add this back when GC is properly supported in DPU with
> one of the standard DRM properties.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> index bbdc95ce374a..57adaebab563 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> @@ -336,9 +336,6 @@ static void dpu_hw_ctl_update_pending_flush_dspp_sub_blocks(

Please drop the DPU_DSPP_IGC in a followup.

>   	case DPU_DSPP_PCC:
>   		ctx->pending_dspp_flush_mask[dspp - DSPP_0] |= BIT(4);
>   		break;
> -	case DPU_DSPP_GC:
> -		ctx->pending_dspp_flush_mask[dspp - DSPP_0] |= BIT(5);
> -		break;
>   	default:
>   		return;
>   	}

-- 
With best wishes
Dmitry

