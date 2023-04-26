Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E3C6EF982
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjDZRhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbjDZRhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:37:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CDFED
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:37:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b4dfead1bso6171113b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682530621; x=1685122621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/Rb0m7CpTZA7EE2udzmj88vBB5OZ6QKrKSNtnC7nH4=;
        b=Weuq5WqHFiUL4RDARreTMvbiUAaMRbPD+EEVph3Zbd3xvax84juabu0KGit5tpKg/j
         dxd8r2cseLt9QJC74CcGwiZKIG0B/nnAOAAnrvX3Az8NXY9KRJLwSyefrmKu/G9+vv6N
         MNATStoNZqzKIqpw+JKCFH/9K0dYNEKKmt1aJKaQvq5H1FY092hfw2xKC8cNhiBRqon3
         GkCztoVMyPtsbP4QdJxEVzwIU9ejwWyyT6nJL1CXSk/Zqhs8DTlu9jwnzQ5OxYV5l08N
         QZwc6QnxXGMCl218E+woajNDcemj1SEgVQYuh76l7yRJOYxKKtIkmvIQYqKj7xbB4EyI
         p2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682530621; x=1685122621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/Rb0m7CpTZA7EE2udzmj88vBB5OZ6QKrKSNtnC7nH4=;
        b=Hc0QHi3Q1Kiurm8Vaa3+rk+PsIAwZawyEakPCOEulg5A+Kxh5aD6c0DeI+rxM3Kehn
         kYfVnzVpREmcCvlhM1yWRKZ/X95DOgQX/3dnZ8lYQ+Vj4GaO2Sl/ErAKw8hUAlaJeJp7
         J0K6zpO8Ff9b9iBugac9/HbnOrNVzeyPxQY2ISw1NDnzkJ2NHQMzLr6A4GLLW8Y6Q1bg
         PB9pNRoK3Nm0+VKGl5m3TOtTZoC1o4orv7r9ZqyNObMR5dHio0Kw6OgCJ7ma0QxyGzCB
         mCjtzROfrAK7CupFTnxKhaOMkPDZ5pB65LVni3mj3hAqYAArDTla2fqAvR/Ldp4qKiU5
         2Z1Q==
X-Gm-Message-State: AAQBX9ckJt7jREgQh+0ELXum4KA5P+vuCbhY5KxYYtdY8gE+NjQ2izr+
        aWlXFxxiLdbhFz7NyWUXPiIR2zxUu8PgazUYKoRNsQ==
X-Google-Smtp-Source: AKy350b3iJLSy/fIKD/j4Htqg1xcBHeNcouKeWnNU/8vNvaqVd7Tc+nYjFxmFYETyIOtBHY3vtqP+FuqvJLFVQR4b/U=
X-Received: by 2002:a05:6a20:6a1b:b0:ef:205f:8184 with SMTP id
 p27-20020a056a206a1b00b000ef205f8184mr28568195pzk.13.1682530621379; Wed, 26
 Apr 2023 10:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230425041838.GA150312@mit.edu> <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
 <CAKwvOdmXgThxzBaaL_Lt+gpc7yT1T-e7YgM8vU=c7sUita6aaw@mail.gmail.com>
In-Reply-To: <CAKwvOdmXgThxzBaaL_Lt+gpc7yT1T-e7YgM8vU=c7sUita6aaw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Apr 2023 10:36:50 -0700
Message-ID: <CAKwvOdmk5emVfUCMna8WoE46Ts6RCn=2O4DTT3Aw-YN9nSFHvw@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 10:34=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Apr 26, 2023 at 10:03=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, Apr 24, 2023 at 9:18=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> w=
rote:
> > >
> > > Please note that after merging the mm and ext4 trees you will need to
> > > apply the patch found here[1].
> > >
> > > [1] https://lore.kernel.org/r/20230419120923.3152939-1-willy@infradea=
d.org
> > >
> > > This is due to a patch in the mm tree, "mm: return an ERR_PTR from
> > > __filemap_get_folio" changing that function to returning an ERR_PTR
> > > instead of returning NULL on an error.
> >
> > Side note, itr would be wonderful if we could mark the places that
> > return an error pointer as returning "nonnull", and catch things like
> > this automatically at build time where people compare an error pointer
> > to NULL.
>
> That's what clang's _Nonnull attribute does (with -Wnullability-extension=
).
> https://godbolt.org/z/6jo1zbMd9

Ah sorry, I _thought_ that's how _Nonnull worked on return types. Let
me dig some more and see how that's supposed to work...

--=20
Thanks,
~Nick Desaulniers
