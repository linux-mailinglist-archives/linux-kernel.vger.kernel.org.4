Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E8A6F4C36
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjEBV2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjEBV2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C46E1FD7;
        Tue,  2 May 2023 14:27:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B659621E3;
        Tue,  2 May 2023 21:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35D0C4339E;
        Tue,  2 May 2023 21:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683062873;
        bh=jCPU9c2wabBAGUXBx0w4fzzWZn23Up45NdgJcoiuHoA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eCASTzM/iGukkSyOO1xmCKX08vb0J66EvmpJ3xPcKf4ZlD3wmx88HpXfuZPMMpFFT
         H9nbfyXLMAntej1+qO5mzf7D25AoWOYyo6F3Qs0gfY00G9VLPKiubPZCjXFz2PHHu0
         wV8rmFhh5MSb3R7uSp6vG/c1qEBLQ9Fyrti1+7MxiKPdWLVeaGThAwZ/3ZmkF1uhYp
         qxVCOztSnaupk/q8zkDhByFTTFDb/NaSjx22lihvXD/qaKs+w/Io65hRZu8dPnpfCR
         sSC+8Nr7DAdWBvwUebIO1ei86iSlHb0a83rhNweDpi64ARuvWXMUKmRSkeQgdY93NN
         Da8zc0cMqvOVQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2a8db10a5d4so44498691fa.1;
        Tue, 02 May 2023 14:27:53 -0700 (PDT)
X-Gm-Message-State: AC+VfDzmGDgoBzexWQk+bZHMgSzRMIO++wkrKQqRLgL9qQ4jnbfmkHEc
        31X30SK/4xkh6I8dATkXDcT8Lmmp0bQINzNXBQ==
X-Google-Smtp-Source: ACHHUZ4VmzJ58Blp8vkFEMpnZTP3rUtg0aygjDIMYeTMpSWAwJvPoANOd1LtrOl749GRPWYY5WO4jHHB7hvvVyp4ngc=
X-Received: by 2002:a2e:860b:0:b0:2a8:bb99:250d with SMTP id
 a11-20020a2e860b000000b002a8bb99250dmr5156347lji.6.1683062871907; Tue, 02 May
 2023 14:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com> <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <CACRpkdZx6vEVnxVt0tW4nYtnbv8g=Dc11sa_3myB3GW4jXk1oA@mail.gmail.com>
In-Reply-To: <CACRpkdZx6vEVnxVt0tW4nYtnbv8g=Dc11sa_3myB3GW4jXk1oA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 2 May 2023 16:27:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKzof_mYRw9Dd0YAVWr1AFoO8gwkVUR22AJX_RF2xv0aA@mail.gmail.com>
Message-ID: <CAL_JsqKzof_mYRw9Dd0YAVWr1AFoO8gwkVUR22AJX_RF2xv0aA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
To:     Linus Walleij <linus.walleij@linaro.org>
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

On Tue, May 2, 2023 at 4:19=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Tue, May 2, 2023 at 9:40=E2=80=AFPM Rob Herring <robh+dt@kernel.org> w=
rote:
>
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
>
> I see my nits were fixed like I wanted them, and it's now mostly a
> mix of soc and vendor names that make sense so from my point of view:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> NB:
> arch/arm64/boot/dts/arm$
> vexpress-v2m-rs1.dtsi -> ../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi
>
> This still works after the script, yes?

Yes, because in the script I do:

git grep -l -F "vexpress-v2m-rs1" arch/arm64/boot/dts | xargs perl -p
-i -e "s/vexpress-v2m-rs1/arm\/arm\/vexpress-v2m-rs1/"

Rob
