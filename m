Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B104C72FF27
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244771AbjFNMyC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Jun 2023 08:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbjFNMyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:54:00 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7091BF7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:53:58 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-53482b44007so3517397a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686747238; x=1689339238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNLStUqoRTHYUkoWELHANj0sv/i/i34CB8/DedqsBvY=;
        b=LQimxyD+G1fu8WSlHi5HQn15VoFw8sMTOwDAwXkaC0B/BiAIWQa1CgoxZCrV82QrY1
         9B11+VFC/pqvuHYi9T4MiEW0fjYsnEehEjwSkoPOk0IKlwckAu0i8slxYVlncgIAz+L4
         KVoruWY7LEiJXyUIWkbpk4rXCZgD5A3AStakX87K5/5kyQtOr55XBWtxce9RuZmWh5gW
         07J7CuifeKjjqsN5uG4sg8K3fvPaWLyTgbfzzE9sxHZAfvfU8jeNe6MB74UwhY247v/h
         j/Iwfyd8Cy2onXD8eFCgRXisBQgm7fA+xWN7HuUEmtE0ceA+qWBQlgQgE9yYCWQWC5dN
         Xuuw==
X-Gm-Message-State: AC+VfDwstpmNefYT5Hu/qL3OB8JmOIZiioA3K9r5MT3ePxqrVbja8F/c
        MYIh4/I+X1FhnYMc4EwhNK8nSjoa0JI0P6WyvtU=
X-Google-Smtp-Source: ACHHUZ5eh85pqktayCn/s1rK/8wKCn5ax5dPWAS4Xegp8r13CWBXCddQjW8HFyK0x5dGj01YKDE0cRD6fQNeqFkUIzI=
X-Received: by 2002:a17:90a:19c4:b0:25b:8bed:d13b with SMTP id
 4-20020a17090a19c400b0025b8bedd13bmr1050056pjj.39.1686747237691; Wed, 14 Jun
 2023 05:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <87sfb1oz13.fsf@meer.lwn.net>
 <8f27ad5f-9a9c-3db0-a934-88e1810974f3@digikod.net> <CACT4oue7DgUf+65yat+6t9VrSji1N0njxunObHbRzfjMCAPmYQ@mail.gmail.com>
In-Reply-To: <CACT4oue7DgUf+65yat+6t9VrSji1N0njxunObHbRzfjMCAPmYQ@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 14 Jun 2023 21:53:46 +0900
Message-ID: <CAMZ6RqJ66wxVAcveVunQ3W6sYihQM43Hi44D7TAee_nUPk+ZXA@mail.gmail.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
To:     =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org,
        danny@kdrag0n.dev, masahiroy@kernel.org, jgg@nvidia.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        linux@rasmusvillemoes.dk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed. 14 Jun. 2023 at 20:40, Íñigo Huguet <ihuguet@redhat.com> wrote:
> On Fri, Jun 9, 2023 at 3:23 PM Mickaël Salaün <mic@digikod.net> wrote:
> > On 09/06/2023 09:50, Jonathan Corbet wrote:
> > > Íñigo Huguet <ihuguet@redhat.com> writes:
> > >
> > >> EditorConfig is a specification to define the most basic code formatting
> > >> stuff, and it's supported by many editors and IDEs, either directly or
> > >> via plugins, including VSCode/VSCodium, Vim, emacs and more.
> > >>
> > >> It allows to define formatting style related to indentation, charset,
> > >> end of lines and trailing whitespaces. It also allows to apply different
> > >> formats for different files based on wildcards, so for example it is
> > >> possible to apply different configs to *.{c,h}, *.py and *.rs.
> > >>
> > >> In linux project, defining a .editorconfig might help to those people
> > >> that work on different projects with different indentation styles, so
> > >> they cannot define a global style. Now they will directly see the
> > >> correct indentation on every fresh clone of the project.
> > >>
> > >> See https://editorconfig.org
> > >>
> > >> Co-developed-by: Danny Lin <danny@kdrag0n.dev>
> > >> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> > >> Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>
> > >
> > > So I must confess to still being really nervous about installing a file
> > > that will silently reconfigure the editors of everybody working on the
> > > kernel source; I wish there were a straightforward way to do this as an
> > > opt-in thing.  We're talking about creating a flag-day behavioral change
> > > for, potentially, thousands of kernel developers.  Something tells me
> > > that we might just hear from a few of them.
> > >
> > > I wonder if we should, instead, ship a file like this as something like
> > > Documentation/process/editorconfig, then provide a "make editorconfig"
> > > command that installs it in the top-level directory for those who want
> > > it?
> > >
> > > Or perhaps I'm worrying too much?
> >
> > This is a legitimate concern. :)
> >
> > A safe approach would be to rename the ".editorconfig" file to something
> > like ".editorconfig.default" and create ".editorconfig" symlinks in all
> > (parent) directories where enforcing this rules don't change anything
> > because the children files are already correctly formatted. Again, a
> > script (provided in another patch) to check and potentially update such
> > links would be useful.
> >
>
> I can't think of an easy way to create that script. Formatting is done
> by each editor using the rules from .editorconfig, but I didn't find
> any available good script or tool to check if a file complies or not.
> Creating that script is not trivial.
>
> I neither think it is good to enable it for some folders and not for
> others: developers will be surprised of having assistance in some
> files and not in others, I would be bothered with such inconsistency.
>
> Right now I see 2 possibilities:
> - Provide an .editorconfig.default so those that want to use it, can
> do it. But I wouldn't mess with cherry-picking directories that
> already complies and those that don't, just the developer chooses to
> use it or not, and that's all.
> - Provide an .editorconfig directly, and those that don't want to use
> it, either disable it in their editors or manually delete the file.
>
> Please tell me what approach you prefer.

Personally, I vote for the latter. My honest opinion is that we are
putting too much consideration into the risk of rejections.

Íñigo previously stated that editors such as Kate can not opt out. I
think that the reason is simply that no one has complained about it so
far. I did some research on the internet with the keyword "kate
disable editorconfig", and nothing  relevant appeared. A deeper
research made me found this:

  KatePart has support for reading configurations from
  .editorconfig files, when the editorconfig library is
  installed. KatePart automatically searches for a .editorconfig
  whenever you open a file. It gives priority to .kateconfig
  files, though.

source: https://docs.kde.org/stable5/en/kate/katepart/config-variables.html

So it appears that for Kate, installing the editorconfig lib is a
prerequisite. I think it falls in the opt-in category.

Is there really an editor with default opt-in and no options to
opt-out? I doubt...

I really think we should have the .editorconfig at the root and for
the rare edge cases where the user really wants to opt-out, I
sincerely believe that there will be solutions. I have seen many
projects using it and I do not recall push backs or complaints.
