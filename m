Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6156A5462
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjB1Iaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjB1Iau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:30:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB4F233E9;
        Tue, 28 Feb 2023 00:30:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15FCDB80DDF;
        Tue, 28 Feb 2023 08:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5A4C4339B;
        Tue, 28 Feb 2023 08:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677573046;
        bh=zfyCcSgjMdF8W+Qi+Rx8oUXMr1yNgfu4iPHvVxSYOB8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LMGsAnQbNrbjVKb8+G+fvfZ4Nx3S39oY87kWEOWgoASqKxZklJySw+eW9+drz71/m
         nHyzIelfs3tpSqZuWrwsRJubwssfX0qjGKJnmNgas7ieS+7VFP6k9mlmd9xi1eeRfX
         P2kCE8SBvTWSghstqqWyM9Gowrll5KV+9R3sc0jtFk8AoWaAQY2HBwgysKtT/uA501
         OCNWtLD2YZndXSAnFQ/imEx8SFRy/BL+nt8Q1nalkbbR9nUt9oTwVnRj3h8iwp6jd/
         ehKNXeHUFBz96U4bAzI/6CPWqiLWqA8R4t9cgqVOS3OQKSP+0aEBLKqvEwS82pJClX
         RoCzQf6G8meQw==
Received: by mail-ot1-f43.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so5131346otv.0;
        Tue, 28 Feb 2023 00:30:46 -0800 (PST)
X-Gm-Message-State: AO0yUKUAermkDJRMBCGsXlcPQV1hW1Lg3+C1vuUD90mz2CGdDeG1LDoG
        jbFP4fG0QThym3SbvC1ELSZZHile3d5KKQcearc=
X-Google-Smtp-Source: AK7set9aGRiK5kBCfmomrGb0lL9fE6jbhl/PxUd9Omi+KWh6wTqYREe8s8vqpNLa4v0A7ZtRnJsCvFM9klVL3SNqFFE=
X-Received: by 2002:a9d:705c:0:b0:688:cfcc:ddad with SMTP id
 x28-20020a9d705c000000b00688cfccddadmr711660otj.1.1677573045838; Tue, 28 Feb
 2023 00:30:45 -0800 (PST)
MIME-Version: 1.0
References: <20230228031317.3415484-1-davidgow@google.com>
In-Reply-To: <20230228031317.3415484-1-davidgow@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 28 Feb 2023 17:30:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNASBznyHmAwSRApOHw_6dyAXFuskmtKav65xFwKZdvNWJw@mail.gmail.com>
Message-ID: <CAK7LNASBznyHmAwSRApOHw_6dyAXFuskmtKav65xFwKZdvNWJw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kbuild: Add note about using (subst m,y)
To:     David Gow <davidgow@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 12:13=E2=80=AFPM David Gow <davidgow@google.com> wr=
ote:
>
> THe kbuild documentation already notes that, where there's an obj-y
> target in a subdirectory, it will be orphaned if the subdirectory uses
> obj-m. Suggest a way of forcing the directory to obj-y when it's based
> on a config option which could be 'm'.
>
> Linus made several suggestions as to how this is usually done here:
> https://lore.kernel.org/linux-kselftest/CAHk-=3DwgK07PQ_DBBbAbSJ41t__6de1=
xZ6q7RRu-JS=3D2SU0wqLQ@mail.gmail.com/
>
> This only documents the first one, which seems most common.
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  Documentation/kbuild/makefiles.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/ma=
kefiles.rst
> index e67eb261c9b0..d9eb24799f52 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -254,6 +254,17 @@ from that directory will be linked into vmlinux. If =
the Makefile in
>  that directory specifies obj-y, those objects will be left orphan.
>  It is very likely a bug of the Makefile or of dependencies in Kconfig.
>
> +This means that, if a directory contains both obj-y and obj-m targets,
> +it should be added with obj-y. If this directory nevertheless should
> +only be built when a config option is enabled (typically to support
> +a module which requires one or two files to nevertheless be built-in),
> +'subst m,y' can be used to ensure obj-y is used.
> +
> +Example::
> +
> +  #drivers/Makefile
> +  obj-$(subst m,y,$(CONFIG_HYPERV)) +=3D hv/
> +


I think many subsystems simply do

obj-y  +=3D hv/


I do not think we need to advertise hyperv's way
since it does not look very pretty.







Mostly, it looks like this:


obj-y  +=3D kunit/

and

obj-$(CONFIG_KUNIT_HOOK)   +=3D hook.o







Bikeshed:

I think Linus' suggestion is OK, but
the BSD style seems less ugly,
of course, that is just a matter of style.


obj-$(CONFIG_HYPERV:m=3Dy)   +=3D kunit/




>  Kbuild also supports dedicated syntax, subdir-y and subdir-m, for
>  descending into subdirectories. It is a good fit when you know they
>  do not contain kernel-space objects at all. A typical usage is to let
> --
> 2.39.2.722.g9855ee24e9-goog
>


--
Best Regards
Masahiro Yamada
