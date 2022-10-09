Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E2F5F8B0E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiJIMFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJIMFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:05:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B9F2228A;
        Sun,  9 Oct 2022 05:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1F2760BC2;
        Sun,  9 Oct 2022 12:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F078BC433D6;
        Sun,  9 Oct 2022 12:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665317109;
        bh=sa1sssn/6Unn/pQ50a8PSKlsizjsCiE1zUUQARnh83Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYhivCEFFjHIN0oe9Zt1MRLwptLjNnmj2ZKeQJ7oWeW8YZy1ckr+NcdQrs+v6RA/W
         g5xaVgyQyaTSviqrZN2kGwSwmO1LLk0cDhOXe+14G/rl1/KL6mY2mwL8wq4QKwNrUA
         N3v0i6kSzZPSLozgVi1Kg1wZqQFO44TVtacLCUkYBa63AjnFHrxiblbUYS40Wc6GOf
         E4HQbW82GatKYWScuFUtDwiMA6W/UHZ4EYoN3MRpIF8oIiVVKbsYBoWErMar1DKIWe
         MpnNh4i/kufN4D/WtenE+nvAMzz6rtiUt3OvcA6VDpKzaOQYdLGmBX86yaWf1YaGbQ
         Zo0bAZBgL49iw==
Received: by pali.im (Postfix)
        id 26F917C1; Sun,  9 Oct 2022 14:05:06 +0200 (CEST)
Date:   Sun, 9 Oct 2022 14:05:06 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Josef Schlehofer <josef.schlehofer@nic.cz>
Subject: Re: [PATCH] powerpc: dts: turris1x.dts: Add channel labels for
 temperature sensor
Message-ID: <20221009120506.itwa4n25nljn2tll@pali>
References: <20220930123901.10251-1-pali@kernel.org>
 <20220930124618.kyaansrl7ls5kn3i@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220930124618.kyaansrl7ls5kn3i@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 September 2022 14:46:18 Pali Rohár wrote:
> + CC hwmon ML
> 
> On Friday 30 September 2022 14:39:01 Pali Rohár wrote:
> > Channel 0 of SA56004ED chip refers to internal SA56004ED chip sensor (chip
> > itself is located on the board) and channel 1 of SA56004ED chip refers to
> > external sensor which is connected to temperature diode of the P2020 CPU.
> > 
> > Fixes: 54c15ec3b738 ("powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers")
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> > With this change userspace 'sensors' applications prints labels:
> > 
> >     $ sensors
> >     sa56004-i2c-0-4c
> >     Adapter: MPC adapter (i2c@3000)
> >     board:        +34.2°C  (low  =  +0.0°C, high = +70.0°C)
> >                            (crit = +85.0°C, hyst = +75.0°C)
> >     cpu:          +58.9°C  (low  =  +0.0°C, high = +70.0°C)
> >                            (crit = +85.0°C, hyst = +75.0°C)
> > 
> > And without this change it prints just generic tempX names:
> > 
> >     $ sensors
> >     sa56004-i2c-0-4c
> >     Adapter: MPC adapter (i2c@3000)
> >     temp1:        +43.0°C  (low  =  +0.0°C, high = +70.0°C)
> >                            (crit = +85.0°C, hyst = +75.0°C)
> >     temp2:        +63.4°C  (low  =  +0.0°C, high = +70.0°C)
> >                            (crit = +85.0°C, hyst = +75.0°C)
> > ---
> >  arch/powerpc/boot/dts/turris1x.dts | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
> > index 4033c554b06a..5b5278c32e43 100644
> > --- a/arch/powerpc/boot/dts/turris1x.dts
> > +++ b/arch/powerpc/boot/dts/turris1x.dts
> > @@ -69,6 +69,20 @@
> >  				interrupt-parent = <&gpio>;
> >  				interrupts = <12 IRQ_TYPE_LEVEL_LOW>, /* GPIO12 - ALERT pin */
> >  					     <13 IRQ_TYPE_LEVEL_LOW>; /* GPIO13 - CRIT pin */
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				/* Local temperature sensor (SA56004ED internal) */
> > +				channel@0 {
> > +					reg = <0>;
> > +					label = "board";
> > +				};
> > +
> > +				/* Remote temperature sensor (D+/D- connected to P2020 CPU Temperature Diode) */
> > +				channel@1 {
> > +					reg = <1>;
> > +					label = "cpu";
> > +				};
> 
> I'm not sure if you want UPPERCASE, lowercase, PascalCase, kebab-case
> or snake_case format of labels. Or if you want also "temp" or
> "temperature" keyword in the label. So please adjust label to the
> preferred one, if proposed format is not the correct.

Ok, if nobody complains then please take this patch as is.

> >  			};
> >  
> >  			/* DDR3 SPD/EEPROM */
> > -- 
> > 2.20.1
> > 
