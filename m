Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDE6ED836
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjDXWzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjDXWzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:55:04 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB1A7AA3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:55:03 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54fb9384c2dso59946627b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682376902; x=1684968902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=urRO9IkUTIq77dWBTXZerCEWau63FaL24inu94rfVRU=;
        b=Fj1zGw/wYbq+07TYyjORi45sEzGM7qvwbMznjo8nS4KsNBNm4YzAM1V+WPLq9gsxuI
         kh0qqol2A8VD75bHUtunyouL5wqCJvHHLwdZ2kIqA9ySn3bhEWrKjlYZtsHegztjKUek
         La5Yx4yKHV6f5OaZKYUZYPBhjeDEdOVk/Gs+Rw/cLwqKZlSO8OMPqhHjnwHSFZ35IxhL
         x2DB+Z6QIgVqv2TvjEjVPJdV6A6Ddflyu/S5QJIuXqvqKaim8U35+mA9wGz96CbIQvgW
         ihtl8N66kc1MVo+ymSNznW98yAKPwYpwDXFDxdxqpYnHXHepsGxigg4Io8lpVJAtAyAA
         ICVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682376902; x=1684968902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urRO9IkUTIq77dWBTXZerCEWau63FaL24inu94rfVRU=;
        b=kckc5BCcp2cSusQTw6IcWpUZvqdz+1DzB5yRVamiHZe9NLesRdHfxchU79FEV0xOWk
         cHbDaJF2icWC82QCbCwkAdusFMUt/7xK9Oa5KHgZpv+Uzl2472BuOVIrCaJOzFSgwOwb
         rsb1LfkQ8NLMFupJNs8nxhKNI7gzQ2GKJEm7k044wussxS2Ru6ITeypqNtgMLBpq/YiA
         Jn0Pvbn+5aOsOOApFnEFTBfFrcyMnZwZzdICWO06jQ28xq7NdeFrWPS97NofnSVNnCrv
         8O5h2Pe3N+C7/zuMFwp8aEB7vdDzM36xnDsLJdd8Yd20GpKGJMdDsB/g8896veAm89gd
         cVUA==
X-Gm-Message-State: AAQBX9fPWQfQaat40qVgnKTQtNZTyUGjOl5qqLM/3YgzPqUlBe2EHRjf
        NM5MSi4Ef9k0iuhI6TInUx8qRW4MQj64eUWNVXCYVw==
X-Google-Smtp-Source: AKy350a7hTDcEHQz7tXIlrO4+/3AZkbk17Ezhn1rQv8pT/D+TxdwqMjvZ14uStOuiJ4HRFQt0n/D+sMyLS5x0fXlnIs=
X-Received: by 2002:a81:4e10:0:b0:54c:16e:6581 with SMTP id
 c16-20020a814e10000000b0054c016e6581mr9732607ywb.37.1682376902478; Mon, 24
 Apr 2023 15:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230418-dpu-drop-useless-for-lookup-v2-0-acb08e82ef19@somainline.org>
 <20230418-dpu-drop-useless-for-lookup-v2-3-acb08e82ef19@somainline.org>
 <50d22e0c-84b3-0678-eb06-30fb66fd24cf@quicinc.com> <ymq4kstme55dm3j5kr6trevnwdelhjq7e7m4yky6zcbnf7auid@66l7inxz4oq2>
In-Reply-To: <ymq4kstme55dm3j5kr6trevnwdelhjq7e7m4yky6zcbnf7auid@66l7inxz4oq2>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 25 Apr 2023 01:54:51 +0300
Message-ID: <CAA8EJprYQUFER6x1+ucHX_Ze2uqWc6xoEaYDdJ1s0jgZjPJ0QQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/msm/dpu: Pass catalog pointers directly from
 RM instead of IDs
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 at 01:03, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2023-04-21 16:25:15, Abhinav Kumar wrote:
> >
> >
> > On 4/21/2023 1:53 PM, Marijn Suijten wrote:
> > > The Resource Manager already iterates over all available blocks from the
> > > catalog, only to pass their ID to a dpu_hw_xxx_init() function which
> > > uses an _xxx_offset() helper to search for and find the exact same
> > > catalog pointer again to initialize the block with, fallible error
> > > handling and all.
> > >
> > > Instead, pass const pointers to the catalog entries directly to these
> > > _init functions and drop the for loops entirely, saving on both
> > > readability complexity and unnecessary cycles at boot.
> > >
> > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > Overall, a nice cleanup!
> >
> > One comment below.
> >
> > > ---
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c        | 37 +++++----------------
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h        | 14 ++++----
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c        | 32 +++---------------
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h        | 11 +++----
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c       | 38 ++++-----------------
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.h       | 12 +++----
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h |  2 +-
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c       | 40 ++++++-----------------
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h       | 12 +++----
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c         | 38 ++++-----------------
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h         | 10 +++---
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.c    | 33 +++----------------
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.h    | 14 ++++----
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c   | 33 +++----------------
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h   | 14 ++++----
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c       | 39 ++++------------------
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h       | 12 +++----
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_vbif.c       | 33 +++----------------
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_vbif.h       | 11 +++----
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c         | 33 ++++---------------
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h         | 11 +++----
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c           | 17 +++++-----
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c            | 18 +++++-----
> > >   23 files changed, 139 insertions(+), 375 deletions(-)
> > >
> >
> > <snipped>
> >
> > > -struct dpu_hw_intf *dpu_hw_intf_init(enum dpu_intf idx,
> > > -           void __iomem *addr,
> > > -           const struct dpu_mdss_cfg *m)
> > > +struct dpu_hw_intf *dpu_hw_intf_init(const struct dpu_intf_cfg *cfg,
> > > +           void __iomem *addr)
> > >   {
> > >     struct dpu_hw_intf *c;
> > > -   const struct dpu_intf_cfg *cfg;
> > > +
> > > +   if (cfg->type == INTF_NONE) {
> > > +           pr_err("Cannot create interface hw object for INTF_NONE type\n");
> > > +           return ERR_PTR(-EINVAL);
> > > +   }
> >
> > The caller of dpu_hw_intf_init which is the RM already has protection
> > for INTF_NONE, see below
> >
> >          for (i = 0; i < cat->intf_count; i++) {
> >                  struct dpu_hw_intf *hw;
> >                  const struct dpu_intf_cfg *intf = &cat->intf[i];
> >
> >                  if (intf->type == INTF_NONE) {
> >                          DPU_DEBUG("skip intf %d with type none\n", i);
> >                          continue;
> >                  }
> >                  if (intf->id < INTF_0 || intf->id >= INTF_MAX) {
> >                          DPU_ERROR("skip intf %d with invalid id\n",
> > intf->id);
> >                          continue;
> >                  }
> >                  hw = dpu_hw_intf_init(intf->id, mmio, cat);
> >
> > So this part can be dropped.
>
> I mainly intended to keep original validation where _intf_offset would
> skip INTF_NONE, and error out.  RM init is hence expected to filter out
> INTF_NONE instead of running into that `-EINVAL`, which I maintained
> here.
>
> If you think there won't be another caller of dpu_hw_intf_init, and that
> such validation is hence excessive, I can remove it in a followup v3.

I'd prefer to see the checks at dpu_rm to be dropped.
dpu_hw_intf_init() (and other dpu_hw_foo_init() functions) should be
self-contained. If they can not init HW block (e.g. because the index
is out of the boundaries), they should return an error.

>
> - Marijn
>
> > >     c = kzalloc(sizeof(*c), GFP_KERNEL);
> > >     if (!c)
> > >             return ERR_PTR(-ENOMEM);
> > >
> > > -   cfg = _intf_offset(idx, m, addr, &c->hw);
> > > -   if (IS_ERR_OR_NULL(cfg)) {
> > > -           kfree(c);
> > > -           pr_err("failed to create dpu_hw_intf %d\n", idx);
> > > -           return ERR_PTR(-EINVAL);
> > > -   }
> > > +   c->hw.blk_addr = addr + cfg->base;
> > > +   c->hw.log_mask = DPU_DBG_MASK_INTF;
> > >
> >
> > <snipped>



-- 
With best wishes
Dmitry
