Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5579874892A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjGEQZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjGEQZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:25:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EAAA9;
        Wed,  5 Jul 2023 09:25:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11F0861610;
        Wed,  5 Jul 2023 16:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA71DC433C7;
        Wed,  5 Jul 2023 16:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688574326;
        bh=l65JmUivLY90VE8juzqY+hoZRfzpdY5o0Cbe6TLs4zA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pw5oKXfEFazKk34nO+C4r/CzXjeW1J3yy9JYhiijAOixGeU1m2QXSj+KkAAhKT5kj
         xYJKPAh2uFHCZNNse/s0iVEX0IxX6OH8tQOrwN4ySJd5TKUANl6QBpWx1re38108gW
         lTupx/xdnKJ7v0RrUhPOx3xLQCTCCbK8DgOsM7PU=
Date:   Wed, 5 Jul 2023 17:25:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 00/13] 6.1.38-rc2 review
Message-ID: <2023070551-matcher-camping-98f0@gregkh>
References: <20230704084611.071971014@linuxfoundation.org>
 <824705ec-38ca-1587-573c-595b146ee2e1@roeck-us.net>
 <2023070529-barcode-unpleased-5705@gregkh>
 <2bbf215e-840d-138b-511f-b2602a3eeda8@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bbf215e-840d-138b-511f-b2602a3eeda8@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 09:13:58AM -0700, Guenter Roeck wrote:
> On 7/5/23 09:06, Greg Kroah-Hartman wrote:
> > On Wed, Jul 05, 2023 at 07:23:30AM -0700, Guenter Roeck wrote:
> > > On 7/4/23 01:48, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.1.38 release.
> > > > There are 13 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.38-rc2.gz
> > > > or in the git tree and branch at:
> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > > and the diffstat can be found below.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > > 
> > > > -------------
> > > > Pseudo-Shortlog of commits:
> > > > 
> > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >       Linux 6.1.38-rc2
> > > > 
> > > > Linus Torvalds <torvalds@linux-foundation.org>
> > > >       gup: avoid stack expansion warning for known-good case
> > > > 
> > > 
> > > I am a bit puzzled by this patch. It avoids a warning introduced with
> > > upstream commit a425ac5365f6 ("gup: add warning if some caller would
> > > seem to want stack expansion"), or at least it says so, but that patch
> > > is not in v6.1.y. Why is this patch needed here ?
> > 
> > It isn't, and was dropped for -rc2, right?
> > 
> 
> The above is from the -rc2 log so, no, it was not dropped. I checked in the
> repository to be sure. It is also in v6.3.12-rc2 and v6.4.2-rc2, but there
> it makes sense because a425ac5365f6 was applied/backported to those branches.

Ah, I must have dropped it right after the -rc2 announcement, it's been
a long week already:
	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=a5847f7c495fdc9c0a7b63703237f2891a6b6ed1

but be sure, it's gone from all branches now.

thanks,

greg k-h
