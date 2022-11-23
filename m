Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8728863501C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 07:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbiKWGLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 01:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKWGK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:10:59 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A932513F39
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 22:10:56 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id i10so40438519ejg.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 22:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JGvVdP4Bfqpyp04bVG1cXRkrqOMcPwJMTXjgeo53p+s=;
        b=M/y/zA1uDiiVj/EruxGP9KEs1YbPQIbTnermjdkVNQA8VpLr5HM7sB4LKRxhfe1wD1
         K829fQNQUYNh2L7PFj7nPms2MQSu/jeuWHHlvXItKQBAFL0R/BZ2nxX7O7AyJ6Sf1Fvr
         kGh6l+kPGZLGJG0lu3mzhU9URnYS05SqttXrLo0EpFXNetQjRnuug6PlVwHSs/0VIE/F
         V4qduc2Nza7SHH7b8q+NERlhr9d6EagE2ckIj59VHKBtZkPTN21d7fHZwBUyugnfc1rD
         mLSarAjiScwhoCnrKL7a256NaI3CW2CniGIKfG1aBbENQIduMZvaF9SJqxOOZLH1t5Fd
         SEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGvVdP4Bfqpyp04bVG1cXRkrqOMcPwJMTXjgeo53p+s=;
        b=JxdWl8PqxFfTYhYIUb0LOZvyQvPgcqZc1Cc8aVsg3YVTgJHQp+flZUpIedzBqqvAmk
         s4tq+IUf8FxLdOiX2TpwDY4kEVPd78M7nQ+DtH2alV8k/W6r/KcyRhYRN2edrbuoQm6s
         nWF6OBcoEYFbpqdcdWel9806xkVAyT7FMMnzu1LgK75336aVIAamM+fcrMHmoOngcD6T
         UbCKYSFpDwWJn/UZZCiiom14QCsE8zmh6z6oappdSYllFIXUGZqQ3BWc7cPFgJKYo0Vu
         wOu3RckaJFPM5sYo1tXHIB9mFIvg1I6ng425z+nAgI56SJnvkkcIlQ23EeQ2Gz9MPFmz
         TgtQ==
X-Gm-Message-State: ANoB5pni6aazwOS0Oe4iXnUu6VIz4fYQ+V3I2jl32vJBYMYMwJXV1RJi
        uwQi4tGzE+l/fGEO/0P1sG+2ZqWb5zFj5VdHT0rrEA==
X-Google-Smtp-Source: AA0mqf6KC6rJnQPiXQL9dC06y5s4WgnywzBbCSISnORalCt40iRqvLUGpzy6QRwCNuvIN6mg5FLen5RfmQMvh+CuO7o=
X-Received: by 2002:a17:906:a0d7:b0:7b2:7af0:c231 with SMTP id
 bh23-20020a170906a0d700b007b27af0c231mr21851245ejb.240.1669183854972; Tue, 22
 Nov 2022 22:10:54 -0800 (PST)
MIME-Version: 1.0
References: <mhng-6299f108-11af-4e70-9981-d7e7b3be0b9a@palmer-ri-x1c9>
 <57114829-c205-dece-abdb-1100947286d4@sholland.org> <CAK9=C2WLOa_zgboFE5UCgnwMB-kbWMAVtmXsBxoswqY63-5QHw@mail.gmail.com>
 <a591599e-d133-e19a-4898-5645c3862daa@sholland.org>
In-Reply-To: <a591599e-d133-e19a-4898-5645c3862daa@sholland.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 23 Nov 2022 11:40:43 +0530
Message-ID: <CAAhSdy2VdX9VivbuRhjN0cPXTi=nFWdiPwFs+hUv6iMqZu-q5g@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
To:     Samuel Holland <samuel@sholland.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        conor.dooley@microchip.com, Conor Dooley <conor@kernel.org>,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:08 AM Samuel Holland <samuel@sholland.org> wrote:
>
> Hi Anup,
>
> On 11/22/22 23:35, Anup Patel wrote:
> > On Wed, Nov 23, 2022 at 10:41 AM Samuel Holland <samuel@sholland.org> wrote:
> >> On 11/22/22 09:28, Palmer Dabbelt wrote:
> >>> I also think we should stop entering non-retentive suspend until we can
> >>> sort out how reliably wake up from it, as the SBI makes that a
> >>> platform-specific detail.  If the answer there is "non-retentive suspend
> >>> is fine on the D1 as long as we don't use the SBI timers" then that
> >>> seems fine, we just need some way to describe that in Linux -- that
> >>> doesn't fix other platforms and other interrupts, but at least it's a
> >>> start.
> >>
> >> We need some way to describe the situation from the SBI implementation
> >> to Linux.
> >>
> >> Non-retentive suspend is fine on the D1 as long as either one of these
> >> conditions is met:
> >>  1) we don't use the SBI timers, or
> >>  2) the SBI timer implementation does not use the CLINT
> >>
> >> And it is up to the SBI implementation which timer hardware it uses, so
> >> the SBI implementation needs to patch this information in to the DT at
> >> runtime.
> >
> > Rather than SBI implementation patching information in DT, it is much
> > simpler to add a quirk in RISC-V timer driver for D1 platform (i.e. based
> > on D1 compatible string in root node).
>
> It would be simpler, but it would be wrong, as I just explained.
>
> Only the SBI implementation knows if the SBI timer extension can wake
> any given CPU from any given non-retentive suspend state.

The SBI implementation would derive this information from platform
compatible string which is already available to the Linux kernel so
why does SBI implementation have to patch the DTB and put the
same information in a different way ?

Regards,
Anup
