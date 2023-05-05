Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9D06F7A17
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 02:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjEEAgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 20:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEEAge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 20:36:34 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CC57D9C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 17:36:32 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3310c01beb9so8406915ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 17:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1683246992; x=1685838992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjmOKwxVLQY18CC3WHFDbVhiCUx1xhOsqgqBRjXYxok=;
        b=a7y7UEmIBOuYdwcFqiVdt1mVbZ3V8yR9xcOGExvHxnh4MMDfRjs0ybX3jSVEWd84/D
         SAHKhOeBZS8BYcEAjoDtLgvzMiioHGEAoDR/tLMciltWezAaeYpbxNIGMiv6tQ2yRoBN
         iafnpmbknvt0dZXpvJN6a7M/v46hbQPgR+d0nhkN//YO+rtni1RxP0rFvHykSMGwgJfk
         6ytmF3XgdJ2mDfnV+G1M69KEPvzovzVpnc+aPUPUPgH63Qu37rLEpbLMeaSajveIN4Vq
         FS6wI8MbJLraEYKQ8IQyuj4Csy0DyMcDh9fO3W1IzGAgD5JLzeJ7z0TZ/kcq1Sow1TOp
         QNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683246992; x=1685838992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjmOKwxVLQY18CC3WHFDbVhiCUx1xhOsqgqBRjXYxok=;
        b=a7FKyXF5QSqtq+lwvZcgaC9V8ljNNzs2quDIGaI+QAnCdCLQhCN3HrYCChbAE3nx1F
         1OGEKD7u6/+nGXaBBUHTwMA4BT8ysUyuhgj5ME3K/7pcBuoJvpVF3nNzWKFztZD7Te6n
         a1ZkZ/Si38kA5i/TKZdmYMkuJ6t1eZzmO0+KAF8GVFTRTSS9h7xCNKvaPmPPmAWptIOB
         tEUrLWQRINXkFU3gmSswT2n/6ukEtrXpPjF3jiNSyPYIFh+8AmiMMih3zjB9Id+jAUVc
         Ouoyhe2GmDksWTNZurp1ibdKia7h/VAbYHBJc0d3nU06Q2W9esYXe3pXe0yU4z+mtrjg
         /Pkw==
X-Gm-Message-State: AC+VfDxo/FI/7SLaYbAp+G2Eyo0YyutAqYQmwkUWXeS/D8IowTIILnrA
        I3Av3N87ZX8STZzzpEsFe94V+FpAKH7Gbt4/TKi+YA==
X-Google-Smtp-Source: ACHHUZ7+o0ekC6oKbBn6xsJ7rA6FEMvSDV8hE9RxRkaB1i7GEfGcBGK/l8ntjGsrVczH79IiMO+tszApBOKFULzWfr0=
X-Received: by 2002:a92:ca90:0:b0:32b:4d92:2b8 with SMTP id
 t16-20020a92ca90000000b0032b4d9202b8mr430638ilo.26.1683246991074; Thu, 04 May
 2023 17:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230426074248.19336-1-zong.li@sifive.com> <MN0PR12MB59536CEE65DBB0EF343650F4B76D9@MN0PR12MB5953.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB59536CEE65DBB0EF343650F4B76D9@MN0PR12MB5953.namprd12.prod.outlook.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 5 May 2023 08:36:19 +0800
Message-ID: <CANXhq0q=VHDmpweSX35iec1x6UHBDRB7-mo4nWL_cqSWTBW0tQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: xilinx: enable on RISC-V platform
To:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 10:17=E2=80=AFPM Pandey, Radhey Shyam
<radhey.shyam.pandey@amd.com> wrote:
>
> > -----Original Message-----
> > From: linux-riscv <linux-riscv-bounces@lists.infradead.org> On Behalf O=
f
> > Zong Li
> > Sent: Wednesday, April 26, 2023 1:13 PM
> > To: vkoul@kernel.org; dmaengine@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-riscv@lists.infradead.org
> > Cc: Zong Li <zong.li@sifive.com>
> > Subject: [PATCH] dmaengine: xilinx: enable on RISC-V platform
> >
> > Enable the xilinx dmaengine driver on RISC-V platform. We have verified=
 the
> > CDMA on RISC-V platform, enable this configuration to allow build on RI=
SC-V.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/dma/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig index
> > fb7073fc034f..816f619804b9 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -695,7 +695,7 @@ config XGENE_DMA
> >
> >  config XILINX_DMA
> >       tristate "Xilinx AXI DMAS Engine"
> > -     depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
> > +     depends on (ARCH_ZYNQ || MICROBLAZE || ARM64 || RISCV)
>
> Instead of adding one more dependency I think we can cleanup this
> dependency list. Similar changes done in ethernet subsystem. Please
> have a look at below commits:
>

Hi Pandey,
Thanks for your tips, let me take a look at it, and give the next version.

> e8b6c54f6d57 net: xilinx: temac: Relax Kconfig dependencies
> d7eaf962a90b net: axienet: In kconfig remove arch dependency for axi_emac
>
> >       select DMA_ENGINE
> >       help
> >         Enable support for Xilinx AXI VDMA Soft IP.
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
