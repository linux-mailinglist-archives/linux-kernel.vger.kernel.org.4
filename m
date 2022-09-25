Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152C95E9423
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 17:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiIYP7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 11:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiIYP67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 11:58:59 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4074C275C4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 08:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sDUzqos38NTHKjqKIbjlgYCo7KMd6hyJQ5kwVtvn2uY=; b=aUOU3kpP1xZAGZ3dK/FPnPmN44
        IFB5fkqB+7/gDaDlxHDtUFNwExLm2Y82UixoykTgQQFV7UJ6zCaI0TRAb016BK+MWPxFKYT87rEuu
        A1bemkbLrV1sxM+2rSTYFVMhsHyHGsq8Rf5UKYL8o5L/v38Oko/QwO4yL+3vCtNEhQg8MU+JZMiPA
        EVy0sNCfGvxloaFKqVVe04oxeKvT4KDyGC/4SyyWNp2P84LU3a9mSkwuvbNZUIkVWdQ0IQJa+7xOQ
        D6+Uxr3m1gcVDNPJI6COfxOM261GO67oHOOTfGyHSXgD0+10bhAg/cDRWDQBl5062iEgkhFEBsL6J
        km1Dw7Vw==;
Received: from [2a01:799:961:d200:f09d:f08a:eb68:87b1] (port=49636)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1ocU1u-0001pc-49; Sun, 25 Sep 2022 17:58:54 +0200
Message-ID: <b5fcb40b-fe9a-c634-902f-35808adfca68@tronnes.org>
Date:   Sun, 25 Sep 2022 17:58:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 00/33] drm: Analog TV Improvements
To:     Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Emma Anholt <emma@anholt.net>,
        Karol Herbst <kherbst@redhat.com>,
        Samuel Holland <samuel@sholland.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, nouveau@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v2-0-f733a0ed9f90@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-f733a0ed9f90@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 22.09.2022 16.25, skrev Maxime Ripard:
> Hi,
> 
> Here's a series aiming at improving the command line named modes support,
> and more importantly how we deal with all the analog TV variants.
> 
> The named modes support were initially introduced to allow to specify the
> analog TV mode to be used.
> 
> However, this was causing multiple issues:
> 
>   * The mode name parsed on the command line was passed directly to the
>     driver, which had to figure out which mode it was suppose to match;
> 
>   * Figuring that out wasn't really easy, since the video= argument or what
>     the userspace might not even have a name in the first place, but
>     instead could have passed a mode with the same timings;
> 
>   * The fallback to matching on the timings was mostly working as long as
>     we were supporting one 525 lines (most likely NSTC) and one 625 lines
>     (PAL), but couldn't differentiate between two modes with the same
>     timings (NTSC vs PAL-M vs NSTC-J for example);
> 
>   * There was also some overlap with the tv mode property registered by
>     drm_mode_create_tv_properties(), but named modes weren't interacting
>     with that property at all.
> 
>   * Even though that property was generic, its possible values were
>     specific to each drivers, which made some generic support difficult.
> 
> Thus, I chose to tackle in multiple steps:
> 
>   * A new TV mode property was introduced, with generic values, each driver
>     reporting through a bitmask what standard it supports to the userspace;
> 
>   * This option was added to the command line parsing code to be able to
>     specify it on the kernel command line, and new atomic_check and reset
>     helpers were created to integrate properly into atomic KMS;
> 
>   * The named mode parsing code is now creating a proper display mode for
>     the given named mode, and the TV standard will thus be part of the
>     connector state;
> 
>   * Two drivers were converted and tested for now (vc4 and sun4i), with
>     some backward compatibility code to translate the old TV mode to the
>     new TV mode;
> 
> Unit tests were created along the way.
> 
> One can switch from NTSC to PAL now using (on vc4)
> 
> modetest -M vc4  -s 53:720x480i -w 53:'TV mode':1 # NTSC
> modetest -M vc4  -s 53:720x576i -w 53:'TV mode':4 # PAL
> 
> Let me know what you think,
> Maxime

<snip>

>  drivers/gpu/drm/drm_atomic_state_helper.c       | 128 ++++-
>  drivers/gpu/drm/drm_atomic_uapi.c               |   8 +
>  drivers/gpu/drm/drm_client_modeset.c            |   4 +
>  drivers/gpu/drm/drm_connector.c                 | 111 +++-
>  drivers/gpu/drm/drm_modes.c                     | 658 +++++++++++++++++++++++-
>  drivers/gpu/drm/gud/gud_connector.c             |  12 +-
>  drivers/gpu/drm/i2c/ch7006_drv.c                |   6 +-
>  drivers/gpu/drm/i915/display/intel_tv.c         |   5 +-
>  drivers/gpu/drm/nouveau/dispnv04/tvnv17.c       |   6 +-
>  drivers/gpu/drm/sun4i/sun4i_tv.c                | 148 ++----
>  drivers/gpu/drm/tests/Makefile                  |  16 +-
>  drivers/gpu/drm/tests/drm_client_modeset_test.c | 239 +++++++++
>  drivers/gpu/drm/tests/drm_cmdline_parser_test.c |  67 +++
>  drivers/gpu/drm/tests/drm_kunit_helpers.c       |  54 ++
>  drivers/gpu/drm/tests/drm_kunit_helpers.h       |   9 +
>  drivers/gpu/drm/tests/drm_modes_test.c          | 136 +++++
>  drivers/gpu/drm/vc4/vc4_hdmi.c                  |   2 +-
>  drivers/gpu/drm/vc4/vc4_vec.c                   | 339 ++++++++++--
>  include/drm/drm_atomic_state_helper.h           |   4 +
>  include/drm/drm_connector.h                     |  92 +++-
>  include/drm/drm_mode_config.h                   |  12 +-
>  include/drm/drm_modes.h                         |  17 +

These also needs updating:

Documentation/gpu/kms-properties.csv
Documentation/fb/modedb.rst

Noralf.
