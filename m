Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956B265A9FC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 13:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjAAM1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 07:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAM1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 07:27:39 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51702718
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 04:27:38 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-4a0d6cb12c5so30306187b3.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 04:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2bWIRx0OjUiiIyER71vIk1rtm1u64tQPJZk2feH605U=;
        b=TluG41Rwc+6pjqk30yxZybimGt7+O6R3MyNiv699OFH83tN10SaLOwYpWTdQ7AWgLS
         EATAkvwk3w+1SThVegNvSV1VPnkjnECmkS4ahcCnfTvIP8QfBYgW/Ia4ZRcA6Bqv8egE
         PEJfcqX/UDVfBl9JyJiUN+7IiIVLZ+0hZDrgq4AdDU7rpmY94WjS4m8euscKNFlEGgwb
         yRfJycNDBK+sRp2RfjN9aPZRGiGGDq2Ni3wozwXNsuEkagQreBC1nRdZINZhht5wa4eO
         P+NCQXiQY5BeMy5+j/LZjh8NCzOcUL0XR8c+V4980ORW0CQYlAqusTFgTJ7lqlgKlt9f
         XJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bWIRx0OjUiiIyER71vIk1rtm1u64tQPJZk2feH605U=;
        b=ThCK1y+KCnfwd/Mv0wgQCt/IW6Wj+edwyUoHs7s0lpMmxW7nU65snk+3gzvmh2g8Bm
         v090OMQKyOvxvqFn+Z2fgkdMx5QinSTxfln/i9+FNjmPHyZuMoXxoAOmRDuJVX4W9mNO
         zgyyUOGIqh9x1XWZfNSNPrTzcz5hod2+7c/N8VW2l+mh1fvSAVu/A+tG25UdKSABEVQs
         aNbdOeGXGvdImhBPjb0DknCjJj0u+R2vKEIBZcblpqbo0l1m8q/nvi6boz6JcOoLuTL5
         RLnkY1quKPdgMzgMbdR73jx4XmAvQK0IMfOQZ2D5ibUQMTK87AlKQfG+SyzTx5MuEML9
         gX5A==
X-Gm-Message-State: AFqh2krXs4E9K/PEdoiRRi0yRwSZ1T5jRszp8ZaIIosCRvohJNRM56W4
        U6aiThkAr0Xxgso7y7DVCMCV2K3UgsQKF8LuGzuUGQ==
X-Google-Smtp-Source: AMrXdXvMw65HDtWFdqX2AnBda4/ddwCGwlF1XJLicIXoOn/3Sx6jOAd2wcSVV/Qr+2ien1/O22ItMviPcZfEztg61OQ=
X-Received: by 2002:a05:690c:fd5:b0:4a4:7135:9214 with SMTP id
 dg21-20020a05690c0fd500b004a471359214mr210838ywb.378.1672576057902; Sun, 01
 Jan 2023 04:27:37 -0800 (PST)
MIME-Version: 1.0
References: <20221231215006.211860-1-marijn.suijten@somainline.org> <20221231215006.211860-8-marijn.suijten@somainline.org>
In-Reply-To: <20221231215006.211860-8-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 1 Jan 2023 14:27:27 +0200
Message-ID: <CAA8EJpraCLQpWn3PZLz9BGYrESVdWmHw0LpNtcx9ntQ_9=HgRg@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] drm/msm/dpu: Remove intr_rdptr from DPU >= 5.0.0
 pingpong config
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2022 at 23:50, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Now that newer DPU platforms use a readpointer-done interrupt on the
> INTF block, stop providing the unused interrupt on the PINGPONG block.
>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
