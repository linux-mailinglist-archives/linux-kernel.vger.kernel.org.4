Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6A26BFF36
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 04:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCSDVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 23:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCSDVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 23:21:47 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF2B1A940
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 20:21:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eg48so34485624edb.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 20:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1679196104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBz9k12p8pVuGJXShL857aw4AxHCc154WrN7zFH8CzM=;
        b=agzmHgPX3Jla+ZbFSASkvD63a6/R4emYExbM2TQMovUsYEj5AOQjKlEqw48xWR2Z98
         T280prz6pqyalQPVcWlUNUyPIzM0P4lpdTJKbHued2ki58pHM7QpW3Eum1fHlNHLq0gz
         SxlFPXVtdcNq6Y2sXdQwef/Hgqu8xWYW0t0vR8AMTiyhZunilv+HjqncW0Zerl1Ag+oK
         /rGb8TCzN9Z6+YevZq8S4/bIiUzVp2NkEzS3joADMcfd1eib17BF4FosfLDSUbLcdF+B
         ZuJRca3KIKDkNHfrJ1ICWzzQsoo6VWnARZgKxW5UhjVuLXiGvlPrltrGl6t5dNGxZeC6
         CViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679196104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBz9k12p8pVuGJXShL857aw4AxHCc154WrN7zFH8CzM=;
        b=KCaJPjS5hlhRTXHqD59FA9DOR52IGUwCNwSgnev8nIHPOhfMbGi7oiiUW9EOXIgKpN
         WveWKmkaxHpgSZGgV1BVhlqVJgCJ8wRPCR1V6M995jDRMPDBRFGidjPx1qNvSJNHDAA+
         arglu1+EcR4PGpkK7XHJ76b9U2e5H7EOI78KpbY9tAeW+TJB9k8MRrEX4TzYzfMD6DRQ
         y+ySnk8ylRr8tcp7aD60eWHnw32IFCKYQd+FNjCYtgpSipHnj292qSbD5e6WFC3M9PeJ
         371Ir58E8RQELh9/fojNSRPq0D8kstOEIu7SN6ZegNal7ZGfQSQ8MDMqIkl3ag0rmzEU
         7yRA==
X-Gm-Message-State: AO0yUKVl0kq1Lln8Cc1RV5GD/Hr6mH767e5b49tlt7vhC33ppZqcrPsq
        ghOEe7OLaRKrKETgvBaDlBbhU8Q/D3ViWfSyjvUBcA==
X-Google-Smtp-Source: AK7set8u6RB2cfGId0yTlYiaqUpdz3tV6bZKuDYEk9G+jqwLG9c3uB1Qn0K3A6SJwVkVDirnh5x7WoBKbdILO3NzSZI=
X-Received: by 2002:a50:d749:0:b0:4fb:9735:f917 with SMTP id
 i9-20020a50d749000000b004fb9735f917mr4309053edj.8.1679196103892; Sat, 18 Mar
 2023 20:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNATXqPy6F+gB8-1Zqh8hooXh3U_5+3xeMFZDZwYsUi=aeg@mail.gmail.com>
 <20230312200731.599706-1-masahiroy@kernel.org> <20230319011217.147183-1-steev@kali.org>
 <CAK7LNATrzAWiu36=-JXXjSt48O12OAQG4ZAtLABd_PyiE2f_VQ@mail.gmail.com>
In-Reply-To: <CAK7LNATrzAWiu36=-JXXjSt48O12OAQG4ZAtLABd_PyiE2f_VQ@mail.gmail.com>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Sat, 18 Mar 2023 22:21:32 -0500
Message-ID: <CAKXuJqjWORL0GmyOg9_NFUCjUH3Jd7yrNbTYpnQiTk7AptMZMw@mail.gmail.com>
Subject: Re: [PATCH 0/6] kbuild: fix some packaging issues, and use
 git-archive for source package
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Sat, Mar 18, 2023 at 9:19=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Sun, Mar 19, 2023 at 10:12=E2=80=AFAM Steev Klimaszewski <steev@kali.o=
rg> wrote:
> >
> > Hi Masahiro,
> >
> > On Sun, Mar 12, 2023 at 1:07=E2=80=AFPM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > This series fixes some bugs, then switch to 'git archive'
> > > for source package creation as suggested by Linus.
> >
> > I apologize if this is a stupid question, but it's not immediately appa=
rent to
> > me...
> >
> > Previously, I was overriding the deb file output name by the setting of
> > LOCALVERSION_AUTO; but with this series applied, that seems to be ignor=
ed?
> >
> > Now if I pass LOCALVERSION=3D"" I end up with e.g. linux-image-6.3.0-rc=
2_6.3.0-rc2-00575-g46c71cad996d-100_arm64.deb
> > whereas previously, I would end up with linux-image-6.3.0-rc2_6.3.0-rc2=
-100_arm64.deb
> >
> > How would I restore the old naming behaviour?
> >
> > -- steev
>
> The same string "6.3.0-rc2" is repeated in the file name.
> The first one is what Debian calls the ABI version, and the
> second one is the version of the package.
> They are usually different on real Debian kernels.
>
> LOCALVERSION affects the former, and KDEB_PKGVERSION
> the second.
>
>
> My recommendation is "just let it be"
> because "linux-upstream_6.3.0-rc2.orig.tar.gz"
> you would generate is not the real 6.3.0-rc2.
>
>
> If you want to restore what you previously did,
>
>  make deb-pkg KDEB_PKGVERSION=3D6.3.0-rc2-100
>
> will create such a file name.
>
My apologies, my text editor seemed to swallow up half of my previous
email as what I was trying to say wasn't all in there...
What I meant to say is that, prior to this patchset, if
LOCALVERSION_AUTO=3Dy we would end up with

linux-image-6.3.0-rc2_6.3.0-rc2-00575-g46c71cad996d-100_arm64.deb

where
LOCALVERSION_AUTO=3D"00575-g46c71cad996d"
NUMBEROFBUILDS=3D"100" (i'm not sure where this number was stored previousl=
y)

Assuming the above 2 are what the current settings are...

And if you turned LOCALVERSION_AUTO off, and had changes on top of the
git repo, you would end up with

linux-image-6.3.0-rc2_6.3.0-rc2+-100_arm64.deb

Then if you would pass LOCALVERSION=3D"", on top of LOCALVERSION_AUTO
being unset, you would end up with

linux-image-6.3.0-rc2_6.3.0-rc2-100_arm64.deb

Now with your patchset applied, with LOCALVERSION_AUTO being unset,
you end up with

linux-image-6.3.0-rc2_6.3.0-rc2-00575-g46c71cad996d-100_arm64.deb

Which means that LOCALVERSION_AUTO goes away?  I'm not sure why the
package version overrides what I'm trying to set in the first place in
the kernel config?

Your workaround is mostly fine, but that "-100" on the end means I
have to now personally track how many builds I've done?

>
>
> --
> Best Regards
> Masahiro Yamada
