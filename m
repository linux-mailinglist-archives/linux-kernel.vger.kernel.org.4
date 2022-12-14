Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F139264CF91
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbiLNSlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238907AbiLNSlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:41:06 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E102A73B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:41:02 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id y25so11938836lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KlbzUq+tOvWZTX1iTC62dGCw8tS1Tawz7StXXWUJBow=;
        b=OAHpv2sC74xYtK7Xb0MxTnMZXhNCPvr5e5pBtGJRmjeJlqY6rHJaEE4yL1hu1z6IZu
         dFyUbOyyxj7OLPnojhoX+UTzb9zQZ8uiAsrxzZu6USLFMAvEknD6gBYUG5AzQg49FulN
         8qiEu/iYD2aUDeE5Vs/GK5UEdMFYFor271iX4sGEAvzUChWjhlTJxuf6EnImeqMYEObO
         g2jTu1v8VQHGWTr74qcswrFPZ4uvyKZFOf/uigJIUFYlphLrmpQREbRpdqQF08UspHPC
         zOrVLnf+iJWQwZNC2dcXcw9Uk1KWRlGaAHz2aKn7r+PwyntXykUbJnLn3BQLZ9wbQV1Y
         RPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlbzUq+tOvWZTX1iTC62dGCw8tS1Tawz7StXXWUJBow=;
        b=t7sR4/5iDgcZmBfWfgXMf7UDBtAi+rXS2PoCyW1+zYkfLzTckWn8WLZfc4y7MgbLqS
         vPlpf9lh5xRSr1H+zn3JMzI4s05bJP6fF1BV0un46MUiNF/jNyvYGqLe/KHBGZD1U9Fj
         M18/jwSGKkcrTl+z5CQjd6/bXQZxK2hwfPufi/dTfDjDUXkXPNAI/dBewbz7HnHEhBLf
         VA5f+MjKl+cRMvhZ23JaVrMwYsmvtSoMHrYJxwaQwoEJGmAmYjpuCxVXR0G6BsBDJOxl
         xrtAauVrbBkxw44QS8dmz5JODSaEs5lO7XhXlxUXTiJSS9IdhO9oMTyWd7t0OtLP76D5
         Q0DQ==
X-Gm-Message-State: ANoB5plnHUW6lR+cwD1VONfPZQzH1d/fP2GeBQEGZV7YbFoSGiZeNoKY
        1XiFVQngvmdqKJn90aCd9Q4fPA==
X-Google-Smtp-Source: AA0mqf4INakKd3LZMtzDYYR0L5yC7mvhNniVhImL4nXThcWEcwVIgzV3XwS24djEPGbC3exkq6EPgQ==
X-Received: by 2002:a05:6512:2812:b0:4b5:ab12:9acf with SMTP id cf18-20020a056512281200b004b5ab129acfmr8428468lfb.60.1671043260708;
        Wed, 14 Dec 2022 10:41:00 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a4-20020a056512200400b00498f00420e9sm892123lfb.194.2022.12.14.10.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 10:41:00 -0800 (PST)
Message-ID: <c90f6017-b757-f514-a6c4-1fd0f010a2e7@linaro.org>
Date:   Wed, 14 Dec 2022 20:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 1/6] drm/msm/dpu1: Implement DSC binding to PP block
 for CTL V1
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jani Nikula <jani.nikula@intel.com>,
        sunliming <sunliming@kylinos.cn>,
        Sam Ravnborg <sam@ravnborg.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221213232207.113607-1-marijn.suijten@somainline.org>
 <20221213232207.113607-2-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221213232207.113607-2-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 01:22, Marijn Suijten wrote:
> All V1 CTL blocks (active CTLs) explicitly bind the pixel output from a
> DSC block to a PINGPONG block by setting the PINGPONG idx in a DSC
> hardware register.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  3 +++
>   .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |  9 +++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c    | 27 +++++++++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h    |  4 +++
>   4 files changed, 43 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

