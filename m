Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BF57436F1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjF3IWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjF3IWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:22:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430943594;
        Fri, 30 Jun 2023 01:22:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fba74870abso73379e87.0;
        Fri, 30 Jun 2023 01:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688113326; x=1690705326;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ntQTwtwPH6k2j9EgkW281inSLM7kOUQ10aVVuHlZEc4=;
        b=ihlKDBEheoZcYHcqOuKu31r8sFkA0nrjiIPwMW3BZcUrW4C9rwA2fzSFXQMBWhEzGr
         rZD4DOMcqQmnYgHumako0KFVkF6uQRfbyPtCGuC5C7PL+R/TqnoVzqw2uwKkdYR7kNwj
         p17xabIsSVFLUFyr+pmq0V5+FZsutrILjtF7OvIyVo+xdFHw7NUQXZfgrEZKId+RTGKc
         kwD18vrla2uVl+qyGEmjdAtbKByW0bT3JXJbZV9c8nn/ApqreNIxS9bV6lPM12TXOxSK
         iujHBgB+VH24B7tXaX7t8OVBH69OLxD+GKdupORYHv+OAKvHjifd7LBDW+GZ6hJCrZ3J
         CnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688113326; x=1690705326;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntQTwtwPH6k2j9EgkW281inSLM7kOUQ10aVVuHlZEc4=;
        b=bXfBJsPvCwO4OKj24we3Xf0O9m80TbT5D5+BmbApm+WkMTnaB8E2VZtlx2Axs1uvCU
         iAQRvI9hax7Nhv9/Z/zx1IlJi+PbAp2IMEAcbznv+LuXCLHBhX0xmu2+9caDKBYbSQbJ
         ZMApfZBWmDn6w02CTAWYMnfZV8S936mg0+nfl/F913PWtv+XF96mITmtw41I6XsNW9pg
         KEnl12/A4BHXhdUK/iC7Biv1Mt8q/+4PYrUiOTZKNrKk+iiNeF2MdjBlKVmMsnhxJsIO
         R6/+9YvaLaw7oWvZtnRMgHkk1LIdCEMRQoEyflUXBOigE8IE0mSGnesCcSEWWd1O6T26
         FBTg==
X-Gm-Message-State: ABy/qLY50dSu5IZCOqWd1PCnu+kYscNZKfURjl3Nvb/yvSbvMow0z756
        xPe6KkRDsa8+oJ6XhVNn6gI=
X-Google-Smtp-Source: APBJJlExbp8m3ZcjRwFy7mEU1e0ARNuryhyHwt3HSuGcmZLnnFH1KUQwPgPMNpf8oRCelYCSmCVGBQ==
X-Received: by 2002:a05:6512:3491:b0:4fb:7be5:4870 with SMTP id v17-20020a056512349100b004fb7be54870mr1555220lfr.46.1688113325800;
        Fri, 30 Jun 2023 01:22:05 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id f10-20020a19ae0a000000b004fb75142020sm1997184lfc.276.2023.06.30.01.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:22:05 -0700 (PDT)
Date:   Fri, 30 Jun 2023 11:21:53 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        quic_abhinavk@quicinc.com, contact@emersion.fr,
        laurent.pinchart@ideasonboard.com, sebastian.wick@redhat.com,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC v4 6/7] drm/msm/dpu: Allow NULL FBs in atomic commit
Message-ID: <20230630112153.5da36b6a@eldfell>
In-Reply-To: <cca48c01-b84a-dff6-57ae-356971edacf3@linaro.org>
References: <20230404-solid-fill-v4-0-f4ec0caa742d@quicinc.com>
        <20230404-solid-fill-v4-6-f4ec0caa742d@quicinc.com>
        <cca48c01-b84a-dff6-57ae-356971edacf3@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/07tMRP1ecaqD8UF0TI6/QGP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/07tMRP1ecaqD8UF0TI6/QGP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Jun 2023 03:52:37 +0300
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> On 30/06/2023 03:25, Jessica Zhang wrote:
> > Since solid fill planes allow for a NULL framebuffer in a valid commit,
> > add NULL framebuffer checks to atomic commit calls within DPU.
> >=20
> > Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  |  9 ++++++-
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 45 +++++++++++++++++++---=
---------
> >   2 files changed, 36 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm=
/msm/disp/dpu1/dpu_crtc.c
> > index 1edf2b6b0a26..d1b37d2cc202 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > @@ -451,6 +451,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_=
crtc *crtc,
> >   	struct drm_plane_state *state;
> >   	struct dpu_crtc_state *cstate =3D to_dpu_crtc_state(crtc->state);
> >   	struct dpu_plane_state *pstate =3D NULL;
> > +	const struct msm_format *fmt;
> >   	struct dpu_format *format;
> >   	struct dpu_hw_ctl *ctl =3D mixer->lm_ctl;
> >  =20
> > @@ -470,7 +471,13 @@ static void _dpu_crtc_blend_setup_mixer(struct drm=
_crtc *crtc,
> >   		pstate =3D to_dpu_plane_state(state);
> >   		fb =3D state->fb;
> >  =20
> > -		format =3D to_dpu_format(msm_framebuffer_format(pstate->base.fb));
> > +		if (state->pixel_source =3D=3D DRM_PLANE_PIXEL_SOURCE_FB && fb)
> > +			fmt =3D msm_framebuffer_format(pstate->base.fb);
> > +		else
> > +			fmt =3D dpu_get_msm_format(&_dpu_crtc_get_kms(crtc)->base,
> > +					DRM_FORMAT_RGBA8888, 0); =20
>=20
> The DRM_FORMAT_RGBA8888 should be defined somewhere in patch 1 as format=
=20
> for the solid_fill, then that define can be used in this patch.

Isn't this just a driver-specific decision to convert a RGB323232
solid_fill to be presented as a RGBA8888?

Though, below there is ABGR8888 used for something... inconsistent?


Thanks,
pq

>=20
> > +
> > +		format =3D to_dpu_format(fmt);
> >  =20
> >   		if (pstate->stage =3D=3D DPU_STAGE_BASE && format->alpha_enable)
> >   			bg_alpha_enable =3D true;
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_plane.c
> > index 5f0984ce62b1..4476722f03bb 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > @@ -837,8 +837,10 @@ static int dpu_plane_atomic_check(struct drm_plane=
 *plane,
> >  =20
> >   	pipe_cfg->dst_rect =3D new_plane_state->dst;
> >  =20
> > -	fb_rect.x2 =3D new_plane_state->fb->width;
> > -	fb_rect.y2 =3D new_plane_state->fb->height;
> > +	if (new_plane_state->pixel_source =3D=3D DRM_PLANE_PIXEL_SOURCE_FB &&=
 new_plane_state->fb) {
> > +		fb_rect.x2 =3D new_plane_state->fb->width;
> > +		fb_rect.y2 =3D new_plane_state->fb->height;
> > +	}
> >  =20
> >   	/* Ensure fb size is supported */
> >   	if (drm_rect_width(&fb_rect) > MAX_IMG_WIDTH ||
> > @@ -848,10 +850,13 @@ static int dpu_plane_atomic_check(struct drm_plan=
e *plane,
> >   		return -E2BIG;
> >   	}
> >  =20
> > -	fmt =3D to_dpu_format(msm_framebuffer_format(new_plane_state->fb));
> > -
> >   	max_linewidth =3D pdpu->catalog->caps->max_linewidth;
> >  =20
> > +	if (drm_plane_solid_fill_enabled(new_plane_state))
> > +		fmt =3D dpu_get_dpu_format(DRM_FORMAT_ABGR8888);
> > +	else
> > +		fmt =3D to_dpu_format(msm_framebuffer_format(new_plane_state->fb));
> > +
> >   	if (drm_rect_width(&pipe_cfg->src_rect) > max_linewidth) {
> >   		/*
> >   		 * In parallel multirect case only the half of the usual width
> > @@ -1082,21 +1087,32 @@ static void dpu_plane_sspp_atomic_update(struct=
 drm_plane *plane)
> >   	struct drm_crtc *crtc =3D state->crtc;
> >   	struct drm_framebuffer *fb =3D state->fb;
> >   	bool is_rt_pipe;
> > -	const struct dpu_format *fmt =3D
> > -		to_dpu_format(msm_framebuffer_format(fb));
> > +	const struct dpu_format *fmt;
> >   	struct dpu_sw_pipe_cfg *pipe_cfg =3D &pstate->pipe_cfg;
> >   	struct dpu_sw_pipe_cfg *r_pipe_cfg =3D &pstate->r_pipe_cfg;
> >   	struct dpu_kms *kms =3D _dpu_plane_get_kms(&pdpu->base);
> >   	struct msm_gem_address_space *aspace =3D kms->base.aspace;
> >   	struct dpu_hw_fmt_layout layout;
> >   	bool layout_valid =3D false;
> > -	int ret;
> >  =20
> > -	ret =3D dpu_format_populate_layout(aspace, fb, &layout);
> > -	if (ret)
> > -		DPU_ERROR_PLANE(pdpu, "failed to get format layout, %d\n", ret);
> > -	else
> > -		layout_valid =3D true;
> > +	if (state->pixel_source =3D=3D DRM_PLANE_PIXEL_SOURCE_FB && fb) {
> > +		int ret;
> > +
> > +		fmt =3D to_dpu_format(msm_framebuffer_format(fb));
> > +
> > +		ret =3D dpu_format_populate_layout(aspace, fb, &layout);
> > +		if (ret)
> > +			DPU_ERROR_PLANE(pdpu, "failed to get format layout, %d\n", ret);
> > +		else
> > +			layout_valid =3D true;
> > +
> > +		DPU_DEBUG_PLANE(pdpu, "FB[%u] " DRM_RECT_FP_FMT "->crtc%u " DRM_RECT=
_FMT
> > +				", %4.4s ubwc %d\n", fb->base.id, DRM_RECT_FP_ARG(&state->src),
> > +				crtc->base.id, DRM_RECT_ARG(&state->dst),
> > +				(char *)&fmt->base.pixel_format, DPU_FORMAT_IS_UBWC(fmt));
> > +	} else {
> > +		fmt =3D dpu_get_dpu_format(DRM_FORMAT_ABGR8888);
> > +	}
> >  =20
> >   	pstate->pending =3D true;
> >  =20
> > @@ -1104,11 +1120,6 @@ static void dpu_plane_sspp_atomic_update(struct =
drm_plane *plane)
> >   	pstate->needs_qos_remap |=3D (is_rt_pipe !=3D pdpu->is_rt_pipe);
> >   	pdpu->is_rt_pipe =3D is_rt_pipe;
> >  =20
> > -	DPU_DEBUG_PLANE(pdpu, "FB[%u] " DRM_RECT_FP_FMT "->crtc%u " DRM_RECT_=
FMT
> > -			", %4.4s ubwc %d\n", fb->base.id, DRM_RECT_FP_ARG(&state->src),
> > -			crtc->base.id, DRM_RECT_ARG(&state->dst),
> > -			(char *)&fmt->base.pixel_format, DPU_FORMAT_IS_UBWC(fmt));
> > -
> >   	dpu_plane_sspp_update_pipe(plane, pipe, pipe_cfg, fmt,
> >   				   drm_mode_vrefresh(&crtc->mode),
> >   				   layout_valid ? &layout : NULL);
> >  =20
>=20


--Sig_/07tMRP1ecaqD8UF0TI6/QGP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmSekKEACgkQI1/ltBGq
qqf6Tg//TpfJjrOyp7UIcbIe96gAJnBOQNqjDffE+dXnO9mNHkUfumCAeoL8v0JM
5JFEABQABEG5k1DVHzZSRcnIVdPMu2WJl0n7RNUM1GH7ANXTxjPW0aReaWFQxyf8
Pts5v2weaXjUBUGSsiHg+EMRRO951V6W0sOwwAB0Wz+ux6v5i0qWBbDXXE7jquOn
eNUv1LlNBtqDgpMCxrZFxbR3qJZ0z4HpSrZgzEqJO/XpEN+n/2UlIW2GkocfIzfB
nxS6jZuhJ40tQJtY4Mo7kZ2U3KD/KpZKbEO10FFYlVMOEhLMuH52k3pLq8dUJ8J2
Lcc9KaKWIXj00YQUWjHl2ADcsZGR1PU+ZEJrezmx2iu5m0CqiU3wIBJoeIBWmETf
A2los5HQQH4B3BQnK4s3UcpGbX943Ef9v3QvK5jbymk+cjcWjc44fPFXDgLakqQd
arX8Prf9u9LWoMaXTLxfwaSt0u2yaJAs6L+cH9BJLDoC0Gq1bWLrPfPxMVn8J8VB
WuVe2u8JRekuQoPOlgXOGHocz2Wna7j3y7LASbms3UB74rhqfuWz9OdlXmx3I8pU
ZICFtqqi8OufMkS4qqaQxd0logF2KF/tLlCeuTx52yAdt6o2HTeoVcgx4EPA71OL
jAuXVgQ7HGsb3ruQZKOs2e0mYfc/VrfDao9ov5ebdMnqeOBdpQU=
=PGcE
-----END PGP SIGNATURE-----

--Sig_/07tMRP1ecaqD8UF0TI6/QGP--
