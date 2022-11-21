Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56494632DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiKUUZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKUUZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:25:55 -0500
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9FF57B72;
        Mon, 21 Nov 2022 12:25:53 -0800 (PST)
Message-ID: <414c8bf5-f2ce-e042-05ff-0e463ab2613f@gentoo.org>
Date:   Mon, 21 Nov 2022 21:25:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   zzam@gentoo.org
Subject: Re: [PATCH] [media] si2165: Remove redundant NULL check before
 release_firmware() call
Content-Language: en-GB
To:     cgel.zte@gmail.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220606014433.290667-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220606014433.290667-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.06.22 um 03:44 schrieb cgel.zte@gmail.com:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> release_firmware() checks for NULL pointers internally so checking
> before calling it is redundant.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>   drivers/media/dvb-frontends/si2165.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/si2165.c b/drivers/media/dvb-frontends/si2165.c
> index ebee230afb7b..3d167ca670a4 100644
> --- a/drivers/media/dvb-frontends/si2165.c
> +++ b/drivers/media/dvb-frontends/si2165.c
> @@ -513,10 +513,8 @@ static int si2165_upload_firmware(struct si2165_state *state)
>   	ret = 0;
>   	state->firmware_loaded = true;
>   error:
> -	if (fw) {
> -		release_firmware(fw);
> -		fw = NULL;
> -	}
> +	release_firmware(fw);
> +	fw = NULL;
>   
>   	return ret;
>   }

Acked-by: Matthias Schwarzott <zzam@gentoo.org>

