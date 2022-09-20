Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ED25BE5D1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiITMbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiITMb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:31:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1075AC40;
        Tue, 20 Sep 2022 05:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663677088; x=1695213088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q/fZbisIvw+4RruEs9TBl1W84JkX1r956syzCxEZ1v4=;
  b=CYVOcFtUD8UCQuvmj4V/ueMclQN/0XcD7Q9NGdLRo/pLR4xaVvlsSg/c
   YZjYCRiGn9Bj40KJe2Z+YYTeaLzI0SYtTeWrRdfsOleWAFj/z7qenWDPT
   V62qdQ+GVv/O1gPcIx9CDDjLoUPCof//m0YEF0cxaQAqUeDNl7HQxV0Pr
   h2lerBbpM/jBbbIuGvPkvst7muR1epqP8Nsc0wHJ0Km+cNeEZ14f/UyAW
   7hJW90ux0+EsbHGo74CmkQ85nirCf4Klg4xjGPv1bjYNipG1vs22v2XF6
   36hxTr9nFOEKZC7bmEg+VGCy5hAyF+v73zihWmXmA/2WQLEy1W5nSPtWa
   g==;
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="178026134"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Sep 2022 05:31:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 20 Sep 2022 05:31:26 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 20 Sep 2022 05:31:24 -0700
Date:   Tue, 20 Sep 2022 13:31:03 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Conor Dooley <mail@conchuod.ie>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <heiko@sntech.de>, <atishp@rivosinc.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 07/10] riscv: boot: dts: r9a07g043: Add placeholder
 nodes
Message-ID: <Yymyh+UlIICacxeV@wendy>
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915181558.354737-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <3693a3a1-5a2a-4cc5-fb55-f6ad9a4b3f72@microchip.com>
 <CA+V-a8u87tqhC69qGD2zq_gT9jc_cSWd+NRn_u0bPTdmmk+j4A@mail.gmail.com>
 <e15f3e2a-2761-84d9-c5c9-118717e0bb83@conchuod.ie>
 <CAMuHMdUGD9s96JJafsYdfnPqvg6KLvmC9GUS4yjaaXi2hYrJYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUGD9s96JJafsYdfnPqvg6KLvmC9GUS4yjaaXi2hYrJYQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 02:17:50PM +0200, Geert Uytterhoeven wrote:
> Hi Conor,
> 
> On Fri, Sep 16, 2022 at 12:40 AM Conor Dooley <mail@conchuod.ie> wrote:
> > On 15/09/2022 23:26, Lad, Prabhakar wrote:
> > > On Thu, Sep 15, 2022 at 10:36 PM <Conor.Dooley@microchip.com> wrote:
> > >> On 15/09/2022 19:15, Prabhakar wrote:
> > >>> riscv: boot: dts: r9a07g043: Add placeholder nodes
> > >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >>> Add empty placeholder nodes to RZ/Five (R9A07G043) SoC DTSI.
> > >> Can you explain why do you need placeholder nodes for this and
> > >> cannot just directly include the other dtsis?
> > >>
> > > Since the RZ/G2UL SoC is ARM64 where it has a GIC and on RZ/Five SoC
> > > we have PLIC for interrupts. Also the interrupt numbering for RZ/Five
> > > SoC differs from RZ/G2UL SoC hence we are not directly using the
> > > RZ/G2UL SoC DTSI [0].
> > >
> > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/r9a07g043.dtsi?h=v6.0-rc5
> > >
> > > For the RZ/Five SMARC EVK I am re-using the below files [1] (SoM) and
> > > [2] (Carrier board) as the RZ/Five SMARC EVK is pin compatible.  Since
> > > I am re-using these when trying to compile the RZ/Five DTB I get
> > > compilation errors since the nodes dont exist (and there is no way
> > > currently we can delete the node reference when the actual node itself
> > > isn't present) hence these place holders.
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi?h=v6.0-rc5
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi?h=v6.0-rc5
> >
> > If this method is acceptable to Geert, this explanation 100% needs to
> > go into the commit message.
> 
> We've been using these placeholders a lot in Renesas SoC-specific
> .dtsi files, as they allow us to introduce gradually support for a new SoC
> that is mounted on an existing PCB, and thus shares a board-specific
> .dtsi file.  Hence I'm fine with this.

Aye, if you're happy with it then I am too...
> 
> However, I think more properties can be dropped from the placeholders.
> There is no need to have e.g. 'reg-names' and 'status = "disabled"'
> (there is no compatible value, so no matching is done).

...and this makes a lot of sense. I'd still like a comment in the
commit message though explaining why placeholder nodes are needed as
opposed to just leaving it blank etc.

Thanks,
Conor.
