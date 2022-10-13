Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5245FDEA6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJMRI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJMRI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:08:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1B1B1DFD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:08:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5775F618C9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3B9C433C1;
        Thu, 13 Oct 2022 17:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665680935;
        bh=gPkoG3OliTqXtH7dwPct9k4UL9mo8ISg1fjraa/bLuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1BaaBYuKATqzWizjqyh6d1tezY7/GXTbXtMSbgFgNsqb5qkaEM8Qji2HFiMovOtq
         3G71zsQn8qs56/efxlAuswn638RCad/6fP6Zojt5d5pTXXzbgixFz1b4eYLfGM/Ign
         zcu5/gNGyzFRr6mSwyc5Iy5WZ+dv6d9vPlAhmmJaa3gyoU3ZSynL+qwLxB1C9h/oz7
         Kpwhc1y08rWEtcPvVYJ58zvczDSBudRAbz5D5EaTvqFIAWAuRpTNoGJDvQX/vWWQUn
         +T+qP5mZT/NgpY+hCsuH+BV4hDweggjx9Hbu9lsQ29Bj3hU/nHOww7ZjzUMn3s7zsT
         oJ6lC3FCxSf+A==
Date:   Thu, 13 Oct 2022 18:08:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Move from git://github.com to
 https://github.com
Message-ID: <Y0hGIzid/ukXDYBw@spud>
References: <20221013153258.28228-1-palmer@rivosinc.com>
 <Y0hEt51q+Fs0ICbB@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0hEt51q+Fs0ICbB@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 06:02:51PM +0100, Conor Dooley wrote:
> On Thu, Oct 13, 2022 at 08:32:58AM -0700, Palmer Dabbelt wrote:
> > Github deprecated the git:// links about a year ago, but it looks like
> > there's still a handful of them in the MAINTAINERS file.  Conor pointed
> > this out about the RISC-V KVM tree, but I figured it'd be better to just
> > fix them all -- I've got a bunch of insteadOf so I didn't even notice
> > the deprecation, but new contributors probably don't and might get a bit
> > confused.
> > 
> > Reported-by: Conor Dooley <conor@kernel.org>
> > Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > ---
> > @@ -3990,7 +3990,7 @@ M:	Ray Jui <rjui@broadcom.com>
> >  M:	Scott Branden <sbranden@broadcom.com>
> >  R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
> >  S:	Maintained
> > -T:	git git://github.com/broadcom/mach-bcm
> > +T:	git https://github.com/broadcom/mach-bcm
> 
> This link is dead, I can't find a repo with that name on their GitHub
> profile.
> @Florian, should this be updated to the stblinux repo instead?
> 
> >  F:	arch/arm/mach-bcm/
> >  N:	bcm281*
> >  N:	bcm113*
> > @@ -4055,7 +4055,7 @@ M:	Florian Fainelli <f.fainelli@gmail.com>
> >  R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
> >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >  S:	Maintained
> > -T:	git git://github.com/broadcom/stblinux.git
> > +T:	git https://github.com/broadcom/stblinux.git
> >  F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> >  F:	arch/arm/boot/dts/bcm7*.dts*
> >  F:	arch/arm/include/asm/hardware/cache-b15-rac.h
> 
> Other than that, I clicked all the links - some look dead but that's not
> the point of this patch..

I realised I should clarify: s/some look dead/some look abandoned. Only
the one I pointed out above is actually a 404.

> 
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor.
> 
