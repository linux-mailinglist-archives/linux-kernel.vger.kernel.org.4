Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DDC732518
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240284AbjFPCQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 22:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240288AbjFPCQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:16:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E78296B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 19:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686881766; x=1718417766;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fU0lLudBphp5iZvj7Ivutn5Srt0z2bVmbg0LGVBVbGM=;
  b=Y7YSkg2c/IlI2yB2Wk7f+sNvM8/g4tzw0qx9UGyoUr/yPyqrOiOld7dD
   nofPb6yQNO7YKoKjFYMTZbeuMblbhLnmfZmYBgw2H+4YpfFlBjOf0rN5o
   WC6i5dhbTGT8+cGwkvXRhUtQpBqyW1wdSe3E56hKb2hXOjEs2A8yKdojm
   e5/M6TfX8/+JahinRJVTv7Ov7RH2O6LYyYbfyrUaqhucsRg53XxZhMzcL
   6Bz43pvUJUQKUrqL5z2LnlgmI4ldXNu94Z9WHPhWGlBwRBxL9bnzwzoCQ
   iZJvKUF7xi5P7D9meDCnKnRDRTIaYRZ1mHl4HWLjk532Egfpnd8MlCIbD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343833750"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="343833750"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 19:16:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="1042909682"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="1042909682"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2023 19:16:03 -0700
Message-ID: <ecdf9b68-ed90-9d8b-12e8-46e77c456890@linux.intel.com>
Date:   Fri, 16 Jun 2023 10:14:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Venkata Rao Kakani <quic_vkakani@quicinc.com>,
        Vagdhan Kumar <quic_vagdhank@quicinc.com>
Subject: Re: [PATCH] iommu: export iommu_set_default_translated function
Content-Language: en-US
To:     Anvesh Jain P <quic_ajainp@quicinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20230615093308.24989-1-quic_ajainp@quicinc.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230615093308.24989-1-quic_ajainp@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 5:33 PM, Anvesh Jain P wrote:
> export iommu_set_default_translated function to be used by other modules.
> 
> Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
> Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>
> Signed-off-by: Vagdhan Kumar <quic_vagdhank@quicinc.com>
> ---
>   drivers/iommu/iommu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f1dcfa3f1a1b..1b4a5db58d66 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2730,6 +2730,7 @@ void iommu_set_default_translated(bool cmd_line)
>   		iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
>   	iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>   }
> +EXPORT_SYMBOL_GPL(iommu_set_default_translated);

Exporting a symbol without using it is meaningless. It is better to
export and use it in a single series.

Additionally, there is a restriction on the use of this helper. Calling
it after the iommu probe has no effect.

>   
>   bool iommu_default_passthrough(void)
>   {
> 
> base-commit: b6dad5178ceaf23f369c3711062ce1f2afc33644

Best regards,
baolu
