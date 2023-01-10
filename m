Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E576664B53
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbjAJSlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239678AbjAJSlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:41:25 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136205EC25
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:35:09 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id b12so8844092pgj.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g52wDQR8/IIDDs4StQuzSV2ua8NLfetdd275k+8B5dM=;
        b=cD32zmqroBWxd8Rr7zVcOTbU+5VannjE8t2cnjJxlHRjAkkf4+KjVLscm2qGdFUbo2
         K9cwjru/GH6tPTm7JzrVYYwCNztERSce3Nyy+VcE8F0eQTObMgwX7Kd0sJiaGvCw/saY
         7vjG3QHmYGE986WlemST8r7i1jYut8m9qkNjplF3alpv02ATj4E1fX5wQV/Qie7gcuXT
         RIFoQWdZ+/wf6YzPpeP1bqZ4HmImEEP6UzW6mU8u8I32sAFbejOO97L2JswA5alKbrG4
         CDa6fqvioSEsQ35+yaIbzrAyb1SzcI895q5yRVBroJmuBCEhqMfPZv0xnQ/tRHf1bjJ6
         jM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g52wDQR8/IIDDs4StQuzSV2ua8NLfetdd275k+8B5dM=;
        b=mAfrcgA/LlQucL2kOsgKXusTm3jTKM5+Q16MS+q2WGdQcSHxE2rSX+spMV9B+3IvAT
         Cko7Slyx0D5vN7SPtOqKZL4n1sEvTEGOSfCe9ZvMAHJUiB7NbaDUe9VgbZG44KAM8t9j
         EdaOPe7e9ov7a2TXQSBGJQgZ1MCZf4Ec+8CB2S6kSi3kbZRoLP34KJOtCIpdZ+S/WQuL
         dEHdWty/4tGbl8uKs/YtNxXEQp7xluQSK318Jl3g0PXh3Q2oTIAyKEAyDKksD+nD/VVi
         C7kqzPudLaXzt+lVviHZf4tCCw7A1gakyBOHaq02QfptBVpWYRa48YkUq88KYS4D5R3D
         OPnw==
X-Gm-Message-State: AFqh2koILre57wD6b2b/EMVhlg4eest9jaRoHcgGvy9cepgMNh3Zxh/Q
        0yqnExJqnQare2mgAYc1KV9x8g==
X-Google-Smtp-Source: AMrXdXtKOknjNWVmAs9h7nmS8UbdLQIT0fCBX7CP9/j+Zq27bBae9rPRYTblI9ZsBzlG3n/d3KSewQ==
X-Received: by 2002:a05:6a00:450a:b0:56e:664f:a5f5 with SMTP id cw10-20020a056a00450a00b0056e664fa5f5mr83432498pfb.8.1673375708461;
        Tue, 10 Jan 2023 10:35:08 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:339:119d:e561:2d7d])
        by smtp.gmail.com with ESMTPSA id 3-20020a621503000000b00581c741f95csm6634963pfv.46.2023.01.10.10.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:35:08 -0800 (PST)
Date:   Tue, 10 Jan 2023 11:35:05 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Devarsh Thakkar <devarsht@ti.com>
Cc:     andersson@kernel.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s-anna@ti.com, hnagalla@ti.com,
        praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com,
        j-luthra@ti.com
Subject: Re: [PATCH v5 2/2] remoteproc: k3-r5: Use separate compatible string
 for TI AM62 SoC family
Message-ID: <20230110183505.GA2741090@p14s>
References: <20221227145216.1524-1-devarsht@ti.com>
 <20221227145216.1524-3-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227145216.1524-3-devarsht@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 08:22:16PM +0530, Devarsh Thakkar wrote:
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
> V2: Fix indentation and ordering issues as per review comments
> V3: Change CLUSTER_MODE_NONE value to -1
> V4: No change
> V5: No change (fixing typo in email address)
> ---
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 57 ++++++++++++++++++------
>  1 file changed, 44 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 0481926c6975..127f1f68e592 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -74,9 +74,11 @@ struct k3_r5_mem {
>   *   Split mode      : AM65x, J721E, J7200 and AM64x SoCs
>   *   LockStep mode   : AM65x, J721E and J7200 SoCs
>   *   Single-CPU mode : AM64x SoCs only
> + *   None            : AM62x, AM62A SoCs
>   */
>  enum cluster_mode {
> -	CLUSTER_MODE_SPLIT = 0,
> +	CLUSTER_MODE_NONE = -1,

s/CLUSTER_MODE_NONE/CLUSTER_MODE_ONECORE

And add it after CLUSTER_MODE_SINGLECPU

> +	CLUSTER_MODE_SPLIT,
>  	CLUSTER_MODE_LOCKSTEP,
>  	CLUSTER_MODE_SINGLECPU,
>  };
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
> +	    cluster->mode == CLUSTER_MODE_NONE) {
>  		core = core0;
>  	} else {
>  		core = kproc->core;
> @@ -853,7 +858,7 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
>  		boot_vec, cfg, ctrl, stat);
>  
>  	/* check if only Single-CPU mode is supported on applicable SoCs */
> -	if (cluster->soc_data->single_cpu_mode) {
> +	if (cluster->soc_data->single_cpu_mode || cluster->soc_data->is_single_core) {

Everywhere other than k3_r5_probe(), cluster->mode should be used.  Otherwise it
is wildly confusing and error prone.  Please resend this set with an extra
preamble patch that fixes this.

>  		single_cpu =
>  			!!(stat & PROC_BOOT_STATUS_FLAG_R5_SINGLECORE_ONLY);
>  		if (single_cpu && cluster->mode == CLUSTER_MODE_SPLIT) {
> @@ -1074,6 +1079,7 @@ static void k3_r5_adjust_tcm_sizes(struct k3_r5_rproc *kproc)
>  
>  	if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
>  	    cluster->mode == CLUSTER_MODE_SINGLECPU ||
> +	    cluster->mode == CLUSTER_MODE_NONE ||
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

Same comment as above.

>  	} else {
> @@ -1271,7 +1279,8 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>  
>  		/* create only one rproc in lockstep mode or single-cpu mode */
>  		if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
> -		    cluster->mode == CLUSTER_MODE_SINGLECPU)
> +		    cluster->mode == CLUSTER_MODE_SINGLECPU ||
> +		    cluster->mode == CLUSTER_MODE_NONE)
>  			break;
>  	}
>  
> @@ -1704,21 +1713,32 @@ static int k3_r5_probe(struct platform_device *pdev)
>  	 * default to most common efuse configurations - Split-mode on AM64x
>  	 * and LockStep-mode on all others
>  	 */

The above comment needs to be adjusted.

Thanks,
Mathieu

> -	cluster->mode = data->single_cpu_mode ?
> +	if (!data->is_single_core)
> +		cluster->mode = data->single_cpu_mode ?
>  				CLUSTER_MODE_SPLIT : CLUSTER_MODE_LOCKSTEP;
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
> +		ret = of_property_read_s32(np, "ti,cluster-mode", &cluster->mode);
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
