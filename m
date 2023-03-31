Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88606D2714
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjCaRwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjCaRwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:52:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299B586B5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:52:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bi9so29903766lfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680285151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8e80o4Gln79rBts1nJMY6npgXhVyP7I9l6v7qOmueE=;
        b=ZDMMsOOv7bfUQdz6tTuzYk4eoWNfPOynWKo7prMzzERpOnSYfO3iJWqKNRl2biNzxR
         plXcDrJMH0etJstWAhURI6h0Emo3yos5KYLYAC5vQk32L5qJ2KHiODceSYJAYB5tKh1S
         EpVdWD70PM98V9dohJZAtonBCMekXxlMHzt9y4ChHGts/uWsdHO13bE1HXB0DI+kBETj
         1LHZl8n2ojURi/ya23GTnBBaAYu3g0YeJiDLEaGLfnfbfbkiRr5k2n56pxm4c5f4SgBj
         BpOch70J30vIOEb+KgVgSul4thXKDM8Bsyj6RnTKk49Qe1Z7tAdbBUNiMqn277oxM0Em
         N6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680285151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8e80o4Gln79rBts1nJMY6npgXhVyP7I9l6v7qOmueE=;
        b=lRXMImxGD+MGZDzAedyCw6oYykKpBUgRUKxUcODjo+52bSLVBnE2XvygSdsq4jdmXr
         cNnUrSPmQxKmfphaVcqWyMSOjuxYmhVflF0el8Ub96/G3CCzdSWpG5GGFVMbwwzLk7Yl
         EoCLWY6dWIPFbTDOGuqrp+0EKUpTthzkANr/2eYJvIFkGFBmuti9f/Bjic+jlsOFPQoN
         aVGLD+bs9NDPlKSV1oiJN0ijnXGE/jSwO6rg1ZWGdbpShtpS928db6FXGRDQxClqXSAE
         VBRbtTqCYLe+8i0nBAPicYYtwSZfAZdqbCEf7clE5aEEE1jX7FF0hQsre0M1T9nhcBHC
         B4vg==
X-Gm-Message-State: AAQBX9eYdlAN9UP9NTelW2wBeDgNXAQkK8GG3fkz/P+LsZToKH48EhZD
        djuAb/5CJ0k9OW3xORd/dAmfXqj/r192mf6bGmGmNg==
X-Google-Smtp-Source: AKy350a+fqJATU7e9z9fJ7w3yTsauVEcnZ7kHiX0Y2joMw8UR3mkd5AYXqrb8iX+RpDnRkPGHb3IeuFazPqEgQ1kl8s=
X-Received: by 2002:a05:6512:23a3:b0:4d8:86c2:75ea with SMTP id
 c35-20020a05651223a300b004d886c275eamr4807421lfv.3.1680285151328; Fri, 31 Mar
 2023 10:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230221190858.3159617-1-evan@rivosinc.com> <20230221190858.3159617-3-evan@rivosinc.com>
 <605fb2fd-bda2-4922-92bf-e3e416d54398@app.fastmail.com> <CALs-HstAKtvORKwRWeh97SuAuYR61aiR-3jA2_0JCZGAJXVHbg@mail.gmail.com>
 <d91ffb1e-261b-4b2f-a78f-f2846600a3e7@app.fastmail.com>
In-Reply-To: <d91ffb1e-261b-4b2f-a78f-f2846600a3e7@app.fastmail.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Fri, 31 Mar 2023 10:51:55 -0700
Message-ID: <CALs-HsuiyocyK+RW_5O3JniOE7ROHHDJ4K=+6NZRzGad7wJpMQ@mail.gmail.com>
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

Hi Arnd,

On Fri, Mar 31, 2023 at 6:21=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Thu, Mar 30, 2023, at 20:30, Evan Green wrote:
> > On Thu, Feb 23, 2023 at 2:06=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >> > +    long sys_riscv_hwprobe(struct riscv_hwprobe *pairs, size_t
> >> > pair_count,
> >> > +                           size_t cpu_count, cpu_set_t *cpus,
> >> > +                           unsigned long flags);
> >>
> >> The cpu set argument worries me more: there should never be a
> >> need to optimize for broken hardware that has an asymmetric set
> >> of features. Just let the kernel figure out the minimum set
> >> of features that works across all CPUs and report that like we
> >> do with HWCAP. If there is a SoC that is so broken that it has
> >> important features on a subset of cores that some user might
> >> actually want to rely on, then have them go through the slow
> >> sysfs interface for probing the CPUs indidually, but don't make
> >> the broken case easier at the expense of normal users that
> >> run on working hardware.
> >
> > I'm not so sure. While I agree with you for major classes of features
> > (eg one CPU has floating point support but another does not), I expect
> > these bits to contain more subtle details as well, which might vary
> > across asymmetric implementations without breaking ABI compatibility
> > per-se. Maybe some vendor has implemented exotic video decoding
> > acceleration instructions that only work on the big core. Or maybe the
> > big cores support v3.1 of some extension (where certain things run
> > faster), but the little cores only have v3.0, where it's a little
> > slower. Certain apps would likely want to know these things so they
> > can allocate their work optimally across cores.
>
> Do you have a specific feature in mind where hardware would be
> intentionally designed this way? I still can't come up with a
> scenario where this would actually work in practice, as having
> asymmetric features is incompatible with so many other things
> we normally do.

Isn't this already a reality, with the ARM folks building systems
where only some cores can run arm32 code, and the rest are aarch64
only?
https://lwn.net/Articles/838339/

The way I see it, it's going to be close to impossible to _not_ design
hardware this way. As long as die area and energy efficiency are a
constraint, big.LITTLE and other asymmetric architectures seem
inevitable. Given this interface is sort of a software cpuid
instruction, pretending there won't be differences between cores feels
like an incomplete API.

>
> - In a virtual machine, the VCPU tents to get scheduled arbitrarily
>   to physical CPUs, so setting affinity in a guest won't actually
>   guarantee that the feature is still there.

Sure, but I wouldn't expect the guest to be able to observe physical
properties from a transient host CPU (I'd consider that a bug). I'd
expect either the VCPU is pinned to a physical CPU with no chance of
migration, in which case you might reasonably plumb down some physical
properties to the guest, or the guest sees a watered down generic CPU
containing the least common denominator of features.

>
> - Using a CPU feature from library code is practically impossible
>   if it requires special CPU affinity, as the application may
>   already be started on specific CPUs for another reason, and
>   having a library call sched_setaffinity will conflict with those.
>
> - Even in the simplest case of having a standalone application
>   without any shared libraries try to pick a sensible CPU to
>   run on is hard to do in a generic way, as it would need to
>   weigh availabilty of features on certain cores against the
>   number of cores with or without the feature and their current
>   and expected system load.

In ChromeOS at least, we struggled a lot with chrome getting scheduled
on the big vs little cores on some ARM platforms, as we'd get things
like dropped video frames if we stayed stuck on the wrong cores. I
think we managed to solve that with uclamp, but again that
acknowledges that there are differences between cores, which I think
justifies the cpuset parameter to a cpu feature interface like this.

>
> As long as there isn't a specific requirement, I think it's better
> to not actually encourage hardware vendors to implement designs
> like that, or at least not designing an interface to make getting
> this information a few microseconds faster that what already
> exists.

As this is ABI, there is a bit of "crystal ball gazing" I'm doing,
though I hope I've backed it up with enough to show it's not a
completely wild parameter.

-Evan
