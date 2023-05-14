Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8DC701B0C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 03:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjENBOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 21:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjENBOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 21:14:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBD52136;
        Sat, 13 May 2023 18:14:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E734260BC9;
        Sun, 14 May 2023 01:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BECC433EF;
        Sun, 14 May 2023 01:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684026877;
        bh=3QdJmr5m5maa+XMrfY3oVoJ0UuEdW/AsePQKgllnAbs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ezmVz2Kf5i+Bvqt7ZzT0jF2ekEag7PtilgCm6IvZ//zlxSixtCSWoGrAYKIemvaH+
         Xrfcczv8DKWmw0wiwK4AyqIyBNCJfdFBeARXmgYhynMvGvh88EnMxuhy2U6KTM+l/9
         GFKkmRmZw6/m3rD+wwjzyCSLN7I8PG3AAHfDO4Y9Py8xO/vnRgzXs19Gzl+HPv2c5M
         teUfxi97rDZlPEdSNjYxP1+CwpyHgoqooavumGTrt96D9Xw0TymHnWHO/5zALm8Vo/
         ygInTjpY/AkQLH6b7dgBNTC5LgbMJJ4JIsC8swvFH3g1LKlyb8tV0SGimImJx714+Q
         3BdmuAPCyNF0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ED534CE007B; Sat, 13 May 2023 18:14:36 -0700 (PDT)
Date:   Sat, 13 May 2023 18:14:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH locking/atomic 18/19] locking/atomic: Refrain from
 generating duplicate fallback kernel-doc
Message-ID: <551c7820-1748-433b-8c42-daf777e202df@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
 <20230510181717.2200934-18-paulmck@kernel.org>
 <ZF0haDfyL3At3Ijw@FVFF77S0Q05N.cambridge.arm.com>
 <2a8b310c-3145-462b-a4c4-a130939da862@paulmck-laptop>
 <ZF48uBYKczItubrU@FVFF77S0Q05N>
 <b5498819-c2d4-414d-ba01-5373e749dc52@paulmck-laptop>
 <ZF5xXuPsrZEgAEEE@FVFF77S0Q05N>
 <e767dcc6-ea63-4ed8-9a15-9e5bb133fafc@paulmck-laptop>
 <b3956719-d478-4dc6-95fd-ec0744acc662@paulmck-laptop>
 <23195f15-7024-6fde-84f2-4cdd45c9abfc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23195f15-7024-6fde-84f2-4cdd45c9abfc@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 08:58:00AM +0900, Akira Yokosawa wrote:
> Hi,
> 
> On Fri, 12 May 2023 19:11:15 -0700, Paul E. McKenney wrote:
> [...]
> 
> > 
> > And here is a rough first cut:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/fallback-rework-kernel-doc.2023.05.12a
> > 
> > Or via HTML:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/log/?h=fallback-rework-kernel-doc.2023.05.12a
> 
> Running "./scripts/kernel-doc -none include/linux/atomic/atomic-arch-fallback.h"
> on the tag emits a lot of warnings.
> 
> Looks like there are kernel-doc comments who don't have a corresponding
> function signature next to them.
> 
>     /**
>      * function_name() - Brief description of function.
>      * @arg1: Describe the first argument.
>      * @arg2: Describe the second argument.
>      *        One can provide multiple line descriptions
>      *        for arguments.
>      *
>      * A longer description, with more discussion of the function function_name()
>      * that might be useful to those using or modifying it. Begins with an
>      * empty comment line, and may include additional embedded empty
>      * comment lines.
>      */
>     int function_name(int arg1, int arg2)  <---
> 
> Note that the kernel-doc script ignores #ifdef -- #else.

Me, I was thinking in terms of making this diagnostic ignore
include/linux/atomic/atomic-arch-fallback.h.  ;-)

The actual definitions are off in architecture-specific files, and
the kernel-doc headers could be left there.  But there are benefits to
automatically generating all of them.

Another approach might be to put a "it is OK for the definition to
be elsewhere" comment following those kernel-doc headers.

Any other ways to make this work?  For me, the option of making this
diagnostic ignore include/linux/atomic/atomic-arch-fallback.h has
considerable attraction.

> BTW, I couldn't checkout the tag so downloaded the tar ball via
> HTML.

Tags can be a bit annoying in that way.  I will provide a branch next
time.

							Thanx, Paul

>         Thanks, Akira
> 
> > 
> > Thoughts?
> > 
> > In the meantime, enjoy the weekend!
> > 
> > 							Thanx, Paul
