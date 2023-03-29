Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE13D6CD78A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjC2KVt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 06:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjC2KVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:21:47 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109561BFC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 03:21:45 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id DCEE97FD6;
        Wed, 29 Mar 2023 18:21:37 +0800 (CST)
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 29 Mar
 2023 18:21:37 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX161.cuchost.com
 (172.16.6.71) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 29 Mar
 2023 18:21:37 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Wed, 29 Mar 2023 18:21:37 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: RE: [PATCH v7 0/4] RISC-V Hibernation Support
Thread-Topic: [PATCH v7 0/4] RISC-V Hibernation Support
Thread-Index: AQHZXUPKO69rRW/KG0+oVGFtmEc2GK8OG1CAgAGl6+CAAdOAgA==
Date:   Wed, 29 Mar 2023 10:21:37 +0000
Message-ID: <23301371d7a44ab6918274ca937fde3d@EXMBX066.cuchost.com>
References: <20230323045604.536099-1-jeeheng.sia@starfivetech.com>
 <20230327131353.6gzjjppfy2o5456x@orel>
 <5cf6ed6ca59e4173b6c469aa36510090@EXMBX066.cuchost.com>
In-Reply-To: <5cf6ed6ca59e4173b6c469aa36510090@EXMBX066.cuchost.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [60.53.70.89]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: JeeHeng Sia
> Sent: Tuesday, March 28, 2023 2:37 PM
> To: 'Andrew Jones' <ajones@ventanamicro.com>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> Subject: RE: [PATCH v7 0/4] RISC-V Hibernation Support
> 
> 
> 
> > -----Original Message-----
> > From: Andrew Jones <ajones@ventanamicro.com>
> > Sent: Monday, March 27, 2023 9:14 PM
> > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> > Subject: Re: [PATCH v7 0/4] RISC-V Hibernation Support
> >
> > On Thu, Mar 23, 2023 at 12:56:00PM +0800, Sia Jee Heng wrote:
> > > This series adds RISC-V Hibernation/suspend to disk support.
> > > Low level Arch functions were created to support hibernation.
> > > swsusp_arch_suspend() relies code from __cpu_suspend_enter() to write
> > > cpu state onto the stack, then calling swsusp_save() to save the memory
> > > image.
> > >
> > > Arch specific hibernation header is implemented and is utilized by the
> > > arch_hibernation_header_restore() and arch_hibernation_header_save()
> > > functions. The arch specific hibernation header consists of satp, hartid,
> > > and the cpu_resume address. The kernel built version is also need to be
> > > saved into the hibernation image header to making sure only the same
> > > kernel is restore when resume.
> > >
> > > swsusp_arch_resume() creates a temporary page table that covering only
> > > the linear map. It copies the restore code to a 'safe' page, then start to
> > > restore the memory image. Once completed, it restores the original
> > > kernel's page table. It then calls into __hibernate_cpu_resume()
> > > to restore the CPU context. Finally, it follows the normal hibernation
> > > path back to the hibernation core.
> > >
> > > To enable hibernation/suspend to disk into RISCV, the below config
> > > need to be enabled:
> > > - CONFIG_ARCH_HIBERNATION_HEADER
> > > - CONFIG_ARCH_HIBERNATION_POSSIBLE
> > >
> > > At high-level, this series includes the following changes:
> > > 1) Change suspend_save_csrs() and suspend_restore_csrs()
> > >    to public function as these functions are common to
> > >    suspend/hibernation. (patch 1)
> > > 2) Refactor the common code in the __cpu_resume_enter() function and
> > >    __hibernate_cpu_resume() function. The common code are used by
> > >    hibernation and suspend. (patch 2)
> > > 3) Enhance kernel_page_present() function to support huge page. (patch 3)
> > > 4) Add arch/riscv low level functions to support
> > >    hibernation/suspend to disk. (patch 4)
> > >
> > > The above patches are based on kernel v6.3-rc3 and are tested on
> > > StarFive VF2 SBC board and Qemu.
> > > ACPI platform mode is not supported in this series.
> > >
> >
> > I tested this on QEMU, but, FYI, I had to use a raw backing file for
> > the swap disk, rather than a qcow2 backing file, otherwise it didn't
> > resume. It's probably worth looking into why that is.
> Thanks for your time. The raw file format is closer to the actual physical disk. Although I can look into the qcow2 format for QEMU in
> the near future, it shouldn't be a blocking factor for this patch series to be upstreamed.

FYI, I managed to reproduce the hibernation issue that Andrew reported. The hibernation resume failed while retrieving pages from the disk, specifically in the kernel/power/swap.c - swap_read_page() function and the snapshot_write_next() function in the kernel/power/snapshot.c. I found that adding a delay to the functions (by adding a printk) allowed the page retrieval process to progress further. Through this exercise, I have begun to suspect that there may be an issue with coherency handling in between the hibernation core and the QEMU qcow2 driver. I will add it to my AR list and shall help to investigate the issue in the near future.
> >
> > Thanks,
> > drew
