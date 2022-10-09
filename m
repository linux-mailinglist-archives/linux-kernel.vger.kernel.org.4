Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177325F8A90
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 12:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJIK1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 06:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJIK1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 06:27:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208D42A263;
        Sun,  9 Oct 2022 03:27:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id nb11so19604629ejc.5;
        Sun, 09 Oct 2022 03:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJl9C1fQIvxFUwdbFz1SgRkeddPcRdTDbbIUDnexT70=;
        b=qLQSdIiR5PapexVzl063z2aEo26cbOWVgWEgF301AjG0gUFmhtRrwmG9n0PVOXNLmt
         2NF3NmhkLx28aGdK4bGpT75sU8rmiZLWDogqaInm4eOE99Xao2n4pPtwAgIpJjOuLqjv
         vFbV4ag5Kof3zwsdRdOqTazqK0216oW8R19pYixA9Q7hrkn+WD1jHSZNzy1hD2wSgCcL
         fAYYKWU0G/VpsRYScl7UxwzoK/iNlSxcDGNlEw4aBEx6q48BaO8hkAMGTYQlj9Sr7zj9
         mCh6vjZcjlsmYMybMe2vKCN5PlbWqtWPoRsSwjUo6PMe/t4i0ITZ3vIWOD+i75pz1qDL
         VQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJl9C1fQIvxFUwdbFz1SgRkeddPcRdTDbbIUDnexT70=;
        b=FVilK+PP1hJAse3QtDfAU0EhjAwnA4B0i5M0FBUGUcdXuE3HerlZ3TqZoVbQDJ/UZW
         Wlmwh0yB8KF8g5nUifkGwMKQdIBch77qMqRDiyQvTsDvbcLB+HL4/PDBgzNeassmEOym
         L2Nprr9igZl0PTgIUTu8Rp8iPMYgcoCmcAVfr/IKvK/jEs7k1H5OZUqMdeGAK0t2b0v1
         omIfrRHm5jZmCazfW7NwkaykLp1FrUG4dHI3a5v+nLAzRORi31RyugeCOI2p7ytf6IUi
         GWpk1gVdAf8vWz+NeGw0uat1b/HZxn+cmk7kz4EsPcgSJ9nIm2ueIzl8abV9xXHqeWy/
         DNfw==
X-Gm-Message-State: ACrzQf0Mm3+xiugmnCYQHnl6veXk2wblvJRX4WTA+St/SzErWY/NCusw
        h2XVP5cqcduKhery5iFXm8bLy7GyOGIuplOMCco=
X-Google-Smtp-Source: AMsMyM7f6+8m4CJOahYIP7KrMNy7GFS1Q9//v3Fsxw+3PLIvPkDdmvKXN6iheUhXTJQIA1kiuKrWQuL3wSr4Y2XFnqM=
X-Received: by 2002:a17:907:948e:b0:783:91cf:c35a with SMTP id
 dm14-20020a170907948e00b0078391cfc35amr10697954ejc.366.1665311220333; Sun, 09
 Oct 2022 03:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210520224213.7907-1-keguang.zhang@gmail.com> <20210806200913.0a04c71c@xps13>
In-Reply-To: <20210806200913.0a04c71c@xps13>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Sun, 9 Oct 2022 18:26:48 +0800
Message-ID: <CAJhJPsWf7Z=nf5KG2eHOPqzZgpNb42fpQzFtMrTox933h+6Psg@mail.gmail.com>
Subject: Re: [PATCH V5 RESEND] mtd: rawnand: Add Loongson1 NAND driver
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,
Sorry for the slow response.

Miquel Raynal <miquel.raynal@bootlin.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=887=
=E6=97=A5=E5=91=A8=E5=85=AD 02:09=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Keguang,
>
> Sorry again for the very late review, here are my comments.
>
> Keguang Zhang <keguang.zhang@gmail.com> wrote on Fri, 21 May 2021
> 06:42:13 +0800:
>
> > From: Kelvin Cheung <keguang.zhang@gmail.com>
> >
> > This patch adds NAND driver for Loongson1B.
> >
> > Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> > ---
> > V4 -> V5:
> >    Update the driver to fit the raw NAND framework.
> >    Implement exec_op() instead of legacy cmdfunc().
> >    Use dma_request_chan() instead of dma_request_channel().
> >    Some minor fixes and cleanups.
> > V3 -> V4:
> >    Retrieve the controller from nand_hw_control.
> > V2 -> V3:
> >    Replace __raw_readl/__raw_writel with readl/writel.
> >    Split ls1x_nand into two structures: ls1x_nand_chip and
> >    ls1x_nand_controller.
> > V1 -> V2:
> >    Modify the dependency in Kconfig due to the changes of DMA
> >    module.
> > ---
> >  drivers/mtd/nand/raw/Kconfig          |   8 +
> >  drivers/mtd/nand/raw/Makefile         |   1 +
> >  drivers/mtd/nand/raw/loongson1_nand.c | 770 ++++++++++++++++++++++++++
> >  3 files changed, 779 insertions(+)
> >  create mode 100644 drivers/mtd/nand/raw/loongson1_nand.c
> >
> > diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfi=
g
> > index 30f061939560..63402e335df4 100644
> > --- a/drivers/mtd/nand/raw/Kconfig
> > +++ b/drivers/mtd/nand/raw/Kconfig
> > @@ -453,6 +453,14 @@ config MTD_NAND_ROCKCHIP
> >           NFC v800: RK3308, RV1108
> >           NFC v900: PX30, RK3326
> >
> > +config MTD_NAND_LOONGSON1
> > +     tristate "Support for Loongson1 SoC NAND controller"
>
> Can you please match the style for the titles?
>
> > +     depends on MACH_LOONGSON32
>
>  || CROSS_COMPILE
>
> > +     select MTD_NAND_ECC_SW_HAMMING
> > +     select LOONGSON1_DMA
>
> Maybe this should be a depends on?
>
will change to depends on.

> > +     help
> > +       Enables support for NAND controller on Loongson1 SoCs.
> > +
> >  comment "Misc"
> >
> >  config MTD_SM_COMMON
> > diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makef=
ile
> > index d011c6c53f8f..50a51ad6ec21 100644
> > --- a/drivers/mtd/nand/raw/Makefile
> > +++ b/drivers/mtd/nand/raw/Makefile
> > @@ -57,6 +57,7 @@ obj-$(CONFIG_MTD_NAND_CADENCE)              +=3D cade=
nce-nand-controller.o
> >  obj-$(CONFIG_MTD_NAND_ARASAN)                +=3D arasan-nand-controll=
er.o
> >  obj-$(CONFIG_MTD_NAND_INTEL_LGM)     +=3D intel-nand-controller.o
> >  obj-$(CONFIG_MTD_NAND_ROCKCHIP)              +=3D rockchip-nand-contro=
ller.o
> > +obj-$(CONFIG_MTD_NAND_LOONGSON1)        +=3D loongson1_nand.o
> >
> >  nand-objs :=3D nand_base.o nand_legacy.o nand_bbt.o nand_timings.o nan=
d_ids.o
> >  nand-objs +=3D nand_onfi.o
> > diff --git a/drivers/mtd/nand/raw/loongson1_nand.c b/drivers/mtd/nand/r=
aw/loongson1_nand.c
> > new file mode 100644
> > index 000000000000..b06e36ec32da
> > --- /dev/null
> > +++ b/drivers/mtd/nand/raw/loongson1_nand.c
> > @@ -0,0 +1,770 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * NAND Flash Driver for Loongson 1 SoC
> > + *
> > + * Copyright (C) 2015-2021 Zhang, Keguang <keguang.zhang@gmail.com>
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/clk.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/mtd/mtd.h>
> > +#include <linux/mtd/rawnand.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/sizes.h>
> > +
> > +#include <nand.h>
> > +
> > +/* Loongson 1 NAND Register Definitions */
> > +#define NAND_CMD             0x0
> > +#define NAND_ADDR1           0x4
> > +#define NAND_ADDR2           0x8
> > +#define NAND_TIMING          0xc
> > +#define NAND_IDL             0x10
> > +#define NAND_IDH             0x14
> > +#define NAND_STATUS          0x15
> > +#define NAND_PARAM           0x18
> > +#define NAND_OP_NUM          0x1c
> > +#define NAND_CS_RDY          0x20
> > +
> > +#define NAND_DMA_ADDR                0x40
> > +
> > +/* NAND Command Register Bits */
> > +#define OP_DONE                      BIT(10)
> > +#define OP_SPARE             BIT(9)
> > +#define OP_MAIN                      BIT(8)
> > +#define CMD_STATUS           BIT(7)
> > +#define CMD_RESET            BIT(6)
> > +#define CMD_READID           BIT(5)
> > +#define BLOCKS_ERASE         BIT(4)
> > +#define CMD_ERASE            BIT(3)
> > +#define CMD_WRITE            BIT(2)
> > +#define CMD_READ             BIT(1)
> > +#define CMD_VALID            BIT(0)
> > +
> > +#define MAX_ADDR_CYC         5U
> > +#define MAX_ID_SIZE          (NAND_STATUS - NAND_IDL)
>
> Strange. I guess you can hardcode it.
>
will remove MAX_ID_SIZE.

> > +#define SIZE_MASK            GENMASK(11, 8)
> > +
> > +#define BITS_PER_WORD                32
> > +
> > +/* macros for registers read/write */
> > +#define nand_readl(nc, off)          \
> > +     readl((nc)->reg_base + (off))
> > +
> > +#define nand_writel(nc, off, val)    \
> > +     writel((val), (nc)->reg_base + (off))
> > +
> > +struct ls1x_nand_controller {
> > +     void __iomem *reg_base;
> > +     __le32 addr1_reg;
> > +     __le32 addr2_reg;
> > +
> > +     char *buf;
> > +     unsigned int len;
> > +     unsigned int rdy_timeout;
> > +
> > +     /* DMA Engine stuff */
> > +     struct dma_chan *dma_chan;
> > +     dma_cookie_t dma_cookie;
> > +     struct completion dma_complete;
> > +};
> > +
> > +struct ls1x_nand {
> > +     struct device *dev;
> > +     struct clk *clk;
> > +     struct nand_chip chip;
> > +     struct nand_controller controller;
> > +     struct ls1x_nand_controller nc;
> > +     struct plat_ls1x_nand *pdata;
> > +};
> > +
> > +static void ls1x_nand_dump_regs(struct nand_chip *chip)
> > +{
> > +     struct ls1x_nand *nand =3D nand_get_controller_data(chip);
> > +     struct ls1x_nand_controller *nc =3D &nand->nc;
> > +
> > +     print_hex_dump(KERN_INFO, "REG: ", DUMP_PREFIX_OFFSET, 16, 4,
> > +                    nc->reg_base, 0x44, false);
> > +}
> > +
> > +static void ls1x_nand_dma_callback(void *data)
> > +{
> > +     struct ls1x_nand *nand =3D (struct ls1x_nand *)data;
> > +     struct ls1x_nand_controller *nc =3D &nand->nc;
> > +     enum dma_status status;
> > +
> > +     status =3D dmaengine_tx_status(nc->dma_chan, nc->dma_cookie, NULL=
);
> > +     if (likely(status =3D=3D DMA_COMPLETE))
> > +             dev_dbg(nand->dev, "DMA complete with cookie=3D%d\n",
> > +                     nc->dma_cookie);
> > +     else
> > +             dev_err(nand->dev, "DMA error with cookie=3D%d\n",
> > +                     nc->dma_cookie);
> > +
> > +     complete(&nc->dma_complete);
> > +}
> > +
> > +static int ls1x_nand_dma_transfer(struct ls1x_nand *nand, bool is_writ=
e)
> > +{
> > +     struct ls1x_nand_controller *nc =3D &nand->nc;
> > +     struct dma_chan *chan =3D nc->dma_chan;
> > +     struct dma_async_tx_descriptor *desc;
> > +     enum dma_data_direction data_dir =3D
> > +         is_write ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
> > +     enum dma_transfer_direction xfer_dir =3D
> > +         is_write ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
> > +     dma_addr_t dma_addr;
> > +     int ret;
> > +
> > +     dma_addr =3D dma_map_single(chan->device->dev, nc->buf, nc->len,
> > +                               data_dir);
> > +     if (dma_mapping_error(chan->device->dev, dma_addr)) {
> > +             dev_err(nand->dev, "failed to map DMA buffer!\n");
> > +             return -ENXIO;
> > +     }
> > +
> > +     desc =3D dmaengine_prep_slave_single(chan, dma_addr, nc->len, xfe=
r_dir,
> > +                                        DMA_PREP_INTERRUPT);
> > +     if (!desc) {
> > +             dev_err(nand->dev, "failed to prepare DMA descriptor!\n")=
;
> > +             ret =3D PTR_ERR(desc);
> > +             goto err;
> > +     }
> > +     desc->callback =3D ls1x_nand_dma_callback;
> > +     desc->callback_param =3D nand;
> > +
> > +     nc->dma_cookie =3D dmaengine_submit(desc);
> > +     ret =3D dma_submit_error(nc->dma_cookie);
> > +     if (ret) {
> > +             dev_err(nand->dev, "failed to submit DMA descriptor!\n");
> > +             goto err;
> > +     }
> > +
> > +     dev_dbg(nand->dev, "issue DMA with cookie=3D%d\n", nc->dma_cookie=
);
> > +     dma_async_issue_pending(chan);
> > +
> > +     ret =3D wait_for_completion_timeout(&nc->dma_complete,
> > +                                       msecs_to_jiffies(nc->rdy_timeou=
t));
> > +     if (ret <=3D 0) {
> > +             dev_err(nand->dev, "DMA timeout!\n");
> > +             dmaengine_terminate_all(chan);
> > +             ret =3D -EIO;
> > +     }
> > +     ret =3D 0;
> > +err:
> > +     dma_unmap_single(chan->device->dev, dma_addr, nc->len, data_dir);
> > +
> > +     return ret;
> > +}
> > +
> > +static inline void ls1x_nand_parse_address(struct nand_chip *chip,
> > +                                        const u8 *addrs,
> > +                                        unsigned int naddrs, int cmd)
> > +{
> > +     struct ls1x_nand *nand =3D nand_get_controller_data(chip);
> > +     struct ls1x_nand_controller *nc =3D &nand->nc;
> > +#if defined(CONFIG_LOONGSON1_LS1B)
>
> Please use a regular if (IS_DEFINED())
>
> I don't like this symbol anyway, you should get this information from a
> compatible (like the machine compatible) not from a Kconfig symbol.
>
will add DT support in the next version.

> > +     unsigned int page_shift =3D chip->page_shift + 1;
> > +#endif
> > +     int i;
> > +
> > +     nc->addr1_reg =3D 0;
> > +     nc->addr2_reg =3D 0;
> > +#if defined(CONFIG_LOONGSON1_LS1B)
> > +     if (cmd =3D=3D CMD_ERASE) {
> > +             page_shift =3D chip->page_shift;
> > +
> > +             for (i =3D 0; i < min(MAX_ADDR_CYC - 2, naddrs); i++)
> > +                     nc->addr1_reg |=3D
> > +                         (u32)addrs[i] << (page_shift + BITS_PER_BYTE =
* i);
> > +             if (i =3D=3D MAX_ADDR_CYC - 2)
> > +                     nc->addr2_reg |=3D
> > +                         (u32)addrs[i] >> (BITS_PER_WORD - page_shift =
-
> > +                                           BITS_PER_BYTE * (i - 1));
> > +
> > +             return;
> > +     }
> > +
> > +     for (i =3D 0; i < min(2U, naddrs); i++)
> > +             nc->addr1_reg |=3D (u32)addrs[i] << BITS_PER_BYTE * i;
> > +     for (i =3D 2; i < min(MAX_ADDR_CYC, naddrs); i++)
> > +             nc->addr1_reg |=3D
> > +                 (u32)addrs[i] << (page_shift + BITS_PER_BYTE * (i - 2=
));
> > +     if (i =3D=3D MAX_ADDR_CYC)
> > +             nc->addr2_reg |=3D
> > +                 (u32)addrs[i] >> (BITS_PER_WORD - page_shift -
> > +                                   BITS_PER_BYTE * (i - 1));
> > +#elif defined(CONFIG_LOONGSON1_LS1C)
> > +     if (cmd =3D=3D CMD_ERASE) {
> > +             for (i =3D 0; i < min(MAX_ADDR_CYC, naddrs); i++)
> > +                     nc->addr2_reg |=3D (u32)addrs[i] << BITS_PER_BYTE=
 * i;
> > +
> > +             return;
> > +     }
> > +
> > +     for (i =3D 0; i < min(MAX_ADDR_CYC, naddrs); i++) {
> > +             if (i < 2)
> > +                     nc->addr1_reg |=3D (u32)addrs[i] << BITS_PER_BYTE=
 * i;
> > +             else
> > +                     nc->addr2_reg |=3D
> > +                         (u32)addrs[i] << BITS_PER_BYTE * (i - 2);
> > +     }
> > +#endif
> > +}
> > +
> > +static int ls1x_nand_set_controller(struct nand_chip *chip,
> > +                                 const struct nand_subop *subop, int c=
md)
> > +{
> > +     struct ls1x_nand *nand =3D nand_get_controller_data(chip);
> > +     struct ls1x_nand_controller *nc =3D &nand->nc;
> > +     unsigned int op_id;
> > +
> > +     nc->buf =3D NULL;
> > +     nc->len =3D 0;
> > +     nc->rdy_timeout =3D 0;
> > +
> > +     for (op_id =3D 0; op_id < subop->ninstrs; op_id++) {
> > +             const struct nand_op_instr *instr =3D &subop->instrs[op_i=
d];
> > +             unsigned int offset, naddrs;
> > +             const u8 *addrs;
> > +
> > +             switch (instr->type) {
> > +             case NAND_OP_CMD_INSTR:
> > +                     break;
>
> This is very suspicious. You should definitely do something with the
> command bytes, you should not guess the commands based on the format of
> the operation.
>
will remove this case.

> > +             case NAND_OP_ADDR_INSTR:
> > +                     offset =3D nand_subop_get_addr_start_off(subop, o=
p_id);
> > +                     naddrs =3D nand_subop_get_num_addr_cyc(subop, op_=
id);
> > +                     addrs =3D &instr->ctx.addr.addrs[offset];
> > +
> > +                     ls1x_nand_parse_address(chip, addrs, naddrs, cmd)=
;
> > +                     /* set NAND address */
> > +                     nand_writel(nc, NAND_ADDR1, nc->addr1_reg);
> > +                     nand_writel(nc, NAND_ADDR2, nc->addr2_reg);
> > +                     break;
> > +             case NAND_OP_DATA_IN_INSTR:
> > +                     offset =3D nand_subop_get_data_start_off(subop, o=
p_id);
> > +                     nc->len =3D nand_subop_get_data_len(subop, op_id)=
;
> > +                     nc->buf =3D instr->ctx.data.buf.in + offset;
> > +
> > +                     if (!IS_ALIGNED(nc->len, chip->buf_align) ||
> > +                         !IS_ALIGNED((unsigned int)nc->buf, chip->buf_=
align))
> > +                             return -ENOTSUPP;
> > +                     /* set NAND data length */
> > +                     nand_writel(nc, NAND_OP_NUM, nc->len);
> > +                     break;
> > +             case NAND_OP_DATA_OUT_INSTR:
> > +                     offset =3D nand_subop_get_data_start_off(subop, o=
p_id);
> > +                     nc->len =3D nand_subop_get_data_len(subop, op_id)=
;
> > +                     nc->buf =3D (void *)instr->ctx.data.buf.out + off=
set;
> > +
> > +                     if (!IS_ALIGNED(nc->len, chip->buf_align) ||
> > +                         !IS_ALIGNED((unsigned int)nc->buf, chip->buf_=
align))
> > +                             return -ENOTSUPP;
> > +                     /* set NAND data length */
> > +                     nand_writel(nc, NAND_OP_NUM, nc->len);
> > +                     break;
> > +             case NAND_OP_WAITRDY_INSTR:
> > +                     nc->rdy_timeout =3D instr->ctx.waitrdy.timeout_ms=
;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     /*set NAND erase block count */
> > +     if (cmd & CMD_ERASE)
> > +             nand_writel(nc, NAND_OP_NUM, 1);
> > +     /*set NAND operation region */
>
> Please fix all your comments in the driver, eg:

will do.
>
>         /* Set NAND operation region */
>
> > +     if (nc->buf && nc->len) {
> > +             if (nc->addr1_reg & BIT(chip->page_shift))
> > +                     cmd |=3D OP_SPARE;
> > +             else
> > +                     cmd |=3D OP_SPARE | OP_MAIN;
>
> Is this really needed? Can't you always stick to OP_SPARE | OP_MAIN?
>
will do.

> > +     }
> > +
> > +     /*set NAND command */
> > +     nand_writel(nc, NAND_CMD, cmd);
> > +     /* Trigger operation */
> > +     nand_writel(nc, NAND_CMD, nand_readl(nc, NAND_CMD) | CMD_VALID);
> > +
> > +     return 0;
> > +}
> > +
> > +static inline int ls1x_nand_wait_for_op_done(struct ls1x_nand_controll=
er *nc)
> > +{
> > +     unsigned int val;
> > +     int ret =3D 0;
> > +
> > +     /* Wait for operation done */
> > +     if (nc->rdy_timeout)
> > +             ret =3D readl_relaxed_poll_timeout(nc->reg_base + NAND_CM=
D, val,
> > +                                              val & OP_DONE, 0,
> > +                                              nc->rdy_timeout * 1000);
> > +
> > +     return ret;
> > +}
> > +
> > +static int ls1x_nand_reset_exec(struct nand_chip *chip,
> > +                             const struct nand_subop *subop)
> > +{
> > +     struct ls1x_nand *nand =3D nand_get_controller_data(chip);
> > +     struct ls1x_nand_controller *nc =3D &nand->nc;
> > +     int ret;
> > +
> > +     ls1x_nand_set_controller(chip, subop, CMD_RESET);
> > +
> > +     ret =3D ls1x_nand_wait_for_op_done(nc);
> > +     if (ret)
> > +             dev_err(nand->dev, "CMD_RESET failed! %d\n", ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static int ls1x_nand_read_id_exec(struct nand_chip *chip,
> > +                               const struct nand_subop *subop)
> > +{
> > +     struct ls1x_nand *nand =3D nand_get_controller_data(chip);
> > +     struct ls1x_nand_controller *nc =3D &nand->nc;
> > +     int idl, i;
> > +     int ret;
> > +
> > +     ls1x_nand_set_controller(chip, subop, CMD_READID);
> > +
> > +     ret =3D ls1x_nand_wait_for_op_done(nc);
> > +     if (ret) {
> > +             dev_err(nand->dev, "CMD_READID failed! %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     idl =3D (nand_readl(nc, NAND_IDL));
>
> Unneeded outer ( ).
>
will do.

> > +     for (i =3D 0; i < min_t(unsigned int, nc->len, MAX_ID_SIZE); i++)
>
> The core enforces the number of data cycles to be less or
> equal than MAX_ID_SIZE if correctly described below (see the comment in
> the exec_op array) so you don't need this min_t() here.
>
will remove min_t().

> Please use { } to enclose the if/else block.
>
> > +             if (i > 0)
>
will do.
> This looks very suspicious, I would expect the condition to be i < 4
>
> > +                     nc->buf[i] =3D *((char *)&idl + 4 - i);
>
> Please rewrite this, it is hard to follow.
>
will do.
> > +             else
> > +                     nc->buf[i] =3D (char)(nand_readl(nc, NAND_IDH));
> > +
> > +     return ret;
> > +}
> > +
> > +static int ls1x_nand_erase_exec(struct nand_chip *chip,
> > +                             const struct nand_subop *subop)
> > +{
> > +     struct ls1x_nand *nand =3D nand_get_controller_data(chip);
> > +     struct ls1x_nand_controller *nc =3D &nand->nc;
> > +     int ret;
> > +
> > +     ls1x_nand_set_controller(chip, subop, CMD_ERASE);
> > +
> > +     ret =3D ls1x_nand_wait_for_op_done(nc);
> > +     if (ret)
> > +             dev_err(nand->dev, "CMD_ERASE failed! %d\n", ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static int ls1x_nand_read_exec(struct nand_chip *chip,
> > +                            const struct nand_subop *subop)
> > +{
> > +     struct ls1x_nand *nand =3D nand_get_controller_data(chip);
> > +     struct ls1x_nand_controller *nc =3D &nand->nc;
> > +     int ret;
> > +
> > +     ls1x_nand_set_controller(chip, subop, CMD_READ);
> > +
> > +     ret =3D ls1x_nand_dma_transfer(nand, false);
>
> Please use an intermediate variable such as bool write =3D false; (same
> below)
>
will do.
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D ls1x_nand_wait_for_op_done(nc);
> > +     if (ret)
> > +             dev_err(nand->dev, "CMD_READ failed! %d\n", ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static int ls1x_nand_write_exec(struct nand_chip *chip,
> > +                             const struct nand_subop *subop)
> > +{
> > +     struct ls1x_nand *nand =3D nand_get_controller_data(chip);
> > +     struct ls1x_nand_controller *nc =3D &nand->nc;
> > +     int ret;
> > +
> > +     ls1x_nand_set_controller(chip, subop, CMD_WRITE);
> > +
> > +     ret =3D ls1x_nand_dma_transfer(nand, true);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D ls1x_nand_wait_for_op_done(nc);
> > +     if (ret)
> > +             dev_err(nand->dev, "CMD_WRITE failed! %d\n", ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static int ls1x_nand_read_status_exec(struct nand_chip *chip,
> > +                                   const struct nand_subop *subop)
> > +{
> > +     struct ls1x_nand *nand =3D nand_get_controller_data(chip);
> > +     struct ls1x_nand_controller *nc =3D &nand->nc;
> > +     int ret;
> > +
> > +     ls1x_nand_set_controller(chip, subop, CMD_STATUS);
> > +
> > +     ret =3D ls1x_nand_wait_for_op_done(nc);
> > +     if (ret) {
> > +             dev_err(nand->dev, "CMD_STATUS failed! %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     nc->buf[0] =3D nand_readl(nc, NAND_IDH) >> BITS_PER_BYTE;
>
> This looks very specific to the status cmd, which is not a valid
> implementation. Can you turn this function generic to any cmd+data
> bytes? (the number of data bytes could be different than 1).
>
will read NAND_STATUS directly.
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct nand_op_parser ls1x_nand_op_parser =3D NAND_OP_PAR=
SER(
> > +     NAND_OP_PARSER_PATTERN(
> > +             ls1x_nand_reset_exec,
> > +             NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +             NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> > +     NAND_OP_PARSER_PATTERN(
> > +             ls1x_nand_read_id_exec,
> > +             NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +             NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDR_CYC),
> > +             NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 8)),
>
> Please use the definition used above                   ^
>
> > +     NAND_OP_PARSER_PATTERN(
> > +             ls1x_nand_erase_exec,
> > +             NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +             NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDR_CYC),
> > +             NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +             NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> > +     NAND_OP_PARSER_PATTERN(
> > +             ls1x_nand_read_exec,
> > +             NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +             NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDR_CYC),
> > +             NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +             NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
> > +             NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 0)),
> > +     NAND_OP_PARSER_PATTERN(
> > +             ls1x_nand_write_exec,
> > +             NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +             NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDR_CYC),
> > +             NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 0),
> > +             NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +             NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
> > +     NAND_OP_PARSER_PATTERN(
> > +             ls1x_nand_read_status_exec,
> > +             NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +             NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 1)),
> > +     );
> > +
> > +static int ls1x_nand_exec_op(struct nand_chip *chip,
> > +                          const struct nand_operation *op, bool check_=
only)
> > +{
> > +     return nand_op_parser_exec_op(chip, &ls1x_nand_op_parser, op,
> > +                                   check_only);
> > +}
> > +
> > +static int ls1x_nand_read_subpage(struct nand_chip *chip,
> > +                               unsigned int data_offs, unsigned int re=
adlen,
> > +                               unsigned char *bufpoi, int page)
> > +{
>
> There is nothing specific to your controller in that helper, why do you
> need it?
>
Just want to make the most of monolithic_read.
I should modify the nand subsystem instead of implementing own helper, righ=
t?
I will submit a separate patch for this.

> > +     struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +     int start_step, end_step, num_steps, ret;
> > +     char *p;
> > +     int data_col_addr, i;
> > +     int datafrag_len, eccfrag_len, aligned_len, aligned_pos;
> > +     int busw =3D (chip->options & NAND_BUSWIDTH_16) ? 2 : 1;
> > +     int index, section =3D 0;
> > +     unsigned int max_bitflips =3D 0;
> > +     struct mtd_oob_region oobregion =3D { };
> > +
> > +     /* Read the whole page and OOB data */
> > +     ret =3D chip->ecc.read_page_raw(chip, bufpoi, 1, page);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Column address within the page aligned to ECC size (256bytes) =
*/
> > +     start_step =3D data_offs / chip->ecc.size;
> > +     end_step =3D (data_offs + readlen - 1) / chip->ecc.size;
> > +     num_steps =3D end_step - start_step + 1;
> > +     index =3D start_step * chip->ecc.bytes;
> > +
> > +     /* Data size aligned to ECC ecc.size */
> > +     datafrag_len =3D num_steps * chip->ecc.size;
> > +     eccfrag_len =3D num_steps * chip->ecc.bytes;
> > +
> > +     data_col_addr =3D start_step * chip->ecc.size;
> > +     /* If we read not a page aligned data */
> > +     p =3D bufpoi + data_col_addr;
> > +
> > +     /* Calculate ECC */
> > +     for (i =3D 0; i < eccfrag_len; i +=3D chip->ecc.bytes, p +=3D chi=
p->ecc.size)
> > +             chip->ecc.calculate(chip, p, &chip->ecc.calc_buf[i]);
> > +
> > +     ret =3D mtd_ooblayout_find_eccregion(mtd, index, &section, &oobre=
gion);
> > +     if (ret)
> > +             return ret;
> > +
> > +     aligned_pos =3D oobregion.offset & ~(busw - 1);
> > +     aligned_len =3D eccfrag_len;
> > +     if (oobregion.offset & (busw - 1))
> > +             aligned_len++;
> > +     if ((oobregion.offset + (num_steps * chip->ecc.bytes)) & (busw - =
1))
> > +             aligned_len++;
> > +
> > +     memcpy(&chip->oob_poi[aligned_pos],
> > +            bufpoi + mtd->writesize + aligned_pos, aligned_len);
> > +
> > +     ret =3D mtd_ooblayout_get_eccbytes(mtd, chip->ecc.code_buf,
> > +                                      chip->oob_poi, index, eccfrag_le=
n);
> > +     if (ret)
> > +             return ret;
> > +
> > +     p =3D bufpoi + data_col_addr;
> > +     for (i =3D 0; i < eccfrag_len; i +=3D chip->ecc.bytes, p +=3D chi=
p->ecc.size) {
> > +             int stat;
> > +
> > +             stat =3D chip->ecc.correct(chip, p, &chip->ecc.code_buf[i=
],
> > +                                      &chip->ecc.calc_buf[i]);
> > +             if (stat)
> > +                     ls1x_nand_dump_regs(chip);
> > +
> > +             if (stat =3D=3D -EBADMSG &&
> > +                 (chip->ecc.options & NAND_ECC_GENERIC_ERASED_CHECK)) =
{
> > +                     /* check for empty pages with bitflips */
> > +                     stat =3D nand_check_erased_ecc_chunk(p, chip->ecc=
.size,
> > +                                                     &chip->ecc.code_b=
uf[i],
> > +                                                     chip->ecc.bytes,
> > +                                                     NULL, 0,
> > +                                                     chip->ecc.strengt=
h);
> > +             }
> > +
> > +             if (stat < 0) {
> > +                     mtd->ecc_stats.failed++;
> > +             } else {
> > +                     mtd->ecc_stats.corrected +=3D stat;
> > +                     max_bitflips =3D max_t(unsigned int, max_bitflips=
, stat);
> > +             }
> > +     }
> > +     return max_bitflips;
> > +}
> > +
> > +static int ls1x_nand_attach_chip(struct nand_chip *chip)
> > +{
> > +     struct ls1x_nand *nand =3D nand_get_controller_data(chip);
> > +     struct ls1x_nand_controller *nc =3D &nand->nc;
> > +     struct plat_ls1x_nand *pdata =3D nand->pdata;
> > +     int hold_cycle =3D pdata->hold_cycle;
> > +     int wait_cycle =3D pdata->wait_cycle;
> > +     u64 chipsize =3D nanddev_target_size(&chip->base);
> > +     int cell_size =3D 0;
> > +
>
> You should somehow be able to configure the controller to work in
> software mode or without ECC for debug purposes. Please add and test
> those two features.
>
will do.

> > +     switch (chipsize) {
> > +     case SZ_128M:
> > +             cell_size =3D 0x0;
> > +             break;
> > +     case SZ_256M:
> > +             cell_size =3D 0x1;
> > +             break;
> > +     case SZ_512M:
> > +             cell_size =3D 0x2;
> > +             break;
> > +     case SZ_1G:
> > +             cell_size =3D 0x3;
> > +             break;
> > +     case SZ_2G:
> > +             cell_size =3D 0x4;
> > +             break;
> > +     case SZ_4G:
> > +             cell_size =3D 0x5;
> > +             break;
> > +     case (SZ_2G * SZ_4G):   /*8G */
> > +             cell_size =3D 0x6;
> > +             break;
> > +     case (SZ_4G * SZ_4G):   /*16G */
> > +             cell_size =3D 0x7;
> > +             break;
> > +     default:
> > +             dev_err(nand->dev, "unsupported chip size: %llu MB\n",
> > +                     chipsize);
> > +             break;
> > +     }
> > +
> > +     if (hold_cycle && wait_cycle)
> > +             nand_writel(nc, NAND_TIMING,
> > +                         (hold_cycle << BITS_PER_BYTE) | wait_cycle);
> > +     nand_writel(nc, NAND_PARAM,
> > +                 (nand_readl(nc, NAND_PARAM) & ~SIZE_MASK) | cell_size=
 <<
> > +                 BITS_PER_BYTE);
>
> Please do this in three steps for readability:
>
> param =3D nand_readl()
> param |=3D cell_size...
> nand_writel()
>
will do.
> > +
> > +     chip->ecc.read_page_raw =3D nand_monolithic_read_page_raw;
> > +     chip->ecc.write_page_raw =3D nand_monolithic_write_page_raw;
>
> Nice :)
>
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct nand_controller_ops ls1x_nc_ops =3D {
> > +     .exec_op =3D ls1x_nand_exec_op,
> > +     .attach_chip =3D ls1x_nand_attach_chip,
> > +};
> > +
> > +static void ls1x_nand_controller_cleanup(struct ls1x_nand *nand)
> > +{
> > +     if (nand->nc.dma_chan)
> > +             dma_release_channel(nand->nc.dma_chan);
> > +}
> > +
> > +static int ls1x_nand_controller_init(struct ls1x_nand *nand,
> > +                                  struct platform_device *pdev)
> > +{
> > +     struct ls1x_nand_controller *nc =3D &nand->nc;
> > +     struct device *dev =3D &pdev->dev;
> > +     struct dma_slave_config cfg;
> > +     struct resource *res;
> > +     int ret;
> > +
> > +     nc->reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(nc->reg_base))
> > +             return PTR_ERR(nc->reg_base);
> > +
> > +     res =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
> > +     if (!res) {
> > +             dev_err(dev, "failed to get DMA information!\n");
> > +             return -ENXIO;
> > +     }
> > +
> > +     nc->dma_chan =3D dma_request_chan(dev, res->name);
> > +     if (!nc->dma_chan) {
> > +             dev_err(dev, "failed to request DMA channel!\n");
> > +             return -EBUSY;
> > +     }
> > +     dev_info(dev, "got %s for %s access\n",
> > +              dma_chan_name(nc->dma_chan), dev_name(dev));
> > +
> > +     cfg.src_addr =3D CPHYSADDR(nc->reg_base + NAND_DMA_ADDR);
> > +     cfg.dst_addr =3D CPHYSADDR(nc->reg_base + NAND_DMA_ADDR);
> > +     cfg.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +     cfg.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +     ret =3D dmaengine_slave_config(nc->dma_chan, &cfg);
> > +     if (ret) {
> > +             dev_err(dev, "failed to config DMA channel!\n");
> > +             dma_release_channel(nc->dma_chan);
> > +             return ret;
> > +     }
> > +
> > +     init_completion(&nc->dma_complete);
> > +
> > +     return 0;
> > +}
> > +
> > +static int ls1x_nand_chip_init(struct ls1x_nand *nand)
> > +{
> > +     struct nand_chip *chip =3D &nand->chip;
> > +     struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +     struct plat_ls1x_nand *pdata =3D nand->pdata;
> > +     int ret =3D 0;
> > +
> > +     chip->controller =3D &nand->controller;
> > +     chip->options =3D NAND_NO_SUBPAGE_WRITE | NAND_USES_DMA | NAND_BR=
OKEN_XD;
> > +     chip->buf_align =3D 16;
> > +     chip->ecc.engine_type =3D NAND_ECC_ENGINE_TYPE_SOFT;
> > +     chip->ecc.algo =3D NAND_ECC_ALGO_HAMMING;
>
> ECC configuration should only be done in ->attach_chip().
>
will do.

> > +     nand_set_controller_data(chip, nand);
> > +
> > +     mtd->dev.parent =3D nand->dev;
> > +     mtd->name =3D "ls1x-nand";
> > +     mtd->owner =3D THIS_MODULE;
> > +
> > +     ret =3D nand_scan(chip, 1);
> > +     if (ret)
> > +             return ret;
> > +
> > +     chip->ecc.read_subpage =3D ls1x_nand_read_subpage;
>
> Do you really need this? It looks like your implementation of
> read_subpage is very similar to the one from the core.
>
will remove this line.
> > +
> > +     ret =3D mtd_device_register(mtd, pdata->parts, pdata->nr_parts);
> > +     if (ret) {
> > +             dev_err(nand->dev, "failed to register MTD device! %d\n",=
 ret);
> > +             nand_cleanup(chip);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int ls1x_nand_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct plat_ls1x_nand *pdata;
> > +     struct ls1x_nand *nand;
>
> Please use another name for the variable, "nand"/"chip" is used by the
> core for the nand_chip structure, for yours you can name it eg ls1x or
> lsnand.
>
will do.

> > +     int ret;
> > +
> > +     pdata =3D dev_get_platdata(dev);
> > +     if (!pdata) {
> > +             dev_err(dev, "platform data missing!\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     nand =3D devm_kzalloc(dev, sizeof(*nand), GFP_KERNEL);
> > +     if (!nand)
> > +             return -ENOMEM;
> > +
> > +     nand->pdata =3D pdata;
> > +     nand->dev =3D dev;
> > +     nand->controller.ops =3D &ls1x_nc_ops;
> > +     nand_controller_init(&nand->controller);
> > +
> > +     ret =3D ls1x_nand_controller_init(nand, pdev);
>
> I'm not sure this deserves a helper (same for the chip init) but why
> not.
>
> > +     if (ret)
> > +             return ret;
> > +
> > +     nand->clk =3D devm_clk_get(dev, pdev->name);
> > +     if (IS_ERR(nand->clk)) {
> > +             dev_err(dev, "failed to get %s clock!\n", pdev->name);
> > +             return PTR_ERR(nand->clk);
> > +     }
> > +     clk_prepare_enable(nand->clk);
> > +
> > +     ret =3D ls1x_nand_chip_init(nand);
> > +     if (ret) {
> > +             clk_disable_unprepare(nand->clk);
> > +             goto err;
> > +     }
> > +
> > +     platform_set_drvdata(pdev, nand);
> > +     dev_info(dev, "Loongson1 NAND driver registered\n");
>
> I don't think this is useful, you can drop that trace.
>
will do.

> > +
> > +     return 0;
> > +err:
> > +     ls1x_nand_controller_cleanup(nand);
> > +     return ret;
> > +}
> > +
> > +static int ls1x_nand_remove(struct platform_device *pdev)
> > +{
> > +     struct ls1x_nand *nand =3D platform_get_drvdata(pdev);
> > +     struct nand_chip *chip =3D &nand->chip;
> > +
> > +     mtd_device_unregister(nand_to_mtd(chip));
>
> ret =3D mtd_device_unregister()
> WARN_ON(ret);
>
will do.

> > +     nand_cleanup(chip);
> > +     clk_disable_unprepare(nand->clk);
> > +     ls1x_nand_controller_cleanup(nand);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver ls1x_nand_driver =3D {
> > +     .probe  =3D ls1x_nand_probe,
> > +     .remove =3D ls1x_nand_remove,
> > +     .driver =3D {
> > +             .name   =3D "ls1x-nand",
>
> ls1x-nand-controller
>
Can I keep the name "ls1x-nand"?
Thanks!

> > +             .owner  =3D THIS_MODULE,
> > +     },
> > +};
> > +
> > +module_platform_driver(ls1x_nand_driver);
> > +
> > +MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
> > +MODULE_DESCRIPTION("Loongson1 NAND Flash driver");
> > +MODULE_LICENSE("GPL");
> >
> > base-commit: fd0d8d85f7230052e638a56d1bfea170c488e6bc
>
>
>
>
> Thanks,
> Miqu=C3=A8l
--
Best regards,

Kelvin Cheung
