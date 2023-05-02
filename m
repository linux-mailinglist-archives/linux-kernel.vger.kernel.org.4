Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DE76F4A7C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 21:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjEBTkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 15:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEBTkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 15:40:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290869E;
        Tue,  2 May 2023 12:40:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2E7D620AE;
        Tue,  2 May 2023 19:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AD3C4339E;
        Tue,  2 May 2023 19:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683056435;
        bh=9Dokck6Jc4naZGVhGmqgJoJLIGEOHwC1dkDJ1O4Mipg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iGl2fDpG6u+V7nw9XiF//RgP2qeZBecdfPEueb6HbN4e9bmh+rMmyTGvoJLh7U0IN
         LT34Sz26U9ehDgNU9xWS2cGEUZMofynDqCr3NMtbyMjGcM7Ig7XSHoWMlWBe61LHXK
         foLe03MQ+bujtF/31rycC13DeFqREes6CUthTP2NucBb4VgBQHzmK8qPa10Q9tcJfT
         kGl1UrAJYytqHUS+kOaWhu7l1nLj3tflKoPvaGU5xVR382p8EsxG5UXDV4YqhNrt0H
         gKKH9JwAQNWbY4QwmuAxfFPQMrV5eeoP/Nm8Xjp3aXp2elQ+yUvR0d0n0PahunLwSd
         cPLAVqB30txpQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ab25e8a4a7so42562611fa.3;
        Tue, 02 May 2023 12:40:34 -0700 (PDT)
X-Gm-Message-State: AC+VfDzz4UFGujsu7oNd6erhc3aE43prRHFuJi1VoB6g0h/RU/rMPrjt
        w8YGHihaI1wzdcDXtg3QuRn5oWdubKmfNswUEQ==
X-Google-Smtp-Source: ACHHUZ4oET00FnB+Fs3paO2KFWP6eBEztecawKM1A53Y541JaZi1w2Ra1iVebif6hgPcY0x6Ou0Xe91anOEl+A8jdBw=
X-Received: by 2002:a2e:8801:0:b0:2a8:b995:ffe5 with SMTP id
 x1-20020a2e8801000000b002a8b995ffe5mr4898960ljh.25.1683056432976; Tue, 02 May
 2023 12:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com> <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
In-Reply-To: <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 2 May 2023 14:40:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
Message-ID: <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 3:15=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Apr 25, 2023, at 17:57, Rob Herring wrote:
> > On Tue, Apr 25, 2023 at 2:28=E2=80=AFAM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> >
> >> Does your script also cater for .dts files not matching any pattern,
> >> but including a .dtsi file that does match a pattern?
> >
> > I assume I built everything after moving, but maybe not...
> >
> > That's all just "details". First, we need agreement on a) moving
> > things to subdirs and b) doing it 1-by-1 or all at once. So far we've
> > been stuck on a) for being 'too much churn'.
>
> Sorry for missing most of the discussion last week. The script sounds
> fine to me, the only reason I didn't want to do this in the past is that
> we had the plan to move platforms out of the kernel tree to an external
> repository and I wanted to do this platform at a time and also only move
> each one once. I don't think that is going to happen anytime soon now,
> so let's just do your script.
>
> Can you send me the script and/or a pull request of the resulting
> tree based on my soc/dt branch? Everything is merged upstream,
> and I think git-merge would handle the remaining merges with any
> other changes in mainline.

I've dusted off my script and made a branch[1] with the result.
There's just a couple of fixes needed after the script is run (see the
top commit). The cross arch includes are all fixed up by the script.
dtbs_install maintains a flat install. I compared the number of .dtbs
before and after to check the script.

I think the only issue remaining is finalizing the mapping of
platforms to subdirs. What I have currently is a mixture of SoC
families and vendors. The most notable are all the Freescale/NXP
platforms, pxa, socfpga, and stm32. It's not consistent with arm64
either. Once that's finalized, I still need to go update MAINTAINERS.

Here's the current mapping:

vendor_map =3D {
    'alphascale' : 'alphascale',
    'alpine' : 'alpine',
    'artpec' : 'axis',
    'axm' : 'lsi',
    'cx9' : 'cnxt',
    'ecx' : 'calxeda',
    'highbank' : 'calxeda',
    'ep7' : 'cirrus',
    'mxs': 'mxs',
    'imx23': 'mxs',
    'imx28': 'mxs',
    'sun' : 'allwinner',
    'imx': 'imx',
    'e6' : 'imx',
    'e7' : 'imx',
    'mba6' : 'imx',
    'ls': 'fsl',
    'vf': 'fsl',
    'qcom': 'qcom',
    'am3' : 'ti',
    'am4' : 'ti',
    'am5' : 'ti',
    'dra' : 'ti',
    'keystone' : 'ti',
    'omap' : 'ti',
    'compulab' : 'ti',
    'logicpd' : 'ti',
    'elpida' : 'ti',
    'motorola' : 'ti',
    'twl' : 'ti',
    'da' : 'ti',
    'dm' : 'ti',
    'nspire' : 'nspire',
    'armada' : 'marvell',
    'dove' : 'marvell',
    'kirkwood' : 'marvell',
    'orion' : 'marvell',
    'mvebu' : 'marvell',
    'mmp' : 'marvell',
    'berlin' : 'berlin',
    'pxa2' : 'pxa',
    'pxa3' : 'pxa',
    'pxa' : 'marvell',
    'arm-' : 'arm',
    'integ' : 'arm',
    'mps' : 'arm',
    've' : 'arm',
    'aspeed' : 'aspeed',
    'ast2' : 'aspeed',
    'facebook' : 'aspeed',
    'ibm' : 'aspeed',
    'openbmc' : 'aspeed',
    'en7' : 'airoha',
    'at91' : 'microchip',
    'sama' : 'microchip',
    'sam9' : 'microchip',
    'usb_' : 'microchip',
    'tny_' : 'microchip',
    'mpa1600' : 'microchip',
    'animeo_ip' : 'microchip',
    'aks-cdu' : 'microchip',
    'ethernut5' : 'microchip',
    'evk-pro3' : 'microchip',
    'pm9g45' : 'microchip',
    'ge86' : 'microchip',
    'bcm' : 'brcm',
    'exynos' : 'samsung',
    's3c' : 'samsung',
    's5p' : 'samsung',
    'gemini' : 'gemini',
    'hi3' : 'hisilicon',
    'hip' : 'hisilicon',
    'hisi' : 'hisilicon',
    'sd5' : 'hisilicon',
    'hpe' : 'hpe',
    'intel': 'intel',
    'mt' : 'mediatek',
    'meson' : 'meson',
    'moxa' : 'moxa',
    'mstar' : 'mstar',
    'nuvo' : 'nuvoton',
    'lpc' : 'lpc',
    'lan96' : 'microchip',
    'owl' : 'actions',
    'ox8' : 'oxsemi',
    'rda' : 'rda',
    'rtd' : 'realtek',
    'r7' : 'renesas',
    'r8' : 'renesas',
    'r9' : 'renesas',
    'emev2' : 'renesas',
    'sh73a' : 'renesas',
    'gr-' : 'renesas',
    'iwg' : 'renesas',
    'rk' : 'rockchip',
    'rv11' : 'rockchip',
    'rockchip' : 'rockchip',
    'socfpga' : 'socfpga',
    'stm' : 'stm32',
    'sti' : 'sti',
    'st-pin' : 'sti',
    'ste' : 'st-ericsson',
    'spear' : 'spear',
    'axp' : 'allwinner',
    'tegra' : 'nvidia',
    'milbeaut' : 'socionext',
    'uniph' : 'socionext',
    'vt8500' : 'vt8500',
    'wm8' : 'vt8500',
    'xen' : 'xen',
    'zx' : 'zte',
    'zynq' : 'xilinx',
}

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git arm-dts-mo=
ve-v2
