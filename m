Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDBF69B0E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjBQQ36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjBQQ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:29:53 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6F87095F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676651359; x=1708187359;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WqzXDxoShDpdbm4A3JDCwL+WgDDdcPspdLN0ZTbEwDo=;
  b=ft2SDCgw9DcBYt8mrss6q0yNgNscX7EFcWdLuTG0H3fqrQ0+gqferLmG
   Yq44EKORhqSR+052ToCFS5pAnKqcWZW0V/ZTAoaDdwe1VHeNTKqEpXxQc
   z4de/lMmdfSr+/Fulhzu7UYRAMCV6HlmefYTNQpTIw8BZ/K+vIl84aFg3
   VIle24HX56O9oUtfJ6PWBoTuzPTcuUpbcl1vl7vWGT0tWkpizgZZk0j7U
   NnBHE8e0zIL+p5f0C7bG0+OrjNxa0hiRctZyTcvhL4uaA41JzLFm4xadE
   BF4Wai6tfFyyK3z73MAU4qt7wgteVQV/ObFzxZaDCXaA3zW95Bl5UepEt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="320129359"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="320129359"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 08:28:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="999493226"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="999493226"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 08:28:58 -0800
Date:   Fri, 17 Feb 2023 08:32:40 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 4/5] iommu/ioasid: Rename INVALID_IOASID
Message-ID: <20230217083240.147d2c76@jacob-builder>
In-Reply-To: <25fbbc7f-f137-c2c4-ddf8-d143fce1dcc5@intel.com>
References: <20230216235951.3573059-1-jacob.jun.pan@linux.intel.com>
        <20230216235951.3573059-5-jacob.jun.pan@linux.intel.com>
        <25fbbc7f-f137-c2c4-ddf8-d143fce1dcc5@intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On Thu, 16 Feb 2023 17:23:15 -0800, Fenghua Yu <fenghua.yu@intel.com> wrote:

> > --- a/drivers/dma/idxd/irq.c
> > +++ b/drivers/dma/idxd/irq.c
> > @@ -80,7 +80,7 @@ static void idxd_int_handle_revoke_drain(struct
> > idxd_irq_entry *ie) desc.opcode = DSA_OPCODE_DRAIN;
> >   	desc.priv = 1;
> >   
> > -	if (ie->pasid != INVALID_IOASID)
> > +	if (ie->pasid != IOMMU_PASID_INVALID)  
> 
> It's better to change to:
> +	if (pasid_valid(ie->paid))
> 
> If pasid_vaild() is called, any invalid PASID value change in the future 
> will be hidden in pasid_valid() and won't impact this code any more.
> 
> And checking pasid_valid() is more readable and meaninful than direct 
> checking the invalid PASID value.
Sounds good, here I'm just renaming. I will submit another patch to
convert.

Thanks,

Jacob
