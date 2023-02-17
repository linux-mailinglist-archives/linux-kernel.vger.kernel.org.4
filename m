Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291BE69B04D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjBQQN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjBQQN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:13:26 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D5F6EB88
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676650403; x=1708186403;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r8bBM/yf3WwebfUqIrFu03yYfmoDNHRjZ6EzhZrG32o=;
  b=YLag87awuxBe7vcKedewzwld4u65nL9QzLKZxeGegBcCWycyFjHKKyfy
   8OX8GDGG9J1G5/w4yuXPWmUl29gLyhYeO3NJbRpfa9rTZPJ4on4iJJZyt
   sgFkwXmJIdSsaBvjNoMFDYw+HPRvIgo3dgmFLjO48LlA0jlSjxJmN0s2z
   B4dNKLhXZy9qcltkLX26AeJwQZBQlzi27rVckj6xtzw+eYuz/9qrQ7HwY
   bVpdrUMLAPKsPbsDKFsXhoGCoDqwPqQbV4i7tBkTjjc/g4g/Cjm+oER3n
   7ce00AjwA6pI6/9OG7Hdh1KighRb8R8gDU3unDaRZ279HYqcdm7vcf6J/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="394495429"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="394495429"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 08:13:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="672633081"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="672633081"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.187.252]) ([10.213.187.252])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 08:13:18 -0800
Message-ID: <f0d3a527-6e37-0e34-5776-ed5a1ad0da3e@intel.com>
Date:   Fri, 17 Feb 2023 09:13:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v3 4/5] iommu/ioasid: Rename INVALID_IOASID
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>
References: <20230216235951.3573059-1-jacob.jun.pan@linux.intel.com>
 <20230216235951.3573059-5-jacob.jun.pan@linux.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230216235951.3573059-5-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/23 4:59 PM, Jacob Pan wrote:
> INVALID_IOASID and IOMMU_PASID_INVALID are duplicated. Rename
> INVALID_IOASID and consolidate since we are moving away from IOASID
> infrastructure.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com> # for idxd bits
> ---
>   Documentation/x86/sva.rst   | 2 +-
>   arch/x86/kernel/traps.c     | 5 ++++-
>   drivers/dma/idxd/device.c   | 8 ++++----
>   drivers/dma/idxd/idxd.h     | 1 +
>   drivers/dma/idxd/init.c     | 2 +-
>   drivers/dma/idxd/irq.c      | 2 +-
>   drivers/iommu/intel/dmar.c  | 4 ++--
>   drivers/iommu/intel/iommu.c | 2 +-
>   drivers/iommu/intel/svm.c   | 2 +-
>   drivers/iommu/iommu-sva.c   | 2 +-
>   include/linux/ioasid.h      | 4 ----
>   include/linux/iommu.h       | 6 +++++-
>   mm/init-mm.c                | 4 ++--
>   13 files changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/x86/sva.rst b/Documentation/x86/sva.rst
> index 2e9b8b0f9a0f..33cb05005982 100644
> --- a/Documentation/x86/sva.rst
> +++ b/Documentation/x86/sva.rst
> @@ -107,7 +107,7 @@ process share the same page tables, thus the same MSR value.
>   PASID Life Cycle Management
>   ===========================
>   
> -PASID is initialized as INVALID_IOASID (-1) when a process is created.
> +PASID is initialized as IOMMU_PASID_INVALID (-1) when a process is created.
>   
>   Only processes that access SVA-capable devices need to have a PASID
>   allocated. This allocation happens when a process opens/binds an SVA-capable
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index d317dc3d06a3..d6fb03ebf548 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -40,7 +40,10 @@
>   #include <linux/io.h>
>   #include <linux/hardirq.h>
>   #include <linux/atomic.h>
> -#include <linux/ioasid.h>
> +
> +#ifdef CONFIG_IOMMU_SVA
> +#include <linux/iommu.h>
> +#endif
>   
>   #include <asm/stacktrace.h>
>   #include <asm/processor.h>
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 29dbb0f52e18..125652a8bb29 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1194,7 +1194,7 @@ static void idxd_device_set_perm_entry(struct idxd_device *idxd,
>   {
>   	union msix_perm mperm;
>   
> -	if (ie->pasid == INVALID_IOASID)
> +	if (ie->pasid == IOMMU_PASID_INVALID)
>   		return;
>   
>   	mperm.bits = 0;
> @@ -1224,7 +1224,7 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
>   	idxd_device_clear_perm_entry(idxd, ie);
>   	ie->vector = -1;
>   	ie->int_handle = INVALID_INT_HANDLE;
> -	ie->pasid = INVALID_IOASID;
> +	ie->pasid = IOMMU_PASID_INVALID;
>   }
>   
>   int idxd_wq_request_irq(struct idxd_wq *wq)
> @@ -1240,7 +1240,7 @@ int idxd_wq_request_irq(struct idxd_wq *wq)
>   
>   	ie = &wq->ie;
>   	ie->vector = pci_irq_vector(pdev, ie->id);
> -	ie->pasid = device_pasid_enabled(idxd) ? idxd->pasid : INVALID_IOASID;
> +	ie->pasid = device_pasid_enabled(idxd) ? idxd->pasid : IOMMU_PASID_INVALID;
>   	idxd_device_set_perm_entry(idxd, ie);
>   
>   	rc = request_threaded_irq(ie->vector, NULL, idxd_wq_thread, 0, "idxd-portal", ie);
> @@ -1265,7 +1265,7 @@ int idxd_wq_request_irq(struct idxd_wq *wq)
>   	free_irq(ie->vector, ie);
>   err_irq:
>   	idxd_device_clear_perm_entry(idxd, ie);
> -	ie->pasid = INVALID_IOASID;
> +	ie->pasid = IOMMU_PASID_INVALID;
>   	return rc;
>   }
>   
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 7ced8d283d98..417e602a46b6 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -13,6 +13,7 @@
>   #include <linux/ioasid.h>
>   #include <linux/bitmap.h>
>   #include <linux/perf_event.h>
> +#include <linux/iommu.h>
>   #include <uapi/linux/idxd.h>
>   #include "registers.h"
>   
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 529ea09c9094..f30eef701970 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -105,7 +105,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
>   		ie = idxd_get_ie(idxd, msix_idx);
>   		ie->id = msix_idx;
>   		ie->int_handle = INVALID_INT_HANDLE;
> -		ie->pasid = INVALID_IOASID;
> +		ie->pasid = IOMMU_PASID_INVALID;
>   
>   		spin_lock_init(&ie->list_lock);
>   		init_llist_head(&ie->pending_llist);
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index aa314ebec587..242f1f0b9f09 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -80,7 +80,7 @@ static void idxd_int_handle_revoke_drain(struct idxd_irq_entry *ie)
>   	desc.opcode = DSA_OPCODE_DRAIN;
>   	desc.priv = 1;
>   
> -	if (ie->pasid != INVALID_IOASID)
> +	if (ie->pasid != IOMMU_PASID_INVALID)
>   		desc.pasid = ie->pasid;
>   	desc.int_handle = ie->int_handle;
>   	portal = idxd_wq_portal_addr(wq);
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index bf0bfe5ba7a7..c567f94b66c7 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1933,7 +1933,7 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
>   		return 0;
>   	}
>   
> -	if (pasid == INVALID_IOASID)
> +	if (pasid == IOMMU_PASID_INVALID)
>   		pr_err("[%s NO_PASID] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
>   		       type ? "DMA Read" : "DMA Write",
>   		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
> @@ -2014,7 +2014,7 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
>   		if (!ratelimited)
>   			/* Using pasid -1 if pasid is not present */
>   			dmar_fault_do_one(iommu, type, fault_reason,
> -					  pasid_present ? pasid : INVALID_IOASID,
> +					  pasid_present ? pasid : IOMMU_PASID_INVALID,
>   					  source_id, guest_addr);
>   
>   		fault_index++;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index a295e80fdfe8..10f657828d3a 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -876,7 +876,7 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>   		return;
>   	}
>   	/* For request-without-pasid, get the pasid from context entry */
> -	if (intel_iommu_sm && pasid == INVALID_IOASID)
> +	if (intel_iommu_sm && pasid == IOMMU_PASID_INVALID)
>   		pasid = PASID_RID2PASID;
>   
>   	dir_index = pasid >> PASID_PDE_SHIFT;
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index c76b66263467..be98af2fce06 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -274,7 +274,7 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
>   	if (WARN_ON(!mutex_is_locked(&pasid_mutex)))
>   		return -EINVAL;
>   
> -	if (pasid == INVALID_IOASID || pasid >= PASID_MAX)
> +	if (pasid == IOMMU_PASID_INVALID || pasid >= PASID_MAX)
>   		return -EINVAL;
>   
>   	svm = pasid_private_find(pasid);
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 17821ad5bf9b..1f1b4d680ede 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -41,7 +41,7 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
>   
>   void mm_pasid_init(struct mm_struct *mm)
>   {
> -	mm->pasid = INVALID_IOASID;
> +	mm->pasid = IOMMU_PASID_INVALID;
>   }
>   
>   /* Associate a PASID with an mm_struct: */
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index af1c9d62e642..9ef22552376c 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -40,10 +40,6 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>   int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>   void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>   int ioasid_set_data(ioasid_t ioasid, void *data);
> -static inline bool pasid_valid(ioasid_t ioasid)
> -{
> -	return ioasid != INVALID_IOASID;
> -}
>   
>   #else /* !CONFIG_IOASID */
>   static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 46e1347bfa22..f04d3f05784a 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -193,7 +193,11 @@ enum iommu_dev_features {
>   };
>   
>   #define IOMMU_PASID_INVALID	(-1U)
> -
> +typedef unsigned int ioasid_t;
> +static inline bool pasid_valid(ioasid_t ioasid)
> +{
> +	return ioasid != IOMMU_PASID_INVALID;
> +}
>   #ifdef CONFIG_IOMMU_API
>   
>   /**
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index c9327abb771c..a084039f55d8 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -10,7 +10,7 @@
>   
>   #include <linux/atomic.h>
>   #include <linux/user_namespace.h>
> -#include <linux/ioasid.h>
> +#include <linux/iommu.h>
>   #include <asm/mmu.h>
>   
>   #ifndef INIT_MM_CONTEXT
> @@ -40,7 +40,7 @@ struct mm_struct init_mm = {
>   	.user_ns	= &init_user_ns,
>   	.cpu_bitmap	= CPU_BITS_NONE,
>   #ifdef CONFIG_IOMMU_SVA
> -	.pasid		= INVALID_IOASID,
> +	.pasid		= IOMMU_PASID_INVALID,
>   #endif
>   	INIT_MM_CONTEXT(init_mm)
>   };
