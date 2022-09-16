Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06985BB01D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiIPPV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiIPPVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:21:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD5AAA4DF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:21:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sb3so20541026ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=FAZ1nZoda0LvxFO03fEct6+OY7sOs5EIJLDowUOvXx4=;
        b=i3EM54wqEUd4S0hEjrVzr83R6YfecGIo0DsXnpvu9Xi5oB1vfFa8ZVBK2Is2icTZWm
         X5hso/7NBeg9mGUsZNtQzLp7jv/OTgknKbmhMgB4znO6wmSipfbNDVNKwdd/spAXbwL4
         yVQWrtWpdhgdoaYh5zmlRXLyokBMUZXmQlOnKfqultK8EcRuQ5lTU9qONFYronuMziCP
         La1Rml9QYllS1G3sqFsNVEpqcaF3HSK2nY1c5Wpgt8fVVo6YBLBTBCUkP+xZHDWYy2Ds
         SzQjOdH8HgLucw29Hg2ugKqSYNh6Ewx+S0j0u+0N/4IHqbsTwuk8ffu8qg4/Z0N2pqzS
         gv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FAZ1nZoda0LvxFO03fEct6+OY7sOs5EIJLDowUOvXx4=;
        b=49p9s5/y45TKSv912kDg1ZBST+r9RVPJh+T9wRKLV/4rIAePzkVoXZMK/av6P7NV0D
         XbpvR+BRmrXyzOQpaHistrWgK6RGF83KsrD5BZ29oxlQDFZOV1QMjS7rPoBI883gB++k
         i2XIppt549nhqjriXAMvlqArWixNFqNwraI9fe22IXp5IGfcItxzzwfYeMjrpoCFYoTP
         2kRrTLzeU+7BjYc2MKAWjCMbzdtn7/j3oG68xbWJmI3wOtwmKvyJsSpPb0WWP1E+nGag
         WCyv2CfF5pfS0Ugn2xethHMB1k5/cm2aE0Yn+HZWTEXhadtp5DKVelbMQ4NyAilSHwgx
         FOCw==
X-Gm-Message-State: ACrzQf2Y6917Ywhn0FdrfKDv9Pzl0sL4EhaWr4GfFrlKaCBasOOZXKdS
        UNCkfhPogxWBvV1n0I4O9asiBziroxP/4/4n09g=
X-Google-Smtp-Source: AMsMyM7VdObrUWQ3oMSH0uIBXnSpYn73/MNnHRJRFIMKRcnMR0VWDex5xXR94UsnsJLt5amN0/PYib0/nXhnk1LrGNk=
X-Received: by 2002:a17:906:8a77:b0:780:a02d:ca4a with SMTP id
 hy23-20020a1709068a7700b00780a02dca4amr2762440ejc.488.1663341707544; Fri, 16
 Sep 2022 08:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAJedcCxVW++iH49UFZp9ruUuTcNubWCH6Wsqe11K4COB3E8msg@mail.gmail.com>
 <CAJedcCw1eJqjSK+yR7eQMDheNtH3Mjm+viwt00xAhnmrfpq2pw@mail.gmail.com>
 <CAJedcCweHjD78F7iydiq6Xc2iH=t_3m=H9JKnaCooToUk32FvQ@mail.gmail.com>
 <YxWtfjfpNsoPUrgh@kroah.com> <CAJedcCzMo51aiy=Dv7zn7VmL3gwkw7JgzwAPAB2Z27C9CnhoYA@mail.gmail.com>
 <20220907030754.GU1089@zhen-hp.sh.intel.com> <CAJedcCxO_Rq0qMeLiHtY5+FuN1A1pDGsZd3gMtvUpm1xbAK3aA@mail.gmail.com>
 <Yxmzj2nCoTKurCY8@kroah.com> <CAJedcCwVC6Rg+wF7h6GhFvL6BGkKV=DS9Mo9fOf-gfDAk9VqPg@mail.gmail.com>
 <CAJedcCxRQ4h-ChNsD4OWpDMUJd3JNaQrvD=uVKxMpYONGFUgzA@mail.gmail.com> <YyQzDlM5n7mOLh5Q@kroah.com>
In-Reply-To: <YyQzDlM5n7mOLh5Q@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 16 Sep 2022 23:21:35 +0800
Message-ID: <CAJedcCy-beMX=ytszAWMu28FH0qGKCsLC=0bJPL_Tmh35wigKw@mail.gmail.com>
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

Hi greg,

Thanks for pointing that out. Working on it now :)

Best wishes,
Zheng Wang

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B49=E6=9C=8816=E6=
=97=A5=E5=91=A8=E4=BA=94 16:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Sep 16, 2022 at 02:39:21PM +0800, Zheng Hacker wrote:
> > >From 8d95c1399e3ff345500a575e21254a73b0c89144 Mon Sep 17 00:00:00 2001
> > From: xmzyshypnc <1002992920@qq.com>
> > Date: Fri, 16 Sep 2022 14:37:48 +0800
> > Subject: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_ent=
ry
> >
> > There is a double-free security bug in split_2MB_gtt_entry.
> >
> > Here is a calling chain :
> > ppgtt_populate_spt->ppgtt_populate_shadow_entry->split_2MB_gtt_entry.
> > If intel_gvt_dma_map_guest_page failed, it will call
> > ppgtt_invalidate_spt, which will finally call ppgtt_free_spt and
> > kfree(spt). But the caller does not notice that, and it will call
> > ppgtt_free_spt again in error path.
> >
> > Fix this by only freeing spt in ppgtt_invalidate_spt in good case.
> >
> > Signed-off-by: xmzyshypnc <1002992920@qq.com>
> > ---
> >  drivers/gpu/drm/i915/gvt/gtt.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/=
gtt.c
> > index 9f14fded8c0c..31d2a8d56384 100644
> > --- a/drivers/gpu/drm/i915/gvt/gtt.c
> > +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> > @@ -959,7 +959,7 @@ static inline int ppgtt_put_spt(struct
> > intel_vgpu_ppgtt_spt *spt)
> >   return atomic_dec_return(&spt->refcount);
> >  }
> >
> > -static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt);
> > +static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *sptm,
> > int is_error);
>
> Your patch is whitespace damaged and linewrapped and can not be applied,
> and can only barely read :(
>
> Please fix up your email client to not do this so that the change can be
> properly reviewed and accepted if correct.
>
> thanks,
>
> greg k-h
