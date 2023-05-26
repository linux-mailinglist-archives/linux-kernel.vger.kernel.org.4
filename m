Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD9B712ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244085AbjEZVQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbjEZVQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:16:40 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FFABC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:16:39 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-565a6837a0bso18724237b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685135798; x=1687727798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMxB33ZwtJ62Rd3pdsfVx0QDMuGQJeUN8Db0SpoNE7c=;
        b=WO8ETJpr3D8s+L8V7BZGdNHhdBMauE8nCTE+BKsOSVTHrKqsPSboOCcRv4PWnkjmEw
         jK5L1C0daoeXuXDI7ZXrWWRm8Mrf2U0RNr2eT1JIM2bgFi/VV2R8C+nW5XPpKWVKHDdl
         enKGgowQZCPHxHaosuumQ0IPA8EJvaTrHFjahnsa0CCW9I7TpoTIM4IKw4KFBeBzsias
         G2qYE6Otw/RgQ11EASK9n7LTUiUFFtdpXj2NUNRYDBpkZNzKHDCXK+7kmxNeYeLj4FD0
         /ViPAmBwjCpUrhWjNxBlomdfAP3b1tme0MH2qsrVPARPUzEW9+17V3gg92Z58EGEu/Tf
         j8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685135798; x=1687727798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMxB33ZwtJ62Rd3pdsfVx0QDMuGQJeUN8Db0SpoNE7c=;
        b=Gxb1OwxGNMEwzXMzBTGdEcIJtyw3oGFBOhSM/RnwJZxOU3Mza4n0hiCo0tT4D4EXyd
         q/eV/kf2QbaKsMIZrRyHDyzy0oUaliOJvXYTTpifqKtEepJsttCfHFRTU3Ga4rB3l2z0
         BNBTKu8OwH+E/VDRXYFS52TffxBrRLmGQ4SgaofLYQ7zqtDv8QJSDN4HgXvrEo2cQ4vq
         zwOkPvXACEBJh26pT2NGHIyReKsLutVnE5tILn2NVVAcSbQKVuWMb9AaPVC1Pfgn8bYh
         1/lQl+E+yawW6Dpon60ejcAG98kXISsINIHHBhJanEaOpb/KsHBWkmyZIpypE59XtTok
         IiKg==
X-Gm-Message-State: AC+VfDypCw3BYIIyYaZaYL0nf92GzNwUkeK55E2ReOfXz139RR6eN0y4
        g+7u9RrGBHkloFGcynqGCBX+jci5Y8zBnky5qlw=
X-Google-Smtp-Source: ACHHUZ6F3ZaUq0kBCJc2bnmLNDOInVmWlfumg7WpVPyqePHsklyhD8el7XV9QVkbgduMYUBCTMAfBzTmQWkzZMtAVRs=
X-Received: by 2002:a81:8747:0:b0:552:a0fc:6827 with SMTP id
 x68-20020a818747000000b00552a0fc6827mr3311805ywf.52.1685135798208; Fri, 26
 May 2023 14:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230414101052.11012-1-ihuguet@redhat.com> <CANiq72=vTLT1PnbWu4pwNNyMO0S413G3O+_TLcCGLiDGr5fH7Q@mail.gmail.com>
 <CACT4ouf2M1k7SaMgqv1Fj33Wen7UKuUyKp-Y9oer+THiWEebNg@mail.gmail.com>
In-Reply-To: <CACT4ouf2M1k7SaMgqv1Fj33Wen7UKuUyKp-Y9oer+THiWEebNg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 26 May 2023 23:16:26 +0200
Message-ID: <CANiq72njUr2wv7CA7W9ziRUf8mrVQPFEQfS7=it3zTVhJFvf3A@mail.gmail.com>
Subject: Re: [PATCH v3] Add .editorconfig file for basic formatting
To:     =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Cc:     ojeda@kernel.org, masahiroy@kernel.org, jgg@nvidia.com,
        mic@digikod.net, danny@kdrag0n.dev, linux-kernel@vger.kernel.org,
        corbet@lwn.net, joe@perches.com, linux@rasmusvillemoes.dk,
        willy@infradead.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 10:59=E2=80=AFAM =C3=8D=C3=B1igo Huguet <ihuguet@red=
hat.com> wrote:
>
> Originally I sampled manually, but I have crafted a script to collect
> more data. It's not 100% reliable, but good to get an idea. It reads
> the leading whitespaces and if >80% of the lines have one kind of
> indentation, it considers that it's the one used in that file. The
> results, filtered to show only the relevant ones, are pasted at the
> end.

This is useful -- thanks a lot for working on collecting it!

> These are some personal conclusions from the script's results:
> - .py: although the official and most widely used style in the
> community is 4-space indentation, in Linux tree many files use tabs.
> What should we do here? 4-space is the clear standard for python...

Yeah, this is the kind of thing that worries me and why I asked --
what do editors do when they have the config saying it is 4-spaces,
but the file is tabs? Do they adjust, do they convert the entire file,
or do they simply start mixing indentation styles? Does the
`.editorconfig` spec say anything about it? For instance, here is an
issue about this sort of problem:

    https://github.com/editorconfig/editorconfig-vscode/issues/329

If the rule could be applied only to new files, then it would be
fairly easy to decide, given the majority uses 4-spaces and it nicely
aligns with PEP 8, Black, etc. But unless we are quite sure we are not
annoying developers, I would avoid specifying anything in these cases.

In some cases (e.g. few files), you may be able to propose to
normalize the indentation style treewide for that extension.

> - .rb: only one file in the whole tree
> - .pm: only 3 files in the whole tree

I guess you could also ignore extensions without many matches in order
to simplify -- they can always be added later, ideally by their
maintainers.

> - Files with many different indentations, better not to specify them:
> rst, cocci, tc, xsl, manual pages
> - Files that we should specify, tab indented: awk, dts, dtsi, dtso, s, S
> - Files that we might specify, with preference for tab indenting but
> not 100% clear: sh, bash, pl
> - Files in tools/perf/scripts/*/bin/*: there is no clear formatting
> for any file type, only for .py files that are tab-indented. To get
> these results I've run my script from tools/perf/scripts directory.

If all Python tab-indented files are in a given folder, then would it
be possible to provide an `.editorconfig` for that folder, and then
4-spaces for the global one? i.e. splitting the problem across folders
may be a solution (within reason, of course, i.e. as long as we don't
fill the kernel with `.editorconfig` files... :)

> I'm only aware of Clang and Rust formatter configs in Linux tree, and
> I think this complies with them. Do you know about any other?

There is `scripts/checkpatch.pl`, which I guess may be counted as one
since one can fix what it complains about manually (and I think it has
some "fix in place" support too).

There is also `Documentation/devicetree/bindings/.yamllint`.

In addition, some may be using formatters in a default config? e.g.
Black for some of the Python scripts.

Cheers,
Miguel
