Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A791772580B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbjFGIk2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jun 2023 04:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238524AbjFGIkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:40:21 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203571706;
        Wed,  7 Jun 2023 01:40:14 -0700 (PDT)
Received: from ip5b412278.dynamic.kabel-deutschland.de ([91.65.34.120] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1q6oi6-0006LM-Ch; Wed, 07 Jun 2023 10:40:06 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     Keith Zhao <keith.zhao@starfivetech.com>,
        Shengyu Qu <wiagn233@outlook.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com, Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: Re: [PATCH 1/9] dt-bindings: display: Add yamls for JH7110 display subsystem
Date:   Wed, 07 Jun 2023 10:40:04 +0200
Message-ID: <3560873.iIbC2pHGDl@diego>
In-Reply-To: <20230606-geometry-blurb-1f0f07d4bf6a@spud>
References: <20230602074043.33872-1-keith.zhao@starfivetech.com>
 <1991848.PYKUYFuaPT@diego> <20230606-geometry-blurb-1f0f07d4bf6a@spud>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 7. Juni 2023, 00:37:53 CEST schrieb Conor Dooley:
> On Wed, Jun 07, 2023 at 12:22:33AM +0200, Heiko Stübner wrote:
> > Am Dienstag, 6. Juni 2023, 20:41:17 CEST schrieb Shengyu Qu:
> > > > On Fri, Jun 02, 2023 at 03:40:35PM +0800, Keith Zhao wrote:
> > > >> Add bindings for JH7110 display subsystem which
> > > >> has a display controller verisilicon dc8200
> > > >> and an HDMI interface.
> 
> > > >> +description:
> > > >> +  The StarFive SoC uses the HDMI signal transmiter based on innosilicon IP
> > > > Is innosilicon the same thing as verisilicon? Also
> > > > s/transmiter/transmitter/, both here and in the title.
> > > 
> > > I think that is not the same, I remember Rockchip has used a HDMI 
> > > transmitter from
> > > 
> > > Innosilicon, and there is a existing driver for that in mainline.
> > 
> > Yep, I think Innosilicon is the company you turn to when you want to save
> > a bit of money ;-) . In the bigger SoCs Rockchip most of the time uses
> > Designware hdmi blocks and looking at the history only the rk3036 ever
> > used an Innosilicon block.
> > 
> > Looking at the history, 2016 really was a long time ago :-D.
> > 
> > > So Keith, if that's true, I think it is better to seperate the HDMI 
> > > stuff and reuse existing driver.
> > 
> > I'm not so sure about that - at least from a cursory glance :-) .
> > 
> > The registers do look slightly different and I don't know how much
> > the IP changed between the rk3036-version and the jh7110 version.
> > 
> > At the very least, I know my rk3036 board isn't booting right now, so
> > I can't really provide help for generalizing the rockchip-driver.
> > 
> > At the very least both the binding and driver could drop the "starfive-hdmi"
> > and actually use the Innosilicon in the naming somewhere, so that it's
> > clear for future developers :-)
> 
> Seeing "based on" always makes me a little bit nervous to be honest when
> it comes to using a compatible from the IP. Is it the IP? What version
> is it? etc. Perhaps "starfive,jh7110-hdmi" & falling back to some sort
> of "innosilicon,hdmi" would be more future/IP-silliness proof.
> Driver can always be generic & bind against "innosilicon,hdmi" until
> that becomes impossible.


what Connor said makes a lot of sense. Just name the compatible
after the actual implementation - aka "starfive,jh7110-hdmi" .

This is similar to what the rk3036 does with its
"rockchip,rk3036-inno-hdmi". That way you're nicely independent
and future proof.


Heiko


