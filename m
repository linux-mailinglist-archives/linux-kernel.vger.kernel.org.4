Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26CF5FBD18
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 23:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJKVjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 17:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKVjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:39:22 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDAA7F250
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 14:39:21 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 29BLculr020304
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:38:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 29BLculr020304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1665524337;
        bh=6QF2Z+xGT+0UIwMrYon1K2nSWoQjAKCrqu9BXQ1yjQE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p/HK3sAjxHBXYZQkb9tU2rYXQp3XQaiV5Br8vKhS/OSy5aQVU6ihXweLBAzVhUCai
         il63aoeJ9l94+b0p7E2TMExrylgk5OdqCTbbcWfwL0Yygu8JM2ouQ3ypSkO2LVLAXa
         855qI6W1wWwkSAoswvr9jgBpypqRi3btr4rATEZfAQ3cZ6ODWGdmp2X9UiyU0A/4Lv
         vNC1RVVf684QGfuwIiZna0XpXK/LGqageK+PO9AG53POXhYtIT0ieBJDP+67Em9ijL
         6ryyJUzNmblOhep5KtgTnbvF3r+P9FCNdqqGy+cM8IamN5pyl7rbEroWSXbDTwuzxW
         hydPz66es2rlw==
X-Nifty-SrcIP: [209.85.160.45]
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1326637be6eso17469161fac.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 14:38:57 -0700 (PDT)
X-Gm-Message-State: ACrzQf1Ix5YNzxeyQ4c8rAvs8C4Eqgcx81JxkHpThFqMuwRGfbeZmhm7
        ZKyRDW+NzOjipsdD+PlfzvTxvF3t+Pedpj4n7Fo=
X-Google-Smtp-Source: AMsMyM7Z0Beqt9F0KJlic1siwi6JGV1pqmUpr6Tl15m1gksXT1Vh8LdiQC/jmufunGb0eKIrggIS7QUqyHgwrx9hSM4=
X-Received: by 2002:a05:6870:8a09:b0:132:554d:2f3d with SMTP id
 p9-20020a0568708a0900b00132554d2f3dmr729290oaq.194.1665524336217; Tue, 11 Oct
 2022 14:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <a10e25f13205cb96e1ad63f1b1371a76f37af549.1665515051.git.quic_gurus@quicinc.com>
 <CAKwvOdmsjxB_i=9Qy6L+4AH+CwOYa0EsRBPFUTj9vwxJ6vNPSg@mail.gmail.com>
In-Reply-To: <CAKwvOdmsjxB_i=9Qy6L+4AH+CwOYa0EsRBPFUTj9vwxJ6vNPSg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 12 Oct 2022 06:38:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR8RKxe0AizKjDS5NJcDG47LEDQS-qDzWTnEZaxS5r7SA@mail.gmail.com>
Message-ID: <CAK7LNAR8RKxe0AizKjDS5NJcDG47LEDQS-qDzWTnEZaxS5r7SA@mail.gmail.com>
Subject: Re: [PATCH 1/1] scripts/clang-tools: Convert clang-tidy args to list
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        John Moon <quic_johmoo@quicinc.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 5:34 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Oct 11, 2022 at 12:06 PM Guru Das Srinagesh
> <quic_gurus@quicinc.com> wrote:
> >
> > Convert list of clang-tidy arguments to a list for ease of adding to
> > them and extending them as required.
> >
> > Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Thanks for the patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Masahiro, would you please be able to carry this up through the kbuild tree?


Applied to linux-kbuild. Thanks.



> > ---
> >  scripts/clang-tools/run-clang-tools.py | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
> > index bb78c9b..56f2ec8 100755
> > --- a/scripts/clang-tools/run-clang-tools.py
> > +++ b/scripts/clang-tools/run-clang-tools.py
> > @@ -45,13 +45,14 @@ def init(l, a):
> >
> >  def run_analysis(entry):
> >      # Disable all checks, then re-enable the ones we want
> > -    checks = "-checks=-*,"
> > +    checks = []
> > +    checks.append("-checks=-*")
> >      if args.type == "clang-tidy":
> > -        checks += "linuxkernel-*"
> > +        checks.append("linuxkernel-*")
> >      else:
> > -        checks += "clang-analyzer-*"
> > -        checks += ",-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling"
> > -    p = subprocess.run(["clang-tidy", "-p", args.path, checks, entry["file"]],
> > +        checks.append("clang-analyzer-*")
> > +        checks.append("-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling")
> > +    p = subprocess.run(["clang-tidy", "-p", args.path, ",".join(checks), entry["file"]],
> >                         stdout=subprocess.PIPE,
> >                         stderr=subprocess.STDOUT,
> >                         cwd=entry["directory"])
> > --
> > 2.7.4
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
