Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1D972DBA3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbjFMH4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240274AbjFMHzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:55:54 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF6810E3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:55:53 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bcad7f7dabcso1530103276.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686642953; x=1689234953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqkMTpZSPTrtiBwrlg2HB9jORG0uNI2X+Q54yKxHyHA=;
        b=X1lH0zTSm/2trYaS1XeQ55Q9hA/9/r0gKILDhIP3BM1V9j/9FcNnlTg8C6eqes6MhY
         kEEujrjfs/bXMw2MXXaDIEhSffQ3ZxmyyehIWQMaGdQ83t9lijLU+cai3uaF5ZNQ3hJ1
         U4h+mNKlmJ4enUA0b9qIy8BcA850nZF9q8DNphIsqHIDVsbimRdE1m2LdXqy6pRLVSor
         CuNaeb3ZHWvaqWp2UlX8SxpNaeTb54BL1Y6A72HUI8F4MxEPteEgE7OxPWAGRl2KwREW
         FSjlxEtmon50dMqJgkzch8RTCiRJz+wMgeMWSkqDFbH4doZHuoKH0L9GHXdRo8TV+x0S
         4DDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686642953; x=1689234953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqkMTpZSPTrtiBwrlg2HB9jORG0uNI2X+Q54yKxHyHA=;
        b=YYg/3o34xGy0N2foTsDR8jIFFY2PSLtBoBczXkWSpcysdGpMlnaeTMBtUX2g7vJW+X
         Ng1URThGgSAi/XNQvQshiA3A4/IZ1zvbsrt+qjh3pM8y0VoMmb0DO5jzSgXvTs1CMj45
         jbOMd/f8P/85l10U6UztzFh3aWbZphrC5psrZnRITCU/tG2C8ysX9bjQHee/gB3Uw6fF
         HmBwicX01XI7t34Ncl3u3Vs2A7rXEBd4YZw9mlC93EwNTHxPQsXKuQ+gfeGgMVwqdVxL
         B86JMjI0UuLH/s73dNHXu5JEBRqR/pv5SUsSqnoWZwPZFzJalfp/tqVJ8QIgI6TBW+TW
         +Kmg==
X-Gm-Message-State: AC+VfDx7m2cN8Q137TccS07owv506iPmeer/C/aj9b0V3Oq8VzcwgDvf
        ndhBLdZaKSxF4f0qFs1aaMJAT1B48+2QcNkfXpEnrA==
X-Google-Smtp-Source: ACHHUZ7O4IuL4c5Qy6TEcv499ftciQaYRXdKcvbuS5ivN5I0ThoFAm05aH64SAu17/J52IMOAeGVAiqoO7kjJSXAUJs=
X-Received: by 2002:a0d:fd83:0:b0:56d:4014:dd20 with SMTP id
 n125-20020a0dfd83000000b0056d4014dd20mr982407ywf.30.1686642952928; Tue, 13
 Jun 2023 00:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-8-apatel@ventanamicro.com> <ZGIrOKIT8uHcNqbQ@nvidia.com>
In-Reply-To: <ZGIrOKIT8uHcNqbQ@nvidia.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 13 Jun 2023 13:25:41 +0530
Message-ID: <CAK9=C2V9o4FsFXAfRHLGSuJaDubwM_HSL7keTYeWb_vFDNLd7g@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] irqchip/riscv-imsic: Improve IOMMU DMA support
To:     Jason Gunthorpe <jgg@nvidia.com>
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
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 6:23=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, May 08, 2023 at 07:58:38PM +0530, Anup Patel wrote:
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
> >
> > To address above issue, we do the following:
> > 1) Map MSI pages for all CPUs in imsic_irq_domain_alloc()
> >    using iommu_dma_prepare_msi().
> > 2) Add a new iommu_dma_select_msi() API to select a specific
> >    MSI page from a set of already mapped MSI pages.
> > 3) Use iommu_dma_select_msi() to select a specific MSI page
> >    before calling iommu_dma_compose_msi_msg() in
> >    imsic_irq_compose_msi_msg().
>
> Is there an iommu driver somewhere in all this? I don't obviously see
> one?

Sorry for the delayed response.

The RISC-V IOMMU specification is frozen and will be ratified/released
anytime this month or next.
https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0-rc6/ris=
cv-iommu.pdf

The RISC-V IOMMU driver will be send-out on LKML pretty soon
https://github.com/tjeznach/linux/tree/tjeznach/riscv-iommu
which can be tested on QEMU
https://github.com/tjeznach/qemu/tree/tjeznach/riscv-iommu

>
> There should be no reason to use the dma-iommu.c stuff just to make
> interrupts work, that is only necessary if there is an iommu, and the
> platform architecture requires the iommu to have the MSI region
> programmed into IOPTEs.
>
> And I'd be much happier if we could clean this design up before risc-v
> starts using it too :\
>

Sure, I will send-out v4 in the next few days.

Regards,
Anup
