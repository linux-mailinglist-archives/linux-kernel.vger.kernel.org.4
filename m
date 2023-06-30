Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AC5743495
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjF3FwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjF3FwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:52:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA291FE8;
        Thu, 29 Jun 2023 22:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FFE7616BC;
        Fri, 30 Jun 2023 05:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4506FC433C0;
        Fri, 30 Jun 2023 05:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688104327;
        bh=icxRgbeu8s/q8bp41QRk+7MlrDs1asovY+2huJNdnzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cgtoeWO+GMsLEdkcQ+lIualgStOpgMh0KCoOWy70ULPTa/Ke5mQAX4D/pvdO7QQAt
         mriYCbouxM99thXX6kfySJd8P1aPF/RnQ08Q4qU1yE8d8mKozHTEXjB4vwt8nKWGhO
         if3ZrRNAAkGIMP2qV3Q4Qb3POeLr/0A9dEmz6pMI=
Date:   Fri, 30 Jun 2023 07:52:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, linux-parisc <linux-parisc@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Jason Wang <wangborong@cdjrlc.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
Message-ID: <2023063035-drainer-alfalfa-b1d2@gregkh>
References: <20230629184151.888604958@linuxfoundation.org>
 <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:00:51AM +0530, Naresh Kamboju wrote:
> On Fri, 30 Jun 2023 at 00:18, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.4.1 release.
> > There are 28 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 01 Jul 2023 18:41:39 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.1-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> 
> Following build regression noticed on Linux stable-rc 6.4 and also noticed on
> Linux mainline master.
> 
> Regressions found on Parisc and Sparc build failed:
>  - build/gcc-11-defconfig
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Parisc Build log:
> =============
> arch/parisc/mm/fault.c: In function 'do_page_fault':
> arch/parisc/mm/fault.c:292:22: error: 'prev' undeclared (first use in
> this function)
>   292 |                 if (!prev || !(prev->vm_flags & VM_GROWSUP))
>       |                      ^~~~
> arch/parisc/mm/fault.c:292:22: note: each undeclared identifier is
> reported only once for each function it appears in
> 
> 
> sparc Build log:
> ===========
> <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> arch/sparc/mm/fault_32.c: In function 'force_user_fault':
> arch/sparc/mm/fault_32.c:315:49: error: 'regs' undeclared (first use
> in this function)
>   315 |         vma = lock_mm_and_find_vma(mm, address, regs);
>       |                                                 ^~~~
> arch/sparc/mm/fault_32.c:315:49: note: each undeclared identifier is
> reported only once for each function it appears in
> 
> 
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4-29-g8e5ddb853f08/testrun/17959811/suite/build/test/gcc-11-defconfig/details/
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4-29-g8e5ddb853f08/testrun/17959811/suite/build/test/gcc-11-defconfig/log
> 
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4-29-g8e5ddb853f08/testrun/17959890/suite/build/test/gcc-11-defconfig/details/
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.4.y/build/v6.4-29-g8e5ddb853f08/testrun/17959890/suite/build/test/gcc-11-defconfig/log
> 
> 
> Both build failures noticed on mainline and sparc build have been
> fixed yesterday.
>  - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-8542-g82a2a5105589/testrun/17963192/suite/build/test/gcc-11-defconfig/history/
> 
> 
> Following patch that got fixed
> ---
> >From 0b26eadbf200abf6c97c6d870286c73219cdac65 Mon Sep 17 00:00:00 2001
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Thu, 29 Jun 2023 20:41:24 -0700
> Subject: sparc32: fix lock_mm_and_find_vma() conversion
> 
> The sparc32 conversion to lock_mm_and_find_vma() in commit a050ba1e7422
> ("mm/fault: convert remaining simple cases to lock_mm_and_find_vma()")
> missed the fact that we didn't actually have a 'regs' pointer available
> in the 'force_user_fault()' case.
> 
> It's there in the regular page fault path ("do_sparc_fault()"), but not
> the window underflow/overflow paths.
> 
> Which is all fine - we can just pass in a NULL pointer.  The register
> state is only used to avoid deadlock with kernel faults, which is not
> the case for any of these register window faults.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: a050ba1e7422 ("mm/fault: convert remaining simple cases to
> lock_mm_and_find_vma()")
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Thanks!  That saves me having to dig.  I'll go push out updates with
this in them...

greg k-h
