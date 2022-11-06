Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B53361E6FB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 23:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiKFWsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 17:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKFWsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 17:48:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC4F65A9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 14:48:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC9E560DE5
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 22:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03CAC433C1;
        Sun,  6 Nov 2022 22:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667774885;
        bh=w5IZtVGyB78C1pybpSuLuYkijzB0ftqE393WbSFktkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qaC6OlFLcOMzUE08QXHlxeviBOEKxpNZDfUAS5FpYV3NZegWUOgiTKbxCRjp5lI2+
         N5jkQZruY/MJFMvzzTjsczKB0O8B4lLPjG7MPKbu3VToR6Xrk6tSIlr77obc3JCKLr
         H9CbJ0ocG8j/BC+BnJDl+HD20Sp9Ptc3tk0GwbhwOCApwjz2TiFSBN3hAlW5I1AyKz
         cjVGd4kbvaEZN3ced56kLDaKMd4EIh9fKmkP50Lq940BPPh/6/U49SDHO+P8u67lmE
         MtsWK8+2PSvIN9eCZQ4/y2SPN4ROAR1X4l+p2z9SCfcP6rjCyw3MgCROd0kubwm2yr
         JTwHx4aLc2LZg==
Date:   Sun, 6 Nov 2022 23:48:02 +0100
From:   Pratyush Yadav <pratyush@kernel.org>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: Fix formatting in spi_nor_read_raw()
 kerneldoc comment
Message-ID: <20221106224802.suut4pni6u2c27tv@yadavpratyush.com>
References: <20221101162906.990125-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101162906.990125-1-j.neuschaefer@gmx.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/22 05:29PM, Jonathan Neuschäfer wrote:
> It doesn't make sense to put "set" on its own line like that.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

> ---
>  drivers/mtd/spi-nor/sfdp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index 2257f1b4c2e2d..3e0bb383ab8e2 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -135,8 +135,7 @@ struct sfdp_4bait {
>  /**
>   * spi_nor_read_raw() - raw read of serial flash memory. read_opcode,
>   *			addr_nbytes and read_dummy members of the struct spi_nor
> - *			should be previously
> - * set.
> + *			should be previously set.
>   * @nor:	pointer to a 'struct spi_nor'
>   * @addr:	offset in the serial flash memory
>   * @len:	number of bytes to read
> --
> 2.35.1
> 

-- 
Regards,
Pratyush Yadav
