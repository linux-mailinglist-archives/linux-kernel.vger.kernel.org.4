Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4011170E7C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbjEWVqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238678AbjEWVqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:46:46 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B649E6
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:46:45 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f6915ca22eso3097791cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684878404; x=1687470404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0SLng/+57yNacAyFcfk9MHo3CzpuHHJKyzuH5DOnbs=;
        b=Uz9Pah/zTvsmYDSpGZz3RBTNuUByhLxjaCX3v6ogXZrGzDSUiLw7bE/09MrFJVjlCC
         1cg+zHprfU/yYEp0+kM7r7yizISHat4ZVnNMYdxcqCtOnTLy0+VX+38sksIRcnjPi2Wn
         eX0wfuu08UQJ2NMLxb/yt6lePFIka52GBc2VfXvmYA25BmHPiw+UPze6CgJXU4cM3i84
         6NXfd4JKbkjVQLH7UIYhGVDe4AuTcaFhw6kqBl5iZVq7+jpwjc3nzpcCaImHNjh+tw7R
         Adhlpuj5n+WE3xgDaAjetyDT70TGhu7soC+uvPZRL70+PNeVSP7fSqgXwiwWOJusC/E3
         0Mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878404; x=1687470404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0SLng/+57yNacAyFcfk9MHo3CzpuHHJKyzuH5DOnbs=;
        b=WDHlJbpTl0TwMTLxn3xxcRw3MuU6ibirmVWSoHLk158iRl3WpMACB2dijgb2XCixs1
         Zj0qtq9NQ88agi0hd40I/sKrr+cUirnNoJc5BvVBwN6reLzPuM7XbpwBpRIm8DthNKS9
         R3NunE9ihYMwFy09OsBQkRvLBub7thIIhLjfy1obXN0en0QEDlxYJywYT/zjmfOcJEPB
         BTK9nZmerOxrezpes0bOztPg87lq0J9mvMt4BsL9g1pPobXKQNmCZ/tCS1bhM1YEhdyg
         5yviCbMfZQCb1WA2o2JrufV8ysi6foPNWzEOXSzOWAdSC8TwHFebGJlojP6fp40GO8qX
         T5NA==
X-Gm-Message-State: AC+VfDwJ0Ibvky+5voeMykKLb5JMtWUwRblfrxz46Iq+UGoCsEgsycQL
        VIvrlenRFQfKC7xyjBkgaCXplEYBcq8NN8dnPNgHTA==
X-Google-Smtp-Source: ACHHUZ6PC+6gMkHsqVYqsVb/1RBmIyHiDzul4UAhu0pxfc/7Yd/DNsG2O4pCqDr9tjNxljKCUP3o62/kFGxVNi+fzyo=
X-Received: by 2002:a05:622a:51:b0:3f6:c202:b011 with SMTP id
 y17-20020a05622a005100b003f6c202b011mr1350410qtw.3.1684878404036; Tue, 23 May
 2023 14:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230523212050.9970-1-aweber.kernel@gmail.com> <CAKwvOd=00s_MMQcnbyQkEsUE8HwhSCw+=KyzckKpdTrivQ3N-w@mail.gmail.com>
In-Reply-To: <CAKwvOd=00s_MMQcnbyQkEsUE8HwhSCw+=KyzckKpdTrivQ3N-w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 May 2023 14:46:32 -0700
Message-ID: <CAKwvOdkQ87Bd0ep_c4qdd0TjGgsUmFq-ng1nqewZNsoR3Afc3A@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: samsung-s6d7aa0: use pointer for drm_mode in
 panel desc struct
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, thierry.reding@gmail.com,
        David Airlie <airlied@gmail.com>,
        Nikita Travkin <nikita@trvn.ru>,
        Daniel Vetter <daniel@ffwll.ch>, Tom Rix <trix@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 2:29=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, May 23, 2023 at 2:20=E2=80=AFPM Artur Weber <aweber.kernel@gmail.=
com> wrote:
> >
> > Fixes compilation errors on older GCC versions (before 8.x) and Clang
> > after changes introduced in commit 6810bb390282 ("drm/panel: Add
> > Samsung S6D7AA0 panel controller driver"). Tested with GCC 13.1.1,
> > GCC 6.4.0 and Clang 16.0.3.
>
> Hi Artur,
> Thanks for the patch! Mind sending a v2 with the diagnostic added to
> the commit message? This gives reviewers much more context as to what
> issue you are fixing.

Perhaps it was these errors:
https://lore.kernel.org/llvm/646c6def.a70a0220.58c1a.903d@mx.google.com/T/#=
u

?
If so, please add

Reported-by: kernelci.org bot <bot@kernelci.org>
Link: https://lore.kernel.org/llvm/646c6def.a70a0220.58c1a.903d@mx.google.c=
om

To the v2 commit message as well.

>
> >
> > Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> > ---
> >  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gp=
u/drm/panel/panel-samsung-s6d7aa0.c
> > index f532aa018428..102e1fc7ee38 100644
> > --- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> > +++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> > @@ -37,7 +37,7 @@ struct s6d7aa0_panel_desc {
> >         unsigned int panel_type;
> >         int (*init_func)(struct s6d7aa0 *ctx);
> >         int (*off_func)(struct s6d7aa0 *ctx);
> > -       const struct drm_display_mode drm_mode;
> > +       const struct drm_display_mode *drm_mode;
> >         unsigned long mode_flags;
> >         u32 bus_flags;
> >         bool has_backlight;
> > @@ -309,7 +309,7 @@ static const struct s6d7aa0_panel_desc s6d7aa0_lsl0=
80al02_desc =3D {
> >         .panel_type =3D S6D7AA0_PANEL_LSL080AL02,
> >         .init_func =3D s6d7aa0_lsl080al02_init,
> >         .off_func =3D s6d7aa0_lsl080al02_off,
> > -       .drm_mode =3D s6d7aa0_lsl080al02_mode,
> > +       .drm_mode =3D &s6d7aa0_lsl080al02_mode,
> >         .mode_flags =3D MIPI_DSI_MODE_VSYNC_FLUSH | MIPI_DSI_MODE_VIDEO=
_NO_HFP,
> >         .bus_flags =3D DRM_BUS_FLAG_DE_HIGH,
> >
> > @@ -412,7 +412,7 @@ static const struct s6d7aa0_panel_desc s6d7aa0_lsl0=
80al03_desc =3D {
> >         .panel_type =3D S6D7AA0_PANEL_LSL080AL03,
> >         .init_func =3D s6d7aa0_lsl080al03_init,
> >         .off_func =3D s6d7aa0_lsl080al03_off,
> > -       .drm_mode =3D s6d7aa0_lsl080al03_mode,
> > +       .drm_mode =3D &s6d7aa0_lsl080al03_mode,
> >         .mode_flags =3D MIPI_DSI_MODE_NO_EOT_PACKET,
> >         .bus_flags =3D 0,
> >
> > @@ -440,7 +440,7 @@ static const struct s6d7aa0_panel_desc s6d7aa0_ltl1=
01at01_desc =3D {
> >         .panel_type =3D S6D7AA0_PANEL_LTL101AT01,
> >         .init_func =3D s6d7aa0_lsl080al03_init, /* Similar init to LSL0=
80AL03 */
> >         .off_func =3D s6d7aa0_lsl080al03_off,
> > -       .drm_mode =3D s6d7aa0_ltl101at01_mode,
> > +       .drm_mode =3D &s6d7aa0_ltl101at01_mode,
> >         .mode_flags =3D MIPI_DSI_MODE_NO_EOT_PACKET,
> >         .bus_flags =3D 0,
> >
> > @@ -458,7 +458,7 @@ static int s6d7aa0_get_modes(struct drm_panel *pane=
l,
> >         if (!ctx)
> >                 return -EINVAL;
> >
> > -       mode =3D drm_mode_duplicate(connector->dev, &ctx->desc->drm_mod=
e);
> > +       mode =3D drm_mode_duplicate(connector->dev, ctx->desc->drm_mode=
);
> >         if (!mode)
> >                 return -ENOMEM;
> >
> >
> > base-commit: 37cee4876a45a5c3da79a83d34ed4f3c68548aef
> > --
> > 2.40.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
