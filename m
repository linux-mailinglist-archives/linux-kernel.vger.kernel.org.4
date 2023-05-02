Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899346F4C17
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjEBVVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjEBVVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:21:52 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A1A1704
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 14:21:50 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2a7ac89b82dso44041351fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 14:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683062509; x=1685654509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wGbP6RM3R75eA3RnhHLQ4W06nOme0g1Ed3QvUzGLWq0=;
        b=Oqz1tTv7OVdAmsPsFQuYh79l0wo7ie+YsGt9Wuhk8ZZmKWFwnPeYt73iiW8dFY/6KN
         XOkPCB8YO1ktn7aEBlk5bD083ylewZW+HVjS6xqcCShkvLF3z2wo44ykkn/biLDtiBwf
         jNWcWwmvFLzOj28XzyoPshlKeywtZp3WErhkOsgeW3g9DkQxHHL/0MN/4Q2L9vNiIUv+
         fx/yVP6dtoelc4xjr2XrjCAIyppe1dsvxIQo9kPdMypu/rZO4+B9t2WpfSnqoKwBtwJs
         I8E6FmS3y8UBInZp8yvZafUB0oGaxlu9ZO/B5A8HG/IRBZ4uDEcGvWJ3b9dK2pX9/0TI
         IUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683062509; x=1685654509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGbP6RM3R75eA3RnhHLQ4W06nOme0g1Ed3QvUzGLWq0=;
        b=JfGoWEqlp4zJLmHZDykSD6MOztj17B4vjoLlpNW+pkQPeydPguqKytLKsx8+uo7dbI
         GUZse3n+84sRt2TF8/yLpihqPWkiezmZCnmiWd6te1hVLb+mSt0JKVaksjrOukOebEKD
         LuEd0P69h13bm9w6kLaeUrw2np853Ik1Pctyc0p4saKPleyovG0syHGS1DlVE/G04jew
         xgm/igl3P64SQ7EhKYkI4HHO3inx7ANcLjA9yIozSgDZzawhh349Yuquscr+UPWxHIuj
         CW09piB1ipyQdrz8A6SYZc04YgbTru1c9T+vBB5I/Ja0nKWpD5iupS36CKQ8Ek6YhutX
         UpmA==
X-Gm-Message-State: AC+VfDzOm1w6pEudSVHNP9HgZnDl0Zyul+NKB1ngW24AYn4jENKJtVJX
        JvdXKEbcrHOBMcHZg1aFccDX2A==
X-Google-Smtp-Source: ACHHUZ77AYKGrnUhyy85bE2JFop+7AXDKKij2MhhnC28fjOENsIP1ecIk/CW6bd+UDPm4j7do4xn8Q==
X-Received: by 2002:ac2:5199:0:b0:4eb:2643:c6c6 with SMTP id u25-20020ac25199000000b004eb2643c6c6mr320900lfi.53.1683062509021;
        Tue, 02 May 2023 14:21:49 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id c15-20020ac2530f000000b004efe7b2e35asm4880584lfh.248.2023.05.02.14.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 14:21:48 -0700 (PDT)
Message-ID: <ebd22101-16de-f754-9304-6ce0532394c8@linaro.org>
Date:   Wed, 3 May 2023 00:21:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 4/7] drm/msm/dpu: add PINGPONG_NONE to disconnect DSC
 from PINGPONG
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1683061382-32651-1-git-send-email-quic_khsieh@quicinc.com>
 <1683061382-32651-5-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1683061382-32651-5-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 00:02, Kuogee Hsieh wrote:
> During DSC setup, the crossbar mux need to be programmed to engage
> DSC to specified PINGPONG. Hence during tear down, the crossbar mux
> need to be reset to disengage DSC from PINGPONG. This patch add
> PINGPONG_NONE to serve as disable to reset crossbar mux.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 2 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c  | 7 +++----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h  | 1 -
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h | 3 ++-
>   4 files changed, 6 insertions(+), 7 deletions(-)
-- 
With best wishes
Dmitry

