Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F50611D79
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJ1WnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ1WnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:43:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4379D1BA1EF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:43:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E03B562AC3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75AFC433D6;
        Fri, 28 Oct 2022 22:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666996980;
        bh=34c6l6gV15ZGIVGR9RSKf5GQmfOYDa5a8AkQQVHMlEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMvpcmeK0wFUUVxkzsszNeUeYKc5PFKsAk8Q+SQjcPlDSNkEoY/bzPhfWfKWVT1ZX
         0Nou8iS1eOMO4r4WXjqCXRDUjqaEbYXWZc5yS0WfEEBSzpL8sg4xh6/Nvawqj/TYTD
         NlVc92neML8BvmoiIoeszV35JYxEr0weFKgn8rO6kTJzF8N4RWnplK0DIb/kpe3Vif
         Oj4iKYjbjNJT7tcnNwZ45JCNL5pv5IpLss7yem0OuPk7TeJdWiYuBMAwblUoCuW/t1
         07W0C0c0+VqSMCH0RgC2XqKVjfrxroiqXg8MH1t8bibFB6FokUPlQzvz0eK8e2KpwU
         CW8i9AbPis2Ew==
Date:   Fri, 28 Oct 2022 23:42:55 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, waterdev@galaxycrow.de,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: fix styling in ucontext header
Message-ID: <Y1xa782WsdULPIiL@spud>
References: <Y0/PfL5SWNw8HCLr@wendy>
 <mhng-036eff83-1a93-4e98-9810-a4abb79e55e7@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-036eff83-1a93-4e98-9810-a4abb79e55e7@palmer-ri-x1c9a>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 03:23:21PM -0700, Palmer Dabbelt wrote:
> On Wed, 19 Oct 2022 03:20:44 PDT (-0700), Conor Dooley wrote:
> > On Wed, Oct 19, 2022 at 12:07:58PM +0200, Cleo John wrote:
> > > 
> > > Hey, because I am new to Kernel submissions I wanted to ask if there is a way for me to see / track how far this commit has gone in the pipeline of commits?
> > 
> > https://patchwork.kernel.org/project/linux-riscv/patch/20221010182848.GA28029@watet-ms7b87/
> > 
> > IIRC you sent the patch during the merge window, so it wouldn't be
> > applied for v6.1-rc1. You'll get an email from the patchwork-bot when it
> > gets applied.
> 
> Yep, this is one of the more confusing parts of the Linux development
> process for new folks (or at least was for me when I was new): you send a

Nope, was the case for me too. Same applies to most subsystems, think
probably places like netdev are good in that regard as their review
cadence is really good.

> patch and it's not super clear what's going to happen to it for a while.
> The merge window is generally a pretty hectic time, so stuff like this
> that's not fixing a bug or adding some frameware that other patches depend
> on can kind of get lost in the shuffle.
> 
> I always feel kind of bad for folks about that, but patchwork should help
> some here as at least we can get the smaller stuff called out.

Yeah, hopefully patchwork helps. If we keep on top of it & over time
it'll get more useful for infrequent contributors - but for first time
contributors I'm not sure what to do other than for people that notice
it is a first time contributor to be helpful to them?
