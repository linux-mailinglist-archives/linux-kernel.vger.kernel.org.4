Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8F16E420B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjDQIFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjDQIFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:05:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5926D1BF;
        Mon, 17 Apr 2023 01:05:39 -0700 (PDT)
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B160BDE6;
        Mon, 17 Apr 2023 10:05:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1681718733;
        bh=mo5Aedmwo7B/5nq+EOr9wBxYL7ukqoSB5JP37ZRi/wQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZrNfc7d2g05GOS/efqpXBEHL5CjqhcFXWku5y8mPUBG7LmtOLxPdIGOZfjdY9BFTD
         EO7bGfUiWhjLDWXeu/7gZ1UL46XlGl+4mFiSFHLuKXTQTutwrh537rJ+XpoQg+OA18
         rLb8dsNH+tszbXw839lo7QIb5rRI6AbvQ1+pIbIQ=
Message-ID: <bc48ef67-dbe2-47c8-4bb9-854bcab5c168@ideasonboard.com>
Date:   Mon, 17 Apr 2023 09:05:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] media: ov5693: Simplify an error message
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org
References: <928f2f70de241d0fa66801b46d736ad0f881eb72.1681576102.git.christophe.jaillet@wanadoo.fr>
From:   Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <928f2f70de241d0fa66801b46d736ad0f881eb72.1681576102.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe

On 15/04/2023 17:28, Christophe JAILLET wrote:
> dev_err_probe() already display the error code. There is no need to
> duplicate it explicitly in the error message.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---


Thanks for the patch:


Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>

>   drivers/media/i2c/ov5693.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
> index e3c3bed69ad6..d23786afd754 100644
> --- a/drivers/media/i2c/ov5693.c
> +++ b/drivers/media/i2c/ov5693.c
> @@ -404,8 +404,8 @@ static int ov5693_read_reg(struct ov5693_device *ov5693, u32 addr, u32 *value)
>   	ret = i2c_transfer(client->adapter, msg, 2);
>   	if (ret < 0)
>   		return dev_err_probe(&client->dev, ret,
> -				     "Failed to read register 0x%04x: %d\n",
> -				     addr & OV5693_REG_ADDR_MASK, ret);
> +				     "Failed to read register 0x%04x\n",
> +				     addr & OV5693_REG_ADDR_MASK);
>   
>   	*value = 0;
>   	for (i = 0; i < len; ++i) {
