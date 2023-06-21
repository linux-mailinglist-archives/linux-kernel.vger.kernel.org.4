Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A4A73875A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjFUOln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjFUOlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:41:31 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808A31FC8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:41:09 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-76d846a4b85so2150029241.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687358468; x=1689950468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+4gmWWpq7Djs7g2QPfPh4TUyGT/CtkLCGk8CipnQN0=;
        b=PDUMfmFQYAMB9vCmB0Ttn4YY59y81gbLnOttuI3SXA3hvMlhcNUlMys3cJxMKNvkIn
         R0jyaB2SqQFBVjvACAj8dvUUMmZAXHpF9aJeD3ojF92pNf7oBSdvyYk5tq6g1Ux86zkQ
         9JWneBdpO5hhTq0dvZYdUDMbAF/aQ5QQHliarM5V6a25fv31RWp3+Ess0ufl6nRRaXtz
         tfJI3RMDuC6LBt/zQD0lsJHRJMesm4CTp3QJKF/vGKt5rDjl5Ei1Q5UpHghp/VSkf887
         UwOvoyATy6XdSDzN1sUR6KGdyX9fN1kCKfS5NZWY6dZIJlPAuRCjGk20P4/h42gXLiPJ
         4xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687358468; x=1689950468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+4gmWWpq7Djs7g2QPfPh4TUyGT/CtkLCGk8CipnQN0=;
        b=NZJVCk1h5N45DU6KGroYXJb0VSRuXPCs8GJdf1r1lsSZ6aBAmG/nS55bURo2TTLXX3
         4Bw7SglKnD+/61B1sjKhN/Fjfb2ONrVFuITPdtN/ww8lWeNGUXDNLCsTveShSPBbYUgs
         /gJlSngOU5zhjVi2REHuvRawUz9897UGmuHIRMG62za1xT8uGttRvn0Z0ph1zd6pcuhc
         EYaZQXpU7YrZBc1EFA66ZjcMPQqrsA4J9LNycyrMy4/YCOI8IIk5VbSQUu8cgIpoqKoz
         OSu+NvYXADWEVBd+jMiFgIOZZd2siofVWt3ePIFF3YDsn7rzZZuZAgJ6Run3VWv+csng
         G8wQ==
X-Gm-Message-State: AC+VfDyg6yAorTN9hvQLDd4W4rgDOwD2lqcpZMuY2EMuw8HZe2b0Vsy3
        grBdi8mQ69YoaX3vm/8IQKN0jDeoreRIwDOTRwjmRQ==
X-Google-Smtp-Source: ACHHUZ4dq1LdhGzp3OOX38Raaet+ZVvDOyLhKykwG3qnsrV/Eq5wqqTteVExZp7zyq0CSly4JMNNtgMuIM2LuwsGjYs=
X-Received: by 2002:a67:f99a:0:b0:440:92ac:a909 with SMTP id
 b26-20020a67f99a000000b0044092aca909mr6641454vsq.28.1687358468495; Wed, 21
 Jun 2023 07:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuifLivwhCh33kedtpU=6zUpTQ_uSkESyzdRKYp8WbTFQ@mail.gmail.com>
 <ZJLzsWsIPD57pDgc@FVFF77S0Q05N> <CA+G9fYvwriD8X+kmDx35PavSv-youSUmYTuYTfQ4oBWnZzVRUQ@mail.gmail.com>
 <CANk7y0imD3tK1Jox_V_f1vfzFi2tPhUzGOA_mLLkYy-VDHdncg@mail.gmail.com>
In-Reply-To: <CANk7y0imD3tK1Jox_V_f1vfzFi2tPhUzGOA_mLLkYy-VDHdncg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 21 Jun 2023 20:10:57 +0530
Message-ID: <CA+G9fYuK4FWaLizcuVyW3ApR6fcgjMccYp3YxdAm61BOedXxzQ@mail.gmail.com>
Subject: Re: next: Rpi4: Unexpected kernel BRK exception at EL1
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <song@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 at 19:46, Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> Hi,
>
> On Wed, Jun 21, 2023 at 3:39=E2=80=AFPM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > On Wed, 21 Jun 2023 at 18:27, Mark Rutland <mark.rutland@arm.com> wrote=
:
> > >
> > > On Wed, Jun 21, 2023 at 06:06:51PM +0530, Naresh Kamboju wrote:
> > > > Following boot warnings and crashes noticed on arm64 Rpi4 device ru=
nning
> > > > Linux next-20230621 kernel.
> > > >
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > >
> > > > boot log:
> > > >
> > > > [   22.331748] Kernel text patching generated an invalid instructio=
n
> > > > at 0xffff8000835d6580!
> > > > [   22.340579] Unexpected kernel BRK exception at EL1
> > > > [   22.346141] Internal error: BRK handler: 00000000f2000100 [#1] P=
REEMPT SMP
> > >
> > > This indicates execution of AARCH64_BREAK_FAULT.
> >
> > I see kernel panic with kselftest merge configs on Juno-r2 and Rpi4.
>
> Is there a way to reproduce this setup on Qemu?

Not reproducible on Qemu-arm64.
I see only on arm64 devices Juno-r2 and Rpi4.

>
> I am able to build the linux-next kernel with the config given below.
> But the bug doesn't reproduce in Qemu with debian rootfs.
>
> I guess I would need the Rootfs that is being used here to reproduce it.
> Can you point me to the rootfs for this?

Here is the link for rootfs - OE one.
https://storage.tuxsuite.com/public/linaro/lkft/oebuilds/2RVA7dHPf73agY0gDJ=
D6XEdBQBI/images/juno/

>
> Thanks,
> Puranjay
>
> > metadata:
> >   git_ref: master
> >   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> >   git_sha: 15e71592dbae49a674429c618a10401d7f992ac3
> >   git_describe: next-20230621
> >   kernel_version: 6.4.0-rc7
> >   kernel-config:
> >     https://storage.tuxsuite.com/public/linaro/lkft/builds/2RVAA4lj35ia=
3YDkqaoV6ztyqdW/config
> >   artifact-location:
> >     https://storage.tuxsuite.com/public/linaro/lkft/builds/2RVAA4lj35ia=
3YDkqaoV6ztyqdW/
> >   toolchain: gcc-11
> >   build_name: gcc-11-lkftconfig-kselftest
> >
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org

- Naresh
