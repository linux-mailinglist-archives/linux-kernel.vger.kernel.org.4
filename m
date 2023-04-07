Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7CD6DB251
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjDGSBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjDGSBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:01:32 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18915FF0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:01:31 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-62751b6ef58so100657b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680890491; x=1683482491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q77ZcgCYnodZClKQX1HhPOSoqs2rfxGtOfBwRswul/4=;
        b=b8gKd+6rbeWwg8r+DFOMum1BwImUQSQAJBPrje68ohZORJXaU6x2Xjwzkhvjx0zkBd
         5h5bRrw74dAx8oRlL3w74Jr9fcAfAvcocqj/1iJERl3gENUbwc4NGQ55i5HQ+b+0ZP09
         0rez9y9Qa5huxDLtpYeke3L8uF9vTMjRiL+vSbvl9/TsWbbjtrZCUB3oXEknJi7Yhk47
         JXF9nbuPR2gdw5dq4TaBv2MF+VCKznTZ3GqXyMZ37PRQS5m96O2D+EIpIAaQFlYoGbdz
         WsWo06NQmP1P4MIKU9TIsU4519oxYzv7nhhKpZgz+FnI+GxMuVQaX78O9G7tHEuj/+r8
         t6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680890491; x=1683482491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q77ZcgCYnodZClKQX1HhPOSoqs2rfxGtOfBwRswul/4=;
        b=vHQv8FQNsQXQaoW+UKR/QVzHO4K88FG79iONmuHyxgq2n03RD0RXIulehgaXOuiYGX
         l/Sc4f1ZBtwViZK8toEoxLhrRiwVh/hb7BPxIGJvsPzaaNVDOg6esrb9k2yQ2IRF7Eno
         ORqiDcAdj3onzduO/YFjaQpWKOKuFmYkCOxGgcOmgIK781Fq1So2aDR5QUtuibjUeqm7
         eZMiM/rZ6a0d4ZbyRU1+f4uNknnTYV9I2QPN2ll/awGir8L4KPT6V6IFAsjrBpNCdEs9
         RDrwTU9p3Mb/TwmOnWi7JGQ11hmyt5AR8cjDc8MFbnBtozEsX211Xj/9NzoTr+N7QU4e
         sx/A==
X-Gm-Message-State: AAQBX9eYm8zP8bmW27Q16bNXBUeJdktEKlgiwoYTWcuYuYSseEE9c4VS
        kRcnMnoV+PR/UNfY6CUCmLRGGKnCIusY6JUrT3eQFPAvPSmKqggtpT/2MQ==
X-Google-Smtp-Source: AKy350ZHpTLUkU+XPnuqC13BzSbCyuTyl9RXM3G4Em3Qru7EkrOtM+34INuQ/mLJt+FyJN0GtVAS94TF68VaGc2rObc=
X-Received: by 2002:a05:6a00:2e28:b0:625:c55f:bc66 with SMTP id
 fc40-20020a056a002e2800b00625c55fbc66mr1615956pfb.4.1680890490979; Fri, 07
 Apr 2023 11:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230329231407.1816570-1-trix@redhat.com>
In-Reply-To: <20230329231407.1816570-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 11:01:19 -0700
Message-ID: <CAKwvOdnQCVZ+gqOWzsRvkSKbYFJdh5yAJEN-TT+7MC4e8tdu8A@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/svm: remove unused ret variable
To:     Tom Rix <trix@redhat.com>
Cc:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 4:14=E2=80=AFPM Tom Rix <trix@redhat.com> wrote:
>
> clang with W=3D1 reports
> drivers/gpu/drm/nouveau/nouveau_svm.c:929:6: error: variable
>   'ret' set but not used [-Werror,-Wunused-but-set-variable]
>         int ret;
>             ^
> This variable is not used so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouv=
eau/nouveau_svm.c
> index a74ba8d84ba7..e072d610f2f9 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -926,15 +926,14 @@ nouveau_pfns_map(struct nouveau_svmm *svmm, struct =
mm_struct *mm,
>                  unsigned long addr, u64 *pfns, unsigned long npages)
>  {
>         struct nouveau_pfnmap_args *args =3D nouveau_pfns_to_args(pfns);
> -       int ret;
>
>         args->p.addr =3D addr;
>         args->p.size =3D npages << PAGE_SHIFT;
>
>         mutex_lock(&svmm->mutex);
>
> -       ret =3D nvif_object_ioctl(&svmm->vmm->vmm.object, args,
> -                               struct_size(args, p.phys, npages), NULL);
> +       nvif_object_ioctl(&svmm->vmm->vmm.object, args,
> +                         struct_size(args, p.phys, npages), NULL);

nvif_object_ioctl() may return -ENOSYS.  Seeing other call sites have
comments like:
114     /*XXX: warn? */
134     /*XXX: warn? */

or other places where the return code isn't checked makes me think
that a better approach would be to
1. plumb error codes back up through nouveau_pfns_map() (and other
call sites of nvif_object_ioctl)
2. consider making nvif_object_ioctl __must_check

>
>         mutex_unlock(&svmm->mutex);
>  }
> --
> 2.27.0
>


--=20
Thanks,
~Nick Desaulniers
