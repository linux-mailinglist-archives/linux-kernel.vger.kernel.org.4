Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC49F64CFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLNSxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbiLNSxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:53:00 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421562934E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:52:57 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id z4so7583600ljq.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZseIU9pUHVwznNtxNlFxx+0mTPXyTHR3NZJ8jxTNHvY=;
        b=r/gW/N2Pnn4oZW8y86l9QHLF343OH2bshWe8KXeJ0yZ3tWuEcwyRugUz0q4xtyDE1o
         cGWrdvNidcO9AiiaboC+4oTdrw+29Bm8FDdoRZXbnfjdJe/Cto/H5RvQTS58jWylWX1K
         SZyM5/ZHedIIs3MDjXFzCk0B7wntCny+eUl+Ui6cx07xFFqOwCK5W5X3zQtJx14x6c5i
         YeU0DexZQtJfMT/w2tCslRmgsZAtV681kCGIU/1Jo03bVYZna9POL3J0x1noKdjgocZR
         n4ncmQzYUp/aBrcoiU+A5tP3hxbdzICfzSi+O/oP9XMIs4Q5OU5ERsgBzeRc3xmu/JCn
         wVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZseIU9pUHVwznNtxNlFxx+0mTPXyTHR3NZJ8jxTNHvY=;
        b=tggM9Bj0uOFjV9ZdFpfB3d98kDlBTzavVH8lKGKDsn4f1qTejobWoSvbSqjxCCR30+
         dYRal4zGCNnqyeR5t92HWEQGlkTYJAiAcpbx6NyQVr8zWG7PRfc2gK0+YsyTDWXEzDmt
         IfC0/n6Ea0VK6h/ik3nAPPzG1rTXNa8EuBX9CEi1QebK99T5wedJGA/JFJgu//P0pnhk
         jJcJRbgXB9XVemXkBCXDt3/RwGK3V2S7FfOkfblu75i2EnTaV1Oz9HhbCmOTt922SjKb
         ng+t9EAQobHmfn1cNa15CX+NmPfltfT1CtdXDJ/6CFQkt1CnmpJ/zNYwbEZpqBK9C4Lo
         2Jqw==
X-Gm-Message-State: ANoB5pkZUdX24hawic9FS7UT5nOiTtcfyGMewK2uXtFGr2mHf06ODyiu
        k5wnO6ti3TVQDnKwIW+2WZQT3g==
X-Google-Smtp-Source: AA0mqf7ZgNkE56lYnu/RzMo2/dyqB/FcOcbFfYQFPy+YE495hfWhIWasUAYLlY1RxV/76aJczrI/Tw==
X-Received: by 2002:a05:651c:178d:b0:26f:e87b:d3bd with SMTP id bn13-20020a05651c178d00b0026fe87bd3bdmr8121650ljb.39.1671043975587;
        Wed, 14 Dec 2022 10:52:55 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id q20-20020a2e9694000000b002770eafaafbsm695766lji.99.2022.12.14.10.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 10:52:55 -0800 (PST)
Message-ID: <ca33cb5d-363d-dddd-4ad9-62f8a2d87bb1@linaro.org>
Date:   Wed, 14 Dec 2022 20:52:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 4/6] drm/msm/dsi: Use DSC slice(s) packet size to
 compute word count
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
 <20221213232207.113607-5-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221213232207.113607-5-marijn.suijten@somainline.org>
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
> According to downstream the value to use for WORD_COUNT is
> bytes_per_pkt, which denotes the number of bytes in a packet based on
> how many slices have been configured by the panel driver times the
> width of a slice times the number of bytes per pixel.
> 
> The DSC panels seen thus far use one byte per pixel, only one slice
> per packet, and a slice width of half the panel width leading to the
> desired bytes_per_pkt+1 value to be equal to hdisplay/2+1.  This however
> isn't the case anymore for panels that configure two slices per packet,
> where the value should now be hdisplay+1.
> 
> Note that the aforementioned panel (on a Sony Xperia XZ3, sdm845) with
> slice_count=1 has also been tested to successfully accept slice_count=2,
> which would have shown corrupted output previously.
> 
> Fixes: 08802f515c3c ("drm/msm/dsi: Add support for DSC configuration")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

