Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F04646CA1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLHKW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHKW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:22:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618EB54342;
        Thu,  8 Dec 2022 02:22:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C6E5B82362;
        Thu,  8 Dec 2022 10:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D58C433C1;
        Thu,  8 Dec 2022 10:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670494942;
        bh=ErJmS2Ph8pUOWhyn1bGZWvmgNR7aRTvFWTY/3HNMPPU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=o0KcurJGm6y78e9JLdrN//6EMuoWntcFSF144dnvgGcqBiqFKKriISACdEKrx7sxx
         La5DX1xW1PixYRltDbCUxoduG0dZ6vkKCfUPd7vM3vY2GJIyL7s8yGUE8SJvCbhj48
         x64j5qqgULkys6NCYqCYy7XeL+usCTWA6tgKPn4XnlVTHA9P1IbavRKe7OGe8PRVMo
         VUNXyV++if0t5eP0oqsA2VBcntBoR1GfIZhfr+MuJy9eUjCRFA5QmDCDoKG7544l//
         K2B4h1+FAntaBDRCZdPq1NERky/C2j9Qx/3Z5Otea0Z1TWwvnrXDhhApZr14fwvE/+
         kcUXZlOeTuU+Q==
Message-ID: <f2aaf9bd-e65b-08c7-5eae-7fac59324791@kernel.org>
Date:   Thu, 8 Dec 2022 12:22:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v11 2/6] remoteproc: pru: Add enum for PRU Core
 Identifiers.
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Suman Anna <s-anna@ti.com>, "Andrew F . Davis" <afd@ti.com>,
        nm@ti.com, vigneshr@ti.com, srk@ti.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221207110411.441692-1-danishanwar@ti.com>
 <20221207110411.441692-3-danishanwar@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221207110411.441692-3-danishanwar@ti.com>
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



On 07/12/2022 13:04, MD Danish Anwar wrote:
> Introducing enum pruss_pru_id for PRU Core Identifiers.
> PRUSS_PRU0 indicates PRU Core 0.
> PRUSS_PRU1 indicates PRU Core 1.
> PRUSS_NUM_PRUS indicates the total number of PRU Cores.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

--
cheers,
-roger

> ---
>  drivers/remoteproc/pru_rproc.c |  7 ++++---
>  include/linux/pruss.h          | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/pruss.h
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index 128bf9912f2c..a1a208b31846 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
> +#include <linux/pruss.h>
>  #include <linux/pruss_driver.h>
>  #include <linux/remoteproc.h>
>  
> @@ -438,7 +439,7 @@ static void *pru_d_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
>  	dram0 = pruss->mem_regions[PRUSS_MEM_DRAM0];
>  	dram1 = pruss->mem_regions[PRUSS_MEM_DRAM1];
>  	/* PRU1 has its local RAM addresses reversed */
> -	if (pru->id == 1)
> +	if (pru->id == PRUSS_PRU1)
>  		swap(dram0, dram1);
>  	shrd_ram = pruss->mem_regions[PRUSS_MEM_SHRD_RAM2];
>  
> @@ -747,14 +748,14 @@ static int pru_rproc_set_id(struct pru_rproc *pru)
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
> new file mode 100644
> index 000000000000..fbe4fbb45807
> --- /dev/null
> +++ b/include/linux/pruss.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/**
> + * PRU-ICSS Subsystem user interfaces
> + *
> + * Copyright (C) 2015-2022 Texas Instruments Incorporated - http://www.ti.com
> + *	Suman Anna <s-anna@ti.com>
> + */
> +
> +#ifndef __LINUX_PRUSS_H
> +#define __LINUX_PRUSS_H
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +
> +#define PRU_RPROC_DRVNAME "pru-rproc"
> +
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
> +
> +#endif /* __LINUX_PRUSS_H */
> \ No newline at end of file
