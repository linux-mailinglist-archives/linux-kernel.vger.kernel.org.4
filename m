Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525555E6CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiIVUXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiIVUXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:23:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44781110EE3;
        Thu, 22 Sep 2022 13:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663878179; x=1695414179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OFzLjRJCU6cKjDYxboR7rQMxdY3lYv9nZojoR5dDW9A=;
  b=mJ+qLuXixye9ljY6AZVoNXbJduXtszhYNO9LQgrL/+RZDyliO+fn38R8
   BpISZCWis1VyAaE+Ivcduos5vtwKXJdN10tp/SKhsu9S6E8ParX+0Cf96
   Zh5ddpKM8UE5O/EzL6RLFz8mmuKYyOaNu93QpIZ33+0YfGDk3MIUda16w
   Ep9UoQ+V5hsn7axpov/5Grd4LojTG9GmC1Jj2l0P0jlgjKD+I8JN4IFYk
   48wDY7RXqNHnJkfcHcpbZT8srPHvjK0dHpTssuXKpEoAxKGmFJ4v1jCLN
   KnhtNfjb3CwkFgsGeGKx/LFPIxlO3iSepr5qSUBUfhy2W97DZ3iGOsncI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="280790917"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="280790917"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:22:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="762350047"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:22:57 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id C7F462007A;
        Thu, 22 Sep 2022 23:22:54 +0300 (EEST)
Date:   Thu, 22 Sep 2022 20:22:54 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] device property: Add const qualifier to
 device_get_match_data() parameter
Message-ID: <YyzEHk2TTcsIO0ha@paasikivi.fi.intel.com>
References: <20220922135410.49694-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922135410.49694-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for cc'ing me.

On Thu, Sep 22, 2022 at 04:54:10PM +0300, Andy Shevchenko wrote:
> Add const qualifier to the device_get_match_data() parameter.
> Some of the future users may utilize this function without
> forcing the type.

From const to non-const? This is what this patch does, right?

> 
> All the same, dev_fwnode() may be used with a const qualifier.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/property.c  | 4 ++--
>  include/linux/property.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index ed6f449f8e5c..4d6278a84868 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -17,7 +17,7 @@
>  #include <linux/property.h>
>  #include <linux/phy.h>
>  
> -struct fwnode_handle *dev_fwnode(struct device *dev)
> +struct fwnode_handle *dev_fwnode(const struct device *dev)

If you have const struct device pointer, then the embedded fwnode handle in
that object sure is const, too. Isn't it?

If you really have const struct device pointer (where do you?), then I'd
suggest to add another function, dev_fwnode_const() that is otherwise the
same except the argument as well as the return value are const.

Or alternatively define it as a macro and use _Generic()?

>  {
>  	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
>  		of_fwnode_handle(dev->of_node) : dev->fwnode;
> @@ -1200,7 +1200,7 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>  }
>  EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
>  
> -const void *device_get_match_data(struct device *dev)
> +const void *device_get_match_data(const struct device *dev)
>  {
>  	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
>  }
> diff --git a/include/linux/property.h b/include/linux/property.h
> index a5b429d623f6..117cc200c656 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -32,7 +32,7 @@ enum dev_dma_attr {
>  	DEV_DMA_COHERENT,
>  };
>  
> -struct fwnode_handle *dev_fwnode(struct device *dev);
> +struct fwnode_handle *dev_fwnode(const struct device *dev);
>  
>  bool device_property_present(struct device *dev, const char *propname);
>  int device_property_read_u8_array(struct device *dev, const char *propname,
> @@ -387,7 +387,7 @@ bool device_dma_supported(struct device *dev);
>  
>  enum dev_dma_attr device_get_dma_attr(struct device *dev);
>  
> -const void *device_get_match_data(struct device *dev);
> +const void *device_get_match_data(const struct device *dev);
>  
>  int device_get_phy_mode(struct device *dev);
>  int fwnode_get_phy_mode(struct fwnode_handle *fwnode);

-- 
Regards,

Sakari Ailus
