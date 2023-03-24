Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331256C829A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjCXQtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCXQtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:49:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19266EB67;
        Fri, 24 Mar 2023 09:49:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7F1F62A46;
        Fri, 24 Mar 2023 16:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FEDC433D2;
        Fri, 24 Mar 2023 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679676550;
        bh=Ko+doy6miNVccGF6PLZMT2NOgYDK5UYSp2j4A6+XB/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bikEEwzoIKbiEp++ZVDS2od9Vj6fM5doaZjPYGBWhRItvFbwZWn4eSSvcUDhXwz2C
         +/MRKr1qCD+3SgCkFt27Y/szQX9521IROrEvmdyPxM1NH7q+6vTIIjPlZHXUFtL+nD
         eBQ6glP0tjCcYZoC5P0I/kB5YLLHHGZTP0VGQ1eUWkz053KBLBkGgqn36LUxpzpEPd
         ZqqPv69iDsAnebfmMUJjszrgWw2Uuxhbang2j2KzncjL8C6WVRbwu7zYScqlBAsHCU
         CmAlaxtZKKboh0FbxAqNeNw306p+ZHZYlHjKeSYEYeiUZrkTS8iGzHhnQuFUY/lTov
         0bNoykhMwACXQ==
Date:   Fri, 24 Mar 2023 19:48:50 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mm@kvack.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 00/14] arch,mm: cleanup Kconfig entries for
 ARCH_FORCE_MAX_ORDER
Message-ID: <ZB3Uci7kjTOyOEiy@kernel.org>
References: <20230324052233.2654090-1-rppt@kernel.org>
 <F98008AC-F79C-4712-A262-4EC85BBC0B29@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F98008AC-F79C-4712-A262-4EC85BBC0B29@nvidia.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 10:30:07AM -0400, Zi Yan wrote:
> On 24 Mar 2023, at 1:22, Mike Rapoport wrote:
> 
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> >
> > Hi,
> >
> > Several architectures have ARCH_FORCE_MAX_ORDER in their Kconfig and
> > they all have wrong and misleading prompt and help text for this option.
> >
> > Besides, some define insane limits for possible values of
> > ARCH_FORCE_MAX_ORDER, some carefully define ranges only for a subset of
> > possible configurations, some make this option configurable by users for no
> > good reason.
> >
> > This set updates the prompt and help text everywhere and does its best to
> > update actual definitions of ranges where applicable.
> >
> > kbuild generated a bunch of false positives because it assigns -1 to
> > ARCH_FORCE_MAX_ORDER, hopefully this will be fixed soon.
> >
> > v2:
> > * arm64: show prompt for ARCH_FORCE_MAX_ORDER only if EXPERT (Catalin)
> > * Add Acked- and Reviewed-by tags (thanks Geert, Kirill and Max)
> >
> > v1: https://lore.kernel.org/all/20230323092156.2545741-1-rppt@kernel.org
> >
> > Mike Rapoport (IBM) (14):
> >   arm: reword ARCH_FORCE_MAX_ORDER prompt and help text
> >   arm64: drop ranges in definition of ARCH_FORCE_MAX_ORDER
> >   arm64: reword ARCH_FORCE_MAX_ORDER prompt and help text
> >   csky: drop ARCH_FORCE_MAX_ORDER
> >   ia64: don't allow users to override ARCH_FORCE_MAX_ORDER
> >   m68k: reword ARCH_FORCE_MAX_ORDER prompt and help text
> >   nios2: reword ARCH_FORCE_MAX_ORDER prompt and help text
> >   nios2: drop ranges for definition of ARCH_FORCE_MAX_ORDER
> >   powerpc: reword ARCH_FORCE_MAX_ORDER prompt and help text
> >   powerpc: drop ranges for definition of ARCH_FORCE_MAX_ORDER
> >   sh: reword ARCH_FORCE_MAX_ORDER prompt and help text
> >   sh: drop ranges for definition of ARCH_FORCE_MAX_ORDER
> >   sparc: reword ARCH_FORCE_MAX_ORDER prompt and help text
> >   xtensa: reword ARCH_FORCE_MAX_ORDER prompt and help text
> >
> >  arch/arm/Kconfig      | 16 +++++++++-------
> >  arch/arm64/Kconfig    | 27 ++++++++++++---------------
> >  arch/csky/Kconfig     |  4 ----
> >  arch/ia64/Kconfig     |  3 +--
> >  arch/m68k/Kconfig.cpu | 16 +++++++++-------
> >  arch/nios2/Kconfig    | 17 +++++++++--------
> >  arch/powerpc/Kconfig  | 22 +++++++++-------------
> >  arch/sh/mm/Kconfig    | 19 +++++++++----------
> >  arch/sparc/Kconfig    | 16 +++++++++-------
> >  arch/xtensa/Kconfig   | 16 +++++++++-------
> >  10 files changed, 76 insertions(+), 80 deletions(-)
> >
> >
> > base-commit: 51551d71edbc998fd8c8afa7312db3d270f5998e
> 
> LGTM, thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks!

And thanks for spotting the mistakes in arm64 and sh patches.
 
> --
> Best Regards,
> Yan, Zi

-- 
Sincerely yours,
Mike.
