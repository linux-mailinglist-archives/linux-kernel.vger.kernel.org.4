Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23E67304C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjFNQSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjFNQSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:18:08 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D4D119
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:18:06 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-43b2fb0afa6so1044831137.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686759486; x=1689351486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqZ5IpvvmpQbJ1zzadm9lsilhVlagwH9wED8wa6qKyk=;
        b=XOfu1eYFWRpySp+RiCt0aA1jZbJR83Le9ctjs32cZySjS+GuH51iRYEtWpVlMPTqW9
         U5gItI0/rvhDWXWBSa0SMZNqwdysynD6LhqX84SvnNkBk+zWvV8ArIMnrYWTWVyqDojM
         GtdYN+TehUP1b9mwBeN1snu5Rk6tHA0eq6V1W4DblADlIddcAJllqCWZaW34CZUeoP5S
         TTglt7Hz5thFncRnDsOg0zxzAcyov99SLxk0pbhPTP4R5jh19C1aNmE1wcx93UxEx6fJ
         7K37K/Da6eQVnx2tYotE/7pD43Rj1+5vBMOVTKvvPIr20KNj1FRJUOceFPeUhutwO5X7
         qovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686759486; x=1689351486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqZ5IpvvmpQbJ1zzadm9lsilhVlagwH9wED8wa6qKyk=;
        b=A/ExxQ6vdh7FByPJRr6Rq/Ecxr7KZs1DeudbWaEQJRolmkQabxwLWQKT5CZ2s+NPCB
         6l5GOkIl/N5kSgkCiCflE6YKTwNj25yM+PHPJ5uuzyJ3geUVPkDUwFCDDth7p0rskLIt
         02Oasj98B8+2u8QFMiffXK5nJD7vKw75/C2dXMfVah0XppSalHXvuipIGJHDdM5GywFR
         jsnI2K6jR1Zhx+zvo+eJLYADPrBuHQz7SvGvFurnQ1zPcUYMT5GlsOoIVfhYgaxMeYbM
         /vLEcUurQtxtkSKL8OZLl2xz2LlfNzUXJfe2lZ4jxQsAxiPc6wrMzxJtMs2wviF4meh+
         sPKw==
X-Gm-Message-State: AC+VfDyozaswnrDQ4MdJ8MgRatOlcMnXea2cNb2sjQB5o57y05D6C5AX
        GoalpsNlmAqTALuRUB7Sv4pEL51DLymI9ezMKcHTog==
X-Google-Smtp-Source: ACHHUZ4T7QMUba26lRFayVBzKQdCxI1brJ81aRWNBFfCUqmdZDfLVwDazHkjAEg8Z171WQ5oQkD4ady8X/LpgmJXumY=
X-Received: by 2002:a67:d088:0:b0:43b:2f4d:2467 with SMTP id
 s8-20020a67d088000000b0043b2f4d2467mr7412759vsi.29.1686759485808; Wed, 14 Jun
 2023 09:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230613153415.350528-1-apatel@ventanamicro.com>
 <20230613153415.350528-7-apatel@ventanamicro.com> <ZInSqC6b7RPD1nzX@ziepe.ca>
In-Reply-To: <ZInSqC6b7RPD1nzX@ziepe.ca>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 14 Jun 2023 21:47:53 +0530
Message-ID: <CAK9=C2XBObBGh2R2pxVgM0E1gFPBn4m7DKzoTxEmDdZ9V1QLrA@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] irqchip/riscv-imsic: Improve IOMMU DMA support
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        Vincent Chen <vincent.chen@sifive.com>
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

On Wed, Jun 14, 2023 at 8:16=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Jun 13, 2023 at 09:04:11PM +0530, Anup Patel wrote:
> > We have a separate RISC-V IMSIC MSI address for each CPU so changing
> > MSI (or IRQ) affinity results in re-programming of MSI address in
> > the PCIe (or platform) device.
> >
> > Currently, the iommu_dma_prepare_msi() is called only once at the
> > time of IRQ allocation so IOMMU DMA domain will only have mapping
> > for one MSI page. This means iommu_dma_compose_msi_msg() called
> > by imsic_irq_compose_msi_msg() will always use the same MSI page
> > irrespective to target CPU MSI address. In other words, changing
> > MSI (or IRQ) affinity for device using IOMMU DMA domain will not
> > work.
>
> You didn't answer my question from last time - there seems to be no
> iommu driver here so why are you messing with iommu_dma_prepare_msi()?
>
> This path is only for platforms that have IOMMU drivers that translate
> the MSI window. You should add this code to link the interrupt
> controller to the iommu driver when you introduce the iommu driver,
> not in this series?
>
> And, as I said before, I'd like to NOT see new users of
> iommu_dma_prepare_msi() since it is a very problematic API.
>
> This hacking of it here is not making it better :(

I misunderstood your previous comments.

We can certainly deal with this later when the IOMMU
driver is available for RISC-V. I will drop this patch in the
next revision.

Regards,
Anup
