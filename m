Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90386736B76
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjFTMBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjFTMBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:01:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02AB1B6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:01:09 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f86e1bdce5so3331376e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687262465; x=1689854465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFWQUb8YUAaWCnl1hQyep9GnOaoIB00JbWZuEOfrn1I=;
        b=ANe57mwHgrzuH3cCHjRIzRBAPUm5J5bTPcEqUYFT3Q6gJHqWjBUV3DvGxCpEsBodda
         2wHTFWlvV1wBHSCb5z+c+Lk0c2TjQchh548KB/0Ayio3nSx0fkiPBByA8bh6v3eBedmu
         FLJdy8x3AeaDbZ2YDMVc/xwKtpErXSQmitVGTMtQdp8os8ffBogcw1w9RrnqcIna4aRP
         7G9i1sv8lO4liOmiimWydz5G+pON4GIwLEC7q5TQfK0YlX63l7LYgLTu2i4JPFFZIYjx
         cHGKvtgDS6oNLJCgyh3MTTTezmEr1InlYb6AvaEDOzR3aHjbARiPtm+yBFnTagPQWTV3
         lClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687262465; x=1689854465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFWQUb8YUAaWCnl1hQyep9GnOaoIB00JbWZuEOfrn1I=;
        b=OZg7KgPs4jlfejPEwDfqk/46CSXMbAaGewf+SnYE3oAMA7lCZIctu8sg9kX9rG4a7p
         4RbHXQ28LzCZKDIMZynZf+pomARkAYeIUOY3HZ0qekBN5cZGjs4lbnM2Ssp62bVwsXQE
         3VnCy9aQjSm6au9U2X/sJPmaDNVwa9rM3DIAexcntHl14NHYsS4zlkFz+aTJkKPp/n62
         I22Gc332SRNLzjjNNxkFKAAeT+360Wu43vyDvcxOoui5Q2dKMsldooIq8j7sewBXh3T4
         SDPw5NEO87/h7hSrVmLZwLWYdoKjbihddJyqzZg8pL1t9q2cn/2ToG99K76zgSseP1bC
         gOsQ==
X-Gm-Message-State: AC+VfDyYil9rKQeUwtHsfvzOEODJSbCr/wchhj4RXvH9YUmT1OduLHuu
        M1s7WiJjUprPtDQkEO+U4QiQoB5SiD08W+BAHcOdEA==
X-Google-Smtp-Source: ACHHUZ6m6qAlPWlbn9FLMThfoWnqCrtX0nqoNL5PEOBMk2hqwmsq1Z24uhQOSAsNLMVTOrUGPwCAcWtO7SkZulDfBYw=
X-Received: by 2002:a05:6512:3290:b0:4f7:5f9e:fc59 with SMTP id
 p16-20020a056512329000b004f75f9efc59mr6842825lfe.39.1687262464918; Tue, 20
 Jun 2023 05:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230619094705.51337-1-alexghiti@rivosinc.com>
 <20230619-kerchief-unmixed-cfdbeb1cf242@wendy> <CAHVXubjV=0HNyc0-UMAQRQfi4ZUnwH8dmghV-BGogZsJiumtZA@mail.gmail.com>
 <20230619-sponge-armful-6beeaf4a8624@spud> <CAHVXubjHpdRpgrywwm1UTxwV99uCYOp9qhKBui9Ghff65yGmsQ@mail.gmail.com>
 <20230620-limes-glaring-4831955f7250@wendy>
In-Reply-To: <20230620-limes-glaring-4831955f7250@wendy>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 20 Jun 2023 14:00:53 +0200
Message-ID: <CAHVXubgaJ7m88_nh-pNrNGPG43P18Qv+6DmGJ6Gcb2DORJxqAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: riscv: Add early boot document
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 12:33=E2=80=AFPM Conor Dooley
<conor.dooley@microchip.com> wrote:
>
> On Tue, Jun 20, 2023 at 11:09:47AM +0200, Alexandre Ghiti wrote:
> > On Mon, Jun 19, 2023 at 6:00=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > > On Mon, Jun 19, 2023 at 04:04:52PM +0200, Alexandre Ghiti wrote:
> > > > On Mon, Jun 19, 2023 at 2:26=E2=80=AFPM Conor Dooley <conor.dooley@=
microchip.com> wrote:
> > > > > On Mon, Jun 19, 2023 at 11:47:04AM +0200, Alexandre Ghiti wrote:
>
> > > > > > +Bootflow
> > > > >
> > > > > "Boot Flow", no?
> > > > > I am not sure that this is the "correct" heading for the content =
it
> > > > > describes, but I have nothing better to offer :/
> > > >
> > > > Yes you're right, what about simply "Kernel Entrance"? Not sure thi=
s
> > > > is easily understandable though.
> > >
> > > "Non-boot Hart Initialisation"?
> >
> > Hmmm not that great either (sorry for being direct here)
>
> lol, no need to apologise.
>
> > > > > > +There exist 2 methods to enter the kernel:
> > > > > > +
> > > > > > +- `RISCV_BOOT_SPINWAIT`: the firmware releases all harts in th=
e kernel, one hart
> > > > > > +  wins a lottery and executes the early boot code while the ot=
her harts are
> > > > > > +  parked waiting for the initialization to finish. This method=
 is now
> > > > >
> > > > > nit: s/now//
> > > >
> > > > Ok
> > > >
> > > > >
> > > > > What do you mean by deprecated? There's no requirement to impleme=
nt the
> > > > > HSM extension, right?
> > > >
> > > > I would say yes, you have to use a recent version of openSBI that
> > > > supports the HSM extension. @Atish Kumar Patra WDYT?
> > >
> > > Uh, you don't need to use OpenSBI in the first place, let alone use a
> > > recent version of it, right? What am I missing?
> >
> > You need a M-Mode firmware which follows the SBI specification and
> > that implements the HSM extension.
>
> Firstly, and maybe I am showing my ignorance here, but we do support
> m-mode in Linux, and SMP is not disabled for m-mode kernels where it is
> required to use the spinwait method.

You're right.

> Secondly, I don't think that we've actually noted that non-HSM booting
> is deprecated before now - at least not somewhere obviously. Things like
> the platform spec on github might require it & it may be deprecated in
> SBI implementations etc, but in the Kconfig option it is not described
> as deprecated. The Kconfig option only says that it "should be only
> enabled for M-mode Linux or platforms relying on older firmware without
> SBI HSM extension".
> I think marking it as deprecated here is not accurate, and instead we
> would be better off pointing out what the limitations of the method are
> and noting the limited situations when it should be used.

You're right again, before this is officially deprecated, I'll point
out the limitations of this method only as follows:

Kernel entrance
---------------

On SMP systems, there are 2 methods to enter the kernel:

- `RISCV_BOOT_SPINWAIT`: the firmware releases all harts in the kernel, one=
 hart
  wins a lottery and executes the early boot code while the other
harts are
  parked waiting for the initialization to finish. This method is mostly us=
ed to
  support older firmwares without SBI HSM extension and M-mode RISC-V
kernel.
- `Ordered booting`: the firmware releases only one hart that will
execute the
  initialization phase and then will start all other harts using the SBI HS=
M
  extension. The ordered booting method is the preferred booting
method for
  booting the RISC-V kernel because it can support cpu hotplug and kexec.

>
> > > Also, what about !SMP systems? Although my suggested new section titl=
e
> > > kinda addresses that!
> >
> > I'll add "On SMP systems, there exist 2 methods to enter the
>
> nit: s/exist/are/
>
> > kernel:....", I don't think we need to detail the !SMP case as it is
> > obvious.
>
> That's fine. Maybe I am just a pedant, but I think it is good to be a
> bit over precise.
>
> > > > > > +  **deprecated**.
> > > > > > +- Ordered booting: the firmware releases only one hart that wi=
ll execute the
> > > > > > +  initialization phase and then will start all other harts usi=
ng the SBI HSM
> > > > > > +  extension.
>
> > > > > > +---------------------
> > > > > > +
> > > > > > +The installation of the virtual mapping is done in 2 steps in =
the RISC-V kernel:
> > > > > > +
> > > > > > +1. :c:func:`setup_vm` installs a temporary kernel mapping in
> > > > > > +   :c:var:`early_pg_dir` which allows to discover the system m=
emory: only the
> > > > >
> > > > > s/to discover/discovery of/
> > > >
> > > > You mean "the discovery of" right?
> > >
> > > No? The "the" there would not be required.
> >
> > That was a genuine question, thanks
>
> Sorry if the "No?" came across as aggressive, I meant it inquisitively.
> Adding the "the" changes the meaning slightly, but not in a way that
> that is relevant here.

No worries :)

>
> > > > > > +Pre-MMU execution
> > > > > > +-----------------
> > > > > > +
> > > > > > +Any code that executes before even the first virtual mapping i=
s established
> > > > > > +must be very carefully compiled as:
> > > > >
> > > > > Could you point out what the non-obvious examples of this code ar=
e?
> > > >
> > > > I can do a list, yes
> > >
> > > Not even a list, just something like "...established, for example ear=
ly
> > > alternatives and foo, must be very..."
> >
> > Done as follows:
> >
> > "A few pieces of code need to run before even the first virtual mapping=
 is
> > established, that comprises the installation of the first virtual mappi=
ng, the
> > early alternatives and the early parsing of the kernel command line. Th=
at code
> > must be very carefully compiled as:..."
>
> Changed slightly:
> "A few pieces of code need to run before even the first virtual mapping i=
s
> established. These are the installation of the first virtual mapping itse=
lf,
> patching of early alternatives and the early parsing of the kernel comman=
d line.
> That code must be very carefully compiled as:..."
>
> Two minor suggestions there, one to make the it more obvious what the fir=
st
> section inside commas refers to & one to note what it is that we do with
> the alternatives.
>

Thanks

> Cheers,
> Conor.
