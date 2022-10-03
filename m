Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84715F3752
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJCUsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiJCUsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:48:21 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7829A4C629;
        Mon,  3 Oct 2022 13:48:01 -0700 (PDT)
Message-ID: <1a9f797c-e11f-a60b-8b3f-9e229c17fe64@gentoo.org>
Date:   Mon, 3 Oct 2022 16:47:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [PATCH] rtc: ds1685: Fix spelling of function name in comment
 block
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221003153711.271630-1-colin.i.king@gmail.com>
From:   Joshua Kinard <kumba@gentoo.org>
In-Reply-To: <20221003153711.271630-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/2022 11:37, Colin Ian King wrote:
> The function name is missing the letter 'd' in the comment block.
> Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/rtc/rtc-ds1685.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
> index a24331ba8a5f..5db9c737c022 100644
> --- a/drivers/rtc/rtc-ds1685.c
> +++ b/drivers/rtc/rtc-ds1685.c
> @@ -132,7 +132,7 @@ ds1685_rtc_bin2bcd(struct ds1685_priv *rtc, u8 val, u8 bin_mask, u8 bcd_mask)
>   }
>   
>   /**
> - * s1685_rtc_check_mday - check validity of the day of month.
> + * ds1685_rtc_check_mday - check validity of the day of month.
>    * @rtc: pointer to the ds1685 rtc structure.
>    * @mday: day of month.
>    *

Acked-by: Joshua Kinard <kumba@gentoo.org>

