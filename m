Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082F05F8DB4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 21:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJITYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 15:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJITYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 15:24:42 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2572E60F8
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 12:24:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id p5so11125989ljc.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8Zf3BsxO45m3r/45zObKvChnR3gfGHDc8wwHfVB+mM=;
        b=Jo9FydsSo3KFqrMCPz1dJsMMf24LFsWe5cCzzTzQDbtFmRMvq1lX56myj+xDLnPLlF
         MUZEZXHctCl7yP//dIcPizkSs76q1iHU4aukA2TogMY3zvIRIq+1xArPgUZJmPnoZakX
         LONOD0jWD0X5Reod3urH0E05Jc9rfxhqydw6tF0uK5uBZfJwq+JbzDj1ko9Tj2KYuC/F
         eDzeaeOvFbzXGHrpkZbSAk4tcmLAJA8NkWeCWXng7V0+uF27JUMKsA3OqAgISqFLQZ2Z
         NoJf2V0YtA6NHTE1ecsbqEfwzX6xO7J+kQs0rkCMMxT5G0u1Xb+n+upE+Y8JpHswZ1mP
         BvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8Zf3BsxO45m3r/45zObKvChnR3gfGHDc8wwHfVB+mM=;
        b=zRKq6GxQS9TQfKuHVutXg15uBTtB6oyvMn8i7FpXuSs/TMbSqlkBPZIEs5onF57vrX
         +tWM9Irpnm6aARgj/a6ySnUiia3EQgVuVHVEy1uepwTPLznssosyCkA/KaxSwp414W7V
         ++YCBza/BxucOmVYOXFmjhkeQjfYdMZod4hDHDVNqCye03/dZ7IxubFhDM5iVzUASV4x
         unfE4emYtuBs+/Nwx99VX9jqWQ1ksNncqH6JLB/8wQ99XyZbuNyFTEDnzHyvQWEfvtbM
         lf5tehM20qtiN3S0UlPTmUwHJp2PYqKDIeOnpjJW4Z3Mx+mZSMOHmCiiJN2TTDEWA313
         ld6w==
X-Gm-Message-State: ACrzQf0bkTZSlaMs8iPFpdt4j6QPYpf+SPMISuMZHbZflPrSApEsbQNH
        ResHmJN0mPbKrxKGKfprcLzrWw==
X-Google-Smtp-Source: AMsMyM66JUJ2jqCOTzPTtqfXv5I+mno/7wauBHCBh7zYyj1HZ/eXqdJXn8tZeHWFk4fcR/T4hyf7Pw==
X-Received: by 2002:a05:651c:1590:b0:26c:4311:9b84 with SMTP id h16-20020a05651c159000b0026c43119b84mr5816939ljq.152.1665343477534;
        Sun, 09 Oct 2022 12:24:37 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id n17-20020a0565120ad100b0049936272173sm1111974lfu.204.2022.10.09.12.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 12:24:37 -0700 (PDT)
Message-ID: <13755211-82fe-937b-f96e-966a55e68917@linaro.org>
Date:   Sun, 9 Oct 2022 22:24:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 08/10] drm/msm/dsi: Account for DSC's bits_per_pixel
 having 4 fractional bits
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221009184824.457416-1-marijn.suijten@somainline.org>
 <20221009185316.462522-1-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221009185316.462522-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2022 21:53, Marijn Suijten wrote:
> drm_dsc_config's bits_per_pixel field holds a fractional value with 4
> bits, which all panel drivers should adhere to for
> drm_dsc_pps_payload_pack() to generate a valid payload.  All code in the
> DSI driver here seems to assume that this field doesn't contain any
> fractional bits, hence resulting in the wrong values being computed.
> Since none of the calculations leave any room for fractional bits or
> seem to indicate any possible area of support, disallow such values
> altogether.  calculate_rc_params() in intel_vdsc.c performs an identical
> bitshift to get at this integer value.
> 
> Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 

-- 
With best wishes
Dmitry

