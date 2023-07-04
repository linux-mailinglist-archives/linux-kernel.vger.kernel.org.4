Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76D1747A7B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGDXnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjGDXnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:43:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3143F133;
        Tue,  4 Jul 2023 16:43:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9250613F9;
        Tue,  4 Jul 2023 23:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25A7C433C7;
        Tue,  4 Jul 2023 23:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688514189;
        bh=ODgTpPZ8XWIkL6FTY36mMHMsqL1QiuCv3dF06sqYPx0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gHKHqF7ahpzo9OyMnR4sytxGeTNQKzD/WIySfrlabczMmKRl7opAPHDd3VKXb88Qg
         CoL/olqf70VVmAjBvFMlEeZeMkVS+S71i1Q6RXMaFGb8R39H88z/s3NK2zTuLNVCtx
         R9z8O3I+yI2qY4kz2SZhgsZn8IcIZgo/RWuuHu6rg6DE2jBCTDYus+L9GUfPjz+EVo
         5q4vbV4ELJmfqFOuAQQWNOyNvQGy8+9hY2CSmCJfRkSv+jVmFYzJalD3v05N2rLfkb
         rLd66nAu19rBeSij3EDlc9kbTKpQszUUL8PYLOWPTvLtR42i8Ic36Eqbjo8+1j8o98
         K+j6cipqd3EuQ==
Message-ID: <8bf077e2-a70f-37bf-2bc8-f4fe0df9306a@kernel.org>
Date:   Wed, 5 Jul 2023 08:43:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 3/5] ublk: rename driver files to prepare for multiple
 translation units
Content-Language: en-US
To:     Andreas Hindborg <nmi@metaspace.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>, gost.dev@samsung.com,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
References: <20230704165209.514591-1-nmi@metaspace.dk>
 <20230704165209.514591-4-nmi@metaspace.dk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230704165209.514591-4-nmi@metaspace.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 01:52, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> The zoned storage support for ublk adds a translation unit to the module.
> In order to be able to keep the existing name for the module, rename the
> currently only translation unit. Also rename the header to align with the C
> file name.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

Looks OK, but see my comment on patch 2.

> ---
>  MAINTAINERS                          | 4 ++--
>  drivers/block/Makefile               | 1 +
>  drivers/block/{ublk_drv.c => ublk.c} | 2 +-
>  drivers/block/{ublk_drv.h => ublk.h} | 0
>  4 files changed, 4 insertions(+), 3 deletions(-)
>  rename drivers/block/{ublk_drv.c => ublk.c} (99%)
>  rename drivers/block/{ublk_drv.h => ublk.h} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ace71c90751c..1f193cd43958 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21553,8 +21553,8 @@ M:	Ming Lei <ming.lei@redhat.com>
>  L:	linux-block@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/block/ublk.rst
> -F:	drivers/block/ublk_drv.c
> -F:	drivers/block/ublk_drv.h
> +F:	drivers/block/ublk.c
> +F:	drivers/block/ublk.h
>  F:	include/uapi/linux/ublk_cmd.h
>  
>  UCLINUX (M68KNOMMU AND COLDFIRE)
> diff --git a/drivers/block/Makefile b/drivers/block/Makefile
> index 101612cba303..38f2229623a8 100644
> --- a/drivers/block/Makefile
> +++ b/drivers/block/Makefile
> @@ -38,5 +38,6 @@ obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
>  obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
>  
>  obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk_drv.o
> +ublk_drv-$(CONFIG_BLK_DEV_UBLK)			+= ublk.o
>  
>  swim_mod-y	:= swim.o swim_asm.o
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk.c
> similarity index 99%
> rename from drivers/block/ublk_drv.c
> rename to drivers/block/ublk.c
> index bca0c4e1cfd8..a0453619bf67 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk.c
> @@ -45,7 +45,7 @@
>  #include <linux/namei.h>
>  #include <linux/kref.h>
>  #include <uapi/linux/ublk_cmd.h>
> -#include "ublk_drv.h"
> +#include "ublk.h"
>  
>  #define UBLK_MINORS		(1U << MINORBITS)
>  
> diff --git a/drivers/block/ublk_drv.h b/drivers/block/ublk.h
> similarity index 100%
> rename from drivers/block/ublk_drv.h
> rename to drivers/block/ublk.h

-- 
Damien Le Moal
Western Digital Research

