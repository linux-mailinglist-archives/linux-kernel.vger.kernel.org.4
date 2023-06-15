Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42722730EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjFOFqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFOFqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:46:50 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53871BEC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 22:46:48 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so697664276.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 22:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686808008; x=1689400008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4BBZdcwV53I4/SexLSk4m4e3GYSRd1uRKWHBlB/d9A=;
        b=UCpwqoTDu/DROrJquC1iaX7jIAVfquVUK6sURGuKJtxmN9g4RKtD00nto+vvsS8bNp
         oKbK8Y+RXJKKxH4f6u6caNxlKAG/AeQYQTFTIE75tNmOhPEd9IMFwtSOaoPgEfwZtAFP
         0jQj9J/BXTtj7MHcewu/5cBMRHZzzI2y+9/jGHd6knT98/9bBKLBsMO0LOZmRQjvFkfM
         UJ3CFb7GECyuOK7+34bZMWwtncdS6fZ0xfPvc8zd+4V22sN1LESqOE0EfWkHBkt5HF85
         xqcEhQa87H/PJxBncJy+DmQvK0yhYTj4LMeZw45Hk2jZsgiu92DYgaR+FrH5BTywvV3C
         mHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686808008; x=1689400008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4BBZdcwV53I4/SexLSk4m4e3GYSRd1uRKWHBlB/d9A=;
        b=Pcu3mtn8UDyPjF0EkcqPjQRpJSb3zXt3XkqzGJqyhpwH8526WYQ0pZol6K1+IAkPxv
         f/Q7I0doEacMnwj97Wg7ooOWnuomzTwJ0y5W38Gfg42yhrvhUy+dfopm+5LrRyFMVF4E
         OAPqAERKPFI/b0t0Cyxgv8Y66frqtg1htnIBu9tuKegESPznr0uygHW1BSBeMljQTtcR
         7s6WiLPnJ7CNjj67qScnm5Y3oViSreKaFKt7/qwJQrqnFONanhufOv3v2D/QLRdp8t0P
         1y4YEK9InSrSKAmGi+WPOhJZOVeveCHxlyq5ctnzdE1tATa1rUBrXPojVvicJ9OLwjav
         bs3g==
X-Gm-Message-State: AC+VfDxpL6XungJYNDN6dpLBvExYc+u2TuYW0blgDNHfhlL8kD4GU0Ng
        EgzZUX31Wnv19EFV3luj6DnTj7dkdd7KbViF0pSpdg==
X-Google-Smtp-Source: ACHHUZ672iNfzCBweTy9QLV/i/rzr5Vs6Tq41Zax9L7mWUr9BNqjo0vzLUUxM2G49aQFlhWghyl53s3wEwbXOODugyU=
X-Received: by 2002:a25:da84:0:b0:ba9:b304:107b with SMTP id
 n126-20020a25da84000000b00ba9b304107bmr4885752ybf.27.1686808007846; Wed, 14
 Jun 2023 22:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230613153415.350528-1-apatel@ventanamicro.com>
 <20230613153415.350528-7-apatel@ventanamicro.com> <ZInSqC6b7RPD1nzX@ziepe.ca>
 <CAK9=C2XBObBGh2R2pxVgM0E1gFPBn4m7DKzoTxEmDdZ9V1QLrA@mail.gmail.com> <ZInvvMZvrP4U/LL+@ziepe.ca>
In-Reply-To: <ZInvvMZvrP4U/LL+@ziepe.ca>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 15 Jun 2023 11:16:35 +0530
Message-ID: <CAK9=C2XKg5jBxBtrWMvQP--8Yb4ACFZFyX4wrtLy1efH7hO9ow@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:20=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Wed, Jun 14, 2023 at 09:47:53PM +0530, Anup Patel wrote:
> > On Wed, Jun 14, 2023 at 8:16=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Tue, Jun 13, 2023 at 09:04:11PM +0530, Anup Patel wrote:
> > > > We have a separate RISC-V IMSIC MSI address for each CPU so changin=
g
> > > > MSI (or IRQ) affinity results in re-programming of MSI address in
> > > > the PCIe (or platform) device.
> > > >
> > > > Currently, the iommu_dma_prepare_msi() is called only once at the
> > > > time of IRQ allocation so IOMMU DMA domain will only have mapping
> > > > for one MSI page. This means iommu_dma_compose_msi_msg() called
> > > > by imsic_irq_compose_msi_msg() will always use the same MSI page
> > > > irrespective to target CPU MSI address. In other words, changing
> > > > MSI (or IRQ) affinity for device using IOMMU DMA domain will not
> > > > work.
> > >
> > > You didn't answer my question from last time - there seems to be no
> > > iommu driver here so why are you messing with iommu_dma_prepare_msi()=
?
> > >
> > > This path is only for platforms that have IOMMU drivers that translat=
e
> > > the MSI window. You should add this code to link the interrupt
> > > controller to the iommu driver when you introduce the iommu driver,
> > > not in this series?
> > >
> > > And, as I said before, I'd like to NOT see new users of
> > > iommu_dma_prepare_msi() since it is a very problematic API.
> > >
> > > This hacking of it here is not making it better :(
> >
> > I misunderstood your previous comments.
> >
> > We can certainly deal with this later when the IOMMU
> > driver is available for RISC-V. I will drop this patch in the
> > next revision.
>
> Not only just this patch but the calls to iommu_dma_prepare_msi() and
> related APIs in the prior patch too. Assume the MSI window is directly
> visible to DMA without translation.

Okay, I will remove iommu_dma_xyz() usage from IMSIC driver in the
next revision.

>
> When you come with an iommu driver we can discuss how best to proceed.

Yes, that's better.

Regards,
Anup
