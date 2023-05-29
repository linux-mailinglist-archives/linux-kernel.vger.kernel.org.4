Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A3B714A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjE2Nbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2Nb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:31:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D644C90
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:31:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72DEF61853
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 13:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9D3C433EF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685367085;
        bh=gai7gg0nc2XAlnjc330+sTNAq2Dcj7WxQOfnyM5Av1E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fa+xbQq1IBIaAgWAroL1Q9UyEs6LTvXkBgOhHCWWGjO58BzCpvltVxbI2oWa4H6rM
         +ayrZRhUsVdPIQjH0x27adEBxWda+kqQopk3qi8RDrnfn504ttclALlst03alq8xjK
         TSdJPKRAJz+NQfNDNJAxZ6H3WZqkCWNlr3ZDoij1/LqJcQ/58ceBJz7FIpdIjcL17i
         o9RYxgwxesu+3EvUgLLUksY3cMuMc9XlwodV8SpVPB3geNFEW1PmUvz1KCR8btc4bM
         B0N0cTTm+av2zfNDST8ZdkUZXqAtlG7BX8S/cESxiTxm88uWIS4fLZVmMufOEu4uwT
         Ga289QSyauarQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f4e71a09a7so3577583e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:31:25 -0700 (PDT)
X-Gm-Message-State: AC+VfDxEzDMi0yPw5VvVo8woG62cBZGgrjmDb0p0kIcgnqwCwrUfR68U
        FOUPr/dzNzM8jGy8avPwTSLWIvK2RsppMWY+ck4=
X-Google-Smtp-Source: ACHHUZ4WIrh5/v9Tee4hQx0CGiDeiFqWZcxoFne2Kqby2w4CTXMDqX2JXzPqCuqdv/IoPk7Pc8Cy21z3WwlJaC319VE=
X-Received: by 2002:ac2:5581:0:b0:4e8:487a:7c2e with SMTP id
 v1-20020ac25581000000b004e8487a7c2emr3007235lfg.14.1685367083877; Mon, 29 May
 2023 06:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230526121751.41060-1-lihuisong@huawei.com> <CAMj1kXHgPbzgPm1Sq5hqqz7RX6sj2axze5F+fvMyfPY=d9=Hhw@mail.gmail.com>
 <d180192a-afad-00dc-426f-3d8d249cdd89@huawei.com>
In-Reply-To: <d180192a-afad-00dc-426f-3d8d249cdd89@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 29 May 2023 15:31:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHk-HTmJzovMFiYStZeZiehS2n01rhGeyOYF_wCn0sHbg@mail.gmail.com>
Message-ID: <CAMj1kXHk-HTmJzovMFiYStZeZiehS2n01rhGeyOYF_wCn0sHbg@mail.gmail.com>
Subject: Re: [PATCH] arm64: acpi: Export symbol for acpi_os_ioremap
To:     "lihuisong (C)" <lihuisong@huawei.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>,
        catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
        rafael.j.wysocki@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        wangkefeng.wang@huawei.com, liuyonglong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023 at 15:12, lihuisong (C) <lihuisong@huawei.com> wrote:
>
>
> =E5=9C=A8 2023/5/26 20:39, Ard Biesheuvel =E5=86=99=E9=81=93:
> > (cc Lorenzo)
> >
> > On Fri, 26 May 2023 at 14:20, Huisong Li <lihuisong@huawei.com> wrote:
> >> The driver who calls the acpi_os_ioremap() cannot be compiled if the '=
M'
> >> is selected for the driver. The compiling log is as follows:
> >> -->
> >> MODPOST Module.symvers
> >> ERROR: modpost: "acpi_os_ioremap" [drivers/soc/hisilicon/xxx.ko] undef=
ined!
> >> scripts/Makefile.modpost:136: recipe for target 'Module.symvers' faile=
d
> >> make[1]: *** [Module.symvers] Error 1
> >>
> >> So this patch exports symbol for acpi_os_ioremap.
> >>
> > That driver does not exist in mainline.
>
> We have an uploading driver [1] that may use it.
>
> [1]
> https://patchwork.kernel.org/project/linux-soc/patch/20230522072211.8894-=
2-lihuisong@huawei.com/
>
> >
> > Why does it need to use acpi_os_ioremap() instead of the ordinary
> > memremap/ioremap routines?
> This driver needs to ioremap the shared memory space of a PCC subspace.
> And @Sudeep suggested that we use this interface.
> It is suitable here.

I disagree. acpi_io_ioremap() is internal arch plumbing for the ACPI
subsystem. I don't see why we should use it here.

On arm64, acpi_os_ioremap() cross references the EFI memory map to
figure out whether a physical region is memory or device, but a driver
should already know that.




> >
> >> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> >> ---
> >>   arch/arm64/kernel/acpi.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> >> index dba8fcec7f33..ec0414caf3d1 100644
> >> --- a/arch/arm64/kernel/acpi.c
> >> +++ b/arch/arm64/kernel/acpi.c
> >> @@ -354,6 +354,7 @@ void __iomem *acpi_os_ioremap(acpi_physical_addres=
s phys, acpi_size size)
> >>          }
> >>          return ioremap_prot(phys, size, pgprot_val(prot));
> >>   }
> >> +EXPORT_SYMBOL(acpi_os_ioremap);
> >>
> >>   /*
> >>    * Claim Synchronous External Aborts as a firmware first notificatio=
n.
> >> --
> >> 2.33.0
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > .
