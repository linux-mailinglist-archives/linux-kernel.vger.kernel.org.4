Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C8874FC92
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjGLBTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGLBTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:19:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA3D127
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 18:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C61F61691
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D452C433D9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689124781;
        bh=OM7jgID5+nDTdQR28+4xIcEawoenyRWnAs3OJMJYetA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KogWyRn2VV5EZhXGlejNpBZVugdnvEr9ROeC4CRSSSEYKuuGFz6Q3eKZBWxlbfC7Q
         xKynDGGP9yuWUJrf5EJunAhtgDUwFyPPJI0nAdhO7RzAXluhsgqEDWZZwSaSob5aOD
         2PVtaK/wBMqAVqtxWitUn4aaCzZ2uf42yDh26ZCgR36pqxPgz6SAvLSVWRgYAHVqui
         8ABLk16iWwNecceSWo9JPrF2a/E3nwbqgO4YV26BoJKh3/JO9hAH3npJFY8lq+QVEL
         wrjdTcdrUtdMKFs7/hZZ7BajJ/L/K+UGu62Rg0SgZ1yhouMfSfHk4TEq9Okc0AWI6J
         824m10wJFUDxA==
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-307d58b3efbso6335589f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 18:19:41 -0700 (PDT)
X-Gm-Message-State: ABy/qLaxd6AIr3Dth1wU+DZxLXeNladOEgZNaEnnMk6xURHeXUipMMXs
        RCyEUiCJBixXt6cr3tIwxL3zy04H74h5TjqPJJY=
X-Google-Smtp-Source: APBJJlFk4AotcRZBsIkX55a+pPm9Vn/TiF+hEpBDZFcOK1865HA0wMQMSVlbpVD9PRtSkP69IMxrcW7aE7Y+qwwEGe0=
X-Received: by 2002:a05:6000:1106:b0:315:a1f9:8667 with SMTP id
 z6-20020a056000110600b00315a1f98667mr4599399wrw.23.1689124779730; Tue, 11 Jul
 2023 18:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <MEYP282MB2597B4BD3CDA1ED340691C9CD931A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
 <CAAhV-H56GhqETf=NAGzHRLk73F+-Kb=j+gzNMshVQijPi-Tc=g@mail.gmail.com> <3310eb5b3c944434b6e3b53750f1801f510811f2.camel@hotmail.com>
In-Reply-To: <3310eb5b3c944434b6e3b53750f1801f510811f2.camel@hotmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 12 Jul 2023 09:19:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4ZE3eXOaMSaCCH6pk40pwYTOs9QasjLbPRtos5V=fM-w@mail.gmail.com>
Message-ID: <CAAhV-H4ZE3eXOaMSaCCH6pk40pwYTOs9QasjLbPRtos5V=fM-w@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
To:     donmor <donmor3000@hotmail.com>
Cc:     "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "kernel@xen0n.name" <kernel@xen0n.name>,
        "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>,
        "zhoubinbin@loongson.cn" <zhoubinbin@loongson.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "tangyouling@loongson.cn" <tangyouling@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:27=E2=80=AFPM =E2=80=8E donmor <donmor3000@hotma=
il.com> wrote:
>
> =E5=9C=A8 2023-07-11=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 22:26 +0800=EF=
=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
>
> ...
> > +       if (IS_ENABLED(CONFIG_CMDLINE_EXTEND)) {
> > > +               strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LI=
NE_SIZE);
> > > +               strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> > > +               strlcat(boot_command_line, init_command_line, COMMAND=
_LINE_SIZE);
> > You can simply the logic:
> >                strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> >                strlcat(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_=
SIZE);
> > And then modify the comments because you are appending built-in parts
> > to bootloader parts.
> >
> I think the command line retrieved from bootloader should be placed after=
 the
> built-in one so that it can override params in the latter.
config CMDLINE_EXTEND
        bool "Use built-in to extend bootloader kernel arguments"

The fdt version also uses this logic, but you are using bootloader
parts to extend built-in parts.

>
> > >         }
> > > +
> > > +       if (IS_ENABLED(CONFIG_CMDLINE_BOOTLOADER) && !boot_command_li=
ne[0])
> > > +               strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LI=
NE_SIZE);
> > This should be removed if you want to keep the exact meaning of
> > CONFIG_CMDLINE_BOOTLOADER.
> >
> > Huacai
> >
> Do you mean 'IS_ENABLED(CONFIG_CMDLINE_BOOTLOADER) && ' is not necessary?=
 And I
> think the rest of this part should be here, because CONFIG_CMDLINE_BOOTLO=
ADER
> won't append anything to boot_command_line unless it is empty, according =
to its
> description.

OK, you are right here.

Huacai
