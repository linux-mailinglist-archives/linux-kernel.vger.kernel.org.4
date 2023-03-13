Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3176B7368
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCMKIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCMKIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:08:20 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D750E11667
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:08:17 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 778A7D5A;
        Mon, 13 Mar 2023 11:08:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1678702095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z7HFpDnOl3q4iWUSr5nmYuABZICa90lL0/oWJXog6fQ=;
        b=IPSyNUTF1zf4GgMhTcPiQ8Yi2TqeqIj9hfapBYTBpuA7U+IujqXW1yjeF53eq+WGiHDdz8
        cArlPt4LDOqnp5PHuS4/RjiC2Q+BJVhoLf88WICB2UqWab47FerIKjKY3yI40YdXtTibch
        CQqVTxSJBm/kVYuBn5YvkIOXqdfYQMXPUBroAjrkZ6L99TncRX0sebeoH+sa6kzz/LSWq7
        F9tYNQTQFhY6iG1AbZmO+RAdmJSw7XQkI7hKyOcKNfleuZfV3T5lBMxFfaZXxNkteoUQzm
        eYOLBgga6n3V6BT/iVxBpSMe63XdXP+r73BD2G8ymhx16FRZJ++b2NfTmRs9OQ==
MIME-Version: 1.0
Date:   Mon, 13 Mar 2023 11:08:15 +0100
From:   Michael Walle <michael@walle.cc>
To:     Luke He <sixuerain@gmail.com>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: Add support for XMC XM25QH256C / XM25QU256C
 / XM25QH512C / XM25QU512C site: https://www.xmcwh.com/site/product#
In-Reply-To: <20230313100153.15441-1-sixuerain@gmail.com>
References: <20230313100153.15441-1-sixuerain@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d553beb1c6e38eac748d0b6b62bcd335@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please have a look at Documentation/process/submitting-patches.rst
how to properly format patches. But also see below.

Am 2023-03-13 11:01, schrieb Luke He:
> Signed-off-by: Luke He <sixuerain@gmail.com>
> ---
>  drivers/mtd/spi-nor/xmc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
> index 051411e86339..6db01b80237f 100644
> --- a/drivers/mtd/spi-nor/xmc.c
> +++ b/drivers/mtd/spi-nor/xmc.c
> @@ -16,6 +16,18 @@ static const struct flash_info xmc_nor_parts[] = {
>  	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
> +	{ "XM25QH256C", INFO(0x204019, 0, 64 * 1024, 512)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ "XM25QU256C", INFO(0x204119, 0, 64 * 1024, 512)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			     SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ "XM25QH512C", INFO(0x204020, 0, 64 * 1024, 1024)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			     SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ "XM25QU512C", INFO(0x204120, 0, 64 * 1024, 1024)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			     SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) }

I've just looked at XM25QH256C [1], but I suspect all of these
flashes supports SFDP, therefore you shouldn't use the NO_SFDP_FLAGS.
Then, without any additional flags, there is no need for an entry
at all, because it should be coverered by the "generic spi-nor"
driver [2].

-michael

[1] https://www.xmcwh.com/uploads/198/XM25QH256C_Ver1.8.pdf
[2] 
https://elixir.bootlin.com/linux/v6.3-rc2/source/drivers/mtd/spi-nor/core.c#L1637
