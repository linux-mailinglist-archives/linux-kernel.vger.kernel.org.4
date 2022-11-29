Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9044363BAC6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiK2HeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK2HeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:34:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CA6429BB;
        Mon, 28 Nov 2022 23:34:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B93DB8117D;
        Tue, 29 Nov 2022 07:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B119FC433D6;
        Tue, 29 Nov 2022 07:34:01 +0000 (UTC)
Message-ID: <08660efa-8429-5db1-b3a2-c74d48955a2a@xs4all.nl>
Date:   Tue, 29 Nov 2022 08:33:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH -next] media: Remove unneeded semicolon
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20221129010455.81099-1-yang.lee@linux.alibaba.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20221129010455.81099-1-yang.lee@linux.alibaba.com>
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

Hi Yang Li,

Please repost with a proper subject line prefix: "media: rzg2l-cru:".

The 'media:' prefix suggests a media-wide patch, not a patch for a single driver.

Ditto for your other patch for sun6i_isp.c.

Why is this so hard to do?

Regards,

	Hans

On 29/11/2022 02:04, Yang Li wrote:
> ./drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:409:2-3: Unneeded semicolon
> ./drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c:407:2-3: Unneeded semicolon
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3273
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c  | 2 +-
>  drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
> index aa752b80574c..5b80feaad927 100644
> --- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
> +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
> @@ -406,7 +406,7 @@ static void rzg2l_csi2_mipi_link_disable(struct rzg2l_csi2 *csi2)
>  		if (!(rzg2l_csi2_read(csi2, CSI2nRTST) & CSI2nRTST_VSRSTS))
>  			break;
>  		usleep_range(100, 200);
> -	};
> +	}
>  
>  	if (!timeout)
>  		dev_err(csi2->dev, "Clearing CSI2nRTST.VSRSTS timed out\n");
> diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> index 9533e4069ecd..cec4d20963a8 100644
> --- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> @@ -404,7 +404,7 @@ void rzg2l_cru_stop_image_processing(struct rzg2l_cru_dev *cru)
>  			break;
>  
>  		usleep_range(10, 20);
> -	};
> +	}
>  
>  	/* Notify that AXI bus can not stop here */
>  	if (!retries)

