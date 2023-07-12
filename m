Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6B9750A68
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjGLOCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjGLOBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:01:36 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6FC1BC2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:01:23 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-558a79941c6so4371201eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689170482; x=1691762482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLsiJY8/ea7O7yxQWYP4ePh8E4N69Kqkk8kigk+qX6M=;
        b=FgMJpQ/pj6kNs5c+c1c2Aoew9MESIoDfn7VsaHwFNnCkWeL9ITu9C6cQXikR43hLwB
         5frncd2GabZBWeYbWOFh/ffCiy5zngdNCyIB+jVdOw6fJAgw0oI/Pv1Lwf/x1lIS5H13
         dzTeWPQ1pwSeFaH30v4Uzmd3os2Bqp4kKIkHIuh135YwvSrQQOJ4ypgiVDuOLIqRkFhI
         qdZV7dWL3P6l8j1fkjylu4jv8+hZJfsWrbm6J+fXZ6ehoJlbrXc9M8m+S7dBv0TzACJG
         MGzNiCTjDuJ/C1Swt406BDxagOH9HawRbvVpveLtnPN/w0oI/ea8LgZU4mi8/dZZWBJa
         q8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689170482; x=1691762482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLsiJY8/ea7O7yxQWYP4ePh8E4N69Kqkk8kigk+qX6M=;
        b=leRZvRLz5h1NJFNofX6j5PAbCpC2l5OKUgGjTJBI9XI4y/J3hyoXmh9tZZtYPjtPm6
         YVWbI2s+JBGLQtVkM+potnSbMOrtTFXr5VgfxjJlKWDv1da8dwWQCwVnZjDw3yx+01Q4
         U3qzw1YNAeCA9sy3jLa0LC3enuyDEsuMVbdqwzGutWUHqF3pcPvIJt4gaN0RjyoB7qZU
         k9jjEZ7E6SMUmiKjZgdRP0ANQZs4zo2jWOmH03eQPPvnVHPKRQEKbuqnvQVstwOME5Ns
         PRgwD1Cqo0XwG5mGCEKt20sqVHOp89I/3HMJsUuGUTmqMQx4699npalAvJ4xo6pJm0v7
         Lwgw==
X-Gm-Message-State: ABy/qLayv7PNECpmO+VJLMKMjrpJTotQ0T0S2j41vHD6zEmhMfscfEk1
        kxu872YrZgSAZDpEVmZ8i9kj/PHPQaHunG3JeHk=
X-Google-Smtp-Source: APBJJlH6CZA350YNzNxZYIEobwacjGj4qVtyjqAlR8TRHYmxX+4F4sp0Q6BykIOS556IpkJ7Dzh0rd4ydTv/7vipWmA=
X-Received: by 2002:a4a:6243:0:b0:566:f51f:bbd3 with SMTP id
 y3-20020a4a6243000000b00566f51fbbd3mr691848oog.2.1689170482529; Wed, 12 Jul
 2023 07:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230712022339.17902-1-rdunlap@infradead.org> <acee82a2-d5f9-9bf1-5138-44db14c079d1@amd.com>
In-Reply-To: <acee82a2-d5f9-9bf1-5138-44db14c079d1@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 12 Jul 2023 10:01:10 -0400
Message-ID: <CADnq5_Pnqiz+KK6S_8rhm9K3RgMi3RLAt2u1jrM7m_ucSNvo8g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: dc.h: eliminate kernel-doc warnings
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Leo Li <sunpeng.li@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Jul 12, 2023 at 9:58=E2=80=AFAM Harry Wentland <harry.wentland@amd.=
com> wrote:
>
> On 2023-07-11 22:23, Randy Dunlap wrote:
> > Quash 175 kernel-doc warnings in dc.h by unmarking 2 struct
> > comments as containing kernel-doc notation and by spelling one
> > struct field correctly in a kernel-doc comment.
> >
> > Fixes: 1682bd1a6b5f ("drm/amd/display: Expand kernel doc for DC")
> > Fixes: ea76895ffab1 ("drm/amd/display: Document pipe split policy")
> > Fixes: f6ae69f49fcf ("drm/amd/display: Include surface of unaffected st=
reams")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Harry Wentland <harry.wentland@amd.com>
> > Cc: Leo Li <sunpeng.li@amd.com>
> > Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > Cc: dri-devel@lists.freedesktop.org
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dc.h |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff -- a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/dis=
play/dc/dc.h
> > --- a/drivers/gpu/drm/amd/display/dc/dc.h
> > +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> > @@ -506,7 +506,7 @@ enum dcn_zstate_support_state {
> >       DCN_ZSTATE_SUPPORT_DISALLOW,
> >  };
> >
> > -/**
> > +/*
> >   * struct dc_clocks - DC pipe clocks
> >   *
> >   * For any clocks that may differ per pipe only the max is stored in t=
his
> > @@ -728,7 +728,7 @@ struct resource_pool;
> >  struct dce_hwseq;
> >  struct link_service;
> >
> > -/**
> > +/*
> >   * struct dc_debug_options - DC debug struct
> >   *
> >   * This struct provides a simple mechanism for developers to change so=
me
> > @@ -756,7 +756,7 @@ struct dc_debug_options {
> >       bool use_max_lb;
> >       enum dcc_option disable_dcc;
> >
> > -     /**
> > +     /*
> >        * @pipe_split_policy: Define which pipe split policy is used by =
the
> >        * display core.
> >        */
> > @@ -1334,7 +1334,7 @@ struct dc_validation_set {
> >       struct dc_stream_state *stream;
> >
> >       /**
> > -      * @plane_state: Surface state
> > +      * @plane_states: Surface state
> >        */
> >       struct dc_plane_state *plane_states[MAX_SURFACES];
> >
>
