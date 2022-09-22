Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1FC5E6617
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiIVOoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiIVOoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:44:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63FD857C2;
        Thu, 22 Sep 2022 07:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663857862; x=1695393862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KjPjANkLllDlBkaG+Gla8NEhlVvc72QOTw89sdo6Spc=;
  b=cuHehpl9X72hbSny97q38w1xcQcdnUGVl4a866MQbDeZLgJ2fZMHYQMt
   skOKjElnXMXgOkXOkh4QWcWPLZYpWz5iZM3zOBj63mDkRF4icHtELuaSQ
   XtarFEI0CSNeO/xMwGFKRkVkwg+TgyRyCjC1cv9YC+ZPlUf548OgrDsBP
   +b3/KGC/OOjcsGDqNfe8OhPVzlz4KF4SQVHpLkoSJVflHKok4JYan86UF
   tsWcsyucDx6acep8BOFMgp2HTPTC02Ix7nHLqUYG24qIVsER24JZt5G1O
   R43sG8C9Ere0p7aNKUXSykiK3vlFEtPdEsbhuI5nfBuatiXBvyg1WTYLd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364295201"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="364295201"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 07:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="762206495"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Sep 2022 07:44:19 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 22 Sep 2022 17:44:18 +0300
Date:   Thu, 22 Sep 2022 17:44:18 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] device property: Add const qualifier to
 device_get_match_data() parameter
Message-ID: <Yyx0wtteJB+yGQoD@kuha.fi.intel.com>
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

On Thu, Sep 22, 2022 at 04:54:10PM +0300, Andy Shevchenko wrote:
> Add const qualifier to the device_get_match_data() parameter.
> Some of the future users may utilize this function without
> forcing the type.
> 
> All the same, dev_fwnode() may be used with a const qualifier.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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
> -- 
> 2.35.1

-- 
heikki
