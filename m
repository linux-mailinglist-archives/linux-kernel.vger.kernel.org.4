Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C693D5F586B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJEQi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJEQiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:38:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E785A6DFB1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 09:38:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g28so1231750pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oQbM0nVWmaDXyk82cl6r367zDWVYGaPQODZVcdO+QZM=;
        b=Hvcb5sHqdru0SR4QpRIz/cd5ZjallOVpwA/Xe1rPLCdPvyRIAk3u2ZzmOM+RCSI4jO
         xwGVJxU60hIgDlibk/ghL6C0nR+WwOg3rwgU9dZ+xS3HmhEdtDucFiWz6Jh47/7Yarn8
         mYpnPD5igo+2paasd/TO+B/9xkXR9uEHlwTrhKvIrvCTAOf2BXnATMSDQHxI7lKESOQd
         77fdwtyclHf4iHYpXv1jqvj5lFtaIlvlg6qZrtUyopdTpppjkDJCMdC/xBgcTgbkQwFb
         /4mq3kG7xMSbvqgwG7o5F4vcnrLKamlu5jbzAh2W1lzrlQTZJ1Kwn8XUra5gHp91EhHi
         SSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oQbM0nVWmaDXyk82cl6r367zDWVYGaPQODZVcdO+QZM=;
        b=DQDxhl5DyXkkJJAtSvrpA9DGHjfsKCgeT+k8J00WXipaoqcZ8iOPbWtqWHKfKpbg4a
         FIl8udgXx1PqVXvsu8T6fDMFUnC/y/rTNuJJBYlDZnL10Qd7AfN5B4COesb+pLzdh8aV
         5JMaSIBtoBCqh8m1xf61cP7IFSYuigmgYZC01wALE9smVl3T89Y/asd+Hlw1grcjsEMW
         PpZcbMBCvKL/5cyQrMnpENDNTdWSNK80JbAffXAvCJBNflZmzV6550gOVjwMOebasmwJ
         md7LCerloL9KsCGl7iEJPJ5XSUR5fttTX23mEK/ycPnEKYQk5zljtKi2StR7GaJY5j2n
         bttQ==
X-Gm-Message-State: ACrzQf1YbSx0gXjhm+507SIEs4C+LNQmM4TvF7Cj7DMWuNW+OtU7exrx
        yrlRlROFWrQEFlJD3YP/J0n4//9s6d10MbwMzjvQRQ==
X-Google-Smtp-Source: AMsMyM71N9pjV+owSSTwxxr2FguNkvc47wBKX2/glG8mXnLd5jbKpLUAq5gPGDnyOa8pNUB/CiA5HYCdi64kN1H1Gmw=
X-Received: by 2002:a63:e709:0:b0:438:98e8:d1c with SMTP id
 b9-20020a63e709000000b0043898e80d1cmr555835pgi.403.1664987930207; Wed, 05 Oct
 2022 09:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <Yz1oTvzDpCkOE+fr@debian>
In-Reply-To: <Yz1oTvzDpCkOE+fr@debian>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Oct 2022 09:38:38 -0700
Message-ID: <CAKwvOdkRQk+x7CP6p_TsZvoM0pnL1mjEBgyKp+NC-K_cVnDUGA@mail.gmail.com>
Subject: Re: build failure of next-20221005 due to a3a956c78efa ("fs/ntfs3:
 Add option "nocase"")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-next@vger.kernel.org
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

On Wed, Oct 5, 2022 at 4:19 AM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> The builds of x86_84 allmodconfig with clang have failed to build
> next-20221005 with the error:
>
> fs/ntfs3/namei.c:445:7: error: variable 'uni1' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>                 if (toupper(c1) != toupper(c2)) {
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/ctype.h:64:20: note: expanded from macro 'toupper'
> #define toupper(c) __toupper(c)
>                    ^
> fs/ntfs3/namei.c:487:12: note: uninitialized use occurs here
>         __putname(uni1);
>                   ^~~~
> ./include/linux/fs.h:2803:65: note: expanded from macro '__putname'
> #define __putname(name)         kmem_cache_free(names_cachep, (void *)(name))
>                                                                        ^~~~
> fs/ntfs3/namei.c:445:3: note: remove the 'if' if its condition is always false
>                 if (toupper(c1) != toupper(c2)) {
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/ntfs3/namei.c:434:7: error: variable 'uni1' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>                 if (!lm--) {
>                     ^~~~~
> fs/ntfs3/namei.c:487:12: note: uninitialized use occurs here
>         __putname(uni1);
>                   ^~~~
> ./include/linux/fs.h:2803:65: note: expanded from macro '__putname'
> #define __putname(name)         kmem_cache_free(names_cachep, (void *)(name))
>                                                                        ^~~~
> fs/ntfs3/namei.c:434:3: note: remove the 'if' if its condition is always false
>                 if (!lm--) {
>                 ^~~~~~~~~~~~
> fs/ntfs3/namei.c:430:22: note: initialize the variable 'uni1' to silence this warning
>         struct cpu_str *uni1, *uni2;
>                             ^
>                              = NULL
> 2 errors generated.
>
> git bisect pointed to a3a956c78efa ("fs/ntfs3: Add option "nocase"").
>
> I will be happy to test any patch or provide any extra log if needed.

Hi Sudip,
Thanks for the report.  Please help review+test:
https://lore.kernel.org/llvm/20221004232359.285685-1-nathan@kernel.org/.

For future reports, please take the time to review:
1. Our issue tracker. Nathan had a bug filed about this yesterday.
https://github.com/ClangBuiltLinux/linux/issues/1729
2. The mailing list archives on lore: https://lore.kernel.org/llvm/ If
you search for -Wsometimes-uninitialized you'll see Nathan's
report/patch as well as reports from KernelCI.

I'll take more reports over no reports, but if we already have an open
report, please take the time to participate in the existing threads
rather than create new ones.  That way, if an issue needs a discussion
to resolve, it happens in one thread and not across multiple.
-- 
Thanks,
~Nick Desaulniers
