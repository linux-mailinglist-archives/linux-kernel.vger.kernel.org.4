Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D9E664004
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjAJMNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjAJMMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:12:18 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7403F114;
        Tue, 10 Jan 2023 04:10:20 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bp15so18050709lfb.13;
        Tue, 10 Jan 2023 04:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2WaSXC/7/FBuPmv1FQzNBeYruyUkb12FiGFU5VIm2z8=;
        b=agrV2mnxYLZzJNW6DkkkULffC6Cz18gmtiaM/p8dwu2UN3yj6+wOE5XWZOlWHdrLtq
         fvZHm/EHfhQQlCtO9/1wQx1treC00ax7IbuX8OuiqD7vl2ZBENXBxxEFXgHRS08+NkoT
         gxJPCTSkND/Js+GpQW2Jk0ROxGzua8soEp5ER2nOem9uSe557Y0QRbrQPOMvzFL8mcUB
         8yDG2VO7sLTXnuhJ0G9dInT9IlQ4Z6YEi6byoEaaNCkbdS8EnE7BzZLkW6PREsJJzMDE
         KKHFXJhAH6lWI+VF/lKYU4OTokmqfvaUHfAhSr9WldlOFIuLXuuE/wuTn15trOkI0GgE
         s5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WaSXC/7/FBuPmv1FQzNBeYruyUkb12FiGFU5VIm2z8=;
        b=dLZV1gCQA8VlnbgSxfoXhO85fS9y5vWB01rutCZ95jNVUgCy9Xp+ZMaW0PyFnpBvvG
         9P/Cpha6Edfs0+N9n9fMYUPWOKVa3rLxzthKoJdQ4aLrU5A+KsneQhfCrp1UEG6Sbqjd
         KjOo1DxKQmS2+DlhAXjwb+n6Fx/SsE/itb8YQ5TbeigGNWVOEOD7qNMsjdG3bnP6IvQA
         IsNVQp4cwADrlXovnPHSyHRia1C5iCliQM1TZD7b9KuuyNeklK/PpDxcOrdwkBsN/Zuo
         4i4xzfJ+x9eIVvPQV9bDnjBdAxlqwr7r8y33WckbomtZGt8jeOHevKXpmkRzgV4C3VV2
         iRpw==
X-Gm-Message-State: AFqh2koOuIl7TIb2VMML36xxT09ccjYOw42I2E3bTxRwKLk2+nncYSYR
        E9oaAEs6nc+cZGzVUl3pAHc=
X-Google-Smtp-Source: AMrXdXv+dtnEvvWJBFwendVrqh2Yhdxxr+OlgC5zeS9lPm7yd8g8AGK/fDnALYu3PbHL6s+vDKe2NA==
X-Received: by 2002:a05:6512:2586:b0:4b5:9e70:ca6e with SMTP id bf6-20020a056512258600b004b59e70ca6emr1134630lfb.17.1673352618547;
        Tue, 10 Jan 2023 04:10:18 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id d18-20020a056512369200b004b4a0482a53sm2150468lfs.231.2023.01.10.04.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 04:10:18 -0800 (PST)
Date:   Tue, 10 Jan 2023 15:10:16 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/15] spi: dw: Add retry for enhanced spi mode
Message-ID: <20230110121016.apwgvjhhkkxrmvrq@mobilestation>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221212180732.79167-13-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212180732.79167-13-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 06:07:29PM +0000, Sudip Mukherjee wrote:
> If the connection to the spi device is not stable then the transfer can
> fail. Add retry for DW_SPI_WAIT_RETRIES times and print error if it still
> fails.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index dff7b419af304..cef56acd8d8fd 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -906,7 +906,7 @@ static void dw_spi_enh_write_cmd_addr(struct dw_spi *dws, const struct spi_mem_o
>  	}
>  }
>  
> -static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +static int dw_spi_try_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  {
>  	struct spi_controller *ctlr = mem->spi->controller;
>  	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
> @@ -991,6 +991,21 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
>  	return ret;
>  }
>  

> +static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	struct spi_controller *ctlr = mem->spi->controller;
> +	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
> +	int retry, ret = -EIO;
> +
> +	for (retry = 0; retry < DW_SPI_WAIT_RETRIES && ret != 0; retry++)
> +		ret = dw_spi_try_enh_mem_op(mem, op);
> +
> +	if (retry == DW_SPI_WAIT_RETRIES)
> +		dev_err(&dws->master->dev, "Retry of enh_mem_op failed\n");
> +
> +	return ret;

No. If something goes wrong during the transfer you should return an
error and let the upper layer to decide whether to retry or pass the
failure further.

-Serge(y)

> +}
> +
>  /*
>   * Initialize the default memory operations if a glue layer hasn't specified
>   * custom ones. Direct mapping operations will be preserved anyway since DW SPI
> -- 
> 2.30.2
> 
