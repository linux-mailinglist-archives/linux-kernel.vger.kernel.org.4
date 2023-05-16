Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD937705B48
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjEPXWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjEPXWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:22:47 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9708F5598
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:22:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f24cfb8539so154972e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684279365; x=1686871365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7VAhpo92jN54Fe2L3yyfkmVB4msq33PbAZ9pt+KT4z8=;
        b=PEjKzkKFwg9DhWnkbxJIppl3GBnbkXu3XtMQpwJuourIFZZZmC5fiZnifNiPLMTCjU
         SnbTkokLPCSXFA37zY/8Rv7xKY/0oKMGKzm7Ly/pA25Sm8ULpecPptiYZgAMj3aeZKO9
         h764fhx/OgSu/GsW2Mj5DHnkceGTUY3fSuSI+xY/2m+1cEtiR2gvu/MgGSz1SsTuhKkA
         VdQ81FC9pEQb7QmaXuFANifFA0ywpBkaZCIEX5lUBjf/5PWaOGpJfwJr86AEpL48qjdl
         V4EweawUNHyM8ZbYHrPS7nKv7hg384jkBl140aRR32GLgB3E1TJB+KTdrUDGueSmvCZj
         G/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684279365; x=1686871365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VAhpo92jN54Fe2L3yyfkmVB4msq33PbAZ9pt+KT4z8=;
        b=S4cdpgk44ElBgev41ZjoGhhaJm2WQxobzrvI6iJyorT/hneN3mCDzCIvSMPrOrCgNB
         kcxwWFB35EKvzQboE+CQD321s4XoUZQkNjKiGFWQmN9pbZjlNc/ghe8hVTphgG2uGOqW
         24vLSDUD/NWXCljt+MMC2DA2IG9h6li7BonyzG31wzlv6p1Re00S4XPanNVsHaAbFlDX
         DFjU3Ujpu61m1FjmvPJxxg4xaCV9yjMERa79m4sXRvLIbw0hZr6xcfE6AHWjbRyz43PW
         9URMaelFMslcWasM5r+quwGLWBsB6JK/LOy/JlZC6GRQFcNnNIEdIISEQ1IK9WfBULos
         Hs5Q==
X-Gm-Message-State: AC+VfDzsF4BJnc9ZHFnQixw+vkLPmeEX6X78LLhtAa++jeF8Icu9kXy5
        uZtBdn1OWMHmBC5Mf6iVxGt1pA==
X-Google-Smtp-Source: ACHHUZ6ZLHWS6AxNdvby7Rx3xUbbWtDDyrWiA8gw73Uk9O49w5tJDuZUC7wwOX77tlraOpnpmbnTBQ==
X-Received: by 2002:ac2:46f6:0:b0:4f3:7b1b:ff7b with SMTP id q22-20020ac246f6000000b004f37b1bff7bmr3043742lfo.9.1684279364857;
        Tue, 16 May 2023 16:22:44 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id z12-20020a19f70c000000b004db3d57c3a8sm3119886lfe.96.2023.05.16.16.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 16:22:44 -0700 (PDT)
Message-ID: <aec4f825-482a-5e8f-66e1-d74b218e1a8d@linaro.org>
Date:   Wed, 17 May 2023 02:22:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/2] drm/msm: Be more shouty if per-process pgtables
 aren't working
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20230516222039.907690-1-robdclark@gmail.com>
 <20230516222039.907690-2-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230516222039.907690-2-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 01:20, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Otherwise it is not always obvious if a dt or iommu change is causing us
> to fall back to global pgtable.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/msm_iommu.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

