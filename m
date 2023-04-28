Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CAE6F0FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344368AbjD1Apy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjD1Apw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:45:52 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AE9AC;
        Thu, 27 Apr 2023 17:45:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9536df4b907so1740380766b.0;
        Thu, 27 Apr 2023 17:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682642749; x=1685234749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl96LCCkpjgD23grkbS1yyST45SlEkE3SGRzL04YVVA=;
        b=RJAufDGR1WE8/kTpjEXn/SvE1akzytsLkLMSFAJuQmkq+aQ8VH3RyUdR1ZfgYEC01H
         dmeIFGhI24rxqIiby9nWCw+j8K0i3X9sQbFmN75plsAoXnd9Zj8Q6o2R6qjte3BuY417
         hUaAJ6cnQ30c2uNMkqx3cFnGaRy1ap/Rj1eGCPQ/w/mi24OP2rRGsSjBcondz35Q+U8g
         nqYb0c1YNnlph2ix5Sq0pZm4FK1G8TCXFubpXMmi0pHzzxZPy5Xf4JLqT1mavNSfSUoh
         l3q1uIo1B1tNbnDB1xi7cAl8jrXPKyYBmAKg76zKhV4tinMQXyTUkdWTeHBOHS0KjO7j
         KWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682642749; x=1685234749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kl96LCCkpjgD23grkbS1yyST45SlEkE3SGRzL04YVVA=;
        b=QFjZbWTvzN/2p1RvrQdtIIl2C1nnVvQZpRt1k9TekjKaWGtipl/AZbqXmGQoZx0uJg
         vtyKHdK6anXWVVur1wWSV2PJge/MiVb0eqyyLkau/C54NR04yRz2E+hFxRPCDWYYKsUx
         EfUDnjOdguIfEG5Ns6XClHIgVZy3jK9fu9ZAOv5zKZRILEu0GS7nskkVvjStR0AmfOKs
         KzHZlNQChlpBc3nRzwQsJNkHN3X/60EgT1HAM5VfxojhKHYr5fcN1FdHI15+for6s2hd
         BYPxKuZYyalp5XsVwC0JY1UCox0fbAdrAAETzTQa6+QnWG94jkwefXcO0bbHkd2LAQN8
         9FSQ==
X-Gm-Message-State: AC+VfDxRAlhBSZOb5fxMATUmV2Jqk1rQgrWrStmjGuJVF42sIGP5k9JG
        qVyyCmGO/b2vXiR1i028QSuRkT/rlKacaa8yyB8=
X-Google-Smtp-Source: ACHHUZ7B0b4msmyMH8xuBKiO++UE2DzmKb86fdqinlxALx425ntv5PITQowYd8G9Wnbi1TbWybLGz4JLLXngOlOJbf8=
X-Received: by 2002:a17:906:dc93:b0:94e:5708:1564 with SMTP id
 cs19-20020a170906dc9300b0094e57081564mr4377799ejc.22.1682642749260; Thu, 27
 Apr 2023 17:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230419122233.3440-1-hackyzh002@gmail.com> <CAF6NKda1Jy_wfxaVqWt-o75f1BO-o4JXHY9HS9_JtJ2FHztMmQ@mail.gmail.com>
 <CADnq5_MfynMAPU8c-Lq1X_dcDOdRpjW6i=m-Qo8zsZZ=dO-62w@mail.gmail.com>
In-Reply-To: <CADnq5_MfynMAPU8c-Lq1X_dcDOdRpjW6i=m-Qo8zsZZ=dO-62w@mail.gmail.com>
From:   whitehat002 whitehat002 <hackyzh002@gmail.com>
Date:   Fri, 28 Apr 2023 08:45:36 +0800
Message-ID: <CAF6NKdaxK_ZRkKRyWtm9Cj-8fNE9RptW3FjW-V39rmaHaCGHTw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     alexander.deucher@amd.com, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        sumit.semwal@linaro.org, linaro-mm-sig@lists.linaro.org,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        airlied@gmail.com, christian.koenig@amd.com,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex,I have a question, why I don't see it on the
https://patchwork.freedesktop.org/

Alex Deucher <alexdeucher@gmail.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=8827=E6=
=97=A5=E5=91=A8=E5=9B=9B 20:40=E5=86=99=E9=81=93=EF=BC=9A
>
> As per my prior reply, it has been applied.
>
> Thanks,
>
> Alex
>
> On Thu, Apr 27, 2023 at 8:39=E2=80=AFAM whitehat002 whitehat002
> <hackyzh002@gmail.com> wrote:
> >
> > hello
> > What is the current status of this patch, has it been applied?
> >
> >
> > hackyzh002 <hackyzh002@gmail.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=B8=89 20:23=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > The type of size is unsigned int, if size is 0x40000000, there will
> > > be an integer overflow, size will be zero after size *=3D sizeof(uint=
32_t),
> > > will cause uninitialized memory to be referenced later.
> > >
> > > Signed-off-by: hackyzh002 <hackyzh002@gmail.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_cs.c
> > > index 08eced097..89bcacc65 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > > @@ -192,7 +192,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parse=
r *p,
> > >         uint64_t *chunk_array_user;
> > >         uint64_t *chunk_array;
> > >         uint32_t uf_offset =3D 0;
> > > -       unsigned int size;
> > > +       size_t size;
> > >         int ret;
> > >         int i;
> > >
> > > --
> > > 2.34.1
> > >
