Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2462F5E9FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbiIZKbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiIZK3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:29:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D6043E50
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:19:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DAE2B80926
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7BEC433C1;
        Mon, 26 Sep 2022 10:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664187555;
        bh=KCjjwcHyXGg/GjG7SNTwfpi8BnY3Fr99E5kHq2yWohc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D60NBDVUvwdPSNrkU/GAB6uNnGlYB0ab6TCywJJj7GcTspcR2Sua1lLuzIn5o2X0e
         Q/+Vf+sJGmU9wiqJfeTEsRbm67S4ZkRKwxfRqEItLnqGcrT4XOWKfB/2+xXFO60I5J
         WbcpoZbVBkCIPr+12VgroqTq+fOn1XzzyzqVIb/n1SmY4Y6ZdttaMh/2QsIEZeHgBC
         8F9xsZA9VUyUntDsm6mC97WR1TXGugZ57z9m79HS1OJE+8ms5CHrXP6y9vM2673F1m
         Zi55y6okrekuMnp4R4UNcOYhShUcqHB4QNFnBe1wldVz78ZItqo/A+VCTeUnm2/XfT
         soUXPyPGU1Y0Q==
Received: by pali.im (Postfix)
        id 25A9C8A3; Mon, 26 Sep 2022 12:19:12 +0200 (CEST)
Date:   Mon, 26 Sep 2022 12:19:12 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] powerpc/85xx: p2020: Enable boards by new config
 option CONFIG_P2020
Message-ID: <20220926101912.jcirlaoywz5obn77@pali>
References: <20220819191557.28116-1-pali@kernel.org>
 <20220819191557.28116-7-pali@kernel.org>
 <872fa228-1fbb-1723-4b28-c130368e99f7@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <872fa228-1fbb-1723-4b28-c130368e99f7@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 September 2022 10:08:19 Christophe Leroy wrote:
> Le 19/08/2022 à 21:15, Pali Rohár a écrit :
> > Generic unified P2020 machine description which supports all P2020-based
> > boards is now in separate file p2020.c. So create a separate config option
> > CONFIG_P2020 for it.
> 
> Could it be CONFIG_PPC_P2020 instead ? Nowadays, drivers seems to spread 
> all over driver/ directory, so it's much better to have CONFIG_PPC_ 
> prefix on all dedicated powerpc config items.

Ok! I do not have any strong preference of config option name.

> > 
> > Previously machine descriptions for P2020 boards were enabled by
> > CONFIG_MPC85xx_DS or CONFIG_MPC85xx_RDB option. So set CONFIG_P2020 to be
> > enabled by default when one of those option is enabled.
> > 
> > This allows to compile support for P2020 boards without need to have
> > enabled support for older mpc85xx boards. And to compile kernel for old
> > mpc85xx boards without having enabled support for new P2020 boards.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >   arch/powerpc/platforms/85xx/Kconfig  | 22 ++++++++++++++++++----
> >   arch/powerpc/platforms/85xx/Makefile |  3 +--
> >   2 files changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> > index be16eba0f704..2cb4e9248b42 100644
> > --- a/arch/powerpc/platforms/85xx/Kconfig
> > +++ b/arch/powerpc/platforms/85xx/Kconfig
> > @@ -78,16 +78,16 @@ config MPC8536_DS
> >   	  This option enables support for the MPC8536 DS board
> >   
> >   config MPC85xx_DS
> > -	bool "Freescale MPC8544 DS / MPC8572 DS / P2020 DS"
> > +	bool "Freescale MPC8544 DS / MPC8572 DS"
> >   	select PPC_I8259
> >   	select DEFAULT_UIMAGE
> >   	select FSL_ULI1575 if PCI
> >   	select SWIOTLB
> >   	help
> > -	  This option enables support for the MPC8544 DS, MPC8572 DS and P2020 DS boards
> > +	  This option enables support for the MPC8544 DS and MPC8572 DS boards
> >   
> >   config MPC85xx_RDB
> > -	bool "Freescale P102x MBG/UTM/RDB and P2020 RDB"
> > +	bool "Freescale P102x MBG/UTM/RDB"
> >   	select PPC_I8259
> >   	select DEFAULT_UIMAGE
> >   	select FSL_ULI1575 if PCI
> > @@ -95,7 +95,21 @@ config MPC85xx_RDB
> >   	help
> >   	  This option enables support for the P1020 MBG PC, P1020 UTM PC,
> >   	  P1020 RDB PC, P1020 RDB PD, P1020 RDB, P1021 RDB PC, P1024 RDB,
> > -	  P1025 RDB, P2020 RDB and P2020 RDB PC boards
> > +	  and P1025 RDB boards
> > +
> > +config P2020
> > +	bool "Freescale P2020"
> > +	default y if MPC85xx_DS || MPC85xx_RDB
> 
> Is that necessary ?
> Can you just update defconfigs ?

This is for old users defconfigs, so if they update kernel to new
version it automatically selects all features which were already
enabled.

But if you think this is not necessary, just drop it.

> By the way, did you have a look at the impact on defconfigs ?
> 
> > +	select DEFAULT_UIMAGE
> > +	select SWIOTLB
> > +	imply PPC_I8259
> > +	imply FSL_ULI1575 if PCI
> 
> Why imply and not select ?

Because more P2020 boards do not have these two HW parts. So I do not
see reason for hard dependency. In my opinion, if user does not need to
enable some kernel option (because his HW does not require it) then
kernel should allow to do it, unless there is no strong reason for it.

And IIRC imply is like select but allow user to disable specified
option.

> > +	help
> > +	  This option enables generic unified support for any board with the
> > +	  Freescale P2020 processor.
> > +
> > +	  For example: P2020 DS board, P2020 RDB board, P2020 RDB PC board or
> > +	  CZ.NIC Turris 1.x boards.
> >   
> >   config P1010_RDB
> >   	bool "Freescale P1010 RDB"
> > diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
> > index 1ad261b4eeb6..021e168442d7 100644
> > --- a/arch/powerpc/platforms/85xx/Makefile
> > +++ b/arch/powerpc/platforms/85xx/Makefile
> > @@ -23,8 +23,7 @@ obj-$(CONFIG_P1010_RDB)   += p1010rdb.o
> >   obj-$(CONFIG_P1022_DS)    += p1022_ds.o
> >   obj-$(CONFIG_P1022_RDK)   += p1022_rdk.o
> >   obj-$(CONFIG_P1023_RDB)   += p1023_rdb.o
> > -obj-$(CONFIG_MPC85xx_DS)  += p2020.o
> > -obj-$(CONFIG_MPC85xx_RDB) += p2020.o
> > +obj-$(CONFIG_P2020)       += p2020.o
> >   obj-$(CONFIG_TWR_P102x)   += twr_p102x.o
> >   obj-$(CONFIG_CORENET_GENERIC)   += corenet_generic.o
> >   obj-$(CONFIG_FB_FSL_DIU)	+= t1042rdb_diu.o
