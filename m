Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629AF6FBD77
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjEIDDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbjEIDDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:03:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1BF4C15;
        Mon,  8 May 2023 20:03:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5E32630DA;
        Tue,  9 May 2023 03:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDE7C433D2;
        Tue,  9 May 2023 03:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683601381;
        bh=YPHQfv7IscC0DBbnpqrUWLJ6kDkQr6sORNu5Wm0HuLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bzGkgGW2BVks9KLVgl3jZFwivq02uB98DtZh6Qz1IStajuD1AfkIzuY8J3h6TQPQV
         XHBNbSZd/p7LrlweQukb4sTN3LMRt0Lm2nobxtW9J1h6mPkSq0cGxoNwcxcSrZqp6A
         PVcWYEhlqCIlSpMuOWCwO/fKykRMQ6YN3ExPjc/k=
Date:   Tue, 9 May 2023 05:02:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     stable@vger.kernel.org, Pierre Gondois <pierre.gondois@arm.com>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc1 review
Message-ID: <2023050932-avenging-annex-0cef@gregkh>
References: <20230508094432.603705160@linuxfoundation.org>
 <0ab5fa02-c2cf-fe09-8825-a25493f6e358@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ab5fa02-c2cf-fe09-8825-a25493f6e358@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 03:46:02PM -0700, Florian Fainelli wrote:
> On 5/8/23 02:37, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.3.2 release.
> > There are 694 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 10 May 2023 09:42:40 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.2-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> We also need to bring in this patch from upstream:
> 
> 3522340199cc060b70f0094e3039bdb43c3f6ee1 ("arch_topology: Remove early
> cacheinfo error message if -ENOENT") otherwise we will be spitting out the
> "Early cacheinfo failed, ret = " messages on boot.

Now queued up, thanks!

greg k-h
