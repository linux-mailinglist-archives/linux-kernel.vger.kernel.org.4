Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0DE71EFB5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjFAQwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjFAQw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:52:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113411AB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685638321; x=1717174321;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pm4VUQyubQxYWLZEuh6qnK28OPDj9UxOI+MeZtmOfaI=;
  b=FxxQv6iWb+LfUv3Lj7pouwAPRgAh8X9n82AktTBH5ZzoufI3S2Ok2Z+5
   kpnvI1J/3kkBuHkVzun4NlO/MZ85ThwpFL+rme0vsuzXPY1FqATeMw67Z
   8YJjdsJ6jM0z++R8h/8ElaCQYLrhM2yEbTAUiQMA3fw4FDcpdc4Etv5iB
   fHBkCOsdfYRLzX+fTvbJHU4z3dliWfQzbDaKe1AOjpYfcBTQBBte2ZyFl
   0+qr8yc5/nsDF4F6yKPoQIxHYptM4uUtgdNiu3Vvvek8/NDWI7hQSG68J
   OMGGEm8McpnVSRB9PaqXiLyo/425nWdAB/LAzZ1ZYuuiEH+x+BwYTOrZg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421426880"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="421426880"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:51:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="777283282"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="777283282"
Received: from rcelisco-mobl.amr.corp.intel.com (HELO [10.212.207.82]) ([10.212.207.82])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:51:56 -0700
Message-ID: <d9bbf549-7ee3-1f8f-ad66-75350a5baf52@linux.intel.com>
Date:   Thu, 1 Jun 2023 11:39:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] soundwire: bandwidth allocation: Remove pointless
 variable
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230601161622.1808135-1-ckeepax@opensource.cirrus.com>
 <20230601161622.1808135-2-ckeepax@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230601161622.1808135-2-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/23 11:16, Charles Keepax wrote:
> The block_offset variable in _sdw_compute_port_params adds nothing
> either functionally or in terms of code clarity, remove it.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

This one is easy enough, thanks!

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/generic_bandwidth_allocation.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
> index 325c475b6a66d..31162f2b56381 100644
> --- a/drivers/soundwire/generic_bandwidth_allocation.c
> +++ b/drivers/soundwire/generic_bandwidth_allocation.c
> @@ -139,20 +139,16 @@ static void _sdw_compute_port_params(struct sdw_bus *bus,
>  {
>  	struct sdw_master_runtime *m_rt;
>  	int hstop = bus->params.col - 1;
> -	int block_offset, port_bo, i;
> +	int port_bo, i;
>  
>  	/* Run loop for all groups to compute transport parameters */
>  	for (i = 0; i < count; i++) {
>  		port_bo = 1;
> -		block_offset = 1;
>  
>  		list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
> -			sdw_compute_master_ports(m_rt, &params[i],
> -						 port_bo, hstop);
> +			sdw_compute_master_ports(m_rt, &params[i], port_bo, hstop);
>  
> -			block_offset += m_rt->ch_count *
> -					m_rt->stream->params.bps;
> -			port_bo = block_offset;
> +			port_bo += m_rt->ch_count * m_rt->stream->params.bps;
>  		}
>  
>  		hstop = hstop - params[i].hwidth;
