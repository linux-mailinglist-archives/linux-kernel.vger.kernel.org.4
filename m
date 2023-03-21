Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD9D6C3525
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjCUPJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjCUPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:09:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0391D50983;
        Tue, 21 Mar 2023 08:08:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7077B817BB;
        Tue, 21 Mar 2023 15:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53884C433EF;
        Tue, 21 Mar 2023 15:08:32 +0000 (UTC)
Message-ID: <487b75ea-aecd-5fdc-c2a2-5f5080f8647e@xs4all.nl>
Date:   Tue, 21 Mar 2023 16:08:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: av7110: put spaces around operators
Content-Language: en-US
To:     Daniel Watson <ozzloy@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <ZBlShLl4PYlNIpGN@trent-reznor>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <ZBlShLl4PYlNIpGN@trent-reznor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 21/03/2023 07:45, Daniel Watson wrote:
> put spaces around '=' and '<=' to match style from checkpatch
> 
> Signed-off-by: Daniel Watson <ozzloy@gmail.com>
> ---
>  drivers/staging/media/av7110/av7110_hw.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/media/av7110/av7110_hw.h b/drivers/staging/media/av7110/av7110_hw.h
> index 6380d8950c695..3274146c401f1 100644
> --- a/drivers/staging/media/av7110/av7110_hw.h
> +++ b/drivers/staging/media/av7110/av7110_hw.h
> @@ -402,8 +402,8 @@ static inline u32 irdebi(struct av7110 *av7110, u32 config, int addr, u32 val, u
>  {
>  	u32 res;
>  
> -	res=av7110_debiread(av7110, config, addr, count);
> -	if (count<=4)
> +	res = av7110_debiread(av7110, config, addr, count);
> +	if (count <= 4)
>  		memcpy(av7110->debi_virt, (char *) &res, count);
>  	return res;
>  }
> @@ -424,7 +424,7 @@ static inline u32 rdebi(struct av7110 *av7110, u32 config, int addr, u32 val, un
>  	u32 res;
>  
>  	spin_lock_irqsave(&av7110->debilock, flags);
> -	res=av7110_debiread(av7110, config, addr, count);
> +	res = av7110_debiread(av7110, config, addr, count);
>  	spin_unlock_irqrestore(&av7110->debilock, flags);
>  	return res;
>  }

I'm not sure what the point it of these two fixes since this driver is
full of such things.

In any case, I'm rejecting this. Just leave this driver alone, it's not
worth the effort.

If you are doing this as part of some mentorship program, then skip the
drivers/staging/media directory, it's not suitable for that.

Regards,

	Hans
