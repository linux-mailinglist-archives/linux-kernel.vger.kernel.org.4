Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AA95EAEE8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIZR7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiIZR6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:58:55 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750776FA2A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:37:58 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id cs3FoyDRoC5LCcs3FoinIN; Mon, 26 Sep 2022 19:37:56 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 26 Sep 2022 19:37:56 +0200
X-ME-IP: 86.243.100.34
Message-ID: <4463371a-2b71-1153-7814-fdff59eb99cd@wanadoo.fr>
Date:   Mon, 26 Sep 2022 19:37:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] block/swim3: add __init annotation to module init
 func
Content-Language: fr
To:     ruanjinjie <ruanjinjie@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926092241.1191846-1-ruanjinjie@huawei.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220926092241.1191846-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/09/2022 à 11:22, ruanjinjie a écrit :
> Add missing __init annotation to module init func.
> 
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
>   drivers/block/swim3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
> index da811a7da03f..1f65d506fbc9 100644
> --- a/drivers/block/swim3.c
> +++ b/drivers/block/swim3.c
> @@ -1278,7 +1278,7 @@ static struct macio_driver swim3_driver =
>   };
>   
>   
> -int swim3_init(void)
> +int __init swim3_init(void)
>   {
>   	macio_register_driver(&swim3_driver);
>   	return 0;

Hi,

unrelated, but should there be a swim3_exit() to call 
macio_register_driver(), as already done in some other drivers using 
these functions?

CJ
