Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367AA70A43B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 03:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjETBS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 21:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjETBSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 21:18:54 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD6B1B7
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 18:18:52 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2af225e5b4bso18063301fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 18:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684545531; x=1687137531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQeGWuW8RcPla1MeSBzNJGfr9g0lsAtcWxD6c9UFs98=;
        b=hTtCjc7O5oTR1ftdHf2UZ4g2m3ZmcB+HMAAdY4R4wijTwQl//sNkm18HJt9V6HvP3+
         qWB10B5bbVifvIm+cvM6CQxb9F1YjSFWQQLd6y6O+a0XrXAvTHzilOVwDj/iu7UWNfez
         XCDWiJn4cdsJJzz/KCVSVinL+J+lzEFWHJ1DlGs3cG6IrvbwXYQPnNKo1ZeAJzxoZeSI
         +I1YRiW6A1YArltMc0MVVTNR6/zl4ztl881mS/gn6lv7FNPEZCt+YECQzxcn8rcMAz8Z
         B3lZBEv7f0Ie2OHyhwtPCOtHgJnpulRe7RxzbTzGX0qeEgpR0FUOWuUl231igBSdP80x
         6iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684545531; x=1687137531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQeGWuW8RcPla1MeSBzNJGfr9g0lsAtcWxD6c9UFs98=;
        b=GrhMGg9Q+jKZ9PTPS3O4LaMuUJJ01DozAMIYCjfwdLOu0K6Ek1XYIQO/UkFPX2P6uT
         fBAFFkenT32LGrA3kAZY7Somz1FjjdSkW79ya8Ef5dXd7tB0oDL2vKcb6nv7ekbC3Jxg
         nKxpuUBPZNkFJLoi0Ii9YEeqgsmOsMDNEQ5/9OJnZB4EZwQv8KpGLwL04QC2SGXpuJMQ
         5axuJeDVN4KCVvyrgFl7V/1yfYQU/oh44hAF8sK+i0MCdcnGiT3lu0+Y17Y1XTQbXHS5
         +M6ZSU0PwKsMa0nWOlxft3k1/d7bDzol/4CQXBYUhW+FGmbLWuL45YbV6p55lBLvGj9U
         Kq0Q==
X-Gm-Message-State: AC+VfDwjKMezyDuPQt5zG6sqP6matMmwLU9kEzGti3sJO3GksTHu3NVJ
        zl3xD0Xes0vd8zc+vE0aHshdGw==
X-Google-Smtp-Source: ACHHUZ4nWlf1P1MoPeTL7kAFyzkQHlLj8djlYxph5xL2WpK5rj3dqdtDO2ujXNAkWiZVCdilAvLr5A==
X-Received: by 2002:a2e:92cd:0:b0:2a7:a30e:d11b with SMTP id k13-20020a2e92cd000000b002a7a30ed11bmr1595802ljh.7.1684545530859;
        Fri, 19 May 2023 18:18:50 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id n18-20020a2e9052000000b00295a3a64816sm76710ljg.2.2023.05.19.18.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 18:18:50 -0700 (PDT)
Message-ID: <bbdced3e-b7be-493c-e6a8-4aba3aa2d09d@linaro.org>
Date:   Sat, 20 May 2023 04:18:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] drm/msm/dp: Drop now unused dp_hpd module
Content-Language: en-GB
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
References: <20230515030256.300104-1-quic_bjorande@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230515030256.300104-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 06:02, Bjorn Andersson wrote:
> The dp_hpd module is a remnant from the downstream design and is now
> completely unused. Drop it and all references to it.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_debug.c   |  8 ++-
>   drivers/gpu/drm/msm/dp/dp_debug.h   | 12 ++---
>   drivers/gpu/drm/msm/dp/dp_display.c | 35 +------------
>   drivers/gpu/drm/msm/dp/dp_hpd.c     | 67 -------------------------
>   drivers/gpu/drm/msm/dp/dp_hpd.h     | 78 -----------------------------
>   drivers/gpu/drm/msm/dp/dp_panel.h   |  1 -
>   6 files changed, 11 insertions(+), 190 deletions(-)
>   delete mode 100644 drivers/gpu/drm/msm/dp/dp_hpd.c
>   delete mode 100644 drivers/gpu/drm/msm/dp/dp_hpd.h

I think this is not complete. Could you please check if 
https://patchwork.freedesktop.org/patch/433883/?series=90198&rev=1 works 
for you?

-- 
With best wishes
Dmitry

