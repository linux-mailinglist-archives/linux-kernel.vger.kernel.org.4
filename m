Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBD66F05FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244028AbjD0Mk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243989AbjD0MkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:40:15 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83FE558B;
        Thu, 27 Apr 2023 05:40:03 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-38bef71c258so5762415b6e.2;
        Thu, 27 Apr 2023 05:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682599203; x=1685191203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6ET9XLS5jM/TyHq4+UE6o4i1yy/wsCl/8+/RTLOHqY=;
        b=msyOC8BBuy7I5069cJ9Fs6UeK9SnEiNiykDGApouWwIVmp6W+w4i7EI0BD6bwq45Te
         Mv8ooCvRm5eCzKziAc0k3FmoE9HbIC5yDZUY+pqJzuVCHk7IWnWr9+mXvwTTuj9l0Ncz
         CMRlMc3859WHiODGKv/+0U7vSrJpu/RWfAH+SyiwNgsOLmX1BVdKgnoAV2YMsITtsmPL
         iFdrpSLUmvyTf8WJnrfeTYpIh//v5KGODvIhdeuaNW1lM1XD3gmrZ34un2ub2iJvj1wM
         LXVyWM9yoKcEjEPrVn+zY9Fu3t3uKe4w/r4/5m/2yU76S0mRQPAZCd3XfuQMVJwWXUBL
         bGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682599203; x=1685191203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6ET9XLS5jM/TyHq4+UE6o4i1yy/wsCl/8+/RTLOHqY=;
        b=Kld19s8fDpoQLWqialRfx9xhLvUM+DviHdi/j0Tsehp9xhghVVGn0NoI3ZxRdrqQeJ
         6NuV0BfeEcBQ38PYgaQQNDndcfpEsCLlDLUIwnfcxYOEg8smFzh1ttAw/6yS8VmXHL87
         4uKRxBJN08eOW7DQRh4e/bOZ61QJx/QRQe3fwnXd17laeu3R4PsLQ+rmjWWCDSx+b2Aq
         M2GpjFmEwxBWONTIaBz+PD84GZlRp17gOQosRxAAOQ9BPZYWSboStIbspECUPGAA3pFS
         wdLVATO6WhSY1bttgj7RQdne/FZjn1HaxcknDFwaUTjcoS9g+1xET3Ulwvf4GEe7W336
         2O5g==
X-Gm-Message-State: AC+VfDyiPYY95Im27WFsN+TevDgaayv8rwbpN2C36ct/Zt9nZ4/oajze
        7IJFcHhvZgWb3oN2SZjNyYZRNNKdAalhA/ZagsYmAgD/
X-Google-Smtp-Source: ACHHUZ5+5nq8G0fdCC1+vwj+KmJkfoWFgNBUEKtOzD2dq9+mpvse2ZJ72PF955P7xK8j8473xqe+Z9K5Jz67W2iX7LQ=
X-Received: by 2002:aca:1307:0:b0:38e:2879:735b with SMTP id
 e7-20020aca1307000000b0038e2879735bmr563675oii.34.1682599203057; Thu, 27 Apr
 2023 05:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230419122233.3440-1-hackyzh002@gmail.com> <CAF6NKda1Jy_wfxaVqWt-o75f1BO-o4JXHY9HS9_JtJ2FHztMmQ@mail.gmail.com>
In-Reply-To: <CAF6NKda1Jy_wfxaVqWt-o75f1BO-o4JXHY9HS9_JtJ2FHztMmQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 Apr 2023 08:39:51 -0400
Message-ID: <CADnq5_MfynMAPU8c-Lq1X_dcDOdRpjW6i=m-Qo8zsZZ=dO-62w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1
To:     whitehat002 whitehat002 <hackyzh002@gmail.com>
Cc:     alexander.deucher@amd.com, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        sumit.semwal@linaro.org, linaro-mm-sig@lists.linaro.org,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        airlied@gmail.com, christian.koenig@amd.com,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per my prior reply, it has been applied.

Thanks,

Alex

On Thu, Apr 27, 2023 at 8:39=E2=80=AFAM whitehat002 whitehat002
<hackyzh002@gmail.com> wrote:
>
> hello
> What is the current status of this patch, has it been applied?
>
>
> hackyzh002 <hackyzh002@gmail.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=B8=89 20:23=E5=86=99=E9=81=93=EF=BC=9A
> >
> > The type of size is unsigned int, if size is 0x40000000, there will
> > be an integer overflow, size will be zero after size *=3D sizeof(uint32=
_t),
> > will cause uninitialized memory to be referenced later.
> >
> > Signed-off-by: hackyzh002 <hackyzh002@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index 08eced097..89bcacc65 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -192,7 +192,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser =
*p,
> >         uint64_t *chunk_array_user;
> >         uint64_t *chunk_array;
> >         uint32_t uf_offset =3D 0;
> > -       unsigned int size;
> > +       size_t size;
> >         int ret;
> >         int i;
> >
> > --
> > 2.34.1
> >
