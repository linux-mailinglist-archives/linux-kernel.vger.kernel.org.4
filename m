Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5EA66CA80
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjAPRDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjAPRDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:03:17 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CC72F7BD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:45:30 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id g23so15267404plq.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LzyAhUKx02vsHse/bj4NXPoBji03hcAvZwNWSPzAssE=;
        b=UkWrXvDyc0cUkxpAlH9rI8+XFykmRKW7wp/w2dlGz5MwCiHza3yS8mCK8rn+4+ik7P
         BiwVt+UW+GtQQ77q/Y333Ged6OvdSffMFYXzu1cyNEkPcCz9cwbQ2GSsIeFz9GmAwbSJ
         WN9tAtzAmyCPXp8zvEaYbHEK+AC/YA9UeXIytjnjMcGYt0JJ8u/gAs2/5z9kbrUdIvQ6
         BKPzlJpwVH42ZRuY6RuZZ18VSFIz5ghVbiAACCCmUJLwktJ7qD2ellthVZV3VUUxzgq6
         OHzXOjOVXZbS4RaqZj+HkDZpWizr0ZI+ZatCHhobnr+NBbOzJbwbLvVa/i/lDtu+1MWn
         MKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzyAhUKx02vsHse/bj4NXPoBji03hcAvZwNWSPzAssE=;
        b=LJLrrx3858kwsBKYtPES7vwg4vZtQ3oNbBdG6gx/MopDmgxgs5ORBu/AHm7rdlg8xj
         MLGZgvUWPxHaQX7DJedYUT26uFdhUZFWPqgIqiNcCug6CLyhz1JTRkyHGzoh3oBSlUTh
         N4+Baxu60Ymw6qdvXYh7nYP8mfjsPdH7ziBRfbUr4luSraCqU5bmkELeDUGrcCadL51Q
         Qp3Y9Y/xBq50MqFyRtVpxnXkwzeZyAWFnudQ2SkhYPEjjDIDuiGqGLhKxiWEEd13ZlAQ
         HbCpVXoHCKHIi3rJOpZTED7AklM3kjUYRPPOrfUAq/VwJCqyarpmeG4eFgM7j4XK4Tap
         OacA==
X-Gm-Message-State: AFqh2krgAJ5bRRkf1uQjP+LzRunXsLrrYrBwgXeeF/sed1g1SgWIEmBi
        OEmghP91WcFolfxEmjOHPZFnDg==
X-Google-Smtp-Source: AMrXdXujuxveDFPFhYUPCXbSH9LxGIDcACLfLoa5S2FWGSOTzxkQzqRq2FIE1WsGcBQtPD6eOBcYpQ==
X-Received: by 2002:a05:6a20:ce4d:b0:b8:71b7:b903 with SMTP id id13-20020a056a20ce4d00b000b871b7b903mr5854407pzb.31.1673887530242;
        Mon, 16 Jan 2023 08:45:30 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:32ab:eb7f:cea:1014])
        by smtp.gmail.com with ESMTPSA id i15-20020aa796ef000000b0058d9623e7f1sm2944640pfq.73.2023.01.16.08.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 08:45:29 -0800 (PST)
Date:   Mon, 16 Jan 2023 09:45:27 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Devarsh Thakkar <devarsht@ti.com>
Cc:     andersson@kernel.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s-anna@ti.com, hnagalla@ti.com,
        praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com,
        j-luthra@ti.com
Subject: Re: [PATCH v6 3/3] remoteproc: k3-r5: Use separate compatible string
 for TI AM62x SoC family
Message-ID: <20230116164527.GB3239767@p14s>
References: <20230116151906.549384-1-devarsht@ti.com>
 <20230116151906.549384-4-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116151906.549384-4-devarsht@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 08:49:06PM +0530, Devarsh Thakkar wrote:
> AM62 and AM62A SoCs use single core R5F which is a new scenario
> different than the one being used with CLUSTER_MODE_SINGLECPU
> which is for utilizing a single core from a set of cores available
> in R5F cluster present in the SoC.
> 
> To support this single core scenario map it with
> newly defined CLUSTER_MODE_SINGLECORE and use it when
> compatible is set to ti,am62-r5fss.
> 
> Also set PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE config for
> CLUSTER_MODE_SINGLECORE too as it is required by R5 core when it
> is being as general purpose core instead of device manager.
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V2:
> - Fix indentation and ordering issues as per review comments
> V3:
> - Change CLUSTER_MODE_NONE value to -1
> V4:
> - No change
> V5:
> - No change (fixing typo in email address)
> V6:
>    - Use CLUSTER_MODE_SINGLECORE for AM62x
>    - Set PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE for single core.
> ---
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 62 +++++++++++++++++++-----
>  1 file changed, 49 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 036c9dc217f3..089215144e6b 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -71,14 +71,16 @@ struct k3_r5_mem {
>  /*
>   * All cluster mode values are not applicable on all SoCs. The following
>   * are the modes supported on various SoCs:
> - *   Split mode      : AM65x, J721E, J7200 and AM64x SoCs
> - *   LockStep mode   : AM65x, J721E and J7200 SoCs
> - *   Single-CPU mode : AM64x SoCs only
> + *   Split mode       : AM65x, J721E, J7200 and AM64x SoCs
> + *   LockStep mode    : AM65x, J721E and J7200 SoCs
> + *   Single-CPU mode  : AM64x SoCs only
> + *   Single-Core mode : AM62x, AM62A SoCs
>   */
>  enum cluster_mode {
>  	CLUSTER_MODE_SPLIT = 0,
>  	CLUSTER_MODE_LOCKSTEP,
>  	CLUSTER_MODE_SINGLECPU,
> +	CLUSTER_MODE_SINGLECORE
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
> +	    cluster->mode == CLUSTER_MODE_SINGLECORE) {
>  		core = core0;
>  	} else {
>  		core = kproc->core;
> @@ -881,7 +886,8 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
>  		 * with the bit configured, so program it only on
>  		 * permitted cores
>  		 */
> -		if (cluster->mode == CLUSTER_MODE_SINGLECPU) {
> +		if (cluster->mode == CLUSTER_MODE_SINGLECPU ||
> +		    cluster->mode == CLUSTER_MODE_SINGLECORE) {
>  			set_cfg = PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE;

Why was this not part of the 5 previous version?

>  		} else {
>  			/*
> @@ -1073,6 +1079,7 @@ static void k3_r5_adjust_tcm_sizes(struct k3_r5_rproc *kproc)
>  
>  	if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
>  	    cluster->mode == CLUSTER_MODE_SINGLECPU ||
> +	    cluster->mode == CLUSTER_MODE_SINGLECORE ||
>  	    !cluster->soc_data->tcm_is_double)
>  		return;
>  
> @@ -1146,7 +1153,9 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
>  	atcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_ATCM_EN ?  1 : 0;
>  	btcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_BTCM_EN ?  1 : 0;
>  	loczrama = cfg & PROC_BOOT_CFG_FLAG_R5_TCM_RSTBASE ?  1 : 0;
> -	if (cluster->soc_data->single_cpu_mode) {
> +	if (cluster->soc_data->is_single_core) {
> +		mode = CLUSTER_MODE_SINGLECORE;
> +	} else if (cluster->soc_data->single_cpu_mode) {

I have already commented on that.

>  		mode = cfg & PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE ?
>  				CLUSTER_MODE_SINGLECPU : CLUSTER_MODE_SPLIT;
>  	} else {
> @@ -1268,9 +1277,12 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>  			goto err_add;
>  		}
>  
> -		/* create only one rproc in lockstep mode or single-cpu mode */
> +		/* create only one rproc in lockstep, single-cpu or
> +		 * single core mode
> +		 */
>  		if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
> -		    cluster->mode == CLUSTER_MODE_SINGLECPU)
> +		    cluster->mode == CLUSTER_MODE_SINGLECPU ||
> +		    cluster->mode == CLUSTER_MODE_SINGLECORE)
>  			break;
>  	}
>  
> @@ -1699,12 +1711,19 @@ static int k3_r5_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	cluster->dev = dev;
> +
>  	/*
> -	 * default to most common efuse configurations - Split-mode on AM64x
> -	 * and LockStep-mode on all others
> +	 * default to most common efuse configurations -
> +	 * Split-mode on AM64x
> +	 * Single core on AM62x
> +	 * LockStep-mode on all others
>  	 */
> -	cluster->mode = data->single_cpu_mode ?
> +	if (!data->is_single_core)
> +		cluster->mode = data->single_cpu_mode ?
>  				CLUSTER_MODE_SPLIT : CLUSTER_MODE_LOCKSTEP;
> +	else
> +		cluster->mode = CLUSTER_MODE_SINGLECORE;
> +
>  	cluster->soc_data = data;
>  	INIT_LIST_HEAD(&cluster->cores);
>  
> @@ -1716,8 +1735,14 @@ static int k3_r5_probe(struct platform_device *pdev)
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
> @@ -1759,18 +1784,28 @@ static const struct k3_r5_soc_data am65_j721e_soc_data = {
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
> @@ -1778,6 +1813,7 @@ static const struct of_device_id k3_r5_of_match[] = {
>  	{ .compatible = "ti,j721e-r5fss", .data = &am65_j721e_soc_data, },
>  	{ .compatible = "ti,j7200-r5fss", .data = &j7200_j721s2_soc_data, },
>  	{ .compatible = "ti,am64-r5fss",  .data = &am64_soc_data, },
> +	{ .compatible = "ti,am62-r5fss",  .data = &am62_soc_data, },
>  	{ .compatible = "ti,j721s2-r5fss",  .data = &j7200_j721s2_soc_data, },
>  	{ /* sentinel */ },
>  };
> -- 
> 2.34.1
> 
