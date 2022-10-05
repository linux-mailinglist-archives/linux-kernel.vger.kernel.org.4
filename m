Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49D65F5768
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiJEP0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJEP0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:26:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC4413F2A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 08:26:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b2so10801547plc.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=b2eDhIzvuJjsHv2/DwfAjBACGmEeoKasF0f+LJfWpy4=;
        b=yDIJ8ZRMEYVCQFO1ONUXGEjRWvVcL4ThiGTz4epVKemVgaY5GzauwMHGAPuPetOFZd
         1atCE/2CnumELCMAVeQRLc0q96EHO9X+08JgZNM1u4ryBBhLYR+W9J23gpfQ2PKMnxef
         0J6f1eCd0/a4j2CDQgTJn5zjH9mLBnQNb8aSYf7qPclJdqSABVWrvM1f5nA2LMtUtXFU
         svsrSdo0k7K6EK/uICxNBzkN26XLVDBzevv9Lo8h0ZkQkCnleoj3dypTWfA/aHApymbh
         ybz6EN8VmbxmVT4akpxKjIl2EQEmTr16EbO78zJW2+RXq3Z1qbqeDQjzfr+SvX7KK+rW
         jogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=b2eDhIzvuJjsHv2/DwfAjBACGmEeoKasF0f+LJfWpy4=;
        b=gJ0fl2/RAB6VmdB5Cbfod7MJaSf1kSu0CeQGv5JrriSjqSDVUqUnMpvFnfBs8oS3MP
         8DXmS7WEJToKO1y32hSNb5zbQ64okpb9UEaBJVCvZr7sdjT02VFvUOYgw2yWsAOSAPLZ
         vB57DmB1XnqAV1xYuFGdnelgMfFqSEcToY6S71jTADbCFji73Equ6XS5gFeJkSIMfz3P
         lDdpaMMvQ259Fbl8p5PncbqqC0f0H2t9e6KEY0ZGlXV7IXG+as/bOccgfYIohiw/9G0J
         moo5cJMyf7VotSloVZHON2P9WSMysN7Wwc1VBCzM2VuytjegWGi6rJ/UvAV8xb0MqB/m
         0wzQ==
X-Gm-Message-State: ACrzQf2iCO5iZiKAwOcu0Vi6qMOInXMV7RFniANve74giwoOeJcPv2oX
        TRrnjfAfqc9/zpm9v6jYwgcz1A==
X-Google-Smtp-Source: AMsMyM6U1Tjop20XQFBtNuI8reRTz70L8Jz87X/3OM8EuLG/sMQ/s6TIjTbd9f/dOjM1BuBlaJx7AQ==
X-Received: by 2002:a17:902:b693:b0:178:5fa6:4b3 with SMTP id c19-20020a170902b69300b001785fa604b3mr32658463pls.63.1664983567257;
        Wed, 05 Oct 2022 08:26:07 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a0f1700b001efa9e83927sm1249541pjy.51.2022.10.05.08.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 08:26:06 -0700 (PDT)
Date:   Wed, 5 Oct 2022 09:26:04 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2] remoteproc: virtio: Fix warning on bindings by
 removing the of_match_table
Message-ID: <20221005152604.GA2666639@p14s>
References: <20221005081317.3411684-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005081317.3411684-1-arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 10:13:17AM +0200, Arnaud Pouliquen wrote:
> The checkpatch tool complains that "virtio,rproc" is not documented.
> But it is not possible to probe the device "rproc-virtio" by declaring
> it in the device tree. So documenting it in the bindings does not make
> sense.
> This commit solves the checkpatch warning by suppressing the useless
> of_match_table.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the remoteproc_virtio")
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> Updates vs previous revision:
> - replace the "of_platform.h" include by "platform_device.h",
> - replace "Fix-suggested-by" by "Suggested-by",
> - add Rob's Reviewed-by.
> ---
>  drivers/remoteproc/remoteproc_virtio.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index a29e3b8ff69c..0e95525c1158 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -13,8 +13,8 @@
>  #include <linux/dma-map-ops.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/export.h>
> -#include <linux/of_platform.h>
>  #include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
>  #include <linux/virtio.h>
>  #include <linux/virtio_config.h>
> @@ -593,17 +593,11 @@ static int rproc_virtio_remove(struct platform_device *pdev)
>  }
>  
>  /* Platform driver */
> -static const struct of_device_id rproc_virtio_match[] = {
> -	{ .compatible = "virtio,rproc" },
> -	{},
> -};
> -
>  static struct platform_driver rproc_virtio_driver = {
>  	.probe		= rproc_virtio_probe,
>  	.remove		= rproc_virtio_remove,
>  	.driver		= {
>  		.name	= "rproc-virtio",
> -		.of_match_table	= rproc_virtio_match,

Applied.

Thanks,
Mathieu

>  	},
>  };
>  builtin_platform_driver(rproc_virtio_driver);
> -- 
> 2.24.3
> 
