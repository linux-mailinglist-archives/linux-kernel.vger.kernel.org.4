Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BEB60FD1C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbiJ0Qcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbiJ0Qcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:32:31 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73FC9DF89;
        Thu, 27 Oct 2022 09:32:27 -0700 (PDT)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 29RGW5Bt010706;
        Fri, 28 Oct 2022 01:32:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 29RGW5Bt010706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1666888326;
        bh=52K3j4S01m6w/RfZ2ZmouebwYkbBAw9HS00T9luyzUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NbAQ6FXkO9En0C8Gi1ej9gn1bbEKRjuN0OQjeGqMUuzE5jS3YnzHhYwjEOWhQq3/s
         RmqVCqFFTjGudrH2pQ5zuXFfSv14UPIzRRUKsUc0oBEGGymUH9RPkmwkSspuCBW25I
         Ppvtyeb23nVGhJqIke+KIMGPKX19bvDYrLvPyrJYyqJiLXx9nJCOCEjsrf4ubq+VLJ
         x3VTyjvJ1l5a8cCd5Y7jnPHGbjZdHAXXSxn5TC65QAm5ODb3sZEofiZ/ulw9WRIXsj
         S7QkqPg+cVVx7f+K/fOhJ5936Sz+kHAZLZ//VFcQv3+TA7eugy0eWbq1in57rzd9WU
         D7soZ/NNpmeAQ==
X-Nifty-SrcIP: [209.85.160.44]
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1322d768ba7so2792724fac.5;
        Thu, 27 Oct 2022 09:32:06 -0700 (PDT)
X-Gm-Message-State: ACrzQf0tBy5riaiPOJ6YBDg7wijXoMUD3o7pxueJbOyqd/7aFcsmFLiR
        GDV9Lj0TUuPYe8ccekFN8tF2hrhFc1I1tsLzOMY=
X-Google-Smtp-Source: AMsMyM5HtJWKYTji479rNEYH9axJJybHQHD8bBb7XeWPXWObEmy8J9YLvBHRuppp2rRV0aIxNwePrqHWrwGH8t/5cqE=
X-Received: by 2002:a05:6870:7027:b0:13b:a5b7:165a with SMTP id
 u39-20020a056870702700b0013ba5b7165amr5974579oae.194.1666888325338; Thu, 27
 Oct 2022 09:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221023195257.175946-1-masahiroy@kernel.org> <CAKwvOd=pimEoN_OvyefPiTTsOdzo+Xda1gJrYg8+jAE5GA0rqA@mail.gmail.com>
In-Reply-To: <CAKwvOd=pimEoN_OvyefPiTTsOdzo+Xda1gJrYg8+jAE5GA0rqA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 28 Oct 2022 01:31:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS5nvQDYD8jqazng2_CwuuZMGE2FyLFF73iW1_Vp6DWgw@mail.gmail.com>
Message-ID: <CAK7LNAS5nvQDYD8jqazng2_CwuuZMGE2FyLFF73iW1_Vp6DWgw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix 'Broken pipe' message for AR=gcc-ar
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>, eng.stk@sapo.pt
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 4:15 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Oct 23, 2022 at 12:53 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Since commit 321648455061 ("kbuild: use obj-y instead extra-y for
> > objects placed at the head"), 'make AR=gcc-ar' shows the following
> > message:
> >
> >   /usr/bin/ar terminated with signal 13 [Broken pipe]
>
> Not just AR=gcc-ar, but also AR=llvm-ar:
>
> error: write on a pipe with no reader
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1651
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>



Thank you.

I updated the commit description, and sent v2.

https://lore.kernel.org/linux-kbuild/20221027162839.410720-1-masahiroy@kernel.org/T/#u


> Note that due to
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8017ce50641c303b9b5d96f3c10229ecfd770a70
> we should send a backport to stable like:
> https://github.com/engstk/op8/commit/6f2688e3eb4ec06b276e541640d4f06364b68442


Maybe, we can backport 8017ce50641c30 itself,
but I am not sure if it is cleanly applicable.



-- 
Best Regards
Masahiro Yamada
