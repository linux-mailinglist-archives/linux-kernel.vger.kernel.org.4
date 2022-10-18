Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD6B602051
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiJRBVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJRBVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:21:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B538B9580;
        Mon, 17 Oct 2022 18:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666056062; x=1697592062;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=su5zkI72C0sQs7FAa4bTuhB/QJ0TTUO44k56XMq6UHE=;
  b=k44ZMY7j2nykHe93Nnkox6z+NI6hlmnTWmuRkU11Bqn0oU2oLMzBpSI4
   pVfe+/dz9o5PmABrWa7ekOhgUy+C0geVpjReeEdKgDF3NoiJ+0TBefC/9
   uPvR9Ke0PuuSpfpEJ+pyRJAVtWqJ+1qPwxBo6KoRqqhc8FyP4lSNaUMnc
   Ev9BVPagLLSSTq3dgCnG27/1yZqxnnEuB+MQ9nXkE9wFoR+vpo0YP1oLe
   4MI3b5YCpHfeYIvqtH30ONV5pPdUwgNpN0nEjRcmA5hnvx70/vcA7QTqR
   FceuzhrD9XU7EIXBJQ8o+3YaR/Y1be8wWMwq86ZIOfH5qgeXWbOWnd3TW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="367991493"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="367991493"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 18:21:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="659576177"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="659576177"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.49]) ([10.254.211.49])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 18:20:54 -0700
Message-ID: <a7c55d04-2523-e6d5-8715-0f8a6d3e3233@linux.intel.com>
Date:   Tue, 18 Oct 2022 09:20:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Cc:     baolu.lu@linux.intel.com, jgg@nvidia.com, kevin.tian@intel.com,
        quic_jjohnson@quicinc.com, suravee.suthikulpanit@amd.com,
        robdclark@gmail.com, dwmw2@infradead.org, yong.wu@mediatek.com,
        matthias.bgg@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
        jean-philippe@linaro.org, tglx@linutronix.de,
        shameerali.kolothum.thodi@huawei.com,
        christophe.jaillet@wanadoo.fr, yangyicong@hisilicon.com,
        yangyingliang@huawei.com, quic_saipraka@quicinc.com,
        jon@solid-run.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v7 2/5] iommu: Add return value rules to attach_dev op and
 APIs
To:     Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com
References: <cover.1666042872.git.nicolinc@nvidia.com>
 <bd56d93c18621104a0fa1b0de31e9b760b81b769.1666042872.git.nicolinc@nvidia.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <bd56d93c18621104a0fa1b0de31e9b760b81b769.1666042872.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/18 7:01, Nicolin Chen wrote:
> Cases like VFIO wish to attach a device to an existing domain that was
> not allocated specifically from the device. This raises a condition
> where the IOMMU driver can fail the domain attach because the domain and
> device are incompatible with each other.
> 
> This is a soft failure that can be resolved by using a different domain.
> 
> Provide a dedicated errno EINVAL from the IOMMU driver during attach that
> the reason why the attach failed is because of domain incompatibility.
> 
> VFIO can use this to know that the attach is a soft failure and it should
> continue searching. Otherwise, the attach will be a hard failure and VFIO
> will return the code to userspace.
> 
> Update kdocs to add rules of return value to the attach_dev op and APIs.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 24 ++++++++++++++++++++++++
>   include/linux/iommu.h | 12 ++++++++++++
>   2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4893c2429ca5..3c0c5d64bb50 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1949,6 +1949,18 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>   	return ret;
>   }
>   
> +/**
> + * iommu_attach_device - Attach an IOMMU domain to a device
> + * @domain: IOMMU domain to attach
> + * @dev: Device that will be attached
> + *
> + * Returns 0 on success and error code on failure
> + *
> + * Note that EINVAL can be treated as a soft failure, indicating
> + * that certain configuration of the domain is incompatible with
> + * the device. In this case attaching a different domain to the
> + * device may succeed.
> + */
>   int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>   {
>   	struct iommu_group *group;
> @@ -2075,6 +2087,18 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>   	return ret;
>   }
>   
> +/**
> + * iommu_attach_group - Attach an IOMMU domain to an IOMMU group
> + * @domain: IOMMU domain to attach
> + * @group: IOMMU group that will be attached
> + *
> + * Returns 0 on success and error code on failure
> + *
> + * Note that EINVAL can be treated as a soft failure, indicating
> + * that certain configuration of the domain is incompatible with
> + * the group. In this case attaching a different domain to the
> + * group may succeed.
> + */
>   int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
>   {
>   	int ret;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a325532aeab5..6f3569340e8a 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -266,6 +266,18 @@ struct iommu_ops {
>   /**
>    * struct iommu_domain_ops - domain specific operations
>    * @attach_dev: attach an iommu domain to a device
> + *  Return:
> + * * 0		- success
> + * * EINVAL	- can indicate that device and domain are incompatible due to
> + *		  some previous configuration of the domain, in which case the
> + *		  driver shouldn't log an error, since it is legitimate for a
> + *		  caller to test reuse of existing domains. Otherwise, it may
> + *		  still represent some other fundamental problem
> + * * ENOMEM	- out of memory
> + * * ENOSPC	- non-ENOMEM type of resource allocation failures
> + * * EBUSY	- device is attached to a domain and cannot be changed
> + * * ENODEV	- device specific errors, not able to be attached
> + * * <others>	- treated as ENODEV by the caller. Use is discouraged
>    * @detach_dev: detach an iommu domain from a device
>    * @map: map a physically contiguous memory region to an iommu domain
>    * @map_pages: map a physically contiguous set of pages of the same size to

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
