Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681DC6F71AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjEDSAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDSAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:00:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7C859F5
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:00:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFB5261426
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 18:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97661C433D2;
        Thu,  4 May 2023 18:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683223239;
        bh=06QOaU+SpcqPDkz/s2qgwS7uJCNUwPpQEaMShjUZgRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZDSNz4lBk8iewUYJAPWmA3pIAWwgyW/Q5ooAHOoyBhT9tBeLHqklA0VwkbHK6tA5
         LEySSXmzAO7/WM7k+uR7EvoF6FuwIC3PVzfYAcvZafjEmFQO9+G65Lmj7zU9Ip4jG7
         ETB6dkCVWRPUQX76eg0ZarsKcVt6up7bRax/pCJQSykF2h0f3fuE+JTSluPNQN4kSC
         4IcmuxdbOy93iNgwV98+Fr+DYaaUffYNGQfCi60+T6rifyhyxU5cX/SBCVBsqyvhbs
         AyQFC1yKQ4hwwHkKbuOc2CYdYR5XbdoUYvPNFnDO/Vt30sUEEisHLBa0wOkeWCfqaz
         oyP+/H4KfmhZg==
Date:   Thu, 4 May 2023 23:30:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [GIT PULL]: Generic phy updates for v6.4
Message-ID: <ZFPywqdpgESLD46Z@matsya>
References: <ZFI74eeUzVPKhi4f@matsya>
 <20230504150624.GA1000378@dev-arch.thelio-3990X>
 <ZFPPucb9VNLB8r8v@matsya>
 <CAHk-=wi-ve0h02vsNrzuox58rLXSbzcjay+k=XnUueWRh6cO2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi-ve0h02vsNrzuox58rLXSbzcjay+k=XnUueWRh6cO2Q@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-05-23, 10:23, Linus Torvalds wrote:
> On Thu, May 4, 2023 at 8:31 AM Vinod Koul <vkoul@kernel.org> wrote:
> > Sorry between vacation and travel, this was missed.
> >
> > No worries we have process to deal with this, so this shall go in as
> > fixes.. I will do the needful shortly
> 
> You need to do it *now*.

It was already done a bit ago and applied to my fixes and should be in
-next tomorrow. I will wait a day before sending you fixes update.

> You should never have sent the pull request to me in the first place
> if you hadn't checked the status in linux-next.
> 
> The point of linux-next is to find failures. And if you don't then
> *care* about the failures, then it has all become  entirely pointless,
> and it's effectively the same as if it had never been there in the
> first place.
> 
> So this needs to get fixed *PRONTO*, and it needs to never ever happen again.

Ack, agree I should have paid it more attention. Between vacation and
travel and stuff I have missed it this time, will ensure this doesn't
happen again.

> 
> Because if it does happen, I will consider your code to effectively
> never have been in linux-next, and thus just not be an option for
> pulling.
> 
> This isn't debatable. You don't put things in linux-next, ignore the
> reports, and then send things upstream anyway.
> 
> If you don't have time to check the status of your tree in linux-next,
> you don't have the time to do a pull request. That's just how it
> works.
> 
>                       Linus

-- 
~Vinod
