Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F62169B4BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 22:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBQVZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 16:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBQVZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:25:52 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7CF644F8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 13:25:42 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a18so2493016ljp.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 13:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORR0AQhnlGMPN31e9mPJsCgrOnth8Cg37H+T3TwuNc0=;
        b=EoKqClsxJvczaooILRkmTBpck9RRYIHxHhARz8ghkE8ju8QcDyIPrBdTfevR7Z7AYF
         bQvRcgTxf3QXT3o+H7K62Y1yvdZ99qrQDH+WtYWTyVIw80V+nDv62YyBoaZKLIAbH56g
         jf3LIQbBz8bo+W1AvacimbCzHm/J6YBzWx1Wn8MLFLclXLAvF0jnke0Mvt6d+RMbJx/r
         qRbrGwgZxk5J9sZMf9Yia+L+eo6jHfR+gHpeXfVYCtPECh32Dmuez+UhF9KDPoQNms/+
         KGUJ1wv4V2NMYKV55/yZrCYnbb1fQcmwca5HaYPXOprKOubiHt30ejmd2g3BUdl7aHdK
         f8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORR0AQhnlGMPN31e9mPJsCgrOnth8Cg37H+T3TwuNc0=;
        b=TlAcU9tusx1Rk2myfHmS0ioHVbQCBpzwZb6C+tKUPntSgq1VrtnwJa8+5ObVyClCLb
         v6Sejg6tKErpZvIJWjpDuO/4mMmm/XXTfQMGiUXedQzDzQVusgAdU1LM4ntcFLY/HCWX
         4WLIvwTPIYsb4rH6n+v6L2XNs6CFZhQipXUoY+z9pfncd6glP4dH3FzzSwkasWRXQHO4
         fxzftY0xcEGeA+qSYgLvKOK6nchqbqj44RcSzs7PCYHzuFU+iIgbjwp9H5k4w1qwFSBM
         ZOinByAXLennQH6y7I+81QfrwhyJa2vByCQJM7TdtNRP4jie6G1uySFj6MZbMBJrobSq
         uIaA==
X-Gm-Message-State: AO0yUKXS2Y3g2GqTSyTG0ymqivLl2rZw7i54Hf4xi6HUTHR7SqNW4KDC
        Zjw3GS8fcrVTxH7ZyeacJ1Ny1A==
X-Google-Smtp-Source: AK7set83FcpuRjdr9aqb+dOcUa1SF8I+J/myUtqrLeob8tTbxS+Ehimel0K+msGa0mKWSfujy0Ztag==
X-Received: by 2002:a05:651c:2118:b0:293:4ba3:17be with SMTP id a24-20020a05651c211800b002934ba317bemr1091977ljq.11.1676669140539;
        Fri, 17 Feb 2023 13:25:40 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x2-20020ac25dc2000000b004db513b0175sm783715lfq.136.2023.02.17.13.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 13:25:39 -0800 (PST)
Message-ID: <a13997c2-3b68-7c30-2486-c56cb7b72170@linaro.org>
Date:   Fri, 17 Feb 2023 23:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 14/14] drm/msm/a6xx: Add A610 speedbin support
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
 <20230214173145.2482651-15-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230214173145.2482651-15-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 19:31, Konrad Dybcio wrote:
> A610 is implemented on at least three SoCs: SM6115 (bengal), SM6125
> (trinket) and SM6225 (khaje). Trinket does not support speed binning
> (only a single SKU exists) and we don't yet support khaje upstream.
> Hence, add a fuse mapping table for bengal to allow for per-chip
> frequency limiting.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

