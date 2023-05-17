Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBD3706492
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjEQJv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEQJv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:51:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399E440E6;
        Wed, 17 May 2023 02:51:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C873D63DB1;
        Wed, 17 May 2023 09:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87A8C433D2;
        Wed, 17 May 2023 09:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684317084;
        bh=PiIX9F7CgLx+hd6tbKAUBlwKVOg63Kqvs7tVepmIrnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2/zGuNuFCzdxhmxUOhm7YSe3r4jzd5mPfUYEJXuphNIXjHVx7hj1kJHju/xS7NWg
         UuZAp6B0MT0X50OrPm2dcEZqnEZt+wM06l7pKpBJZ8GBVm4vc5B9Zg76+x+UGj4VBn
         PyFOSl4rkI0OkFeGlSTnZzPuD9Blr+m8wrk7o54o=
Date:   Wed, 17 May 2023 11:51:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 5.10 000/381] 5.10.180-rc1 review
Message-ID: <2023051704-catnip-vitality-d6cb@gregkh>
References: <20230515161736.775969473@linuxfoundation.org>
 <ZGNJfAPd8eeVoCJ3@debian>
 <2023051711-thespian-sponsor-8878@gregkh>
 <CA+G9fYvw6HJopruUn4QKPCcqbdgw++AFf1wnwMP9hP1rJsmq3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvw6HJopruUn4QKPCcqbdgw++AFf1wnwMP9hP1rJsmq3g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 03:11:48PM +0530, Naresh Kamboju wrote:
> On Wed, 17 May 2023 at 14:21, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, May 16, 2023 at 10:14:36AM +0100, Sudip Mukherjee (Codethink) wrote:
> > > Hi Greg,
> > >
> > > On Mon, May 15, 2023 at 06:24:11PM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.10.180 release.
> > > > There are 381 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > >
> > > Build test (gcc version 11.3.1 20230511):
> > > mips: 63 configs -> no failure
> > > arm: 104 configs -> no failure
> > > arm64: 3 configs -> 1 failure
> > > x86_64: 4 configs -> no failure
> > > alpha allmodconfig -> no failure
> > > powerpc allmodconfig -> no failure
> > > riscv allmodconfig -> no failure
> > > s390 allmodconfig -> no failure
> > > xtensa allmodconfig -> no failure
> > >
> > > arm64 allmodconfig build fails with the error:
> > >
> > > /gcc/bin/aarch64-linux-ld: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o: in function `__kvm_nvhe___kvm_tlb_flush_vmid_ipa':
> > > (.hyp.text+0x1a4c): undefined reference to `__kvm_nvhe_memset'
> > > /gcc/bin/aarch64-linux-ld: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o: in function `__kvm_nvhe___kvm_tlb_flush_vmid':
> > > (.hyp.text+0x1b20): undefined reference to `__kvm_nvhe_memset'
> > > /gcc/bin/aarch64-linux-ld: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o: in function `__kvm_nvhe___kvm_flush_cpu_context':
> > > (.hyp.text+0x1b80): undefined reference to `__kvm_nvhe_memset'
> >
> > That's odd, I don't see that symbol anywhere in the tree at all.
> >
> > And the only arm-related kvm changes don't have those symbols either
> > (the other kvm changes are x86-only)
> >
> > Also, no one else has seen this issue.  Can you bisect?
> 
> This is an old issue,
> Many other reported long back [1]
> 
> [1] https://lore.kernel.org/stable/CADYN=9KSKQx816id-zWepV-E3ozph3k2_i9Rhs6QseFv0hkPfg@mail.gmail.com/

Then maybe someone should submit it properly for inclusion?

thanks,

greg k-h
