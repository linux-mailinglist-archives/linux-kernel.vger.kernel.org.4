Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7941063A3AE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiK1I4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiK1I4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:56:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA53D2D1;
        Mon, 28 Nov 2022 00:56:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 319F76103C;
        Mon, 28 Nov 2022 08:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B4DC433C1;
        Mon, 28 Nov 2022 08:56:09 +0000 (UTC)
Message-ID: <eeea8927-1b0e-6a0b-12e5-b94097caed11@xs4all.nl>
Date:   Mon, 28 Nov 2022 09:56:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] media/i2c: fix repeated words in comments
Content-Language: en-US
To:     wangjianli <wangjianli@cdjrlc.com>, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220908123000.15066-1-wangjianli@cdjrlc.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220908123000.15066-1-wangjianli@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 14:30, wangjianli wrote:
> Delete the redundant word 'in'.
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  drivers/media/i2c/adv7175.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/adv7175.c b/drivers/media/i2c/adv7175.c
> index b58689728243..bc8f8bbedb45 100644
> --- a/drivers/media/i2c/adv7175.c
> +++ b/drivers/media/i2c/adv7175.c
> @@ -209,7 +209,7 @@ static int adv7175_s_std_output(struct v4l2_subdev *sd, v4l2_std_id std)
>  		/* This is an attempt to convert
>  		 * SECAM->PAL (typically it does not work
>  		 * due to genlock: when decoder is in SECAM
> -		 * and encoder in in PAL the subcarrier can
> +		 * and encoder in PAL the subcarrier can

As Randy said, this should be: is in

>  		 * not be synchronized with horizontal
>  		 * quency) */

And while at it, let's replace 'quency' with 'frequency'.

>  		adv7175_write_block(sd, init_pal, sizeof(init_pal));

And PLEASE add the driver name to the subject line.

If it starts with 'media/i2c' then that suggests the patch changes
multiple files in that directory. With 'media: i2c: adv7175:' I
know it is just for that driver.

Regards,

	Hans
