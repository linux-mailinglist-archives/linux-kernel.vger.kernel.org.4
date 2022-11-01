Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A0661553F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiKAWoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiKAWob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:44:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746811EC5A;
        Tue,  1 Nov 2022 15:44:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 310E9B81D5E;
        Tue,  1 Nov 2022 22:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FEEC433C1;
        Tue,  1 Nov 2022 22:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667342667;
        bh=T6X814n6uuTYX8qCVDxnR9LEQXhgOnylT/BCSSOXgcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QpO9D/fe8DhXU6Kc3sJNxz19TIDYCDSNG3L5Zor7VeH2SbBmpcTSoH5rsixqORotF
         oFYD/gKUWl45Ob+eFZnFKHesrKq/JSyBVEoPzhhm1dGIeWQwC0fpn4i3ymqDeee1nt
         e4VryfWSu+dGqHpRIEr6eFRmhe6reQaTaJAJhCY5im3Lg4RrNfnf/6z/Ej5Or65PQ0
         9dicT9v5wZDHAUzVG1zv4qPKHuXyIs+WYerszSl3HT6BomMdR9Z0Q0BpjVyBY7Ky3u
         1Efv9/K403cvC47lhxj6nGsI3nHXA8CagkhtKBcW0DphA1Yqcz0FEdB6vY3pie7IXp
         R2BhKYgrMLjQg==
Received: by pali.im (Postfix)
        id 94BFB7F8; Tue,  1 Nov 2022 23:44:25 +0100 (CET)
Date:   Tue, 1 Nov 2022 23:44:25 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] ARM: dts: armada-38x: Fix compatible string for
 gpios
Message-ID: <20221101224425.huygrjriyhjwov5x@pali>
References: <20220714115515.5748-1-pali@kernel.org>
 <20220714183328.4137-1-pali@kernel.org>
 <20220714183328.4137-3-pali@kernel.org>
 <20220930233453.ixfj7ps2fo2jukjp@pali>
 <20221009120558.nb6mxipaijrhszt6@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221009120558.nb6mxipaijrhszt6@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING?

On Sunday 09 October 2022 14:05:58 Pali Rohár wrote:
> PING
> 
> On Saturday 01 October 2022 01:34:53 Pali Rohár wrote:
> > Gregory: ping
> > 
> > On Thursday 14 July 2022 20:33:27 Pali Rohár wrote:
> > > Armada 38x supports per CPU interrupts for gpios, like Armada XP. Pre-XP
> > > variants like Armada 370 do not support per CPU interrupts for gpios.
> > > 
> > > So change compatible string for Armada 38x from "marvell,armada-370-gpio"
> > > which indicates pre-XP variant to "marvell,armadaxp-gpio" which indicates
> > > XP variant or new.
> > > 
> > > Driver gpio-mvebu.c which handles both pre-XP and XP variants already
> > > provides support for per CPU interrupts on XP and newer variants.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > Fixes: 7cb2acb3fbae ("ARM: dts: mvebu: Add PWM properties for armada-38x")
> > > ---
> > >  arch/arm/boot/dts/armada-38x.dtsi | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> > > index df3c8d1d8f64..9343de6947b3 100644
> > > --- a/arch/arm/boot/dts/armada-38x.dtsi
> > > +++ b/arch/arm/boot/dts/armada-38x.dtsi
> > > @@ -292,7 +292,7 @@
> > >  			};
> > >  
> > >  			gpio0: gpio@18100 {
> > > -				compatible = "marvell,armada-370-gpio",
> > > +				compatible = "marvell,armadaxp-gpio",
> > >  					     "marvell,orion-gpio";
> > >  				reg = <0x18100 0x40>, <0x181c0 0x08>;
> > >  				reg-names = "gpio", "pwm";
> > > @@ -310,7 +310,7 @@
> > >  			};
> > >  
> > >  			gpio1: gpio@18140 {
> > > -				compatible = "marvell,armada-370-gpio",
> > > +				compatible = "marvell,armadaxp-gpio",
> > >  					     "marvell,orion-gpio";
> > >  				reg = <0x18140 0x40>, <0x181c8 0x08>;
> > >  				reg-names = "gpio", "pwm";
> > > -- 
> > > 2.20.1
> > > 
