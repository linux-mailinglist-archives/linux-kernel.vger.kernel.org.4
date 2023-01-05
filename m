Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A45465E176
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjAEAWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbjAEAWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:22:45 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161C344351
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 16:22:44 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id c6so4557494pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 16:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3c8RG9ethTAlzypVak+6wGrVNQqJ7cf9gqZQVweD01g=;
        b=aNrnNQVzQ5PTmpvCFejqhQvblS1+kHYmgrqGQWdfeMHg0dZcTRtVXdpTbJ8yOwalk1
         ftOuie+k0s++f7kBswj7xbDMopy5jeN03dXlnMpMYq6oveUPOr8kTe6/Fl1XodMqjDme
         XzVmIY/g7DMfSWGFg7c7DcjUI4dNAcEa359lzRklSAGF0cnLGA8gRR6PNFlnjL62K0LB
         /KOreZefwyiAH4jI9Stl6Oa8tqlPVG9pwMYYeztAKhjrqCBqxmtt+pgKYm8fX16SSiQM
         vqYCVWgR6F9pYByawFQB3IUNLxHgGEyqTN91fi621FmCqLeiwvZo0tixHv5Skk+Vhy4T
         Q+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c8RG9ethTAlzypVak+6wGrVNQqJ7cf9gqZQVweD01g=;
        b=g6OdJ4bCCB1iZScg/uiJot1CrZpo69unkN+kyNCrvyN2xfhpWk4CP/FtPmzCHiGCwW
         t1GJGtYtazgVbWdHgaXy2g8chJq5SNFBOJJRCzb8XsLdAcy2dYqsgC+6EJtIfUwsfjKZ
         AERMh8qGV57QCHWW8qMwNnveHdsXMdf872uVE36Bn8kgfBnLSXv2jW8vf4pdomqMOidh
         o0it44lRonSdLs2FISmQZ2PvMkhUgFw1eqx2/Uk+a8XTMEkMJ22FbHskLWxfWjyhNSU4
         XbXdvQDQA2ZxL2vvnOQDygiyix2IJLXAJNN12SnAcsKCIZOHj3mqFTy4P7dpGSOti8zo
         A+hQ==
X-Gm-Message-State: AFqh2kpHrSWyvCnpofjK/7N0YZ1FTVqQ9kjL+hodmdUmDOdBna7chovK
        KwjqAWzdyRmmcAI2DTKaL+cWfQ==
X-Google-Smtp-Source: AMrXdXs0y5+HF3RRYVT+Wm6ldNHIW8HJptsLBJHGReFTQDlrLQMB5hqXUUPZkYOPOAWIykMs5fA8fA==
X-Received: by 2002:a05:6a20:5487:b0:ad:b4a5:8d2f with SMTP id i7-20020a056a20548700b000adb4a58d2fmr77215137pzk.42.1672878163547;
        Wed, 04 Jan 2023 16:22:43 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:1328:ca09:d4c2:fcbc])
        by smtp.gmail.com with ESMTPSA id y4-20020a655b44000000b0047899d0d62csm20920486pgr.52.2023.01.04.16.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 16:22:43 -0800 (PST)
Date:   Wed, 4 Jan 2023 17:22:40 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Suman Anna <s-anna@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, nm@ti.com, vigneshr@ti.com,
        srk@ti.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v12 2/6] remoteproc: pru: Add enum for PRU Core
 Identifiers.
Message-ID: <20230105002240.GE2112402@p14s>
References: <20221216053313.2974826-1-danishanwar@ti.com>
 <20221216053313.2974826-3-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216053313.2974826-3-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 11:03:09AM +0530, MD Danish Anwar wrote:
> Introducing enum pruss_pru_id for PRU Core Identifiers.
> PRUSS_PRU0 indicates PRU Core 0.
> PRUSS_PRU1 indicates PRU Core 1.
> PRUSS_NUM_PRUS indicates the total number of PRU Cores.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
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

I fixed the checkpatch warning associated with this patch but it has a cascading
effect on the other patches.  Please address and send a new revision.  Aside
from this I am good with this patchset.

Thanks,
Mathieu

> -- 
> 2.25.1
> 
