Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111846F6141
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjECWWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjECWWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:22:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5D57D9E;
        Wed,  3 May 2023 15:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C95DF6305C;
        Wed,  3 May 2023 22:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BE2C433A8;
        Wed,  3 May 2023 22:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683152567;
        bh=3fU8zKQCl4Kz1eWXPpHONjdIQH2Taxo8c7rFXpP8al8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gyKS6MttCNtMBfY1UbH64Gxs+WPEh98Gt6OT01M40SteIWEK5rSEDwur1RaXFO+KB
         k1tdcAAsc2c2rzXvd1weeyyawHuQ8Lq59qhupvTSHCEywGQVnNLirhUV5LFKBX8xed
         l0/UGIQ3CmVjXekItREFnJAzg+8iaG+wi29nNBk6X2ZIHAF+OpORY7hcZEXw8ggyI7
         lqhuUpVxEH1ffbseQZUFxUdR9etC+52u7eYE9GhWMkOLouRSZWF2P5Zy0o7/nRvHLU
         sdqmfLYRY9trzvPKYYsZ5exHv0HiJ28pGmOXf1C9Ug/qGMH9We/64sSgv1jQPsw+Ts
         HEEttqKJrWkpw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4eff4ea8e39so6629946e87.1;
        Wed, 03 May 2023 15:22:47 -0700 (PDT)
X-Gm-Message-State: AC+VfDwcjFjpxgpvwx/xjNV9IQuAxkgbI5G3tn4jZA22Ob7XCoVB3rm2
        OozWR8Cwyhdt1FF41qXllLAt13GXoBYRCpAM1Q==
X-Google-Smtp-Source: ACHHUZ7HeoGV7sGaLAr5Tc+TosYIxgwnkvp5ZEsh8Jj7wpXuo0FJb1Bm44GqyVTuGr9wlxbZQ+2RYfnrH8bg8TYUOtU=
X-Received: by 2002:a19:ee03:0:b0:4ea:fa26:2378 with SMTP id
 g3-20020a19ee03000000b004eafa262378mr1222041lfb.23.1683152565137; Wed, 03 May
 2023 15:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com> <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <bce93654-fc36-3d12-282d-76fafb8f51ce@linaro.org> <CAL_JsqJXd_EpOQwwNEAn25mzFfkhEvqzur6ui5Ca+dbt2kA8-Q@mail.gmail.com>
 <5e318b02-8f33-4e2d-a956-5660e1c60619@app.fastmail.com> <CAA8EJpq8x5wQa3fMebaSP3hCdMiCsZRaF+B4Y3N3royW_CeXCA@mail.gmail.com>
 <4e1e70a9-9b28-410b-bd29-fb5f5805798f@app.fastmail.com> <CAL_JsqJEdZBS231TvkmmipaXEqzvDjz+A32V6uJ4zfSMAJHn2w@mail.gmail.com>
 <4d9b4159-88b2-48cf-84d9-34169928c8e4@app.fastmail.com>
In-Reply-To: <4d9b4159-88b2-48cf-84d9-34169928c8e4@app.fastmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 3 May 2023 17:22:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLi+h3E8wEjuzjdh-VhWac8VJAfBeAKAHMny=gg=-OQgQ@mail.gmail.com>
Message-ID: <CAL_JsqLi+h3E8wEjuzjdh-VhWac8VJAfBeAKAHMny=gg=-OQgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Olof Johansson <olof@lixom.net>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        linux-arm-msm@vger.kernel.org, linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 3:37=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, May 3, 2023, at 15:16, Rob Herring wrote:
>
> > We could do a second level of directories here:
>
> Works for me, but at that point, I'd really also want to do it
> for nxp with its five or more product lines (mxs, imx, lpc,
> s32, layerscape, vybrid)

And marvell, microchip(lan96), ti, and broadcom probably. I think I
withdraw my suggestion...

Rob
