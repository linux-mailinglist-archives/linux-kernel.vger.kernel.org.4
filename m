Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CBD6FBCCC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjEIB4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjEIB4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:56:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C784F5
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 18:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683597365; x=1715133365;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zFaFfO28Av6WuZj3Bx6g2+QHA9qzcvUC6YooF425aG8=;
  b=M4XK9pLQTdKmAZto2HuKQL+UKCjynRiHn58fP0OKynIuegWwmR/XVYaY
   A80wzmYbUE6GOoQEByUDBznWqp8DtGGq2MgYiSm+XBUR9pfmJP30PRfum
   p2WTNgWPkZDn5IWHFVimntzd/KlYfm45gfvD7aOL5f5kezJFVBE4ypwTP
   vHyCuqplJkq3nwkluMZd0zBrwqyanzUeSBnx7JeY6upSWvPDg5iMOOHHZ
   0rNMRcK0rCvnfFDeTxtI0j98ZI5gah8ypOM+ksIQ4zBtVk70tCeX4Sie0
   BuaqGcCdl/nHZuxJZRNFw3bgkMFEwjFDlhUFPeuNASz5NbVzQuBZQlF5e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="351955889"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="351955889"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 18:56:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="698715887"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="698715887"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 08 May 2023 18:56:01 -0700
Message-ID: <e0a570c3-4145-8413-cb7a-e4313819ae1b@linux.intel.com>
Date:   Tue, 9 May 2023 09:55:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
 <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com>
 <20230506150741.2e3d2dcc@jacob-builder>
 <CAHk-=wjmOAQnqJF-pW=fzMXb_Rk_J_Oi4ESBLmVPhxwBK4xfGg@mail.gmail.com>
 <20230508094014.53913cf3@jacob-builder>
 <CAHk-=wgobPe0U=Sc-PH08vF-ZbG00KrzftEpQMQ=n0LLNn7y6A@mail.gmail.com>
 <ZFkpk8y8mUZuZjkV@nvidia.com>
 <CAHk-=wiv=Dm5diw2N-4Mx3k8iYWNfyvjzrQxB3JxVLC_7cuY+g@mail.gmail.com>
 <20230508132130.5a6feb0b@jacob-builder>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230508132130.5a6feb0b@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 4:21 AM, Jacob Pan wrote:
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index db98c3f86e8c..7106f3af74ee 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -153,9 +153,13 @@ config IOMMU_DMA
>   	select IRQ_MSI_IOMMU
>   	select NEED_SG_DMA_LENGTH
>   
> +config IOMMU_MM_PASID
> +	bool
> +
>   # Shared Virtual Addressing
>   config IOMMU_SVA
>   	bool
> +	select IOMMU_MM_PASID
>   
>   config FSL_PAMU
>   	bool "Freescale IOMMU support"
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index 2e56bd79f589..b4d7bd68a911 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -50,6 +50,7 @@ config INTEL_IOMMU_SVM
>   	depends on X86_64
>   	select MMU_NOTIFIER
>   	select IOMMU_SVA
> +	select IOMMU_MM_PASID

IOMMU_SVA has already selected IOMMU_MM_PASID, so there's no need to
select it again here?

IOMMU_SVA selects IOMMU_MM_PASID, the vt-d driver itself has no need to
know about this.

>   	help
>   	  Shared Virtual Memory (SVM) provides a facility for devices
>   	  to access DMA resources through process address space by

Best regards,
baolu
