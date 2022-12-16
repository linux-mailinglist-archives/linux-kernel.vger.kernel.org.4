Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB05764E5A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiLPBcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLPBcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:32:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5631D654D3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 17:32:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E549AB81D11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 01:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897D3C43398
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 01:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671154337;
        bh=WWdQKzHA8nf22v/OFQFI1ds1vcA1UIuh7vvuZYDECOo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nCvaCS6gHauVcBnVZfKURpicxhfn6G/YiBVLvNYVEhlboSe3tt6CkCOb2d9V7oWAd
         gFMyeW9YkLwNH3Ivsu3vHl0iEzbbEXr3CuqgvhFllbiXBrd4brWuM2MvFIO368vk98
         KSufTeTdJVrOg5YvbCLnmu9FgrLaDneKCi5xvF6mJmdgOLB9hPuhJlG97U3GozqbNL
         HdLyYdaGSgV9pD9ploRUbnd04XLQ9i2lKVwa3KUdkgEnS3X6jbvSiM7co2dHs96TB0
         LTQr/Oa8TtTA8DRMp6qPGmYutjdRrN+AoAzuZhXQVIs8gHtIe29Gy57+yejmobNEWF
         ujPpuADwbP9Qg==
Received: by mail-ed1-f46.google.com with SMTP id s5so1659232edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 17:32:17 -0800 (PST)
X-Gm-Message-State: ANoB5pkEIqgVfovpK4dHYAZtmGgtM5Z+GYTQtoNmoAfxcm6qlS6DNahi
        TUmzpV4ic01VX7BkdVrXcmqbxYcBziwFKSnwqt4=
X-Google-Smtp-Source: AA0mqf42YLAwQARhvxsf7dGvS0oc39aHHg/VjrmuoPl5AnlSakaRzEm4vNH6yBmh16Vo+BrOSyi3tz/l6+TpkPFOfQ4=
X-Received: by 2002:aa7:db07:0:b0:470:44da:db04 with SMTP id
 t7-20020aa7db07000000b0047044dadb04mr1540957eds.419.1671154335559; Thu, 15
 Dec 2022 17:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20221215073212.1966823-1-guoren@kernel.org> <c10c9742-06d6-f56b-ea55-47f99b06ca32@arm.com>
In-Reply-To: <c10c9742-06d6-f56b-ea55-47f99b06ca32@arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 16 Dec 2022 09:32:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRHjhCzDT4J1F=zjcB0Mx+w+Ok0JYuuqorxgnw+KODnDA@mail.gmail.com>
Message-ID: <CAJF2gTRHjhCzDT4J1F=zjcB0Mx+w+Ok0JYuuqorxgnw+KODnDA@mail.gmail.com>
Subject: Re: [PATCH] iommu/renesas: Support riscv compile
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     palmer@dabbelt.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        iommu@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 1:16 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-12-15 07:32, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > After riscv selects ARCH_RENESAS, we need to add ARM64 || ARM
> > dependency here.
>
> This effectively removes all the extra COMPILE_TEST coverage we've been
> enjoying. FWIW I prefer Geert's suggestion to separate the real
> functional dependency from implicit assumptions about ARCH_RENESAS, with
> something like:
>
>         depends on ARCH_RENESAS || COMPILE_TEST
>         depends on !GENERIC_ATOMIC64    #for IOMMU_IO_PGTABLE_LPAE

The problem is from clang version 16.0.0, and gcc version 12.2.0 () is
okay. I didn't recognize COMPILE_TEST could utilize the x86(another
arch) to test the arm driver.

How About:

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dc5f7a156ff5..a2e259da5a6a 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -283,6 +283,7 @@ config EXYNOS_IOMMU_DEBUG

 config IPMMU_VMSA
        bool "Renesas VMSA-compatible IPMMU"
+       depends on !RISCV
        depends on ARCH_RENESAS || (COMPILE_TEST && !GENERIC_ATOMIC64)
        select IOMMU_API
        select IOMMU_IO_PGTABLE_LPAE

>
> Thanks,
> Robin.
>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >   drivers/iommu/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index dc5f7a156ff5..746b95b9f345 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -283,6 +283,7 @@ config EXYNOS_IOMMU_DEBUG
> >
> >   config IPMMU_VMSA
> >       bool "Renesas VMSA-compatible IPMMU"
> > +     depends on ARM64 || ARM
> >       depends on ARCH_RENESAS || (COMPILE_TEST && !GENERIC_ATOMIC64)
> >       select IOMMU_API
> >       select IOMMU_IO_PGTABLE_LPAE



--
Best Regards
 Guo Ren
