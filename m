Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC80671565
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjARHt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjARHr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:47:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531AD45236;
        Tue, 17 Jan 2023 23:16:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDD95616C6;
        Wed, 18 Jan 2023 07:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414EFC433D2;
        Wed, 18 Jan 2023 07:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674026215;
        bh=fMdiTni2gMvcsKxUoV8Xq96M3e8d2FKt/Z2+Ho2gGYQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GHARI1gdwPtbgorOO7XpOh6wzyb0pqbkfxntZx/n8ts+D93dWmq9wAl7q7m1UTimX
         nbnClMbTijjFUwfoGaZ7x+zin/HON9yHZ2RY7dheYfvb5gEqWTrJp6jltkdaSYI9og
         e1bKLIZr/R1HcwzBLxSuwUmKMPiKGVDMfAB16J1HhJQWXmyOUXyBD/+I/KQy+J6Ht0
         ccJwdGaoNMbsupEi89SFHdda/5GIhq0KUiHh+7QEZVIyKV4c6LT8QNn4K71LxgCzcG
         pRqq/xKxlZjMCWP6WII2akAQewH13/EwZ2bXdqheimpY2Mc6Zi0FVFvH2dU6aYhOns
         YMcxRmk4HLH2w==
Received: by mail-ot1-f41.google.com with SMTP id v15-20020a9d69cf000000b006709b5a534aso19181668oto.11;
        Tue, 17 Jan 2023 23:16:55 -0800 (PST)
X-Gm-Message-State: AFqh2krEEkbuQJI7dPo5qhMTtc1nltB2oV4Cs5V84dGumfV2lw28OLW3
        +u2pzDu79e6ElqBcdEEtFgPuqvMTWMC2pCqseYE=
X-Google-Smtp-Source: AMrXdXsnxQyWQhxAAGTn9D2e1gF/sug0YZkUn/lyrkp9S3QjlOzNh4GiblyYPA4sCDeSMt4uD5K1LmzCpvf5PNKbbhU=
X-Received: by 2002:a9d:1984:0:b0:684:c0c2:59c6 with SMTP id
 k4-20020a9d1984000000b00684c0c259c6mr319508otk.343.1674026214533; Tue, 17 Jan
 2023 23:16:54 -0800 (PST)
MIME-Version: 1.0
References: <20230117-kernel-kheaders-cpio-v1-1-058d3e1c8621@weissschuh.net>
 <Y8ZgTgtA9oH8W17Y@buildd.core.avm.de> <20230117131919.3ywkaptian2y242d@t-8ch.de>
In-Reply-To: <20230117131919.3ywkaptian2y242d@t-8ch.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 18 Jan 2023 16:16:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNASJU6Ad0HN7SoP-KHCxskYodzHg2AFMkyeTSKnzB=vBzw@mail.gmail.com>
Message-ID: <CAK7LNASJU6Ad0HN7SoP-KHCxskYodzHg2AFMkyeTSKnzB=vBzw@mail.gmail.com>
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
>
> > Reviewed-by: Nicolas Schier <n.schier@avm.de>
>
> Thanks!
>
> Thomas


Applied to linux-kbuild. Thanks.


--=20
Best Regards
Masahiro Yamada
