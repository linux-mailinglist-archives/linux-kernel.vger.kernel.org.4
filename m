Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624846931C4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 15:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjBKOrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 09:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBKOrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 09:47:23 -0500
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB76C64F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 06:46:51 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id Qr95pNL9rOJaFQr95pI1Nk; Sat, 11 Feb 2023 15:46:32 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Feb 2023 15:46:32 +0100
X-ME-IP: 86.243.2.178
Message-ID: <e8ce6ab5-5db0-305b-f025-a4cef95fde58@wanadoo.fr>
Date:   Sat, 11 Feb 2023 15:46:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] spi: Remove extra/duplicate constant from expression
To:     drv@mailo.com
Cc:     broonie@kernel.org, kumarpraveen@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        ssengar@microsoft.com
References: <Y+dnFKut9qiQUxjW@ubun2204.myguest.virtualbox.org>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Y+dnFKut9qiQUxjW@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/02/2023 à 10:59, Deepak R Varma a écrit :
> Constant SPI_TX_OCTAL is included twice while building the controller
> mode bits. Remove the extra constant.
> Issue identified using doublebitand.cocci Coccinelle semantic patch.
> 
> Signed-off-by: Deepak R Varma <drv-asAA5fHt7EIAvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/spi/spi-sn-f-ospi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
> index 348c6e1edd38..19284d6914fc 100644
> --- a/drivers/spi/spi-sn-f-ospi.c
> +++ b/drivers/spi/spi-sn-f-ospi.c
> @@ -611,7 +611,7 @@ static int f_ospi_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	ctlr->mode_bits = SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL
> -		| SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_OCTAL
> +		| SPI_RX_DUAL | SPI_RX_QUAD

Or maybe s/SPI_TX_OCTAL/SPI_RX_OCTAL/ ?

CJ

>   		| SPI_MODE_0 | SPI_MODE_1 | SPI_LSB_FIRST;
>   	ctlr->mem_ops = &f_ospi_mem_ops;
>   	ctlr->bus_num = -1;

