Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DFA7433FC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjF3FSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjF3FSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:18:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355332D69;
        Thu, 29 Jun 2023 22:18:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 964286164B;
        Fri, 30 Jun 2023 05:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7084BC433C8;
        Fri, 30 Jun 2023 05:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688102313;
        bh=VNj8VKDu2zaozgcFJLTIq3ErZ8I2Nt5WMw7P4iC/eb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HdU6O5IxJwu8K/zv3OV7fPfovbpdX2qTdBA5B1ajt+IHkYLRAKP90DMuJjhDCsuKE
         4RkRVl5pWjoO+8HX2g3qNUzKdbtiPhEu+cJPCW570Tv3MHwvzL48RS9wL7wxqbaqXI
         YZqLnDTFX7yMwzEPcMaXiIZB6B9sZ41eUxQHxRLQ=
Date:   Fri, 30 Jun 2023 07:18:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 00/30] 6.1.37-rc1 review
Message-ID: <2023063056-waviness-unearth-08aa@gregkh>
References: <20230629184151.651069086@linuxfoundation.org>
 <CAEUSe7-xC90CGpJjQD4w10ea=nXMiGhsFouhaa8fVK5W-WJJJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe7-xC90CGpJjQD4w10ea=nXMiGhsFouhaa8fVK5W-WJJJQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 04:25:40PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On Thu, 29 Jun 2023 at 12:46, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 6.1.37 release.
> > There are 30 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 01 Jul 2023 18:41:39 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.37-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Early report of failures.
> 
> SPARC and PA-RISC both fail to build (GCC-8 and GCC-11).
> 
> For SPARC:
> * allnoconfig
> * defconfig
> * tinyconfig
> 
> -----8<-----
> /builds/linux/arch/sparc/mm/fault_32.c: In function 'force_user_fault':
> /builds/linux/arch/sparc/mm/fault_32.c:312:49: error: 'regs'
> undeclared (first use in this function)
>   312 |         vma = lock_mm_and_find_vma(mm, address, regs);
>       |                                                 ^~~~
> /builds/linux/arch/sparc/mm/fault_32.c:312:49: note: each undeclared
> identifier is reported only once for each function it appears in
> make[4]: *** [/builds/linux/scripts/Makefile.build:250:
> arch/sparc/mm/fault_32.o] Error 1
> make[4]: Target 'arch/sparc/mm/' not remade because of errors.
> ----->8-----
> 
> For PA-RISC:
> * allnoconfig
> * tinyconfig
> 
> -----8<-----
> /builds/linux/arch/parisc/mm/fault.c: In function 'do_page_fault':
> /builds/linux/arch/parisc/mm/fault.c:292:22: error: 'prev' undeclared
> (first use in this function)
>   292 |                 if (!prev || !(prev->vm_flags & VM_GROWSUP))
>       |                      ^~~~
> /builds/linux/arch/parisc/mm/fault.c:292:22: note: each undeclared
> identifier is reported only once for each function it appears in
> make[4]: *** [/builds/linux/scripts/Makefile.build:250:
> arch/parisc/mm/fault.o] Error 1
> make[4]: Target 'arch/parisc/mm/' not remade because of errors.
> ----->8-----

These issues are also in Linus's tree right now, right?  Or are they
unique to the -rc releases right now?

thanks,

greg k-h
