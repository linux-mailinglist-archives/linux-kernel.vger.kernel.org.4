Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB2668DDF8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjBGQ3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjBGQ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:29:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736493E0B6;
        Tue,  7 Feb 2023 08:29:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E64FC60DE1;
        Tue,  7 Feb 2023 16:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BA9C433EF;
        Tue,  7 Feb 2023 16:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675787340;
        bh=dDevxFmx4nPr6l+g/cb4GQD7A8atVYaQ4UfrYU36L5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSHVPFMxSejPzpwEk9GYVVQQ5dNWOxcu/ii2+QHh4kwQGnMZeAqCJchqgWuZ1j6bD
         y72jJzamDDkZZLD0fN5FLKQ8vzCC2Pzpv+vDjkEIABlVUBjNTqjIz69weiNCK8MZ6Y
         PKMlKmnr6RKLPJw29OX1HhFa7eBX/srI9Dn554k1lBrKlnFoe6lRsPTCDZXicAgARy
         X8qIlTK7huyf8no2jar4LDbV4cH1gPB+KCRnhbFjhhhCiyXr14kUMiE9JLzrsABNA9
         2RLnh8LeF8PVUrbWoz4QGYMwkXK5fP/tdOViD9JoE2XX+HPkePOEiteMSXoA1JBZWP
         5vcJ7oD467maw==
Date:   Tue, 7 Feb 2023 09:28:58 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     llvm@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, borislav.petkov@amd.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: x86/include/asm/arch_hweight.h:49:15: error: invalid input size
 for constraint 'D'
Message-ID: <Y+J8SobyVojJWuFv@dev-arch.thelio-3990X>
References: <CA+G9fYuSWodh1teau4jGG_P15yT-ev1+bS7HAAmMu5D5J-d2vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuSWodh1teau4jGG_P15yT-ev1+bS7HAAmMu5D5J-d2vw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

On Tue, Feb 07, 2023 at 01:27:05PM +0530, Naresh Kamboju wrote:
> Following Build regressions warnings / errors noticed on Linux next-20230207.
> 
> Regressions found on x86_64:
> 
>     - build/clang-15-lkftconfig-compat
>     - build/clang-nightly-lkftconfig
>     - build/clang-15-lkftconfig
>     - build/clang-15-lkftconfig-kcsan
>     - build/clang-lkftconfig
> 
> In file included from arch/x86/entry/vdso/vdso32/vgetcpu.c:2:
> In file included from arch/x86/entry/vdso/vdso32/../vgetcpu.c:8:
> In file included from include/linux/kernel.h:22:
> In file included from include/linux/bitops.h:68:
> In file included from arch/x86/include/asm/bitops.h:420:
> arch/x86/include/asm/arch_hweight.h:49:15: error: invalid input size
> for constraint 'D'
>                          : REG_IN (w));
>                                    ^
> In file included from arch/x86/entry/vdso/vdso32/vgetcpu.c:2:
> In file included from arch/x86/entry/vdso/vdso32/../vgetcpu.c:8:
> In file included from include/linux/kernel.h:25:
> In file included from include/linux/math.h:6:
> arch/x86/include/asm/div64.h:85:34: error: invalid output size for
> constraint '=a'
>         asm ("mulq %2; divq %3" : "=a" (q)
>                                         ^
> 2 errors generated.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thanks a lot for the report as always! Looks like there is a fix pending
on the list:

https://lore.kernel.org/Y+IsCWQdXEr8d9Vy@linutronix.de/

Cheers,
Nathan
