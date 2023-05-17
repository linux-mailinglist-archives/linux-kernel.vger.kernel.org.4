Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02772707445
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjEQV3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjEQV3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:29:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3677EB4;
        Wed, 17 May 2023 14:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684358981; x=1715894981;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eZ74ldENADY+CWTR6k8PxDuJHdv/JJ22uNtqWxNPuV0=;
  b=BK2MC1eCFMJrdpgB8A7Qgetbq7ppI//kttTiHltacCluYW+luay4W5WV
   fM71YY6pnNpc5V1GROtXrew8B1NB+0Z+B5mDJzNe0fIwxlbvcURgiQVSb
   pP9an74bDkIe7WL7oCxXdU3aqQ0YTpTuJstKsAiTbS5VSrkvohMTWtwxt
   tQ1CBFSniiIglb6ulGMZS3+5LJwaOA1tI1noB8CFQ1j4JLMoqAyR6U3s3
   jINJFPk9rSKSrWt6Y3wmv+UoUPeoP4Ik7ms20JgA3TF53Z/uaaqIqV4hY
   N1vVd4to/egDVEvdPvhOMxUdpVgNKgss7+Clve1xbmib1gaMPydxAbKZc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="417543691"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="417543691"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 14:29:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="704962201"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="704962201"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.83.61]) ([10.212.83.61])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 14:29:35 -0700
Message-ID: <f09f9c9d-09d2-72bd-6892-4a7e80a37b49@intel.com>
Date:   Wed, 17 May 2023 14:29:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] MAINTAINERS: Add additional reviewers for CXL
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230426-cxl-fixes-v1-0-870c4c8b463a@intel.com>
 <20230426-cxl-fixes-v1-1-870c4c8b463a@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230426-cxl-fixes-v1-1-870c4c8b463a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/23 2:28 PM, Ira Weiny wrote:
> To get better coverage add Dave Jiang and Jonathan Cameron as reviewers.
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90abe83c02f3..6f8568ec2731 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5169,6 +5169,8 @@ M:	Vishal Verma <vishal.l.verma@intel.com>
>   M:	Ira Weiny <ira.weiny@intel.com>
>   M:	Ben Widawsky <bwidawsk@kernel.org>
>   M:	Dan Williams <dan.j.williams@intel.com>
> +R:	Dave Jiang <dave.jiang@intel.com>
> +R:	Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>   L:	linux-cxl@vger.kernel.org
>   S:	Maintained
>   F:	drivers/cxl/
> 
