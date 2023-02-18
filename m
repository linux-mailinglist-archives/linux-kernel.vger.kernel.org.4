Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1455369B9E8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 13:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjBRMFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 07:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBRMFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 07:05:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7729319690;
        Sat, 18 Feb 2023 04:05:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FE7F60B8B;
        Sat, 18 Feb 2023 12:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4E8C433EF;
        Sat, 18 Feb 2023 12:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676721928;
        bh=TmAb1GafN4gpzoQhxhlwDTfphssUg/5r9Sqy94z7ifo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=unQDxG2swsiziDdZOR3cHzU1vK66DWAJWytXvML35cY72loxGCGXTOS6lBPpYXUm9
         UgK1Auf5GxywMv1xtdvTkYR9/w3q6M4hhl5PY8iJLVn7pOOQd8ABW4y2YBnkCvaAu0
         i3LQkLkwR5K5jn8JyETMX5tqfx7K7+Cbhkfi/yrTimB66aR5OHUxbd9WJde8ki0ubj
         05Wch5vEKcCOm6VxoL/6msH8MdYvRiJJMRRLE4Y06Os2yY+O37KEsksZL4x4c6U5yh
         b1sUvuRu0XX8X3D9oJzjBaWrYmGpdMr5JrvwtQvA5eGY52dvf09PdxCZ6wtW19Qw0x
         iv9ga7MWTUyIw==
Received: by pali.im (Postfix)
        id 8754D71F; Sat, 18 Feb 2023 13:05:25 +0100 (CET)
Date:   Sat, 18 Feb 2023 13:05:25 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 3/3] powerpc: dts: turris1x.dts: Set lower priority
 for CPLD syscon-reboot
Message-ID: <20230218120525.7zplk5zdg5qmkmaz@pali>
References: <20220820102925.29476-1-pali@kernel.org>
 <20221226114513.4569-1-pali@kernel.org>
 <20221226114513.4569-3-pali@kernel.org>
 <20230209001021.oitnv6x7ilwvy4it@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230209001021.oitnv6x7ilwvy4it@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 February 2023 01:10:21 Pali Rohár wrote:
> On Monday 26 December 2022 12:45:13 Pali Rohár wrote:
> > Due to CPLD firmware bugs, set CPLD syscon-reboot priority level to 64
> > (between rstcr and watchdog) to ensure that rstcr's global-utilities reset
> > method which is preferred stay as default one, and to ensure that CPLD
> > syscon-reboot is more preferred than watchdog reset method.
> > 
> > Fixes: 0531a4abd1c6 ("powerpc: dts: turris1x.dts: Add CPLD reboot node")
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> May I ask who can take this 3/3 patch? powersupply or powerpc tree?

+ Christophe

> > ---
> >  arch/powerpc/boot/dts/turris1x.dts | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
> > index e9cda34a140e..c9b619f6ed5c 100644
> > --- a/arch/powerpc/boot/dts/turris1x.dts
> > +++ b/arch/powerpc/boot/dts/turris1x.dts
> > @@ -367,11 +367,34 @@
> >  			};
> >  
> >  			reboot@d {
> > +				/*
> > +				 * CPLD firmware which manages system reset and
> > +				 * watchdog registers has bugs. It does not
> > +				 * autoclear system reset register after change
> > +				 * and watchdog ignores reset line on immediate
> > +				 * succeeding reset cycle triggered by watchdog.
> > +				 * These bugs have to be workarounded in U-Boot
> > +				 * bootloader. So use system reset via syscon as
> > +				 * a last resort because older U-Boot versions
> > +				 * do not have workaround for watchdog.
> > +				 *
> > +				 * Reset method via rstcr's global-utilities
> > +				 * (the preferred one) has priority level 128,
> > +				 * watchdog has priority level 0 and default
> > +				 * syscon-reboot priority level is 192.
> > +				 *
> > +				 * So define syscon-reboot with custom priority
> > +				 * level 64 (between rstcr and watchdog) because
> > +				 * rstcr should stay as default preferred reset
> > +				 * method and reset via watchdog is more broken
> > +				 * than system reset via syscon.
> > +				 */
> >  				compatible = "syscon-reboot";
> >  				reg = <0x0d 0x01>;
> >  				offset = <0x0d>;
> >  				mask = <0x01>;
> >  				value = <0x01>;
> > +				priority = <64>;
> >  			};
> >  
> >  			led-controller@13 {
> > -- 
> > 2.20.1
> > 
