Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7926095F4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 22:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiJWUDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 16:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJWUDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 16:03:35 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DAF6566D;
        Sun, 23 Oct 2022 13:03:34 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 29NK3J4k022655;
        Mon, 24 Oct 2022 05:03:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 29NK3J4k022655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1666555400;
        bh=M3ZxNAiBcIlFjCWFQwnzBKBdtwWozx3fquXatda9+ts=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0I0T256zWWV6zA2tgsOvWc6x3ZTfoc8ge+22LIO39gjCgS/km2BA1jIrEhtn+r9GO
         4UIsFHoVZxN9MqakWGBwi4/fzQo0jv0KHjD62NVW/XEGkWVKyERtJZZgppSN3cOOo9
         YQA7byhXHWmkTLFDgcesP6xuJWoAdf+96F4nVvHQlwvBh+TulXgOjYa+eWq8vkbapv
         wdU2blx2tKlpUWnJDLaTyx/+pHvNGX9PkRtMkP7BvYaRJ8REDgJyHE55hy8Mo1iZYf
         Jl4b9ElC3Qq53iVZDAXnjnjBHNDSGNVojDatXwf3QRn/8DN6KCrcQlXDjWhvz/lbr/
         0/hqY1a95lJCg==
X-Nifty-SrcIP: [209.85.167.182]
Received: by mail-oi1-f182.google.com with SMTP id y67so9026768oiy.1;
        Sun, 23 Oct 2022 13:03:19 -0700 (PDT)
X-Gm-Message-State: ACrzQf2Nq7sFo/dXBb7tNAQ+Sh+1PMRhek/XISXMbBMztBfhUvKyY1Gs
        prc0XRw58ukZH5C0fULUOx7G4XklFJfbskGVXfs=
X-Google-Smtp-Source: AMsMyM4LQgSLuv2/57yI1HYPJBmkgqay9G85DXbIyd+aQEe7R0SyF7lqhnkbn17ye/olVzl4x7cdZReGeE+6xhU6J6A=
X-Received: by 2002:aca:bbd4:0:b0:353:f167:6fd3 with SMTP id
 l203-20020acabbd4000000b00353f1676fd3mr15510922oif.287.1666555398536; Sun, 23
 Oct 2022 13:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221020103823.31001-1-ashimida@linux.alibaba.com>
 <Y1FVphEyu23U0jho@debian.me> <8b2864bd-30b1-254f-ebd6-79967249da9b@linux.alibaba.com>
 <Y1JRhiAQ1bV/Dh7h@buildd.core.avm.de>
In-Reply-To: <Y1JRhiAQ1bV/Dh7h@buildd.core.avm.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 24 Oct 2022 05:02:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNATo3+CTpRzKQEtdOxVSU4qvj2+-BOEQr8z8_Yj7eW9p4Q@mail.gmail.com>
Message-ID: <CAK7LNATo3+CTpRzKQEtdOxVSU4qvj2+-BOEQr8z8_Yj7eW9p4Q@mail.gmail.com>
Subject: Re: [RFC] Documentation: kbuild: Add description of git for
 reproducible builds
To:     Nicolas Schier <n.schier@avm.de>
Cc:     Dan Li <ashimida@linux.alibaba.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, michal.lkml@markovi.net,
        ndesaulniers@google.com, corbet@lwn.net,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
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

On Fri, Oct 21, 2022 at 5:00 PM Nicolas Schier <n.schier@avm.de> wrote:
>
> On Thu, Oct 20, 2022 at 06:48:20PM -0700, Dan Li wrote:
> >
> >
> > On 10/20/22 07:05, Bagas Sanjaya wrote:
> > > On Thu, Oct 20, 2022 at 03:38:23AM -0700, Dan Li wrote:
> > > > diff --git a/Documentation/kbuild/reproducible-builds.rst b/Documentation/kbuild/reproducible-builds.rst
> > > > index 071f0151a7a4..13397f38c358 100644
> > > > --- a/Documentation/kbuild/reproducible-builds.rst
> > > > +++ b/Documentation/kbuild/reproducible-builds.rst
> > > > @@ -119,6 +119,16 @@ To avoid this, you can make the vDSO different for different
> > > >   kernel versions by including an arbitrary string of "salt" in it.
> > > >   This is specified by the Kconfig symbol ``CONFIG_BUILD_SALT``.
> > > > +Git
> > > > +-----------------------
> > > > +
> > > > +Uncommitted changes or different commit ids in git can also lead
> > > > +to different compilation results. For example, after executing
> > > > +``git reset HEAD^``, even if the code is the same, the
> > > > +``include/config/kernel.release`` generated during compilation
> > > > +will be different, which will eventually lead to binary differences.
> > > > +See ``scripts/setlocalversion`` for details.
> > > > +
> > >
> > > Briefly read the script, I don't see what the correlation between git
> > > reset with LOCALVERSION thing is. Also, does the exact state of git
> > > repository required for reproducible builds?
> > >
> >
> > Hi Bagas,
> >
> > The Makefile has the following code:
> > filechk_kernel.release = \
> >         echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
> >
> > The output of setlocalversion affects kernel.release, while the output
> > of setlocalversion is related to the state of git when the git repository
> > exists (see function scm_version).
> >
> > So changes in git state will result in changes to kernel.release, and
> > this information will be included in the final output vmlinux/modules
> > and in turn affect reproducible builds.
> >
> > For example:
> > $ git log
> > commit 4cd155a93eec......
> > $ make ...
> > $ cat include/config/kernel.release
> > 6.0.0-rc4-00025-g4cd155a93eec
> >
> > $ git reset HEAD^
> > $ git log
> > commit 7b4d266b0c41......
> > $ make ...
> > $ cat include/config/kernel.release
> > 6.0.0-rc4-00024-g7b4d266b0c41-dirty
> >
> >
> > AFAICT, in the presence of a git repository, we can compile a reproducible
> > build kernel in any git state, but we need to ensure that the git state is
> > always the same between compilations (or the same from the perspective of
> > the scm_version function).
>
> yes, that definitely true.  Absence or presence of git tags can change
> the output of setlocalversion even more drastically.
>
> I think it is sensible to add a stanza about git in
> Documentation/kbuild/reproducible-builds.rst.




Make sense.
Applied to linux-kbuild.
Thanks.



-- 
Best Regards
Masahiro Yamada
