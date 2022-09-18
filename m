Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30AD5BBF15
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 19:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIRRSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 13:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRRSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 13:18:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D264014D13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 10:18:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dv25so59505598ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 10:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=g4F1o3OxSkwyGTECuVsvCx/NyKOfCc+oSSw810FYyjo=;
        b=QRI+Gv16BKwthqTnKwPsBDdooKTjM+DS7nip1lJfY2cXjnp9bXM7B5srbbWQfzwvZq
         6b1hFUUW2uA2q7mXcES+P3JE+k3JfuUqCcJRGBX+G3zNRSGmbwor7FWwVqwXsO8fCOW3
         CMClGqb+UufxwVMtPsNAMA6LAST4e4eAXpGMWMmVbg6/aoRbs4MdD4niSj91wYjGx65R
         NvioDgl8yvTaTtRrImg3+XY3r2Znk8hn9RBeSy4RCCfz40n8EuAguPScGLGLdT23kZtT
         f70JjP9kpn27sTJAwxM5Ua9R9sprHO8iWhmq+2KpidhCdijl1q92a66hURyO9Vq+5puo
         RJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=g4F1o3OxSkwyGTECuVsvCx/NyKOfCc+oSSw810FYyjo=;
        b=n6qXzcmPsJqCauc/uGDuF+pCeX6ikibW7y1Xzmap50A5FyuyGEjY8ezqmTTykVQT9D
         rG8neN0YR4BYtd9J9BETCpvfYShhG0Jnwuqoe7awxHOZMPndvn8VUTZeBC+tZwa5K8Vz
         30LpBXJuCE39CLqPsmbnqF1dP75/DLsosd7u1VhopenVb5583lhn6/8lGlCosDqvEhLQ
         D7umFdRdTIn+mMqiUEzkch2LebzwotZbVOoHuCgJ1NjxEXeFXz4gQx3vC7s4G8oR1Jc2
         /4aC8O2DhLSqIIF9pDUM/1Wasyp/8GyGWO3oOiGnnJk0rOVYUj+L7Qmoql50HZUKGJvc
         ujEA==
X-Gm-Message-State: ACrzQf3Bst3bghUewDJWMuJGmRE8MT+bVIKdIcpELSk5e8ACNn7XQmJN
        1TyjWeztF4l+SlAk1//LzexXz9vick2jkujpSxykgR0rmpg=
X-Google-Smtp-Source: AMsMyM475ieyAlM9tDvO7b8MM84jCL/RawZkh8FJpEdvGHaOF7Cv/ooAmlyexeixIRJWEQmCGIcJ4jH/Wuv3bq0DKao=
X-Received: by 2002:a17:907:3f09:b0:780:330d:d907 with SMTP id
 hq9-20020a1709073f0900b00780330dd907mr10763664ejc.23.1663521492233; Sun, 18
 Sep 2022 10:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJedcCweHjD78F7iydiq6Xc2iH=t_3m=H9JKnaCooToUk32FvQ@mail.gmail.com>
 <YxWtfjfpNsoPUrgh@kroah.com> <CAJedcCzMo51aiy=Dv7zn7VmL3gwkw7JgzwAPAB2Z27C9CnhoYA@mail.gmail.com>
 <20220907030754.GU1089@zhen-hp.sh.intel.com> <CAJedcCxO_Rq0qMeLiHtY5+FuN1A1pDGsZd3gMtvUpm1xbAK3aA@mail.gmail.com>
 <Yxmzj2nCoTKurCY8@kroah.com> <CAJedcCwVC6Rg+wF7h6GhFvL6BGkKV=DS9Mo9fOf-gfDAk9VqPg@mail.gmail.com>
 <CAJedcCxRQ4h-ChNsD4OWpDMUJd3JNaQrvD=uVKxMpYONGFUgzA@mail.gmail.com>
 <YyQzDlM5n7mOLh5Q@kroah.com> <CAJedcCzt_1ZRV5egMLdoFVZ4hBDE+nDu9fLkBuGY0A=uYicvQA@mail.gmail.com>
 <YyWOh+jGvmSdrHqz@kroah.com>
In-Reply-To: <YyWOh+jGvmSdrHqz@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 19 Sep 2022 01:17:59 +0800
Message-ID: <CAJedcCwzgELQquRLc2deXt+E4X2D2-NMLERpE1z3sy21bTdddw@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_entry.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>,
        "security@kernel.org" <security@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        xmzyshypnc <1002992920@qq.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll try using another mail client like Mutt later. :)

Regards,
Zheng Wang

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B49=E6=9C=8817=E6=
=97=A5=E5=91=A8=E5=85=AD 17:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Sep 16, 2022 at 11:54:42PM +0800, Zheng Hacker wrote:
> > >From afe79848cb74cc8e45ab426d13fa2394c87e0422 Mon Sep 17 00:00:00 2001
> > From: xmzyshypnc <1002992920@qq.com>
> > Date: Fri, 16 Sep 2022 23:48:23 +0800
> > Subject: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_ent=
ry
> >
> > There is a double-free security bug in split_2MB_gtt_entry.
> >
> > Here is a calling chain :
> > ppgtt_populate_spt->ppgtt_populate_shadow_entry->split_2MB_gtt_entry.
> >
> > If intel_gvt_dma_map_guest_page failed, it will call
> > ppgtt_invalidate_spt, which will finally call ppgtt_free_spt and
> > kfree(spt). But the caller does not notice that, and it will call
> > ppgtt_free_spt again in error path.
> >
> > Fix this by only freeing spt in ppgtt_invalidate_spt in good case.
> >
> > Signed-off-by: Zheng Wang <hackerzheng666@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/gvt/gtt.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/=
gtt.c
> > index ce0eb03709c3..550519f0acca 100644
> > --- a/drivers/gpu/drm/i915/gvt/gtt.c
> > +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> > @@ -959,7 +959,7 @@ static inline int ppgtt_put_spt(struct
> > intel_vgpu_ppgtt_spt *spt)
> >     return atomic_dec_return(&spt->refcount);
> >  }
> >
> > -static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt);
> > +static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt, int
> > is_error);
> >
> >  static int ppgtt_invalidate_spt_by_shadow_entry(struct intel_vgpu *vgp=
u,
> >         struct intel_gvt_gtt_entry *e)
> > @@ -995,7 +995,7 @@ static int
> > ppgtt_invalidate_spt_by_shadow_entry(struct intel_vgpu *vgpu,
>
> Still line-wrapped and whitespace broken :(
>
