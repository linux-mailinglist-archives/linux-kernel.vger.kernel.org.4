Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E63C6B1917
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 03:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCICMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 21:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCICMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 21:12:47 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1BFBA87B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 18:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678327960; x=1709863960;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NuBmxgRDNL4Na0RMQuWBwVEo4HGT3XkCwSpqJn53O0w=;
  b=jXE+WbVl53RkxtPbgLHjcvRKA376jeurzt5mzOiv3/7M1ccl/JIuUDpf
   /pbPmqPj2FTHlCzluUFccLw0IsMTY6L9xsVwFPxWK9Lf24FH7fpfussyp
   x0yeBI1yRYbu2S/GOPCmwKPXmaeGucnVsWjRkQICjO+vosxUu2T4ULQ9I
   RTQ/lUS8+8zOnlf10UK4gh5M8YDM0/04Mtu7VMaIoGHn6Up89aDZlHtwf
   cHs0C+AbRUvSGbGOXW2wgctBskhrR8qf7AvQMdwNcphBn5Bi9aPqsCrXa
   bvy+tfW3JbVSBvzo5pnMeOQ7WTIEjHE02aB+WlETF2nL+w1kXqFewuE3U
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="320161057"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="320161057"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 18:11:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="766240739"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="766240739"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Mar 2023 18:11:26 -0800
Message-ID: <efa3e59b-cb93-4519-0e3f-cf94b6788765@linux.intel.com>
Date:   Thu, 9 Mar 2023 10:10:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, kernel test robot <lkp@intel.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        Timur Tabi <timur@tabi.org>,
        Varun Sethi <Varun.Sethi@freescale.com>,
        Emil Medve <Emilian.Medve@Freescale.com>
Subject: Re: [PATCH] iommu/fsl: fix all kernel-doc warnings in fsl_pamu.c
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <20230308034504.9985-1-rdunlap@infradead.org>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230308034504.9985-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 11:45 AM, Randy Dunlap wrote:
> Fix kernel-doc warnings as reported by the kernel test robot:
> 
> fsl_pamu.c:192: warning: expecting prototype for pamu_config_paace(). Prototype was for pamu_config_ppaace() instead
> fsl_pamu.c:239: warning: Function parameter or member 'omi_index' not described in 'get_ome_index'
> fsl_pamu.c:239: warning: Function parameter or member 'dev' not described in 'get_ome_index'
> fsl_pamu.c:332: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Setup operation mapping and stash destinations for QMAN and QMAN portal.
> fsl_pamu.c:361: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Setup the operation mapping table for various devices. This is a static
> 
> Fixes: 695093e38c3e ("iommu/fsl: Freescale PAMU driver and iommu implementation.")
> Fixes: cd70d4659ff3 ("iommu/fsl: Various cleanups")
> Signed-off-by: Randy Dunlap<rdunlap@infradead.org>
> Reported-by: kernel test robot<lkp@intel.com>
> Link:lore.kernel.org/r/202302281151.B1WtZvSC-lkp@intel.com
> Cc: Aditya Srivastava<yashsri421@gmail.com>
> Cc: Joerg Roedel<joro@8bytes.org>
> Cc: Will Deacon<will@kernel.org>
> Cc: Robin Murphy<robin.murphy@arm.com>
> Cc:iommu@lists.linux.dev
> Cc: Timur Tabi<timur@tabi.org>
> Cc: Varun Sethi<Varun.Sethi@freescale.com>
> Cc: Emil Medve<Emilian.Medve@Freescale.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
