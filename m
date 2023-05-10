Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6246FE7C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbjEJW60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbjEJW6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:58:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C126E64;
        Wed, 10 May 2023 15:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F8E664114;
        Wed, 10 May 2023 22:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CADAC433EF;
        Wed, 10 May 2023 22:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683759502;
        bh=g8qGJpAEyuVgyeWPgBU0j7jqjsddasHX4jJ7f76dAZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tD9AkRjvYqaW85zt2vC2nz5/a+JYU3owoSLi1T4W+ulrKVFged9zKZhwbUDfVTGra
         DIpQtGfwtNvzodu0rnGPanm2UrsSIj8Eu5dMqHbV94AHban0axExy1IePS41DMx5Ww
         dT3I2cxgvRsDX4yKj8fgBlGRweL4V8nQxmBdtB7M=
Date:   Thu, 11 May 2023 07:58:17 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, laoar.shao@gmail.com
Subject: Re: [PATCH 5.15 000/370] 5.15.111-rc2 review
Message-ID: <2023051154-activator-aside-bc8e@gregkh>
References: <20230509030611.521807993@linuxfoundation.org>
 <863a112f-f4a4-d580-9687-f6214d555939@linaro.org>
 <2023051035-monitor-sandy-2a5b@gregkh>
 <CAEUSe79AViqsHimbYbFjkKAxcvROGhFKA2yKVuC3aP1Gm=jc1w@mail.gmail.com>
 <CAEUSe7_ZBW_hPUZYeKkZ6zuckeqYb+O46GdgGx0wE6T0=c5wZg@mail.gmail.com>
 <4d3c5462-1788-426a-a44a-e839b1c4970d@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d3c5462-1788-426a-a44a-e839b1c4970d@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 12:53:48PM -0700, Guenter Roeck wrote:
> On Wed, May 10, 2023 at 11:00:42AM -0600, Daniel Díaz wrote:
> > Hello!
> > 
> > On Wed, 10 May 2023 at 09:46, Daniel Díaz <daniel.diaz@linaro.org> wrote:
> > > Hello!
> > >
> > > On Wed, 10 May 2023 at 01:43, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > On Tue, May 09, 2023 at 09:12:33AM -0600, Daniel Díaz wrote:
> > > > > Hello!
> > > > >
> > > > > On 08/05/23 21:26, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 5.15.111 release.
> > > > > > There are 370 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > >
> > > > > > Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> > > > > > Anything received after that time might be too late.
> > > > > >
> > > > > > The whole patch series can be found in one patch at:
> > > > > >     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.111-rc2.gz
> > > > > > or in the git tree and branch at:
> > > > > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > > > > and the diffstat can be found below.
> > > > > >
> > > > > > thanks,
> > > > > >
> > > > > > greg k-h
> > > > >
> > > > > New warnings are introduced for Arm, PowerPC, RISC-V:
> > > > >
> > > > >   /builds/linux/kernel/sched/debug.c: In function 'print_cfs_group_stats':
> > > > >   /builds/linux/kernel/sched/debug.c:465:41: warning: unused variable 'stats' [-Wunused-variable]
> > > > >                   struct sched_statistics *stats =  __schedstats_from_se(se);
> > > > >                                            ^~~~~
> > > >
> > > > Odd, and this isn't on other kernels too?
> > >
> > > Only on 5.15, not on the 6.x RC's. I'll share more info after my
> > > bisection is done.
> > 
> > Bisection leads to:
> > 
> >   sched: Make struct sched_statistics independent of fair sched class
> > 
> > Reverting makes the warning disappear.
> > 
> 
> Commit 769fdf83df57 ("sched: Fix DEBUG && !SCHEDSTATS warn") explains why
> this works upstream.

Thanks!  Turns out someone put the wrong "Fixes:" tag in that commit
which is why I missed it.  Now queued up.

greg k-h
