Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADAA60257D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJRHUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJRHU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:20:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8798D19C1C;
        Tue, 18 Oct 2022 00:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666077630; x=1697613630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=d2BCVj64BTYSF36FIoeHkZaQnwzNtVMpJCVSYBSBrSY=;
  b=vf0ckdCmCEeBnqc2BtUn5NxqU8D5uX5YKU4M6zeC2DY4ElzZ9DC/g1+P
   RhCvRqbpr11YHx2MGLEYhxymbUK6VyFitvTv6BPFTBmgENHHzjDrBKnO4
   QAvNNKOdAmfzwgb4pNuxMGukiZNvS1HZOfkmgh7GvwR0RiknMzHW6ipJa
   Mibo6vShHpUJXxUb3SoZXJsgB1GDc/ii+ikpSn9M82nnuvPzSyUR7i4s3
   hhZBzcL8XWXJWekJVeimF2T/2h5GskfojGM1zX6NNF2hqD/rZCmBAdRTQ
   y3avy0Grl/X4S+dicFJslhso+fwdY42LRGgr0Rx/KqrlLQQCSYLUw34Of
   A==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="182673360"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Oct 2022 00:13:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 18 Oct 2022 00:13:28 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 18 Oct 2022 00:13:24 -0700
Date:   Tue, 18 Oct 2022 08:13:01 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
CC:     Conor Dooley <conor@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <anup@brainfault.org>, <heiko@sntech.de>, <guoren@kernel.org>,
        <mick@ics.forth.gr>, <alexandre.ghiti@canonical.com>,
        <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
        <corbet@lwn.net>, <bagasdotme@gmail.com>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <crash-utility@redhat.com>, <heinrich.schuchardt@canonical.com>,
        <k-hagio-ab@nec.com>, <hschauhan@nulltrace.org>,
        <yixun.lan@gmail.com>
Subject: Re: [PATCH V2 2/2] Documentation: kdump: describe VMCOREINFO export
 for RISCV64
Message-ID: <Y05R/WK3cSEmwmYx@wendy>
References: <20221014134139.5151-1-xianting.tian@linux.alibaba.com>
 <20221014134139.5151-3-xianting.tian@linux.alibaba.com>
 <Y02vm7FrhdEoSXZ+@spud>
 <a4d2dc7e-7f45-00b7-6c31-cc934ba9c1f5@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4d2dc7e-7f45-00b7-6c31-cc934ba9c1f5@linux.alibaba.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:41:50AM +0800, Xianting Tian wrote:
> 
> 在 2022/10/18 上午3:40, Conor Dooley 写道:
> > On Fri, Oct 14, 2022 at 09:41:39PM +0800, Xianting Tian wrote:
> > > The following interrelated definitions and ranges are needed by the kdump
> > > crash tool, they are exported by "arch/riscv/kernel/crash_core.c":
> > >      VA_BITS,
> > >      PAGE_OFFSET,
> > >      phys_ram_base,
> > >      MODULES_VADDR ~ MODULES_END,
> > >      VMALLOC_START ~ VMALLOC_END,
> > >      VMEMMAP_START ~ VMEMMAP_END,
> > >      KASAN_SHADOW_START ~ KASAN_SHADOW_END,
> > >      KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END
> > > 
> > > Document these RISCV64 exports above.
> > > 
> > > Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> > > ---
> > >   .../admin-guide/kdump/vmcoreinfo.rst          | 30 +++++++++++++++++++
> > >   1 file changed, 30 insertions(+)
> > > 
> > > diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> > > index 6726f439958c..8e2e164cf3db 100644
> > > --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> > > +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> > > @@ -595,3 +595,33 @@ X2TLB
> > >   -----
> > >   Indicates whether the crashed kernel enabled SH extended mode.
> > > +
> > > +RISCV64
> > > +=======
> > > +
> > > +VA_BITS
> > > +-------
> > > +
> > > +The maximum number of bits for virtual addresses. Used to compute the
> > > +virtual memory ranges.
> > > +
> > > +PAGE_OFFSET
> > > +-----------
> > > +
> > > +Indicates the virtual kernel start address of direct-mapped RAM region.
> > Apologies for not seeing this sooner, but should there not be a "the"
> > prior to "direct-mapped"?
> will fix in v3
> > 
> > > +
> > > +phys_ram_base
> > > +-------------
> > > +
> > > +Indicates the start physical RAM address.
> > > +
> > > +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
> > > +----------------------------------------------------------------------------------------------------------------------------------------------------
> > > +
> > > +Used to get the correct ranges:
> > > +
> > > +  * MODULES_VADDR ~ MODULES_END : Kernel module space.
> > > +  * VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
> > > +  * VMEMMAP_START ~ VMEMMAP_END : vmemmap region, used for struct page array.
> > Since I'm in pedant mode, it does look a little odd that you're using
> > region for vmemmap but space for the others but idc that much.
> 
> Sorry, I didn't get your point :(
> 
> it contains vmemmap area with reference wth arch/arm64/kernel/crash_core.c.

The wording is different, vmemmap uses space and the others use region.
Not a big deal.

> 
> > 
> > Thanks,
> > Conor.
> > 
> > > +  * KASAN_SHADOW_START ~ KASAN_SHADOW_END : kasan shadow space.
> > > +  * KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END : Kernel link and BPF space.
> > > -- 
> > > 2.17.1
> > > 
> > > 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
