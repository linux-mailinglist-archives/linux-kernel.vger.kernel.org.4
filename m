Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B2466E0D1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjAQOea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjAQOeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:34:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BFF3C2A3;
        Tue, 17 Jan 2023 06:34:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86ECFB81112;
        Tue, 17 Jan 2023 14:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392C2C433F1;
        Tue, 17 Jan 2023 14:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673966047;
        bh=hCDrOLdb+rE+r1D0INnM9e1g81qWnJBWV0FvTqnhAwg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QzGqPT+rzcyjOvQ/ULH/oxFdXIWTZqhtB09ZocEk3ckyorQlCrTISaYcXWDRG7Qh7
         xLWqndt8dCq17m8/VptTrczyG49mI4xhJYLv2aJcwvPV4VJ5zuVPPbXjEO1k6hiu8N
         008jv8DpWzOlag9PCNmdgK0Wi0kDF3IkjJ7yU0KfBO0Elhuxsn1OnAMQGoNmFIan2I
         T741wDav/mjzyrRbySRPkawOIohAGuupo9ETgjnpVyQA1mMX9L7UYC9n90xX42uE5I
         SkyNXKiAV+Ef2M9Q8fL57EcuspbIf23Tt19MZUx9EuXmpzBnTGz6tbBLeOwH/9dvAS
         2kt5NqOjEZ3dw==
Received: by mail-oi1-f177.google.com with SMTP id v17so4690869oie.5;
        Tue, 17 Jan 2023 06:34:07 -0800 (PST)
X-Gm-Message-State: AFqh2kqyKFsVA9iAMUESDZq6348VkhpxKw9sOGMlRQTZNLrDxQJ5xtsz
        4tLmPdozAZFouS885FTc4DcsJNnhCFLsy5xzPbc=
X-Google-Smtp-Source: AMrXdXvKpdkbCB3bpzsdTLuWvqZ2gIxDzMmIuomb5V0v5dAbgpI1gRO+NYUn/pv/rKsKdnZ09uVOa4/nFAgaee4VFOw=
X-Received: by 2002:aca:acd5:0:b0:364:5d10:7202 with SMTP id
 v204-20020acaacd5000000b003645d107202mr143711oie.194.1673966046471; Tue, 17
 Jan 2023 06:34:06 -0800 (PST)
MIME-Version: 1.0
References: <20230117-kernel-kheaders-cpio-v1-1-058d3e1c8621@weissschuh.net>
 <Y8ZgTgtA9oH8W17Y@buildd.core.avm.de> <20230117131919.3ywkaptian2y242d@t-8ch.de>
In-Reply-To: <20230117131919.3ywkaptian2y242d@t-8ch.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 17 Jan 2023 23:33:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQLBZOOjN7humBHKO9R3C5UGKfuSEX5dSEajt8KiSrAvQ@mail.gmail.com>
Message-ID: <CAK7LNAQLBZOOjN7humBHKO9R3C5UGKfuSEX5dSEajt8KiSrAvQ@mail.gmail.com>
Subject: Re: [PATCH] kheaders: explicitly validate existence of cpio command
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kbuild@vger.kernel.org,
        Amy Parker <apark0006@student.cerritos.edu>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:19 PM Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> wr=
ote:
>
> On Tue, Jan 17, 2023 at 09:46:02AM +0100, Nicolas Schier wrote:
> > On Tue, Jan 17, 2023 at 05:30:43AM +0000, Thomas Wei=C3=9Fschuh wrote:
> > > If the cpio command is not available the error emitted by
> > > gen_kheaders.so is not clear as all output of the call to cpio is
> > > discarded:
> > >
> > > GNU make 4.4:
> > >
> > >   GEN     kernel/kheaders_data.tar.xz
> > > find: 'standard output': Broken pipe
> > > find: write error
> > > make[2]: *** [kernel/Makefile:157: kernel/kheaders_data.tar.xz] Error=
 127
> > > make[1]: *** [scripts/Makefile.build:504: kernel] Error 2
> > >
> > > GNU make < 4.4:
> > >
> > >   GEN     kernel/kheaders_data.tar.xz
> > > make[2]: *** [kernel/Makefile:157: kernel/kheaders_data.tar.xz] Error=
 127
> > > make[2]: *** Waiting for unfinished jobs....
> > > make[1]: *** [scripts/Makefile.build:504: kernel] Error 2
> > >
> > > Add an explicit check that will trigger a clear message about the iss=
ue:
> > >
> > >   CHK     kernel/kheaders_data.tar.xz
> > > ./kernel/gen_kheaders.sh: line 17: type: cpio: not found
> >
> > Thanks for the patch!  What would you think about an even more verbose
> > message?  Perhaps something like:
> >
> >     echo >&2 ' *** "cpio" is required for "CONFIG_IKHEADERS". >&2
>
> Wouldn't hurt obviously.
> The other scripts used by the kernel don't seem to try to provide this
> kind of explicit message either, though.
> Having a line number, some sort of "not found" and the name of the
> command are enough, in my opinion.



Agree.  I am fine with this patch.


Just a side note.


'type' is defined in posix [1], so this code is portable.

Kbuild often uses "command -v" to check the existence of a command
because it is also posix compliant [2].


I just wondered why we did not use 'type' before...

'type' is more efficient because it is shell-builtin
(at least for dash and bash) but 'command' is not.



[1]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/type.html

[2]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.htm=
l







>
> > Reviewed-by: Nicolas Schier <n.schier@avm.de>
>
> Thanks!
>
> Thomas



--=20
Best Regards
Masahiro Yamada
