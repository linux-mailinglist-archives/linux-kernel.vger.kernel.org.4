Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5256C7CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCXKyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCXKyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:54:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527E9244A6;
        Fri, 24 Mar 2023 03:54:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1C1F62A1D;
        Fri, 24 Mar 2023 10:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87892C433D2;
        Fri, 24 Mar 2023 10:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679655247;
        bh=05TRJlmt+n+Rfz7qihEXoMNgUCXEtNcYL32YthagoLk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZdbMGXD2UULJcRdC1qoFKwkOtzO9RKWLMKHs725xtj9tNndRiEi44p+zwT8wrbwDo
         NHKyZ+8ybCye8FZr3sG37zSwGBbhA4RCAF6jdIEs0kWrXLD4KhQ8oRcr/n+8xHtByd
         G7H0+6phPKzTpebgXRik23ixC6/0z10+AhmHLDElSIWR3TGHpjKfKhDToPXG58HGWB
         ce3LWVy11a8jdY3uiBG0n8BzR5nh1QCAYt2SRwRV1beohunn//XetphFXcpOo23ErM
         oc5fJ+ATOkRWfOAIL0c827OB/A8E19Bk/LSpd99zsGqX5n8IypFCK7zNHJIOdWi/Mw
         J/QM20+MiDm+g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-toolchains@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: Linux 6.3-rc3
References: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
        <20230320180501.GA598084@dev-arch.thelio-3990X>
        <CAHk-=wgSqpdkeJBb92M37JNTdRQJRnRUApraHKE8uGHTqQuu2Q@mail.gmail.com>
        <20230320185337.GA615556@dev-arch.thelio-3990X>
        <87pm91uf9c.fsf@kernel.org>
        <20230322163637.GA918620@dev-arch.thelio-3990X>
Date:   Fri, 24 Mar 2023 12:54:01 +0200
In-Reply-To: <20230322163637.GA918620@dev-arch.thelio-3990X> (Nathan
        Chancellor's message of "Wed, 22 Mar 2023 09:36:37 -0700")
Message-ID: <87wn36ctdi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Chancellor <nathan@kernel.org> writes:

> On Wed, Mar 22, 2023 at 02:44:47PM +0200, Kalle Valo wrote:
>> Nathan Chancellor <nathan@kernel.org> writes:
>> 
>> > Perhaps these would make doing allmodconfig builds with clang more
>> > frequently less painful for you?
>> >
>> > https://lore.kernel.org/llvm/20230319235619.GA18547@dev-arch.thelio-3990X/
>> 
>> Thank you, at least for me this is really helpful.
>
> Really glad to hear! I hope this helps make testing and verifying
> changes with clang and LLVM easier for developers and maintainers.

It really does. And I hope you are able to update these packages in
future as well so that it would be easy to get the latest clang.

>> I tried now clang for the first time but seeing a strange problem.
>> 
>> I prefer to define the compiler in GNUmakefile so it's easy to change
>> compilers and I don't need to remember the exact command line. So I have
>> this in the top level GNUmakefile (all the rest commented out):
>> 
>> LLVM=/opt/clang/llvm-16.0.0/bin/
>> 
>> If I run 'make oldconfig' it seems to use clang but after I run just
>> 'make' it seems to switch back to the host GCC compiler and ask for GCC
>> specific config questions again. Workaround for this seems to be adding
>> 'export LLVM' to GNUmakefile, after that also 'make' uses clang as
>> expected.
>
> Interesting... I just tested with a basic GNUmakefile and everything
> seems to work fine without an export. At the same time, the export
> should not hurt anything, so as long as it works, that is what matters.

Sure, once I figured out the quirks I can workaround them. I was just
hoping that other users would not have to go through the same hassle as
I did :)

> If you have any further issues, please do not hesitate to reach out!

This is nitpicking but it would be nice if the tarball contents wouldn't
conflict with each other. Now both llvm-16.0.0-aarch64.tar.gz and
llvm-16.0.0-x86_64.tar extract to the same directory llvm-16.0.0 with
same binary names. It would be much better if they would extract to
llvm-16.0.0-aarch64 and llvm-16.0.0-x86_64, respectively.

For example, Arnd's crosstool packages don't conflict with each other:

https://mirrors.edge.kernel.org/pub/tools/crosstool/

And maybe request a similar llvm directory under pub/tools to make it
more official? :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
