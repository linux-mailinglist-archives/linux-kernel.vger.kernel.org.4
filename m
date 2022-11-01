Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E224561553B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiKAWoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiKAWny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:43:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F1D1DF2F;
        Tue,  1 Nov 2022 15:43:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8C66B81D5E;
        Tue,  1 Nov 2022 22:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575F7C433B5;
        Tue,  1 Nov 2022 22:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667342630;
        bh=2zNKF9sIrblZIsup7pAfIEmiHmxsXlJEBUxwNTmO6lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WuFx8933JHTEaadMAo6XrnWpo7g90tPRQXRB7DjNMKQsdDQFCmBF6z2ATeQ3euU32
         YBGfwPJKcJyhJDvV2HVx01O8lxSvdmvftj49OjVWC2lj4f8SX+znJm4IHz+2p0iWHj
         BV+J+bK1SRItD5IU5Z15NXggaCX44NYUK+0I6LSjAg/1TQqaS67nRVOcttR0LLCc9V
         45FZsSbEtoIaQMEwuvKXA4VFegTvmUt1t725ep8CTMfNLWrjykTJkuI+VuquWX55ty
         UdgdVccL3o85KRdikcu4o6sXDJx+6+WtFzQbSupglm8bbenKmKfmSOp9gBiKk2C0vq
         H9zjXfz5qaTfg==
Received: by pali.im (Postfix)
        id 1312D7F8; Tue,  1 Nov 2022 23:43:48 +0100 (CET)
Date:   Tue, 1 Nov 2022 23:43:48 +0100
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
Message-ID: <20221101224348.xkpzucskunn46i5z@pali>
References: <20220930123901.10251-1-pali@kernel.org>
 <20220930124618.kyaansrl7ls5kn3i@pali>
 <20221009120506.itwa4n25nljn2tll@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221009120506.itwa4n25nljn2tll@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael, could you take this patch?

On Sunday 09 October 2022 14:05:06 Pali Rohár wrote:
> On Friday 30 September 2022 14:46:18 Pali Rohár wrote:
> > + CC hwmon ML
> > 
> > On Friday 30 September 2022 14:39:01 Pali Rohár wrote:
> > > Channel 0 of SA56004ED chip refers to internal SA56004ED chip sensor (chip
> > > itself is located on the board) and channel 1 of SA56004ED chip refers to
> > > external sensor which is connected to temperature diode of the P2020 CPU.
> > > 
> > > Fixes: 54c15ec3b738 ("powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers")
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > ---
> > > With this change userspace 'sensors' applications prints labels:
> > > 
> > >     $ sensors
> > >     sa56004-i2c-0-4c
> > >     Adapter: MPC adapter (i2c@3000)
> > >     board:        +34.2°C  (low  =  +0.0°C, high = +70.0°C)
> > >                            (crit = +85.0°C, hyst = +75.0°C)
> > >     cpu:          +58.9°C  (low  =  +0.0°C, high = +70.0°C)
> > >                            (crit = +85.0°C, hyst = +75.0°C)
> > > 
> > > And without this change it prints just generic tempX names:
> > > 
> > >     $ sensors
> > >     sa56004-i2c-0-4c
> > >     Adapter: MPC adapter (i2c@3000)
> > >     temp1:        +43.0°C  (low  =  +0.0°C, high = +70.0°C)
> > >                            (crit = +85.0°C, hyst = +75.0°C)
> > >     temp2:        +63.4°C  (low  =  +0.0°C, high = +70.0°C)
> > >                            (crit = +85.0°C, hyst = +75.0°C)
> > > ---
> > >  arch/powerpc/boot/dts/turris1x.dts | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
> > > index 4033c554b06a..5b5278c32e43 100644
> > > --- a/arch/powerpc/boot/dts/turris1x.dts
> > > +++ b/arch/powerpc/boot/dts/turris1x.dts
> > > @@ -69,6 +69,20 @@
> > >  				interrupt-parent = <&gpio>;
> > >  				interrupts = <12 IRQ_TYPE_LEVEL_LOW>, /* GPIO12 - ALERT pin */
> > >  					     <13 IRQ_TYPE_LEVEL_LOW>; /* GPIO13 - CRIT pin */
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +
> > > +				/* Local temperature sensor (SA56004ED internal) */
> > > +				channel@0 {
> > > +					reg = <0>;
> > > +					label = "board";
> > > +				};
> > > +
> > > +				/* Remote temperature sensor (D+/D- connected to P2020 CPU Temperature Diode) */
> > > +				channel@1 {
> > > +					reg = <1>;
> > > +					label = "cpu";
> > > +				};
> > 
> > I'm not sure if you want UPPERCASE, lowercase, PascalCase, kebab-case
> > or snake_case format of labels. Or if you want also "temp" or
> > "temperature" keyword in the label. So please adjust label to the
> > preferred one, if proposed format is not the correct.
> 
> Ok, if nobody complains then please take this patch as is.
> 
> > >  			};
> > >  
> > >  			/* DDR3 SPD/EEPROM */
> > > -- 
> > > 2.20.1
> > > 
