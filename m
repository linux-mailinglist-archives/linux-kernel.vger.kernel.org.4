Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6256839EE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjAaXAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjAaXAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:00:03 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B04323C79
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:00:01 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id ay1so11224588pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3QpaZ5KVjwfMzAN4m8VDdNazD96JE3dp7xBbhHzuQWQ=;
        b=EYIEX4ort4qvDuppuUZjW+/9XDQ1WWEFl+JuPLNBfizjRa9qN+/mL8KuPKj0/5dZRn
         gimhmwYOXQbt4+RayLj0CNSTbgJ1/vPWgYZXSbvIhOUt+j2f6cfVofLmbVbeQ33sCmBr
         vPEEABtiBqsotSRYLGjk4ApseTdYoeruqosqSKGzavwYCWzYlMGMZyMf3r1quJGNtJFE
         nMTYmRaVt/omO91NytLlMIFJytqvOEhSQPiNndFKuxiWrZjEk4dZT/XqhrfmfGD8Y0mN
         YyhTHKP28YXk4hpxSTsLFl2pF0LWRDkWHQ28FHiayjyqs2K+ZHz+ok7R43i8gbYLhhux
         yhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QpaZ5KVjwfMzAN4m8VDdNazD96JE3dp7xBbhHzuQWQ=;
        b=kltfSYVVQHIpVa7RvLZn2oLwUSLRfMinOVnsPL7DQCWjg5pIYMyoShQa+vHQwi1s2t
         aJyspXATISgGSTNfNfaE+s1HVFV7NDG7jXv6rAjxlo/qqX2eh/syo7z2kBqYpx746tW/
         s4QVkpZkQsobI7eOhJH5+3steaETj8MTZntamMtub/3/sE3LrHwGACpdk5al2E9HMfNL
         NGdC97L4y0q5MWQl3bVXu7ooilLdOhvptoprFV2KKGGNKuogucJ1QspWK4aOSI+4HhPL
         ayM2S/49llu2HvwBN5b4menuBtcELJ9J4iToP0xkJAdxjl+Nh1jXe7xe+vMV5/ANoQaD
         Y2Nw==
X-Gm-Message-State: AO0yUKWosL05TmCDuqaqcL9qj2ZcWMTTuivvtITOcgbmuqRZEYspW8bU
        A0ethXPpw/DhXz0O940MlZ0V5g==
X-Google-Smtp-Source: AK7set8ehO5ZBPK+SjOOw8UbnmOjz01o/s24nQFI2pjdieXK8cR6M+saD194BhoBshQ/6yWsfX6YzQ==
X-Received: by 2002:a62:1c88:0:b0:593:b115:e2ca with SMTP id c130-20020a621c88000000b00593b115e2camr198651pfc.9.1675206000471;
        Tue, 31 Jan 2023 15:00:00 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:4e47:8986:95c0:e9fd])
        by smtp.gmail.com with ESMTPSA id q22-20020aa79836000000b00575caf80d08sm10044453pfl.31.2023.01.31.14.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 14:59:59 -0800 (PST)
Date:   Tue, 31 Jan 2023 15:59:57 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     andersson@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: xilinx: add mailbox channels for rpmsg
Message-ID: <20230131225957.GA217823@p14s>
References: <20230126213154.1707300-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126213154.1707300-1-tanmay.shah@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon,

On Thu, Jan 26, 2023 at 01:31:54PM -0800, Tanmay Shah wrote:
> This patch makes each r5 core mailbox client and uses
> tx and rx channels to send and receive data to/from
> remote processor respectively. This is needed for rpmsg
> communication to remote processor.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v2:
>   - fix vrings carveout names as expeceted by remoteproc framework
> 

This should be in a patch on its own along with a "Fixes" tag.

>  drivers/remoteproc/xlnx_r5_remoteproc.c | 352 ++++++++++++++++++++----
>  1 file changed, 292 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 2db57d394155..45ce7f2089bf 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -8,16 +8,23 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/firmware/xlnx-zynqmp.h>
>  #include <linux/kernel.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mailbox/zynqmp-ipi-message.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
> -#include <linux/slab.h>
>  
>  #include "remoteproc_internal.h"
>  
> +/* IPI buffer MAX length */
> +#define IPI_BUF_LEN_MAX	32U
> +

The documentation for struct zynqmp_ipi_message clearly states that @data is
fixed to 12 bytes, whereas here is it set to 32 bytes.  Wrong documentation or
bug?

> +/* RX mailbox client buffer max length */
> +#define MBOX_CLIENT_BUF_MAX	(IPI_BUF_LEN_MAX + \
> +				 sizeof(struct zynqmp_ipi_message))
>  /*
>   * settings for RPU cluster mode which
>   * reflects possible values of xlnx,cluster-mode dt-property
> @@ -65,6 +72,12 @@ static const struct mem_bank_data zynqmp_tcm_banks[] = {
>   * @rmem: reserved memory region nodes from device tree
>   * @rproc: rproc handle
>   * @pm_domain_id: RPU CPU power domain id
> + * @rx_mc_buf: to copy data from mailbox rx channel
> + * @tx_mc_buf: to copy data to mailbox tx channel
> + * @mbox_work: schedule work after receiving data from mailbox
> + * @mbox_cl: mailbox client
> + * @tx_chan: mailbox tx channel
> + * @rx_chan: mailbox rx channel
>   */
>  struct zynqmp_r5_core {
>  	struct device *dev;
> @@ -75,6 +88,14 @@ struct zynqmp_r5_core {
>  	struct reserved_mem **rmem;
>  	struct rproc *rproc;
>  	u32 pm_domain_id;
> +
> +	/* mailbox related data structures */
> +	unsigned char rx_mc_buf[MBOX_CLIENT_BUF_MAX];
> +	unsigned char tx_mc_buf[MBOX_CLIENT_BUF_MAX];
> +	struct work_struct mbox_work;
> +	struct mbox_client mbox_cl;
> +	struct mbox_chan *tx_chan;
> +	struct mbox_chan *rx_chan;
>  };
>  
>  /**
> @@ -92,6 +113,181 @@ struct zynqmp_r5_cluster {
>  	struct zynqmp_r5_core **r5_cores;
>  };
>  
> +/**
> + * event_notified_idr_cb() - callback for vq_interrupt per notifyid
> + * @id: rproc->notify id
> + * @ptr: pointer to idr private data
> + * @data: data passed to idr_for_each callback
> + *
> + * Pass notification to remoteproc virtio
> + *
> + * Return: 0. having return is to satisfy the idr_for_each() function
> + *          pointer input argument requirement.
> + **/
> +static int event_notified_idr_cb(int id, void *ptr, void *data)
> +{
> +	struct rproc *rproc = data;
> +
> +	if (rproc_vq_interrupt(rproc, id) == IRQ_NONE)
> +		dev_dbg(&rproc->dev, "data not found for vqid=%d\n", id);
> +
> +	return 0;
> +}
> +
> +/**
> + * handle_event_notified() - remoteproc notification work function
> + * @work: pointer to the work structure
> + *
> + * It checks each registered remoteproc notify IDs.
> + */
> +static void handle_event_notified(struct work_struct *work)
> +{
> +	struct zynqmp_r5_core *r5_core;
> +	struct rproc *rproc;
> +
> +	r5_core = container_of(work, struct zynqmp_r5_core, mbox_work);
> +	rproc = r5_core->rproc;
> +
> +	/*
> +	 * We only use IPI for interrupt. The RPU firmware side may or may
> +	 * not write the notifyid when it trigger IPI.
> +	 * And thus, we scan through all the registered notifyids and
> +	 * find which one is valid to get the message.
> +	 * Even if message from firmware is NULL, we attempt to get vqid
> +	 */
> +	idr_for_each(&rproc->notifyids, event_notified_idr_cb, rproc);
> +}
> +
> +/**
> + * zynqmp_r5_mb_rx_cb() - receive channel mailbox callback
> + * @cl: mailbox client
> + * @msg: message pointer
> + *
> + * Receive data from ipi buffer, ack interrupt and then
> + * it will schedule the R5 notification work.
> + */
> +static void zynqmp_r5_mb_rx_cb(struct mbox_client *cl, void *msg)
> +{
> +	struct zynqmp_ipi_message *ipi_msg, *buf_msg;
> +	struct zynqmp_r5_core *r5_core;
> +	size_t len;
> +
> +	r5_core = container_of(cl, struct zynqmp_r5_core, mbox_cl);
> +
> +	/* copy data from ipi buffer to r5_core */
> +	ipi_msg = (struct zynqmp_ipi_message *)msg;
> +	buf_msg = (struct zynqmp_ipi_message *)r5_core->rx_mc_buf;
> +	len = ipi_msg->len;
> +	if (len > IPI_BUF_LEN_MAX) {
> +		dev_warn(r5_core->dev, "msg size exceeded than %d\n",
> +			 IPI_BUF_LEN_MAX);
> +		len = IPI_BUF_LEN_MAX;
> +	}
> +	buf_msg->len = len;
> +	memcpy(buf_msg->data, ipi_msg->data, len);
> +
> +	/* received and processed interrupt ack */
> +	if (mbox_send_message(r5_core->rx_chan, NULL) < 0)
> +		dev_err(r5_core->dev, "ack failed to mbox rx_chan\n");
> +
> +	schedule_work(&r5_core->mbox_work);
> +}
> +
> +/**
> + * zynqmp_r5_setup_mbox() - Setup mailboxes related properties
> + *			    this is used for each individual R5 core
> + *
> + * @r5_core: pointer to the ZynqMP r5 core data
> + *
> + * Function to setup mailboxes related properties
> + *
> + */
> +static void zynqmp_r5_setup_mbox(struct zynqmp_r5_core *r5_core)
> +{
> +	struct zynqmp_r5_cluster *cluster;
> +	struct mbox_client *mbox_cl;
> +
> +	cluster = dev_get_drvdata(r5_core->dev->parent);
> +
> +	/**

Extra '*', please remove.

> +	 * ToDo: Use only one IPI channel for APU to communicate with both RPUs
> +	 * in split mode. As of now, two IPI channels are expeceted for APU
> +	 * to communicate with RPU. for example, APU(IPI0)<-> RPU0(IPI1) and
> +	 * APU(IPI7)<->RPU1(IPI2). However, this is not the optimized use
> +	 * of the hardware. As per hardware reference manual, each IPI channel
> +	 * can receive interrupt from another IPI channel. So APU must be able
> +	 * to communicate with both RPUs simultaneously using same IPI channel.
> +	 * For example, this is valid case: APU(IPI0)<->RPU0(IPI1) and
> +	 * APU(IPI0)<->RPU1(IPI2). However, with current available examples
> +	 * and RPU firmware, this configuration in device-tree is causing system-crash.
> +	 * And so, using extra IPI channel is required in device-tree. In split
> +	 * mode explicitly inform user about this limitation and requirement.
> +	 */
> +	if (cluster->mode == SPLIT_MODE)
> +		dev_warn(r5_core->dev, "split mode: APU should use two IPI channels\n");

This comment doesn't do anything useful, please remove.

> +
> +	mbox_cl = &r5_core->mbox_cl;
> +	mbox_cl->rx_callback = zynqmp_r5_mb_rx_cb;
> +	mbox_cl->tx_block = false;
> +	mbox_cl->knows_txdone = false;
> +	mbox_cl->tx_done = NULL;
> +	mbox_cl->dev = r5_core->dev;
> +
> +	/* Request TX and RX channels */
> +	r5_core->tx_chan = mbox_request_channel_byname(mbox_cl, "tx");
> +	if (IS_ERR(r5_core->tx_chan)) {
> +		r5_core->tx_chan = NULL;
> +		return;
> +	}
> +
> +	r5_core->rx_chan = mbox_request_channel_byname(mbox_cl, "rx");
> +	if (IS_ERR(r5_core->rx_chan)) {
> +		mbox_free_channel(r5_core->tx_chan);
> +		r5_core->rx_chan = NULL;
> +		r5_core->tx_chan = NULL;
> +		return;
> +	}
> +
> +	INIT_WORK(&r5_core->mbox_work, handle_event_notified);
> +}
> +
> +static void zynqmp_r5_free_mbox(struct zynqmp_r5_core *r5_core)
> +{
> +	if (r5_core->tx_chan) {
> +		mbox_free_channel(r5_core->tx_chan);
> +		r5_core->tx_chan = NULL;
> +	}
> +
> +	if (r5_core->rx_chan) {
> +		mbox_free_channel(r5_core->rx_chan);
> +		r5_core->rx_chan = NULL;
> +	}
> +}
> +
> +/*
> + * zynqmp_r5_core_kick() - kick a firmware if mbox is provided
> + * @rproc: r5 core's corresponding rproc structure
> + * @vqid: virtqueue ID
> + */
> +static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
> +{
> +	struct zynqmp_r5_core *r5_core = rproc->priv;
> +	struct device *dev = r5_core->dev;
> +	struct zynqmp_ipi_message *mb_msg;
> +	int ret;
> +
> +	/* don't handle kick if mbox setup failed for this core */
> +	if (!r5_core->tx_chan && !r5_core->rx_chan)
> +		return;
> +
> +	mb_msg = (struct zynqmp_ipi_message *)r5_core->tx_mc_buf;
> +	memcpy(mb_msg->data, &vqid, sizeof(vqid));
> +	mb_msg->len = sizeof(vqid);
> +	ret = mbox_send_message(r5_core->tx_chan, mb_msg);
> +	if (ret < 0)
> +		dev_warn(dev, "failed to send message\n");
> +}
> +
>  /*
>   * zynqmp_r5_set_mode()
>   *
> @@ -227,6 +423,63 @@ static int zynqmp_r5_mem_region_unmap(struct rproc *rproc,
>  	return 0;
>  }
>  
> +/**
> + * zynqmp_r5_get_mem_region_node()
> + * parse memory-region property and get reserved mem regions
> + *
> + * @r5_core: pointer to zynqmp_r5_core type object
> + *
> + * Return: 0 for success and error code for failure.
> + */
> +static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
> +{
> +	struct device_node *np, *rmem_np;
> +	struct reserved_mem **rmem;
> +	int res_mem_count, i;
> +	struct device *dev;
> +
> +	dev = r5_core->dev;
> +	np = r5_core->np;
> +
> +	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
> +							sizeof(phandle));
> +
> +	if (res_mem_count <= 0) {
> +		dev_warn(dev, "failed to get memory-region property %d\n",
> +			 res_mem_count);
> +		return 0;
> +	}
> +
> +	if (!r5_core->tx_chan && !r5_core->rx_chan)
> +		res_mem_count = 1;

Hackish, please remove.  There should not be a need to mix mailbox information
with memory regions.

> +
> +	rmem = devm_kcalloc(dev, res_mem_count,
> +			    sizeof(struct reserved_mem *), GFP_KERNEL);
> +	if (!rmem)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < res_mem_count; i++) {
> +		rmem_np = of_parse_phandle(np, "memory-region", i);
> +		if (!rmem_np)
> +			goto release_rmem;
> +
> +		rmem[i] = of_reserved_mem_lookup(rmem_np);
> +		if (!rmem[i]) {
> +			of_node_put(rmem_np);
> +			goto release_rmem;
> +		}
> +
> +		of_node_put(rmem_np);
> +	}
> +
> +	r5_core->rmem_count = res_mem_count;
> +	r5_core->rmem = rmem;
> +	return 0;
> +
> +release_rmem:
> +	return -EINVAL;
> +}
> +
>  /*
>   * add_mem_regions_carveout()
>   * @rproc: single R5 core's corresponding rproc instance
> @@ -241,6 +494,7 @@ static int add_mem_regions_carveout(struct rproc *rproc)
>  	struct zynqmp_r5_core *r5_core;
>  	struct reserved_mem *rmem;
>  	int i, num_mem_regions;
> +	const char *name;
>  
>  	r5_core = (struct zynqmp_r5_core *)rproc->priv;
>  	num_mem_regions = r5_core->rmem_count;
> @@ -253,15 +507,33 @@ static int add_mem_regions_carveout(struct rproc *rproc)
>  			rproc_mem = rproc_of_resm_mem_entry_init(&rproc->dev, i,
>  								 rmem->size,
>  								 rmem->base,
> -								 rmem->name);
> +								 "vdev0buffer");

This looks very hackish.

>  		} else {
> +			/*
> +			 * As per bindings 3rd entry in memory-region property
> +			 * must contain vring0 and 4th entry must contain vring1
> +			 * memory-regions. For remoteproc framework it is
> +			 * required to have fixed names for these carveouts i.e.
> +			 * in the form of "vdev%dvring%d" where first %d is ID
> +			 * of vdev and second %d is ID of vring. Assign fix names
> +			 * instead of node names, as node names may contain
> +			 * @unit-address as well i.e. vdev0vring0@xxxxxxxx which
> +			 * won't work.
> +			 */
> +			if (!strncmp(rmem->name, "vdev0vring0", strlen("vdev0vring0")))
> +				name = "vdev0vring0";
> +			else if (!strncmp(rmem->name, "vdev0vring1", strlen("vdev0vring1")))
> +				name = "vdev0vring1";
> +			else
> +				name = rmem->name;
> +

So does this.  It would be much better to get the right rmem->name before
getting to this function, something that should be done in
zynqmp_r5_get_mem_region_node().  Look at stm32_rproc_prepare() for an example
on how to get the right name reserve memory entries. 

I am also reasonning this problem has become obvious now that mailboxes are
working.  That said I also think it should have been caught when the patchset
adding support for r5f was worked on.

>  			/* Register associated reserved memory regions */
>  			rproc_mem = rproc_mem_entry_init(&rproc->dev, NULL,
>  							 (dma_addr_t)rmem->base,
>  							 rmem->size, rmem->base,
>  							 zynqmp_r5_mem_region_map,
>  							 zynqmp_r5_mem_region_unmap,
> -							 rmem->name);
> +							 name);
>  		}
>  
>  		if (!rproc_mem)
> @@ -572,6 +844,20 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
>  		return ret;
>  	}
>  
> +	/*
> +	 * If mailbox nodes are disabled using "status" property then setting up
> +	 * mailbox channels will be failed and in that case, we don't need vrings
> +	 * and vdevbuffer for this core. So, setup mailbox before parsing
> +	 * memory-region property. If "tx" and "rx" mailboxes are not setup, then
> +	 * only parse and add first memory-region carveout. As per bindings, it
> +	 * must be firmware load region
> +	 */
> +	zynqmp_r5_setup_mbox(rproc->priv);
> +

Setting up mailboxes should return an error code when not successful.  Moreover,
why do mailboxes have to be initialised at prepare() time and not once in the
probe() function?

> +	ret = zynqmp_r5_get_mem_region_node(rproc->priv);
> +	if (ret)
> +		dev_warn(&rproc->dev, "memory-region prop failed %d\n", ret);
> +
>  	ret = add_mem_regions_carveout(rproc);
>  	if (ret) {
>  		dev_err(&rproc->dev, "failed to get reserve mem regions %d\n", ret);
> @@ -597,6 +883,8 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
>  
>  	r5_core = (struct zynqmp_r5_core *)rproc->priv;
>  
> +	zynqmp_r5_free_mbox(r5_core);
> +
>  	for (i = 0; i < r5_core->tcm_bank_count; i++) {
>  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
>  		if (zynqmp_pm_release_node(pm_domain_id))
> @@ -617,6 +905,7 @@ static const struct rproc_ops zynqmp_r5_rproc_ops = {
>  	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
>  	.sanity_check	= rproc_elf_sanity_check,
>  	.get_boot_addr	= rproc_elf_get_boot_addr,
> +	.kick		= zynqmp_r5_rproc_kick,

A kick() function should added only when mailboxes are present rather than
invariably as it is now.

>  };
>  
>  /**
> @@ -726,59 +1015,6 @@ static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
>  	return 0;
>  }
>  
> -/**
> - * zynqmp_r5_get_mem_region_node()
> - * parse memory-region property and get reserved mem regions
> - *
> - * @r5_core: pointer to zynqmp_r5_core type object
> - *
> - * Return: 0 for success and error code for failure.
> - */
> -static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
> -{
> -	struct device_node *np, *rmem_np;
> -	struct reserved_mem **rmem;
> -	int res_mem_count, i;
> -	struct device *dev;
> -
> -	dev = r5_core->dev;
> -	np = r5_core->np;
> -
> -	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
> -							sizeof(phandle));
> -	if (res_mem_count <= 0) {
> -		dev_warn(dev, "failed to get memory-region property %d\n",
> -			 res_mem_count);
> -		return 0;
> -	}
> -
> -	rmem = devm_kcalloc(dev, res_mem_count,
> -			    sizeof(struct reserved_mem *), GFP_KERNEL);
> -	if (!rmem)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < res_mem_count; i++) {
> -		rmem_np = of_parse_phandle(np, "memory-region", i);
> -		if (!rmem_np)
> -			goto release_rmem;
> -
> -		rmem[i] = of_reserved_mem_lookup(rmem_np);
> -		if (!rmem[i]) {
> -			of_node_put(rmem_np);
> -			goto release_rmem;
> -		}
> -
> -		of_node_put(rmem_np);
> -	}
> -
> -	r5_core->rmem_count = res_mem_count;
> -	r5_core->rmem = rmem;
> -	return 0;
> -
> -release_rmem:
> -	return -EINVAL;
> -}
> -

Why was this moved instead of simply adding a forward declaration at the top of
the file?

>  /*
>   * zynqmp_r5_core_init()
>   * Create and initialize zynqmp_r5_core type object
> @@ -806,10 +1042,6 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>  	for (i = 0; i < cluster->core_count; i++) {
>  		r5_core = cluster->r5_cores[i];
>  
> -		ret = zynqmp_r5_get_mem_region_node(r5_core);
> -		if (ret)
> -			dev_warn(dev, "memory-region prop failed %d\n", ret);
> -

Why doing this since this driver doesn't support attach()/detach() operations
yet?

Thanks,
Mathieu

>  		/* Initialize r5 cores with power-domains parsed from dts */
>  		ret = of_property_read_u32_index(r5_core->np, "power-domains",
>  						 1, &r5_core->pm_domain_id);
> 
> base-commit: 10de8156ed71d3dbd7e9099aa76e67ea2c37d4ff
> -- 
> 2.25.1
> 
