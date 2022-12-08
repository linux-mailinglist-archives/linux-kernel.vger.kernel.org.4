Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4899F6465DA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 01:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiLHA1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 19:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLHA1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:27:23 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082B08D660;
        Wed,  7 Dec 2022 16:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670459240; x=1701995240;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KYJ6hcVvIO5vkbtqYrNEba4eRn5+x3iA1yRBVGIoUEg=;
  b=VCubSR482i489g00PPvZYPCMPi5sGWnBILwkM8WkRxmCILbJsxdZHKdm
   D1Peg26t1TJJquW6NZNUfHMr5+yfgsoctyA+95TWO53mxoQ67fge1nvLB
   vuf3qqOYz52mAiTuQ9v/RDZb48C2xdOQK4hUXx2pNE2zqJLRrHb9cyiaZ
   GwRPgQokl3qdBEwS1plqyVsObLkq2WDiQYuO0btT1zGeRbUeD/GGmyy2B
   D5xh6NiYj8OoteAEFDdivRP720gbljn4fwrw9jUG0EENAHPUxozea4naO
   ZLMGSoUrGEIYEdG2gy6s0jTMdu3Q2+hozamgiCQUCrwennaAR2l6zOaib
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="296729925"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="296729925"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 16:27:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="892009688"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="892009688"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.93.88]) ([10.212.93.88])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 16:27:19 -0800
Message-ID: <4d75c340-0942-44cf-67db-ee52f58ee65e@intel.com>
Date:   Wed, 7 Dec 2022 17:27:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH] cxl/uapi: Add warning on CXL command enum
Content-Language: en-US
To:     ira.weiny@intel.com, Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221208000141.701642-1-ira.weiny@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221208000141.701642-1-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/2022 5:01 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The CXL command enum is exported to user space and must maintain
> backwards compatibility.
> 
> Add comment that new defines must be added to the end of the list.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   include/uapi/linux/cxl_mem.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index c71021a2a9ed..459a3f7f764b 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -19,6 +19,10 @@
>   #define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
>   #define CXL_MEM_SEND_COMMAND _IOWR(0xCE, 2, struct cxl_send_command)
>   
> +/*
> + * NOTE: New defines must be added to the end of the list to preserve
> + * compatibility because this enum is exported to user space.
> + */
>   #define CXL_CMDS                                                          \
>   	___C(INVALID, "Invalid Command"),                                 \
>   	___C(IDENTIFY, "Identify Command"),                               \
> 
> base-commit: acb704099642bc822ef2aed223a0b8db1f7ea76e
