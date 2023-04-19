Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A191A6E85FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 01:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjDSXel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 19:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjDSXek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 19:34:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9302D62
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 16:34:38 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24704a7bf34so281457a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 16:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1681947278; x=1684539278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42V/4d2g4SmvVdtXXthexb+5Ubl/6v371AotGfmaixU=;
        b=lgrWN3ZYYUvxafsTOzwbZWiNtrbe8XhcGEd/r4vVw8GtLnvll+Mvinro9WIVnR7cdr
         +Lt9LcEQFlrJuCxKy5W0tkjkWAFuV2ex9CCpzHsX848xUdkxfhWlrizQarsdW2RFRqP6
         Nf/+gtcblODAJ/oIEwPw4g6tRzhkn6C6Q46r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681947278; x=1684539278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42V/4d2g4SmvVdtXXthexb+5Ubl/6v371AotGfmaixU=;
        b=jyxqhZQSCSuizCkbhayI6kZTlcnKd1dAmmMnh2F33J6QmKb3V/QY/F32FYexVkOOHW
         fLFjELJFNpQo1LAvWXR/g5s1Eqg4gTw3Tx/tABFlrQxBkVDjk3cnY6NQKQv1bCS8lLNI
         eCumVkx+bmMFjUoAAe45CiQVw4MqU6EdA5brdWXkJtywqc1S9rGr9HyDL75UCjhYLku2
         5OocKblANJppaeU0JOW90ZwzhMbH7RsWbV4gXdoOSc5ZFoHDwYc4d1X7qv/OjdD5NO2N
         5CQ+wUU1qP/9gQkzJmaNgSi1McgeH2j1IjY1cBdgAVuRNOYqMNouEVg/WM23sBBKqARQ
         IzYg==
X-Gm-Message-State: AAQBX9d43TWKqxwlPg86urkxEDOGafcK2Ft4TtgkYLBAzJ3k7ieWoYTo
        MjKhOkODWZCIGN1onzUQ6gu/cIfeUWaz1IEa5rkC
X-Google-Smtp-Source: AKy350aBH0VEPcP2Qh/Eoox3kPORS1HQObKPOJMrnSxK+FdPS8mYZv3TNtyW5xMB6xiXuJwilswkqt/c7AoWpmH4+5o=
X-Received: by 2002:a17:90b:180f:b0:247:eae:1787 with SMTP id
 lw15-20020a17090b180f00b002470eae1787mr4273120pjb.36.1681947278172; Wed, 19
 Apr 2023 16:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <16007014-c5f2-4b07-baec-e19952236aa5@spud> <ZAbGSA6F0kfv9YYw@sunil-laptop>
 <E7FB4927-1FE6-435A-914E-9615C2AD9D34@kernel.org> <a9823561-2e32-49e8-b6c9-73e4b8f8cf8d@spud>
 <ZAfeaO52pnYhiyLN@sunil-laptop> <CAFiDJ58bRo6R1qOFaSSNgAdbQJZ3xDY6Wth-t8M8XKRFbig2hA@mail.gmail.com>
 <ZCvJpnNZYzrIcfPe@sunil-laptop> <CAHBxVyHA8ZouSUnqHaZTa=uMQxx61RqZuSBHx15Hg8+AVYLXZg@mail.gmail.com>
 <CAFiDJ5-7qY2vQvbcTU7QPLmqrbCmXWkCxmswO4OqeYtsNOiOFw@mail.gmail.com>
In-Reply-To: <CAFiDJ5-7qY2vQvbcTU7QPLmqrbCmXWkCxmswO4OqeYtsNOiOFw@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 20 Apr 2023 05:04:26 +0530
Message-ID: <CAOnJCUJT+kdFRn=3nZA6P6JatyN0anbKd0ufbQ_Zs9DSAoaC6A@mail.gmail.com>
Subject: Re: [PATCH V3 00/20] Add basic ACPI support for RISC-V
To:     Ley Foon Tan <lftan@kernel.org>
Cc:     Atish Kumar Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-doc@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, llvm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>, linux-acpi@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <lenb@kernel.org>
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

On Wed, Apr 19, 2023 at 1:38=E2=80=AFPM Ley Foon Tan <lftan@kernel.org> wro=
te:
>
> On Thu, Apr 6, 2023 at 10:45=E2=80=AFAM Atish Kumar Patra <atishp@rivosin=
c.com> wrote:
> >
>
> > > >
> > > > Hi Sunil
> > > >
> > > > One question regarding PMU in ACPI flow.
> > > >
> > > > We use DT to decode the supported HPM counters/events for the
> > > > different platforms now.
> > > > How do we enable PMU (drivers/perf/riscv_pmu_sbi.c) when using ACPI=
 method?
> > > > Note, this might be in separate patch series.
> > > >
> > > Hi Lay Foon,
> > >
> > > This driver uses SBI calls and hence should work in case of ACPI also=
.
> > >
> > > There is one minor change required in this driver for overflow
> > > interrupt. I have a patch for that in future series.
> >
> > Just to add further clarification: OpenSBI will continue to use the
> > device tree so that
> > the firmware will have access to all the PMU details.
> >
> Sorry for the late reply, missed out on this email in my kernel.org mailb=
ox.
>
> Do you mean OpenSBI still using the device tree, but EDK II and Linux
> using the ACPI table? Normally Linux shouldn't mix between ACPI and

Yes. For Linux, it will only be ACPI. Otherwise, we have to define all
those bindings in ACPI as well.
In the future, we will have supervisor counter delegation ISA
extension(in progress) that allows the kernel to directly program
the hpmevents & modify counters without needing SBI PMU extension.


> device tree.
>


> Regards
> Ley Foon
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Regards,
Atish
