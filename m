Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BC5662123
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbjAIJNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbjAIJLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:11:55 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AAF1706C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:08:21 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id e76so7876823ybh.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WyzaMNbovLz5e0f2Pj2AVJV48B77i8KtmFksLIp0GoE=;
        b=iXGaRlr7cxQs3VBPA8A5uTISSRojwoueFyMX7G6tweRggPW+GPYeqDgsqNkHStZSQJ
         t6Cgb20KuNRVfq5lvZF/plnYMCuKLDkpaeywH75qWRo7V9ccg3wOkmrRfDDE3tvSUFMu
         jgtXkleXxqKNPndI7DJvBLsxqWl4g2EfeSGHoZbFWP1ctsTp7T2IfaRsnfUYVGlO/hww
         aySl2ma/XK1VvC1Z5DXbs7qRrpNqAK6ralW1vU2H5Uem+UGGXgxHVAlh28GCMPopYRyA
         Y0Q6Qj+lIHE4kS6bCir36+Frf1wnEXF927Xcbv4XGk7vGi5VxpuOt4NJYOzTFrv30xgJ
         zXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WyzaMNbovLz5e0f2Pj2AVJV48B77i8KtmFksLIp0GoE=;
        b=l+bYZvoGDyg1fE+IYdu8UIek1oQSto3Nkr6Ca+D8dBX3wZFyDUxu+uHu9riGfyZai9
         oTbWopLU4tj1j9F0+sjPlYYsJ6L4lFNo19sPwA2eWsi058lcc/ibMvvt4gk5a8ZMYBnO
         0u0RcQs37RYroBKURyYmK3O1PWJ4cp0Q5n7FsQqf+a/yBLXTphM2G+fDC27xRibtKOp8
         ooa+sj0KNw+AYweGxpZbnB+cAxjtMRT46Y2eEu9saE+JYVINf2M41TGQiHtnoNfzsd4J
         qU+vXLoZOQjhxpZhj6jBSPF1GiXNOrhz9mtZUFqC+at8DkCDXjkZMxlk+fnpLtQ7NT54
         0qPg==
X-Gm-Message-State: AFqh2kovf35s2S1O+S1JLg4wc68cn78X4uThpqqR8GOeltDUgVv8U0cl
        Hz3x4s36l9lPIm0Vkgff7kfc5wmxs3hB2np5/VUn9A==
X-Google-Smtp-Source: AMrXdXv7heUksktJrLuJT2/sl9qccUjvu0Os6fLmv3Ph8ZSTHk+gDOCAM7/Xr9au1wvH0fDjgfiSNEu1ReJh6u/Mtxo=
X-Received: by 2002:a25:e90c:0:b0:73a:3b94:47fc with SMTP id
 n12-20020a25e90c000000b0073a3b9447fcmr7036713ybd.152.1673255300641; Mon, 09
 Jan 2023 01:08:20 -0800 (PST)
MIME-Version: 1.0
References: <20221221231943.1961117-1-marijn.suijten@somainline.org>
 <20221221231943.1961117-7-marijn.suijten@somainline.org> <42b45762-7fb9-2694-9fab-039ee09e4709@linaro.org>
 <20230109082118.v2abyucljztsflxj@SoMainline.org>
In-Reply-To: <20230109082118.v2abyucljztsflxj@SoMainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 9 Jan 2023 11:08:09 +0200
Message-ID: <CAA8EJppTfJ6LnTEUWVASk1U6v3OX3MH71vuOhUk_Aa_HoraQ_w@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] drm/msm/dpu: Remove num_enc from topology struct
 in favour of num_dsc
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 at 10:21, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2023-01-09 01:31:57, Dmitry Baryshkov wrote:
> > On 22/12/2022 01:19, Marijn Suijten wrote:
> > > Downstream calls this num_enc yet the DSC patches introduced a new
> > > num_dsc struct member, leaving num_enc effectively unused.
> > >
> > > Fixes: 7e9cc175b159 ("drm/msm/disp/dpu1: Add support for DSC in topology")
> > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > ---
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 9 ++++-----
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 4 ++--
> > >   drivers/gpu/drm/msm/msm_drv.h               | 2 --
> > >   3 files changed, 6 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > > index 9c6817b5a194..a158cd502d38 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > > @@ -579,19 +579,18 @@ static struct msm_display_topology dpu_encoder_get_topology(
> > >                     topology.num_dspp = topology.num_lm;
> > >     }
> > >
> > > -   topology.num_enc = 0;
> > >     topology.num_intf = intf_count;
> > >
> > >     if (dpu_enc->dsc) {
> > > -           /* In case of Display Stream Compression (DSC), we would use
> > > -            * 2 encoders, 2 layer mixers and 1 interface
> > > +           /*
> > > +            * In case of Display Stream Compression (DSC), we would use
> > > +            * 2 DSC encoders, 2 layer mixers and 1 interface
> > >              * this is power optimal and can drive up to (including) 4k
> > >              * screens
> > >              */
> > > -           topology.num_enc = 2;
> > >             topology.num_dsc = 2;
> > > -           topology.num_intf = 1;
> > >             topology.num_lm = 2;
> > > +           topology.num_intf = 1;
> >
> > Unless there is a reason, please move num_intf assignment back while
> > preparing v3.
>
> The assignment was reordered to match the order described in the comment
> right above, such that this reads more naturally.  Not sure if it's
> worth sending that as a separate fix, or drop it entirely.

I see. Sounds logical then. Let's keep it as is.

>
> > With that fixed:
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> <snip>



-- 
With best wishes
Dmitry
