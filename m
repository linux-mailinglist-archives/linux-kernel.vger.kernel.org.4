Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2639746C24
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGDIkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjGDIj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:39:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B66C4;
        Tue,  4 Jul 2023 01:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B96696119B;
        Tue,  4 Jul 2023 08:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E67EC433C8;
        Tue,  4 Jul 2023 08:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688459998;
        bh=mCVClS7EcoGBFNazRWSxsNvPRy+H3H1JIh9ATrI8UCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dd/FuTChwX77AfBKIZnW69EFpeMNFMO/AelldNOoD3O6jQfKZtW4Zf+VR/DCsv8Ey
         xVgFKzUD/3TtMbKNzA8X4XhWmAg9Rgz7SsveJGTlWG4kyMzdAiTq/hFkSBYOC74dMn
         PjxXZ+TaUQlZxMaxC4IivTT4HZyprNFS9mvice/s=
Date:   Tue, 4 Jul 2023 09:39:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.3 00/13] 6.3.12-rc1 review
Message-ID: <2023070436-evident-constant-890f@gregkh>
References: <20230703184519.206275653@linuxfoundation.org>
 <CA+G9fYvf-sw8tCHjxhoMvHrtzzdE69EwvB2PmypUkGDdCFFASA@mail.gmail.com>
 <2023070411-steadfast-overtly-02a3@gregkh>
 <2023070416-wow-phrasing-b92c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023070416-wow-phrasing-b92c@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 09:24:37AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jul 04, 2023 at 08:43:54AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Jul 04, 2023 at 01:04:36PM +0530, Naresh Kamboju wrote:
> > > On Tue, 4 Jul 2023 at 00:26, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > This is the start of the stable review cycle for the 6.3.12 release.
> > > > There are 13 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Wed, 05 Jul 2023 18:45:08 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.12-rc1.gz
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > 
> > > 
> > > While running LTP hugetlb testing on x86 the following kernel BUG noticed
> > > on running stable-rc 6.3.12-rc1.
> > > 
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > 
> > > Crash log:
> > > =========
> > > [   54.386939] hugefallocate01 (410): drop_caches: 3
> > > g tests.......
> > 
> > And this worked on 6.3.11 just fine?
> > 
> > Trying to narrow down what would have caused this...
> > 
> > Any chance you can run Linus's tree with thie LTP test as well?
> 
> Ah, I can hit this here locally too!  Let me bisect...

Found it.  I'll drop the offending patch and push out a new -rc release,
thanks.

greg k-h
