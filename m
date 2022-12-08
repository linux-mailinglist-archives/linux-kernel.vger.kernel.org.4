Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE4F646C6B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiLHKHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiLHKHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:07:35 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE06716D1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:07:30 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so2693144ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nchtWG4neFGOOj13GrKgdXLK3R2xwbGEgZISqS6VaOs=;
        b=uMFjV+ajacsyEDH18PJoeXtCdnbaJ6wI7E+2NnLpMnTIa2crzfWi8G0qoSBQnSDln/
         E6Ilh1ez6OicJCNQnszgpCRb3h6HkYEevULKk/7/lGEELqkxUZR/gnmj2xSOijBe5WGw
         I/Sj79MdCEe/6rmhzfSLVShmNbh94+QeTLm/YdSE93yXHmHJ2jxMhs0RduQOLkRd8vhe
         SlALk/DWMoL24fc737jckaqj9pcOK9UY25ahzA/chceY2GnSRR77cqebJwobydf9OTki
         N3MHOJlPIy6zpJY3W850sKpfG5l2PWWKw0/s+iDTq+xtVYPszPiVqAThIRDv6WE5NNur
         YKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nchtWG4neFGOOj13GrKgdXLK3R2xwbGEgZISqS6VaOs=;
        b=b9uYrpkP+aRizzDIGlTmD7QedlEPXxUtfslGTVK+zXx+cACyvoxvj58lRuc9C97SmV
         LC1dIIa50aHC+P0gXfEeVWBb8juRqpdZak8LvJqdb9t/NxgDq9kDo8XRn7GhYHJyKFet
         23uOoiyV0HEbkxr67f59qJYRrujUQksGRt2U0xc6rat3uMXuCpuE01a7pXNzZVmWzihV
         p0F3ItrdRpkYh5vWt/wtG/NeLC5ZpVgohbJ9XDeWgXm7T/ndZvTk/r4AbndvMpbtkG6t
         wdvq1A0ru/yK16O1JzR8cuPsotslFm4j25bk4dZENJUT8SVVJdrxoYQKe56/LgZtLSol
         WOpQ==
X-Gm-Message-State: ANoB5pl8J3AzjilGNRoikp1B7iAiA0BKrjtI/6Cq0DPMkRvtzwlVE64W
        +NKBWWMBn8lTSfNysr4CT/0/ucdYyW/W4oNl
X-Google-Smtp-Source: AA0mqf6ucx66YnAYNtXgV2O4MCu3SxRtE21/ghep4vV5Dia3lR5WaEzXILvH3Fh9n5XiQrufI9n4kA==
X-Received: by 2002:a17:906:2a85:b0:78d:f454:ba2c with SMTP id l5-20020a1709062a8500b0078df454ba2cmr1613438eje.43.1670494048709;
        Thu, 08 Dec 2022 02:07:28 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id my48-20020a1709065a7000b007c0d64c1886sm6221569ejc.33.2022.12.08.02.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 02:07:27 -0800 (PST)
Message-ID: <b7ece19c-e50e-0709-7be1-2945883d155b@monstr.eu>
Date:   Thu, 8 Dec 2022 11:07:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 6.2-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull these changes to your tree. They are cleaning up the PCI bus support 
which was pretty much c&p from PowerPC long time ago for one custom platform 
which is not available for years. Finally Xilinx/AMD PCIe team tested Microblaze 
with IP cores also used on ARM SOCs and clean up Microblaze code.

Thanks,
Michal


The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

   Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

   git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.2

for you to fetch changes up to 5cfe469c2654c3a4dda8504b1209abdd8b379e95:

   microblaze/PCI: Moving PCI iounmap and dependent code (2022-11-25 11:39:23 +0100)

----------------------------------------------------------------
Microblaze patches for 6.2-rc1

- Cleanup PCI support

----------------------------------------------------------------
Thippeswamy Havalige (13):
       microblaze/PCI: Remove unused early_read_config_byte() et al declarations
       microblaze/PCI: Remove Null PCI config access unused functions
       microblaze/PCI: Remove unused PCI bus scan if configured as a host
       microblaze/PCI: Remove unused PCI legacy IO's access on a bus
       microblaze/PCI: Remove unused device tree parsing for a host bridge resources
       microblaze/PCI: Remove unused allocation & free of PCI host bridge structure
       microblaze/PCI: Remove unused PCI BIOS resource allocation
       microblaze/PCI: Remove unused PCI Indirect ops
       microblaze/PCI: Remove unused pci_address_to_pio() conversion of CPU 
address to I/O port
       microblaze/PCI: Remove unused sys_pciconfig_iobase() and et al declaration
       microblaze/PCI: Remove unused pci_iobar_pfn() and et al declarations
       microblaze/PCI: Remove support for Xilinx PCI host bridge
       microblaze/PCI: Moving PCI iounmap and dependent code

  arch/microblaze/Kconfig                  |    8 -
  arch/microblaze/configs/mmu_defconfig    |    1 -
  arch/microblaze/include/asm/pci-bridge.h |   92 --
  arch/microblaze/include/asm/pci.h        |   29 -
  arch/microblaze/pci/Makefile             |    3 +-
  arch/microblaze/pci/indirect_pci.c       |  158 ---
  arch/microblaze/pci/iomap.c              |   36 +
  arch/microblaze/pci/pci-common.c         | 1067 --------------------
  arch/microblaze/pci/xilinx_pci.c         |  170 ----
  9 files changed, 37 insertions(+), 1527 deletions(-)
  delete mode 100644 arch/microblaze/pci/indirect_pci.c
  delete mode 100644 arch/microblaze/pci/pci-common.c
  delete mode 100644 arch/microblaze/pci/xilinx_pci.c

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs


