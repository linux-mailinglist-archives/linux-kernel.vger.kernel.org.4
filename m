Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50567687205
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjBAXq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBAXqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:46:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB1964680
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 15:46:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 762746197E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 23:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B027EC433EF;
        Wed,  1 Feb 2023 23:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675295212;
        bh=5iXJHg/bNi506Wumv2Wdn+vPPmHRh07HufMbXsgnVy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZrBnQV1jPotsPALZ6r13v4Pva5XddNGXTh5WmYlqMdHG8RKRT3veuEg0r5lDfIoQz
         bQWrA1NHUCJxP4amV4J/c7PVP2wIi+Fa13H9M/BTtYanDSVKfGuNlA3U9bE9GptGnS
         XpB9OLT3zdVOKcBD5EP6Hz7yBmZiqcJy47a9mmNvkHCxCPPxy8zo+ghcbYXR+9yd2y
         0s8ARZ+vpEF6wbaGOVTTkLu6G4xfGTnpThxxNsqenYR6O68E6rAaJhMjpHySQl3FET
         CswLFU1Yu8q+dpic09oTAsuf0aJR+XYztN7H+xH/0J4fmdW118Rk1eSsIj6HNjLsna
         wLhN+AcdCbHhw==
Received: by pali.im (Postfix)
        id AD6CF7FB; Thu,  2 Feb 2023 00:46:49 +0100 (CET)
Date:   Thu, 2 Feb 2023 00:46:49 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, jbglaw@lug-owl.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] powerpc/64: Replace -mcpu=e500mc64 by -mcpu=e5500
Message-ID: <20230201234649.yxztgdm3efklmoy5@pali>
References: <38a8d765ed9149bc6b5484a7142e3bc59ffa3b1a.1671475543.git.christophe.leroy@csgroup.eu>
 <fa71ed20d22c156225436374f0ab847daac893bc.1671475543.git.christophe.leroy@csgroup.eu>
 <20221220201508.b47rg5ii2p6wkrkq@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221220201508.b47rg5ii2p6wkrkq@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 December 2022 21:15:08 Pali Rohár wrote:
> On Monday 19 December 2022 19:45:58 Christophe Leroy wrote:
> > E500MC64 is a processor pre-dating E5500 that has never been
> > commercialised. Use -mcpu=e5500 for E5500 core.
> > 
> > More details at https://gcc.gnu.org/PR108149
> > 
> > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Acked-by: Pali Rohár <pali@kernel.org>
> 
> > ---
> >  arch/powerpc/platforms/Kconfig.cputype | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> > index 31cea2eeb59e..29d6be033576 100644
> > --- a/arch/powerpc/platforms/Kconfig.cputype
> > +++ b/arch/powerpc/platforms/Kconfig.cputype
> > @@ -249,7 +249,7 @@ config TARGET_CPU
> >  	default "power8" if POWER8_CPU
> >  	default "power9" if POWER9_CPU
> >  	default "power10" if POWER10_CPU
> > -	default "e500mc64" if E5500_CPU
> > +	default "e5500" if E5500_CPU
> >  	default "e6500" if E6500_CPU
> >  	default "power4" if POWERPC64_CPU && !CPU_LITTLE_ENDIAN
> >  	default "power8" if POWERPC64_CPU && CPU_LITTLE_ENDIAN
> > -- 
> > 2.38.1
> > 

It looks like that this patch is also missing in powerpc tree...
