Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2EF6B81EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCMT43 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 15:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjCMT41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:56:27 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103238534F;
        Mon, 13 Mar 2023 12:56:21 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id h8so9615886ede.8;
        Mon, 13 Mar 2023 12:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678737380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjMVYl/zcmqZd7QTw6wKbhHzflyXdyDOQNkUW9nv/Bo=;
        b=D9lNcrqcKWZhYGH2knR6Vx+Ac5WO2sMeDpeLzpBiMrsE1/FgKX5ZB3GOXa18jHaGvy
         G9rk+cey7h8Km9j02MU/joCzs8i+jPo9XgDmW6BOZVNcBphPzqFUP/BsmZLVcF5fU4UA
         B34lzzneOmVdsZ7ZpZ6SwE4tyF1VofzAqvro0dVS7AYMxWCxB7nra58OBn47TfShJs7S
         8nvRD5BxI1g804MlCSTG2FjS2NM0VxnWt4F7Zn1N1fL3XMZvLupTR6GybCUh/CPFfLbM
         Pd9/0VVXq9rp5k2Jz57nEQO+oDxrXkfQrK447nX5W7oRX5z6lc9CL4F9mpoZVhZEorAz
         QBzw==
X-Gm-Message-State: AO0yUKV8gSCuGP4UbKEf/s1aufyfr1et6CGFowTH1OKk2oDuh7zsBSCE
        eJa9iNoo3NA5yPdMjDZo1D7+2WCYi84gKLfaOZY=
X-Google-Smtp-Source: AK7set+6bXxAz1AjPX0PoQzviwHtDnGhZeGybBm1XzqjXjCxdk0LzSFKdn0GMUK8pc0w02DXCKDF/nRF3teWxyC89FU=
X-Received: by 2002:a17:906:64d:b0:8d1:57cf:ef3c with SMTP id
 t13-20020a170906064d00b008d157cfef3cmr17373566ejb.2.1678737380313; Mon, 13
 Mar 2023 12:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230308141322.25201-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230308141322.25201-1-lukas.bulwahn@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Mar 2023 20:56:09 +0100
Message-ID: <CAJZ5v0jinyS0asCT3fG+cAMkFYd=wYk9-fRnf=w=24qPH9hUkA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update the 01.org website entries
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 3:15 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> The 01.org links in MAINTAINERS now forward to different other pages or do
> not resolve.
>
> The link https://01.org/linuxgraphics/ resolves to the Intel Graphics for
> Linux - Programmer's Reference Manuals. Update this webpage entry.
>
> The link
> https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-misc.html
> does not resolve. Remove this webpage entry.
>
> The link https://01.org/igvt-g resolves to
> https://github.com/intel/gvt-linux. Remove the webpage entry, as the
> github repository is already referred to by the T: entry in that section.
>
> The link resolves the pm-graph project page in Intel's Open Ecosystem area
> at intel.com. Update this webpage entry.
>
> M:      "Todd E Brandt" <todd.e.brandt@linux.intel.com>
> L:      linux-pm@vger.kernel.org
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the pm-graph entry.

Or I can apply this part of the patch if you send it to linux-pm separately.

Thanks!

> ---
>  MAINTAINERS | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1333928a7be4..99adcd74b06a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6747,7 +6747,6 @@ M:        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>  M:     Maxime Ripard <mripard@kernel.org>
>  M:     Thomas Zimmermann <tzimmermann@suse.de>
>  S:     Maintained
> -W:     https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-misc.html
>  T:     git git://anongit.freedesktop.org/drm/drm-misc
>  F:     Documentation/gpu/
>  F:     drivers/gpu/drm/*
> @@ -10250,7 +10249,7 @@ M:      Rodrigo Vivi <rodrigo.vivi@intel.com>
>  M:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
>  L:     intel-gfx@lists.freedesktop.org
>  S:     Supported
> -W:     https://01.org/linuxgraphics/
> +W:     https://www.intel.com/content/www/us/en/develop/documentation/intel-graphics-for-linux-programmers-reference-guide/top.html
>  Q:     http://patchwork.freedesktop.org/project/intel-gfx/
>  B:     https://gitlab.freedesktop.org/drm/intel/-/wikis/How-to-file-i915-bugs
>  C:     irc://irc.oftc.net/intel-gfx
> @@ -10312,7 +10311,6 @@ M:      Zhi Wang <zhi.a.wang@intel.com>
>  L:     intel-gvt-dev@lists.freedesktop.org
>  L:     intel-gfx@lists.freedesktop.org
>  S:     Supported
> -W:     https://01.org/igvt-g
>  T:     git https://github.com/intel/gvt-linux.git
>  F:     drivers/gpu/drm/i915/gvt/
>
> @@ -16668,7 +16666,7 @@ PM-GRAPH UTILITY
>  M:     "Todd E Brandt" <todd.e.brandt@linux.intel.com>
>  L:     linux-pm@vger.kernel.org
>  S:     Supported
> -W:     https://01.org/pm-graph
> +W:     https://www.intel.com/content/www/us/en/developer/topic-technology/open/pm-graph/overview.html
>  B:     https://bugzilla.kernel.org/buglist.cgi?component=pm-graph&product=Tools
>  T:     git git://github.com/intel/pm-graph
>  F:     tools/power/pm-graph
> --
> 2.17.1
>
