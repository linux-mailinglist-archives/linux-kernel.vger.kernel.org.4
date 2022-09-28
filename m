Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7A05EE8B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiI1VyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiI1Vxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:53:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566F1B6023
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:53:51 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cv6so3389425pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ay3drFi6JCOWyd7mwYuzVhdDqZJYtGvjCnOOuic4lIQ=;
        b=d8AWbiSBxXrgrvwAoskxcicNPYKtAtvQ8eTNvx31A5tDj05HG3JYRAX8qf2vlcBFux
         Q1KTlPLAgoTxKVWu/nVzVOf7AiT7GTQhdNsUYqMxZ71hoxMdvb5Q9qsvn3yjzUg5VS4Z
         AeFBZtfNn12MoU7iIzQGkn5wjz+gaTpfVO1hEeE57+wJ12W7ze2a3aRKpnA8Lx9MTtIJ
         grbEUQMs3nxDSYRKy9B5Ov4jaMGgXhqeyepODAApSSchrz1BCHHbq4bwQtIzq5YjUq/5
         KGRlA9uTZis4skTF0coWa95GNfO6iWQbU6avtKMDiR8zb+dfBnXP+edrsxPOv/ezAxb2
         ZDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ay3drFi6JCOWyd7mwYuzVhdDqZJYtGvjCnOOuic4lIQ=;
        b=2zU3Q7fYKOSEenvMlBc54I+VYkhVy2J5otOOQK6tBpXDmsMw5ipWyIVMynYyD2gZK3
         YmEVXKJLEFiNffbKAcDiTOuR7YIl8gRxNbvNXdDFqCeFOiSQ9vPZBmEl1ONnqID+n5Ju
         UZGnmFFVHbv4hNkZxaUNDTso9g9Xl7XcZWCh6Yb+FIsMX2yzeo3/MwF/1pyx7zm5leqt
         IueH9vT3P/PXB3ap9VjFXRT9I6Ad+mAGaRt1W5juprkqqMph20R2uQxOIFWOxB6EdlY9
         Tgfxw1KQBN/mTqvJIaBDvz6Se7vMqaLsGYabdublidgAPpaYyQ9xCOiTDxh24yi45rLw
         x3nw==
X-Gm-Message-State: ACrzQf25op5+xxCxTtcw6Xv3UGIUMEB9GUqXsLKmIz6KqsqZXT6XpHgM
        0mE8bAphntygcDNh18oQZChduKP69wNIFysJbhj2fQ==
X-Google-Smtp-Source: AMsMyM6+V0RnFW83E4Yey5hPTG/WNDzcVaQZ9uZmK44iTcOwLQ3OpYQRTfUlegcvBrQLEHiPkA+P6skieEZazNbCnnA=
X-Received: by 2002:a17:90a:74c4:b0:203:336d:dd36 with SMTP id
 p4-20020a17090a74c400b00203336ddd36mr12421313pjl.107.1664402030259; Wed, 28
 Sep 2022 14:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220928182523.3105953-1-nathan@kernel.org> <CAKwvOdmPLqX=oCwg43TYHj=tdoaU5OYc=bO906u=LeqcSrx+Dw@mail.gmail.com>
 <YzS+bQT1zJAUpp/6@dev-arch.thelio-3990X>
In-Reply-To: <YzS+bQT1zJAUpp/6@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Sep 2022 14:53:38 -0700
Message-ID: <CAKwvOdk87wRWoiVjswZPwoLbSm+sYsMW6FHZv+r6MHxLHn0Trw@mail.gmail.com>
Subject: Re: [PATCH] lib/Kconfig.debug: Add check for non-constant
 .{s,u}leb128 support to DWARF5
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rix <trix@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        llvm@lists.linux.dev, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 2:36 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, Sep 28, 2022 at 02:13:47PM -0700, Nick Desaulniers wrote:
> > Reraising my concern from
> > https://github.com/ClangBuiltLinux/linux/issues/1719#issuecomment-1258678969
>
> Sorry, I thought I addressed your concern with my comment right below it
> but I probably should have worded it better.

No, I just missed your point about other architectures.

> > We've put a fair amount of work into getting CC=clang LLVM_IAS=0 to
> > work for DWARF v5 (both on the GNU binutils side, and Kbuild), I'd
> > hate to see that effectively knee-capped because of an issue in GNU
> > binutils that is only relevant for one architecture.
>
> Sure, that is a completely reasonable concern. However...
>
> > I'd concede support for ARCH=riscv, but not for all other
> > architectures, which this effectively does.
>
> No, it does not, CONFIG_AS_HAS_NON_CONST_LEB128 can still be enabled
> when GNU as supports this construct for a particular architecture; as
> far as I can tell, RISC-V is the only one that doesn't. See the tests
> with ARCH=arm64 and ARCH=x86_64 compared with ARCH=riscv below.

Ah, sorry for the noise then. Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
