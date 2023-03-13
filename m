Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F8A6B744C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCMKj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjCMKjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:39:21 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9BBA5C9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:39:02 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id DF1C116A7;
        Mon, 13 Mar 2023 11:39:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1678703940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lG+1YG/ll6A6Rxr6tBRejWjyDoRlJTY6VGsQkKwEwtQ=;
        b=ZfB2vAd/J9L6ec8RcrVKS8Onm92C8YxZjQ03HJ1Xz0mKtoRjyMawAPug6ehODeeDvLhIyc
        jGbef7D6c/BGTxYN3g6uXJOXPgKVhlfYs8AQQHc0nmO1lbwDBpSm9NDnVExJ539UA5/4js
        lzrUArLzsP8Sg8E+tP/Fm6wq+ETNIWZWKlSBJkOnh1liJ6ojLPKcSc7ln8CUdtNN7xdlWP
        eNh0kIXdKywi1uv71/3tZ8+roPcMFXRTACoaj7Fw3TYcBctyx/KP9Zb4coOETEiR47sQ5K
        nsxogfTNu2Ob6VD/mdoees0WhdGrhECkkqsxFPzJaOBbFaEzmK+63DV8dgZ58Q==
MIME-Version: 1.0
Date:   Mon, 13 Mar 2023 11:39:00 +0100
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Luke He <sixuerain@gmail.com>, tudor.ambarus@linaro.org,
        pratyush@kernel.org, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: Add support for XMC XM25QH256C / XM25QU256C
 / XM25QH512C / XM25QU512C site: https://www.xmcwh.com/site/product#
In-Reply-To: <20230313113304.1611638d@xps-13>
References: <20230313100153.15441-1-sixuerain@gmail.com>
 <d553beb1c6e38eac748d0b6b62bcd335@walle.cc> <20230313113304.1611638d@xps-13>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <17d46633869f64e029e065693e341e3b@walle.cc>
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

Am 2023-03-13 11:33, schrieb Miquel Raynal:
> Hi Michael,
> 
> michael@walle.cc wrote on Mon, 13 Mar 2023 11:08:15 +0100:
> 
>> Hi,
>> 
>> please have a look at Documentation/process/submitting-patches.rst
>> how to properly format patches. But also see below.
>> 
>> Am 2023-03-13 11:01, schrieb Luke He:
>> > Signed-off-by: Luke He <sixuerain@gmail.com>
>> > ---
>> >  drivers/mtd/spi-nor/xmc.c | 12 ++++++++++++
>> >  1 file changed, 12 insertions(+)
>> >
>> > diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
>> > index 051411e86339..6db01b80237f 100644
>> > --- a/drivers/mtd/spi-nor/xmc.c
>> > +++ b/drivers/mtd/spi-nor/xmc.c
>> > @@ -16,6 +16,18 @@ static const struct flash_info xmc_nor_parts[] = {
>> >  	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256)
>> >  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>> >  			      SPI_NOR_QUAD_READ) },
>> > +	{ "XM25QH256C", INFO(0x204019, 0, 64 * 1024, 512)
>> > +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>> > +			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>> > +	{ "XM25QU256C", INFO(0x204119, 0, 64 * 1024, 512)
>> > +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>> > +			     SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>> > +	{ "XM25QH512C", INFO(0x204020, 0, 64 * 1024, 1024)
>> > +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>> > +			     SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>> > +	{ "XM25QU512C", INFO(0x204120, 0, 64 * 1024, 1024)
>> > +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>> > +			     SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) }
>> 
>> I've just looked at XM25QH256C [1], but I suspect all of these
>> flashes supports SFDP, therefore you shouldn't use the NO_SFDP_FLAGS.
> 
> I didn't check, do we have a kdoc or something like that which explains
> what flags to use and when?

https://elixir.bootlin.com/linux/v6.3-rc2/source/drivers/mtd/spi-nor/core.h#L429

What's missing is still some overview document when and how to add a new
entry to our database. /me looks in Tudors direction :)

-michael
