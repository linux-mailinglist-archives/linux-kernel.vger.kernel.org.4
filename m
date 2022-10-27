Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE0260ED53
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 03:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJ0BQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 21:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiJ0BQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 21:16:51 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12FA543E1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 18:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666833409; x=1698369409;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4ap/kLZ0OSB6Zuig+PaHn7p6EhgNVXfGROLAu+d2tkk=;
  b=ZLK+v79RXJ19m0p+j8boAJZ/1Jq2eAHa0O9a0gyl73GQtKXLYbGPxYvs
   /ssHb29+ZYqe/uMKWU2w0bYumgbtkPZrjwu9SjfgIm44E/34B/Zb241sV
   0a79AUIVP9mZwV4o3Xx6SB+KqtEfEIsdXtoQ6yhN6wKBqNdEfqu83WApL
   +IOSCg7VxT8mHO3witebSiQcTJNdL0N98f8KFG9x4ZIAUIrzzs13MtKKN
   UvIBLSmAEHylfwZuWkZ6yzPG5qVBKBmkml6IWD2HkP00UVkCpgUILn0KP
   rim7BdO67A0cIL2JAx7naRjhlesqOcqpYm6/NLnxOBfotFoVMBtTiKDH2
   A==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661788800"; 
   d="scan'208";a="326936994"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 09:16:48 +0800
IronPort-SDR: rFgpOuAVLYuW+eDuNHrjyOMlJAXJQ28m8g2jtzNQaisFUGZ3pq5SMh5Pg3//1bH3YunE/GAL7H
 95GRdY+uwGZmJ0Nk/frrZi9IWtLq1NuCE1m1CO/xFy+nFzklK/t+Gn/9DvJ0B30aYr/TGB5pEw
 pGYiw3nLrxINQZ2c0Yb2t54kK1p/Xw088rOsWQ2Qy1vq++s5g9eL9QFyryTFgAIppXvmmhxAmL
 qO67SZHrBnWQPpl+UVB0+AXhgqQWhUNOk38mrDMVlT5lN4+5324KAvl88FDHq+3XlJ3HFnqSKG
 ZUzO+AHy4mpv0P9cZRryPR58
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 17:30:27 -0700
IronPort-SDR: TtXaHg3hPXi3k2ZcJn2hclXayyTAMg+RZtIWjVYhaTbnEmOpx9yIQ2Qr0Cm5vBLJEojtWSWNQ4
 nhW0YddAhvbm1rJWudff6Dpz0lWOxseHOC0PFnQxAlkLFnsHE2Er9irkb5p4jQk+2Z8JVx1SN5
 0tS42Rh5eSZeICgQ8xzIhZTFHwM8cH9fLuqHEtjjd5fce7P0DdeCqJ1BFbyXI0T6aamiB/9Ggg
 olccoMvKA9Cy7XcLWvZEcRFeHadjXoSkrXm6kx0iiV3LudauULF1adIYCsAyZFDaxak5gojhGu
 6yg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 18:16:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MySSb6m8Dz1RwvT
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 18:16:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666833407; x=1669425408; bh=4ap/kLZ0OSB6Zuig+PaHn7p6EhgNVXfGROL
        Au+d2tkk=; b=cKLxzHejdmmtU3+kZrY6FomzrFFLd9xctuL5K8LMOXvpP6dfIPb
        dUyT6ATcBLj6H0FDOXG3xByzvQqRCvdjp3h5zgwlequ6W6iftbsOlv0soQCyvn9U
        THY3BsSPZ0PqGYFAm/qkc1Oh01OBxMF9h1yR6Fj0hQmnWJpJ0WncbXOheshGcGj0
        Gy5RK7U3v12OX2r9iCrbKt3gkFE9U/lCP+wdiZwafLleL3t/igYctLZ1SX3poOG9
        +YmVKo5FBAB2lK2pDOm+jYloNVRXM8fcYFLLRqKpGp/CIseI00EGF32W7Mu2YsT+
        A15NlDCOhgfy4KoN6MvdnXwyfNcyzXrFHZw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4LWMO5kkGbrR for <linux-kernel@vger.kernel.org>;
        Wed, 26 Oct 2022 18:16:47 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MySSX3v2yz1RvLy;
        Wed, 26 Oct 2022 18:16:44 -0700 (PDT)
Message-ID: <9cd8aa6a-98be-ddba-db4e-07ed59b53f08@opensource.wdc.com>
Date:   Thu, 27 Oct 2022 10:16:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 01/22] blk-mq: Don't get budget for reserved
 requests
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        jinpu.wang@cloud.ionos.com, hare@suse.de, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
 <1666693096-180008-2-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1666693096-180008-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 19:17, John Garry wrote:
> It should be possible to send reserved requests even when there is no
> budget, so don't request a budget in that case.
> 
> This comes into play when we need to allocate a reserved request from the
> target device request queue for error handling for that same device.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  block/blk-mq.c          | 4 +++-
>  drivers/scsi/scsi_lib.c | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 260adeb2e455..d8baabb32ea4 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1955,11 +1955,13 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>  	errors = queued = 0;
>  	do {
>  		struct blk_mq_queue_data bd;
> +		bool need_budget;
>  
>  		rq = list_first_entry(list, struct request, queuelist);
>  
>  		WARN_ON_ONCE(hctx != rq->mq_hctx);
> -		prep = blk_mq_prep_dispatch_rq(rq, !nr_budgets);
> +		need_budget = !nr_budgets && !blk_mq_is_reserved_rq(rq);
> +		prep = blk_mq_prep_dispatch_rq(rq, need_budget);
>  		if (prep != PREP_DISPATCH_OK)
>  			break;

Below this code, there is:

		if (nr_budgets)
			nr_budgets--;

Don't you need to change that to:

		if (need_budget && nr_budgets)
			nr_budgets--;

? Otherwise, the accounting will be off.

>  
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index fa96d3cfdfa3..39d4fd124375 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -298,7 +298,8 @@ void scsi_device_unbusy(struct scsi_device *sdev, struct scsi_cmnd *cmd)
>  	if (starget->can_queue > 0)
>  		atomic_dec(&starget->target_busy);
>  
> -	sbitmap_put(&sdev->budget_map, cmd->budget_token);
> +	if (!blk_mq_is_reserved_rq(scsi_cmd_to_rq(cmd)))
> +		sbitmap_put(&sdev->budget_map, cmd->budget_token);
>  	cmd->budget_token = -1;
>  }
>  

-- 
Damien Le Moal
Western Digital Research

