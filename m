Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C694717158
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjE3XIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjE3XIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:08:14 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7B419F
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:07:42 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2af278ca45eso53265521fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685488060; x=1688080060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aZBYZqm2QX9cYcGeEqnnE5rqTJSxRk4/JBiXuTiUxM0=;
        b=ulU+69wC13TRns9H2O4cl+nn9Tz8PwxPmBGH5PNA5IJHmcDcqr4OY3NcBQ5ialQbdJ
         bL9wumq+ipUUiEBgXf+dQO64M5/jlSPXdd9TOXfLDyi34sLTtdCae1lPq+Lov8MZTt11
         GPFB53UzyMHTv0GbSXrrQkVs2s7tRGqyyw5UiBm19a2fjdjsnwN/JZJn5WIM6tDvB0zy
         BSIGjGnT0AHRIdP/VKdLLE/EH5z8y36+GJWsh5R/nl/nbS5r36LdNEj0OrWN1WTVnEL3
         UzNufZw6i23RzNQIsWiLs+A1gUGcYNTSMFwQjelbwHM+OnEp/FOgYgpEzYp5JBD0blNU
         zUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488060; x=1688080060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZBYZqm2QX9cYcGeEqnnE5rqTJSxRk4/JBiXuTiUxM0=;
        b=Ru9QqTPFX+dx0R2DBlvGSAPZ4Ik2yYYDXQxUpjVfh1dbfC5pfVSK5BG849VetVfRvq
         mOaUHj4XTDaLdj8rxp+C91fftNf5m1cVunYQ0A0aF2hXIg5WyGDspW6nMXf+iGKboNZV
         wpv8AreAJhf1mlT0h7E+U0jSBazkVDxxTUSXwqpliAklKlaXICCOa5gue0BdJdf/8MFS
         HNgWtxqKu1758AWnYwBKl0nd/YP5onpmRpQiWLLCEZvvBYPAEN85rLcKbYSCh+4hQkPU
         10bIaDhI9fpcFzAnoxmKUAePb/den3hXnx54DU8KhSE6cef6+SBloBXkNF7wUHWkbBkC
         LJ7A==
X-Gm-Message-State: AC+VfDyO11jSWINrlyfuGhno4MHnpbimOX3ipucw5/1Irzs/h1m6m1Xh
        SgBbDPwvc5w4thFA6yR4MDDrUw==
X-Google-Smtp-Source: ACHHUZ5Ej9llgNKtAHQ57gkDu3OnNpoWD2Lx9icO+8TRpW35FdeXVdc2sZL1MNWqROBGbmmQgDUuwQ==
X-Received: by 2002:a05:651c:10b:b0:2af:d2ef:49d4 with SMTP id a11-20020a05651c010b00b002afd2ef49d4mr1515001ljb.1.1685488060177;
        Tue, 30 May 2023 16:07:40 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u3-20020a2e9b03000000b002aeee2a093csm3044298lji.59.2023.05.30.16.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 16:07:39 -0700 (PDT)
Message-ID: <64fbc753-d8aa-6845-c530-f76999e8c7b9@linaro.org>
Date:   Wed, 31 May 2023 02:07:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 3/3] drm/msm/dpu: remove msm_dsi_get_dsc_config()
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1685464318-25031-1-git-send-email-quic_khsieh@quicinc.com>
 <1685464318-25031-4-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1685464318-25031-4-git-send-email-quic_khsieh@quicinc.com>
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

On 30/05/2023 19:31, Kuogee Hsieh wrote:
> Since msm_dsi_bridge_get_dsc_config() was added to retrieve DSI DSC
> info through DRM bridge, msm_dsi_get_dsc_config() become redundant
> and should be removed.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 2 --
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h | 2 --
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     | 2 --
>   drivers/gpu/drm/msm/dsi/dsi.c               | 5 -----
>   drivers/gpu/drm/msm/msm_drv.h               | 6 ------
>   5 files changed, 17 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

