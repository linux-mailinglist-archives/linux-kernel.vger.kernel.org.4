Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DEF5BCF58
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiISOm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiISOmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:42:54 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D30B114E;
        Mon, 19 Sep 2022 07:42:53 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8C26CD02;
        Mon, 19 Sep 2022 16:42:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663598571;
        bh=Qy9RieIsYHYKDGtK6BcRK5+sUjxroS2wx65CmlGOgkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sib6AlAh/7VZXk/FgLUZUSnLNwQHjsG5ad5i/9Flb1b2k27JjnXOt4WBlUQWNWHXs
         DSsTIVwTPeS4TL8Ofll6YHvItDYLZCEqlR/sEZpFYYW5tNt6zFIiVJbmI44hgrka1L
         qekRl6d9ejXyHM9f0HR0y2JsuXL8yVt15iX1nFNM=
Date:   Mon, 19 Sep 2022 17:42:38 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] media: i2c: ov5645: Drop fetching the clk reference by
 name
Message-ID: <Yyh/3uzOJOu3drEB@pendragon.ideasonboard.com>
References: <20220919143350.176746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220919143350.176746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thank you for the patch.

On Mon, Sep 19, 2022 at 03:33:50PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The OV5645 sensor has a single clock source, so just drop fetching the
> clk reference by name.
> 
> This is in preparation to drop the "clock-names" property from the DT
> binding.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/media/i2c/ov5645.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> index 81e4e87e1821..47451238ca05 100644
> --- a/drivers/media/i2c/ov5645.c
> +++ b/drivers/media/i2c/ov5645.c
> @@ -1090,7 +1090,7 @@ static int ov5645_probe(struct i2c_client *client)
>  	}
>  
>  	/* get system clock (xclk) */
> -	ov5645->xclk = devm_clk_get(dev, "xclk");
> +	ov5645->xclk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(ov5645->xclk)) {
>  		dev_err(dev, "could not get xclk");
>  		return PTR_ERR(ov5645->xclk);

-- 
Regards,

Laurent Pinchart
