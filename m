Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67D15FDE9C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJMRC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJMRC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:02:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFE2EC535
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4993B81E19
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA65C433D6;
        Thu, 13 Oct 2022 17:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665680571;
        bh=DZUZVyP2R+VQiL9UZwbG/Qa8u2aiJBG0EcVdvHGdTyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPwKMyVgLxHsXwE3Ys0ysC6wVyAncBrdAV0GEKez83el5ubu+DOCOguR3fIqsf4xI
         VsTob5/RwVU19e0fSviWnoNDPouqS31WVcixrDqARwU2pt4bw08p1OB5FU1Oeoeavc
         lJbLlwFc+BUuUz0YilRX6Bw4OtpNY0kb/FpK80At9LECdOPtes5zwuG4DDxhrLLjpW
         te0Co5Fn8k+suwoFYR3+oM19o7zi5D97vB7Y2gsbxM5zvpq/bQN73gFRfzSFeGVo/o
         +Olx12PWgaXDpq46ccAtPH7sXy716KDVNZqBtrSficHqJU/E7SOJbJLQh5jIdVTqyt
         Q2PxaJZ59CRew==
Date:   Thu, 13 Oct 2022 18:02:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Move from git://github.com to
 https://github.com
Message-ID: <Y0hEt51q+Fs0ICbB@spud>
References: <20221013153258.28228-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013153258.28228-1-palmer@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 08:32:58AM -0700, Palmer Dabbelt wrote:
> Github deprecated the git:// links about a year ago, but it looks like
> there's still a handful of them in the MAINTAINERS file.  Conor pointed
> this out about the RISC-V KVM tree, but I figured it'd be better to just
> fix them all -- I've got a bunch of insteadOf so I didn't even notice
> the deprecation, but new contributors probably don't and might get a bit
> confused.
> 
> Reported-by: Conor Dooley <conor@kernel.org>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> @@ -3990,7 +3990,7 @@ M:	Ray Jui <rjui@broadcom.com>
>  M:	Scott Branden <sbranden@broadcom.com>
>  R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>  S:	Maintained
> -T:	git git://github.com/broadcom/mach-bcm
> +T:	git https://github.com/broadcom/mach-bcm

This link is dead, I can't find a repo with that name on their GitHub
profile.
@Florian, should this be updated to the stblinux repo instead?

>  F:	arch/arm/mach-bcm/
>  N:	bcm281*
>  N:	bcm113*
> @@ -4055,7 +4055,7 @@ M:	Florian Fainelli <f.fainelli@gmail.com>
>  R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> -T:	git git://github.com/broadcom/stblinux.git
> +T:	git https://github.com/broadcom/stblinux.git
>  F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>  F:	arch/arm/boot/dts/bcm7*.dts*
>  F:	arch/arm/include/asm/hardware/cache-b15-rac.h

Other than that, I clicked all the links - some look dead but that's not
the point of this patch..

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

