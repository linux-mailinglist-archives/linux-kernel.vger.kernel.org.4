Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F666A9CF6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjCCRPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjCCRPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:15:05 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6B41514E;
        Fri,  3 Mar 2023 09:15:02 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id z42so3009222ljq.13;
        Fri, 03 Mar 2023 09:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677863701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iEw+K3SJWMgHRy2gdvxMP4r5YRkc67xMyxzZkLJBo0Q=;
        b=E7eBhfoyoEkbYeFaVU+xLVM29Jm29NcOALA9NytC71x2xsGPWXRycKy4vQDvajYivI
         TySy1ABEu6yDauYGaSsfY0t72ZUbQ0zwbNj3rNKt96iCj91tmU2QfBs17MDyEd1u0Y6o
         Q7TJFkrNWhMGxdGoBK7AO0fqTcz5A5IJpWJyqqJA45ms+H/6Q2/9GPWJaao64yejmwF5
         HojvLbJ9AQV0pSbEygun8H+nD0RkktcNh8BYoq5lweYHqY/aHGJCS1sqC7pMVblU6wlM
         iPjrs1Q3N/tnUb5nYf5tHsQhRStZ4KLqY3CRbAu0oIOoribLbj9vV8XV2i2doOgKa9DL
         bj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677863701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEw+K3SJWMgHRy2gdvxMP4r5YRkc67xMyxzZkLJBo0Q=;
        b=mbGe4m+cE3oYFwQfHGRjzuzM9dCCIw2oQUYVXoAM3hZHzZ7OroHjpSOQVsRAiydHfx
         omVT90kRDBfRRUsUEmQBdX2Q1n/w2j/ZVrVtsL4bdtb/kjGZULfAOYP3XjuoyoMTCeXV
         PRoOepBtB1+fwJSg8jeN8/Pl8nwRUb9TIbQkMWEozM/iX+tt1GEtoJPvvyS1b6zdcq+x
         uATpVrsApfAzbzar+ygaqP9L2WVAM/8gRcbKB0Dzlw5wfyr0hz5u7KrqRtWZZBrA8zfr
         efgwcyv/8kt3PbJv6JkQq1VgDOkjKBI3uWZojhT/9MsycdfT/qgj6d0vq2xiQPOwcXEi
         WaHQ==
X-Gm-Message-State: AO0yUKVKEpvbFwrZRJXZ16YXimGTyxy4go9AcnJLPOzgXv73Rl18tUbf
        VK7zkyjjlaKY2IEMSxy0/AQ=
X-Google-Smtp-Source: AK7set8nfJvjI66QHEokndzFE0WPLKOtAobI7isKJk49VJV1tXjuQ7rKbKecavFTGhA6Z4M5O59p1Q==
X-Received: by 2002:a2e:99c9:0:b0:295:a496:52c3 with SMTP id l9-20020a2e99c9000000b00295a49652c3mr700628ljj.47.1677863700713;
        Fri, 03 Mar 2023 09:15:00 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id t21-20020ac25495000000b004d582cedca5sm465175lfk.2.2023.03.03.09.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 09:15:00 -0800 (PST)
Date:   Fri, 3 Mar 2023 20:14:57 +0300
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
Subject: Re: [PATCH v5 2/4] dmaengine: dw-edma: Create a new dw_edma_core_ops
 structure to abstract controller operation
Message-ID: <20230303171457.dclmksdoyzhe5y6d@mobilestation>
References: <20230303124642.5519-1-cai.huoqing@linux.dev>
 <20230303124642.5519-3-cai.huoqing@linux.dev>
 <20230303170931.noto3tk5lvq24ok2@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303170931.noto3tk5lvq24ok2@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 08:09:38PM +0300, Serge Semin wrote:
> On Fri, Mar 03, 2023 at 08:46:32PM +0800, Cai Huoqing wrote:
> > From: Cai huoqing <cai.huoqing@linux.dev>
> > 
> > The structure dw_edma_core_ops has a set of the pointers
> > abstracting out the DW eDMA vX and DW HDMA Native controllers.
> > And use dw_edma_v0_core_register to set up operation.
> > 
> > Signed-off-by: Cai huoqing <cai.huoqing@linux.dev>
> > ---
> >   v4->v5:
> >     1.Refactor add return irqreturn_t to dw_edma_core_handle_int
> >     2.Define dw_edma_core_handle_int as inline fuction and move to
> >       dw-edma-core.h.
> > 
> >   v4 link:
> >   https://lore.kernel.org/lkml/20230221034656.14476-3-cai.huoqing@linux.dev/
> > 
> >  drivers/dma/dw-edma/dw-edma-core.c    | 83 ++++++++-------------------
> >  drivers/dma/dw-edma/dw-edma-core.h    | 64 +++++++++++++++++++++
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 75 ++++++++++++++++++++----
> >  drivers/dma/dw-edma/dw-edma-v0-core.h | 14 +----
> >  4 files changed, 153 insertions(+), 83 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 1906a836f0aa..5cfba5730695 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -183,6 +183,7 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
> >  
> >  static void dw_edma_start_transfer(struct dw_edma_chan *chan)
> >  {
> > +	struct dw_edma *dw = chan->dw;
> >  	struct dw_edma_chunk *child;
> >  	struct dw_edma_desc *desc;
> >  	struct virt_dma_desc *vd;
> > @@ -200,7 +201,7 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
> >  	if (!child)
> >  		return;
> >  
> > -	dw_edma_v0_core_start(child, !desc->xfer_sz);
> > +	dw_edma_core_start(dw, child, !desc->xfer_sz);
> >  	desc->xfer_sz += child->ll_region.sz;
> >  	dw_edma_free_burst(child);
> >  	list_del(&child->list);
> > @@ -285,7 +286,7 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
> >  		chan->configured = false;
> >  	} else if (chan->status == EDMA_ST_IDLE) {
> >  		chan->configured = false;
> > -	} else if (dw_edma_v0_core_ch_status(chan) == DMA_COMPLETE) {
> > +	} else if (dw_edma_core_ch_status(chan) == DMA_COMPLETE) {
> >  		/*
> >  		 * The channel is in a false BUSY state, probably didn't
> >  		 * receive or lost an interrupt
> > @@ -588,14 +589,12 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
> >  	return dw_edma_device_transfer(&xfer);
> >  }
> >  
> > -static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
> > +void dw_edma_done_interrupt(struct dw_edma_chan *chan)
> >  {
> >  	struct dw_edma_desc *desc;
> >  	struct virt_dma_desc *vd;
> >  	unsigned long flags;
> >  
> > -	dw_edma_v0_core_clear_done_int(chan);
> > -
> >  	spin_lock_irqsave(&chan->vc.lock, flags);
> >  	vd = vchan_next_desc(&chan->vc);
> >  	if (vd) {
> > @@ -631,13 +630,11 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
> >  	spin_unlock_irqrestore(&chan->vc.lock, flags);
> >  }
> >  
> > -static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
> > +void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
> >  {
> >  	struct virt_dma_desc *vd;
> >  	unsigned long flags;
> >  
> > -	dw_edma_v0_core_clear_abort_int(chan);
> > -
> >  	spin_lock_irqsave(&chan->vc.lock, flags);
> >  	vd = vchan_next_desc(&chan->vc);
> >  	if (vd) {
> > @@ -649,63 +646,29 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
> >  	chan->status = EDMA_ST_IDLE;
> >  }
> >  
> > -static irqreturn_t dw_edma_interrupt(int irq, void *data, bool write)
> > +static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
> >  {
> >  	struct dw_edma_irq *dw_irq = data;
> > -	struct dw_edma *dw = dw_irq->dw;
> > -	unsigned long total, pos, val;
> > -	unsigned long off;
> > -	u32 mask;
> > -
> > -	if (write) {
> > -		total = dw->wr_ch_cnt;
> > -		off = 0;
> > -		mask = dw_irq->wr_mask;
> > -	} else {
> > -		total = dw->rd_ch_cnt;
> > -		off = dw->wr_ch_cnt;
> > -		mask = dw_irq->rd_mask;
> > -	}
> > -
> > -	val = dw_edma_v0_core_status_done_int(dw, write ?
> > -							  EDMA_DIR_WRITE :
> > -							  EDMA_DIR_READ);
> > -	val &= mask;
> > -	for_each_set_bit(pos, &val, total) {
> > -		struct dw_edma_chan *chan = &dw->chan[pos + off];
> > -
> > -		dw_edma_done_interrupt(chan);
> > -	}
> > -
> > -	val = dw_edma_v0_core_status_abort_int(dw, write ?
> > -							   EDMA_DIR_WRITE :
> > -							   EDMA_DIR_READ);
> > -	val &= mask;
> > -	for_each_set_bit(pos, &val, total) {
> > -		struct dw_edma_chan *chan = &dw->chan[pos + off];
> > -
> > -		dw_edma_abort_interrupt(chan);
> > -	}
> >  
> > -	return IRQ_HANDLED;
> > -}
> > -
> > -static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
> > -{
> > -	return dw_edma_interrupt(irq, data, true);
> > +	return dw_edma_core_handle_int(dw_irq, EDMA_DIR_WRITE);
> >  }
> >  
> >  static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
> >  {
> > -	return dw_edma_interrupt(irq, data, false);
> > +	struct dw_edma_irq *dw_irq = data;
> > +
> > +	return dw_edma_core_handle_int(dw_irq, EDMA_DIR_READ);
> >  }
> >  
> >  static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
> >  {
> > -	dw_edma_interrupt(irq, data, true);
> > -	dw_edma_interrupt(irq, data, false);
> > +	struct dw_edma_irq *dw_irq = data;
> > +	irqreturn_t ret = IRQ_NONE;
> > +
> > +	ret |= dw_edma_core_handle_int(dw_irq, EDMA_DIR_WRITE);
> > +	ret |= dw_edma_core_handle_int(dw_irq, EDMA_DIR_READ);
> >  
> > -	return IRQ_HANDLED;
> > +	return ret;
> >  }
> >  
> >  static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
> > @@ -806,7 +769,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >  
> >  		vchan_init(&chan->vc, dma);
> >  
> > -		dw_edma_v0_core_device_config(chan);
> > +		dw_edma_core_ch_config(chan);
> >  	}
> >  
> >  	/* Set DMA channel capabilities */
> > @@ -951,14 +914,16 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >  
> >  	dw->chip = chip;
> >  
> > +	dw_edma_v0_core_register(dw);
> > +
> >  	raw_spin_lock_init(&dw->lock);
> >  
> >  	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
> > -			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
> > +			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
> >  	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> >  
> >  	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
> > -			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
> > +			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
> >  	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> >  
> >  	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
> > @@ -977,7 +942,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >  		 dev_name(chip->dev));
> >  
> >  	/* Disable eDMA, only to establish the ideal initial conditions */
> > -	dw_edma_v0_core_off(dw);
> > +	dw_edma_core_off(dw);
> >  
> >  	/* Request IRQs */
> >  	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
> > @@ -990,7 +955,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >  		goto err_irq_free;
> >  
> >  	/* Turn debugfs on */
> > -	dw_edma_v0_core_debugfs_on(dw);
> > +	dw_edma_core_debugfs_on(dw);
> >  
> >  	chip->dw = dw;
> >  
> > @@ -1016,7 +981,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> >  		return -ENODEV;
> >  
> >  	/* Disable eDMA */
> > -	dw_edma_v0_core_off(dw);
> > +	dw_edma_core_off(dw);
> >  
> >  	/* Free irqs */
> >  	for (i = (dw->nr_irqs - 1); i >= 0; i--)
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> > index 0ab2b6dba880..b0c4648cd30c 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > @@ -111,6 +111,19 @@ struct dw_edma {
> >  	raw_spinlock_t			lock;		/* Only for legacy */
> >  
> >  	struct dw_edma_chip             *chip;
> > +
> > +	const struct dw_edma_core_ops	*core;
> > +};
> > +
> > +struct dw_edma_core_ops {
> > +	void (*off)(struct dw_edma *dw);
> > +	u16 (*ch_count)(struct dw_edma *dw, enum dw_edma_dir dir);
> > +	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
> > +	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq,
> > +				  enum dw_edma_dir dir);
> > +	void (*start)(struct dw_edma_chunk *chunk, bool first);
> > +	void (*ch_config)(struct dw_edma_chan *chan);
> > +	void (*debugfs_on)(struct dw_edma *dw);
> >  };
> >  
> >  struct dw_edma_sg {
> > @@ -136,6 +149,9 @@ struct dw_edma_transfer {
> >  	enum dw_edma_xfer_type		type;
> >  };
> > 
>  
> > +void dw_edma_done_interrupt(struct dw_edma_chan *chan);
> > +void dw_edma_abort_interrupt(struct dw_edma_chan *chan);
> 
> I'll ask one more time. So you've decided to go with the global
> dw_edma_done_interrupt()/dw_edma_abort_interrupt() methods instead of
> passing them as the function pointers to the handle_int callback.
> 
> Are you sure it looks better (simpler, more readable) that way?
> 
> > +
> >  static inline
> >  struct dw_edma_chan *vc2dw_edma_chan(struct virt_dma_chan *vc)
> >  {
> > @@ -148,4 +164,52 @@ struct dw_edma_chan *dchan2dw_edma_chan(struct dma_chan *dchan)
> >  	return vc2dw_edma_chan(to_virt_chan(dchan));
> >  }
> >  
> > +static inline
> > +void dw_edma_core_off(struct dw_edma *dw)
> > +{
> > +	dw->core->off(dw);
> > +}
> > +
> > +static inline
> > +u16 dw_edma_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
> > +{
> > +	return dw->core->ch_count(dw, dir);
> > +}
> > +
> > +static inline
> > +enum dma_status dw_edma_core_ch_status(struct dw_edma_chan *chan)
> > +{
> > +	struct dw_edma *dw = chan->dw;
> > +
> > +	return dw->core->ch_status(chan);
> > +}
> > +
> > +static inline irqreturn_t
> > +dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir)
> > +{
> > +	struct dw_edma *dw = dw_irq->dw;
> > +
> > +	return dw->core->handle_int(dw_irq, dir);
> > +}
> > +
> > +static inline
> > +void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk, bool first)
> > +{
> > +	dw->core->start(chunk, first);
> > +}
> > +
> > +static inline
> > +void dw_edma_core_ch_config(struct dw_edma_chan *chan)
> > +{
> > +	struct dw_edma *dw = chan->dw;
> > +
> > +	dw->core->ch_config(chan);
> > +}
> > +
> > +static inline
> > +void dw_edma_core_debugfs_on(struct dw_edma *dw)
> > +{
> > +	dw->core->debugfs_on(dw);
> > +}
> > +
> >  #endif /* _DW_EDMA_CORE_H */
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 72e79a0c0a4e..2ebae48531f9 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -216,7 +216,7 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
> >  	readq_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
> >  
> >  /* eDMA management callbacks */
> > -void dw_edma_v0_core_off(struct dw_edma *dw)
> > +static void dw_edma_v0_core_off(struct dw_edma *dw)
> >  {
> >  	SET_BOTH_32(dw, int_mask,
> >  		    EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
> > @@ -225,7 +225,7 @@ void dw_edma_v0_core_off(struct dw_edma *dw)
> >  	SET_BOTH_32(dw, engine_en, 0);
> >  }
> >  
> > -u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
> > +static u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
> >  {
> >  	u32 num_ch;
> >  
> > @@ -242,7 +242,7 @@ u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
> >  	return (u16)num_ch;
> >  }
> >  
> > -enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
> > +static enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
> >  {
> >  	struct dw_edma *dw = chan->dw;
> >  	u32 tmp;
> > @@ -258,7 +258,7 @@ enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
> >  		return DMA_ERROR;
> >  }
> >  
> > -void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
> > +static void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
> >  {
> >  	struct dw_edma *dw = chan->dw;
> >  
> > @@ -266,7 +266,7 @@ void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
> >  		  FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
> >  }
> >  
> > -void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
> > +static void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
> >  {
> >  	struct dw_edma *dw = chan->dw;
> >  
> > @@ -274,18 +274,56 @@ void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
> >  		  FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
> >  }
> >  
> > -u32 dw_edma_v0_core_status_done_int(struct dw_edma *dw, enum dw_edma_dir dir)
> > +static u32 dw_edma_v0_core_status_done_int(struct dw_edma *dw, enum dw_edma_dir dir)
> >  {
> >  	return FIELD_GET(EDMA_V0_DONE_INT_MASK,
> >  			 GET_RW_32(dw, dir, int_status));
> >  }
> >  
> > -u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
> > +static u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
> >  {
> >  	return FIELD_GET(EDMA_V0_ABORT_INT_MASK,
> >  			 GET_RW_32(dw, dir, int_status));
> >  }
> >  
> > +static
> > +irqreturn_t dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir)
> > +{
> > +	struct dw_edma *dw = dw_irq->dw;
> > +	unsigned long total, pos, val;
> > +	struct dw_edma_chan *chan;

>   +	int ret = IRQ_NONE;

I meant "irqreturn_t" type of course.

-Serge(y)

> > +	unsigned long off;
> > +	u32 mask;
> > +
> > +	if (dir == EDMA_DIR_WRITE) {
> > +		total = dw->wr_ch_cnt;
> > +		off = 0;
> > +		mask = dw_irq->wr_mask;
> > +	} else {
> > +		total = dw->rd_ch_cnt;
> > +		off = dw->wr_ch_cnt;
> > +		mask = dw_irq->rd_mask;
> > +	}
> > +
> > +	val = dw_edma_v0_core_status_done_int(dw, dir);
> > +	val &= mask;
> > +	for_each_set_bit(pos, &val, total) {
> > +		chan = &dw->chan[pos + off];
>   + newline
> > +		dw_edma_v0_core_clear_done_int(chan);
> > +		dw_edma_done_interrupt(chan);
>   + newline
>   +		ret = IRQ_HANDLED;
> > +	}
> > +
> > +	val = dw_edma_v0_core_status_abort_int(dw, dir);
> > +	val &= mask;
> > +	for_each_set_bit(pos, &val, total) {
> > +		chan = &dw->chan[pos + off];
>   + newline
> > +		dw_edma_v0_core_clear_abort_int(chan);
> > +		dw_edma_abort_interrupt(chan);
>   + newline
>   +		ret = IRQ_HANDLED;
> > +	}
> > +
> > -	return IRQ_HANDLED;
>   +	return ret;
> > +}
> 
> Your version of the handler doesn't indicate whether the IRQ was
> actually handled. Instead it misleadingly returns always-handled
> status. What if no IRQ flag was actually set and no for-each
> loop was taken? It's possible for the shared IRQ lines.
> 
> Besides of adding the actual IRQ-handling status return please note
> 1. newlines
> 2. include "linux/irqreturn.h" to the head of the file.
> 
> -Serge(y)
> 
> > +
> >  static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
> >  				     u32 control, u32 size, u64 sar, u64 dar)
> >  {
> > @@ -356,7 +394,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >  	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
> >  }
> >  
> > -void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > +static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  {
> >  	struct dw_edma_chan *chan = chunk->chan;
> >  	struct dw_edma *dw = chan->dw;
> > @@ -427,7 +465,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
> >  }
> >  
> > -int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
> > +static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
> >  {
> >  	struct dw_edma *dw = chan->dw;
> >  	u32 tmp = 0;
> > @@ -494,12 +532,25 @@ int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
> >  		SET_RW_32(dw, chan->dir, ch67_imwr_data, tmp);
> >  		break;
> >  	}
> > -
> > -	return 0;
> >  }
> >  
> >  /* eDMA debugfs callbacks */
> > -void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
> > +static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
> >  {
> >  	dw_edma_v0_debugfs_on(dw);
> >  }
> > +
> > +static const struct dw_edma_core_ops dw_edma_v0_core = {
> > +	.off = dw_edma_v0_core_off,
> > +	.ch_count = dw_edma_v0_core_ch_count,
> > +	.ch_status = dw_edma_v0_core_ch_status,
> > +	.handle_int = dw_edma_v0_core_handle_int,
> > +	.start = dw_edma_v0_core_start,
> > +	.ch_config = dw_edma_v0_core_ch_config,
> > +	.debugfs_on = dw_edma_v0_core_debugfs_on,
> > +};
> > +
> > +void dw_edma_v0_core_register(struct dw_edma *dw)
> > +{
> > +	dw->core = &dw_edma_v0_core;
> > +}
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
> > index ab96a1f48080..04a882222f99 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
> > @@ -11,17 +11,7 @@
> >  
> >  #include <linux/dma/edma.h>
> >  
> > -/* eDMA management callbacks */
> > -void dw_edma_v0_core_off(struct dw_edma *chan);
> > -u16 dw_edma_v0_core_ch_count(struct dw_edma *chan, enum dw_edma_dir dir);
> > -enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan);
> > -void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan);
> > -void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan);
> > -u32 dw_edma_v0_core_status_done_int(struct dw_edma *chan, enum dw_edma_dir dir);
> > -u32 dw_edma_v0_core_status_abort_int(struct dw_edma *chan, enum dw_edma_dir dir);
> > -void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
> > -int dw_edma_v0_core_device_config(struct dw_edma_chan *chan);
> > -/* eDMA debug fs callbacks */
> > -void dw_edma_v0_core_debugfs_on(struct dw_edma *dw);
> > +/* eDMA core register */
> > +void dw_edma_v0_core_register(struct dw_edma *dw);
> >  
> >  #endif /* _DW_EDMA_V0_CORE_H */
> > -- 
> > 2.34.1
> > 
