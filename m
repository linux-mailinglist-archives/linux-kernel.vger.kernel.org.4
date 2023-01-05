Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969D765E54F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 06:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjAEF66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 00:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjAEF6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 00:58:53 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D034C4F122
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 21:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672898332; x=1704434332;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=s5aaIEbbbKip1vwzbtKy2QwcpBFkECPTXwB0EP8j7fA=;
  b=MmC34wgxBubCI/Q7MGMgW9PjjMTSimZfw9T2cHIjSXuRhacuwB5Mus3o
   +FIF9+B00WE2YGKylpgiWeknWkQifkr/SjlOlDYZ97mocCuTQ+HuM2zyz
   YoRRmBmicjsKtj/8QCu5cPCLH146P1IAY0LIViYgHoIoQgdNdvYb/qeGc
   bBOZe94MF7YtXHGkYGMbdbSddJhJe1j/qolk2jTAZkxmJBdvL2KL8Sfhh
   sdk402aKhcDmfKHdC0ff8yY20fPhjx20QvQw3V7Xwyg52adqq6k99RV8O
   wXSEr8mBfKc7q/CbiR3JCW5wD5PA1X8Bi2ACJ+1m+S+ZTvqA1+bCUbPHs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="305624764"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="305624764"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 21:58:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="648810306"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="648810306"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.114]) ([10.254.211.114])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 21:58:44 -0800
Message-ID: <1ef288af-885a-f724-ea37-199f181e4937@linux.intel.com>
Date:   Thu, 5 Jan 2023 13:58:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-11-baolu.lu@linux.intel.com>
 <Y7V8bcUF5zvGvCAP@nvidia.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 10/19] iommu: Add set_platform_dma_ops iommu ops
In-Reply-To: <Y7V8bcUF5zvGvCAP@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 2023/1/4 21:17, Jason Gunthorpe wrote:
> On Wed, Jan 04, 2023 at 08:57:16PM +0800, Lu Baolu wrote:
> 
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index de91dd88705b..4e35a9f94873 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2163,6 +2163,17 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
>>   	return 0;
>>   }
>>   
>> +static int iommu_group_do_set_platform_dma(struct device *dev, void *data)
>> +{
>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>> +
>> +	if (!ops->set_platform_dma_ops)
>> +		return -EINVAL;
>> +
>> +	ops->set_platform_dma_ops(dev);
>> +	return 0;
>> +}
>> +
>>   static int __iommu_group_set_domain(struct iommu_group *group,
>>   				    struct iommu_domain *new_domain)
>>   {
>> @@ -2177,10 +2188,14 @@ static int __iommu_group_set_domain(struct iommu_group *group,
>>   	 * platform specific behavior.
>>   	 */
>>   	if (!new_domain) {
>> -		if (WARN_ON(!group->domain->ops->detach_dev))
>> -			return -EINVAL;
> This should still have the WARN_ON..
> 
> if (WARN_ON(!group->domain->ops->detach_dev && !dev_iommu_ops(dev)->set_platform_dma_ops)

This has been implicitly included in the code.

iommu_group_do_set_platform_dma() returns -EINVAL if the iommu driver
doesn't support set_platform_dma_ops (otherwise always return success).
Then, the domain->ops->detach_dev is required and a WARN_ON was there.

         if (!new_domain) {
                 ret = __iommu_group_for_each_dev(group, NULL,
                                 iommu_group_do_set_platform_dma);
                 if (ret) {
                         if (WARN_ON(!group->domain->ops->detach_dev))
                                 return -EINVAL;
                         __iommu_group_for_each_dev(group, group->domain,
                                 iommu_group_do_detach_device);
                 }
                 group->domain = NULL;
                 return 0;
         }

Perhaps I should add a comment to explain this?

--
Best regards,
baolu
