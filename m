Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEEE711D02
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 03:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjEZBqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 21:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240667AbjEZBpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 21:45:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A29189;
        Thu, 25 May 2023 18:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C97A64C19;
        Fri, 26 May 2023 01:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29D0C433D2;
        Fri, 26 May 2023 01:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685065549;
        bh=SfywDgpNkN5IEaAQx3kJcORg1Vipa1edhuqGcW7elzE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WLhGv7yxDbYxWFFp4yUNFtJ7lMvzXYowTM7++JqmBgWi6k6MZ8o2RddeyGaWkZz7d
         jNOtyilWYfmLRYTecUy1F2axnIjal4XuAdfRBTzELPvpsc1E07fi82tXUx01NZ6YF/
         pIe9DZsMgZcLjVxioA2pLcQhRSZW1DwFtMGvPH3R4P6M+ph90LNa4dkmTfU4weVm09
         iLSgD6SS8cW1WH8RI3ch+usacYFeq7QkW7gksGjUCTwvHyn6sI54sm+NlTBsXB2g/V
         /DNsdogy2Zt6JkJXUX1rvWvSfNEqW5LjSzHWA2J+99Q0dNDFl+FeJ1yzCxgfjs9PP9
         I04F810tRKK8A==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2af2db78b38so2061311fa.3;
        Thu, 25 May 2023 18:45:49 -0700 (PDT)
X-Gm-Message-State: AC+VfDzgkqOGKRDxyHJOvVe4tvEieYojR+TLnWlt602p69G5ofkoszsk
        Au+YW3q19vc57lUnHbOEAf+b4NwTO5p3ddSpNUg=
X-Google-Smtp-Source: ACHHUZ7iExw/Wlf5nZx6NtGxubOcs37XcqxfbWbLz0xDm8IbHfNSgsR88uvVOSYAlpl07Ex0nPRU4Ntj63oxlWa5HDc=
X-Received: by 2002:ac2:5471:0:b0:4f2:7b65:baf1 with SMTP id
 e17-20020ac25471000000b004f27b65baf1mr25328lfn.23.1685065547892; Thu, 25 May
 2023 18:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230517131820.936553-1-arnd@kernel.org> <ZG2bfsr+LwrxqsUX@bombadil.infradead.org>
 <a3d01d39-3d45-4fdc-8f73-b6c33bcae24b@app.fastmail.com> <ZG27pExhUqFpGexM@bombadil.infradead.org>
In-Reply-To: <ZG27pExhUqFpGexM@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 25 May 2023 18:45:35 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4ZksuhhXqDNrb4fPqQFVgW+cfpNLGHOWoLoYWjCKZGpA@mail.gmail.com>
Message-ID: <CAPhsuW4ZksuhhXqDNrb4fPqQFVgW+cfpNLGHOWoLoYWjCKZGpA@mail.gmail.com>
Subject: Re: [PATCH] kallsyms: remove unused arch_get_kallsym() helper
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, linux-modules@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Alan Maguire

On Wed, May 24, 2023 at 12:24=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> On Wed, May 24, 2023 at 08:25:13AM +0200, Arnd Bergmann wrote:
> > On Wed, May 24, 2023, at 07:07, Luis Chamberlain wrote:
> > > On Wed, May 17, 2023 at 03:18:07PM +0200, Arnd Bergmann wrote:
> > >> From: Arnd Bergmann <arnd@arndb.de>
> > >>
> > >> The arch_get_kallsym() function was introduced so that x86 could ove=
rride
> > >> it, but that override was removed in bf904d2762ee ("x86/pti/64: Remo=
ve
> > >> the SYSCALL64 entry trampoline"), so now this does nothing except ca=
using
> > >> a warning about a missing prototype:
> > >>
> > >> kernel/kallsyms.c:662:12: error: no previous prototype for 'arch_get=
_kallsym' [-Werror=3Dmissing-prototypes]
> > >>   662 | int __weak arch_get_kallsym(unsigned int symnum, unsigned lo=
ng *value,
> > >>
> > >> Restore the old behavior before d83212d5dd67 ("kallsyms, x86: Export
> > >> addresses of PTI entry trampolines") to simplify the code and avoid
> > >> the warning.
> > >>
> > >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Shouldn't this go through x86 as this sort of fixesss commit
> > > bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")?
> >
> > That works for me as well, as long as someone picks it up. It's
> > not really x86 any more though since that commit is five years
> > old and removed the last reference from the x86 code.
>
> Fair enough.
>
> > I sent it to you since you are the one that merged most of
> > the kallsyms patches through the module tree, but I guess
> > you are not actually maintaining that file (not blaming you,
> > I'd also try to stay away from kallsyms).
> >
> > I can resend it to Andrew for the -mm tree.
>
> OK, I just took the patch in, it's on the train, better get on before
> it gets lost.

This change broke compilation of BPF selftests in modules-next
branch:

progs/bpf_iter_ksym.c:62:13: error: no member named 'pos_arch_end' in
'struct kallsym_iter'
        if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
             ~~~~  ^
progs/bpf_iter_ksym.c:62:35: error: no member named 'pos_arch_end' in
'struct kallsym_iter'
        if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
                                   ~~~~  ^

I haven't looked into the proper fix for it yet.

Thanks,
Song
