Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBCF7126D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243318AbjEZMj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjEZMjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:39:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745D89E
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 040BE64FA5
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33198C4339C
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685104763;
        bh=qVWtLrpqxSAMuoK+Blatuo1LfDx/QcUFLtFcz/XngQ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fPbF1xT56I/xjLLwnFt08KsRVGxjeR70URcD7RlZyLyGqE7PkQ1kc/Hx2LtPcDL4R
         eHMuLzy5/PrY7vNjYAT/GtpJDjsGXOGGT7xpSboGALW1ha5mZRLlrOfpv6J6mOx4Mq
         pFlLUSRNw5i4EFyFWZYGX/IlZPb0lA6TxD7LfrPMHSqHz9gyq3iTMClkhSB1ZajNzA
         u2lebFLQBkaw7Djw4xUH8CAhwKPsIUl2GcWKChFFSahuYsHZEzyQe0s2Aoxt9RPqib
         HyGOJA0rHv9Nty+AE4ri/XjEJ34Gwc3tV7DXBsRVXPSwHmxcpE2vOTBWgkKTB8NmYJ
         DxipG2B+K7lRA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f122ff663eso706858e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:39:23 -0700 (PDT)
X-Gm-Message-State: AC+VfDx+eFh0HiANNFEvI2KBnGBZNv0ofueiErfDdYG+zUrDqS9k+21x
        L/4N+2JXGrH1yOcgsoghxBPphH3NpsNFfudnxNs=
X-Google-Smtp-Source: ACHHUZ5SuVphec9jazAFzKSa82E3QpzHzyFYAhQ7Z2rGPsCl0TEM+26kA3WWLnUMJUAKlMgmNrOxQpbw6saiGq2NAt0=
X-Received: by 2002:ac2:443c:0:b0:4e9:9f10:b31d with SMTP id
 w28-20020ac2443c000000b004e99f10b31dmr458171lfl.2.1685104761274; Fri, 26 May
 2023 05:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230526121751.41060-1-lihuisong@huawei.com>
In-Reply-To: <20230526121751.41060-1-lihuisong@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 26 May 2023 14:39:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHgPbzgPm1Sq5hqqz7RX6sj2axze5F+fvMyfPY=d9=Hhw@mail.gmail.com>
Message-ID: <CAMj1kXHgPbzgPm1Sq5hqqz7RX6sj2axze5F+fvMyfPY=d9=Hhw@mail.gmail.com>
Subject: Re: [PATCH] arm64: acpi: Export symbol for acpi_os_ioremap
To:     Huisong Li <lihuisong@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
        rafael.j.wysocki@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        wangkefeng.wang@huawei.com, liuyonglong@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc Lorenzo)

On Fri, 26 May 2023 at 14:20, Huisong Li <lihuisong@huawei.com> wrote:
>
> The driver who calls the acpi_os_ioremap() cannot be compiled if the 'M'
> is selected for the driver. The compiling log is as follows:
> -->
> MODPOST Module.symvers
> ERROR: modpost: "acpi_os_ioremap" [drivers/soc/hisilicon/xxx.ko] undefined!
> scripts/Makefile.modpost:136: recipe for target 'Module.symvers' failed
> make[1]: *** [Module.symvers] Error 1
>
> So this patch exports symbol for acpi_os_ioremap.
>

That driver does not exist in mainline.

Why does it need to use acpi_os_ioremap() instead of the ordinary
memremap/ioremap routines?


> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  arch/arm64/kernel/acpi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index dba8fcec7f33..ec0414caf3d1 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -354,6 +354,7 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>         }
>         return ioremap_prot(phys, size, pgprot_val(prot));
>  }
> +EXPORT_SYMBOL(acpi_os_ioremap);
>
>  /*
>   * Claim Synchronous External Aborts as a firmware first notification.
> --
> 2.33.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
