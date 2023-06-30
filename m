Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AB07434F3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjF3G2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjF3G2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:28:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A33E2D63;
        Thu, 29 Jun 2023 23:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13A4B60FD6;
        Fri, 30 Jun 2023 06:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5394C433C8;
        Fri, 30 Jun 2023 06:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688106492;
        bh=Bi17cT6QoK7w71H2ZRGDKU6Rdu/zSgePXPQhfko9J8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Op4YO4XvQomo8SNJDAxBwXEwCGYGWevNc15VeB2aO9HLmoBecGSfE20gWbPMdLpcO
         wymprc0KVy7u0RjEELYWV6za4d23z/DxsiIitw7VASJ7wJg2LcgPtg5moLT2vCTUv9
         qA+mq5zDxRhd5SWBq2Selty5MNFU49W7wutXq4Mc=
Date:   Fri, 30 Jun 2023 08:28:09 +0200
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
Message-ID: <2023063043-feminine-clasp-1d11@gregkh>
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

This is now fixed in Linus's tree with ea3f8272876f ("parisc: fix
expand_stack() conversion"), so I'll queue it up and push out
yet-another-rc...

thanks,

greg k-h
