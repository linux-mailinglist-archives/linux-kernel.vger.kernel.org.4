Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CF76B797E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCMNxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMNw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:52:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7D21FE4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:52:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23290612CB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80450C433A0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678715574;
        bh=QddGMGZH2uSDy7WMNvyVz5nSsecFIKvQwNk9EnMKP2g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BqzyS6VOKP+xZ2fxlujS0qxf3ZgEtv3ygBBe4HPYiXeXcuSc7Y4Zx044iCAIUMjS7
         uuicPk0C5sriXR9Vv+ue9NG3eEm3n0U5Uh62yaBJdKjyCLyc5H2TbhfEjk0tLMi7Ib
         R9q7+TFoFsEMHVdANrJt9BkXx6zcjxyOsWrJOmiPc8ol1eL45pNJ/scAzz5qmTB3xV
         RbSIqoztPRLozjvOb57QBjE2xda13ZdYsiLHiTbeKSe5mcyK956Blq70Q29F81nlLC
         W9O+9A40ehWMCKORthy19HzaYVru+jmnUlA0ReJGuMQdw7YASytluZ9tOxSPi1lxxf
         n9qfRSmc94/NA==
Received: by mail-pl1-f174.google.com with SMTP id ja10so3345059plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:52:54 -0700 (PDT)
X-Gm-Message-State: AO0yUKXrAnvjH8jz3u0PueIu9K/UWvFR6RaZrpmE+pmI9UIX+NcBgNF2
        zQO+FHW8acVAi0MzPNzj3qGPCBYUnoqFvAUKKzu5rQ==
X-Google-Smtp-Source: AK7set9XTcMOOJTIbvE3tTd6nShWwc1eAL3DYYDeE2y70F/yyyAjGP3BlGqmKzBHcvMqwete4V5CiRXVrwWvmRHA10c=
X-Received: by 2002:a17:90a:f10b:b0:23a:6ed6:7817 with SMTP id
 cc11-20020a17090af10b00b0023a6ed67817mr12471901pjb.5.1678715573999; Mon, 13
 Mar 2023 06:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230313055951.2997299-1-victor.liu@nxp.com> <292f25d7-2b2b-ba2a-36c3-c207960141f9@linaro.org>
In-Reply-To: <292f25d7-2b2b-ba2a-36c3-c207960141f9@linaro.org>
From:   Robert Foss <rfoss@kernel.org>
Date:   Mon, 13 Mar 2023 14:52:42 +0100
X-Gmail-Original-Message-ID: <CAN6tsi7yz+DvAsV2F9x08Nz3TO-HTCazc11996Y9khVm7SPncw@mail.gmail.com>
Message-ID: <CAN6tsi7yz+DvAsV2F9x08Nz3TO-HTCazc11996Y9khVm7SPncw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add include/drm/drm_bridge.h to DRM DRIVERS
 FOR BRIDGE CHIPS
To:     neil.armstrong@linaro.org
Cc:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com,
        tzimmermann@suse.de, jonas@kwiboo.se,
        Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 10:36=E2=80=AFAM <neil.armstrong@linaro.org> wrote:
>
> On 13/03/2023 06:59, Liu Ying wrote:
> > Appropriate maintainers should be suggested for changes to the
> > include/drm/drm_bridge.h header file, so add the header file to the
> > 'DRM DRIVERS FOR BRIDGE CHIPS' section.
> >
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> >   MAINTAINERS | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3d409875740d..b6e7ac70b8a8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6824,6 +6824,7 @@ S:      Maintained
> >   T:  git git://anongit.freedesktop.org/drm/drm-misc
> >   F:  Documentation/devicetree/bindings/display/bridge/
> >   F:  drivers/gpu/drm/bridge/
> > +F:   include/drm/drm_bridge.h
> >
> >   DRM DRIVERS FOR EXYNOS
> >   M:  Inki Dae <inki.dae@samsung.com>
>
>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Robert Foss <robert.foss@linaro.org>
