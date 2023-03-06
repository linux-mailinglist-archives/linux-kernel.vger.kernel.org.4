Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F7A6ABA0A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjCFJiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCFJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:38:16 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED3B900B;
        Mon,  6 Mar 2023 01:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678095495; x=1709631495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JV9yY295k9+hO3We4GvdB9PU1QYZIuczZziMixnP5ks=;
  b=MJtDcrz8KwrX3ZQScfkCvngI5ctW489Ar0UiQuNOxn3/Gujfc8HpPvOb
   Yfna0UeUrzUJ7lnIE9g6Cxf+oEAG03GgFy1oiWXeleBEzBzKSvolTg1bc
   uZ3ZcprGkJBdFyR1ilC68OPde+78Aq5JaanJP5pkVCu+fQlNwYfXLIR+2
   nSZKc1ou5xjfiBo7fFiZTh6lVbga5rBsU4KZjOmcykJ5DDGScTfEtIg3y
   0xdNgH6Vgxut38TybEZipldUxNkIh8BPmNnDAccnDUC7Ay21LrnjLF1WE
   uUIqi39nkVP3qq06vN+HMBCrExACKyNCQXUMxces+v0apbNxLgko5IYYC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="337029146"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="337029146"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 01:38:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="819244299"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="819244299"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 06 Mar 2023 01:38:09 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 06 Mar 2023 11:38:09 +0200
Date:   Mon, 6 Mar 2023 11:38:09 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 1/4] usb: typec: stusb160x: Remove use of
 fw_devlink_purge_absent_suppliers()
Message-ID: <ZAW0gaDWrQKsSzC1@kuha.fi.intel.com>
References: <20230301214952.2190757-1-saravanak@google.com>
 <20230301214952.2190757-2-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301214952.2190757-2-saravanak@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 01:49:48PM -0800, Saravana Kannan wrote:
> This reverts commit 6b63376722d9 (usb: typec: stusb160x: Don't block
> probing of consumer of "connector" nodes, 2021-07-16).
> 
> After recent changes to fw_devlink that ended with commit 4a032827daa8
> ("of: property: Simplify of_link_to_phandle()"), fw_devlink no longer
> cares about the "compatible" property and figures out the correct struct
> device at runtime. So, we no longer need to call
> fw_devlink_purge_absent_suppliers().
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Cc: Amelie Delaunay <amelie.delaunay@foss.st.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/stusb160x.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/usb/typec/stusb160x.c b/drivers/usb/typec/stusb160x.c
> index 494b371151e0..482bffeb8a8f 100644
> --- a/drivers/usb/typec/stusb160x.c
> +++ b/drivers/usb/typec/stusb160x.c
> @@ -685,15 +685,6 @@ static int stusb160x_probe(struct i2c_client *client)
>  	if (!fwnode)
>  		return -ENODEV;
>  
> -	/*
> -	 * This fwnode has a "compatible" property, but is never populated as a
> -	 * struct device. Instead we simply parse it to read the properties.
> -	 * This it breaks fw_devlink=on. To maintain backward compatibility
> -	 * with existing DT files, we work around this by deleting any
> -	 * fwnode_links to/from this fwnode.
> -	 */
> -	fw_devlink_purge_absent_suppliers(fwnode);
> -
>  	/*
>  	 * When both VDD and VSYS power supplies are present, the low power
>  	 * supply VSYS is selected when VSYS voltage is above 3.1 V.
> -- 
> 2.39.2.722.g9855ee24e9-goog

-- 
heikki
