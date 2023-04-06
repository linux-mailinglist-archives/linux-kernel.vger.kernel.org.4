Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C7D6D903A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbjDFHMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbjDFHMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:12:19 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3252E55;
        Thu,  6 Apr 2023 00:12:17 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 91E2E5C0096;
        Thu,  6 Apr 2023 03:12:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 06 Apr 2023 03:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680765135; x=1680851535; bh=IHLCbFaBZU/91yw5kszxiEKx+gZnH+tjq4Y
        W7whSqlQ=; b=ifCm37L0/5FfP5o7BgNK08W2hQLkUugFk1CNrH3YB9Qa6L7/L4X
        g6pIx1Z9yAidTl69rRsEsNMy8d2/pEeFVMVCr3WghzwjNR/ClH6yfDTrru3E25DQ
        pRjr8B0AS0qDQrc+O7GDIzTTCkXSSwQP3cjoDYC77Tcjrgfas1Unib7YLmt0ILus
        iUu1lpBuvYe0EMezQVOxxFx/lBKpDavRJ4EL7Ypctsh68Ko3ylE8WbPc4n7xpVx9
        0qcfat0eB9qEP9HQglrE+hybwzdai2BU2oOzykF4RuYggsR62gbOihMjNzF9p1vA
        5kY9RcRS+LedvSCpG3VX/qFzJD9X3uWLWtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680765135; x=1680851535; bh=IHLCbFaBZU/91yw5kszxiEKx+gZnH+tjq4Y
        W7whSqlQ=; b=WrvZiGgVOFnTKDCWxuJFTBHt8N/AeSE5z3FRbhBIa7sN46gsa5N
        guiWdekavibjbMhYD1J3z4mqe8+OtvaLq0I4KiFPNzNuk/a/GJsyExdBCr4ETZyO
        h/76CjDCUtepGCA86Xfy7coofV1iqBTKal4UkoaeplXzLluztRmQC20KS4Ndeaus
        VNZUeaNeCV8VHZYMONsv9jNbUuSTG1oFHFHdfVTo1URiPJ8L8kkqiyp9pRQjDipH
        fAevElt/AGzYSiYS5lGiFPJBc+uR17hpVFYjujC499lc7XOoxhSHufXwWm7piVIy
        AV9iOfC8ebqMLfubzHlxUqo70Sh3qfreO7g==
X-ME-Sender: <xms:znAuZO4U5IbX8CQzQqzzH_4PxcAql6S_zxhG7DR2fYxYQbMYEHnj7g>
    <xme:znAuZH7ZSFFZXLJW3NRRvdTkvQoTHUYqVJQ2QDw14IsMqR0muqtIabdIqJQVIwLV1
    wGRMEdcd3oLJ1n94-M>
X-ME-Received: <xmr:znAuZNcm9MphzTrenf1JAx56T4hGpEet7gX00Tr-fFJxMBHfEBcXl0Ca1-Ar8NjGwcPW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejvddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedutdejffetteefkeejieehfeeuieeguedtveeijeeviefh
    ffelvdfgudeihfdvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:znAuZLIf8Um38yCDigq3NfEJ8zMCVUE-_iqVAEccn6EMqyDtMVCRfQ>
    <xmx:znAuZCIvgO4l_vb9ZM7nTIEB6wDOu7Jaf3njnDJE-cYwcxY6RKt33w>
    <xmx:znAuZMw5KydGXL3bON8w0ZszqoT6wuVIMWtHI2lo3lRgw0kJ9IE7Cg>
    <xmx:z3AuZECSnkJC1VPcrhvgTd2MszZ3G7EGxLvYt7fE0Ft0qDADXH4VQw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Apr 2023 03:12:12 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v4 0/3] Use dma_default_coherent for devicetree default
 coherency
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230401091531.47412-1-jiaxun.yang@flygoat.com>
Date:   Thu, 6 Apr 2023 08:12:01 +0100
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>, m.szyprowski@samsung.com,
        Robin Murphy <robin.murphy@arm.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <C51B954E-FA96-450D-BB4F-D8D9D1FFC525@flygoat.com>
References: <20230401091531.47412-1-jiaxun.yang@flygoat.com>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B44=E6=9C=881=E6=97=A5 10:15=EF=BC=8CJiaxun Yang =
<jiaxun.yang@flygoat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi all,
>=20
> This series split out second half of my previous series
> "[PATCH 0/4] MIPS DMA coherence fixes".
>=20
> It intends to use dma_default_coherent to determine the default =
coherency of
> devicetree probed devices instead of hardcoding it with Kconfig =
options.
>=20
> For some MIPS systems, dma_default_coherent is determined with either
> bootloader or hardware registers in platform initilization code, and =
devicetree
> does not explicility specify the coherency of the device, so we need =
the ability
> to change the default coherency of devicetree probed devices.
>=20
> For other platforms that supports noncoherent, dma_default_coherent is =
a fixed
> value set by arch code. It's defaulted to false for most archs except =
RISC-V
> and powerpc in some cases.

Ping.

Is there any issue remain in this series?

Thanks
Jiaxun

>=20
> Thanks
> - Jiaxun
> ---
> v2:
>  - Add PATCH 1 to help with backporting
>  - Use Kconfig option to set dma_default_coherent=20
>=20
> v3:
>  - Style fixes
>  - Squash setting ARCH_DMA_DEFAULT_COHERENT into PATCH 4
>  - Setting ARCH_DMA_DEFAULT_COHERENT for PowerPC
>=20
> v4:
>  - Drop first patch
>=20
> Jiaxun Yang (3):
>  dma-mapping: Provide a fallback dma_default_coherent
>  dma-mapping: Provide CONFIG_ARCH_DMA_DEFAULT_COHERENT
>  of: address: Always use dma_default_coherent for default coherency
>=20
> arch/powerpc/Kconfig        | 2 +-
> arch/riscv/Kconfig          | 2 +-
> drivers/of/Kconfig          | 4 ----
> drivers/of/address.c        | 2 +-
> include/linux/dma-map-ops.h | 2 ++
> kernel/dma/Kconfig          | 7 +++++++
> kernel/dma/mapping.c        | 6 +++++-
> 7 files changed, 17 insertions(+), 8 deletions(-)
>=20
> --=20
> 2.39.2 (Apple Git-143)
>=20

