Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFFE6034E7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJRV2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJRV2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:28:38 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6355BABF28
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:28:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a26so35165904ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMqcto7q4Y02vhxVqpYib/gpRgMq96A3OL97M56Aao4=;
        b=WpO4iY1dA9puF/IaStcAWch5qKTRLozIaUxJXUmJrwW5HnWmKHN+bVKzyVOX0osEuN
         tcjlTsNepc4kyh8hcqqXqr5jYNMzexnDXf0k0m8rssH5YBnHsuZOpambwz+VUrlN9tDi
         hExOHdVS37FHjky9E+m7XBtxwIMI4D0KWYug8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMqcto7q4Y02vhxVqpYib/gpRgMq96A3OL97M56Aao4=;
        b=e+6PInHXD2OERwgFVjfuTiod2LGEeI2yTijjKjL6JAShl8SFcz4YWJufuo1OoqCQvi
         Bo/R2ZBbF79Fad5XU3m+rbdITHIPJu2YL5Hyh3FYGnORx/Jq5z3TpZM4KnLa8zCtfvgt
         +U5r8at3gNcpYv9VL8mmQYi10cD78e/I80TtJyoS6fTkCDHklSEq+neTbOVvWgz0c8IT
         Q9+nUSCJA16CXoCrtbFt+c3VLyaYqvbNnoDWbvWVSqWRo+beaVNy55w34UZ30qsz+/5J
         XcgP/y4/SIkXrBSNVCMfZBm7/Hh+nCiLLzRSqxpU2COJS55et2GhR7mOcM+F9ti4lJ0v
         IwCQ==
X-Gm-Message-State: ACrzQf04aZTauT35MyjtvVzKlLWsBy75yV68ucejjxybfaZ6SRQz3pQR
        kgFAjFhZB5HPJau8106QDPuBboKYdbORMA1V13ZB7g==
X-Google-Smtp-Source: AMsMyM6kMdc0KSJ2ed/MG+9WR+5ozoOFrFYW8ekGDznxwnOQtdfxzQGgP4vCb+iVI8/aQZfQmqL6Yy7v8bN+Uo9w7Gk=
X-Received: by 2002:a17:906:b08d:b0:782:d526:3e36 with SMTP id
 x13-20020a170906b08d00b00782d5263e36mr4115546ejy.358.1666128514819; Tue, 18
 Oct 2022 14:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221018164532.1705215-1-tommaso.merciai@amarulasolutions.com> <544c35c3-d87f-30e7-5f6b-a64ab7f894ec@tronnes.org>
In-Reply-To: <544c35c3-d87f-30e7-5f6b-a64ab7f894ec@tronnes.org>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Tue, 18 Oct 2022 23:28:23 +0200
Message-ID: <CAOf5uwnP+hc+hDKwQJq9HZ03hHXwwCWw3HE0-W16jF3WkKuHXA@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/tiny: add support tft display based on ilitek,ili9488
To:     =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        kamlesh.gurudasani@gmail.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Oct 18, 2022 at 9:06 PM Noralf Tr=C3=B8nnes <noralf@tronnes.org> wr=
ote:
>
>
>
> Den 18.10.2022 18.45, skrev Tommaso Merciai:
> > Hi All,
> > This series  support for ilitek,ili9488 based displays like
> > Waveshare-ResTouch-LCD-3.5 display. Tested on Waveshare-ResTouch-LCD-3.=
5
> > connected to px30-evb via SPI.
>
> There's a generic MIPI DBI SPI driver now that should work with all
> these panels: drivers/gpu/drm/tiny/panel-mipi-dbi.c
>
> More info: https://github.com/notro/panel-mipi-dbi/wiki
>

We have seen it but it does not apply to the color output and there is
no helper. I was a bit surprised
to have a generic panel for spi and not for standard mipi one.

Michael

> Noralf.
>
> > This series is based on work done by Kamlesh Gurudasani in 2020:
> >
> >  - "drm/tiny: add support for tft displays based on ilitek, ili9488"
> >
> > (Thanks Kamlesh for your starting point)
> >
> > Tests are done using the following tools coming from Yocto fs:
> >
> >  - modetest -M "ili9488" -s 31:320x480@RG16 -v
> >  - fb-test
> >  - fb-rect
> >
> > References:
> >  - https://patchwork.kernel.org/project/dri-devel/patch/00719f68aca488a=
6476b0dda634617606b592823.1592055494.git.kamlesh.gurudasani@gmail.com/
> >  - https://www.hpinfotech.ro/ILI9488.pdf
> >  - https://www.waveshare.com/wiki/Pico-ResTouch-LCD-3.5
> >
> > Regards,
> > Tommaso
> >
> > Tommaso Merciai (2):
> >   dt-bindings: add binding for tft displays based on ilitek,ili9488
> >   drm/tiny: add support for tft displays based on ilitek,ili9488
> >
> >  .../bindings/display/ilitek,ili9488.yaml      |  72 +++
> >  drivers/gpu/drm/tiny/Kconfig                  |  13 +
> >  drivers/gpu/drm/tiny/Makefile                 |   1 +
> >  drivers/gpu/drm/tiny/ili9488.c                | 440 ++++++++++++++++++
> >  4 files changed, 526 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/ilitek,il=
i9488.yaml
> >  create mode 100644 drivers/gpu/drm/tiny/ili9488.c
> >



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
