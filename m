Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A429C5F4F4A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJEFHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJEFG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:06:27 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528AF1D314
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 22:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664946287; x=1696482287;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uFJBTYsaMBZYY3AXnBMf5pwuXPfgYExf5gPkj72Rc1U=;
  b=p5nLca5joPTU/S1oXr1MDJ7C9x39+mlpWS6ZwnFd9/Gu+XWMzAy9bZ2f
   lm3ZrNgE6SKlC0o/alr0oiagS/xKVpqK089OfOBu3nICfkpyeHLOlG7yw
   TeOkDYF2XXZsuXQV9Gtn47DvldTdL80yB6FK5k7Smidb3n4B4ceLvp5on
   rzktlF8H+XI5qa05ze0RrpZxrFUa0lU5+Xd82oFds0sQulT8+eGatbqaI
   GlM2z9wIUNFoGjveGNpKBGn2JQ6kV1FzOJYpcjUmJuOM/35tqL8BPM71g
   JTkb+Hg/QC3fhZ7ebXumXo5tthZ5Oyix/tY1DaLbHXr9O5KaY4PSPXOiX
   w==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661788800"; 
   d="scan'208";a="317307262"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 13:04:22 +0800
IronPort-SDR: Gb17HQHHUvbZIfVupZI9aVofVMr+5mDwgDr20mKQ2A1PWUP5GKLwB46fAkgEhT2zmJ7i+i+H7Z
 1ED+Lkn9iqpOEI6nZkGox6fF08rndrjL+ouM7jruBCKp1emYoEONuk6zzOiSqry6sXt3V327ug
 vc8Gl3QxJmesUlRNMkFXZAWWT+tNH+f2u2qCjMZgZwm0nBg/4XjJ6zZxXed8Q32MrPb8c4zM+1
 N2UVZTkxQ2l8REZgqayStpq70nJzaLmEq+QQlupERLpzOB0stThEuKIYq+5d1BYo403jTEoEtW
 E9is09v0KWE8FzNuerWZKVxY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 21:24:10 -0700
IronPort-SDR: VAYgIb8rZ3MgAxkWyRQtafgeBUWWl8uljwXtY42Pa/EAkKLMNnp+vCanjXzd91xwysM3YWNRzD
 PQQWbhJn+PoGDKaYiqw2Oe1ecIxRV89OL/8hJbORJoi+BwnGejF3WRF8Ssd9x5eDoDnVP2Gbce
 pS3tNq2nTyxJviz8V1EzEmqDTJA8lP3rYk3/0kyxRE9GTYDs40bBxEVAGUEI18NWFgkNjck7X7
 /WhaS2N3Pa91GJ3SKD2WIIV/0dEzFhwq16Asz2ouEAYzwM3+f0jIRnmC56XXgMCXfTaKUqBWay
 WVg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 22:04:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mj2YK6Jqrz1RwqL
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 22:04:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664946261; x=1667538262; bh=uFJBTYsaMBZYY3AXnBMf5pwuXPfgYExf5gP
        kj72Rc1U=; b=gVsj93DwWdgMnF7DCLWcZQEKVFELmQMR+/yvEKgZ9dZeXAjAuXo
        h5/1IUAnUHxCM2yky/MyEI/znUM/OwdGwe0XtJ33336PTFR5uvlhP8Vj3NNdXI3i
        YLh+Y/KOM+4SqAXst0/+z20ZkhYM2qkmcVU7AixPqeaHGD30sIHY+frL9BjFiYwo
        j4ORy6Vy614d/6AXKE6337DkTwyL89YSbsaZZEVWMoOD55pYoMEDEt5Xdbwecmc6
        NB9hdV7cgwpGgQIlEe0DOuxZmVOTkvHWNt5bcyhhRpf4ZnFI39eYltil8QZRGNGV
        zaZQDjoCzO0JwFpiGsgB1giPEoqsrdHmyDg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vp7WOnsBg0Wv for <linux-kernel@vger.kernel.org>;
        Tue,  4 Oct 2022 22:04:21 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mj2YH5h3mz1RvLy;
        Tue,  4 Oct 2022 22:04:19 -0700 (PDT)
Message-ID: <64c8beb8-ddb1-c86c-c6c6-aea93776f619@opensource.wdc.com>
Date:   Wed, 5 Oct 2022 14:04:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 4/6] null_blk: initialize cmd->bio in __alloc_cmd()
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, shinichiro.kawasaki@wdc.com,
        vincent.fu@samsung.com, yukuai3@huawei.com
References: <20221005031701.79077-1-kch@nvidia.com>
 <20221005031701.79077-5-kch@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221005031701.79077-5-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/22 12:16, Chaitanya Kulkarni wrote:
> The function __alloc_cmd() is responsible to allocate tag and
> initializae the different members of the null_cmd structure e.g.
> cmd->tag, cmd->error, and cmd->nq, Move only member bio that is initialized
> from alloc_cmd() into __alloc_cmd().
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/block/null_blk/main.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index b82c2ffeb086..765c1ca0edf5 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -743,7 +743,7 @@ static void free_cmd(struct nullb_cmd *cmd)
>  
>  static enum hrtimer_restart null_cmd_timer_expired(struct hrtimer *timer);
>  
> -static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
> +static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq, struct bio *bio)
>  {
>  	struct nullb_cmd *cmd;
>  	unsigned int tag;
> @@ -754,6 +754,7 @@ static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
>  		cmd->tag = tag;
>  		cmd->error = BLK_STS_OK;
>  		cmd->nq = nq;
> +		cmd->bio = bio;
>  		if (nq->dev->irqmode == NULL_IRQ_TIMER) {
>  			hrtimer_init(&cmd->timer, CLOCK_MONOTONIC,
>  				     HRTIMER_MODE_REL);
> @@ -775,11 +776,9 @@ static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, struct bio *bio)
>  		 * This avoids multiple return statements, multiple calls to
>  		 * __alloc_cmd() and a fast path call to prepare_to_wait().
>  		 */
> -		cmd = __alloc_cmd(nq);
> -		if (cmd) {
> -			cmd->bio = bio;
> +		cmd = __alloc_cmd(nq, bio);
> +		if (cmd)
>  			return cmd;
> -		}
>  		prepare_to_wait(&nq->wait, &wait, TASK_UNINTERRUPTIBLE);
>  		io_schedule();
>  		finish_wait(&nq->wait, &wait);

-- 
Damien Le Moal
Western Digital Research

