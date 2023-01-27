Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452B467DF59
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjA0Igr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjA0Igp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:36:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21BA24CA5;
        Fri, 27 Jan 2023 00:36:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5119561A11;
        Fri, 27 Jan 2023 08:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0058C433D2;
        Fri, 27 Jan 2023 08:36:42 +0000 (UTC)
Message-ID: <a66fec48-ae2e-034f-ecb2-4b0c3196d59c@xs4all.nl>
Date:   Fri, 27 Jan 2023 09:36:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH -next] media: v4l2-ctrls: clean up some inconsistent
 indentings
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20221216074212.45386-1-yang.lee@linux.alibaba.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20221216074212.45386-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2022 08:42, Yang Li wrote:
> clean up some inconsistent indentings to improve the readability of the
> code.
> 
> drivers/media/v4l2-core/v4l2-ctrls-api.c:154 user_to_new() warn: inconsistent indenting

Thank you for the patch, but the actual fix is already on its way
to mainline:

https://patchwork.linuxtv.org/project/linux-media/patch/69624c54-7cbd-7362-c468-f8ffea9614be@xs4all.nl/

Rejecting this in patchwork.

Regards,

	Hans

> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3503
> Fixes: 73278d483378 ("media: v4l2-ctrls-api.c: add back dropped ctrl->is_new = 1")
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/media/v4l2-core/v4l2-ctrls-api.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-api.c b/drivers/media/v4l2-core/v4l2-ctrls-api.c
> index 3d3b6dc24ca6..3bee4ad5be7c 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-api.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-api.c
> @@ -150,8 +150,8 @@ static int user_to_new(struct v4l2_ext_control *c, struct v4l2_ctrl *ctrl)
>  			 * then return an error.
>  			 */
>  			if (strlen(ctrl->p_new.p_char) == ctrl->maximum && last)
> -			ctrl->is_new = 1;
> -				return -ERANGE;
> +				ctrl->is_new = 1;
> +			return -ERANGE;
>  		}
>  		return ret;
>  	default:

