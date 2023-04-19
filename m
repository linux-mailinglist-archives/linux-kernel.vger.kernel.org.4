Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797006E74A9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjDSIIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjDSIIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:08:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA79C3A82;
        Wed, 19 Apr 2023 01:08:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96CF963C47;
        Wed, 19 Apr 2023 08:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B63C433A4;
        Wed, 19 Apr 2023 08:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681891664;
        bh=AXquwKy5LjLh7tSnRzd0VsL8D1TiNE1DyoFpIoSW6NA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SeXRFi7Ed8cuF/n3wtNQRShpWdJqtGRYHLK+7r63bTHUt97aJ7VTI0tWv+eJTpfR/
         hfAxGSUkKgQtr2wugf6N5JAmgtbGhp3jTSQtTFoOm8ARe0fUrb1IC0ViTquGOJZyxU
         2a+eZQnK6BHf0QK4dQyjua/dtsLDRBh4iW6i+/HWOS1o3kXif0k1cwooORbWxk3tjd
         E4ORTMyE1PW23VOnGrt8Gl3nCj/2tmBB2008n9U+7Wg1BLr5mg52GD9q/2wyN4aW5a
         r+j0OgBvQk23jI6yRuUPownWI7ug+xrZD5gWxZqUMk1izEKlpSxCdGNqb4vSTCyhtq
         YQv1ao+ttHRFw==
Received: by mail-qv1-f47.google.com with SMTP id me15so11530785qvb.4;
        Wed, 19 Apr 2023 01:07:43 -0700 (PDT)
X-Gm-Message-State: AAQBX9dwyXD2NHiFmuiCtTUaNREnfAMNyUoQT50y9kqmN9Ld/cCzAFUC
        I8cPtS6VcyRVFSnewo1kdpzkL6xgOT79k41/Tvc=
X-Google-Smtp-Source: AKy350bdQVlRWqsqeS6TRYbu0RmPCz51xkA13vrz1KtzyFZ8SBsJ/CulCVdIHrwUKbMaG/ei0H3CuUjCZH3hhJeLmF8=
X-Received: by 2002:a05:6214:d0d:b0:5b4:89b4:1af8 with SMTP id
 13-20020a0562140d0d00b005b489b41af8mr26907505qvh.16.1681891663014; Wed, 19
 Apr 2023 01:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <16007014-c5f2-4b07-baec-e19952236aa5@spud> <ZAbGSA6F0kfv9YYw@sunil-laptop>
 <E7FB4927-1FE6-435A-914E-9615C2AD9D34@kernel.org> <a9823561-2e32-49e8-b6c9-73e4b8f8cf8d@spud>
 <ZAfeaO52pnYhiyLN@sunil-laptop> <CAFiDJ58bRo6R1qOFaSSNgAdbQJZ3xDY6Wth-t8M8XKRFbig2hA@mail.gmail.com>
 <ZCvJpnNZYzrIcfPe@sunil-laptop> <CAHBxVyHA8ZouSUnqHaZTa=uMQxx61RqZuSBHx15Hg8+AVYLXZg@mail.gmail.com>
In-Reply-To: <CAHBxVyHA8ZouSUnqHaZTa=uMQxx61RqZuSBHx15Hg8+AVYLXZg@mail.gmail.com>
From:   Ley Foon Tan <lftan@kernel.org>
Date:   Wed, 19 Apr 2023 16:07:30 +0800
X-Gmail-Original-Message-ID: <CAFiDJ5-7qY2vQvbcTU7QPLmqrbCmXWkCxmswO4OqeYtsNOiOFw@mail.gmail.com>
Message-ID: <CAFiDJ5-7qY2vQvbcTU7QPLmqrbCmXWkCxmswO4OqeYtsNOiOFw@mail.gmail.com>
Subject: Re: [PATCH V3 00/20] Add basic ACPI support for RISC-V
To:     Atish Kumar Patra <atishp@rivosinc.com>
Cc:     Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 10:45=E2=80=AFAM Atish Kumar Patra <atishp@rivosinc.=
com> wrote:
>

> > >
> > > Hi Sunil
> > >
> > > One question regarding PMU in ACPI flow.
> > >
> > > We use DT to decode the supported HPM counters/events for the
> > > different platforms now.
> > > How do we enable PMU (drivers/perf/riscv_pmu_sbi.c) when using ACPI m=
ethod?
> > > Note, this might be in separate patch series.
> > >
> > Hi Lay Foon,
> >
> > This driver uses SBI calls and hence should work in case of ACPI also.
> >
> > There is one minor change required in this driver for overflow
> > interrupt. I have a patch for that in future series.
>
> Just to add further clarification: OpenSBI will continue to use the
> device tree so that
> the firmware will have access to all the PMU details.
>
Sorry for the late reply, missed out on this email in my kernel.org mailbox=
.

Do you mean OpenSBI still using the device tree, but EDK II and Linux
using the ACPI table? Normally Linux shouldn't mix between ACPI and
device tree.

Regards
Ley Foon
