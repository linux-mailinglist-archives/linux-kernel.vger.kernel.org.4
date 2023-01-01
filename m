Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BA565A8D0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 05:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjAAESx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 23:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjAAESq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 23:18:46 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573296356
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 20:18:44 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bt23so20616002lfb.5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 20:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69gDuhyvyskPxkoiJfXY3XwAwa6ovH+bzxQjyk8p6KY=;
        b=l75jACFlTzZ9CieQRawrOxUg5PWkxRFz+86CrBn677QHCKCfG2gPbyJASTfn/6+uBm
         BM6oD3FiM0qTj8qhD5xcn6xRGIvWhmCt5PGXYOpQUEiWbNKDUgTnZOca63a9Q/xqQf0E
         PNyLL15uP4oXeFivahExuqn4zvti81uw7NUuUfILsnzXclFaIi6aijc0oBElIYhzih5/
         KXqmS5ZFpxkKDOAsK/n4QERCbvUalyKmWjagkcbRmJb4hyaRQUJktAFBwrYAzy5V285R
         Wdp3OCprWRMEOYj8OgHJ9cz/tX/eglUbOmoN8/oGWtmttI4p1GoF1mBKdRPGnqf574Cx
         Uy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69gDuhyvyskPxkoiJfXY3XwAwa6ovH+bzxQjyk8p6KY=;
        b=lvzhBzlnAxvLdrHUY1HljeXB62X+1ozVWPZfYncpE3YYLT++Db1PQG/XXEziXSdXNA
         GA2OS4jtbKwBn80vfvdr6tkRYzadohSCx/BzMQE0NLLbm+hzYhVOPJEe5pq1FIw81KGm
         ushzJzNq+zO05JwO66QLs1TrqOsdlISFXJ2dARFx3YQXM7yd4/d8X6BJWvlw09PVZlR6
         YQpZV8M8glIfwfHJQ3twJsvTA0Mn+LXjC8PSczjyPUte4HjqNl65BRAtT6s9J638L+SI
         73d8JH6d2wiYvgOywYmOvImC4EDf1QlENmlCGDU2Vz3wto4wQLcS6bv+XZB5Aw7RU5PR
         xndw==
X-Gm-Message-State: AFqh2koLRrCaLCu1wZD7ZVk/XoLPYcittaa5ESISHCfoM+EfUyg68hsd
        Wj+bVPGcj+77pe2Dk3XqYmOFJw==
X-Google-Smtp-Source: AMrXdXuE4021vfsazj1mMsaa3Yx8JAAGxKmqnSmp/m8F5gbAZyIiSwE+7HkewlYDM12pbtMgJpxSuQ==
X-Received: by 2002:a05:6512:2385:b0:4b5:90be:33c8 with SMTP id c5-20020a056512238500b004b590be33c8mr11384536lfv.48.1672546722649;
        Sat, 31 Dec 2022 20:18:42 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id p2-20020ac246c2000000b004b5a85e369asm4047378lfo.252.2022.12.31.20.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 20:18:42 -0800 (PST)
Message-ID: <1f887a99-8184-44f7-204e-ff0a2dd98ec5@linaro.org>
Date:   Sun, 1 Jan 2023 06:18:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 1/7] drm/msm/dpu: Remove unused INTF0 interrupt mask
 from sm6115/qcm2290
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221231215006.211860-1-marijn.suijten@somainline.org>
 <20221231215006.211860-2-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221231215006.211860-2-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2022 23:50, Marijn Suijten wrote:
> Neither of these SoCs has INTF0, they only have a DSI interface on index
> 1.  Stop enabling an interrupt that can't fire.
> 
> Fixes: 3581b7062cec ("drm/msm/disp/dpu1: add support for display on SM6115")
> Fixes: 5334087ee743 ("drm/msm: add support for QCM2290 MDSS")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

