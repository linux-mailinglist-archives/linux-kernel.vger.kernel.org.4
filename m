Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFB76FCBCC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjEIQxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjEIQxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:53:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BFC4C16
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:53:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc25f0c7dso11443306a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=froggi.es; s=google; t=1683651179; x=1686243179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kCSph6RPin0zDIowWuB4TbGOKDvCrFa8+qjOjCD0AQ4=;
        b=bgLHKdztA0Ur7FCUZ9YOsYhFLxYrBT6I8hQLzWmJMKYsmvHSK7RAep9JO4Uec582rt
         yfWJ7w3icpPTDLlo4Q/9I1/CL7cVlBb4ktsxhCECciEQUInOOOIeiNw+fkyZnouCrWAi
         unFFng4n6RY8Wa0FN2Sad3kx9WRKldxQnsoCJfig+WC/33IXG3icw2OkYfJdaeZMNLdV
         oN32xi4AOFUDqeMg62xOV9QI4yWBIBJZyF7pu55yx9vKqip5vE7/fcG+e+onBhONBZQ2
         /CFFGRNkW/+V1KnK3U8ul5lJHZKIalTeiLjY+W+Bz0eUa932FgTLXNa6kfV94MkxNciq
         4q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651179; x=1686243179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCSph6RPin0zDIowWuB4TbGOKDvCrFa8+qjOjCD0AQ4=;
        b=FEn1kEmYYycOyT452C+lMsVWjGWE0PltP/boP/Fd00Ee0bYX1Zigo9JOqaNYW9qNJM
         oMGKUzZASsOsHtRXtPtYhqgiQ3LuWErNcpfIFGvKAH4ehbIp80wyVIPD/o4VH0mfou7i
         dM+SZHHW3JOpR/dtU3QrqSBdZccqS4GMvmuQjSefMJKH7gVEloqkLc5zX0RG4hevqTar
         mgiJuxT2ixRRb9uZjDQCnBI75+27DuLs5tHEj9CxJQYE+9EjU5D24xfQZAugcae4g+b+
         DIKGROaccxfz+Y2cqjr8dvGN2VCvXBJRHKt+tgYV2lOC4dfFo0SYaWqyDlNVfJk/DRqJ
         oxIw==
X-Gm-Message-State: AC+VfDzYgyeVUok5M45PSBBdwD60NF+sa97Cif7I9IgSAsI2tSjGmLgn
        3EPXhCdKTOgE6du4Rdge9SY5NCJb4dS4pcy5quyGMw==
X-Google-Smtp-Source: ACHHUZ4YlFj73/y7wqqAibWxww81w4v76opgy9ewBq6NOW0La7GEnHmTx+ZD6gFf8zsVDFwmkiEY/478DC4l5ouHyS8=
X-Received: by 2002:aa7:d50a:0:b0:50b:d4e8:317f with SMTP id
 y10-20020aa7d50a000000b0050bd4e8317fmr12139312edq.13.1683651179673; Tue, 09
 May 2023 09:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230423141051.702990-1-mwen@igalia.com> <20230423141051.702990-4-mwen@igalia.com>
 <613b2431-7d05-fb44-25d7-dba59e5eca3c@amd.com> <20230509162353.7hak3fda43fim3ho@mail.igalia.com>
In-Reply-To: <20230509162353.7hak3fda43fim3ho@mail.igalia.com>
From:   Joshua Ashton <joshua@froggi.es>
Date:   Tue, 9 May 2023 16:52:48 +0000
Message-ID: <CAEZNXZARW1uxYz1G2gGt-U2VDCaXBZNNAK-UsXuMeHVufU5YLA@mail.gmail.com>
Subject: Re: [RFC PATCH 03/40] drm/amd/display: introduce Steam Deck color
 features to AMD display driver
To:     Melissa Wen <mwen@igalia.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        sunpeng.li@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Sebastian Wick <sebastian.wick@redhat.com>,
        Xaver Hugl <xaver.hugl@gmail.com>,
        Shashank Sharma <Shashank.Sharma@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sungjoon.kim@amd.com, Alex Hung <alex.hung@amd.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the idea is that we wouldn't have a config option so it
doesn't inherently become linux kernel uAPI?

Then we can just build our SteamOS kernels with that definiton set.

On Tue, 9 May 2023 at 16:26, Melissa Wen <mwen@igalia.com> wrote:
>
> On 05/08, Harry Wentland wrote:
> > On 4/23/23 10:10, Melissa Wen wrote:
> > > We are enabling a large set of color calibration features to enhance KMS
> > > color mgmt but these properties are specific of AMD display HW, and
> > > cannot be provided by other vendors. Therefore, set a config option to
> > > enable AMD driver-private properties used on Steam Deck color mgmt
> > > pipeline.
> > >
> > > Co-developed-by: Joshua Ashton <joshua@froggi.es>
> > > Signed-off-by: Joshua Ashton <joshua@froggi.es>
> > > Signed-off-by: Melissa Wen <mwen@igalia.com>
> > > ---
> > >  drivers/gpu/drm/amd/display/Kconfig | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> > > index 06b438217c61..c45a8deb1098 100644
> > > --- a/drivers/gpu/drm/amd/display/Kconfig
> > > +++ b/drivers/gpu/drm/amd/display/Kconfig
> > > @@ -53,5 +53,11 @@ config DRM_AMD_SECURE_DISPLAY
> > >              of crc of specific region via debugfs.
> > >              Cooperate with specific DMCU FW.
> > >
> > > +config STEAM_DECK
> > > +   bool "Enable color calibration features for Steam Deck"
> > > +   depends on DRM_AMD_DC
> > > +   help
> > > +     Choose this option if you want to use AMDGPU features for broader
> > > +     color management support on Steam Deck.
> > >
> >
> > If we can drop this (i.e. don't offer a CONFIG_ option to allow enablement of
> > the uAPI, but build with -DCONFIG_STEAM_DECK) it would go a long way to keep
> > us from requiring to support this forever.
>
> I see, I'll follow this path. Still on that, I've changed
> CONFIG_STEAM_DECK (too generic) to CONFIG_DRM_AMD_COLOR_STEAMDECK.
> Does it sound better?
>
> Thanks,
>
> Melissa
>
> >
> > Harry
> >
> > >  endmenu
> >
> >
