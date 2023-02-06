Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A41768C21D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjBFPrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjBFPrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:47:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1978A18A88;
        Mon,  6 Feb 2023 07:46:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C715560F4E;
        Mon,  6 Feb 2023 15:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F41C433AC;
        Mon,  6 Feb 2023 15:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675698392;
        bh=joRqx9Li9igfnC0oG6IHKkgO3cLoL5bazL6HXykW/Yk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JKn8eNaNJ4rikGY741Uy2+0jJ1t1CJnAt8eg4J/uwsGU91pzRtO8LzlwrMivN/3gp
         NceZa7of2rRpKnlzWWzal3WG40MtjMiIMZbaaoryIEx5QnsmTtPNSjX1udoaGNzRgT
         G+0+/6/mSUKlYDeinY+kmlCkoNaAKjbzQ/q6lmdGksIlr79l0R/s2IlClC45wK/H/E
         fJpyE8hsh7Nvh7Mo7QpuruZlyTxIR5J+/Sc4WgFdeTJJXmiyjrjIITLKZjrsHzdSZd
         FEGytUJ0kxZNmw6G78c7gyEYYv0ewaiHvm/ZsVrn0EfCLdlY3P0oMyVb9DDjyQy+q2
         tg7Sjb+4UeVag==
Received: by mail-vs1-f47.google.com with SMTP id g3so1731094vsr.10;
        Mon, 06 Feb 2023 07:46:32 -0800 (PST)
X-Gm-Message-State: AO0yUKUYdTS3kojaJmbY1uJoPKr4UCcTxOdztk7JNXWFG3p/nyEuaTEs
        YkF8Ljkj5pG/VAVwMddO1mGoXxanUQA0pWv3+A==
X-Google-Smtp-Source: AK7set8Tk9obdWMlC2bGawE53EVM/Oy5EZ7J8YanM63uhthmowerxVZw/LM6nc9a1zR0V1hhJv6Nifwjl9aigUei0n0=
X-Received: by 2002:a67:cc1d:0:b0:3f3:5ce0:85ab with SMTP id
 q29-20020a67cc1d000000b003f35ce085abmr38443vsl.26.1675698390984; Mon, 06 Feb
 2023 07:46:30 -0800 (PST)
MIME-Version: 1.0
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
 <20230203182119.GA615242-robh@kernel.org> <87f5097d-1cd0-e09f-e759-8592a9165ea6@gmail.com>
 <5647788.DvuYhMxLoT@diego>
In-Reply-To: <5647788.DvuYhMxLoT@diego>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 6 Feb 2023 09:46:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJJcRx0XAJmsS6Q-AmNGDd+bWPVgW1yLBq6o2kmxiEFAg@mail.gmail.com>
Message-ID: <CAL_JsqJJcRx0XAJmsS6Q-AmNGDd+bWPVgW1yLBq6o2kmxiEFAg@mail.gmail.com>
Subject: Re: [PATCH v6 01/17] dt-bindings: display: rockchip: convert
 rockchip-lvds.txt to YAML
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Johan Jonker <jbx6244@gmail.com>, hjc@rock-chips.com,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, philippe.cornu@foss.st.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        linus.walleij@linaro.org, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org
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

On Sun, Feb 5, 2023 at 8:12 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Freitag, 3. Februar 2023, 20:02:54 CET schrieb Johan Jonker:
> >
> > On 2/3/23 19:21, Rob Herring wrote:
> > > On Thu, Dec 22, 2022 at 03:22:14PM +0100, Johan Jonker wrote:
> > >> Convert rockchip-lvds.txt to YAML.
> > >>
> > >> Changed:
> > >>   Add power-domains property.
> > >>   Requirements between PX30 and RK3288
> > >>
> > >> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > >> Reviewed-by: Rob Herring <robh@kernel.org>
> > >> ---
> > >>
> > >> Changed V3:
> > >>   Filename matching compatible style
> > >>   Drop "Regulator phandle for "
> > >>   Specify properties and requirements per SoC
> > >>   Sort order and restyle
> > >>
> > >> Changed V2:
> > >>   Fix title
> > >> ---
> > >>  .../display/rockchip/rockchip,lvds.yaml       | 170 +++++++++++++++=
+++
> > >>  .../display/rockchip/rockchip-lvds.txt        |  92 ----------
> > >>  2 files changed, 170 insertions(+), 92 deletions(-)
> > >>  create mode 100644 Documentation/devicetree/bindings/display/rockch=
ip/rockchip,lvds.yaml
> > >>  delete mode 100644 Documentation/devicetree/bindings/display/rockch=
ip/rockchip-lvds.txt
> > >
> >
> > > What's the plan for these patches? Don't see them in linux-next still=
.
> > > Do you want me to take patches 1-8?
> >
> > Hi,
> >
> > The display patches normally go through the DRM git.
> > Patch 2 must merge with grf.yaml.
> > Heiko has merged now 3 PHY related patches to grf.yaml first.
> >
> > [PATCH v6 02/17] dt-bindings: soc: rockchip: grf: add rockchip,lvds.yam=
l
> >
> > See current
> > https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.gi=
t/log/?h=3Dfor-next&qt=3Dgrep&q=3Djonker
> >
> > Not sure what Heiko's plans are.
> > Patch 2 replaces  only a description text and some accolades removal, s=
o not "too" important.
> >
> > I urgent then you could merge without conflict:
> > 1, 3-8
>
> So I've applied patches 1-7 to the drm-tree now.

That would have been good a month ago. Now these won't land til 6.4.
:( For that reason, if it is after the drm-misc cutoff, I prefer to
take DT bindings via my tree.

> For the GRF-patch, I've dropped the quotes changes, as they are somewhat
> unrelated to the lvds inclusion and so prevented any conflicts when apply=
ing
> the rest to the DRM tree.

Only 1 hunk needed to be dropped to avoid the conflict (which also
dropped quotes). If all the quote changes were dropped, please send
another patch for that.

> @Rob, if you could pick the fusb302 patch (number8), that would be great

Will do.

Rob
