Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EE6699C75
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjBPSjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBPSi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:38:59 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D904B51D;
        Thu, 16 Feb 2023 10:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676572737; x=1708108737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0YUsWje/AVr75kqDIq2aTKdJn3ilr/9RYGzWerozeV4=;
  b=O0byJqQyRWwJmXJHHUPDnQLKOMEQQto5Rq9YO5iNc6Q0Vqr8k6bXJ9HJ
   57WzTSp0i6ZCyQK5YZYmW/Yjg7rOWc+HVn6lS/6ArUrAtGaUCG8r3G8uU
   +pMS57Ypvn9qEQTtr9ZjMYv/lbd3H88MqbSJu06NZktb3HFYf+JzFlm/f
   97e4bYWw43WAvjWBNEniq79zkHglTIAfyMABYJqGTPuqiKd09XX0LJVIv
   nlc/O/FpThQC5TsHYb/7fOssEfVE6dgGD6p/Rn9SgIlZFwT8SQaBomcpP
   +boR53xtuQozaLkKP+00O2W7BS1B6cOKL6TBGybMh2U0V1QK8MbQFxYgj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="396474691"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="396474691"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 10:38:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="647818994"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="647818994"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 16 Feb 2023 10:38:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pSj9i-007tTP-13;
        Thu, 16 Feb 2023 20:38:54 +0200
Date:   Thu, 16 Feb 2023 20:38:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] Support NVIDIA BlueField-3 pinctrl driver
Message-ID: <Y+54Prj3YiPex5lw@smile.fi.intel.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
 <acd85e20d3e8d45ce3254e6ffe5ad2b5039b1a34.1676042188.git.asmaa@nvidia.com>
 <Y+eCNEHcmo4qapcI@smile.fi.intel.com>
 <CH2PR12MB38957ADFF0519278F33E9D57D7A09@CH2PR12MB3895.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR12MB38957ADFF0519278F33E9D57D7A09@CH2PR12MB3895.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 05:50:56PM +0000, Asmaa Mnebhi wrote:
> > +config PINCTRL_MLXBF
> > +	tristate "NVIDIA BlueField-3 SoC Pinctrl driver"
> > +	depends on (MELLANOX_PLATFORM && ARM64 && ACPI)
> 
> This is wrong.
> Please make sure you cover more testing.
> Also, do you really need an ACPI dependency?
> 
> Could you please provide more details on why this is wrong? All our upstreamed drivers use the same "depends on"
> Our pinctrl driver only applies to Mellanox platforms, ARM64 and use ACPI tables.

This is wrong because it narrows down testing coverage.

Besides that you need to define functional and build dependencies separately.

ACPI probably is not what you are using in the driver. I do not believe you
have at all dependency on it.

-- 
With Best Regards,
Andy Shevchenko


