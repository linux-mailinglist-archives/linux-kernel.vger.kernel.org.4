Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D756CA607
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjC0Nfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjC0Nfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:35:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD9D1BC6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:35:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 932C0B81331
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403E2C433D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679924146;
        bh=gzV/IOboiINO+ahaLwg9RG4yRo9jQY8BuzwKNjCQczo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uPTXaKRtpwj5dVUHImxmOc2AwgOEQqRwpi5VXqsY8smX9N4YcCtOopNVqC4+p4+mn
         //xkKTcDesbSgHSD0KS66rgC3W6psDFQPrlVPPjWD03ND3QEhUkUCLipQ8FxiytLY/
         3o/3mv3EX90zKzHJENYob57NkC/X2GSnCkPp5R5O6ys1RdY88YsCEaSGwf4ZEj8aWv
         scVAoSvs1TUePfBlPOa1UEgNXuAcOi0P1U493mNHg2jItBbQCmjIC8J6u5mi6QXeiH
         TfoOo1inBS8OjRiVRyIaiKHpNKGUWErE1B+yNlFUOOLmP6O73IrJ8nztYH8v+DX1E4
         0GwVCFPpaCERw==
Received: by mail-ot1-f50.google.com with SMTP id r17-20020a05683002f100b006a131458abfso1963073ote.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:35:46 -0700 (PDT)
X-Gm-Message-State: AO0yUKUtsLRBEMBQ1tGwm5CiJB4mqomS25lng+szMHoYFQYJzsdevtiH
        11VpHUtkEx9T5krhiGz4v9cEMF/ynCxo95/DFf0=
X-Google-Smtp-Source: AK7set+SOLD7Vu7kzeBp74eXLcPCvfJEIma5UKjMFLxlHmYQpEMS3rpIx8m9bL2CCzoMNJrM7S6qd69AXrl87GsG+FI=
X-Received: by 2002:a9d:6385:0:b0:69f:7470:604f with SMTP id
 w5-20020a9d6385000000b0069f7470604fmr3955827otk.1.1679924145489; Mon, 27 Mar
 2023 06:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230325143122.GA409315@mit.edu> <CAK7LNARndpbtzRAW1kEiqyNBmAxdqJKiTquvY9bW08LYTTMiOg@mail.gmail.com>
 <20230326121118.GB323408@mit.edu>
In-Reply-To: <20230326121118.GB323408@mit.edu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 27 Mar 2023 22:35:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNARcUSsjzi7UV+rHHaQU1X-XJ0jN0sLAw2m=SypTQTCHKA@mail.gmail.com>
Message-ID: <CAK7LNARcUSsjzi7UV+rHHaQU1X-XJ0jN0sLAw2m=SypTQTCHKA@mail.gmail.com>
Subject: Re: Change in kernel debian packages between -rc2 and -rc3
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 9:11=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Sun, Mar 26, 2023 at 12:39:44PM +0900, Masahiro Yamada wrote:
> >
> > I am afraid you are completely misunderstanding the two versions,
> > the ABI version and the package version.
> >
> > They do not need to match. Actually, they do not match.
> >
> > See real Debian (or Ubuntu) systems.
> >
> > `uname -r` returns '5.10.0-21-amd64'.
> > This is what they call the ABI version, and
> > this is contained as a part of the package name,
> > 'linux-image-5.10.0-21-amd64'
>
> That may be a convention that Debian uses, but I'll point out that
> trying to use this as an ABI version when people are using different
> .config's is not going to end well.  That's because many different
> Kernel configurations will end up making incompatible changes to the
> ABI.  and only works if you are ***super*** careful about not making
> any kind of changes (e.g., the number of CPU's, adding or changing
> various cgroup controllers, all of which will make incompatible kernel
> ABI changes.)
>
> This is "Stable ABI nonsense" is well, nonsense.

Well, that is just the _name_.

The actual effect is whether you can install
multiple kernel packages at the same time or not
because the ABI version is a part of the package name.
The ABI is nothing more than that for upstream kernel packages.



>
> > It was _not_ reflected in the package version.
> > This is also correct since the package version
> > is not meant to reflect such user configuration
> > as CONFIG_LOCALVERSION.
>
> Citation, please?  Does the Debian system work in that particular way?


The Debian policy [1] says that the version consists of:

    <upstream_version>-<debian_revision>

For clarification, I omitted <epoch>.


[1] http://www.fifi.org/doc/debian-policy/policy.html/ch-versions.html


See what the Debian source package looks like.

<upstream_version> determines the basename of *.orig.tar.gz.

*.orig.tar.gz is generated by 'git archive'.
Obviously, the output of 'git archive' is the same
as long as you work on the same git commit hash.

Think about doing 'make deb-pkg' multiple times on
commit 463f2e46bf7c.
(for example one for CONFIG_LOCALVERSION=3D"-foo"
the other for CONFIG_LOCALVERSION=3D"-bar")


First run:
linux-upstream_6.3.0-rc3-00043-g463f2e46bf7c.orig.tar.gz  [1]
linux-upstream_6.3.0-rc3-00043-g463f2e46bf7c-1.dsc
linux-upstream_6.3.0-rc3-00043-g463f2e46bf7c-1.debian.tar.xz

Second run:
linux-upstream_6.3.0-rc3-00043-g463f2e46bf7c.orig.tar.gz  [2]
linux-upstream_6.3.0-rc3-00043-g463f2e46bf7c-2.dsc
linux-upstream_6.3.0-rc3-00043-g463f2e46bf7c-2.debian.tar.xz


[1] and [2] are the same
(since it is the output of "git archive 463f2e46bf7c").
Hence, it is shared by multiple packages, no matter how many
you generate from commit 463f2e46bf7c.


You are requiring the file name to contain "-xfstests", "-foo", or "-bar"
depending on the CONFIG options.
There is no room for CONFIG options to affect <upstream_version>.

So, the rule is quite simple.
If the contents are exactly the same, they have the same version.
If they are different, they have different versions.



> In any case, it's an incompatible regression made during rc2 and rc3,
> which I think is at the very least, unfortunate.


Your tool was working on a wrong assumption, which nobody promised.

Kbuild already provides various hooks.
You can use CONFIG options and KERNELRELEASE to override uname,
and use KDEB_PKGVERSION to override the package version.

They are enough to continue your broken workflow.





>
>                                     - Ted
--
Best Regards
Masahiro Yamada
