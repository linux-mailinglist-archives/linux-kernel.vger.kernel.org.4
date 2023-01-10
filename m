Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4906663F65
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbjAJLnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjAJLm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:42:58 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AF44880D;
        Tue, 10 Jan 2023 03:42:56 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id p25so5969540ljn.12;
        Tue, 10 Jan 2023 03:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ey5iDJkqO43rCV0HCuOUGkr/CSnJkJ5X9noQqptCZow=;
        b=GwWY6T+MiOEJmP217ZwjYV14B6OoGTwaw48mVPWPlu4fKJLXt1pcAXKesmjIxMjaJF
         9bFBfYxGJXsLhIVs5zc1lSKaAw1kfsn46h9QwSlXz0nD3asTYtvQr46cvuzTlhrmxGrb
         yi7fI38XpjSTdTXfv/Wj3Dl4kGn2/1vy2SnFI4VPw0X9jnxP6XJT4Fp+U8iLNEuJydkK
         AvLJQ4NIxO9+VEafPmnuxIpQ1F4e0QOlCgkOF2m1w8uF8+TWJvX5xBDIMH3ZjpmNslpP
         ydjuX6tKMM/AhZ9k5CHDoGNQMei983o6fYqhhVYWdqAzuC6lDlREM7AkfGHHvb8B92G/
         QjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ey5iDJkqO43rCV0HCuOUGkr/CSnJkJ5X9noQqptCZow=;
        b=xignG9QFjgcorxhWtrhjI2J2stm1MwG+NhsSnm/69oeVRR8YAcyFI2AdKzAAUaH57o
         sWrUiRPqs6oFz/YCydC1z05mY3oTkH8sVlnn5Ii3uYkMgRqK9WYXe8YwPBysHvvHhJzW
         O31DNhzpXb2VgEOonb8FX8LxlPYrHe8uzJw6T+IJpbDEUXdRRfVo6oz1xENI3Bopz1rM
         36KT0pShBvk6HQ2Mz/srR75JB9hajJuDgY/eFh6VEwhcQhYslcfsMJUdJpjquibJwGJC
         Me6YokUfk2gPb+d80HH7ouvbXQgKBM4f0/YXHy0r/O0La0jRvcCmzNXJCcW5Ngq/bV7C
         31jw==
X-Gm-Message-State: AFqh2konCLbIYWvL/Yu2PidUmk5Med64cw4wcOzbX2ovhlZjetPSHUWs
        Fh455PhrFzSQNfwn1fItzV0=
X-Google-Smtp-Source: AMrXdXuvmQzSTgpg8U9Wa16iSmZ949+ZlBDrGit0vqzPDCGJoIZ3yODmMw/jhIZQ8c9QFtm0qggV6g==
X-Received: by 2002:a2e:aaa7:0:b0:283:adf9:7514 with SMTP id bj39-20020a2eaaa7000000b00283adf97514mr2648634ljb.12.1673350974689;
        Tue, 10 Jan 2023 03:42:54 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id u17-20020a05651c131100b002848666b356sm789711lja.17.2023.01.10.03.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 03:42:54 -0800 (PST)
Date:   Tue, 10 Jan 2023 14:42:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/15] spi: dw: send cmd and addr to start the spi
 transfer
Message-ID: <20230110114252.eg6z5bbrhjlrg6sd@mobilestation>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221212180732.79167-8-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212180732.79167-8-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 06:07:24PM +0000, Sudip Mukherjee wrote:
> In enhanced spi mode, read or write will start by sending the cmd
> and address (if present).
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 06169aa3f37bf..ecab0fbc847c7 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -832,6 +832,29 @@ static void dw_spi_init_enh_mem_buf(struct dw_spi *dws, const struct spi_mem_op
>  	}
>  }
>  
> +static void dw_spi_enh_write_cmd_addr(struct dw_spi *dws, const struct spi_mem_op *op)
> +{
> +	void *buf = dws->buf;
> +	u32 txw;
> +

> +	/* Send cmd as 32 bit value */
> +	if (buf) {
> +		txw = *(u32 *)(buf);
> +		dw_write_io_reg(dws, DW_SPI_DR, txw);
> +		buf += dws->reg_io_width;
> +		if (op->addr.nbytes) {
> +			txw = *(u32 *)(buf);
> +			dw_write_io_reg(dws, DW_SPI_DR, txw);
> +			if (op->addr.nbytes > 4) {
> +				/* address more than 32bit */
> +				buf += dws->reg_io_width;
> +				txw = *(u32 *)(buf);
> +				dw_write_io_reg(dws, DW_SPI_DR, txw);
> +			}
> +		}
> +	}

Just put the command and address directly to the CSR. There is no
point in using the temporary buffer in your case unless I miss
something.

-Serge(y)

> +}
> +
>  static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  {
>  	struct spi_controller *ctlr = mem->spi->controller;
> @@ -886,6 +909,8 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
>  
>  	dw_spi_enable_chip(dws, 1);
>  
> +	dw_spi_enh_write_cmd_addr(dws, op);
> +
>  	return 0;
>  }
>  
> -- 
> 2.30.2
> 
