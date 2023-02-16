Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A2E699CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBPSyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBPSx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:53:59 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E9E4AFCF;
        Thu, 16 Feb 2023 10:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676573638; x=1708109638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n+4m1AfZ7XShRrXYbLgcVYw8/NfoE4C2R9srLhnH+Qk=;
  b=B0JEDqoqMlIKr9bWqdgQvnY4j9K2YkPGD3B7SlPzViy2Nv81z6X1AMag
   cgtd8LXp0TdbHWmvArFUTkx9m/go9exKVQrG2PbnAZtocrZIuSVvhYjzn
   2DcYak8OnzcwnAMQmtXYUmBqfek5/9MoWyejCLWFTseSFr/y7iquDXW/e
   KXjMFUMZTKLvCHubfQu3DLGEE10KnmCp8Do1eyjIHFXjR275ZGVUCI3xe
   Iaqa6CyHHn5GHNfaXaBEBjwOWyeErsXdUHLiookacOqVQUaI8OKnKmHZg
   Q4jjinCb7f2EO6XOmrhCXMIU5Y/yY31YKRrxfcVTAGww9RCTcG9j8se7x
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="312172038"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="312172038"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 10:53:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="672297585"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="672297585"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 16 Feb 2023 10:53:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pSjOD-007tjs-33;
        Thu, 16 Feb 2023 20:53:53 +0200
Date:   Thu, 16 Feb 2023 20:53:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] Support NVIDIA BlueField-3 pinctrl driver
Message-ID: <Y+57wasEo/CLHakK@smile.fi.intel.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
 <acd85e20d3e8d45ce3254e6ffe5ad2b5039b1a34.1676042188.git.asmaa@nvidia.com>
 <Y+eCNEHcmo4qapcI@smile.fi.intel.com>
 <CH2PR12MB38957ADFF0519278F33E9D57D7A09@CH2PR12MB3895.namprd12.prod.outlook.com>
 <Y+54Prj3YiPex5lw@smile.fi.intel.com>
 <CH2PR12MB3895DCD7B2D54B2228CA8F24D7A09@CH2PR12MB3895.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR12MB3895DCD7B2D54B2228CA8F24D7A09@CH2PR12MB3895.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 06:44:58PM +0000, Asmaa Mnebhi wrote:
> > > +config PINCTRL_MLXBF
> > > +	tristate "NVIDIA BlueField-3 SoC Pinctrl driver"
> > > +	depends on (MELLANOX_PLATFORM && ARM64 && ACPI)
> > 
> > This is wrong.
> > Please make sure you cover more testing.
> > Also, do you really need an ACPI dependency?
> > 
> > Could you please provide more details on why this is wrong? All our
> > upstreamed drivers use the same "depends on" Our pinctrl driver only
> > applies to Mellanox platforms, ARM64 and use ACPI tables.
> 
> This is wrong because it narrows down testing coverage.
> 
> Besides that you need to define functional and build dependencies separately.
> 
> ACPI probably is not what you are using in the driver. I do not believe you
> have at all dependency on it.
> 
> Noted, I will define function and build dependencies separately.
> We have our own custom UEFI for BlueField SoCs so ACPI tables are our only
> options (for users/customer etc... as well)

I understand that, but I'm pretty sure that driver can be compiled with ACPI=n
which is good for testing coverage.

-- 
With Best Regards,
Andy Shevchenko


