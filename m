Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220736EA658
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjDUIz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjDUIyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:54:38 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4737CAF06;
        Fri, 21 Apr 2023 01:53:59 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2a8c30ac7e3so12776691fa.1;
        Fri, 21 Apr 2023 01:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682067237; x=1684659237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4P0O1Vz2tzhQURoSKKcWOq45Razq2r2XK7+VYyIBMnA=;
        b=JvHvzjhAsxV6wYLc7fWpRlro4WbZEAsukdm7V0YqRCyIeWLmFmjgAtX0LWXZC1oTEH
         2EIK2w8Aqjwmy9m1I5tiIyBFI0zTT3zF5RsDW4PJy6kK2NZnVlB6pNzYw2NlduO1gf57
         Lzq5K41A8c2OFj4dB5NGVP+zHXNtp2dhYi/KonhYsjzoKps6fqm2Y9FnoSsPmu4x/Kn6
         Y6/lyEXHisOG+0kEZ+Lw0F+stwAdVSNks1jJ73ImE6QZJe4BobSqv7WFVxe1yvSbtoAA
         yTg4xmn5XGPUHZMPkpq4AlKnUpWkuLMmmu7A3oKoNobYqvgsgFDZ029XVcKtpz0Jic9u
         nN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682067237; x=1684659237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4P0O1Vz2tzhQURoSKKcWOq45Razq2r2XK7+VYyIBMnA=;
        b=cnGEfDgeq0MVUoZouttpr7GUme48hZsdl+ek/xD7qWeBVXgIrkzjpRnl06cGu2pc1r
         W87JzlwAgN0GjKlMSh2zeWlln+ESLjFjDcPLddBQnPOL2o55I/Su+EUznZ2/ENpEBe3u
         VxR4Lf4zgfQiuAqG9DlTIfyJyPgiAoxTjUllATnmsQBN8sHF7YBp0IitzzIZT6hCOGcA
         ZxgWFIgtdgMnBBu5arrtsKHaI5Y6po86ZSCbqq0JuLBXFRHpIkUstRpKv7vSGBVEa84I
         4KFSymUoBnYDHHZgGzT02Aqopvg+9OzzWU/HNPYGY9MJS0wp5cXcOZQzPpawwVPbbs8u
         bUMw==
X-Gm-Message-State: AAQBX9csXN5FVzC6u+OhJAkRFc/duMg5aOZeJnUI4QE/r+QPSj/kv1aO
        KbS6fW5eUruOLxAxidHpLuxmm0x9gMM=
X-Google-Smtp-Source: AKy350bpj5V4IQTn138cn0Tk1H+aKuaTEhQCax6SMuSw5WtMbeLZwiLQL0OItlCjT1hZWNv5+DN/7Q==
X-Received: by 2002:a2e:99d1:0:b0:2a9:ebf0:d95a with SMTP id l17-20020a2e99d1000000b002a9ebf0d95amr529602ljj.34.1682067237208;
        Fri, 21 Apr 2023 01:53:57 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id y13-20020a2e9d4d000000b002a4bb086610sm543356ljj.123.2023.04.21.01.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 01:53:56 -0700 (PDT)
Date:   Fri, 21 Apr 2023 11:53:54 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com
Subject: Re: [PATCH v8 5/5] spi: dw: Round of n_bytes to power of 2
Message-ID: <20230421085354.34dwrgr3enlxqhtc@mobilestation>
References: <20230420055131.2048959-1-joychakr@google.com>
 <20230420055131.2048959-6-joychakr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420055131.2048959-6-joychakr@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 05:51:31AM +0000, Joy Chakraborty wrote:
> n_bytes variable in the driver represents the number of bytes per word
> that needs to be sent/copied to fifo. Bits/word can be between 8 and 32
> bits from the client but in memory they are a power of 2, same is mentioned
> in spi.h header:
> "
>  * @bits_per_word: Data transfers involve one or more words; word sizes
>  *	like eight or 12 bits are common.  In-memory wordsizes are
>  *	powers of two bytes (e.g. 20 bit samples use 32 bits).
>  *	This may be changed by the device's driver, or left at the
>  *	default (0) indicating protocol words are eight bit bytes.
>  *	The spi_transfer.bits_per_word can override this for each transfer.
> "
> 
> Hence, round of n_bytes to a power of 2 to avoid values like 3 which
> would generate unalligned/odd accesses to memory/fifo.
> 
> Fixes: a51acc2400d4 ("spi: dw: Add support for 32-bits max xfer size")
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> ---
>  drivers/spi/spi-dw-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index c3bfb6c84cab..a6486db46c61 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -426,7 +426,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
>  	int ret;
>  
>  	dws->dma_mapped = 0;

> -	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
> +	dws->n_bytes = roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE));

Almost 100 symbols looks too bulky. Moreover single-lined nested call
makes things a bit harder to read. What about formatting it up like
this?

	dws->n_bytes =
		roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word,
						BITS_PER_BYTE));

	or like this:

	dws->n_bytes = roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word,
						       BITS_PER_BYTE));

Splitting the line into chunks will simplify the visual
differentiation between the outer and inner calls.

* Note even though the 80-char columns limit isn't that strict rule
now, but it's still preferable unless exceeding the limit significantly
increases readability. The update you suggest doesn't seem like the case
which would improve the readability.

-Serge(y)

>  	dws->tx = (void *)transfer->tx_buf;
>  	dws->tx_len = transfer->len / dws->n_bytes;
>  	dws->rx = transfer->rx_buf;
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 
