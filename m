Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA4064E175
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiLOTBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLOTBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:01:16 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BB614099
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:01:15 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so42770pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuChFR2oQEj+k5SBziL84rBEkRXF5P0h5Y1/WRLhyyY=;
        b=ZvKUZ+wIj8TxVtXe1RmNvLjYq85nqQBKWR2J/sMYL0yqrTyu+UIEtCMu6SMMiGuHdi
         NtF5eIEeBIIREjqALMs36a6cxpwOE4tLu1bZjVyfDBuVgxoncSgLgs+dbDTJpun20SSu
         Xt1Trrb36KkWuLHzxWxObFiky759qYX98nuqcexdTjQxbupuQ2oCvBmSq7jSZTMG794X
         d7O6OCqAMsUR3gtxmWGHRxJDe14XXy67HAKuF2xxfYIMr775J6cmYQk9q8BKZCM1XjUg
         eil5hXNgvld6EEtMwkPM7GV2sU/JeaNw/bUeaKkf6n9V3eF0WRY53FeeBV57gTVjLpd+
         vsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuChFR2oQEj+k5SBziL84rBEkRXF5P0h5Y1/WRLhyyY=;
        b=iyLp2HXj1OYc7TP6mYGKkemzf1a7G31fnbCVDCpq+PmCWI11iThEtJUQvav28kLOP1
         KYsSZtlA8L6thn5vTdGQmvVOdyx1CNwrzi/WHHWXg3waNN4X/camaRPZdzDggoU4wQOZ
         Bvvv9AetuckJhn7E9BxzWbwRqMgoAGOQd1SCjN4235yTenwNO77b/602vZXnCISgV1j8
         gFdP5VrJjNjJvm5nlOz/njnTVZQsHvznEjFTTsxTD0fwk7fgWFQzhx6gV0KLW3jwqOgO
         UyjQOO50NQpoYKMYqpvuUNF9FgEdMLOw2X97CU/4rZuk7Zo9PJRiaq5uO0sOPu05ASEm
         EzPA==
X-Gm-Message-State: AFqh2kqer2P+oJbTP0bDP/U9LREA+tWBTGvL/iJfM20YyPQuSc7sADsC
        Sn5CiUoaEv0zxJ4eU5tAK/mWTMnc2NR6FL3nQ3E=
X-Google-Smtp-Source: AMrXdXtdRsOyrnYoJR2RVGd9eyrfrVTfZ1DFEMT0t/oIZUy03YLBzDZV9lr94IVNdHNbNiPMf0tQtHMH/Wi08Fn/tKY=
X-Received: by 2002:a17:90b:2415:b0:223:4d09:2523 with SMTP id
 nr21-20020a17090b241500b002234d092523mr368734pjb.161.1671130875248; Thu, 15
 Dec 2022 11:01:15 -0800 (PST)
MIME-Version: 1.0
References: <mhng-975b1d7b-7b3f-4e88-804c-8b22787f9588@palmer-ri-x1c9>
 <e9cf13a9-561a-3438-00f0-41fe2631888d@rivosinc.com> <Y5irn63DQkwumfvW@bruce.bluespec.com>
 <8fe9cfaf-2cbc-8de6-3928-067de9113bfc@rivosinc.com> <Y5qByfCtpV0uNID3@bruce.bluespec.com>
 <877cysx4yf.fsf@all.your.base.are.belong.to.us> <87h6xwdf5g.fsf@oldenburg.str.redhat.com>
 <24a1a812-95a9-ed97-abd1-c0ff259726d2@linaro.org> <15d902d0-4492-f828-7147-164319d741f9@rivosinc.com>
 <CA+=Sn1nH-b8OigfFBNKT_ECr5DL-jJ5XU+H9pA9g5gF=8YQNMQ@mail.gmail.com>
In-Reply-To: <CA+=Sn1nH-b8OigfFBNKT_ECr5DL-jJ5XU+H9pA9g5gF=8YQNMQ@mail.gmail.com>
From:   Andrew Pinski <pinskia@gmail.com>
Date:   Thu, 15 Dec 2022 11:01:02 -0800
Message-ID: <CA+=Sn1k=VoG1p9ZA0n5KYRg8yPbSkyxzd8piqDcTsTepqJQFyw@mail.gmail.com>
Subject: Re: RISCV Vector unit disabled by default for new task (was Re:
 [PATCH v12 17/17] riscv: prctl to enable vector commands)
To:     Vineet Gupta <vineetg@rivosinc.com>
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Darius Rad <darius@bluespec.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>, stillson@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        libc-alpha@sourceware.org, christoph.muellner@vrull.eu,
        Aaron Durbin <adurbin@rivosinc.com>, linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 10:59 AM Andrew Pinski <pinskia@gmail.com> wrote:
>
> On Thu, Dec 15, 2022 at 10:57 AM Vineet Gupta <vineetg@rivosinc.com> wrot=
e:
> >
> >
> >
> > On 12/15/22 07:33, Richard Henderson wrote:
> > > On 12/15/22 04:28, Florian Weimer via Libc-alpha wrote:
> > >> * Bj=C3=B6rn T=C3=B6pel:
> > >>
> > >>>> For SVE, it is in fact disabled by default in the kernel.  When a
> > >>>> thread
> > >>>> executes the first SVE instruction, it will cause an exception, th=
e
> > >>>> kernel
> > >>>> will allocate memory for SVE state and enable TIF_SVE. Further use
> > >>>> of SVE
> > >>>> instructions will proceed without exceptions.  Although SVE is
> > >>>> disabled by
> > >>>> default, it is enabled automatically.  Since this is done
> > >>>> automatically
> > >>>> during an exception handler, there is no opportunity for memory
> > >>>> allocation
> > >>>> errors to be reported, as there are in the AMX case.
> > >>>
> > >>> Glibc has an SVE optimized memcpy, right? Doesn't that mean that pr=
etty
> > >>> much all processes on an SVE capable system will enable SVE
> > >>> (lazily)? If
> > >>> so, that's close to "enabled by default" (unless SVE is disabled sy=
stem
> > >>> wide).
> > >>
> > >> Yes, see sysdeps/aarch64/multiarch/memcpy.c:
> > >>
> > >>    static inline __typeof (__redirect_memcpy) *
> > >>    select_memcpy_ifunc (void)
> > >>    {
> > >>      INIT_ARCH ();
> > >>         if (sve && HAVE_AARCH64_SVE_ASM)
> > >>        {
> > >>          if (IS_A64FX (midr))
> > >>            return __memcpy_a64fx;
> > >>          return __memcpy_sve;
> > >>        }
> > >>         if (IS_THUNDERX (midr))
> > >>        return __memcpy_thunderx;
> > >>         if (IS_THUNDERX2 (midr) || IS_THUNDERX2PA (midr))
> > >>        return __memcpy_thunderx2;
> > >>         if (IS_FALKOR (midr) || IS_PHECDA (midr))
> > >>        return __memcpy_falkor;
> > >>         return __memcpy_generic;
> > >>    }
> > >>    And the __memcpy_sve implementation actually uses SVE.
> > >>
> > >> If there were a prctl to select the vector width and enable the vect=
or
> > >> extension, we'd have to pick a width in glibc anyway.
> > >
> > > There *is* a prctl to adjust the SVE vector width, but glibc does not
> > > need to select because SVE dynamically adjusts to the currently
> > > enabled width.  The kernel selects a default width that fits within
> > > the default signal frame size.
> > >
> > > The other thing of note for SVE is that, with the default function AB=
I
> > > all of the SVE state is call-clobbered, which allows the kernel to
> > > drop instead of save state across system calls.  (There is a separate
> > > vector function call ABI when SVE types are used.)
> >
> > For the RV psABI, it is similar - all V regs are
> > caller-saved/call-clobbered [1] and syscalls are not required to
> > preserve V regs [2]
> > However last I checked ARM documentation the ABI doc seemed to suggest
> > that some (parts) of the SVE regs are callee-saved [3]
>
> Yes the lower 64 bits which overlap with the floating point registers.

I should expand on that, only the specific callee registers have to
save the lower 64bits because they overlap with the floating point
registers.

Thanks,
Andrew

>
> Thanks,
> Andrew Pinski
>
>
> >
> > >
> > > So while strcpy may enable SVE for the thread, the next syscall may
> > > disable it again.
> >
> > Next syscall could trash them, but will it disable SVE ? Despite
> > syscall/function-call clobbers, using V in tight loops such as mem*/str=
*
> > still is a win.
> >
> >
> > [1]
> > https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-=
cc.adoc
> > [2]
> > https://github.com/riscv/riscv-v-spec/blob/master/calling-convention.ad=
oc
> > [3]
> > https://github.com/ARM-software/abi-aa/blob/2982a9f3b512a5bfdc9e3fea5d3=
b298f9165c36b/aapcs64/aapcs64.rst#the-base-procedure-call-standard
> > Sec 6.1.3 ".... In other cases it need only preserve the low 64 bits of
> > z8-z15"
> >
