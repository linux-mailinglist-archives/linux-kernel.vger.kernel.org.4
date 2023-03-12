Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5077D6B6BB1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 22:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjCLVLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 17:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCLVL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 17:11:27 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E245923A42
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 14:11:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o12so41144803edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 14:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1678655484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hil+65mTmc3AMUxw5xsQhzsU9a1qRH1xSyrgVLUlwPg=;
        b=Iul58Gg6AFjhXB28onIUV6+BhaUNvY5osJG0aAOvsD4ewgu5tI8prqouao+qF7phjA
         CIlxQwWiHhwFYKYzgD6dOLbWmTXMw9olJyELFNTATT7YWGGifMpa6hW36OV53+Is0wIU
         Q9DA8r/HoxNKyfBO7RBoRNUE3297pJWCD41I2SQRlDZY7CSYHLDauiXix+j8JfxDdpDd
         LJUgiMBeeRDGRShbOVCIXzYex9sDZwdBOAF2qBgpxi+Jt8CFz6q4OwbJ2BBNDnoH3mtt
         XMhxqoeCuCI5MMqlkA+/CyX47dVL4OTw/65T7mGYz05UxyNx0c8tYOTltEHnOrKrwp4R
         E5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678655484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hil+65mTmc3AMUxw5xsQhzsU9a1qRH1xSyrgVLUlwPg=;
        b=6ATMyrSU6hfowy/TpdUCr818ofcDRT+CJo4wMlVv+yGMlFjjX/ZG5hEjs7SuNHGwaa
         G1LClyguqkSH81H+iaTX4EcrR5X4pON1mxvJSUczse+lMlTTTpJn59KNbnZsOFMFA5FG
         Ju+cQU2JAdDxHNkElHIbjYf/oXtVSI7Qtu8EBE0HGoQujeCB4Uf4vcah+A1YjSNWDIjV
         RBfskYFHXv5lxgFnOgwjpVx6oP8BrglY8hBfNC8g6kFpVk/0JUYtBUtbAEgVrTcPbW4A
         9kHpETFihUIm2Fk9hdhoCJ5z5NyvMsnmu/o2eL/t0ioltq2h3W7J/GsF7nuq9v4gUjj8
         fC5Q==
X-Gm-Message-State: AO0yUKVE6nlhHHuq6Ck9F9DMjTgEmTLCw2XQcCHaYKzABC6PQA+iN9cv
        L+lhoiSqkFRzg70hnKKYZkHcB1eQVK2JxGv53jhnvg==
X-Google-Smtp-Source: AK7set/w8y0erJsgMhQLRjt/vwMLCi5VNIOvczMJfE/dOPuQHDrYrNarInk51vZANGevW35ePpBXWfNfcYodIKSZlKY=
X-Received: by 2002:a17:906:174a:b0:8ae:b14b:4b9e with SMTP id
 d10-20020a170906174a00b008aeb14b4b9emr15045042eje.9.1678655484388; Sun, 12
 Mar 2023 14:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230312201712.367545-1-joe@isovalent.com> <875yb5wwed.fsf@meer.lwn.net>
In-Reply-To: <875yb5wwed.fsf@meer.lwn.net>
From:   Joe Stringer <joe@isovalent.com>
Date:   Sun, 12 Mar 2023 14:11:13 -0700
Message-ID: <CADa=RyzQmTEFnpKehGoKihmz+EniibjWQ0P12XMwqgqQ8UcO-w@mail.gmail.com>
Subject: Re: [PATCH linux-doc] docs/doc-guide: Clarify how to write tables
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 1:24=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> Joe Stringer <joe@isovalent.com> writes:
>
> Thanks for working to improve the docs...I have a couple of questions,
> though.
>
> > Prior to this commit, the kernel docs writing guide spent over a page
> > describing exactly how *not* to write tables into the kernel docs,
> > without providing a example about the desired format.
> >
> > This patch provides a positive example first in the guide so that it's
> > harder to miss, then leaves the existing less desirable approach below
> > for contributors to follow if they have some stronger justification for
> > why to use that approach.
>
> There's all kinds of things you can do in RST, but we've deliberately
> not tried to create a new RST guide in the kernel docs.  I'm not sure
> that tables merit an exception to that?  If people really need help,
> perhaps a link to (say)
>
>   https://docutils.sourceforge.io/docs/user/rst/quickref.html#tables
>
> would suffice?

Thanks for the review! A link with a clear recommendation would make
sense to me.

> > Signed-off-by: Joe Stringer <joe@isovalent.com>
> > ---
> >  Documentation/doc-guide/sphinx.rst | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-gui=
de/sphinx.rst
> > index 23edb427e76f..9c2210b6ea3f 100644
> > --- a/Documentation/doc-guide/sphinx.rst
> > +++ b/Documentation/doc-guide/sphinx.rst
> > @@ -313,9 +313,25 @@ the documentation build system will automatically =
turn a reference to
> >  function name exists.  If you see ``c:func:`` use in a kernel document=
,
> >  please feel free to remove it.
> >
> > +Tables
> > +------
> > +
> > +Tables should be written in cell grid form unless there is a strong
> > +justification for using an alternate format:
> > +
> > +.. code-block:: rst
> > +
> > +   +------------------------+------------+----------+----------+
> > +   | Header row, column 1   | Header 2   | Header 3 | Header 4 |
> > +   | (header rows optional) |            |          |          |
> > +   +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +   | body row 1, column 1   | column 2   | column 3 | column 4 |
> > +   +------------------------+------------+----------+----------+
> > +   | body row 2             | ...        | ...      |          |
> > +   +------------------------+------------+----------+----------+
>
> ...and if they do merit an exception, why would we prefer the full grid
> format (which is harder to create and maintain) than the simple table
> format?  Most of the time, the simple format can do what's needed, and I
> don't think it's less readable.

I'm not opinionated about grid format, I just picked one. But this is
interesting - If simple table is the preferred format, then that
sounds like the sort of detail that this docs page should communicate.
For example:

ReStructured text provides several formats to define tables. Kernel
style for tables is to use:
- Simple table format wherever possible
- Grid format if the table requires row spans
- Other formats if there is a specific justification (see list tables
for an example below).

See the Quick reStructured Text cheat for examples:
https://docutils.sourceforge.io/docs/user/rst/quickref.html#tables
