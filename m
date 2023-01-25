Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9799F67B655
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbjAYPxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbjAYPxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:53:17 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881B510AB4;
        Wed, 25 Jan 2023 07:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674661996; x=1706197996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FLRml78XzfhODs7kyj7uTIE6eGuSRqNw+7OXE6QUWkM=;
  b=gg+St4BvBSpN4wyI0kKlep30QurV4/kAjJyf4vLSUco0hWXkpsT9JYWv
   QvdP7euF0oQetybuhIxItuem0eZ17ZGpx2qyXja2q1J/Kr087AoEdMKdk
   VMy1H+pWPZyBZSsOwANMM2oy0R4aWCY9ask+7jJBBIGli9SGhgGZDdNCa
   fLM23oJaccBSQAOtlrnOBgLNxdWCH3kxzwtEkXwCVSTYQjUfHtkqx45GI
   ioo/unKdlRKosToDlRUdjQw6FQ4LWvDoqjPUhStwsSUNdUhFXjgRvXnXR
   CX3q+0hoVGe8L3GOk8sbLUbYVm8gGQ6JqflTQzv5CbNuFvsxWpljG+wmr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="388932521"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="388932521"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 07:53:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="907913698"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="907913698"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.71.142])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 07:53:13 -0800
Date:   Wed, 25 Jan 2023 07:53:11 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl: fix spelling mistakes
Message-ID: <Y9FQZ5f/7DDYzlI/@aschofie-mobl2>
References: <20230125032221.21277-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125032221.21277-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 07:22:21PM -0800, Randy Dunlap wrote:
> Correct spelling mistakes (reported by codespell).
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> ---
> v2: add corrections for other source-code spelling errors (Alison)

Thanks Randy,
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
>  drivers/cxl/Kconfig       |    2 +-
>  drivers/cxl/acpi.c        |    2 +-
>  drivers/cxl/core/port.c   |    2 +-
>  drivers/cxl/core/region.c |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff -- a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -116,7 +116,7 @@ config CXL_REGION_INVALIDATION_TEST
>  	depends on CXL_REGION
>  	help
>  	  CXL Region management and security operations potentially invalidate
> -	  the content of CPU caches without notifiying those caches to
> +	  the content of CPU caches without notifying those caches to
>  	  invalidate the affected cachelines. The CXL Region driver attempts
>  	  to invalidate caches when those events occur.  If that invalidation
>  	  fails the region will fail to enable.  Reasons for cache
> diff -- a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -19,7 +19,7 @@ struct cxl_cxims_data {
>  
>  /*
>   * Find a targets entry (n) in the host bridge interleave list.
> - * CXL Specfication 3.0 Table 9-22
> + * CXL Specification 3.0 Table 9-22
>   */
>  static int cxl_xor_calc_n(u64 hpa, struct cxl_cxims_data *cximsd, int iw,
>  			  int ig)
> diff -- a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1137,7 +1137,7 @@ static struct cxl_port *find_cxl_port_at
>  }
>  
>  /*
> - * All users of grandparent() are using it to walk PCIe-like swich port
> + * All users of grandparent() are using it to walk PCIe-like switch port
>   * hierarchy. A PCIe switch is comprised of a bridge device representing the
>   * upstream switch port and N bridges representing downstream switch ports. When
>   * bridges stack the grand-parent of a downstream switch port is another
> diff -- a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -399,7 +399,7 @@ static ssize_t interleave_granularity_st
>  	 * When the host-bridge is interleaved, disallow region granularity !=
>  	 * root granularity. Regions with a granularity less than the root
>  	 * interleave result in needing multiple endpoints to support a single
> -	 * slot in the interleave (possible to suport in the future). Regions
> +	 * slot in the interleave (possible to support in the future). Regions
>  	 * with a granularity greater than the root interleave result in invalid
>  	 * DPA translations (invalid to support).
>  	 */
