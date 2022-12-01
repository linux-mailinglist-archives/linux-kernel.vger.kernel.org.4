Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD29963F007
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiLAL6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiLAL6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:58:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DBDF3B;
        Thu,  1 Dec 2022 03:58:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 709D361FAF;
        Thu,  1 Dec 2022 11:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD91C433C1;
        Thu,  1 Dec 2022 11:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669895916;
        bh=25enWOXWSxUHeG1IZJe+Ih0SWl3XZid+jpKEUF0YHyc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AoCwcf0bz6tb7EVh9CHF6DmkPZFGozfl7p894cEkWDvxCw6c5ABoN0kp6PTMhKEI9
         kv2a2CBe9ZuzdLORhZFI1hAla9bB+zL8DL06NLy0E7TZj7sa7q/eU1N61mZcqs/qcF
         u/vmx6zmS9+GgAcWnEcwbxQDSMAJd5ZgBLF+QujloJO9pV22ISsXWyJecfFWZ+mCTM
         xfVOBGcTXXqzEMZEGuw9EdtT6nrbU5B9IVUQ5+03uHcPpX8eA7GdYEXl0RqrWOykOy
         8wc0CD5aB6L24r3jO/bVylPLFi0Z9pJ7Xig3TG66x2LX3/wnCOUBBnnbw2G3Xh/Ng1
         F5C3wVT24RGzQ==
Message-ID: <a32f817e-6b61-7666-94f9-cf11f1f2e0a8@kernel.org>
Date:   Thu, 1 Dec 2022 13:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v10 3/6] remoteproc: pru: Add enum for PRU Core
 Indentifiers.
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Suman Anna <s-anna@ti.com>, "Andrew F . Davis" <afd@ti.com>,
        nm@ti.com, vigneshr@ti.com, srk@ti.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221201110500.4017889-1-danishanwar@ti.com>
 <20221201110500.4017889-4-danishanwar@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221201110500.4017889-4-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Danish,

On 01/12/2022 13:04, MD Danish Anwar wrote:
> Introducing enum pruss_pru_id for PRU Core Identifiers.
> PRUSS_PRU0 indicates PRU Core 0.
> PRUSS_PRU1 indicates PRU Core 1.
> PRUSS_NUM_PRUS indicates the total number of PRU Cores.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/remoteproc/pru_rproc.c | 16 ++++++++++++----
>  include/linux/pruss.h          | 19 +++++++++++++++++--
>  2 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index b4498a505108..7d4ed39b3772 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -186,6 +186,7 @@ static struct rproc *__pru_rproc_get(struct device_node *np, int index)
>   * pru_rproc_get() - get the PRU rproc instance from a device node
>   * @np: the user/client device node
>   * @index: index to use for the ti,prus property
> + * @pru_id: optional pointer to return the PRU remoteproc processor id
>   *
>   * This function looks through a client device node's "ti,prus" property at
>   * index @index and returns the rproc handle for a valid PRU remote processor if
> @@ -193,13 +194,17 @@ static struct rproc *__pru_rproc_get(struct device_node *np, int index)
>   * time. Caller must call pru_rproc_put() when done with using the rproc, not
>   * required if the function returns a failure.
>   *
> + * When optional @pru_id pointer is passed the PRU remoteproc processor id is
> + * returned.
> + *
>   * Return: rproc handle on success, and an ERR_PTR on failure using one
>   * of the following error values
>   *    -ENODEV if device is not found
>   *    -EBUSY if PRU is already acquired by anyone
>   *    -EPROBE_DEFER is PRU device is not probed yet
>   */
> -struct rproc *pru_rproc_get(struct device_node *np, int index)
> +struct rproc *pru_rproc_get(struct device_node *np, int index,
> +			    enum pruss_pru_id *pru_id)

You just introduced pru_rproc_get() in the previous patch and are
now updating it here.

Instead, what you need to do is, first introduce enum pruss_pru_id
and make any changes to code using hardcoded values for PRU ID.
This patch will have to introduce <linux/pruss.h> as it doesn't exist yet.
Hopefully this clears the chicken/egg situation.

Then introduce pru_rproc_get() patch with the final desired arguments.

>  {
>  	struct rproc *rproc;
>  	struct pru_rproc *pru;
> @@ -226,6 +231,9 @@ struct rproc *pru_rproc_get(struct device_node *np, int index)
>  
>  	mutex_unlock(&pru->lock);
>  
> +	if (pru_id)
> +		*pru_id = pru->id;
> +
>  	return rproc;
>  
>  err_no_rproc_handle:
> @@ -556,7 +564,7 @@ static void *pru_d_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
>  	dram0 = pruss->mem_regions[PRUSS_MEM_DRAM0];
>  	dram1 = pruss->mem_regions[PRUSS_MEM_DRAM1];
>  	/* PRU1 has its local RAM addresses reversed */
> -	if (pru->id == 1)
> +	if (pru->id == PRUSS_PRU1)
>  		swap(dram0, dram1);
>  	shrd_ram = pruss->mem_regions[PRUSS_MEM_SHRD_RAM2];
>  
> @@ -865,14 +873,14 @@ static int pru_rproc_set_id(struct pru_rproc *pru)
>  	case RTU0_IRAM_ADDR_MASK:
>  		fallthrough;
>  	case PRU0_IRAM_ADDR_MASK:
> -		pru->id = 0;
> +		pru->id = PRUSS_PRU0;
>  		break;
>  	case TX_PRU1_IRAM_ADDR_MASK:
>  		fallthrough;
>  	case RTU1_IRAM_ADDR_MASK:
>  		fallthrough;
>  	case PRU1_IRAM_ADDR_MASK:
> -		pru->id = 1;
> +		pru->id = PRUSS_PRU1;
>  		break;
>  	default:
>  		ret = -EINVAL;
> diff --git a/include/linux/pruss.h b/include/linux/pruss.h
> index 5c5d14b1249d..efe89c586b4b 100644
> --- a/include/linux/pruss.h
> +++ b/include/linux/pruss.h
> @@ -14,17 +14,32 @@
>  
>  #define PRU_RPROC_DRVNAME "pru-rproc"
>  
> +/**
> + * enum pruss_pru_id - PRU core identifiers
> + * @PRUSS_PRU0: PRU Core 0.
> + * @PRUSS_PRU1: PRU Core 1.
> + * @PRUSS_NUM_PRUS: Total number of PRU Cores available.
> + *
> + */
> +
> +enum pruss_pru_id {
> +	PRUSS_PRU0 = 0,
> +	PRUSS_PRU1,
> +	PRUSS_NUM_PRUS,
> +};
> +
>  struct device_node;
>  
>  #if IS_ENABLED(CONFIG_PRU_REMOTEPROC)
>  
> -struct rproc *pru_rproc_get(struct device_node *np, int index);
> +struct rproc *pru_rproc_get(struct device_node *np, int index,
> +			    enum pruss_pru_id *pru_id);
>  void pru_rproc_put(struct rproc *rproc);
>  
>  #else
>  
>  static inline struct rproc *
> -pru_rproc_get(struct device_node *np, int index)
> +pru_rproc_get(struct device_node *np, int index, enum pruss_pru_id *pru_id)
>  {
>  	return ERR_PTR(-EOPNOTSUPP);
>  }

--
cheers,
-roger
