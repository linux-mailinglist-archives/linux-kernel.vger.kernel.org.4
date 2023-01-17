Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6177F66E10E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjAQOmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjAQOmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:42:03 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4942E0E1;
        Tue, 17 Jan 2023 06:42:01 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30HEfsx4003203;
        Tue, 17 Jan 2023 08:41:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673966514;
        bh=qMI40n9Jg933qD8lnlcWFusTT5yfunXtFEJ9UhoK5uc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=SOpkKpsH5XJpVdrcj7UzuW5EpuhVLElTMfaFksNs7aBafxEnjTLLuN1fmT0tDTRuI
         cLqdxWFxrC/1OVoLJsuLxGyZkmBXwgpyyVq7dBEfq96JDdMy+rwtZZdzX3DsYfauB4
         3Z1G422kRm+JY1aAjd81Z66/RULbJg+HfqzPyYhI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30HEfspc020508
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jan 2023 08:41:54 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 17
 Jan 2023 08:41:53 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 17 Jan 2023 08:41:53 -0600
Received: from [172.24.145.199] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30HEfnMi013379;
        Tue, 17 Jan 2023 08:41:50 -0600
Message-ID: <53a231ae-1bc7-d8ab-9117-d8c73b2db5c1@ti.com>
Date:   Tue, 17 Jan 2023 20:11:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 3/3] remoteproc: k3-r5: Use separate compatible string
 for TI AM62x SoC family
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <linux-remoteproc@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>,
        <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>
References: <20230116151906.549384-1-devarsht@ti.com>
 <20230116151906.549384-4-devarsht@ti.com> <20230116164527.GB3239767@p14s>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20230116164527.GB3239767@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 16/01/23 22:15, Mathieu Poirier wrote:
> On Mon, Jan 16, 2023 at 08:49:06PM +0530, Devarsh Thakkar wrote:
>> AM62 and AM62A SoCs use single core R5F which is a new scenario
>> different than the one being used with CLUSTER_MODE_SINGLECPU
>> which is for utilizing a single core from a set of cores available
>> in R5F cluster present in the SoC.
>>
>> To support this single core scenario map it with
>> newly defined CLUSTER_MODE_SINGLECORE and use it when
>> compatible is set to ti,am62-r5fss.
>>
>> Also set PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE config for
>> CLUSTER_MODE_SINGLECORE too as it is required by R5 core when it
>> is being as general purpose core instead of device manager.
>>
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> ---
>> V2:
>> - Fix indentation and ordering issues as per review comments
>> V3:
>> - Change CLUSTER_MODE_NONE value to -1
>> V4:
>> - No change
>> V5:
>> - No change (fixing typo in email address)
>> V6:
>>    - Use CLUSTER_MODE_SINGLECORE for AM62x
>>    - Set PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE for single core.
>> ---
>>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 62 +++++++++++++++++++-----
>>  1 file changed, 49 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>> index 036c9dc217f3..089215144e6b 100644
>> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
>> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>> @@ -71,14 +71,16 @@ struct k3_r5_mem {
>>  /*
>>   * All cluster mode values are not applicable on all SoCs. The following
>>   * are the modes supported on various SoCs:
>> - *   Split mode      : AM65x, J721E, J7200 and AM64x SoCs
>> - *   LockStep mode   : AM65x, J721E and J7200 SoCs
>> - *   Single-CPU mode : AM64x SoCs only
>> + *   Split mode       : AM65x, J721E, J7200 and AM64x SoCs
>> + *   LockStep mode    : AM65x, J721E and J7200 SoCs
>> + *   Single-CPU mode  : AM64x SoCs only
>> + *   Single-Core mode : AM62x, AM62A SoCs
>>   */
>>  enum cluster_mode {
>>  	CLUSTER_MODE_SPLIT = 0,
>>  	CLUSTER_MODE_LOCKSTEP,
>>  	CLUSTER_MODE_SINGLECPU,
>> +	CLUSTER_MODE_SINGLECORE
>>  };
>>  
>>  /**
>> @@ -86,11 +88,13 @@ enum cluster_mode {
>>   * @tcm_is_double: flag to denote the larger unified TCMs in certain modes
>>   * @tcm_ecc_autoinit: flag to denote the auto-initialization of TCMs for ECC
>>   * @single_cpu_mode: flag to denote if SoC/IP supports Single-CPU mode
>> + * @is_single_core: flag to denote if SoC/IP has only single core R5
>>   */
>>  struct k3_r5_soc_data {
>>  	bool tcm_is_double;
>>  	bool tcm_ecc_autoinit;
>>  	bool single_cpu_mode;
>> +	bool is_single_core;
>>  };
>>  
>>  /**
>> @@ -838,7 +842,8 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
>>  
>>  	core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
>>  	if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
>> -	    cluster->mode == CLUSTER_MODE_SINGLECPU) {
>> +	    cluster->mode == CLUSTER_MODE_SINGLECPU ||
>> +	    cluster->mode == CLUSTER_MODE_SINGLECORE) {
>>  		core = core0;
>>  	} else {
>>  		core = kproc->core;
>> @@ -881,7 +886,8 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
>>  		 * with the bit configured, so program it only on
>>  		 * permitted cores
>>  		 */
>> -		if (cluster->mode == CLUSTER_MODE_SINGLECPU) {
>> +		if (cluster->mode == CLUSTER_MODE_SINGLECPU ||
>> +		    cluster->mode == CLUSTER_MODE_SINGLECORE) {
>>  			set_cfg = PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE;
> 
> Why was this not part of the 5 previous version?

I came to know about this recently only. The AM62x R5 IPC is functional
even without this change but set_config was failing in another single core MCU
R5 chip which was using this compatible. The recommendation I got from firmware
team was to set this flag for all single core R5 scenarios.

Regards,
Devarsh
> 
>>  		} else {
>>  			/*
>> @@ -1073,6 +1079,7 @@ static void k3_r5_adjust_tcm_sizes(struct k3_r5_rproc *kproc)
>>  
>>  	if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
>>  	    cluster->mode == CLUSTER_MODE_SINGLECPU ||
>> +	    cluster->mode == CLUSTER_MODE_SINGLECORE ||
>>  	    !cluster->soc_data->tcm_is_double)
>>  		return;
>>  
>> @@ -1146,7 +1153,9 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
>>  	atcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_ATCM_EN ?  1 : 0;
>>  	btcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_BTCM_EN ?  1 : 0;
>>  	loczrama = cfg & PROC_BOOT_CFG_FLAG_R5_TCM_RSTBASE ?  1 : 0;
>> -	if (cluster->soc_data->single_cpu_mode) {
>> +	if (cluster->soc_data->is_single_core) {
>> +		mode = CLUSTER_MODE_SINGLECORE;
>> +	} else if (cluster->soc_data->single_cpu_mode) {
> 
> I have already commented on that.
> 
>>  		mode = cfg & PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE ?
>>  				CLUSTER_MODE_SINGLECPU : CLUSTER_MODE_SPLIT;
>>  	} else {
>> @@ -1268,9 +1277,12 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>>  			goto err_add;
>>  		}
>>  
>> -		/* create only one rproc in lockstep mode or single-cpu mode */
>> +		/* create only one rproc in lockstep, single-cpu or
>> +		 * single core mode
>> +		 */
>>  		if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
>> -		    cluster->mode == CLUSTER_MODE_SINGLECPU)
>> +		    cluster->mode == CLUSTER_MODE_SINGLECPU ||
>> +		    cluster->mode == CLUSTER_MODE_SINGLECORE)
>>  			break;
>>  	}
>>  
>> @@ -1699,12 +1711,19 @@ static int k3_r5_probe(struct platform_device *pdev)
>>  		return -ENOMEM;
>>  
>>  	cluster->dev = dev;
>> +
>>  	/*
>> -	 * default to most common efuse configurations - Split-mode on AM64x
>> -	 * and LockStep-mode on all others
>> +	 * default to most common efuse configurations -
>> +	 * Split-mode on AM64x
>> +	 * Single core on AM62x
>> +	 * LockStep-mode on all others
>>  	 */
>> -	cluster->mode = data->single_cpu_mode ?
>> +	if (!data->is_single_core)
>> +		cluster->mode = data->single_cpu_mode ?
>>  				CLUSTER_MODE_SPLIT : CLUSTER_MODE_LOCKSTEP;
>> +	else
>> +		cluster->mode = CLUSTER_MODE_SINGLECORE;
>> +
>>  	cluster->soc_data = data;
>>  	INIT_LIST_HEAD(&cluster->cores);
>>  
>> @@ -1716,8 +1735,14 @@ static int k3_r5_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	num_cores = of_get_available_child_count(np);
>> -	if (num_cores != 2) {
>> -		dev_err(dev, "MCU cluster requires both R5F cores to be enabled, num_cores = %d\n",
>> +	if (num_cores != 2 && !data->is_single_core) {
>> +		dev_err(dev, "MCU cluster requires both R5F cores to be enabled but num_cores is set to = %d\n",
>> +			num_cores);
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (num_cores != 1 && data->is_single_core) {
>> +		dev_err(dev, "SoC supports only single core R5 but num_cores is set to %d\n",
>>  			num_cores);
>>  		return -ENODEV;
>>  	}
>> @@ -1759,18 +1784,28 @@ static const struct k3_r5_soc_data am65_j721e_soc_data = {
>>  	.tcm_is_double = false,
>>  	.tcm_ecc_autoinit = false,
>>  	.single_cpu_mode = false,
>> +	.is_single_core = false,
>>  };
>>  
>>  static const struct k3_r5_soc_data j7200_j721s2_soc_data = {
>>  	.tcm_is_double = true,
>>  	.tcm_ecc_autoinit = true,
>>  	.single_cpu_mode = false,
>> +	.is_single_core = false,
>>  };
>>  
>>  static const struct k3_r5_soc_data am64_soc_data = {
>>  	.tcm_is_double = true,
>>  	.tcm_ecc_autoinit = true,
>>  	.single_cpu_mode = true,
>> +	.is_single_core = false,
>> +};
>> +
>> +static const struct k3_r5_soc_data am62_soc_data = {
>> +	.tcm_is_double = false,
>> +	.tcm_ecc_autoinit = true,
>> +	.single_cpu_mode = false,
>> +	.is_single_core = true,
>>  };
>>  
>>  static const struct of_device_id k3_r5_of_match[] = {
>> @@ -1778,6 +1813,7 @@ static const struct of_device_id k3_r5_of_match[] = {
>>  	{ .compatible = "ti,j721e-r5fss", .data = &am65_j721e_soc_data, },
>>  	{ .compatible = "ti,j7200-r5fss", .data = &j7200_j721s2_soc_data, },
>>  	{ .compatible = "ti,am64-r5fss",  .data = &am64_soc_data, },
>> +	{ .compatible = "ti,am62-r5fss",  .data = &am62_soc_data, },
>>  	{ .compatible = "ti,j721s2-r5fss",  .data = &j7200_j721s2_soc_data, },
>>  	{ /* sentinel */ },
>>  };
>> -- 
>> 2.34.1
>>
