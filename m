Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B3A5BE52B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiITMES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiITMEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:04:15 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651F24A836;
        Tue, 20 Sep 2022 05:04:13 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id EA66461EA192A;
        Tue, 20 Sep 2022 14:04:10 +0200 (CEST)
Message-ID: <7146f97f-eace-9ef6-7a16-3f775d851f33@molgen.mpg.de>
Date:   Tue, 20 Sep 2022 14:04:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] dm: Fix spelling mistake in comments
To:     Zhou Nan <zhounan@nfschina.com>
Cc:     song@kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
References: <CAPhsuW64vLfGUGOPjnQx-D7=qh7yFL=yvfWUTPn7teCegLeZaQ@mail.gmail.com>
 <20220920012848.84461-1-zhounan@nfschina.com>
 <20220920012848.84461-2-zhounan@nfschina.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220920012848.84461-2-zhounan@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Zhou,


Am 20.09.22 um 03:28 schrieb Zhou nan:
> From: zhounan <zhounan@nfschina.com>

You missed the comment about using your full name.

     $ git config --global user.name "Zhou Nan"
     $ git commit --amend --author="Zhou Nan <zhounan@nfschina.com>"

> Fix spelling of dones't in comments.

… in one comment.

(Also in summary.)

> Signed-off-by: zhounan <zhounan@nfschina.com>
> ---
>   drivers/md/raid5-cache.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> index f4e1cc1ece43..683fd4adde17 100644
> --- a/drivers/md/raid5-cache.c
> +++ b/drivers/md/raid5-cache.c
> @@ -125,7 +125,7 @@ struct r5l_log {
>   					 * reclaimed.  if it's 0, reclaim spaces
>   					 * used by io_units which are in
>   					 * IO_UNIT_STRIPE_END state (eg, reclaim
> -					 * dones't wait for specific io_unit
> +					 * doesn't wait for specific io_unit
>   					 * switching to IO_UNIT_STRIPE_END
>   					 * state) */
>   	wait_queue_head_t iounit_wait;

The rest looks good.


Kind regards,

Paul
