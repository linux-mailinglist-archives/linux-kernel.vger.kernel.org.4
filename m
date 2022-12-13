Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6153964B542
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiLMMg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbiLMMgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:36:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624C418B10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:36:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7D3C614C6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B1AC433D2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670934983;
        bh=0Xw+Dqf9EeRU735a3/tFqNdCp+AD7AJJJF6DkxVcHkA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=erPv/EQS8CdtXSVv5QdpauwXWq5Gd8wAPzPJ8T0Kp9UirIMcPwbzfsBe8YwvD5p3o
         cLY6iH0wt4cDR80M0l05EDO8gyzJ1KnzS6wnqUQzx73KDyRvxDHDkk09OWvHEkBLy9
         fOGuN2GYg9ffzXyM9gi4e6MahaHI3ApQcOuY7XHSTHnytrov9Rmtbc60XOPJcwUbov
         PKDu6wbnfE6IlHa54SBhr5wjNQZY/1UHMUnOXb9vRfb2TuKRIaEFd06yW+SSnxx4b3
         ZABZ87B17Kkr4u/7L3S+md5hdIfrORgPMHqz05ep2fkIg/kxylFtvVR+YXOSKCuXXV
         MNd2otzoBjOSA==
Received: by mail-lf1-f51.google.com with SMTP id bp15so4625222lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:36:23 -0800 (PST)
X-Gm-Message-State: ANoB5pmy5BB1dCO7UxhOPpFIT925P9A5wQJB1ceQiPs2Meo4eVUWw96x
        Pzt5TY6tCF8ZRsJYRvZ2lPPMU0+d/TziysMKFkQ=
X-Google-Smtp-Source: AA0mqf5Rv7sK6jU2Bfo5hGdRVw8IW6AsCRcC1gxd4lb5J7HqVSXSGtZ4ePkevgylC/0l0DZIv+RmwcRQnFQYq7RjZ/Y=
X-Received: by 2002:a19:6b19:0:b0:4a2:740b:5b02 with SMTP id
 d25-20020a196b19000000b004a2740b5b02mr30598166lfa.122.1670934981185; Tue, 13
 Dec 2022 04:36:21 -0800 (PST)
MIME-Version: 1.0
References: <20221209112500.GA3116@willie-the-truck> <CAHk-=wj-8gKB5SG0w_M2fK0KYyhZbNzDZ1W9H5pmisWzJ0XJEw@mail.gmail.com>
 <20221213121118.GB5719@willie-the-truck>
In-Reply-To: <20221213121118.GB5719@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 13 Dec 2022 13:36:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFf0CYxL28T65WxXUbTwZHJET5Az+oDSxO04zsvkJqwSw@mail.gmail.com>
Message-ID: <CAMj1kXFf0CYxL28T65WxXUbTwZHJET5Az+oDSxO04zsvkJqwSw@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 updates for 6.2
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

l

On Tue, 13 Dec 2022 at 13:11, Will Deacon <will@kernel.org> wrote:
>
> Hi Linus,
>
> [+Ard]
>
> On Mon, Dec 12, 2022 at 10:05:07AM -0800, Linus Torvalds wrote:
> > On Fri, Dec 9, 2022 at 3:25 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > Dynamic SCS:
> > >         * Support for dynamic shadow call stacks to allow switching at
> > >           runtime between Clang's SCS implementation and the CPU's
> > >           pointer authentication feature when it is supported (complete
> > >           with scary DWARF parser!)
> >
> > I've pulled this thing, but this part makes me nervous. There's some
> > bad history with debug information not being 100% reliable probably
> > simply because it gets very little correctness testing.
>
> Hey, I did use the word "scary"! This is, at least, very easy to back
> out (it's effectively an optimisation) if the DWARF info ends up being
> too unreliable and causes issues in practice. We're also only looking
> at .eh_frame here, which should hopefully get a lot more correctness
> testing when compared to the .debug sections due to exception unwinding.
>

Indeed. And this is Clang 15+ at the moment, for precisely this reason.

> > It might be worth thinking about at least verifying the information
> > using something like objtool, so that you at least catch problem cases
> > at *build* time rather than runtime.
>
> Checking that the DWARF data looks sensible at build time isn't a bad
> idea, but see below as I think we can probably still produce a functional
> kernel Image in this case.
>
> > For example, that whole
> >
> >     default:
> >         pr_err("unhandled opcode: %02x in FDE frame %lx\n",
> > opcode[-1], (uintptr_t)frame);
> >         return -ENOEXEC;
> >
> > really makes me go "this should have been verified at build time, it's
> > much too late to notice now that you don't understand the dwarf data".
>
> This isn't actually as bad as it looks -- the patching operation here
> only kicks in on CPUs which do not implement the pointer authentication
> instructions (i.e. where the CPU executes these as NOPs). Therefore, if
> patching bails out half way due to the "unhandled opcode" above, we
> should be ok, albeit missing some SCS coverage.

Indeed.

> I say "should" because
> if we fail within a frame after patching in the SCS "push" but before
> patching in the "pop", then we'd end up with a corrupt SCS pointer.
>
> Ard -- do you think we could tweak the patching so that we patch the push
> and the pop together (e.g. by tracking the two locations on a per-frame
> basis and postponing the text poking until just before we return from
> scs_handle_fde_frame())?
>

The push and the pop are not necessarily balanced (there may be more
than one pop for each push), and the opcode we look for
(DW_CFA_negate_ra_state) may occur in places which are not actually a
pop, so tracking these is not as straight-forward as this.

What we could do is track the push and the first pop on a first pass,
and if we don't encounter any unexpected opcodes, patch the push and
do a second pass starting from the first pop. Or just simply run it
twice and do no patching the first time around (the DWARF frames are
not very big)
