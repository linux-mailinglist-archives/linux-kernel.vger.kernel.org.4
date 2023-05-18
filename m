Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C2B707C68
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjERI7W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 May 2023 04:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjERI7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:59:18 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B811FE3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:59:12 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ae507af2e5so7314955ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684400352; x=1686992352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1v0qOA/M0aDdZzJFdBTNmWpUEfkhwiWQC7dh6d94jA=;
        b=jrCbBnTQAkq831dpt4D7F//khQLgpydlIu+f98JqJ/yz6D8sI6cCLTY9ikCJEtt42W
         bq/ojJ+ZxEhArjj+/3JPdNsBKCcnxXM3jiZJe005Z9E5fs/kOwwk7XjJQd9O3U6hzYU9
         QIVAS3A1Wn0U91KNPht4ceGSnRz2BF7plbM+eboGRgmkzdHPUhDz0WHnthVC/EpOctbl
         CjhhX/vPxnhgcEmbokR2/AUhrfs3N/oasCmITX6Sf43e6++G/gizSZ8/6FeoF9x/gCvY
         DNaiNP6FyB0B8KZNNoma0jzTFwhqMIDujvV2PMwcURy2sZY2yEMVf1+70Zsoje4jx+VQ
         +URA==
X-Gm-Message-State: AC+VfDyytHg3jkqWwum6L3MQc/SapfmRx+0+W9yEURIca39NmUDHEDEX
        uogU0jm+SghIH5zewIXd7H/Et0Owoiqnfml0bM8=
X-Google-Smtp-Source: ACHHUZ5P6G1gy98xyVi+zXSmuHX7PZ/rG3vhLuwQM8JBe+5SbfCm69FasSRrm0j2ytqebL6T9ZjOkoaVojzkvMZED/U=
X-Received: by 2002:a17:902:e889:b0:1ac:6fc3:6beb with SMTP id
 w9-20020a170902e88900b001ac6fc36bebmr1769508plg.9.1684400351844; Thu, 18 May
 2023 01:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230414101052.11012-1-ihuguet@redhat.com> <20230516130437.14753-1-mailhol.vincent@wanadoo.fr>
 <CACT4ouc=VfUtZCGr0+y2sGDyWAnagT-zTMv3C2fkgfYXTJtRhA@mail.gmail.com>
In-Reply-To: <CACT4ouc=VfUtZCGr0+y2sGDyWAnagT-zTMv3C2fkgfYXTJtRhA@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 18 May 2023 17:59:00 +0900
Message-ID: <CAMZ6RqKs0wBPYE4h3HsxDS0F2ZSvDDb3BrOuwtuBERtEGHy6dg@mail.gmail.com>
Subject: Re: [PATCH v3] Add .editorconfig file for basic formatting
To:     =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Cc:     corbet@lwn.net, danny@kdrag0n.dev, jgg@nvidia.com, joe@perches.com,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        masahiroy@kernel.org, mic@digikod.net, ojeda@kernel.org,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu. 18 May 2023 at 16:53, Íñigo Huguet <ihuguet@redhat.com> wrote:
> Hi Vincent,
>
> On Tue, May 16, 2023 at 3:05 PM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
> >
> > Hi Íñigo,
> >
> > Thank you very much for this patch. I would really love to see .editorconfig
> > added to the Linux tree.
> >
> > I need to work on different project and so, since last year, I applied the v2 of
> > this series to my local tree and it works great.
> >
> > On Fri, Apr 14, 2023 at 12:11 PM Íñigo Huguet <ihuguet@redhat.com> wrote:
> > > EditorConfig is a specification to define the most basic code formatting
> > > stuff, and it's supported by many editors and IDEs, either directly or
> > > via plugins, including VSCode/VSCodium, Vim, emacs and more.
> > >
> > > It allows to define formatting style related to indentation, charset,
> > > end of lines and trailing whitespaces. It also allows to apply different
> > > formats for different files based on wildcards, so for example it is
> > > possible to apply different configs to *.{c,h}, *.py and *.rs.
> > >
> > > In linux project, defining a .editorconfig might help to those people
> > > that work on different projects with different indentation styles, so
> > > they cannot define a global style. Now they will directly see the
> > > correct indentation on every fresh clone of the project.
> > >
> > > See https://editorconfig.org
> > >
> > > Link: https://lore.kernel.org/lkml/20200703073143.423557-1-danny@kdrag0n.dev/
> > > Link: https://lore.kernel.org/lkml/20230404075540.14422-1-ihuguet@redhat.com/
> > > Co-developed-by: Danny Lin <danny@kdrag0n.dev>
> > > Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> > > Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>
> > > ---
> > > v2:
> > >  - added special rule for patch files so it doesn't remove
> > >    trailing whitespaces, making them unusable.
> > > v3:
> > >  - moved all rules from [*] section to all the individual
> > >    sections so they doesn't affect to unexpected files.
> >
> > I understand from from the past discussions that trim_trailing_whitespace or the
> > default indentation can not be apply broadly to all files. But what about those
> > three parameters?
> >
> >   [*]
> >   charset = utf-8
> >   end_of_line = lf
> >   insert_final_newline = true
> >
> > Those looks safe to me. Are there files for which we do not want utf-8 or for
> > which we do not what a final empty newline?
>
> Yes, I think that they are probably safe to use, but Miguel thought it
> was better to be more cautious, and I agree. We can expand adding more
> file formats when we detect those that are not covered.

I think you are referring to this message from Miguel:

  While UTF-8 and LF are probably OK for all files, I am not 100% sure about:

  +insert_final_newline = true
  +indent_style = tab
  +indent_size = 8

Link: https://lore.kernel.org/lkml/CANiq72k2rrByxzj1c4azAVJq-V7BqQcmBwtm3XM9T8r3r3-ysQ@mail.gmail.com/

So it seems that we all agree on the UTF-8 and LF. Or did I miss
another message?

Regardless, with or without my nitpick addressed, it looks good to me:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Tested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

> With v3, the most used files are covered, and since there are
> thousands of files with many different purposes, it's very difficult
> to answer if there are files where we don't want these settings.
>
> For example, if there are a few files that, who knows why, need a
> different encoding, we can silently corrupt the file and cause a bad
> debugging time for a developer. For the end of line and final newline,
> we already saw that there are files where they are undesired, like
> patch files. There might be more.
>
> >
> > >  - added some extensions and files from a patch from Danny
> > >    Lin that didn't get to be merged:
> > >    https://lore.kernel.org/lkml/20200703073143.423557-1-danny@kdrag0n.dev/
> > >    However, the following file types hasn't been added
> > >    because they don't have a clear common style:
> > >    rst,pl,cocci,tc,bconf,svg,xsl,manual pages
> > > ---
> > >  .editorconfig                          | 30 ++++++++++++++++++++++++++
> > >  .gitignore                             |  1 +
> > >  Documentation/process/4.Coding.rst     |  4 ++++
> > >  Documentation/process/coding-style.rst |  4 ++++
> > >  4 files changed, 39 insertions(+)
> > >  create mode 100644 .editorconfig
> > >
> > > diff --git a/.editorconfig b/.editorconfig
> > > new file mode 100644
> > > index 000000000000..dce20d45c246
> > > --- /dev/null
> > > +++ b/.editorconfig
> > > @@ -0,0 +1,30 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +root = true
> > > +
> > > +# 8 width tabs
> > > +[{*.{c,h},Kconfig,Makefile,Makefile.*,*.mk}]
> > > +charset = utf-8
> > > +end_of_line = lf
> > > +trim_trailing_whitespace = true
> > > +insert_final_newline = true
> > > +indent_style = tab
> > > +indent_size = 8
> > > +
> > > +# 4 spaces
> > > +[{*.{json,pm,py,rs},tools/perf/scripts/*/bin/*}]
> > > +charset = utf-8
> > > +end_of_line = lf
> > > +trim_trailing_whitespace = true
> > > +insert_final_newline = true
> > > +indent_style = space
> > > +indent_size = 4
> > > +
> > > +# 2 spaces
> > > +[{*.{rb,yaml},.clang-format}]
> > > +charset = utf-8
> > > +end_of_line = lf
> > > +trim_trailing_whitespace = true
> > > +insert_final_newline = true
> > > +indent_style = space
> > > +indent_size = 2
> > > diff --git a/.gitignore b/.gitignore
> > > index 70ec6037fa7a..e4b3fe1d029b 100644
> > > --- a/.gitignore
> > > +++ b/.gitignore
> > > @@ -100,6 +100,7 @@ modules.order
> > >  #
> > >  !.clang-format
> > >  !.cocciconfig
> > > +!.editorconfig
> > >  !.get_maintainer.ignore
> > >  !.gitattributes
> > >  !.gitignore
> > > diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4.Coding.rst
> > > index 1f0d81f44e14..c2046dec0c2f 100644
> > > --- a/Documentation/process/4.Coding.rst
> > > +++ b/Documentation/process/4.Coding.rst
> > > @@ -66,6 +66,10 @@ for aligning variables/macros, for reflowing text and other similar tasks.
> > >  See the file :ref:`Documentation/process/clang-format.rst <clangformat>`
> > >  for more details.
> > >
> > > +Some basic editor settings, such as indentation and line endings, will be
> > > +set automatically if you are using an editor that is compatible with
> > > +EditorConfig. See the official EditorConfig website for more information:
> > > +https://editorconfig.org/
> > >
> > >  Abstraction layers
> > >  ******************
> > > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > > index 007e49ef6cec..ec96462fa8be 100644
> > > --- a/Documentation/process/coding-style.rst
> > > +++ b/Documentation/process/coding-style.rst
> > > @@ -735,6 +735,10 @@ for aligning variables/macros, for reflowing text and other similar tasks.
> > >  See the file :ref:`Documentation/process/clang-format.rst <clangformat>`
> > >  for more details.
> > >
> > > +Some basic editor settings, such as indentation and line endings, will be
> > > +set automatically if you are using an editor that is compatible with
> > > +EditorConfig. See the official EditorConfig website for more information:
> > > +https://editorconfig.org/
> > >
> > >  10) Kconfig configuration files
> > >  -------------------------------
> > > --
