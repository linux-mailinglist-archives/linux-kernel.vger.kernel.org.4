Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D09E74DA11
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGJPkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjGJPkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:40:31 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E58AD1;
        Mon, 10 Jul 2023 08:40:28 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qIszV-0001o1-8T; Mon, 10 Jul 2023 17:39:57 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>, robh+dt@kernel.org,
        conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     d3adme4t@gmail.com, macromorgan@hotmail.com, jbx6244@gmail.com,
        f.kardame@manjaro.org, amadeus@jmu.edu.cn, linux.amoon@gmail.com,
        aurelien@aurel32.net, anarsoul@gmail.com, wiagn233@outlook.com,
        frattaroli.nicolas@gmail.com, strit@manjaro.org,
        luiz.von.dentz@intel.com, zonyitoo@gmail.com, wens@csie.org,
        jensenhuang@friendlyarm.com, lasstp5011@gmail.com,
        frank-w@public-files.de, pgwipeout@gmail.com, leo@nabam.net,
        andyshrk@163.com, michael.riesch@wolfvision.net, jonas@kwiboo.se,
        festevam@denx.de, tobetter@gmail.com, jagan@amarulasolutions.com,
        cnsztl@gmail.com, cristian.ciocaltea@collabora.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: Drop invalid regulator-init-microvolt
 property
Date:   Mon, 10 Jul 2023 17:39:55 +0200
Message-ID: <4519023.cEBGB3zze1@phil>
In-Reply-To: <87wmz7q1fr.fsf@bloch.sibelius.xs4all.nl>
References: <20230707162217.675390-1-cristian.ciocaltea@collabora.com>
 <168899855919.1747213.9998138836668928892.b4-ty@sntech.de>
 <87wmz7q1fr.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 10. Juli 2023, 16:35:36 CEST schrieb Mark Kettenis:
> > From: Heiko Stuebner <heiko@sntech.de>
> > Date: Mon, 10 Jul 2023 16:16:16 +0200
> > 
> > On Fri, 7 Jul 2023 19:22:17 +0300, Cristian Ciocaltea wrote:
> > > The 'regulator-init-microvolt' property is not currently supported by
> > > any driver, it was simply carried on from downstream kernels.
> > > 
> > > The problem is also indicated by the following dtbs_check warning:
> > > 
> > >   rk3588-rock-5b.dtb: pmic@0: regulators:dcdc-reg4: Unevaluated properties are not allowed ('regulator-init-microvolt' was unexpected)
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/1] arm64: dts: rockchip: Drop invalid regulator-init-microvolt property
> >       commit: 4d08b19629495b29601991d09d07865694c25199
> 
> This property *is used* by the drivers in U-Boot.  Dropping this from
> the Linux DTBs will likely result in broken boards the next time the
> U-Boot DTBs are synched again from Linux.  At least that is what
> happened before...
> 
> I think the right solution is to add this property to the DT binding
> instead.

I do have this vague memory of this coming up in the past, though don't
remember what the resolution was then? Though it definitly doesn't look
like the property was added to the binding in the meantime.

Also I think that setting up initial regulator state would be (and
seemingly is) for firmware to handle, so that property should instead
be in the -uboot.dtsi.

That DT isn't a configuration-space also is a decade long mantra.


Heiko


