Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E4C612344
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 15:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJ2NS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 09:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJ2NSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 09:18:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3B46D9EC;
        Sat, 29 Oct 2022 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667049477; x=1698585477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VPLHzdcfQf6PtRVhxGW0ORcRdGwgMEPn5tqu6HxqCYQ=;
  b=FuFd+AfHHedDfzV8PAwlQQkXK0gMA+roRQ8r9f534wY9DxEAmNwwr24Y
   5j+VIvINoHsChO/vzqhmf1ld3ujwbSRh5+CMBp2G9vM2iqIEsTw7+nSbQ
   UcAUdHAyVTf8fdqNgh+wbVLe3H4I1PIeAAxknGKSMVg2Wih/Fz4dnJ7PU
   p24vybxgtBhNsPCmofHTzvBLlVfpoS1ebkTjpoa8jVY94OauHG7m/cT8v
   jHb8FxNzY+FUP9IkkXKybL1xCsg/47+zbXjzD2czDne2AWFbF8HQ8GO2e
   0ZE/JSwIXzLZG6G8FFnDkZjGONgWjAhvSIowqC+9H4H1P291NfqGdpYNE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="370737204"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="370737204"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 06:17:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="702045501"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="702045501"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 29 Oct 2022 06:17:52 -0700
Date:   Sat, 29 Oct 2022 21:08:44 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net, jirislaby@kernel.org,
        geert+renesas@glider.be, andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com
Subject: Re: [PATCH v4 3/4] fpga: dfl: add basic support DFHv1
Message-ID: <Y10l3NkIn0gsdVZq@yilunxu-OptiPlex-7050>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com>
 <20221020212610.697729-4-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020212610.697729-4-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-20 at 14:26:09 -0700, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add generic support for MSI-X interrupts for DFL devices.

The first paragraph of the commit message should be the summary of the
whole change. But this seems one of the changes. Please add the proper
summary at the beginning.

> 
> The location of a feature's registers is explicitly
> described in DFHv1 and can be relative to the base of the DFHv1
> or an absolute address.  Parse the location and pass the information
> to DFL driver.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v4: s/MSIX/MSI_X
>     move kernel doc to implementation
>     use structure assignment
>     fix decode of absolute address
>     clean up comment in parse_feature_irqs
>     remove use of csr_res
> 
> v3: remove unneeded blank line
>     use clearer variable name
>     pass finfo into parse_feature_irqs()
>     refactor code for better indentation
>     use switch statement for irq parsing
>     squash in code parsing register location
> 
> v2: fix kernel doc
>     clarify use of DFH_VERSION field
> ---
>  drivers/fpga/dfl.c  | 234 ++++++++++++++++++++++++++++++++++----------
>  drivers/fpga/dfl.h  |   5 +
>  include/linux/dfl.h |   4 +
>  3 files changed, 194 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index b9aae85ba930..37f995e66436 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -342,6 +342,8 @@ static void release_dfl_dev(struct device *dev)
>  	if (ddev->mmio_res.parent)
>  		release_resource(&ddev->mmio_res);
>  
> +	kfree(ddev->params);
> +
>  	ida_free(&dfl_device_ida, ddev->id);
>  	kfree(ddev->irqs);
>  	kfree(ddev);
> @@ -380,7 +382,16 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
>  	ddev->type = feature_dev_id_type(pdev);
>  	ddev->feature_id = feature->id;
>  	ddev->revision = feature->revision;
> +	ddev->dfh_version = feature->dfh_version;
>  	ddev->cdev = pdata->dfl_cdev;
> +	if (feature->param_size) {
> +		ddev->params = kmemdup(feature->params, feature->param_size, GFP_KERNEL);
> +		if (!ddev->params) {
> +			ret = -ENOMEM;
> +			goto put_dev;
> +		}
> +		ddev->param_size = feature->param_size;
> +	}
>  
>  	/* add mmio resource */
>  	parent_res = &pdev->resource[feature->resource_index];
> @@ -708,20 +719,27 @@ struct build_feature_devs_info {
>   * struct dfl_feature_info - sub feature info collected during feature dev build
>   *
>   * @fid: id of this sub feature.
> + * @revision: revision of this sub feature
> + * @dfh_version: version of Device Feature Header (DFH)
>   * @mmio_res: mmio resource of this sub feature.
>   * @ioaddr: mapped base address of mmio resource.
>   * @node: node in sub_features linked list.
>   * @irq_base: start of irq index in this sub feature.
>   * @nr_irqs: number of irqs of this sub feature.
> + * @param_size: size DFH parameters.
> + * @params: DFH parameter data.
>   */
>  struct dfl_feature_info {
>  	u16 fid;
>  	u8 revision;
> +	u8 dfh_version;
>  	struct resource mmio_res;
>  	void __iomem *ioaddr;
>  	struct list_head node;
>  	unsigned int irq_base;
>  	unsigned int nr_irqs;
> +	unsigned int param_size;
> +	u64 params[];
>  };
>  
>  static void dfl_fpga_cdev_add_port_dev(struct dfl_fpga_cdev *cdev,
> @@ -797,7 +815,17 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  		feature->dev = fdev;
>  		feature->id = finfo->fid;
>  		feature->revision = finfo->revision;
> +		feature->dfh_version = finfo->dfh_version;
>  
> +		if (finfo->param_size) {
> +			feature->params = devm_kmemdup(binfo->dev,
> +						       finfo->params, finfo->param_size,
> +						       GFP_KERNEL);
> +			if (!feature->params)
> +				return -ENOMEM;
> +
> +			feature->param_size = finfo->param_size;
> +		}
>  		/*
>  		 * the FIU header feature has some fundamental functions (sriov
>  		 * set, port enable/disable) needed for the dfl bus device and
> @@ -934,56 +962,108 @@ static u16 feature_id(u64 value)
>  	return 0;
>  }
>  
> +static void *find_param(void *base, resource_size_t max, int param)
> +{
> +	int off = 0;
> +	u64 v, next;
> +
> +	while (off < max) {
> +		v = *(u64 *)(base + off);
> +		if (param == FIELD_GET(DFHv1_PARAM_HDR_ID, v))
> +			return base + off + DFHv1_PARAM_DATA;
> +
> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
> +		off += next & ~DFHv1_PARAM_HDR_NEXT_MASK;
> +		if (next & DFHv1_PARAM_HDR_NEXT_EOL)
> +			break;
> +
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * dfh_find_param() - find data for the given parameter id
> + * @dfl_dev: dfl device
> + * @param: id of dfl parameter
> + *
> + * Return: pointer to parameter data on success, NULL otherwise.
> + */
> +void *dfh_find_param(struct dfl_device *dfl_dev, int param)
> +{
> +	return find_param(dfl_dev->params, dfl_dev->param_size, param);
> +}
> +EXPORT_SYMBOL_GPL(dfh_find_param);
> +
>  static int parse_feature_irqs(struct build_feature_devs_info *binfo,
> -			      resource_size_t ofst, u16 fid,
> -			      unsigned int *irq_base, unsigned int *nr_irqs)
> +			      resource_size_t ofst, struct dfl_feature_info *finfo)
>  {
>  	void __iomem *base = binfo->ioaddr + ofst;
>  	unsigned int i, ibase, inr = 0;
> +	void *params = finfo->params;
>  	enum dfl_id_type type;
> +	u16 fid = finfo->fid;
>  	int virq;
> +	u32 *p;
>  	u64 v;
>  
> -	type = feature_dev_id_type(binfo->feature_dev);
> +	switch (finfo->dfh_version) {
> +	case 0:
> +		/*
> +		 * DFHv0 only provides mmio resource information for each feature
> +		 * in the DFL header.  There is no generic interrupt information.
> +		 * Instead, features with interrupt functionality provide
> +		 * the information in feature specific registers.
> +		 */
> +		type = feature_dev_id_type(binfo->feature_dev);
> +		if (type == PORT_ID) {
> +			switch (fid) {
> +			case PORT_FEATURE_ID_UINT:
> +				v = readq(base + PORT_UINT_CAP);
> +				ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> +				inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> +				break;
> +			case PORT_FEATURE_ID_ERROR:
> +				v = readq(base + PORT_ERROR_CAP);
> +				ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> +				inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> +				break;
> +			}
> +		} else if (type == FME_ID) {
> +			switch (fid) {
> +			case FME_FEATURE_ID_GLOBAL_ERR:
> +				v = readq(base + FME_ERROR_CAP);
> +				ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> +				inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> +				break;
> +			}
> +		}
> +		break;
>  
> -	/*
> -	 * Ideally DFL framework should only read info from DFL header, but
> -	 * current version DFL only provides mmio resources information for
> -	 * each feature in DFL Header, no field for interrupt resources.
> -	 * Interrupt resource information is provided by specific mmio
> -	 * registers of each private feature which supports interrupt. So in
> -	 * order to parse and assign irq resources, DFL framework has to look
> -	 * into specific capability registers of these private features.
> -	 *
> -	 * Once future DFL version supports generic interrupt resource
> -	 * information in common DFL headers, the generic interrupt parsing
> -	 * code will be added. But in order to be compatible to old version
> -	 * DFL, the driver may still fall back to these quirks.
> -	 */
> -	if (type == PORT_ID) {
> -		switch (fid) {
> -		case PORT_FEATURE_ID_UINT:
> -			v = readq(base + PORT_UINT_CAP);
> -			ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> -			inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> +	case 1:
> +		/*
> +		 * DFHv1 provides interrupt resource information in DFHv1
> +		 * parameter blocks.
> +		 */
> +		if (!finfo->param_size)
>  			break;
> -		case PORT_FEATURE_ID_ERROR:
> -			v = readq(base + PORT_ERROR_CAP);
> -			ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> -			inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> +
> +		p = find_param(params, finfo->param_size, DFHv1_PARAM_ID_MSI_X);
> +		if (!p)
>  			break;
> -		}
> -	} else if (type == FME_ID) {
> -		if (fid == FME_FEATURE_ID_GLOBAL_ERR) {
> -			v = readq(base + FME_ERROR_CAP);
> -			ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> -			inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> -		}
> +
> +		ibase = *p++;
> +		inr = *p;
> +		break;
> +
> +	default:
> +		dev_warn(binfo->dev, "unexpected DFH version %d\n", finfo->dfh_version);
> +		break;
>  	}
>  
>  	if (!inr) {
> -		*irq_base = 0;
> -		*nr_irqs = 0;
> +		finfo->irq_base = 0;
> +		finfo->nr_irqs = 0;
>  		return 0;
>  	}
>  
> @@ -1006,12 +1086,37 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>  		}
>  	}
>  
> -	*irq_base = ibase;
> -	*nr_irqs = inr;
> +	finfo->irq_base = ibase;
> +	finfo->nr_irqs = inr;
>  
>  	return 0;
>  }
>  
> +static int dfh_get_psize(void __iomem *dfh_base, resource_size_t max)
> +{
> +	int size = 0;
> +	u64 v, next;
> +
> +	if (!FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS,
> +		       readq(dfh_base + DFHv1_CSR_SIZE_GRP)))
> +		return 0;
> +
> +	while (size + DFHv1_PARAM_HDR < max) {
> +		v = readq(dfh_base + DFHv1_PARAM_HDR + size);
> +
> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
> +		if (!(next & ~DFHv1_PARAM_HDR_NEXT_MASK))
> +			return -EINVAL;
> +
> +		size += next & ~DFHv1_PARAM_HDR_NEXT_MASK;
> +
> +		if (next & DFHv1_PARAM_HDR_NEXT_EOL)
> +			return size;
> +	}
> +
> +	return -ENOENT;
> +}
> +
>  /*
>   * when create sub feature instances, for private features, it doesn't need
>   * to provide resource size and feature id as they could be read from DFH
> @@ -1023,39 +1128,70 @@ static int
>  create_feature_instance(struct build_feature_devs_info *binfo,
>  			resource_size_t ofst, resource_size_t size, u16 fid)
>  {
> -	unsigned int irq_base, nr_irqs;
>  	struct dfl_feature_info *finfo;
> +	int dfh_psize = 0;
>  	u8 revision = 0;
> +	u8 dfh_ver = 0;
>  	int ret;
>  	u64 v;
>  
>  	if (fid != FEATURE_ID_AFU) {
>  		v = readq(binfo->ioaddr + ofst);
>  		revision = FIELD_GET(DFH_REVISION, v);
> -
> +		dfh_ver = FIELD_GET(DFH_VERSION, v);
>  		/* read feature size and id if inputs are invalid */
>  		size = size ? size : feature_size(v);
>  		fid = fid ? fid : feature_id(v);
> +		if (dfh_ver == 1) {
> +			dfh_psize = dfh_get_psize(binfo->ioaddr + ofst, size);
> +			if (dfh_psize < 0) {
> +				dev_err(binfo->dev,
> +					"failed to read size of DFHv1 parameters %d\n",
> +					dfh_psize);
> +				return dfh_psize;
> +			}
> +			dev_dbg(binfo->dev, "dfhv1_psize %d\n", dfh_psize);
> +		}
>  	}
>  
>  	if (binfo->len - ofst < size)
>  		return -EINVAL;
>  
> -	ret = parse_feature_irqs(binfo, ofst, fid, &irq_base, &nr_irqs);
> -	if (ret)
> -		return ret;
> -
> -	finfo = kzalloc(sizeof(*finfo), GFP_KERNEL);
> +	finfo = kzalloc(sizeof(*finfo) + dfh_psize, GFP_KERNEL);

The u64 flexible array in the structure, but seems dfh_get_psize could
not garantee 64bit aligned size.

What's the mandatory alignment of param data? If 64bit aligned, bit 33-34
of PARAM_HDR should be reserved. If 32bit aligned, finfo:params should be
u32[].

Thanks,
Yilun

>  	if (!finfo)
>  		return -ENOMEM;
>  
> +	if (dfh_psize > 0) {
> +		memcpy_fromio(finfo->params,
> +			      binfo->ioaddr + ofst + DFHv1_PARAM_HDR, dfh_psize);
> +		finfo->param_size = dfh_psize;
> +	}
> +
>  	finfo->fid = fid;
>  	finfo->revision = revision;
> -	finfo->mmio_res.start = binfo->start + ofst;
> -	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
> +	finfo->dfh_version = dfh_ver;
>  	finfo->mmio_res.flags = IORESOURCE_MEM;
> -	finfo->irq_base = irq_base;
> -	finfo->nr_irqs = nr_irqs;
> +	if (dfh_ver == 1) {
> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_ADDR);
> +		if (v & DFHv1_CSR_ADDR_REL)
> +			finfo->mmio_res.start = v & ~DFHv1_CSR_ADDR_REL;
> +		else
> +			finfo->mmio_res.start = binfo->start + ofst +
> +					       FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
> +
> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_SIZE_GRP);
> +		finfo->mmio_res.end = finfo->mmio_res.start +
> +				      FIELD_GET(DFHv1_CSR_SIZE_GRP_SIZE, v) - 1;

So for dflv1, no feature header resource for dfl_device, is it a problem
for dfl_uio? Does userspace driver need the raw feature header?

> +	} else {
> +		finfo->mmio_res.start = binfo->start + ofst;
> +		finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
> +	}
> +
> +	ret = parse_feature_irqs(binfo, ofst, finfo);
> +	if (ret) {
> +		kfree(finfo);
> +		return ret;
> +	}
>  
>  	list_add_tail(&finfo->node, &binfo->sub_features);
>  	binfo->feature_num++;
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 45e6e1359a67..1ea7f40c1af6 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -273,11 +273,14 @@ struct dfl_feature_irq_ctx {
>   * @ops: ops of this sub feature.
>   * @ddev: ptr to the dfl device of this sub feature.
>   * @priv: priv data of this feature.
> + * @param_size: size of dfh parameters
> + * @params: point to memory copy of dfh parameters
>   */
>  struct dfl_feature {
>  	struct platform_device *dev;
>  	u16 id;
>  	u8 revision;
> +	u8 dfh_version;
>  	int resource_index;
>  	void __iomem *ioaddr;
>  	struct dfl_feature_irq_ctx *irq_ctx;
> @@ -285,6 +288,8 @@ struct dfl_feature {
>  	const struct dfl_feature_ops *ops;
>  	struct dfl_device *ddev;
>  	void *priv;
> +	unsigned int param_size;
> +	void *params;
>  };
>  
>  #define FEATURE_DEV_ID_UNUSED	(-1)
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index fea9e16d35b6..d00787e870b7 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -50,9 +50,12 @@ struct dfl_device {
>  	u16 type;
>  	u16 feature_id;
>  	u8 revision;
> +	u8 dfh_version;
>  	struct resource mmio_res;
>  	int *irqs;
>  	unsigned int num_irqs;
> +	unsigned int param_size;
> +	void *params;
>  	struct dfl_fpga_cdev *cdev;
>  	const struct dfl_device_id *id_entry;
>  };
> @@ -95,4 +98,5 @@ void dfl_driver_unregister(struct dfl_driver *dfl_drv);
>  	module_driver(__dfl_driver, dfl_driver_register, \
>  		      dfl_driver_unregister)
>  
> +void *dfh_find_param(struct dfl_device *dfl_dev, int param);

int param_id is better?

Thanks,
Yilun

>  #endif /* __LINUX_DFL_H */
> -- 
> 2.25.1
> 
