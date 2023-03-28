Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4DF6CCA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 21:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjC1TJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 15:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjC1TJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:09:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE639D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 12:09:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4372B6191D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 19:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8272EC433EF;
        Tue, 28 Mar 2023 19:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680030548;
        bh=iEymzBzaU4bQVBwE7T/LgoV6sJObq+3Ajj05E4kG0RA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=bF8B0JBDnMFzkv9fIUcE0kR8rLsBHwVf7frqmpVhrSneq8dovcCMUUXiwI1Ow5JHO
         isWy9/rwI/nHte6qSaLdC86LqKscxJyX46op3Xlit59JZRzsQxK3XIWND9NfSDAVaf
         WmVht3Odvelj5/fsHDyMos2qDLk2/PPzXOOic+eE94Hgdm5y1sZEQFKRZFK1YHDJvO
         94RTD0h6yiOl91X6Js9+fAAJ1zxGs/wg6ijKSOWoYyKPw/Sp9Q51lcBOvGjtYXg12Q
         WGUWCObNHgt7dWsac+J7Hn284QB8uzgnQ2fuJ/YEuO+zS1lNj5uxyxt+i+yKMBV+QF
         erdDR75egBz6A==
Date:   Tue, 28 Mar 2023 12:09:06 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Slim and optimized LLVM toolchains for building the Linux kernel
Message-ID: <20230328190906.GB375033@dev-arch.thelio-3990X>
References: <20230319235619.GA18547@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319235619.GA18547@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 04:56:21PM -0700, Nathan Chancellor wrote:
> Hi everyone,
> 
> To make building the Linux kernel with clang/LLVM easier and more
> accessible to people (since distributions tend to only package one
> version at a time and it may be old or have bugs that have since been
> fixed), I have uploaded some slim, profile guided optimized LLVM toolchains
> to my section of kernel.org/pub:
> 
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/nathan/llvm/

This is now

https://mirrors.edge.kernel.org/pub/tools/llvm/

so that they are no longer tied directly to my kernel.org account. I
have updated the README with additional information based on feedback
that I have received thus far.

> The landing page should have all the relevant information but if I need
> to clarify or expand on anything, I am more than happy to do so.
> 
> Due to benchmarking the compilers against the kernel during PGO, they
> can handily beat distribution versions that have not been optimized:
> 
> https://gist.github.com/nathanchance/8d1abed70077ac92cb198ef32389072e
> 
> I aim to keep these up to date with the latest stable versions of LLVM
> as they are released (so 16.0.0 will be replaced with 16.0.1 when it is
> released, etc).

Cheers,
Nathan
