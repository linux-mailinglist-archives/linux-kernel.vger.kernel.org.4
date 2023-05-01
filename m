Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64F66F3254
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjEAOx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjEAOxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:53:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0C810FC;
        Mon,  1 May 2023 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682952785; x=1714488785;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eK08VlhbMvavR7mKJ5uIKLoVViksnz0G9VSv4u8dCXk=;
  b=iX4V1P7jocVVv1R44EYnfZfywREzCrk/laagPr2X3fqH7MHrH20n/9Nx
   mLMNgv30F17bfcstIxtbWhrN0fCfKaCBbXrv+8eMW1u3iTKTy+RclljBH
   4G2/PaMplLsEFZYpDImJG9dGS1ZHgKiZL0NV2nFcTPObSlxm4w2IUCRUt
   iw0mK1u3ifwOZuEV4E+DXkmaNN/9zFqZKql/xIhsrJdp/uuGvxHZkHpDN
   A237/Y/rZ5bYzrqOTw8Xj33Im+d+CdmfyEk2u4pplrrwZvNxNQPNQWAeQ
   hyikF2DT0FiOeX6YMArDtYw7K/+LHVwuKCn/tGoMrqzXXZsn0pozHK+Vb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="434474123"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="434474123"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 07:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="765326986"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="765326986"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.85.208]) ([10.212.85.208])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 07:53:04 -0700
Message-ID: <da1dad4b-cdee-76e3-a3eb-cb39b6ee1423@intel.com>
Date:   Mon, 1 May 2023 07:53:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] cxl/region: Remove else after return statement
Content-Language: en-US
To:     Raghu H <raghuhack78@gmail.com>, linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20230428012235.119333-1-raghuhack78@gmail.com>
 <20230428012235.119333-3-raghuhack78@gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230428012235.119333-3-raghuhack78@gmail.com>
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
> The else section here is redundant after return statement, removing it.
> Sanity and correctness is not affected due to this fix.
> 
> Signed-off-by: Raghu H <raghuhack78@gmail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/region.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f29028148806..a46d6ad9ef0a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2666,11 +2666,11 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>   				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
>   			clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
>   			return 0;
> -		} else {
> -			dev_err(&cxlr->dev,
> -				"Failed to synchronize CPU cache state\n");
> -			return -ENXIO;
>   		}
> +
> +		dev_err(&cxlr->dev,
> +			"Failed to synchronize CPU cache state\n");
> +		return -ENXIO;
>   	}
>   
>   	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
