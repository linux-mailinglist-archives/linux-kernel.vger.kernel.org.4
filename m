Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B6874318D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjF3AVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjF3AUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:20:55 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1C630DD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:20:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f875b267d9so2065005e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688084450; x=1690676450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yx2uReacsSjlB5YUCVOOR3S8enk7DDYDiBnyRDkYlf8=;
        b=EEK6IM0oR1KQiaIUmQRzZYYbmsv33f420dSCtYsBV6ZuFqE2WeNCsHpCN+uDOGT73P
         5B078rFYqp6L8I24vgAINwhEq2O1vhTEkUqf9wwRWpqfJPvjKOe9Fxz1GC/IZpecx3ke
         a5M2ptUfACDXN36SmJiznMyema0SeRiDs3Jak/9AjhkiHsdnT3UiKJh+ipgRS/CExtbK
         F2bJBiDKG0wOwYONYiUYN8Szht9deFiI+oOr8RdSpOwvZ8aAF+2lwA0meIaawZU4cr5v
         /4P/yubPC4bvatCGzbuH9ObBkuyoB9zzTW/O0ASsqXmRW3Y/wWSLytQbYW6Cz6s5gTNg
         NyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688084450; x=1690676450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yx2uReacsSjlB5YUCVOOR3S8enk7DDYDiBnyRDkYlf8=;
        b=iVaYx3LMwLrhsQEp8mpt/58UgvAZDih4NLvw/FU+Ol9vlGKHPaU0ZxxeVmu/WGCt7F
         3ECPHVFeyN+bv2Cem2xwT9KU00GT4n404tpI75utl5oMQ26i17gzZWkMJtmmtbT0coyG
         1lCtEMzIUoUCfxbCJH2Vyyd6tgG/aSRRBjSIxrv6SImnhJNALY0F3bPC3CGonx9vQY3f
         yD2Ur0pjqicj6OTwC+BR2Bp8OJBeKkfRkB0PZGisz1KD04T2Pk5NJ9kgxQMVqugxebhs
         vSQ/rExI8lJvUbIzOoTOy5+JN9iycxTgTwjMkLp6pgxMKoal861VqonfLKyGT31WijMW
         WWHQ==
X-Gm-Message-State: ABy/qLbFeVYXXGUy+TvTMt4N+IlY9KAVt5SGdTSqJd41KnqQRgpsnurG
        CGWwOJsfvhXlXos5PS5Bi811yw==
X-Google-Smtp-Source: APBJJlGPbplAHhgvOKZA2syZpVDVCLQJrMf9fUCYsyO4mN8vNXFe03nhEl8FXt+lD7Pd8jeD+j5IEA==
X-Received: by 2002:a05:6512:3b9c:b0:4f8:5960:49a9 with SMTP id g28-20020a0565123b9c00b004f8596049a9mr1260706lfv.23.1688084450081;
        Thu, 29 Jun 2023 17:20:50 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id y9-20020ac255a9000000b004f755b6ffcdsm2536439lfg.23.2023.06.29.17.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 17:20:49 -0700 (PDT)
Message-ID: <c4a6e82f-ddcc-3adf-4c50-b88c02c09a0f@linaro.org>
Date:   Fri, 30 Jun 2023 03:20:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/3] drm/msm/dpu: drop DPU_INTF_DATA_COMPRESS from dpu
 catalog
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230629193001.22618-1-quic_abhinavk@quicinc.com>
 <20230629193001.22618-3-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230629193001.22618-3-quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 29/06/2023 22:29, Abhinav Kumar wrote:
> Now that all usages of DPU_INTF_DATA_COMPRESS have been replaced
> with the dpu core's major revision lets drop DPU_INTF_DATA_COMPRESS
> from the catalog completely.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 2 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 --
>   2 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

