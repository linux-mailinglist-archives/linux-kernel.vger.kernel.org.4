Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007FA74893E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjGEQ3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjGEQ3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:29:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEEE171B;
        Wed,  5 Jul 2023 09:29:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D22161607;
        Wed,  5 Jul 2023 16:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927E7C433C8;
        Wed,  5 Jul 2023 16:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688574549;
        bh=5YBiOBnq0zAsQvss9m7MJWcWcO0FevQNkDA3keUenzk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ALCFOw9Iivm1aMAHNlKN1FxP5eyEWeFaUbaxjhiCs6Xue9HSKyzU6Mv611fMJHZaq
         hkW9z83xAo8qOtwllrjU/oSOlK3fsCpwyehBtl46HKuADW9DrvNTvHCWL052s/37uA
         Frk7slhvQf5ttlsxrDUvaJcNk9eEGe6PCOnwdujrOYpaNT0gkSsOKpc5CAipyvIHqn
         PwLEmruZHNq0RUVVSZNuI2tolATyzP5TbbmMcReTsd5GQFGTm436LkP8VeusBEwQdM
         wdqhIhRVKpJ6cZWrBfifahUbqHoOHjd0BH2ML/XHTSvx7KN7N95oiN13YyLwtFKJBR
         ILdqfE1eJlMLA==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-56344354e2cso4813758eaf.1;
        Wed, 05 Jul 2023 09:29:09 -0700 (PDT)
X-Gm-Message-State: ABy/qLZMT+qX9B9Z9ABqdm84u9Qr2Kj8m2iKtvNWNXBTR5ZNCKbCMljK
        JQej3qY/wmi3V/zLMzbF8HGxlwNVcz53Vnpq6Pc=
X-Google-Smtp-Source: APBJJlG4uIq9aIpEs6W9Dt7d3Q1LGYwmVfVSyXPogjuyozOWm+vYb36x3kfQSa3sGH/ZAkrWJ0cX5jMPh+wNCrJ1NZ4=
X-Received: by 2002:a05:6871:6a9:b0:1b3:ef56:270b with SMTP id
 l41-20020a05687106a900b001b3ef56270bmr2110602oao.29.1688574548871; Wed, 05
 Jul 2023 09:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
 <CAK7LNAQas0cK7pgi72tYC3yU=ZkQxnr41YYW1mXd-sWiHtG+UA@mail.gmail.com> <20230705153405.GA1382903@mit.edu>
In-Reply-To: <20230705153405.GA1382903@mit.edu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 6 Jul 2023 01:28:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARW_n6kD7zZa0Jry+GCscQpvDGEA=pcHMqEMKQMD6qe4A@mail.gmail.com>
Message-ID: <CAK7LNARW_n6kD7zZa0Jry+GCscQpvDGEA=pcHMqEMKQMD6qe4A@mail.gmail.com>
Subject: Re: Overly aggressive .gitignore file?
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jul 6, 2023 at 12:34=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Wed, Jul 05, 2023 at 10:59:28AM +0900, Masahiro Yamada wrote:
> > Perhaps, a slightly similar case is *.patch.
> > (We do ignore *.patch)
> >
> > People quite often run 'git format-patch'.
> > And, the generated patches have similar prefixes.
> > (0001-, 0002-, 0003-, ..., for good reasons)
> >
> > The autocomplete does not work if 000* files
> > exist from the previous time I ran 'git format-patch'.
> > I repeatedly run 'rm -f 00*' even if 'git status' does not show them.
>
> Autocomplete "works", in so far that if you type 0<TAB>, it will
> autocomplete up to 000 and then ring the terminal bell, at which point
> I'll type say, 1<TAB>, and then if there are previous *.patch files,
> it will ring the terminal bell again, and then if you type <TAB> a
> second time, it will list the possible autocompletes.



Of course, "autocomplete does not work" means
"it does not fill out the whole filename by
pressing the tab key just one time".

I thought it was obvious in the context of this thread.
Anyway, thanks for coming back again to point it out.






>
> I will also say that since of "rm -f <pattern includes a '*'>" is too
> easy to accidentally screwup and delete something I would care about,
> my solution is "git format-patch -o /tmp/p ...", since then I can
> clear out the files by typing "rm -r /tmp/p".
>
> Cheers,
>
>                                         - Ted
>
> P.S.  Also note that "git format-patch" will automatically create
> /tmp/p if it doesn't exist, unlike how b4 works with the -o option.



--=20
Best Regards
Masahiro Yamada
