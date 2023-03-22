Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452596C4252
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCVFoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVFoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:44:13 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC54B50F9F;
        Tue, 21 Mar 2023 22:44:11 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y15so21932204lfa.7;
        Tue, 21 Mar 2023 22:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679463850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bBDCvjEtrSCruS7p9E87rfPbvgy6/5lepHV7zT4R/NE=;
        b=U6FnXg+8AgMDqNKa8qzEy0l6ewbar4Bm0oHKFbMnBJGwufjwz2HMuoYwhHoenbBOHN
         nyPnIWJu1MVhiWKElTcyRHdUvCLb0TCHi1J+Nn036IUyHFcj4dCmok7XUpyC93Rmzuuh
         8kBKiYqnBUu9fjZHxLEIjBWqrYxGrcFk2cWd4r+J8ogD9id0aGuUjhuQIh5/esUX1YNK
         yezOsYEA202QgnI5uyyZd9qeyszsSoUlUUESHOWbxs9hIj+g4SUURtN7K2bIeGc+88fZ
         a/5RbUgmQehp1251J630GYnTHorWAVnRiEmDB+M53H1i8/jEuh9GGFra1DIj/KC/pvGD
         3uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679463850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBDCvjEtrSCruS7p9E87rfPbvgy6/5lepHV7zT4R/NE=;
        b=QskTIvRVE1ZVkrELqH8wZaF8GruNzV0Tlm0GmSlT+OtfGde8Dwd5SYUB/NSVCRxZhq
         mcK9s7kPBiImCacxNc0yhZs74EHUWs/TE8uLs36pfqH7w9ykHneOuQNIAE9kxm1y5NRo
         nr+LEV0ozYWk1AZDb5pD6xroj30ZwoLUe79FS2vlFmA+unmhwZjhsM8UHou2FVxz8snO
         gc6rxm9vhJb32RHUtl3W9t7+qXCwfiYUu+wJON22/cmomZKjoHKjvnouB4g0YTUzo7R5
         uKRVufbKpNNhDaRMk8V34IHjQZJercBxN4wCX0XQM71gaR8DqfpUP2Z2tYz3vOcLE37W
         ISsQ==
X-Gm-Message-State: AO0yUKVuOOAn5XeDMZMMupq8L07GtlBkIrAam0KnWDmFwAwUtPs2oic6
        G3yWkwZf/yCnBIjuyeUvN85Fci1udj4=
X-Google-Smtp-Source: AK7set/H0oOwL491upr7gD7LJoPA5OUFCXLn8/OzRqVWX5tyH5rZB1myVULMcTwvEkGFdhdpmQMtJw==
X-Received: by 2002:ac2:511b:0:b0:4db:1bab:98a4 with SMTP id q27-20020ac2511b000000b004db1bab98a4mr1655946lfb.32.1679463849697;
        Tue, 21 Mar 2023 22:44:09 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651204c200b004da8d947c57sm2473265lfq.149.2023.03.21.22.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 22:44:08 -0700 (PDT)
Date:   Wed, 22 Mar 2023 08:44:06 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 4/5] dmaengine: dw-edma: Add HDMA DebugFS support
Message-ID: <20230322054406.qmir7abj3vytd2lw@mobilestation>
References: <20230315012840.6986-1-cai.huoqing@linux.dev>
 <20230315012840.6986-5-cai.huoqing@linux.dev>
 <20230320115323.rqirpbvvfmibqqry@mobilestation>
 <ZBpzY1aoIAbHl8X/@chq-MS-7D45>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBpzY1aoIAbHl8X/@chq-MS-7D45>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 11:17:55AM +0800, Cai Huoqing wrote:
> On 20 3月 23 14:53:23, Serge Semin wrote:
> > On Wed, Mar 15, 2023 at 09:28:35AM +0800, Cai Huoqing wrote:
> > > From: Cai huoqing <cai.huoqing@linux.dev>
> > > 
> > > Add HDMA DebugFS support to show register information
> > > 
> > > Signed-off-by: Cai huoqing <cai.huoqing@linux.dev>
> > > ---
> > > v6->v7:
> > >   1.Move the change of register file from patch[4/5] to patch[3/5].
> > > v6 link:
> > >   https://lore.kernel.org/lkml/20230310032342.17395-5-cai.huoqing@linux.dev/
> > > 
> > >  drivers/dma/dw-edma/Makefile             |   3 +-
> > >  drivers/dma/dw-edma/dw-hdma-v0-core.c    |   2 +
> > >  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 176 +++++++++++++++++++++++
> > >  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h |  22 +++
> > >  4 files changed, 202 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> > >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
> > > 
> > > diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
> > > index b1c91ef2c63d..83ab58f87760 100644
> > > --- a/drivers/dma/dw-edma/Makefile
> > > +++ b/drivers/dma/dw-edma/Makefile
> > > @@ -1,7 +1,8 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  
> > >  obj-$(CONFIG_DW_EDMA)		+= dw-edma.o
> > > -dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o
> > > +dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o	\
> > > +				   dw-hdma-v0-debugfs.o
> > >  dw-edma-objs			:= dw-edma-core.o	\
> > >  				   dw-edma-v0-core.o	\
> > >  				   dw-hdma-v0-core.o $(dw-edma-y)
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > index cf274231cda9..b540c9ad7dfb 100644
> > > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > @@ -11,6 +11,7 @@
> > >  #include "dw-edma-core.h"
> > >  #include "dw-hdma-v0-core.h"
> > >  #include "dw-hdma-v0-regs.h"
> > > +#include "dw-hdma-v0-debugfs.h"
> > >  
> > >  enum dw_hdma_control {
> > >  	DW_HDMA_V0_CB					= BIT(0),
> > > @@ -257,6 +258,7 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
> > >  /* HDMA debugfs callbacks */
> > >  static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
> > >  {
> > > +	dw_hdma_v0_debugfs_on(dw);
> > >  }
> > >  
> > >  static const struct dw_edma_core_ops dw_hdma_v0_core = {
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> > > new file mode 100644
> > > index 000000000000..f2082b1bf72a
> > > --- /dev/null
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> > > @@ -0,0 +1,176 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2023 Cai Huoqing
> > > + * Synopsys DesignWare HDMA v0 debugfs
> > > + *
> > > + * Author: Cai Huoqing <cai.huoqing@linux.dev>
> > > + */
> > > +
> > > +#include <linux/debugfs.h>
> > > +#include <linux/bitfield.h>
> > > +
> > > +#include "dw-hdma-v0-debugfs.h"
> > > +#include "dw-hdma-v0-regs.h"
> > > +#include "dw-edma-core.h"
> > > +
> > > +#define REGS_ADDR(dw, name)						       \
> > > +	({								       \
> > > +		struct dw_hdma_v0_regs __iomem *__regs = (dw)->chip->reg_base; \
> > > +									       \
> > > +		(void __iomem *)&__regs->name;				       \
> > > +	})
> > > +
> > > +#define REGS_CH_ADDR(dw, name, _dir, _ch)				       \
> > > +	({								       \
> > > +		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;		       \
> > > +									       \
> > > +		if (_dir == EDMA_DIR_READ)				       \
> > > +			__ch_regs = REGS_ADDR(dw, ch[_ch].rd);		       \
> > > +		else							       \
> > > +			__ch_regs = REGS_ADDR(dw, ch[_ch].wr);		       \
> > > +									       \
> > > +		(void __iomem *)&__ch_regs->name;			       \
> > > +	})
> > > +
> > > +#define CTX_REGISTER(dw, name, dir, ch) \
> > > +	{ dw, #name, REGS_CH_ADDR(dw, name, dir, ch), dir, ch }
> > > +
> > > +#define REGISTER(dw, name) \
> > > +	{ dw, #name, REGS_ADDR(dw, name) }
> > > +
> > > +#define WRITE_STR				"write"
> > > +#define READ_STR				"read"
> > > +#define CHANNEL_STR				"channel"
> > > +#define REGISTERS_STR				"registers"
> > > +
> > > +struct dw_hdma_debugfs_entry {
> > > +	struct dw_edma				*dw;
> > > +	const char				*name;
> > > +	void __iomem				*reg;
> > 
> > > +	enum dw_edma_dir			dir;
> > > +	u16					ch;
> > 
> > Fields above seems like unused. What about dropping them?
> > * Note the CTX_REGISTER() initializer will need to be fixed too.
> 

> Do you mean that,
> 
> CTX_REGISTER() like this
> 
> +#define CTX_REGISTER(dw, name, dir, ch) \
> +	{#name, REGS_CH_ADDR(dw, name, dir, ch)}
> 
> dw_hdma_debug_debugfs_entry will be changed to
> 
> +struct dw_hdma_debugfs_entry {
> +	const char				*name;
> +	void __iomem				*reg;
> +};
> 
> right?

Yes.

-Serge(y)

> 
> Thanks,
> -Cai
> > 
> > BTW it doesn't seem like HDMA will ever need the fields above, does it?
> > In case of DW eDMA they were necessary to perform the viewport-based
> > access of the CSR. AFAICS HDMA has always unrolled CSRs mapping.
> > Am I right?
> > 
> > Other than that looks good.
> > 
> > -Serge(y)
> > 
> > > +};
> > > +
> > > +static int dw_hdma_debugfs_u32_get(void *data, u64 *val)
> > > +{
> > > +	struct dw_hdma_debugfs_entry *entry = data;
> > > +	void __iomem *reg = entry->reg;
> > > +
> > > +	*val = readl(reg);
> > > +
> > > +	return 0;
> > > +}
> > > +DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_hdma_debugfs_u32_get, NULL, "0x%08llx\n");
> > > +
> > > +static void dw_hdma_debugfs_create_x32(struct dw_edma *dw,
> > > +				       const struct dw_hdma_debugfs_entry ini[],
> > > +				       int nr_entries, struct dentry *dent)
> > > +{
> > > +	struct dw_hdma_debugfs_entry *entries;
> > > +	int i;
> > > +
> > > +	entries = devm_kcalloc(dw->chip->dev, nr_entries, sizeof(*entries),
> > > +			       GFP_KERNEL);
> > > +	if (!entries)
> > > +		return;
> > > +
> > > +	for (i = 0; i < nr_entries; i++) {
> > > +		entries[i] = ini[i];
> > > +
> > > +		debugfs_create_file_unsafe(entries[i].name, 0444, dent,
> > > +					   &entries[i], &fops_x32);
> > > +	}
> > > +}
> > > +
> > > +static void dw_hdma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
> > > +				    u16 ch, struct dentry *dent)
> > > +{
> > > +	const struct dw_hdma_debugfs_entry debugfs_regs[] = {
> > > +		CTX_REGISTER(dw, ch_en, dir, ch),
> > > +		CTX_REGISTER(dw, doorbell, dir, ch),
> > > +		CTX_REGISTER(dw, prefetch, dir, ch),
> > > +		CTX_REGISTER(dw, handshake, dir, ch),
> > > +		CTX_REGISTER(dw, llp.lsb, dir, ch),
> > > +		CTX_REGISTER(dw, llp.msb, dir, ch),
> > > +		CTX_REGISTER(dw, cycle_sync, dir, ch),
> > > +		CTX_REGISTER(dw, transfer_size, dir, ch),
> > > +		CTX_REGISTER(dw, sar.lsb, dir, ch),
> > > +		CTX_REGISTER(dw, sar.msb, dir, ch),
> > > +		CTX_REGISTER(dw, dar.lsb, dir, ch),
> > > +		CTX_REGISTER(dw, dar.msb, dir, ch),
> > > +		CTX_REGISTER(dw, watermark_en, dir, ch),
> > > +		CTX_REGISTER(dw, control1, dir, ch),
> > > +		CTX_REGISTER(dw, func_num, dir, ch),
> > > +		CTX_REGISTER(dw, qos, dir, ch),
> > > +		CTX_REGISTER(dw, ch_stat, dir, ch),
> > > +		CTX_REGISTER(dw, int_stat, dir, ch),
> > > +		CTX_REGISTER(dw, int_setup, dir, ch),
> > > +		CTX_REGISTER(dw, int_clear, dir, ch),
> > > +		CTX_REGISTER(dw, msi_stop.lsb, dir, ch),
> > > +		CTX_REGISTER(dw, msi_stop.msb, dir, ch),
> > > +		CTX_REGISTER(dw, msi_watermark.lsb, dir, ch),
> > > +		CTX_REGISTER(dw, msi_watermark.msb, dir, ch),
> > > +		CTX_REGISTER(dw, msi_abort.lsb, dir, ch),
> > > +		CTX_REGISTER(dw, msi_abort.msb, dir, ch),
> > > +		CTX_REGISTER(dw, msi_msgdata, dir, ch),
> > > +	};
> > > +	int nr_entries = ARRAY_SIZE(debugfs_regs);
> > > +
> > > +	dw_hdma_debugfs_create_x32(dw, debugfs_regs, nr_entries, dent);
> > > +}
> > > +
> > > +static void dw_hdma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
> > > +{
> > > +	struct dentry *regs_dent, *ch_dent;
> > > +	char name[16];
> > > +	int i;
> > > +
> > > +	regs_dent = debugfs_create_dir(WRITE_STR, dent);
> > > +
> > > +	for (i = 0; i < dw->wr_ch_cnt; i++) {
> > > +		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
> > > +
> > > +		ch_dent = debugfs_create_dir(name, regs_dent);
> > > +
> > > +		dw_hdma_debugfs_regs_ch(dw, EDMA_DIR_WRITE, i, ch_dent);
> > > +	}
> > > +}
> > > +
> > > +static void dw_hdma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
> > > +{
> > > +	struct dentry *regs_dent, *ch_dent;
> > > +	char name[16];
> > > +	int i;
> > > +
> > > +	regs_dent = debugfs_create_dir(READ_STR, dent);
> > > +
> > > +	for (i = 0; i < dw->rd_ch_cnt; i++) {
> > > +		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
> > > +
> > > +		ch_dent = debugfs_create_dir(name, regs_dent);
> > > +
> > > +		dw_hdma_debugfs_regs_ch(dw, EDMA_DIR_READ, i, ch_dent);
> > > +	}
> > > +}
> > > +
> > > +static void dw_hdma_debugfs_regs(struct dw_edma *dw)
> > > +{
> > > +	struct dentry *regs_dent;
> > > +
> > > +	regs_dent = debugfs_create_dir(REGISTERS_STR, dw->dma.dbg_dev_root);
> > > +
> > > +	dw_hdma_debugfs_regs_wr(dw, regs_dent);
> > > +	dw_hdma_debugfs_regs_rd(dw, regs_dent);
> > > +}
> > > +
> > > +void dw_hdma_v0_debugfs_on(struct dw_edma *dw)
> > > +{
> > > +	if (!debugfs_initialized())
> > > +		return;
> > > +
> > > +	debugfs_create_u32("mf", 0444, dw->dma.dbg_dev_root, &dw->chip->mf);
> > > +	debugfs_create_u16("wr_ch_cnt", 0444, dw->dma.dbg_dev_root, &dw->wr_ch_cnt);
> > > +	debugfs_create_u16("rd_ch_cnt", 0444, dw->dma.dbg_dev_root, &dw->rd_ch_cnt);
> > > +
> > > +	dw_hdma_debugfs_regs(dw);
> > > +}
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.h b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
> > > new file mode 100644
> > > index 000000000000..e6842c83777d
> > > --- /dev/null
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
> > > @@ -0,0 +1,22 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (c) 2023 Cai Huoqing
> > > + * Synopsys DesignWare HDMA v0 debugfs
> > > + *
> > > + * Author: Cai Huoqing <cai.huoqing@linux.dev>
> > > + */
> > > +
> > > +#ifndef _DW_HDMA_V0_DEBUG_FS_H
> > > +#define _DW_HDMA_V0_DEBUG_FS_H
> > > +
> > > +#include <linux/dma/edma.h>
> > > +
> > > +#ifdef CONFIG_DEBUG_FS
> > > +void dw_hdma_v0_debugfs_on(struct dw_edma *dw);
> > > +#else
> > > +static inline void dw_hdma_v0_debugfs_on(struct dw_edma *dw)
> > > +{
> > > +}
> > > +#endif /* CONFIG_DEBUG_FS */
> > > +
> > > +#endif /* _DW_HDMA_V0_DEBUG_FS_H */
> > > -- 
> > > 2.34.1
> > > 
