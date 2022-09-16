Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F005BA6F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiIPGkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiIPGkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:40:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A684627CD4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:40:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id lc7so47309986ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=7qw7zTJBliZzCUFRh7uRC/j1d4UKOuRGnko9pDRJCJg=;
        b=GQC1aj9JcqAr/n1JEaVzllQ+WJR4Y6kF3WvjxAzdbFAnpeTTyY8VaBTy2Ww15/PipO
         oB+ieOjKBoaaq21zkzgkX+hdS6ZYi/zxNPj1h3rCCYWNNtuORc2MviXxDJsbOwaYcZf/
         fBWWwQLZ6cgjypPruO4qjyolXKvYNPR1c3T3CbiqcFt66KpSm+3Vu5O9iOta1/wIqKxb
         zB5yW9qpfmG8ouAvKCygVtRUDxBfdDaGxDpzjOjY+W5U0STc9TJA002J/H6Rax3okGzq
         X3mSOmYIAfGufm0Vc6YaUqHj4XF+7YRNE2HtA+n0LSrU7iew8BoF0lqpU0n0m0LwhU4T
         mNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7qw7zTJBliZzCUFRh7uRC/j1d4UKOuRGnko9pDRJCJg=;
        b=sMze97kgc1r60SwHSdN05nREfjgXaGSfIMq7+O1A6OcRPRwpGLFacHDc/tbctBpsAb
         x+flxoPBVotCg6MxOCY3mUzBI9VVQ0xNejvauwsPG6pvZKDxtwb6zVy0b6cEqbHeaALI
         8OlFOqrJKy1RkciqD5xvGjS2QmvjFxG2NYI+Qn2D45b5eAOlETvEBlCiEIhZfb5S9PKg
         yyQ/OmE/zVIKyJlkA7pWFaZdCrbYkLB6TglRVAvV5p+KB7YKkTTbp/6QOVNErXFo7eQE
         Aj8Bzeishxjvmz1/BpvdILRIETv2/4h+Seyc2j3pBsytqKLGmchUrat/w+ReXWpCeAT8
         mgEA==
X-Gm-Message-State: ACrzQf3TlO7hY2XlivIf5i4coC0ydOKIlvRYEN5ErFM7fAQFK/xQX2zv
        1yvr6vbfUhGrAwbf53oyUzqNwvFAo6LBXDgQv89KmXs6EwBiOaQiJO4=
X-Google-Smtp-Source: AMsMyM6JajyBfscpsfrP8P1If2mpqnSWaqdzR5KjBSjX+DS0oFjEdifZTTOj406HyyX2HmVTTuBjFrAG3K6JuaTKc44=
X-Received: by 2002:a17:907:1de0:b0:770:8670:6a6a with SMTP id
 og32-20020a1709071de000b0077086706a6amr2613381ejc.588.1663310448243; Thu, 15
 Sep 2022 23:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_E1BBF05904DFB73C478DCD592740AAE0780A@qq.com>
 <CAJedcCxVW++iH49UFZp9ruUuTcNubWCH6Wsqe11K4COB3E8msg@mail.gmail.com>
 <CAJedcCw1eJqjSK+yR7eQMDheNtH3Mjm+viwt00xAhnmrfpq2pw@mail.gmail.com>
 <CAJedcCweHjD78F7iydiq6Xc2iH=t_3m=H9JKnaCooToUk32FvQ@mail.gmail.com>
 <YxWtfjfpNsoPUrgh@kroah.com> <CAJedcCzMo51aiy=Dv7zn7VmL3gwkw7JgzwAPAB2Z27C9CnhoYA@mail.gmail.com>
 <20220907030754.GU1089@zhen-hp.sh.intel.com> <CAJedcCxO_Rq0qMeLiHtY5+FuN1A1pDGsZd3gMtvUpm1xbAK3aA@mail.gmail.com>
 <Yxmzj2nCoTKurCY8@kroah.com> <CAJedcCwVC6Rg+wF7h6GhFvL6BGkKV=DS9Mo9fOf-gfDAk9VqPg@mail.gmail.com>
 <CAJedcCxRQ4h-ChNsD4OWpDMUJd3JNaQrvD=uVKxMpYONGFUgzA@mail.gmail.com>
In-Reply-To: <CAJedcCxRQ4h-ChNsD4OWpDMUJd3JNaQrvD=uVKxMpYONGFUgzA@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 16 Sep 2022 14:40:36 +0800
Message-ID: <CAJedcCya8SyN+k-JmPH1ep_i_rbtYyL47vvPG_3Rew6EvyADLg@mail.gmail.com>
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

Here I introduced is_error to judge if the ppgtt_invalidate_spt is
called from good case or not. Only free spt in good case, leave it to
handle for the error path of caller.

Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8816=
=E6=97=A5=E5=91=A8=E4=BA=94 14:39=E5=86=99=E9=81=93=EF=BC=9A
>
> From 8d95c1399e3ff345500a575e21254a73b0c89144 Mon Sep 17 00:00:00 2001
> From: xmzyshypnc <1002992920@qq.com>
> Date: Fri, 16 Sep 2022 14:37:48 +0800
> Subject: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_entry
>
> There is a double-free security bug in split_2MB_gtt_entry.
>
> Here is a calling chain :
> ppgtt_populate_spt->ppgtt_populate_shadow_entry->split_2MB_gtt_entry.
> If intel_gvt_dma_map_guest_page failed, it will call
> ppgtt_invalidate_spt, which will finally call ppgtt_free_spt and
> kfree(spt). But the caller does not notice that, and it will call
> ppgtt_free_spt again in error path.
>
> Fix this by only freeing spt in ppgtt_invalidate_spt in good case.
>
> Signed-off-by: xmzyshypnc <1002992920@qq.com>
> ---
>  drivers/gpu/drm/i915/gvt/gtt.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gt=
t.c
> index 9f14fded8c0c..31d2a8d56384 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -959,7 +959,7 @@ static inline int ppgtt_put_spt(struct
> intel_vgpu_ppgtt_spt *spt)
>   return atomic_dec_return(&spt->refcount);
>  }
>
> -static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt);
> +static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *sptm,
> int is_error);
>
>  static int ppgtt_invalidate_spt_by_shadow_entry(struct intel_vgpu *vgpu,
>   struct intel_gvt_gtt_entry *e)
> @@ -995,7 +995,7 @@ static int
> ppgtt_invalidate_spt_by_shadow_entry(struct intel_vgpu *vgpu,
>   ops->get_pfn(e));
>   return -ENXIO;
>   }
> - return ppgtt_invalidate_spt(s);
> + return ppgtt_invalidate_spt(s, 0);
>  }
>
>  static inline void ppgtt_invalidate_pte(struct intel_vgpu_ppgtt_spt *spt=
,
> @@ -1016,7 +1016,7 @@ static inline void ppgtt_invalidate_pte(struct
> intel_vgpu_ppgtt_spt *spt,
>   intel_gvt_dma_unmap_guest_page(vgpu, pfn << PAGE_SHIFT);
>  }
>
> -static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt)
> +static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt, int is=
_error)
>  {
>   struct intel_vgpu *vgpu =3D spt->vgpu;
>   struct intel_gvt_gtt_entry e;
> @@ -1059,9 +1059,11 @@ static int ppgtt_invalidate_spt(struct
> intel_vgpu_ppgtt_spt *spt)
>   }
>   }
>
> - trace_spt_change(spt->vgpu->id, "release", spt,
> + if (!is_error) {
> + trace_spt_change(spt->vgpu->id, "release", spt,
>   spt->guest_page.gfn, spt->shadow_page.type);
> - ppgtt_free_spt(spt);
> + ppgtt_free_spt(spt);
> + }
>   return 0;
>  fail:
>   gvt_vgpu_err("fail: shadow page %p shadow entry 0x%llx type %d\n",
> @@ -1215,7 +1217,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu *v=
gpu,
>   ret =3D intel_gvt_dma_map_guest_page(vgpu, start_gfn + sub_index,
>      PAGE_SIZE, &dma_addr);
>   if (ret) {
> - ret =3D ppgtt_invalidate_spt(spt);
> + ret =3D ppgtt_invalidate_spt(spt, 1);
>   return ret;
>   }
>   sub_se.val64 =3D se->val64;
> @@ -1393,7 +1395,7 @@ static int
> ppgtt_handle_guest_entry_removal(struct intel_vgpu_ppgtt_spt *spt,
>   ret =3D -ENXIO;
>   goto fail;
>   }
> - ret =3D ppgtt_invalidate_spt(s);
> + ret =3D ppgtt_invalidate_spt(s, 0);
>   if (ret)
>   goto fail;
>   } else {
> --
> 2.25.1
>
> Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=888=
=E6=97=A5=E5=91=A8=E5=9B=9B 19:59=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi Greg,
> >
> > I got it, Greg.
> >
> > Mid-Autumn Festival is coming and I will have a couple of days off.
> > I'll see what I can do after holiday :)
> >
> > Regards,
> >
> > Zheng Wang
> >
> > =E5=9C=A8 2022=E5=B9=B49=E6=9C=888=E6=97=A5=E6=98=9F=E6=9C=9F=E5=9B=9B=
=EF=BC=8CGreg KH <gregkh@linuxfoundation.org> =E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On Thu, Sep 08, 2022 at 05:09:40PM +0800, Zheng Hacker wrote:
> >> > Hi Zhenyu,
> >> >
> >> > This issue has been open for a few days. Could you plz write a patch
> >> > for that :) I'm not familiar with the logical code here.
> >>
> >> As this is only able to be hit in a theoretical system, it isn't that
> >> high of a priority, if any priority at all.  Why not try to write a
> >> patch for it yourself to help resolve the issue faster?
> >>
> >> thanks,
> >>
> >> greg k-h
