Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AED617010
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiKBVsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKBVst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:48:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546A53884;
        Wed,  2 Nov 2022 14:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=shvykGCckpRTcs1Df9rnycVxYVdO9mHwuEFaSh4z/FI=; b=V5+8nP8zODqk152jkQ/BlQ2uq8
        +4y71UMci5vEmiwijZSOg8Wcs35yvWik7unkS1M1C/jnruh1q+wYsL5MfwecuJnuBr8ZFOdJIPHxw
        /jf13PWaWNBLVPjOfZtYSe3OiTFYGfI3AjFlVpq4kHkueTQPl+qjOMEYNjv7lfXLaum4Wlc6mB0OH
        ZNtgiYn1q3sPuWvhD5QIwSVcf4jn5qPFk++SHwX9/ciBy0hcKvu1YUqAriyQkjcKcbYBfSCn2HqRS
        Jz2prtmVp5xXEPOIksI5ikqk+GXL1HNvWOYbQBbjnQskCYFAcM32jvvxekmkLQIJd1YjXkVb7AM8A
        ElsAXEuA==;
Received: from [2601:1c2:d80:3110:e65e:37ff:febd:ee53]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqLbK-00EaC0-Sf; Wed, 02 Nov 2022 21:48:46 +0000
Message-ID: <683e5c40-3e61-e1f0-3a7a-890993ec1dd5@infradead.org>
Date:   Wed, 2 Nov 2022 14:48:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 16/17] block, blksnap: Kconfig and Makefile
Content-Language: en-US
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org
References: <20221102155101.4550-1-sergei.shtepa@veeam.com>
 <20221102155101.4550-17-sergei.shtepa@veeam.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221102155101.4550-17-sergei.shtepa@veeam.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 11/2/22 08:51, Sergei Shtepa wrote:
> Allows to build a module.
> 
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>  drivers/block/blksnap/Kconfig  | 12 ++++++++++++
>  drivers/block/blksnap/Makefile | 18 ++++++++++++++++++
>  2 files changed, 30 insertions(+)
>  create mode 100644 drivers/block/blksnap/Kconfig
>  create mode 100644 drivers/block/blksnap/Makefile
> 
> diff --git a/drivers/block/blksnap/Kconfig b/drivers/block/blksnap/Kconfig
> new file mode 100644
> index 000000000000..3a6ecb5fc13d
> --- /dev/null
> +++ b/drivers/block/blksnap/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Block device snapshot module configuration
> +#
> +
> +config BLK_SNAP
> +	tristate "Module for snapshots of block devices."
> +	help
> +	  Allow to create snapshots and track block changes for block devices.
> +	  Designed for creating backups for a simple block devices. Snapshots

	  Drop     the                     "a".

> +	  are temporary and are released then backup is completed. Change block
> +	  tracking allows to create incremental or differential backups.


-- 
~Randy
