Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81B363953C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 11:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiKZKOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 05:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKZKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 05:14:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4847D27930;
        Sat, 26 Nov 2022 02:14:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A249360A0B;
        Sat, 26 Nov 2022 10:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE3AC433D6;
        Sat, 26 Nov 2022 10:14:10 +0000 (UTC)
Message-ID: <7293f7a2-0136-1c1c-e6ac-4fe810081c64@xs4all.nl>
Date:   Sat, 26 Nov 2022 11:14:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 12/31] media: v4l2-core: changing LED_* from enum
 led_brightness to actual value
Content-Language: en-US
To:     Luiz Sampaio <sampaio.ime@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
 <20220121165436.30956-13-sampaio.ime@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220121165436.30956-13-sampaio.ime@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz,

On 21/01/2022 17:54, Luiz Sampaio wrote:
> The enum led_brightness, which contains the declaration of LED_OFF,
> LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
> max_brightness.

Note that there is no Signed-off-by line, so I can't take this.

Same for patches 11/31 and 10/31.

If this is still relevant (it's an old series, after all), then please
repost.

Regards,

	Hans

> ---
>  drivers/media/v4l2-core/v4l2-flash-led-class.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-flash-led-class.c b/drivers/media/v4l2-core/v4l2-flash-led-class.c
> index e70e128ccc9c..a47ac654c9f4 100644
> --- a/drivers/media/v4l2-core/v4l2-flash-led-class.c
> +++ b/drivers/media/v4l2-core/v4l2-flash-led-class.c
> @@ -234,11 +234,11 @@ static int v4l2_flash_s_ctrl(struct v4l2_ctrl *c)
>  	case V4L2_CID_FLASH_LED_MODE:
>  		switch (c->val) {
>  		case V4L2_FLASH_LED_MODE_NONE:
> -			led_set_brightness_sync(led_cdev, LED_OFF);
> +			led_set_brightness_sync(led_cdev, 0);
>  			return led_set_flash_strobe(fled_cdev, false);
>  		case V4L2_FLASH_LED_MODE_FLASH:
>  			/* Turn the torch LED off */
> -			led_set_brightness_sync(led_cdev, LED_OFF);
> +			led_set_brightness_sync(led_cdev, 0);
>  			if (ctrls[STROBE_SOURCE]) {
>  				external_strobe = (ctrls[STROBE_SOURCE]->val ==
>  					V4L2_FLASH_STROBE_SOURCE_EXTERNAL);

