Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B816F3251
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjEAOwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjEAOwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:52:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BFBE54;
        Mon,  1 May 2023 07:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682952738; x=1714488738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w1kVWQtJXHcWHK2KlJ0nuiROkNtp7Mo5xqYnEd0zssQ=;
  b=Pegpo2HvZ81b/6ODqsgO1xV4BvYW59mgmAYViIrgyZ0zAvCLjCH91Rxq
   zudwJ93k6WDm4fxXKrjsd7ovXlVt2QjTj5mzCWfmZT5Amb/NsnJd7yWDa
   4e+btSzoHq+7W0OWA07ffhsLghigYZs3eSj/ay65AYxpxRuRczzyVezI6
   144/jBgy0M2YYG28ZoNsxxGDMiU3/q8HM+kRlFTvZhPzm/MMDQzyS6H2m
   u8Y2WEYLz0vhZsInaRB8ylKzIr7Zis+mwkJL8ObohZx52zkCZilhSxHtt
   m7KiU8zljzDhKj3XlHXDEWU69FpBZ5EBlPg/T7LpYQlclyVV71aXJblsc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="434474055"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="434474055"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 07:52:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="765326926"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="765326926"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.85.208]) ([10.212.85.208])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 07:52:17 -0700
Message-ID: <0d232ddc-446c-bfca-71f4-51182356e974@intel.com>
Date:   Mon, 1 May 2023 07:52:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] cxl/mbox: Remove redundant dev_err() after failed
 mem alloc
Content-Language: en-US
To:     Raghu H <raghuhack78@gmail.com>, linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20230428012235.119333-1-raghuhack78@gmail.com>
 <20230428012235.119333-2-raghuhack78@gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230428012235.119333-2-raghuhack78@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/23 6:22 PM, Raghu H wrote:
> Issue found with checkpatch
> 
> A return of errno should be good enough if the memory allocation fails,
> the error message here is redundatant as per the coding style, removing it.
> 
> Signed-off-by: Raghu H <raghuhack78@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/mbox.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f2addb457172..11ea145b4b1f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1112,10 +1112,8 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>   	struct cxl_dev_state *cxlds;
>   
>   	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
> -	if (!cxlds) {
> -		dev_err(dev, "No memory available\n");
> +	if (!cxlds)
>   		return ERR_PTR(-ENOMEM);
> -	}
>   
>   	mutex_init(&cxlds->mbox_mutex);
>   	mutex_init(&cxlds->event.log_lock);
