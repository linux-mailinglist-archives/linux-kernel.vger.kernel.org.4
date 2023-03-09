Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E242F6B23B6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCIMKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjCIMK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:10:28 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEFDE91B6;
        Thu,  9 Mar 2023 04:10:23 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id b13so1577674ljf.6;
        Thu, 09 Mar 2023 04:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678363822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qIMs/S7KR+kPxwMSTjZhh8ghAuuPganbJ24U/bj7QVo=;
        b=VALtA9zdjLJ+hAE3dyjAZzxuEFSg5k2/DERUsALDgDWc92Y6QwBSA0hYHl+cDiKNet
         MmJkeSMQE++hErquxXwXSZx00D/BF2W88Naw1eI21WQ3+72R+Bjv+DGEGutQNn5695UB
         OznOf3mGUvPKecxjHiGugq0psPseTVm1hO5aHEQ3iPqaz9YnV2RQySbxNdCl5SMnQKk/
         9tuhpejhBFgdMOfEPZdUZZlanaymHkV9EC8taHIPnm02LjF3APrLXvGjAvwkRqdjYcxy
         skKWxErP8ncaoJGiTtcGgel1N/JYyBmAw6IzboZd0hDgoQF7ouoGVN04C3bZ/PZbadms
         HqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678363822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIMs/S7KR+kPxwMSTjZhh8ghAuuPganbJ24U/bj7QVo=;
        b=mNpGgiu0C2d+rWRwpGo9weLtE56bn12X66Qn8nDoH2fRWuUfvOc+ZC02jZWyx0O5Vc
         jfWxDAJgMpBzWSvjz1HbqyIZspupjJv7c71Se0kExNWgphPo9Z/Q67wyiu0DYzKDLO2m
         yTQB/7U3CXugqPYGlgqTYVN454axO3SKPeojc7UVJxeCWAvnsH/1Eu8uWiznzeNaUYmj
         xSXIReU4zkFqeH2Xmn4cpp1A6VzFTf0qnENzX7fvTJr1vC+qwt5q8Vj0t8LrEt6V5rKV
         apoS7tol4wEXfrl+Hkay3Sh6a5Fnwi22vT48BsBiLNw5TRbs4hVZrkbfHkm4rodM778e
         6CBA==
X-Gm-Message-State: AO0yUKV+7uMcqTOmSHOmtdO+yBkekXUcsARpaMYCocs8Z/Wz+FvK04/1
        01vrUZmcRSnRHAVMUcImJJ1d+3xUiL0=
X-Google-Smtp-Source: AK7set9IlJGksuIUvO9SJGemT+7qrb3EE1sbvRzuzRv5R4LYojrsNY3A32HWulZqc9ddCs+ELoz8cA==
X-Received: by 2002:a2e:7006:0:b0:294:6a83:fb28 with SMTP id l6-20020a2e7006000000b002946a83fb28mr6802392ljc.41.1678363821897;
        Thu, 09 Mar 2023 04:10:21 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id f8-20020a2e3808000000b002983bfe65b8sm2423216lja.84.2023.03.09.04.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 04:10:21 -0800 (PST)
Date:   Thu, 9 Mar 2023 15:10:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Lizhe <sensor1010@163.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drivers/spi-dw-core.c : remove redundant function
 spi_controller_set_devdata
Message-ID: <20230309121019.oewvje4lq3ttbrrr@mobilestation>
References: <20230308145551.3240-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308145551.3240-1-sensor1010@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 10:55:51PM +0800, Lizhe wrote:
> in spi_alloc_master() already exists master_controller_set_devdata()
> called, add the struct dw_spi is passed to the spi_alloc_master() as
> the second parameter.

Are you sure that the suggested change does what you think it does?

-Serge(y)

> 
> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>  drivers/spi/spi-dw-core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index c3bfb6c84cab..ad776c7eb66c 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -892,7 +892,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  	if (!dws)
>  		return -EINVAL;
>  
> -	master = spi_alloc_master(dev, 0);
> +	master = spi_alloc_master(dev, sizeof(*dws));
>  	if (!master)
>  		return -ENOMEM;
>  
> @@ -901,8 +901,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  	dws->master = master;
>  	dws->dma_addr = (dma_addr_t)(dws->paddr + DW_SPI_DR);
>  
> -	spi_controller_set_devdata(master, dws);
> -
>  	/* Basic HW init */
>  	dw_spi_hw_init(dev, dws);
>  
> -- 
> 2.34.1
> 
