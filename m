Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF4663AEA6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiK1RQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbiK1RP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:15:56 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3079E1F2FE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:15:51 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id w37so5368241pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ddbBdpNulsR017n5E5YgcxOMQu/XEoBOW3P2/1F1co=;
        b=YuMQpL0dv1TqpmeyTczz0+lHKypVBQGOTC6Eh54K9A2OOim19lAMI8f7qumUqwuVLc
         fCzHYDb2mQeTszPnAToL5TDmRRlsmYmTLe49F+LKnYyu4U2BqvVnOjHUDlLxJrSNPI1W
         InD7aab8AUTHkJEpgX4u6ze6B1vYS9cYjQROIRUszCYO7J1kGr82VP9Sd5C7BnknXfg5
         Ig6LMrF2ucMR5BhviI7P/bouFPcDgeTxD7cmN/J1OK00wb2An9TEFOegYmCG3XyaB99j
         oOZndMPeQro6nkdfCoosUPwc/2QAG66aBhDPwJw53ASVUs1pA5C5gXha45qAackwmvVA
         KBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ddbBdpNulsR017n5E5YgcxOMQu/XEoBOW3P2/1F1co=;
        b=Wi+hKTX+4wJ6G116VHAJLrqvg510ABYUCY/S2bOmBiMxmcBp+2BLKiuEY+hOJNZ+Bp
         lFyPJ7TC2uvBqzX3I/gquj50KacEpFlzv3/5x17HCdTQ3dGtAnPMSqeIHg471lG48Tes
         199rkJUnoHX/D32zblmhOfWn3h9dITv9MfLtNH5Y8Fu8CnG/nNmpAh6cPsABw3FpRR+v
         PZQQYqH2L+79FwIu7KqSIA9Iy3t8nVvoa3nGU8sKjK6C8JnQpHjBTfET86ew6OW7gDlw
         6b8V4wNGCMVqk13VDPXl4sLMAMaWwmDgY41rDd4wdTE5hT3Nr1uJ8dwVdUPMw3fFJxWT
         46Fg==
X-Gm-Message-State: ANoB5pkGfCZ7OW5Lomp9MTapNUuvEK6jE1sCf5ZZ4gL4OjNkKw2WKSli
        poTFxkdDlTR9FWuDo9dDDNvAIQ==
X-Google-Smtp-Source: AA0mqf5sW47znWbvJ9Z/d/FaEVQXL7+HslesJb7PG8taPoT9CXtpOMmrKB1gj7QHXErlp7PXRJdatg==
X-Received: by 2002:a63:f442:0:b0:477:ea30:7d6a with SMTP id p2-20020a63f442000000b00477ea307d6amr14005784pgk.212.1669655750968;
        Mon, 28 Nov 2022 09:15:50 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:908e:93f3:e339:ae71])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79ad9000000b0056befcd7958sm8262895pfp.84.2022.11.28.09.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 09:15:49 -0800 (PST)
Date:   Mon, 28 Nov 2022 10:15:47 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Devarsh Thakkar <devarsht@ti.com>
Cc:     andersson@kernel.org, p.zabel@pengutronix.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        s-anna@ti.com, hnagalla@ti.com, praneeth@ti.com, nm@ti.com,
        vigneshr@ti.com, a-bhatia1@ti.com, j-luthra@ti.com
Subject: Re: [PATCH 2/2] remoteproc: k3-r5: Use separate compatible string
 for TI AM62 SoC family
Message-ID: <20221128171547.GA1010946@p14s>
References: <20221115060934.13279-1-devarsht@ti.com>
 <20221115060934.13279-3-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115060934.13279-3-devarsht@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Devarsh,

On Tue, Nov 15, 2022 at 11:39:34AM +0530, Devarsh Thakkar wrote:
> AM62 and AM62A SoCs use single core R5F which is a new scenario
> different than the one being used with CLUSTER_MODE_SINGLECPU
> which is for utilizing a single core from a set of cores available
> in R5F cluster present in the SoC.
> 
> To support this single core scenario map it with
> newly defined CLUSTER_MODE_NONE and use it when
> compatible is set to ti,am62-r5fss.
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 55 ++++++++++++++++++------
>  1 file changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 0481926c6975..b5adcaa3d3a4 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -74,11 +74,13 @@ struct k3_r5_mem {
>   *   Split mode      : AM65x, J721E, J7200 and AM64x SoCs
>   *   LockStep mode   : AM65x, J721E and J7200 SoCs
>   *   Single-CPU mode : AM64x SoCs only
> + *   None            : AM62x, AM62A SoCs
>   */
>  enum cluster_mode {
>  	CLUSTER_MODE_SPLIT = 0,
>  	CLUSTER_MODE_LOCKSTEP,
>  	CLUSTER_MODE_SINGLECPU,
> +	CLUSTER_MODE_NONE,
>  };
>  
>  /**
> @@ -86,11 +88,13 @@ enum cluster_mode {
>   * @tcm_is_double: flag to denote the larger unified TCMs in certain modes
>   * @tcm_ecc_autoinit: flag to denote the auto-initialization of TCMs for ECC
>   * @single_cpu_mode: flag to denote if SoC/IP supports Single-CPU mode
> + * @is_single_core: flag to denote if SoC/IP has only single core R5
>   */
>  struct k3_r5_soc_data {
>  	bool tcm_is_double;
>  	bool tcm_ecc_autoinit;
>  	bool single_cpu_mode;
> +	bool is_single_core;
>  };
>  
>  /**
> @@ -838,7 +842,8 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
>  
>  	core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
>  	if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
> -	    cluster->mode == CLUSTER_MODE_SINGLECPU) {
> +	    cluster->mode == CLUSTER_MODE_SINGLECPU ||
> +		cluster->mode == CLUSTER_MODE_NONE) {

Indentation problem.  


>  		core = core0;
>  	} else {
>  		core = kproc->core;
> @@ -853,7 +858,7 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
>  		boot_vec, cfg, ctrl, stat);
>  
>  	/* check if only Single-CPU mode is supported on applicable SoCs */
> -	if (cluster->soc_data->single_cpu_mode) {
> +	if (cluster->soc_data->single_cpu_mode || cluster->soc_data->is_single_core) {
>  		single_cpu =
>  			!!(stat & PROC_BOOT_STATUS_FLAG_R5_SINGLECORE_ONLY);
>  		if (single_cpu && cluster->mode == CLUSTER_MODE_SPLIT) {
> @@ -1074,6 +1079,7 @@ static void k3_r5_adjust_tcm_sizes(struct k3_r5_rproc *kproc)
>  
>  	if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
>  	    cluster->mode == CLUSTER_MODE_SINGLECPU ||
> +		cluster->mode == CLUSTER_MODE_NONE ||

Indentation problem.

>  	    !cluster->soc_data->tcm_is_double)
>  		return;
>  
> @@ -1147,7 +1153,9 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
>  	atcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_ATCM_EN ?  1 : 0;
>  	btcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_BTCM_EN ?  1 : 0;
>  	loczrama = cfg & PROC_BOOT_CFG_FLAG_R5_TCM_RSTBASE ?  1 : 0;
> -	if (cluster->soc_data->single_cpu_mode) {
> +	if (cluster->soc_data->is_single_core) {
> +		mode = CLUSTER_MODE_NONE;
> +	} else if (cluster->soc_data->single_cpu_mode) {
>  		mode = cfg & PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE ?
>  				CLUSTER_MODE_SINGLECPU : CLUSTER_MODE_SPLIT;
>  	} else {
> @@ -1271,6 +1279,7 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>  
>  		/* create only one rproc in lockstep mode or single-cpu mode */
>  		if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
> +			cluster->mode == CLUSTER_MODE_NONE     ||

Indentation problem.

Also, CLUSTER_MODE_NONE should be after CLUSTER_MODE_SINGLECPU as you did in
k3_r5_adjust_tcm_sizes().

>  		    cluster->mode == CLUSTER_MODE_SINGLECPU)
>  			break;
>  	}
> @@ -1704,21 +1713,32 @@ static int k3_r5_probe(struct platform_device *pdev)
>  	 * default to most common efuse configurations - Split-mode on AM64x
>  	 * and LockStep-mode on all others
>  	 */
> -	cluster->mode = data->single_cpu_mode ?
> -				CLUSTER_MODE_SPLIT : CLUSTER_MODE_LOCKSTEP;
> +	if (!data->is_single_core)
> +		cluster->mode = data->single_cpu_mode ?
> +						CLUSTER_MODE_SPLIT : CLUSTER_MODE_LOCKSTEP;

Indentation problem - the 'C' should be aligned with the 'd' on the previous
line.


> +	else
> +		cluster->mode = CLUSTER_MODE_NONE;
> +
>  	cluster->soc_data = data;
>  	INIT_LIST_HEAD(&cluster->cores);
>  
> -	ret = of_property_read_u32(np, "ti,cluster-mode", &cluster->mode);
> -	if (ret < 0 && ret != -EINVAL) {
> -		dev_err(dev, "invalid format for ti,cluster-mode, ret = %d\n",
> -			ret);
> -		return ret;
> +	if (!data->is_single_core) {
> +		ret = of_property_read_u32(np, "ti,cluster-mode", &cluster->mode);
> +		if (ret < 0 && ret != -EINVAL) {
> +			dev_err(dev, "invalid format for ti,cluster-mode, ret = %d\n", ret);
> +			return ret;
> +		}
>  	}
>  
>  	num_cores = of_get_available_child_count(np);
> -	if (num_cores != 2) {
> -		dev_err(dev, "MCU cluster requires both R5F cores to be enabled, num_cores = %d\n",
> +	if (num_cores != 2 && !data->is_single_core) {
> +		dev_err(dev, "MCU cluster requires both R5F cores to be enabled but num_cores is set to = %d\n",
> +			num_cores);
> +		return -ENODEV;
> +	}
> +
> +	if (num_cores != 1 && data->is_single_core) {
> +		dev_err(dev, "SoC supports only single core R5 but num_cores is set to %d\n",
>  			num_cores);
>  		return -ENODEV;
>  	}
> @@ -1760,18 +1780,28 @@ static const struct k3_r5_soc_data am65_j721e_soc_data = {
>  	.tcm_is_double = false,
>  	.tcm_ecc_autoinit = false,
>  	.single_cpu_mode = false,
> +	.is_single_core = false,
>  };
>  
>  static const struct k3_r5_soc_data j7200_j721s2_soc_data = {
>  	.tcm_is_double = true,
>  	.tcm_ecc_autoinit = true,
>  	.single_cpu_mode = false,
> +	.is_single_core = false,
>  };
>  
>  static const struct k3_r5_soc_data am64_soc_data = {
>  	.tcm_is_double = true,
>  	.tcm_ecc_autoinit = true,
>  	.single_cpu_mode = true,
> +	.is_single_core = false,
> +};
> +
> +static const struct k3_r5_soc_data am62_soc_data = {
> +	.tcm_is_double = false,
> +	.tcm_ecc_autoinit = true,
> +	.single_cpu_mode = false,
> +	.is_single_core = true,
>  };
>  
>  static const struct of_device_id k3_r5_of_match[] = {
> @@ -1779,6 +1809,7 @@ static const struct of_device_id k3_r5_of_match[] = {
>  	{ .compatible = "ti,j721e-r5fss", .data = &am65_j721e_soc_data, },
>  	{ .compatible = "ti,j7200-r5fss", .data = &j7200_j721s2_soc_data, },
>  	{ .compatible = "ti,am64-r5fss",  .data = &am64_soc_data, },
> +	{ .compatible = "ti,am62-r5fss",  .data = &am62_soc_data, },
>  	{ .compatible = "ti,j721s2-r5fss",  .data = &j7200_j721s2_soc_data, },
>  	{ /* sentinel */ },
>  };
> -- 
> 2.17.1
> 
