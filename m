Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFF16D44AD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjDCMps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjDCMpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:45:46 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CCD65BC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 05:45:44 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id C0CEC11EF;
        Mon,  3 Apr 2023 14:45:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1680525942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lXqDszMZ+SLbaBvX6vkjljjzHJKV81E4AMBJVag1T+A=;
        b=jTRCXU+FfRRRPOtZ5tCHPsid1KRy87r8zyPkU/wXntp/h76JLPyU2fsHRmbJ8yIlvLAFqH
        ovu0KABGY9K9nG6DX4IPVlH5SbyrjSxwwzoScqC2AnMVyqwlbwiD41G70CwXKaOzBxA1to
        +X2B8cAbYqcKzK7KNMsI2ifFI5nyMHphnnRfOGiA8Y4DR2ZEIH+IKAQ0q77oXwBv8Y1JYO
        u9u/ow53LuAJdH6vNJHLaaexhpgMpSxGfd6xLiyKka9hgJCcseAKOgzHjn27+Tjh7IWLR9
        fnaQJ5GdtuBF5USazqTBZYeht0utV77fWGzk3tzssb/jWJ7oa+08rO34SdQiQg==
MIME-Version: 1.0
Date:   Mon, 03 Apr 2023 14:45:42 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] mtd: spi-nor: core: Update name and description
 of spansion_set_4byte_addr_mode
In-Reply-To: <20230331074606.3559258-4-tudor.ambarus@linaro.org>
References: <20230331074606.3559258-1-tudor.ambarus@linaro.org>
 <20230331074606.3559258-4-tudor.ambarus@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <eeb2490a71eac1ae4e55b80856f75ec6@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-03-31 09:45, schrieb Tudor Ambarus:
> Rename method to spi_nor_set_4byte_addr_mode_brwr and extend its
> description. This method is described in JESD216 BFPT[SFDP_DWORD(16)],
> BIT(28) and BIT(20).
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/mtd/spi-nor/core.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 07be81afdc33..e8f6141c0ef6 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -564,15 +564,20 @@ int
> spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor, bool
> enable)
>  }
> 
>  /**
> - * spansion_set_4byte_addr_mode() - Set 4-byte address mode for 
> Spansion
> - * flashes.
> + * spi_nor_set_4byte_addr_mode_brwr() - Set 4-byte address mode using
> + *			SPINOR_OP_BRWR. Typically used by Spansion flashes.
>   * @nor:	pointer to 'struct spi_nor'.
>   * @enable:	true to enter the 4-byte address mode, false to exit the 
> 4-byte
>   *		address mode.
>   *
> + * 8-bit volatile bank register used to define A[30:A24] bits. MSB 
> (bit[7]) is
> + * used to enable/disable 4-byte address mode. When MSB is set to ‘1’, 
> 4-byte
> + * address mode is active and A[30:24] bits are don’t care. Write
> instruction is
> + * SPINOR_OP_BRWR(17h) with 1 byte of data.
> + *

No "typically used by spansion"? I guess there is a reason for that.

In any case:
Reviewed-by: Michael Walle <michael@walle.cc>
