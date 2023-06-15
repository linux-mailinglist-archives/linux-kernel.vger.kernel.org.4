Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8CE731B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344971AbjFOOR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345037AbjFOORX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:17:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFCB295C;
        Thu, 15 Jun 2023 07:16:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBE2861331;
        Thu, 15 Jun 2023 14:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BED7C433CD;
        Thu, 15 Jun 2023 14:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686838606;
        bh=PFDmrzDD6hW6d9/ycxNmaGcyY+9j9u01uaPXaL8OkVM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tc6phaFgm98WKkPAcZGtf82eHgHEezgIh+Bb/0KMmid+TwRvE+izdQWfLrLUL2rJf
         Sg6ccjc9Zny45QkzYnJa+3JM9T+aRDeBUVH1ycG8cCg6rRQP6Cy3SrjbdgnNTLFj5P
         A91SG1tEr3qKG/Axi/1jT+1qd2f8msWAstVNsc3UnbZQrROeJpdYAweRN25SZEi7rQ
         o3YIQ4a9WFD/i7uCNAuDly+NOkatdXMXDwoj5zGYATF1Mo5Cdx7JrtOramPda76XWH
         T0kTcjwbJYsEKdGS4ohvEyPE9OIGM3QgYPviqekFUb8DMDidSH88rcpuRh8dQ+VCnA
         0kRyzpcXnOxVA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1a670ac3650so4602027fac.1;
        Thu, 15 Jun 2023 07:16:46 -0700 (PDT)
X-Gm-Message-State: AC+VfDycNY+A0us2743T5sgshRDK7olPaFQmDWvAefJp3krIL2tuzyPG
        KINoaU2Q99MDkjTZezGPXqZTgDTre4AQa9x1QkE=
X-Google-Smtp-Source: ACHHUZ4DJuQfsF4V/KNERlQUFedO7ljUUzobdijvDSYWjjbe/wYboiEK7+Q7k1h38h8fJrtWTHKr3YiY4DBCvYBiZQU=
X-Received: by 2002:a05:6870:a415:b0:1a6:a5a3:bac0 with SMTP id
 m21-20020a056870a41500b001a6a5a3bac0mr8423379oal.57.1686838605490; Thu, 15
 Jun 2023 07:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230610161711.1094231-1-masahiroy@kernel.org> <ZIokN9rbm8+Xo0jU@bergen.fjasle.eu>
In-Reply-To: <ZIokN9rbm8+Xo0jU@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 15 Jun 2023 23:16:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQqvLBVYwu=jo+2ngQf5PM=imHOSCi3AUdOJ-8HJG-UYQ@mail.gmail.com>
Message-ID: <CAK7LNAQqvLBVYwu=jo+2ngQf5PM=imHOSCi3AUdOJ-8HJG-UYQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: revive "Entering directory" for Make >= 4.4.1
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Thu, Jun 15, 2023 at 5:34=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu> =
wrote:
>
> On Sun 11 Jun 2023 01:17:11 +0900, Masahiro Yamada wrote:
> > With commit 9da0763bdd82 ("kbuild: Use relative path when building in
> > a subdir of the source tree"), compiler messages in out-of-tree builds
> > include relative paths, which are relative to the build directory, not
> > the directory where make was started.
> >
> > To help IDEs/editors find the source files, Kbuild lets GNU Make print
> > "Entering directory ..." when it changes the working directory. It has
> > been working fine for a long time, but David reported it is broken with
> > GNU Make 4.4.1.
> >
> > The behavior was changed by GNU Make commit 8f9e7722ff0f ("[SV 63537]
> > Fix setting -w in makefiles"). Previously, setting --no-print-directory
> > to MAKEFLAGS only affected child makes, but it is now interpreted in
> > the current make as soon as it is set.
> >
> > [test code]
> >
> >   $ cat /tmp/Makefile
> >   MAKEFLAGS +=3D --no-print-directory
> >   all: ; :
> >
> > [before 8f9e7722ff0f]
> >
> >   $ make -C /tmp
> >   make: Entering directory '/tmp'
> >   :
> >   make: Leaving directory '/tmp'
> >
> > [after 8f9e7722ff0f]
> >
> >   $ make -C /tmp
> >   :
> >
> > This commit restores the previous behavior for GNU Make >=3D 4.4.1.
> >
> > Reported-by: David Howells <dhowells@redhat.com>
> > Closes: https://lore.kernel.org/all/2427604.1686237298@warthog.procyon.=
org.uk/
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---


Sorry, I retract this patch.
It does not work.

--=20
Best Regards
Masahiro Yamada
