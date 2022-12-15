Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE764E171
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiLOTAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLOTAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:00:02 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3411B1E1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:00:01 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x66so242632pfx.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9ls2j7Ywe5JCV1Zd3x2Q8hIHEGMMPFJOgwMgtP3Dbw=;
        b=WEPLllNGalHFpRc9XaNskiy3ODgxZnDG+XM3aTqr4+gMdZxy/pSF6X4C4Q03DmDbBe
         X9Ad1j3cHI/S6nmQQAvk4F1eWrpzwGJnOZxsWqrG/4eLBR2Fhw0gRPjPcG5oCttP3Ffl
         0L6zfbOLV1n8dzAIqaOQn5oMlZNutGT/e1dl5vGmT094yr3OOSXGkn3NGwsS03JMK0LF
         AIZO5sludl0usHa4K8v10QKMVhQJeJm4vnam0pmJG+hAUjGsMm03Z5aGzHakt/gkFpYP
         WccAuzs3hpP7Bjl961AMn6BpEBYwx4EohuN9UUrfGPp+a9ylh1spkKGLmF7dMVnj+FHQ
         PkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9ls2j7Ywe5JCV1Zd3x2Q8hIHEGMMPFJOgwMgtP3Dbw=;
        b=yAgV6SLDS79Px14tuSaIqjngAsNNOdRvfG92fhkJsOitpZTjHIIgFjcm8cNK/hrIWB
         kpFgzp7ycbvE2MDrCCF/QGSiS0hLLuv5zTiKKVcDvrhjkSHGfEVFCFGTjku47fTk+5tA
         k05Lufyrn88NP/v2/MdhBnSdDwxWCALBpg8qBy1HUWfIEQ6sIOru4Bfy7Y/838JDihFm
         gj3RBRRcxChkQJbc13mOfYvN5BZ8uQqJsb6sEZ8QKF/0I1PIGtRlJewClpYLck+BDYJu
         GtKZ5p8nGGV8oLephOXNtTxHzrpWtklTNVARiA668CSeJdq/dpwQR9Y9fKmjwmgxvJyo
         VevQ==
X-Gm-Message-State: ANoB5pmW35v1/6npjOKENhSFxnnOIsAcXQFVC/Wg41Dp4fC/SVEjpw8B
        g0dL6Zx/D58GMMU85qMRwIBo3oHhQMQbPP9bu0E=
X-Google-Smtp-Source: AA0mqf57OKqhwBqhmheBunoBC/INxpIpRZ2JKwqXmCHsHVoCpXHZcynAkGWQcQiKsXXsHKYf04AFAazh73lA3n8iP10=
X-Received: by 2002:a63:417:0:b0:478:6f31:d40c with SMTP id
 23-20020a630417000000b004786f31d40cmr32133147pge.16.1671130800746; Thu, 15
 Dec 2022 11:00:00 -0800 (PST)
MIME-Version: 1.0
References: <mhng-975b1d7b-7b3f-4e88-804c-8b22787f9588@palmer-ri-x1c9>
 <e9cf13a9-561a-3438-00f0-41fe2631888d@rivosinc.com> <Y5irn63DQkwumfvW@bruce.bluespec.com>
 <8fe9cfaf-2cbc-8de6-3928-067de9113bfc@rivosinc.com> <Y5qByfCtpV0uNID3@bruce.bluespec.com>
 <877cysx4yf.fsf@all.your.base.are.belong.to.us> <87h6xwdf5g.fsf@oldenburg.str.redhat.com>
 <24a1a812-95a9-ed97-abd1-c0ff259726d2@linaro.org> <15d902d0-4492-f828-7147-164319d741f9@rivosinc.com>
In-Reply-To: <15d902d0-4492-f828-7147-164319d741f9@rivosinc.com>
From:   Andrew Pinski <pinskia@gmail.com>
Date:   Thu, 15 Dec 2022 10:59:47 -0800
Message-ID: <CA+=Sn1nH-b8OigfFBNKT_ECr5DL-jJ5XU+H9pA9g5gF=8YQNMQ@mail.gmail.com>
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

On Thu, Dec 15, 2022 at 10:57 AM Vineet Gupta <vineetg@rivosinc.com> wrote:
>
>
>
> On 12/15/22 07:33, Richard Henderson wrote:
> > On 12/15/22 04:28, Florian Weimer via Libc-alpha wrote:
> >> * Bj=C3=B6rn T=C3=B6pel:
> >>
> >>>> For SVE, it is in fact disabled by default in the kernel.  When a
> >>>> thread
> >>>> executes the first SVE instruction, it will cause an exception, the
> >>>> kernel
> >>>> will allocate memory for SVE state and enable TIF_SVE. Further use
> >>>> of SVE
> >>>> instructions will proceed without exceptions.  Although SVE is
> >>>> disabled by
> >>>> default, it is enabled automatically.  Since this is done
> >>>> automatically
> >>>> during an exception handler, there is no opportunity for memory
> >>>> allocation
> >>>> errors to be reported, as there are in the AMX case.
> >>>
> >>> Glibc has an SVE optimized memcpy, right? Doesn't that mean that pret=
ty
> >>> much all processes on an SVE capable system will enable SVE
> >>> (lazily)? If
> >>> so, that's close to "enabled by default" (unless SVE is disabled syst=
em
> >>> wide).
> >>
> >> Yes, see sysdeps/aarch64/multiarch/memcpy.c:
> >>
> >>    static inline __typeof (__redirect_memcpy) *
> >>    select_memcpy_ifunc (void)
> >>    {
> >>      INIT_ARCH ();
> >>         if (sve && HAVE_AARCH64_SVE_ASM)
> >>        {
> >>          if (IS_A64FX (midr))
> >>            return __memcpy_a64fx;
> >>          return __memcpy_sve;
> >>        }
> >>         if (IS_THUNDERX (midr))
> >>        return __memcpy_thunderx;
> >>         if (IS_THUNDERX2 (midr) || IS_THUNDERX2PA (midr))
> >>        return __memcpy_thunderx2;
> >>         if (IS_FALKOR (midr) || IS_PHECDA (midr))
> >>        return __memcpy_falkor;
> >>         return __memcpy_generic;
> >>    }
> >>    And the __memcpy_sve implementation actually uses SVE.
> >>
> >> If there were a prctl to select the vector width and enable the vector
> >> extension, we'd have to pick a width in glibc anyway.
> >
> > There *is* a prctl to adjust the SVE vector width, but glibc does not
> > need to select because SVE dynamically adjusts to the currently
> > enabled width.  The kernel selects a default width that fits within
> > the default signal frame size.
> >
> > The other thing of note for SVE is that, with the default function ABI
> > all of the SVE state is call-clobbered, which allows the kernel to
> > drop instead of save state across system calls.  (There is a separate
> > vector function call ABI when SVE types are used.)
>
> For the RV psABI, it is similar - all V regs are
> caller-saved/call-clobbered [1] and syscalls are not required to
> preserve V regs [2]
> However last I checked ARM documentation the ABI doc seemed to suggest
> that some (parts) of the SVE regs are callee-saved [3]

Yes the lower 64 bits which overlap with the floating point registers.

Thanks,
Andrew Pinski


>
> >
> > So while strcpy may enable SVE for the thread, the next syscall may
> > disable it again.
>
> Next syscall could trash them, but will it disable SVE ? Despite
> syscall/function-call clobbers, using V in tight loops such as mem*/str*
> still is a win.
>
>
> [1]
> https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-cc=
.adoc
> [2]
> https://github.com/riscv/riscv-v-spec/blob/master/calling-convention.adoc
> [3]
> https://github.com/ARM-software/abi-aa/blob/2982a9f3b512a5bfdc9e3fea5d3b2=
98f9165c36b/aapcs64/aapcs64.rst#the-base-procedure-call-standard
> Sec 6.1.3 ".... In other cases it need only preserve the low 64 bits of
> z8-z15"
>
