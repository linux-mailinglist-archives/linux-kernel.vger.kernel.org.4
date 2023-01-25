Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1233267A8C2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 03:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjAYC33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 21:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjAYC31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 21:29:27 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38170E389;
        Tue, 24 Jan 2023 18:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674613767; x=1706149767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oO37RYbIuKlYJl0EDNVlFv/xTuVNyM5bIiRoYtf3uWE=;
  b=nF4Fv4dS1LaCru4QN3FyXAtIgnWLL/NUo6N6XJbuHvRv2pHMcvZ+j6Ql
   ozyN9h3Zz4+fOis6rV+9lXkzc704jvgUdtMuWEIbbmrZZwgxICP9MiMUH
   3etTJFM76yniHSFOiuX1tXYwj4JfJBPxeIf+4LE5xraxzT3WsKh47HDJQ
   4LV6YgGJyn1moWpUFsxEsAzfTPivVfGBxPQ2vtTFU4BgBYtlWY43Ty8I/
   FJeWRLfkTmmdT3A+FmW6snC/nqDn98mgucD2iN4w3RD/X6VIIiaBb+79D
   QblwCN78tv1sXS6TLTMLgkTl53JY+u9s37UnLTP1F+4azA65Y/D4iDJ/I
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="310039089"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="310039089"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 18:29:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="725717949"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="725717949"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.146.181])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 18:29:24 -0800
Date:   Tue, 24 Jan 2023 18:29:23 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl: Kconfig: fix a spelling mistake
Message-ID: <Y9CUA8VFHobacc5x@aschofie-mobl2>
References: <20230124233431.21599-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124233431.21599-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 03:34:31PM -0800, Randy Dunlap wrote:
> Correct a spelling mistake (reported by codespell).

Hi Randy,

Maybe you were just interested in Kconfig's, but while you're
in here, would you mind correcting a few more:

drivers/cxl/
./acpi.c:22: Specfication ==> Specification
./core/port.c:1140: swich ==> switch
./core/region.c:402: suport ==> support

Thanks,
Alison

> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> ---
>  drivers/cxl/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
