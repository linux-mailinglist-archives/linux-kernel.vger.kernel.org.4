Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D418E6FC04F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjEIHSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEIHSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:18:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B916ABC;
        Tue,  9 May 2023 00:18:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43AB262D64;
        Tue,  9 May 2023 07:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ED0C433D2;
        Tue,  9 May 2023 07:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683616718;
        bh=8QQ/TWzUc3gS4jlPeHQgsKdVbG+aX+ZMQAWZ/cm0O6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e4NzMKx3tLVybcg+6uQj0VRxQXy+OLypPq+PxwnJpQGfMz/i6PIZOpYVrjZGNbVaF
         xzwTof73+FXb0A86M5fSPYwb+2dDP1igHEVjBoxopn05V8Z/b81pi+jwKdkkW3iNAJ
         rc1EojlxIc1q/6coWp/NucH9h8toDQ/3tkFBvT6HNr8+dcAINE49k6mbytvTPZ5LR1
         CSgw9qCWYRCUobtcW8oIhfgM4elaAyDfVcPQySnaBU+QoY82UTF7YEN1mIjthoo8Xu
         yx+XXP2f7CCx/oDzMWyIUtPEZ8bi3YF8+yABVI7I3coz3wbAzYhtZDHSzRqW8YU7ed
         rtkcwiXzKlKkg==
Received: by pali.im (Postfix)
        id 435EB95D; Tue,  9 May 2023 09:18:35 +0200 (CEST)
Date:   Tue, 9 May 2023 09:18:35 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, arnd@arndb.de,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH AUTOSEL 6.3 6/7] powerpc/fsl_uli1575: Allow to disable
 FSL_ULI1575 support
Message-ID: <20230509071835.rrfefrhwtwsxlngy@pali>
References: <20230509035455.59524-1-sashal@kernel.org>
 <20230509035455.59524-6-sashal@kernel.org>
 <62539831-1f8c-d908-bd7c-2a926702fa7f@infradead.org>
 <87jzxix9g7.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jzxix9g7.fsf@mail.lhotse>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 May 2023 17:14:48 Michael Ellerman wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> > Hi--
> >
> > Just a heads up. This patch can cause build errors.
> > I sent a patch for these on 2023-APR-28:
> >   https://lore.kernel.org/linuxppc-dev/20230429043519.19807-1-rdunlap@infradead.org/
> >
> > Michael, I think this is your area if I'm not mistaken.
> 
> Yes. The fix is in my fixes branch as:
>   536d948a8dee ("powerpc/fsl_uli1575: fix kconfig warnings and build errors")
> 
> But I don't think this commit (22fdf79171e8) really warrants going to
> stable, it's a nice-to-have but doesn't fix any pressing bugs.

Exactly. And also this patch alone without 1/8 would not work as in 1/8
https://lore.kernel.org/all/20230409000812.18904-2-pali@kernel.org/ was
added static inline variant of function which is used when ULI is
disabled.

> cheers
> 
> > On 5/8/23 20:54, Sasha Levin wrote:
> >> From: Pali Rohár <pali@kernel.org>
> >> 
> >> [ Upstream commit 22fdf79171e8509db54599fd2c05ef0022ee83f5 ]
> >> 
> >> ULI1575 PCIe south bridge exists only on some Freescale boards. Allow to
> >> disable CONFIG_FSL_ULI1575 symbol when it is not explicitly selected and
> >> only implied. This is achieved by marking symbol as visible by providing
> >> short description. Also adds dependency for this symbol to prevent enabling
> >> it on platforms on which driver does not compile.
> >> 
> >> Signed-off-by: Pali Rohár <pali@kernel.org>
> >> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> >> Link: https://msgid.link/20230409000812.18904-7-pali@kernel.org
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >> ---
> >>  arch/powerpc/platforms/Kconfig | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> >> index d41dad227de84..608ac0290e3aa 100644
> >> --- a/arch/powerpc/platforms/Kconfig
> >> +++ b/arch/powerpc/platforms/Kconfig
> >> @@ -261,7 +261,9 @@ config CPM2
> >>  	  on it (826x, 827x, 8560).
> >>  
> >>  config FSL_ULI1575
> >> -	bool
> >> +	bool "ULI1575 PCIe south bridge support"
> >> +	depends on FSL_SOC_BOOKE || PPC_86xx
> >> +	select FSL_PCI
> >>  	select GENERIC_ISA_DMA
> >>  	help
> >>  	  Supports for the ULI1575 PCIe south bridge that exists on some
> >
> > -- 
> > ~Randy
