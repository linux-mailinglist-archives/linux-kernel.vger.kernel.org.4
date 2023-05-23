Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4551570DBEC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbjEWMFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjEWMFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:05:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6276C109;
        Tue, 23 May 2023 05:05:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F366960AEF;
        Tue, 23 May 2023 12:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B64EC4339C;
        Tue, 23 May 2023 12:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684843510;
        bh=dsOiwV6x1SGNVtWfAZzUDcd5fDjTLtENphFCbr4tOS4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jWPc0Aey9dcnCoKQs/yKfUrMXXoc6Q9exGMqBgIJDdy+lYGQAyEzAvrmLf/3+p7ua
         1EFhv5wk6V4zsPwy0YW+5ZLjGi8HuZ8xDW6756t7ElM7cQojVzdQi88/NeuaYAX3yC
         PwSVuliYuR6N1VNoiwxu/8JkDA/6utDm9LFEwRtfPBxi8vfEFjSDE1MrLQi/BU6Wks
         vPN9UX4OgnWHIgSiGLN/LmtYLeHqId2qTJK0xvM/cp0sh/irq81+/a137PDCJ+D8UP
         FLxFxkKtYssceLydc2OtATkoLHwcHnQqrLwe6ptnl2rbrLhc0gfQU9380kcTVATMc2
         mU2abW18G9icQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-54f5fdaa693so2925334eaf.1;
        Tue, 23 May 2023 05:05:10 -0700 (PDT)
X-Gm-Message-State: AC+VfDzecRF0ToZUGhoG22fnBNFnK7uVfAslDYD7fK25YBQJHvpr3ToB
        EQpJENLE7nob/Qj+A4iiUU7VEy94A00Gcp9Ve08=
X-Google-Smtp-Source: ACHHUZ7bz9X6pK+NyLABRLZbOrxOrZWV4oE0v4NY4yqZkxGl1ZIu9QmFdWMLC8S6u7ZvsrXPAU6/ZFBlyNjkesP4PMY=
X-Received: by 2002:aca:d806:0:b0:38e:e5b5:493e with SMTP id
 p6-20020acad806000000b0038ee5b5493emr8537830oig.11.1684843509560; Tue, 23 May
 2023 05:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-11-masahiroy@kernel.org>
 <CAKwvOdmA1q1ojTWq79VK4HJqKfMHA=8VB9q61xJoKyYsegv3tg@mail.gmail.com>
 <CAK7LNAQ3KO1BY5Nq6uhHQGm_eOVNvk206A-s5pSguTO3ykLUng@mail.gmail.com> <CAKwvOdmrLTfX4sjgs+6n0SEr6GC-z0v4EQTJ7nCyy5LhvPi91Q@mail.gmail.com>
In-Reply-To: <CAKwvOdmrLTfX4sjgs+6n0SEr6GC-z0v4EQTJ7nCyy5LhvPi91Q@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 23 May 2023 21:04:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNARtMHW5m67PRsaB+St0j9unMj9Fe=ksWTCQwgmSC-u2gw@mail.gmail.com>
Message-ID: <CAK7LNARtMHW5m67PRsaB+St0j9unMj9Fe=ksWTCQwgmSC-u2gw@mail.gmail.com>
Subject: Re: [PATCH v5 10/21] modpost: rename find_elf_symbol() and find_elf_symbol2()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 1:59=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sat, May 20, 2023 at 6:28=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > On Thu, May 18, 2023 at 6:14=E2=80=AFAM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Sun, May 14, 2023 at 8:28=E2=80=AFAM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> > > >
> > > > find_elf_symbol() and find_elf_symbol2() are not good names.
> > > >
> > > > Rename them to find_tosym(), find_fromsym(), respectively.
> > >
> > > The comments maybe could be updated, too. The end of the comment look=
s
> > > wrong for both.
> >
> >
> > What do you mean?
> >
> > Please tell me which part should be changed, and how.
>
> Attached the comment style changes.  I didn't have precise wording in
> mind for the comments; I was suggesting to see if the comments could
> be updated to clarify what the functions are doing.

Ah, I understood what you meant.

I think some parts of the comments are stale.
Anyway, these comment blocks will be removed by a later commit.

https://patchwork.kernel.org/project/linux-kbuild/patch/20230521160426.1881=
124-6-masahiroy@kernel.org/



--=20
Best Regards
Masahiro Yamada
