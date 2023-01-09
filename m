Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B651662C42
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjAIRH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbjAIRHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:07:10 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3A01CB14;
        Mon,  9 Jan 2023 09:06:15 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id e13so9580648ljn.0;
        Mon, 09 Jan 2023 09:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kptWDTw8vN/ZCKQXmhnZQhxDWISF/pzOgR+cERcTBEo=;
        b=aU0yQBpi7eMjjiaYpWLTLlDxxal3Oc/k2SSM/iFVGM2hKtTwjxhExc5fXoZOYOmi33
         ajovBpB1A8+Rjc3BTmkkckFkFoP31QkV1HNkzevXtXviap1Epr5rFrfbhDdR5rWK+bUQ
         mHud4aARqE62eFyrxCZ2ObO0bqMA3p3Lxk6xHqXu+cvdP3VoJZ1EISXohooOTYm9fmi+
         0kObSP55MGrD1PXZZ/9Uym1E7RuA2YKWNWq3+vfrYRpvO48UkXLusSUY4fX/i8PMwgqh
         yMfD5uGwSp/TNWcVWZ/6FcVcPA22ZdJ/83x3cLs3MrtJGj5jsXtnHjxJeMRpr2lADrQz
         6ROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kptWDTw8vN/ZCKQXmhnZQhxDWISF/pzOgR+cERcTBEo=;
        b=0pwO6OMvfuLxvdCsEk71698qZDTElorZXDK+OgiFfQMK1mDvpgDR5INupcYbr+lquD
         FdE6BALTJqCAySJldWnGMVLqaOjJUhu7phbd1dFJueQVjYJNdofHLt9IprRv77HzkKJ7
         TFXf8XXMc/p6fxTBZ87b3AckdzvQ4JjqrEzbGz2yyTApYZbgZ6ltIykKipV0Pu+lruXC
         LaYrKwiGA1XeoM7OBSizQaNF1Wp7UMjym0/xx8WOp15hGIJ1Rk6LU31QxKRl8XO7iySb
         myrfVJjLmMG4N47dFg01jKXgRd4NoENaSghW8uIm5qE+6iq4U3EjtckjDwm2PrCwFSa5
         vVWw==
X-Gm-Message-State: AFqh2kp1oVXhOg5oeR5ChF6KZwFEF9QwqkcMJtmGBdjEBNuuIy6+l5hV
        cNI0SQJr7Pg8TXnT16LWgIqnHX+CPBo=
X-Google-Smtp-Source: AMrXdXsa9xskNF3bkLfKqhIFn0DxYnwV7EPVRdGhWywbwDSFG0QX8MSoRL+XZR31KsbUbOItUrCTzA==
X-Received: by 2002:a2e:be29:0:b0:281:175d:fa46 with SMTP id z41-20020a2ebe29000000b00281175dfa46mr5788572ljq.23.1673283973728;
        Mon, 09 Jan 2023 09:06:13 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id d25-20020a2eb059000000b0027fcbcc3bedsm986619ljl.51.2023.01.09.09.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:06:12 -0800 (PST)
Date:   Mon, 9 Jan 2023 20:06:10 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] spi: dw: update SPI_CTRLR0 register
Message-ID: <20230109170610.6ndmqi57leb5scm7@mobilestation>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221212180732.79167-4-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212180732.79167-4-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 06:07:20PM +0000, Sudip Mukherjee wrote:
> If the SPI transfer is being done in enhanced mode then SPI_CTRLR0
> register needs to be updated to mention the instruction length, address
> length, address and instruction transfer format, wait cycles. And, we
> also need to enable clock stretching.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 14 +++++++++++++-
>  drivers/spi/spi-dw.h      | 11 +++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 8c47a4d14b666..d59401f16c47a 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c

> @@ -320,7 +320,7 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
>  {
>  	struct dw_spi_chip_data *chip = spi_get_ctldata(spi);
>  	u32 cr0 = chip->cr0;

I suggest to update the dw_spi_update_config() semantic to accepting
optional eSPI configs by means of passing an additional argument
struct dw_spi_enh_cfg *ecfg. If it's null, then no need in updating
the SPI_CTRLR0 register.

> -	u32 speed_hz;
> +	u32 speed_hz, spi_ctrlr0;

Just reuse the cr0 variable.

>  	u16 clk_div;
>  
>  	/* CTRLR0[ 4/3: 0] or CTRLR0[ 20: 16] Data Frame Size */
> @@ -365,6 +365,18 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
>  		dw_writel(dws, DW_SPI_RX_SAMPLE_DLY, chip->rx_sample_dly);
>  		dws->cur_rx_sample_dly = chip->rx_sample_dly;
>  	}
> +
> +	if (cfg->spi_frf != DW_SPI_CTRLR0_SPI_FRF_STD_SPI) {
> +		spi_ctrlr0 = DW_SPI_SPI_CTRLR0_CLK_STRETCH_EN;
> +		spi_ctrlr0 |= FIELD_PREP(DW_SPI_SPI_CTRLR0_WAIT_CYCLE_MASK,
> +					 cfg->wait_c);
> +		spi_ctrlr0 |= FIELD_PREP(DW_SPI_SPI_CTRLR0_INST_L_MASK,
> +					 cfg->inst_l);
> +		spi_ctrlr0 |= FIELD_PREP(DW_SPI_SPI_CTRLR0_ADDR_L_MASK,
> +					 cfg->addr_l);

> +		spi_ctrlr0 |= cfg->trans_t;

Should be also handled by the FIELD_PREP() macro.

> +		dw_writel(dws, DW_SPI_SPI_CTRLR0, spi_ctrlr0);
> +	}
>  }
>  EXPORT_SYMBOL_NS_GPL(dw_spi_update_config, SPI_DW_CORE);
>  
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 414a415deb42a..f29d89d05f34b 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -63,6 +63,7 @@
>  #define DW_SPI_DR			0x60
>  #define DW_SPI_RX_SAMPLE_DLY		0xf0
                                            <-+
>  #define DW_SPI_CS_OVERRIDE		0xf4  |
                                              |
> +#define DW_SPI_SPI_CTRLR0		0xf4 -+

Please replace SPI_CTRLR0 with ENH_CTRLR0 and move the macro
definition to where the arrow points to.

>  
>  /* Bit fields in CTRLR0 (DWC APB SSI) */
>  #define DW_PSSI_CTRLR0_DFS_MASK			GENMASK(3, 0)
> @@ -126,6 +127,12 @@
>  #define DW_SPI_DMACR_RDMAE			BIT(0)
>  #define DW_SPI_DMACR_TDMAE			BIT(1)
>  

> +/* Bit fields in SPI_CTRLR0 */
> +#define DW_SPI_SPI_CTRLR0_CLK_STRETCH_EN	BIT(30)
> +#define DW_SPI_SPI_CTRLR0_WAIT_CYCLE_MASK	GENMASK(15, 11)
> +#define DW_SPI_SPI_CTRLR0_INST_L_MASK		GENMASK(9, 8)
> +#define DW_SPI_SPI_CTRLR0_ADDR_L_MASK		GENMASK(5, 2)

First add DW_SPI_ENH_CTRLR0_TRANS_T_MASK macro too. Second please
replace SPI_CTRLR0 with ENH_CTRLR0.

> +
>  /* Mem/DMA operations helpers */
>  #define DW_SPI_WAIT_RETRIES			5
>  #define DW_SPI_BUF_SIZE \
> @@ -141,6 +148,10 @@ struct dw_spi_cfg {
>  	u32 ndf;
>  	u32 freq;
>  	u8 spi_frf;

> +	u8 trans_t;
> +	u8 inst_l;
> +	u8 addr_l;
> +	u8 wait_c;

Please move these to a separate structure:
struct dw_spi_enh_cfg {
	u8 wait_l;
	u8 inst_l;
	u8 addr_l;
	u8 trans_t;
};
Thus we'll be able to add an optional argument to the
dw_spi_update_config() method.

-Serge(y)

>  };
>  
>  struct dw_spi;
> -- 
> 2.30.2
> 
