Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CBB6D0DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjC3SbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjC3SbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:31:09 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A0926B8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:31:06 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a11so20585104lji.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680201065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4QG32glT+tPHqBHPO/ahp4Rj/Y6Ok/1/jb66T0Ro+s=;
        b=Qh8bK7i7hfJEM+1W1rQTmIoi2XDNoN9PWIpdbxIWkpGlQUUU9eImLC7wy5nuo3DzfN
         yLLvaWPgAIxb2EyRzYunmxDmUDVS8nULxt8VddcXJEt0APRFPSyidKmu/hKICKNvyi4u
         w70DWAHUVtSFLiYo6+9irFiYZLewPu3rkShiyfKyS+reTYaazmrIR7krCkkZm6N629wC
         aVIbZztnw0jQx4DpJhnTFGeDqe1Mxs6H7EUiLFNymACzxrj/jUPeZQUCm9PG7ngfO7NI
         jhetQus9nZezECvnMgw8kySj7hwy9GGBe4MOgr8wLpaiDL0src1x8+dl9obApepTIT6R
         evhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680201065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4QG32glT+tPHqBHPO/ahp4Rj/Y6Ok/1/jb66T0Ro+s=;
        b=bkCqS3t5HJOYVat7nFQShyOKQPeUR4GYkPo5Il3akA+Fyr7Alhz0zSp3jx1gay6THS
         X2ITMTEyxfumcfSiWwjEbxjmbqfpcLdxM4COp4BCLJKpT2FG2Roc+hFx1tBp+4JlDi/7
         4JnSSXqs49X1u4InS03oBTco+S08oXBLgVOm8i3rRaCHMUWIjsWnpOGg+1WgcZdzMX4F
         3ItbgzQyvw2+ZlB3VI453xUoGe+l6usCQSc/LrCxc6qWK2MPlJ/oeLeMZ058f3dehZ+F
         jdEGUmNre3LMatJndz19gb0RHZz62uUttyZ1kRfX730FS31ObRVPLE5Rzq4oeQsgbG1x
         1wCA==
X-Gm-Message-State: AAQBX9dW4dWRM5Vv1+GoaF9MpdSY+QfWgw7zjl7BV+L4ywPuVl4dKDKm
        p8TMchzWLCsc16xSicdI/A/xqPjR2ed0ebaTzblRB63M+spffoWH
X-Google-Smtp-Source: AKy350ac0Ym4n+b7VsgrP64Z2yOkhqsCxyYEAUlayK34y4u4/HjIP7opTmYIxOLRCt8DA9iOPeeG7EoKst5bN4EsmnE=
X-Received: by 2002:a2e:9887:0:b0:298:72a8:c6c4 with SMTP id
 b7-20020a2e9887000000b0029872a8c6c4mr7514253ljj.9.1680201065020; Thu, 30 Mar
 2023 11:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230221190858.3159617-1-evan@rivosinc.com> <20230221190858.3159617-3-evan@rivosinc.com>
 <605fb2fd-bda2-4922-92bf-e3e416d54398@app.fastmail.com>
In-Reply-To: <605fb2fd-bda2-4922-92bf-e3e416d54398@app.fastmail.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 30 Mar 2023 11:30:29 -0700
Message-ID: <CALs-HstAKtvORKwRWeh97SuAuYR61aiR-3jA2_0JCZGAJXVHbg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] RISC-V: Add a syscall for HW probing
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Conor Dooley <conor@kernel.org>, slewis@rivosinc.com,
        Vineet Gupta <vineetg@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        guoren <guoren@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 2:06=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Feb 21, 2023, at 20:08, Evan Green wrote:
> > We don't have enough space for these all in ELF_HWCAP{,2} and there's n=
o
> > system call that quite does this, so let's just provide an arch-specifi=
c
> > one to probe for hardware capabilities.  This currently just provides
> > m{arch,imp,vendor}id, but with the key-value pairs we can pass more in
> > the future.
> >
> > Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Evan Green <evan@rivosinc.com>
>
> I'm still skeptical about the need for a custom syscall interface here.
> I had not looked at the interface so far, but there are a few things
> that stick out:
>
> > +RISC-V Hardware Probing Interface
> > +---------------------------------
> > +
> > +The RISC-V hardware probing interface is based around a single
> > syscall, which
> > +is defined in <asm/hwprobe.h>::
> > +
> > +    struct riscv_hwprobe {
> > +        __s64 key;
> > +        __u64 value;
> > +    };
>
> The way this is defined, the kernel will always have to know
> about the specific set of features, it can't just forward
> unknown features to user space after probing them from an
> architectured hardware interface or from DT.

You're correct that this interface wasn't intended to have usermode
come in with augmented data or additional key/value pairs. This was
purely meant to provide access to the kernel's repository of
architectural and microarchitectural details. If usermode wants to
provide extra info in this same form, maybe they could wrap this
interface.

>
> If 'key' is just an enumerated value with a small number of
> possible values, I don't see anything wrong with using elf
> aux data. I understand it's hard to know how many keys
> might be needed in the long run, from the way you define
> the key/value pairs here, I would expect it to have a lot
> of the same limitations that the aux data has, except for
> a few bytes to be copied.

Correct, this makes allocating bits out of here cheaper by not
requiring that we actively copy them into every new process forever.
You're right that the aux vector would work as well, but the thinking
behind this series was that an interface like this might be better for
an architecture as extensible as risc-v.

>
> > +    long sys_riscv_hwprobe(struct riscv_hwprobe *pairs, size_t
> > pair_count,
> > +                           size_t cpu_count, cpu_set_t *cpus,
> > +                           unsigned long flags);
>
> The cpu set argument worries me more: there should never be a
> need to optimize for broken hardware that has an asymmetric set
> of features. Just let the kernel figure out the minimum set
> of features that works across all CPUs and report that like we
> do with HWCAP. If there is a SoC that is so broken that it has
> important features on a subset of cores that some user might
> actually want to rely on, then have them go through the slow
> sysfs interface for probing the CPUs indidually, but don't make
> the broken case easier at the expense of normal users that
> run on working hardware.

I'm not so sure. While I agree with you for major classes of features
(eg one CPU has floating point support but another does not), I expect
these bits to contain more subtle details as well, which might vary
across asymmetric implementations without breaking ABI compatibility
per-se. Maybe some vendor has implemented exotic video decoding
acceleration instructions that only work on the big core. Or maybe the
big cores support v3.1 of some extension (where certain things run
faster), but the little cores only have v3.0, where it's a little
slower. Certain apps would likely want to know these things so they
can allocate their work optimally across cores.

>
> > +asmlinkage long sys_riscv_hwprobe(uintptr_t, uintptr_t, uintptr_t,
> > uintptr_t,
> > +                               uintptr_t, uintptr_t);
>
> Why 'uintptr_t' rather than the correct type?

Fixed.
-Evan
