Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6102D6F641A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 06:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjEDEkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 00:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEDEko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 00:40:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0781981
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 21:40:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1aae90f5ebcso329315ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 21:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683175243; x=1685767243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8i47EP8ePoHRL7pxwFpKVB57sm2U0RSBpcP50+Z4MI=;
        b=wINJxjQngMj4N7lNhlO8D83f8HaWZXxf3usgbMommuaTM8eNNO4j2/EEHtFhz1N9pA
         sKTPiRGUmKN3auXfxNUufkzifd8aQ7eEO7oAW9gmaczstYX71/O8z75qgZzd6G1EtSG1
         EzBaxq4TnHmdsNgDGCRo9IuIzQ/KEEGEgKD6hT84srWdNSRGzXPjMBfBVIZB7cKqmWwP
         Hb2CyrrXMeR+MYc4Eg57PK3+lVEhclfCXRBYBE44L36AjZJrJL02habXdmKYOK3zh2ye
         JmKXkFqwjXOY5S2daWyx5cKnF53DE9a/CWJgAEGnUG1P/LUZ66T6G83TSwbPu7zMaHIM
         TbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683175243; x=1685767243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8i47EP8ePoHRL7pxwFpKVB57sm2U0RSBpcP50+Z4MI=;
        b=XB6KHfBAwaowFie3++H3Bmng0vJfDgJcvQCHjBX0LctC+uErpLmhQycpQDnVfRRczx
         qh/TlqdCE3KW0gNV+nFqKziy1y8hwGOzMg1kYu0ovA2b9Ir16Ke0BJ5GhHWxxTTjdVLR
         lbNhcB76iuOFDBYTM+BZd6y91Ut4HfRYELj4hXX8s2ygfAF2AjSD1Lg3LZl8afILAqtj
         A546OQ4SaSENl0DBlTLyAtMnfH4MvAoMdRFtmxO6307bGLr0fDaZQwXwJLzii/qG+3Zh
         MGiyTqStQkkG8EdbFqckT9uVUr05MNuvq/SVhlBLDOTTzyyGXTH3R4sqe16w4hGvHetY
         njPA==
X-Gm-Message-State: AC+VfDwLvZpsApVCWUwStSUIdRCh5jiIjbX0wPUasmWnVMp6x0M1XHhV
        AFVwZb/qg7HhaVlzByAj9zUtnu/RtPGbLgGEjWhUfQ==
X-Google-Smtp-Source: ACHHUZ7hVpuWGatGrW2kl5EnK2Wq7mzgiTndTQDxZOaFmGIbyQzPYJLuazpD1Gmb3OeblvjKuSBYNt9Jjo55ST+jsqg=
X-Received: by 2002:a17:902:d507:b0:1a6:c161:37d7 with SMTP id
 b7-20020a170902d50700b001a6c16137d7mr81166plg.5.1683175242784; Wed, 03 May
 2023 21:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230310063910.2474472-1-saravanak@google.com>
 <4737cacc741c939ca1d980a4858d0748faad11f8.camel@puri.sm> <CAGETcx_0NaSTFFn34nvax2_pG+_5BJtOD0j0wrqU0NSCqwfKWA@mail.gmail.com>
In-Reply-To: <CAGETcx_0NaSTFFn34nvax2_pG+_5BJtOD0j0wrqU0NSCqwfKWA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 3 May 2023 21:40:05 -0700
Message-ID: <CAGETcx-CF83Acp5CQ=RMJq9DD6f_Y70c37zSbLq2R6L5VyoKHg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/mipi-dsi: Set the fwnode for mipi_dsi_device
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <treding@nvidia.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        kernel-team@android.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 3:36=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Sun, Mar 12, 2023 at 7:45=E2=80=AFAM Martin Kepplinger
> <martin.kepplinger@puri.sm> wrote:
> >
> > Am Donnerstag, dem 09.03.2023 um 22:39 -0800 schrieb Saravana Kannan:
> > > After commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
> > > detection more robust"), fw_devlink prints an error when consumer
> > > devices don't have their fwnode set. This used to be ignored
> > > silently.
> > >
> > > Set the fwnode mipi_dsi_device so fw_devlink can find them and
> > > properly
> > > track their dependencies.
> > >
> > > This fixes errors like this:
> > > [    0.334054] nwl-dsi 30a00000.mipi-dsi: Failed to create device
> > > link with regulator-lcd-1v8
> > > [    0.346964] nwl-dsi 30a00000.mipi-dsi: Failed to create device
> > > link with backlight-dsi
> > >
> > > Reported-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> >
> > Reported-and-tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
>
> Maintainers,
>
> Nudge nudge. Will this be picked up for 6.3-rcX?

Greg,

Can you pick this up please? It's a fix that hasn't been picked up for
a few months.

Here's the link to the actual patch for your convenience:
https://lore.kernel.org/lkml/20230310063910.2474472-1-saravanak@google.com/=
#t

-Saravana

>
> -Saravana
>
> >
> > thanks,
> >                          martin
> >
> > > Link:
> > > https://lore.kernel.org/lkml/2a8e407f4f18c9350f8629a2b5fa18673355b2ae=
.camel@puri.sm/
> > > Fixes: 068a00233969 ("drm: Add MIPI DSI bus support")
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_mipi_dsi.c
> > > b/drivers/gpu/drm/drm_mipi_dsi.c
> > > index b41aaf2bb9f1..7923cc21b78e 100644
> > > --- a/drivers/gpu/drm/drm_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> > > @@ -221,7 +221,7 @@ mipi_dsi_device_register_full(struct
> > > mipi_dsi_host *host,
> > >                 return dsi;
> > >         }
> > >
> > > -       dsi->dev.of_node =3D info->node;
> > > +       device_set_node(&dsi->dev, of_fwnode_handle(info->node));
> > >         dsi->channel =3D info->channel;
> > >         strlcpy(dsi->name, info->type, sizeof(dsi->name));
> > >
> >
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >
