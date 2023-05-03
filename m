Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FAB6F4E68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 03:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjECBRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 21:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjECBRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 21:17:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D7D2D69;
        Tue,  2 May 2023 18:17:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1290629CE;
        Wed,  3 May 2023 01:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B903C433A4;
        Wed,  3 May 2023 01:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683076652;
        bh=hzNYaAPUaGLZ1v0sTCo4kr9f/IJ1faX5mnRj5TAeAKs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QMxxEJKiF/Xy/wpJ45M6Vv6cDRwnVgmz71oBe+yu+VPg0ZvwY64iyWw1oPr8JUNsE
         0+NbSQmo02gKsS9daJssd0DmAziCO02D1v+rCR9/TCg9DRmRIzIHHDkEC5EBHq42cC
         iZJESeEwfq5QYqjYTczZHNt4kDZ5i7w0VJs1GJao3IU+1auKFA2BykAAE5UNE3BtXQ
         aC4MLEcHqVgH0EAnYnpuUjEij93YdOr8eL89gHougN+yaCFsiDwKF73MyP/ntMVVx7
         Z0tyl6sVDb0DoXY+oCDA68mFlGLNWyOY++rZwaVyScUlpxomtUHulQA3qlYqFCh+jI
         ZWyTVi+oNLAKA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4efe8991bafso5827118e87.0;
        Tue, 02 May 2023 18:17:31 -0700 (PDT)
X-Gm-Message-State: AC+VfDzOGuDHTJ8vgpfZ2SIogWx5lN3a+TZgCbJBjTPRL6Re+O7Uf5XY
        Pr0kzft79MeZsmfY0mvuMefmJ1XDurLSBZ5MXQ==
X-Google-Smtp-Source: ACHHUZ55e+9yQPQvr0rpIhj0RbrnT2KB6aoc0WjPIM2H1fvT2bLnAwsd1znjwXMKc8qD22lf5irJ3k12RJA0LJgPE6Y=
X-Received: by 2002:a05:6512:964:b0:4ea:c730:aabe with SMTP id
 v4-20020a056512096400b004eac730aabemr592385lft.20.1683076649996; Tue, 02 May
 2023 18:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com> <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <bce93654-fc36-3d12-282d-76fafb8f51ce@linaro.org>
In-Reply-To: <bce93654-fc36-3d12-282d-76fafb8f51ce@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 2 May 2023 20:17:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJXd_EpOQwwNEAn25mzFfkhEvqzur6ui5Ca+dbt2kA8-Q@mail.gmail.com>
Message-ID: <CAL_JsqJXd_EpOQwwNEAn25mzFfkhEvqzur6ui5Ca+dbt2kA8-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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

On Tue, May 2, 2023 at 5:52=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 02/05/2023 22:40, Rob Herring wrote:
> > On Tue, May 2, 2023 at 3:15=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wr=
ote:
> >>
> >> On Tue, Apr 25, 2023, at 17:57, Rob Herring wrote:
> >>> On Tue, Apr 25, 2023 at 2:28=E2=80=AFAM Geert Uytterhoeven <geert@lin=
ux-m68k.org> wrote:
> >>>
> >>>> Does your script also cater for .dts files not matching any pattern,
> >>>> but including a .dtsi file that does match a pattern?
> >>>
> >>> I assume I built everything after moving, but maybe not...
> >>>
> >>> That's all just "details". First, we need agreement on a) moving
> >>> things to subdirs and b) doing it 1-by-1 or all at once. So far we've
> >>> been stuck on a) for being 'too much churn'.
> >>
> >> Sorry for missing most of the discussion last week. The script sounds
> >> fine to me, the only reason I didn't want to do this in the past is th=
at
> >> we had the plan to move platforms out of the kernel tree to an externa=
l
> >> repository and I wanted to do this platform at a time and also only mo=
ve
> >> each one once. I don't think that is going to happen anytime soon now,
> >> so let's just do your script.
> >>
> >> Can you send me the script and/or a pull request of the resulting
> >> tree based on my soc/dt branch? Everything is merged upstream,
> >> and I think git-merge would handle the remaining merges with any
> >> other changes in mainline.
> >
> > I've dusted off my script and made a branch[1] with the result.
> > There's just a couple of fixes needed after the script is run (see the
> > top commit). The cross arch includes are all fixed up by the script.
> > dtbs_install maintains a flat install. I compared the number of .dtbs
> > before and after to check the script.
> >
> > I think the only issue remaining is finalizing the mapping of
> > platforms to subdirs. What I have currently is a mixture of SoC
> > families and vendors. The most notable are all the Freescale/NXP
> > platforms, pxa, socfpga, and stm32. It's not consistent with arm64
> > either. Once that's finalized, I still need to go update MAINTAINERS.
> >
> > Here's the current mapping:
> >
> > vendor_map =3D {
> >      'alphascale' : 'alphascale',
> >      'alpine' : 'alpine',
> >      'artpec' : 'axis',
> >      'axm' : 'lsi',
> >      'cx9' : 'cnxt',
> >      'ecx' : 'calxeda',
> >      'highbank' : 'calxeda',
> >      'ep7' : 'cirrus',
> >      'mxs': 'mxs',
> >      'imx23': 'mxs',
> >      'imx28': 'mxs',
> >      'sun' : 'allwinner',
> >      'imx': 'imx',
> >      'e6' : 'imx',
> >      'e7' : 'imx',
> >      'mba6' : 'imx',
> >      'ls': 'fsl',
> >      'vf': 'fsl',
> >      'qcom': 'qcom',
> >      'am3' : 'ti',
> >      'am4' : 'ti',
> >      'am5' : 'ti',
> >      'dra' : 'ti',
> >      'keystone' : 'ti',
> >      'omap' : 'ti',
> >      'compulab' : 'ti',
> >      'logicpd' : 'ti',
> >      'elpida' : 'ti',
> >      'motorola' : 'ti',
> >      'twl' : 'ti',
> >      'da' : 'ti',
> >      'dm' : 'ti',
> >      'nspire' : 'nspire',
> >      'armada' : 'marvell',
> >      'dove' : 'marvell',
> >      'kirkwood' : 'marvell',
> >      'orion' : 'marvell',
> >      'mvebu' : 'marvell',
> >      'mmp' : 'marvell',
> >      'berlin' : 'berlin',
> >      'pxa2' : 'pxa',
> >      'pxa3' : 'pxa',
> >      'pxa' : 'marvell',
>
> I'd question if it makes sense to split the pxa line. Yes, it was sold
> by Intel to Marvell, but IIRC the devices still had some inheritance.
> So, if we have the 'pxa' subdir, I'd move Marvell PXAs to that dir too.

I think I probably split it because it was different maintainers.
Though it doesn't look like pxa168 or pxa910 have any maintainer. They
are a mixture of pxa and mmp I think.

Rob
