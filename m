Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CD866BCEC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjAPLaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjAPL3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:29:55 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1495A1DBBA;
        Mon, 16 Jan 2023 03:29:53 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b3so42286071lfv.2;
        Mon, 16 Jan 2023 03:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c0omghU3YPaulzZKq7VYOEmDBUCRJtzZ943E4nh9lWI=;
        b=PQlykLLQJfUZeo/V7fn1DVvjaYGw0zm+9/W5VSVERz7DG67/V2ZHyDE82oEZS0c4aM
         lcb3IUqmarU/nZ7Tn7ivFtK/+bXOYPHEjH7/UIZ6Y2Wb3BV+16LZnTST2M66Jcjxdbgt
         2mfHI/Ou23eissFB4Dtvak+DUk2j/8a40rb0ClsMwXpDSXsljBo0l3avWKAQZMj9ppJu
         EHq76mbvgF4ZGlSuQN+BkPLuv2PWYv1xFl9m1HmfwO5MjSfXl6mB+5BBV8F0pA4wx/HP
         dGkn4EJRFPvTwbUUvSX1kjcXRcWRS2zKDBWA25IDpIOteGmI34iTLoKovSBnyc0s1v56
         kCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0omghU3YPaulzZKq7VYOEmDBUCRJtzZ943E4nh9lWI=;
        b=bdzOU0yr9WgpUmzoIIxKBV1RSfl7zCAUzYy/tN+0R4cEd6zURifedX8qEVu+YOpFsR
         UfMOj/dUMD6t64wqEoVCOi4XkkGbJi/IjzWxEeYIwr0Nfdc4hrtbszZXqdAm9rkKuS6/
         U4e6NdVOfnBRujRfHoBsCowgq2U1QwDMoWwopLWGnYx+TBP3YCfmMmnit/O5SCLa1kSt
         mT4L/3rJepXd0IxqcjS7mGQxsntjJs+w3q70ukKYne/oPdQboQeUMV9WcmPzSBbj8C4I
         5GBIG1fTpHYUKdXsk8DdiddaIRHqBS4oYP2pjxxlpExK9v2kyDXajAzwMD2m8K7AigdD
         R/Dw==
X-Gm-Message-State: AFqh2kouesnmTceLZwczq8Lp4hHiO13+uLE0vCCVOxRs5igsO5R7EFrC
        rlhrZwfx+khT+4Jr8nE+/BU=
X-Google-Smtp-Source: AMrXdXs8vtbJDENgKmn2dVkHwf/JBhGa8kUljb2XfKEckHG6V8r0/ys4YsYmc3o0NXdXEdROJ0higw==
X-Received: by 2002:a19:6917:0:b0:4a4:68b7:dedb with SMTP id e23-20020a196917000000b004a468b7dedbmr2421098lfc.55.1673868591179;
        Mon, 16 Jan 2023 03:29:51 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id b9-20020a056512218900b004b57162edfasm4975482lft.117.2023.01.16.03.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 03:29:50 -0800 (PST)
Date:   Mon, 16 Jan 2023 14:29:48 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 00/27] dmaengine: dw-edma: Add RP/EP local DMA
 controllers support
Message-ID: <20230116112948.hq2hdy45c3ymkcc3@mobilestation>
References: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
 <Y8UeXRUnLVtl1unZ@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8UeXRUnLVtl1unZ@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 10:52:29AM +0100, Lorenzo Pieralisi wrote:
> On Fri, Jan 13, 2023 at 08:13:42PM +0300, Serge Semin wrote:
> > This is a final patchset in the series created in the framework of
> > my Baikal-T1 PCIe/eDMA-related work:
> > 
> > [1: Done v5] PCI: dwc: Various fixes and cleanups
> > Link: https://lore.kernel.org/linux-pci/20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru/
> > Merged: kernel 6.0-rc1
> > [2: Done v4] PCI: dwc: Add hw version and dma-ranges support
> > Link: https://lore.kernel.org/linux-pci/20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru/
> > Merged: kernel 6.0-rc1
> > [3: Done v7] PCI: dwc: Add generic resources and Baikal-T1 support
> > Link: https://lore.kernel.org/linux-pci/20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru/
> > Merged: kernel 6.2-rc1
> > [4: In-review v9] dmaengine: dw-edma: Add RP/EP local DMA controllers support
> > Link: ---you are looking at it---
> > 
> > Note it is very recommended to merge the patchsets in the same order as
> > they are listed in the set above in order to have them applied smoothly.
> > Since the patchsets 1-3 have already been merged into the mainline kernel
> > this series can be applied via any DMA-engine or PCI repos.
> > 
> > Here is a short summary regarding this patchset. The series starts with
> > fixes patches. We discovered that the dw-edma-pcie.c driver incorrectly
> > initializes the LL/DT base addresses for the platforms with not matching
> > CPU and PCIe memory spaces. It is fixed by using the pci_bus_address()
> > method to get a correct base address. After that you can find a series of
> > the interleaved xfers fixes. It turned out the interleaved transfers
> > implementation didn't work quite correctly from the very beginning for
> > instance missing src/dst addresses initialization, etc. In the framework
> > of the next two patches we suggest to add a new platform-specific
> > callback - pci_address() and use it to convert the CPU address to the PCIe
> > space address. It is at least required for the DW eDMA remote End-point
> > setup on the platforms with not-matching CPU/PCIe address spaces. In case
> > of the DW eDMA local RP/EP setup the conversion will be done automatically
> > by the outbound iATU (if no DMA-bypass flag is specified for the
> > corresponding iATU window). Then we introduce a set of the patches to make
> > the DebugFS part of the code supporting the multi-eDMA controllers
> > platforms. It starts with several cleanup patches and is closed joining
> > the Read/Write channels into a single DMA-device as they originally should
> > have been. After that you can find the patches with adding the non-atomic
> > io-64 methods usage, dropping DT-region descriptors allocation, replacing
> > chip IDs with the device name. In addition to that in order to have the
> > eDMA embedded into the DW PCIe RP/EP supported we need to bypass the
> > dma-ranges-based memory ranges mapping since in case of the root port DT
> > node it's applicable for the peripheral PCIe devices only. Finally at the
> > series closure we introduce a generic DW eDMA controller support being
> > available in the DW PCIe Root Port/Endpoint driver.
> > 
> > Link: https://lore.kernel.org/linux-pci/20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v2:
> > - Drop the patches:
> >   [PATCH 1/25] dmaengine: dw-edma: Drop dma_slave_config.direction field usage
> >   [PATCH 2/25] dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction semantics
> >   since they are going to be merged in in the framework of the
> >   Frank's patchset.
> > - Add a new patch: "dmaengine: dw-edma: Release requested IRQs on
> >   failure."
> > - Drop __iomem qualifier from the struct dw_edma_debugfs_entry instance
> >   definition in the dw_edma_debugfs_u32_get() method. (@Manivannan)
> > - Add a new patch: "dmaengine: dw-edma: Rename DebugFS dentry variables to
> >   'dent'." (@Manivannan)
> > - Slightly extend the eDMA name array size. (@Manivannan)
> > - Change the specific DMA mapping comment a bit to being
> >   clearer. (@Manivannan)
> > - Add a new patch: "PCI: dwc: Add generic iATU/eDMA CSRs space detection
> >   method."
> > - Don't fail eDMA detection procedure if the DW eDMA driver couldn't probe
> >   device. That happens if the driver is disabled. (@Manivannan)
> > - Add "dma" registers resource mapping procedure. (@Manivannan)
> > - Move the eDMA CSRs space detection into the dw_pcie_map_detect() method.
> > - Remove eDMA on the dw_pcie_ep_init() internal errors. (@Manivannan)
> > - Remove eDMA in the dw_pcie_ep_exit() method.
> > - Move the dw_pcie_edma_detect() method execution to the tail of the
> >   dw_pcie_ep_init() function.
> > 
> > Link: https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v3:
> > - Conditionally set dchan->dev->device.dma_coherent field since it can
> >   be missing on some platforms. (@Manivannan)
> > - Drop the patch: "PCI: dwc: Add generic iATU/eDMA CSRs space detection
> >   method". A similar modification has been done in another patchset.
> > - Add more comprehensive and less regression prune eDMA block detection
> >   procedure.
> > - Drop the patch: "dma-direct: take dma-ranges/offsets into account in
> >   resource mapping". It will be separately reviewed.
> > - Remove Manivannan tb tag from the modified patches.
> > - Rebase onto the kernel v5.18.
> > 
> > Link: https://lore.kernel.org/linux-pci/20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru
> > Changelog v4:
> > - Rabase onto the laters Frank Li series:
> > Link: https://lore.kernel.org/all/20220524152159.2370739-1-Frank.Li@nxp.com/
> > - Add Vinod' Ab-tag.
> > - Rebase onto the kernel v5.19-rcX.
> > 
> > Link: https://lore.kernel.org/linux-pci/20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru
> > Changelog v5:
> > - Just resend.
> > - Rebase onto the kernel v6.0-rc2.
> > 
> > Link: https://lore.kernel.org/linux-pci/20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru
> > Changelog v6:
> > - Fix some patchlog and in-line comments misspells. (@Bjorn)
> > - Directly call *_dma_configure() method on the DW eDMA channel child
> >   device used for the DMA buffers mapping. (@Robin)
> > - Explicitly set the DMA-mask of the child device in the channel
> >   allocation proecedure. (@Robin)
> > - Rebase onto the kernel v6.1-rc3.
> > 
> > Link: https://lore.kernel.org/linux-pci/20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v7:
> > - Activate the mapping auto-detection procedure for IP-cores older than
> >   5.40a. The viewport-based access has been removed since that
> >   version. (@Yoshihiro)
> > - Drop the patch
> >   [PATCH v6 22/24] dmaengine: dw-edma: Bypass dma-ranges mapping for the local setup
> >   since the problem has been fixed in the commit f1ad5338a4d5 ("of: Fix
> >   "dma-ranges" handling for bus controllers"). (@Robin)
> > - Add a new patch:
> >   [PATCH v7 23/25] PCI: dwc: Restore DMA-mask after MSI-data allocation
> >   (@Robin)
> > - Add a new patch:
> >   [PATCH v7 24/25] PCI: bt1: Set 64-bit DMA-mask
> >   (@Robin)
> > 
> > Link: https://lore.kernel.org/linux-pci/20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v8:
> > - Add a new patch:
> >   [PATCH v8 23/26] dmaengine: dw-edma: Relax driver config settings
> >   (@tbot)
> > - Replace the patch
> >   [PATCH v7 23/25] PCI: dwc: Restore DMA-mask after MSI-data allocation
> >   with a new one:
> >   [PATCH v8 24/26] PCI: dwc: Set coherent DMA-mask on MSI-address allocation
> >   (@Robin, @Christoph)
> > 
> > Link: https://lore.kernel.org/linux-pci/20221219144658.26620-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v9:
> > - Add a new patch:
> >   [PATCH v9 23/27] dmaengine: dw-edma: Add mem-mapped LL-entries support
> >   (@tbot)
> > - Rebase onto the kernel 6.2-rc3.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> > Cc: "Krzysztof Wilczyński" <kw@linux.com>
> > Cc: caihuoqing <caihuoqing@baidu.com>
> > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: dmaengine@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > 
> > Serge Semin (27):
> >   dmaengine: Fix dma_slave_config.dst_addr description
> >   dmaengine: dw-edma: Release requested IRQs on failure
> >   dmaengine: dw-edma: Convert ll/dt phys-address to PCIe bus/DMA address
> >   dmaengine: dw-edma: Fix missing src/dst address of the interleaved
> >     xfers
> >   dmaengine: dw-edma: Don't permit non-inc interleaved xfers
> >   dmaengine: dw-edma: Fix invalid interleaved xfers semantics
> >   dmaengine: dw-edma: Add CPU to PCIe bus address translation
> >   dmaengine: dw-edma: Add PCIe bus address getter to the remote EP
> >     glue-driver
> >   dmaengine: dw-edma: Drop chancnt initialization
> >   dmaengine: dw-edma: Fix DebugFS reg entry type
> >   dmaengine: dw-edma: Stop checking debugfs_create_*() return value
> >   dmaengine: dw-edma: Add dw_edma prefix to the DebugFS nodes descriptor
> >   dmaengine: dw-edma: Convert DebugFS descs to being kz-allocated
> >   dmaengine: dw-edma: Rename DebugFS dentry variables to 'dent'
> >   dmaengine: dw-edma: Simplify the DebugFS context CSRs init procedure
> >   dmaengine: dw-edma: Move eDMA data pointer to DebugFS node descriptor
> >   dmaengine: dw-edma: Join Write/Read channels into a single device
> >   dmaengine: dw-edma: Use DMA-engine device DebugFS subdirectory
> >   dmaengine: dw-edma: Use non-atomic io-64 methods
> >   dmaengine: dw-edma: Drop DT-region allocation
> >   dmaengine: dw-edma: Replace chip ID number with device name
> >   dmaengine: dw-edma: Skip cleanup procedure if no private data found
> >   dmaengine: dw-edma: Add mem-mapped LL-entries support
> >   dmaengine: dw-edma: Relax driver config settings
> >   PCI: dwc: Set coherent DMA-mask on MSI-address allocation
> >   PCI: bt1: Set 64-bit DMA-mask
> >   PCI: dwc: Add DW eDMA engine support
> > 
> >  drivers/dma/dw-edma/Kconfig                   |   5 +-
> >  drivers/dma/dw-edma/dw-edma-core.c            | 196 ++++-----
> >  drivers/dma/dw-edma/dw-edma-core.h            |  10 +-
> >  drivers/dma/dw-edma/dw-edma-pcie.c            |  56 ++-
> >  drivers/dma/dw-edma/dw-edma-v0-core.c         | 121 +++---
> >  drivers/dma/dw-edma/dw-edma-v0-core.h         |   1 -
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      | 372 ++++++++----------
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   5 -
> >  drivers/pci/controller/dwc/pcie-bt1.c         |   4 +
> >  .../pci/controller/dwc/pcie-designware-ep.c   |  12 +-
> >  .../pci/controller/dwc/pcie-designware-host.c |  24 +-
> >  drivers/pci/controller/dwc/pcie-designware.c  | 195 +++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h  |  21 +
> >  include/linux/dma/edma.h                      |  25 +-
> >  include/linux/dmaengine.h                     |   2 +-
> >  15 files changed, 652 insertions(+), 397 deletions(-)
> 

> Should I take the series in the PCI tree or do you prefer me acking
> the relevant patches ?

You taking the series in the PCI tree would be preferable choice since
it was what we agreed to do for all the denoted in the cover-letter
patchsets.

-Serge(y)

> 
> Thanks,
> Lorenzo
