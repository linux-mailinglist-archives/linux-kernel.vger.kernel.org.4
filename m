Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E030B72F6E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243606AbjFNHvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243583AbjFNHuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:50:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8640A1FCC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:50:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so8407338e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686729013; x=1689321013;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5YKbnziRubzVi6WVqVyFd6EQmt+JKI0ymRHuouDj6uo=;
        b=IdNjcAMDt98lGyTI5oa6MM1LG3BNT6elZKLC2j/7rkJWCZf/9n3Elo5ApgN3hsvvdL
         It/byY3ulSwVsawBHbtFzTDuBOx6UWeoDlre0+oXoEfKimdxTL0dNNo4WFoaYLgn4jIj
         pqUTI/oAGa4kEN/wSYAV0bRg0/wxAAxa/q1Q1/cAVF4vck9ViKZyLVrgwZjqZJkdiq1f
         8xtOroSsJ+UMT7w9mA0W602up6hE9ws/yskkXwCiGmxQdeslD2UpDoe4CsZjWUm3+5hE
         3qlsWEEb99Gc6mBBtwt3urOsWRedA8t+pZW2tXAjqE2YuWrRnodeM3uxfqIqNQBr+Z9b
         IOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686729013; x=1689321013;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YKbnziRubzVi6WVqVyFd6EQmt+JKI0ymRHuouDj6uo=;
        b=gC1BBxVlzqxQp/AirJ8kXnYgXiwmZPXl78sffgeYg8IDoLu8VCHX379/mIxD+WY6WO
         DuMl7MQb5M0TuybLPdaadTNyeXWpkBw8fQXffEY2tJR79Wq55IXiXWLc7vk/3UaW/ega
         /NKZfN6vWXaO32rDT4XjbCZnVvYrv8iTQ91Cp2rDwh+DsEGqaw9tYj3dvxJG4+Cz+F+Z
         ss//uqzO9aoe1ze8rV10q9my93te9sauAEZQO/eEeHQ6G77hUu+Zj6Hmn4EGN/1q21tb
         dky2Er81SYeieRLXtdoxLjF5YwuN3bMdaCu2A1xzhy95mH3dsMeNVGZMJLe3MP1DEoue
         nymA==
X-Gm-Message-State: AC+VfDzwRz+AhaIw4bG7SLxv5GyYREMsJTNCu4mmq8+yXaUgcGW8i9ZA
        jOjB/MaiBuCPrlKcgw547RMChQ==
X-Google-Smtp-Source: ACHHUZ62kZgdM7tNsdnhfQwqAqvqdDnBY+55awm3KAvrMDFVTGmNWTfyGfL/tK1ICdVnfmLheBEF1A==
X-Received: by 2002:a19:6d1c:0:b0:4ef:fb4b:eb2d with SMTP id i28-20020a196d1c000000b004effb4beb2dmr6572027lfc.33.1686729012630;
        Wed, 14 Jun 2023 00:50:12 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id w15-20020ac2598f000000b004f138ecab11sm2047820lfn.24.2023.06.14.00.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 00:50:11 -0700 (PDT)
Message-ID: <d8f51ab1-b466-d6af-3e85-dac88c402d23@linaro.org>
Date:   Wed, 14 Jun 2023 10:50:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] drm/msm/dpu: Add DPU_INTF_DATABUS_WIDEN feature flag
 for DPU >= 5.0
Content-Language: en-GB
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     quic_abhinavk@quicinc.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
 <20230525-add-widebus-support-v1-1-c7069f2efca1@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230525-add-widebus-support-v1-1-c7069f2efca1@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 04:57, Jessica Zhang wrote:
> DPU 5.x+ supports a databus widen mode that allows more data to be sent
> per pclk. Enable this feature flag on all relevant chipsets.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 3 ++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 ++
>   2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

