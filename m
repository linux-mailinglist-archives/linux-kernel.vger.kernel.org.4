Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0887D6F4E75
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 03:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjECBTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 21:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECBTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 21:19:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9488C5;
        Tue,  2 May 2023 18:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56902629F5;
        Wed,  3 May 2023 01:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A491C433D2;
        Wed,  3 May 2023 01:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683076779;
        bh=/ClN072w7D0BeanxCvNBxwRHREUHQZYiL77EUxvntHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVZeDMEmw3ok5p7/Jokl5bNCXoQM891Tszn/Thv4zoccfzdzf7iHFIpWlAS0tyFpX
         AA7SIMVFkbkYY5BWamH6TXc+Z4lBpRRw/BuCp0bg7BjTsUVZrM3wqhddMLNOBEqtCs
         iokjjjqiG3GqW0VqYJKaWIQpd6Q+V0thg4cB4zRnaTSa9V24b7++ydOgA3W/HzZ8PC
         UWZO6ttjeoJqXl+BqEV6mBqbjoqkHY/IX5QVwWKf09zlT/tidsYX0jfpN0ED1RsGYc
         11tcJfs9v4CYDwdvCCUAUixITcxX98mDPAOJAgRNKRIxD9/FJHjnGP5J0TfstHwO9a
         Jao70lg62pHUg==
Date:   Wed, 3 May 2023 09:19:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Olof Johansson <olof@lixom.net>,
        Christian Marangi <ansuelsmth@gmail.com>,
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
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Message-ID: <20230503011920.GB31464@dragon>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <2783a3ba-8fcb-7e5f-3147-91d02e573ba4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2783a3ba-8fcb-7e5f-3147-91d02e573ba4@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 10:02:03PM +0200, Krzysztof Kozlowski wrote:
> On 02/05/2023 21:40, Rob Herring wrote:
> > On Tue, May 2, 2023 at 3:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> On Tue, Apr 25, 2023, at 17:57, Rob Herring wrote:
> >>> On Tue, Apr 25, 2023 at 2:28 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
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
> >> fine to me, the only reason I didn't want to do this in the past is that
> >> we had the plan to move platforms out of the kernel tree to an external
> >> repository and I wanted to do this platform at a time and also only move
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
> > vendor_map = {
> >     'alphascale' : 'alphascale',
> >     'alpine' : 'alpine',
> >     'artpec' : 'axis',
> >     'axm' : 'lsi',
> >     'cx9' : 'cnxt',
> >     'ecx' : 'calxeda',
> >     'highbank' : 'calxeda',
> >     'ep7' : 'cirrus',
> >     'mxs': 'mxs',
> >     'imx23': 'mxs',
> >     'imx28': 'mxs',
> >     'sun' : 'allwinner',
> >     'imx': 'imx',
> >     'e6' : 'imx',
> >     'e7' : 'imx',
> >     'mba6' : 'imx',
> >     'ls': 'fsl',
> >     'vf': 'fsl',
> 
> If I remember correctly, Vybrid are a bit closer to iMX than to LS
> (Layerscape), but it should be Shawn's call (+Cc).

I would suggest to have all Freescale/NXP platforms in a single
directory, which includes all mxs, imx, fsl ones.

Shawn

> 
> >     'qcom': 'qcom',
> >     'am3' : 'ti',
> >     'am4' : 'ti',
> >     'am5' : 'ti',
> >     'dra' : 'ti',
> >     'keystone' : 'ti',
> >     'omap' : 'ti',
> >     'compulab' : 'ti',
> >     'logicpd' : 'ti',
> >     'elpida' : 'ti',
> >     'motorola' : 'ti',
> >     'twl' : 'ti',
> >     'da' : 'ti',
> >     'dm' : 'ti',
> >     'nspire' : 'nspire',
> >     'armada' : 'marvell',
> >     'dove' : 'marvell',
> >     'kirkwood' : 'marvell',
> >     'orion' : 'marvell',
> >     'mvebu' : 'marvell',
> >     'mmp' : 'marvell',
> >     'berlin' : 'berlin',
> >     'pxa2' : 'pxa',
> >     'pxa3' : 'pxa',
> >     'pxa' : 'marvell',
> >     'arm-' : 'arm',
> >     'integ' : 'arm',
> >     'mps' : 'arm',
> >     've' : 'arm',
> >     'aspeed' : 'aspeed',
> >     'ast2' : 'aspeed',
> >     'facebook' : 'aspeed',
> >     'ibm' : 'aspeed',
> >     'openbmc' : 'aspeed',
> >     'en7' : 'airoha',
> >     'at91' : 'microchip',
> >     'sama' : 'microchip',
> >     'sam9' : 'microchip',
> >     'usb_' : 'microchip',
> >     'tny_' : 'microchip',
> >     'mpa1600' : 'microchip',
> >     'animeo_ip' : 'microchip',
> >     'aks-cdu' : 'microchip',
> >     'ethernut5' : 'microchip',
> >     'evk-pro3' : 'microchip',
> >     'pm9g45' : 'microchip',
> >     'ge86' : 'microchip',
> >     'bcm' : 'brcm',
> >     'exynos' : 'samsung',
> >     's3c' : 'samsung',
> >     's5p' : 'samsung',
> 
> For samsung looks good.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> >     'gemini' : 'gemini',
> >     'hi3' : 'hisilicon',
> >     'hip' : 'hisilicon',
> >     'hisi' : 'hisilicon',
> >     'sd5' : 'hisilicon',
> >     'hpe' : 'hpe',
> >     'intel': 'intel',
> >     'mt' : 'mediatek',
> >     'meson' : 'meson',
> >     'moxa' : 'moxa',
> >     'mstar' : 'mstar',
> >     'nuvo' : 'nuvoton',
> >     'lpc' : 'lpc',
> >     'lan96' : 'microchip',
> >     'owl' : 'actions',
> >     'ox8' : 'oxsemi',
> >     'rda' : 'rda',
> >     'rtd' : 'realtek',
> >     'r7' : 'renesas',
> >     'r8' : 'renesas',
> >     'r9' : 'renesas',
> >     'emev2' : 'renesas',
> >     'sh73a' : 'renesas',
> >     'gr-' : 'renesas',
> >     'iwg' : 'renesas',
> >     'rk' : 'rockchip',
> >     'rv11' : 'rockchip',
> >     'rockchip' : 'rockchip',
> >     'socfpga' : 'socfpga',
> >     'stm' : 'stm32',
> >     'sti' : 'sti',
> >     'st-pin' : 'sti',
> >     'ste' : 'st-ericsson',
> >     'spear' : 'spear',
> >     'axp' : 'allwinner',
> >     'tegra' : 'nvidia',
> >     'milbeaut' : 'socionext',
> >     'uniph' : 'socionext',
> >     'vt8500' : 'vt8500',
> >     'wm8' : 'vt8500',
> >     'xen' : 'xen',
> >     'zx' : 'zte',
> >     'zynq' : 'xilinx',
> 
> The rest looks good to me, but I don't know half of these :)
> 
> Best regards,
> Krzysztof
> 
