Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC3163A1EC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiK1HT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiK1HT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:19:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A820F656E;
        Sun, 27 Nov 2022 23:19:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00B2DD6E;
        Sun, 27 Nov 2022 23:20:03 -0800 (PST)
Received: from [10.57.7.86] (unknown [10.57.7.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D62FF3F73D;
        Sun, 27 Nov 2022 23:19:54 -0800 (PST)
Message-ID: <283adb73-99c2-4215-0711-26ff0f73da26@arm.com>
Date:   Mon, 28 Nov 2022 07:19:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] thermal/core/power allocator: Remove a useless include
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
References: <9adeec47cb5a8193016272d5c8bf936235c1711d.1669459337.git.christophe.jaillet@wanadoo.fr>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <9adeec47cb5a8193016272d5c8bf936235c1711d.1669459337.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/22 10:42, Christophe JAILLET wrote:
> This file does not use rcu, so there is no point in including
> <linux/rculist.h>.
> 
> Remove it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/thermal/gov_power_allocator.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 2d1aeaba38a8..d5d4eae16771 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -8,7 +8,6 @@
>   
>   #define pr_fmt(fmt) "Power allocator: " fmt
>   
> -#include <linux/rculist.h>
>   #include <linux/slab.h>
>   #include <linux/thermal.h>
>   

Good catch.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
