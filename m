Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA1069251F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjBJSOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjBJSOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:14:03 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0D31CAFE;
        Fri, 10 Feb 2023 10:14:00 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id v17so9558076lfd.7;
        Fri, 10 Feb 2023 10:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6fl/5d3EeJ8pkGUsKS8xvNpayMLTpjQtlL2zDinVIs=;
        b=P6VVjD8lvZIi5iDXTPsMsYRpJ3uKowDCgy/nINCmS6wpJdJ0B3oABW2Ht3v1DjvpPv
         cf+EqYfh87mF03yy6AyxipNZwQ/4L77+lvQnVxQpFyXg8v9bn6izd5+LndjEV+nesnXW
         XU2eEArwcylgde+hrG2C0EOtDV8XuyQGUx38Ga1iFy5e8GWXixuLgxWrZB8vlI1OJhv8
         1/deG5sXQ6PuimxRG76FhTOMQ5vJqRKeqST2NZ1AVYrXJwqPLiPKEOmEAG7KgIEixHpk
         LiCOXABE1EWfowjvLNR5QlrMFtoyKai5du7vKyeFsusbS7pdDDWtcz4LaxC/bLxIYACv
         +yHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6fl/5d3EeJ8pkGUsKS8xvNpayMLTpjQtlL2zDinVIs=;
        b=W4HFJtaS9Kkd164XSz68DV1H9wKE+z3yl0n2s1baQUAoZ92tm3ORg8Uum4KQby42Nh
         vL6ko72V6rRauASYCDDtWIvydliTZVstL7KQETCS25Z3XTahQv1FafY0KDok4PGJhQ9O
         YLl3OveNGZYV+1WkQmwn/tKOombK/I9BIJnmhiLpfE4sO3GytHA29PNcoRYYSJz0S+3f
         U5/yNCRAWMNhpoDS5sX0UMSneWLrc9SHncJJOBxPds0UgereQOC+9uuo3p/jAbCe4ysO
         kiXcmbib5U9MtUCba8n1hD2nlv+iwSU0LBmpgeEj2olLh27K4xaiRkGJnU6w2J972JI9
         6ppQ==
X-Gm-Message-State: AO0yUKUqACxGg9sQvdMQ0cP5rPaUGl0qCOHr/FTW8dTHXIF9yTR6cfyS
        0iZwxZ1nkvZ9Bih7+i1JuB3mluAu3PY=
X-Google-Smtp-Source: AK7set9BkUhSYyYHwq8dDl+AgasR3JdDH2EsLWimHHr6sLd9hpYBBjiPKItUXXeNA56rIzb4uFkTgg==
X-Received: by 2002:a05:6512:924:b0:4a4:68b8:9c35 with SMTP id f4-20020a056512092400b004a468b89c35mr4384848lft.29.1676052838810;
        Fri, 10 Feb 2023 10:13:58 -0800 (PST)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id g23-20020ac25397000000b004d61af6771dsm381798lfh.41.2023.02.10.10.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 10:13:58 -0800 (PST)
Date:   Fri, 10 Feb 2023 21:13:55 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     caihuoqing <caihuoqing@baidu.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 3/3] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <20230210181355.oy5hlfacjgsldwjz@mobilestation.baikal.int>
References: <20220921064859.10328-1-cai.huoqing@linux.dev>
 <20220921064859.10328-4-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921064859.10328-4-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 02:48:52PM +0800, Cai Huoqing wrote:
> From: caihuoqing <caihuoqing@baidu.com>
> 
> Add support for HDMA NATIVE, as long the IP design has set
> the compatible register map parameter-HDMA_NATIVE,
> which allows compatibility for native HDMA register configuration.
> 
> The HDMA Hyper-DMA IP is an enhancement of the eDMA embedded-DMA IP.
> And the native HDMA registers are different from eDMA,
> so this patch add support for HDMA NATIVE mode.
> 
> HDMA write and read channels operate independently to maximize
> the performance of the HDMA read and write data transfer over
> the link When you configure the HDMA with multiple read channels,
> then it uses a round robin (RR) arbitration scheme to select
> the next read channel to be serviced.
> The same applies when you have multiple write channels.
> 
> The native HDMA driver also supports a maximum of 16 independent
> channels (8 write + 8 read), which can run simultaneously.
> Both SAR (Source Address Register) and DAR (Destination Address Register)
> are alignmented to byte.
> 
> Signed-off-by: caihuoqing <caihuoqing@baidu.com>
> ---
>  drivers/dma/dw-edma/Makefile             |   6 +-
>  drivers/dma/dw-edma/dw-edma-core.c       |   6 +-
>  drivers/dma/dw-edma/dw-hdma-v0-core.c    | 308 +++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.h    |  17 ++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 150 +++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h |  22 ++
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h    |  98 ++++++++
>  include/linux/dma/edma.h                 |   3 +-
>  8 files changed, 606 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h
> 
> diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
> index 8d45c0d5689d..958e7f202d11 100644
> --- a/drivers/dma/dw-edma/Makefile
> +++ b/drivers/dma/dw-edma/Makefile
> @@ -1,7 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_DW_EDMA)		+= dw-edma.o
> -dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o
> +dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o \
> +				   dw-hdma-v0-debugfs.o
>  dw-edma-objs			:= dw-edma-core.o \
> -					dw-edma-v0-core.o $(dw-edma-y)
> +				   dw-edma-v0-core.o \
> +				   dw-hdma-v0-core.o $(dw-edma-y)
>  obj-$(CONFIG_DW_EDMA_PCIE)	+= dw-edma-pcie.o
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index a66e4216a5d3..59c71e5cc8f6 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -19,6 +19,7 @@
>  
>  #include "dw-edma-core.h"
>  #include "dw-edma-v0-core.h"
> +#include "dw-hdma-v0-core.h"
>  #include "../dmaengine.h"
>  #include "../virt-dma.h"
>  
> @@ -952,7 +953,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  
>  	dw->chip = chip;
>  
> -	dw_edma_v0_core_register(dw);
> +	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE)
> +		dw_hdma_v0_core_register(dw);
> +	else
> +		dw_edma_v0_core_register(dw);
>  
>  	raw_spin_lock_init(&dw->lock);
>  
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> new file mode 100644
> index 000000000000..4ed6881bf3e9
> --- /dev/null
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -0,0 +1,308 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Cai Huoqing
> + * Synopsys DesignWare HDMA v0 core
> + */
> +
> +#include <linux/bitfield.h>
> +
> +#include "dw-edma-core.h"

> +#include "dw-edma-v0-core.h"
> +#include "dw-edma-v0-regs.h"

Do you need these headers here?

> +#include "dw-hdma-v0-core.h"
> +#include "dw-hdma-v0-regs.h"
> +#include "dw-hdma-v0-debugfs.h"
> +
> +enum dw_hdma_control {
> +	DW_HDMA_V0_CB					= BIT(0),
> +	DW_HDMA_V0_TCB					= BIT(1),
> +	DW_HDMA_V0_LLP					= BIT(2),
> +	DW_HDMA_V0_LIE					= BIT(3),
> +	DW_HDMA_V0_RIE					= BIT(4),
> +	DW_HDMA_V0_CCS					= BIT(8),
> +	DW_HDMA_V0_LLE					= BIT(9),
> +};
> +static inline struct dw_hdma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
> +{
> +	return dw->chip->reg_base;
> +}
> +
> +static inline struct dw_hdma_v0_ch_regs __iomem *
> +__dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
> +{
> +
> +	if (dir == EDMA_DIR_WRITE)
> +		return &(__dw_regs(dw)->ch[ch].wr);
> +	else
> +		return &(__dw_regs(dw)->ch[ch].rd);
> +}
> +
> +#define SET_CH_32(dw, dir, ch, name, value) \
> +	writel(value, &(__dw_ch_regs(dw, dir, ch)->name))
> +
> +#define GET_CH_32(dw, dir, ch, name) \
> +	readl(&(__dw_ch_regs(dw, dir, ch)->name))
> +
> +#define SET_BOTH_CH_32(dw, ch, name, value) \
> +	do {					\
> +		writel(value, &(__dw_ch_regs(dw, EDMA_DIR_WRITE, ch)->name));		\
> +		writel(value, &(__dw_ch_regs(dw, EDMA_DIR_READ, ch)->name));	\
> +	} while (0)
> +

> +#define SET_LL_32(ll, value) \
> +	writel(value, ll)

This macro is no longer value since the linked-list descriptors are
now located on the CPU memory. Please see the patch
https://lore.kernel.org/linux-pci/20230113171409.30470-24-Sergey.Semin@baikalelectronics.ru/
which is already in the @Bjron tree for being merged on the next
m-window.

> +
> +/* HDMA management callbacks */
> +static void dw_hdma_v0_core_off(struct dw_edma *dw)
> +{
> +	int id;
> +
> +	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
> +		SET_BOTH_CH_32(dw, id, int_setup,
> +				HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +		SET_BOTH_CH_32(dw, id, int_clear,

> +				HDMA_V0_STOP_INT_MASK & HDMA_V0_ABORT_INT_MASK);
                                                      ^
Shouldn't '|' be here instead? -----------------------+

> +		SET_BOTH_CH_32(dw, id, ch_en, 0);
> +	}
> +}
> +
> +static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
> +{
> +	u32 num_ch = 0;
> +	int id;
> +
> +	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
> +		if (GET_CH_32(dw, id, dir, ch_en) & BIT(0))
> +			num_ch++;
> +	}
> +
> +	if (num_ch > HDMA_V0_MAX_NR_CH)
> +		num_ch = HDMA_V0_MAX_NR_CH;
> +
> +	return (u16)num_ch;
> +}
> +
> +static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
> +{
> +	struct dw_edma *dw = chan->dw;
> +	u32 tmp;
> +
> +	tmp = FIELD_GET(HDMA_V0_CH_STATUS_MASK,
> +			GET_CH_32(dw, chan->id, chan->dir, ch_stat));
> +
> +	if (tmp == 1)
> +		return DMA_IN_PROGRESS;
> +	else if (tmp == 3)
> +		return DMA_COMPLETE;
> +	else
> +		return DMA_ERROR;
> +}
> +
> +static void dw_hdma_v0_core_clear_done_int(struct dw_edma_chan *chan)
> +{
> +	struct dw_edma *dw = chan->dw;
> +
> +	SET_CH_32(dw, chan->dir, chan->id, int_clear, HDMA_V0_STOP_INT_MASK);
> +}
> +
> +static void dw_hdma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
> +{
> +	struct dw_edma *dw = chan->dw;
> +
> +	SET_CH_32(dw, chan->dir, chan->id, int_clear, HDMA_V0_ABORT_INT_MASK);
> +}
> +
> +static u32 dw_hdma_v0_core_status_int(struct dw_edma_chan *chan)
> +{
> +	struct dw_edma *dw = chan->dw;
> +
> +	return GET_CH_32(dw, chan->dir, chan->id, int_stat);
> +}
> +
> +static u32 dw_hdma_v0_core_check_done_int(u32 val)
> +{

> +	return (FIELD_GET(HDMA_V0_STOP_INT_MASK, val) == BIT(0));
> +}
> +
> +static u32 dw_hdma_v0_core_check_abort_int(u32 val)
> +{
> +	return (FIELD_GET(HDMA_V0_ABORT_INT_MASK, val) == BIT(0));

Em, what about
return FIELD_GET(HDMA_V0_*_INT_MASK, val);
?

> +}
> +
> +static
> +void dw_hdma_v0_core_done_handle(struct dw_edma_irq *dw_irq,
> +							void (*done_cb)(struct dw_edma_chan *chan),
> +							enum dw_edma_dir dir)
> +{
> +	struct dw_edma *dw = dw_irq->dw;
> +	unsigned long total, pos, val;
> +	unsigned long off, mask;
> +
> +	if (dir == EDMA_DIR_WRITE) {
> +		total = dw->wr_ch_cnt;
> +		off = 0;
> +		mask = dw_irq->wr_mask;
> +	} else {
> +		total = dw->rd_ch_cnt;
> +		off = dw->wr_ch_cnt;
> +		mask = dw_irq->rd_mask;
> +	}
> +
> +	for_each_set_bit(pos, &mask, total) {
> +		struct dw_edma_chan *chan = &dw->chan[pos + off];
> +
> +		val = dw_hdma_v0_core_status_int(chan);
> +		if (dw_hdma_v0_core_check_done_int(val))
> +			done_cb(chan);
> +	}
> +}
> +
> +static
> +void dw_hdma_v0_core_abort_handle(struct dw_edma_irq *dw_irq,
> +							void (*abort_cb)(struct dw_edma_chan *chan),
> +							enum dw_edma_dir dir)
> +{
> +	struct dw_edma *dw = dw_irq->dw;
> +	unsigned long total, pos, val;
> +	unsigned long off, mask;
> +
> +	if (dir == EDMA_DIR_WRITE) {
> +		total = dw->wr_ch_cnt;
> +		off = 0;
> +		mask = dw_irq->wr_mask;
> +	} else {
> +		total = dw->rd_ch_cnt;
> +		off = dw->wr_ch_cnt;
> +		mask = dw_irq->rd_mask;
> +	}
> +
> +	for_each_set_bit(pos, &mask, total) {
> +		struct dw_edma_chan *chan = &dw->chan[pos + off];
> +
> +		val = dw_hdma_v0_core_status_int(chan);
> +		if (dw_hdma_v0_core_check_abort_int(val))
> +			abort_cb(chan);
> +	}
> +}
> +
> +static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> +{
> +	struct dw_edma_burst *child;
> +	struct dw_edma_chan *chan = chunk->chan;
> +	struct dw_edma_v0_lli __iomem *lli;
> +	struct dw_edma_v0_llp __iomem *llp;
> +	u32 control = 0, i = 0;
> +	int j;
> +
> +	lli = chunk->ll_region.vaddr;
> +
> +	if (chunk->cb)
> +		control = DW_HDMA_V0_CB;
> +
> +	j = chunk->bursts_alloc;
> +	list_for_each_entry(child, &chunk->burst->list, list) {
> +		j--;
> +		if (!j) {
> +			control |= DW_HDMA_V0_LIE;
> +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +				control |= DW_HDMA_V0_RIE;
> +		}

> +		/* Channel control */
> +		SET_LL_32(&lli[i].control, control);
> +		/* Transfer size */
> +		SET_LL_32(&lli[i].transfer_size, child->sz);
> +		/* SAR */
> +		SET_LL_32(&lli[i].sar.lsb, lower_32_bits(child->sar));
> +		SET_LL_32(&lli[i].sar.msb, upper_32_bits(child->sar));
> +		/* DAR */
> +		SET_LL_32(&lli[i].dar.lsb, lower_32_bits(child->dar));
> +		SET_LL_32(&lli[i].dar.msb, upper_32_bits(child->dar));
> +		i++;
> +	}
> +
> +	llp = (void __iomem *)&lli[i];
> +	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
> +	if (!chunk->cb)
> +		control |= DW_HDMA_V0_CB;
> +
> +	/* Channel control */
> +	SET_LL_32(&llp->control, control);
> +	/* Linked list */
> +	SET_LL_32(&llp->llp.lsb, lower_32_bits(chunk->ll_region.paddr));
> +	SET_LL_32(&llp->llp.msb, upper_32_bits(chunk->ll_region.paddr));

Please see the way the LL access is now implemented for eDMA:
https://lore.kernel.org/linux-pci/20230113171409.30470-24-Sergey.Semin@baikalelectronics.ru/
The eDMA v0 core now supports the LL descriptors placed on the CPU memory.
This driver should be properly fixed too.

> +}
> +
> +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> +{
> +	struct dw_edma_chan *chan = chunk->chan;
> +	struct dw_edma *dw = chan->dw;
> +	u32 tmp;
> +
> +	dw_hdma_v0_core_write_chunk(chunk);
> +
> +	if (first) {
> +		/* Enable engine */
> +		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
> +		/* Interrupt enable&unmask - done, abort */
> +		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);

> +		tmp |= HDMA_V0_STOP_INT_MASK;
> +		tmp |= HDMA_V0_ABORT_INT_MASK;
> +		tmp |= HDMA_V0_LOCAL_ABORT_INT_EN;
> +		tmp |= HDMA_V0_LOCAL_STOP_INT_EN;

Using multiple bitwise-OR ops seems a bit more robust then multiple
'|=' ops since the constants will be combined on compile-time.

> +		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
> +		/* Channel control */
> +		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
> +		/* Linked list */
> +		/* llp is not aligned on 64bit -> keep 32bit accesses */
> +		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
> +			  lower_32_bits(chunk->ll_region.paddr));
> +		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
> +			  upper_32_bits(chunk->ll_region.paddr));
> +	}
> +	/* set consumer cycle */
> +	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
> +			  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
> +	/* Doorbell */
> +	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
> +}
> +
> +static int dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
> +{
> +	struct dw_edma *dw = chan->dw;
> +
> +	/* MSI done addr - low, high */
> +	SET_CH_32(dw, chan->dir, chan->id, msi_stop.lsb, chan->msi.address_lo);
> +	SET_CH_32(dw, chan->dir, chan->id, msi_stop.msb, chan->msi.address_hi);
> +	/* MSI abort addr - low, high */
> +	SET_CH_32(dw, chan->dir, chan->id, msi_abort.lsb, chan->msi.address_lo);

> +	SET_CH_32(dw, chan->dir, chan->id, msi_abort.msb, chan->msi.address_hi);
> +	SET_CH_32(dw, chan->dir, chan->id, msi_abort.msb, chan->msi.address_hi);

Two identical lines. Typo?

> +	/* config MSI data */
> +	SET_CH_32(dw, chan->dir, chan->id, msi_msgdata, chan->msi.data);
> +
> +	return 0;
> +}
> +
> +/* eDMA debugfs callbacks */
> +static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
> +{
> +	dw_hdma_v0_debugfs_on(dw);
> +}
> +
> +static const struct dw_edma_core_ops hdma_core = {
> +	.dw_xdma_core_off = dw_hdma_v0_core_off,
> +	.dw_xdma_core_ch_count = dw_hdma_v0_core_ch_count,
> +	.dw_xdma_core_ch_status = dw_hdma_v0_core_ch_status,
> +	.dw_xdma_core_clear_done_int = dw_hdma_v0_core_clear_done_int,
> +	.dw_xdma_core_clear_abort_int = dw_hdma_v0_core_clear_abort_int,
> +	.dw_xdma_core_done_handle = dw_hdma_v0_core_done_handle,
> +	.dw_xdma_core_abort_handle = dw_hdma_v0_core_abort_handle,
> +	.dw_xdma_core_start = dw_hdma_v0_core_start,
> +	.dw_xdma_core_ch_config = dw_hdma_v0_core_ch_config,
> +	.dw_xdma_core_debugfs_on = dw_hdma_v0_core_debugfs_on,
> +};
> +
> +void dw_hdma_v0_core_register(struct dw_edma *dw)
> +{
> +	dw->core = &hdma_core;
> +}
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.h b/drivers/dma/dw-edma/dw-hdma-v0-core.h
> new file mode 100644
> index 000000000000..dc9b93e469ae
> --- /dev/null
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2022 Cai Huoqing
> + * Synopsys DesignWare HDMA v0 core
> + *
> + * Author: Cai Huoqing <cai.huoqing@linux.dev>
> + */
> +
> +#ifndef _DW_HDMA_V0_CORE_H
> +#define _DW_HDMA_V0_CORE_H
> +
> +#include <linux/dma/edma.h>
> +
> +/* HDMA core operation register*/
> +void dw_hdma_v0_core_register(struct dw_edma *dw);
> +
> +#endif /* _DW_HDMA_V0_CORE_H */
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> new file mode 100644
> index 000000000000..1f973b21eef9

> --- /dev/null
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c

Please see the way the module now looks in the @Bjorn tree and
refactor your DebugFS part being similar. Currently due to the way
your driver is designed it's impossible to register more than one HDMA
device in the system.

> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Cai Huoqing
> + * Synopsys DesignWare HDMA v0 debugfs
> + *
> + * Author: Cai Huoqing <cai.huoqing@linux.dev>
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/bitfield.h>
> +
> +#include "dw-hdma-v0-debugfs.h"
> +#include "dw-hdma-v0-regs.h"
> +#include "dw-edma-core.h"
> +
> +#define REGS_ADDR(name) \
> +	((void __force *)&regs->name)
> +
> +#define REGISTER(name) \
> +	{ #name, REGS_ADDR(name) }
> +
> +#define WRITE_STR				"write"
> +#define READ_STR				"read"
> +#define CHANNEL_STR				"channel"
> +#define REGISTERS_STR				"registers"
> +
> +static struct dw_edma				*dw;
> +static struct dw_hdma_v0_regs			__iomem *regs;

Empty line please.

> +struct debugfs_entries {
> +	const char				*name;
> +	dma_addr_t				*reg;
> +};
> +
> +static int dw_hdma_debugfs_u32_get(void *data, u64 *val)
> +{
> +	void __iomem *reg = (void __force __iomem *)data;
> +	*val = readl(reg);
> +
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_hdma_debugfs_u32_get, NULL, "0x%08llx\n");
> +
> +static void dw_hdma_debugfs_create_x32(const struct debugfs_entries entries[],
> +				       int nr_entries, struct dentry *dir)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_entries; i++) {
> +		if (!debugfs_create_file_unsafe(entries[i].name, 0444, dir,
> +						entries[i].reg,	&fops_x32))
> +			break;
> +	}
> +}
> +
> +static void dw_hdma_debugfs_regs_ch(struct dw_hdma_v0_ch_regs __iomem *regs,
> +				    struct dentry *dir)
> +{
> +	int nr_entries;
> +	const struct debugfs_entries debugfs_regs[] = {
> +		REGISTER(ch_en),
> +		REGISTER(doorbell),
> +		REGISTER(llp.lsb),
> +		REGISTER(llp.msb),
> +		REGISTER(cycle_sync),
> +		REGISTER(transfer_size),
> +		REGISTER(sar.lsb),
> +		REGISTER(sar.msb),
> +		REGISTER(dar.lsb),
> +		REGISTER(dar.msb),
> +		REGISTER(control1),
> +		REGISTER(ch_stat),
> +		REGISTER(int_stat),
> +		REGISTER(int_setup),
> +		REGISTER(int_clear),
> +		REGISTER(msi_stop.lsb),
> +		REGISTER(msi_stop.msb),
> +		REGISTER(msi_abort.lsb),
> +		REGISTER(msi_abort.msb),
> +		REGISTER(msi_msgdata),
> +	};
> +
> +	nr_entries = ARRAY_SIZE(debugfs_regs);
> +	dw_hdma_debugfs_create_x32(debugfs_regs, nr_entries, dir);
> +}
> +
> +static void dw_hdma_debugfs_regs_wr(struct dentry *dir)
> +{
> +	struct dentry *regs_dir, *ch_dir;
> +	int i;
> +	char name[16];
> +
> +	regs_dir = debugfs_create_dir(WRITE_STR, dir);
> +	if (!regs_dir)
> +		return;
> +
> +	for (i = 0; i < dw->wr_ch_cnt; i++) {
> +		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
> +
> +		ch_dir = debugfs_create_dir(name, regs_dir);
> +		if (!ch_dir)
> +			return;
> +
> +		dw_hdma_debugfs_regs_ch(&regs->ch[i].wr, ch_dir);
> +	}
> +}
> +
> +static void dw_hdma_debugfs_regs_rd(struct dentry *dir)
> +{
> +	struct dentry *regs_dir, *ch_dir;
> +	int i;
> +	char name[16];
> +
> +	regs_dir = debugfs_create_dir(READ_STR, dir);
> +	if (!regs_dir)
> +		return;
> +
> +	for (i = 0; i < dw->rd_ch_cnt; i++) {
> +		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
> +
> +		ch_dir = debugfs_create_dir(name, regs_dir);
> +		if (!ch_dir)
> +			return;
> +
> +		dw_hdma_debugfs_regs_ch(&regs->ch[i].rd, ch_dir);
> +	}
> +}
> +
> +static void dw_hdma_debugfs_regs(void)
> +{
> +	struct dentry *regs_dir;
> +
> +	regs_dir = debugfs_create_dir(REGISTERS_STR, dw->dma.dbg_dev_root);
> +	if (!regs_dir)
> +		return;
> +
> +	dw_hdma_debugfs_regs_wr(regs_dir);
> +	dw_hdma_debugfs_regs_rd(regs_dir);
> +}
> +
> +void dw_hdma_v0_debugfs_on(struct dw_edma *dw)
> +{
> +	if (!debugfs_initialized())
> +		return;
> +
> +	debugfs_create_u32("mf", 0444, dw->dma.dbg_dev_root, &dw->chip->mf);
> +	debugfs_create_u16("wr_ch_cnt", 0444, dw->dma.dbg_dev_root, &dw->wr_ch_cnt);
> +	debugfs_create_u16("rd_ch_cnt", 0444, dw->dma.dbg_dev_root, &dw->rd_ch_cnt);
> +
> +	dw_hdma_debugfs_regs();
> +}
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.h b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
> new file mode 100644
> index 000000000000..4b70911aedac
> --- /dev/null
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2022 Cai Huoqing
> + * Synopsys DesignWare HDMA v0 debugfs
> + *
> + * Author: Cai Huoqing <cai.huoqing@linux.dev>
> + */
> +
> +#ifndef _DW_HDMA_V0_DEBUG_FS_H
> +#define _DW_HDMA_V0_DEBUG_FS_H
> +
> +#include <linux/dma/edma.h>
> +
> +#ifdef CONFIG_DEBUG_FS
> +void dw_hdma_v0_debugfs_on(struct dw_edma *dw);
> +#else
> +static inline void dw_hdma_v0_debugfs_on(struct dw_edma *dw)
> +{
> +}
> +#endif /* CONFIG_DEBUG_FS */
> +
> +#endif /* _DW_HDMA_V0_DEBUG_FS_H */
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> new file mode 100644
> index 000000000000..677bf44400b3
> --- /dev/null
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -0,0 +1,98 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2022 Cai Huoqing
> + * Synopsys DesignWare HDMA v0 reg
> + *
> + * Author: Cai Huoqing <cai.huoqing@linux.dev>
> + */
> +
> +#ifndef _DW_HDMA_V0_REGS_H
> +#define _DW_HDMA_V0_REGS_H
> +
> +#include <linux/dmaengine.h>
> +

> +#define HDMA_V0_MAX_NR_CH					8

Remove one redundant tab

> +#define HDMA_V0_LOCAL_ABORT_INT_EN			BIT(6)
> +#define HDMA_V0_REMOTE_ABORT_INT_EN			BIT(5)
> +#define HDMA_V0_LOCAL_STOP_INT_EN			BIT(4)
> +#define HDMA_V0_REMOTEL_STOP_INT_EN			BIT(3)
> +#define HDMA_V0_ABORT_INT_MASK				BIT(2)
> +#define HDMA_V0_STOP_INT_MASK				BIT(0)

> +#define HDMA_V0_LINKLIST_EN					BIT(0)

ditto

> +#define HDMA_V0_CONSUMER_CYCLE_STAT			BIT(1)
> +#define HDMA_V0_CONSUMER_CYCLE_BIT			BIT(0)
> +#define HDMA_V0_DOORBELL_START				BIT(0)
> +#define HDMA_V0_CH_STATUS_MASK				GENMASK(1, 0)
> +

> +struct dw_hdma_v0_ch_regs {
> +	u32 ch_en;					/* 0x0000 */

Please make sure all the inline comments are aligned along a single
vertical line. The comments jump out of line here and there.

> +	u32 doorbell;				/* 0x0004 */
> +	u32 prefetch;				/* 0x0008 */
> +	u32 handshake;				/* 0x000c */
> +	union {
> +		u64 reg;				/* 0x0010..0x0014 */
> +		struct {
> +			u32 lsb;			/* 0x0010 */
> +			u32 msb;			/* 0x0014 */
> +		};
> +	} llp;
> +	u32 cycle_sync;				/* 0x0018 */
> +	u32 transfer_size;			/* 0x001c */
> +	union {
> +		u64 reg;				/* 0x0020..0x0024 */
> +		struct {
> +			u32 lsb;			/* 0x0020 */
> +			u32 msb;			/* 0x0024 */
> +		};
> +	} sar;
> +	union {
> +		u64 reg;				/* 0x0028..0x002c */
> +		struct {
> +			u32 lsb;			/* 0x0028 */
> +			u32 msb;			/* 0x002c */
> +		};
> +	} dar;
> +
> +	u32 watermark_en;			/* 0x0030 */

> +	u32	control1;				/* 0x0034 */
> +	u32	func_num;				/* 0x0038 */
> +	u32	qos;					/* 0x003c */
> +	u32	reserved;				/* 0x0040..0x007c */

Use spaces instead of tabs in the field declaration in the same way
as it's done for the rest of the fields.

> +	u32 ch_stat;				/* 0x0080 */
> +	u32 int_stat;				/* 0x0084 */
> +	u32 int_setup;				/* 0x0088 */
> +	u32 int_clear;				/* 0x008c */
> +	union {
> +		u64 reg;				/* 0x0090..0x0094 */
> +		struct {
> +			u32 lsb;			/* 0x0090 */
> +			u32 msb;			/* 0x0094 */
> +		};
> +	} msi_stop;
> +	union {
> +		u64 reg;				/* 0x0098..0x009c */
> +		struct {
> +			u32 lsb;			/* 0x0098 */
> +			u32 msb;			/* 0x009c */
> +		};
> +	} msi_watermark;
> +	union {
> +		u64 reg;				/* 0x00a0..0x00a4 */
> +		struct {
> +			u32 lsb;			/* 0x00a0 */
> +			u32 msb;			/* 0x00a4 */
> +		};
> +	} msi_abort;

> +	u32	msi_msgdata;			/* 0x00a8 */

ditto

> +} __packed;
> +
> +struct dw_hdma_v0_ch {
> +	struct dw_hdma_v0_ch_regs wr;			/* 0x0000 */
> +	struct dw_hdma_v0_ch_regs rd;			/* 0x0100 */
> +} __packed;
> +
> +struct dw_hdma_v0_regs {
> +	struct dw_hdma_v0_ch ch[HDMA_V0_MAX_NR_CH]; /* 0x0000..0x0fa8 */
> +} __packed;
> +
> +#endif /* _DW_HDMA_V0_REGS_H */
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 642dd325259b..b879d107f08b 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -45,7 +45,8 @@ struct dw_edma_plat_ops {
>  enum dw_edma_map_format {
>  	EDMA_MF_EDMA_LEGACY = 0x0,
>  	EDMA_MF_EDMA_UNROLL = 0x1,
> -	EDMA_MF_HDMA_COMPAT = 0x5
> +	EDMA_MF_HDMA_COMPAT = 0x5,

> +	EDMA_MF_HDMA_NATIVE = 0x7

Please add terminating comma here.

-Serge(y)

>  };
>  
>  /**
> -- 
> 2.25.1
> 
