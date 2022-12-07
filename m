Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D315645910
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiLGLct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiLGLcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:32:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C258424BCE;
        Wed,  7 Dec 2022 03:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670412764; x=1701948764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oBQKpjPlutD4/zb2bT2mTk9Jl1yT2qCOW5u8WtSZQBA=;
  b=aiiv/CLplaic/THC/twhv3bEehX8IIcVuFoeQI1BBKkYjdlcykuHSnYx
   jiCXsfLVoPYQprpLvVeffhrCptkSWLXpQHDWj8X3mG6LMA/85wPiJpxjo
   zD6X9fO1KWuTXylU/q4X4e8zpW6raTCakE8/sGeNeeVLe7aucUfrVIO26
   P2nGw7TByjo3bku+Jk0FRujsN8BpZG3C4VT4IG0zQGZG7MLibUtItt0rY
   83GmAyQlNE6Z8qO7Euru885zmXXIc4Nr5Oz6XESONxH3YFjBdglEdKGZ1
   rY+EoXu7zpiQerscOiaBssgHO1I7q/WtTWBlmIGFFczfrgn5ZdZnEXV11
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="379036347"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="379036347"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 03:32:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="715158509"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="715158509"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 07 Dec 2022 03:32:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p2sfI-005k5f-0N;
        Wed, 07 Dec 2022 13:32:40 +0200
Date:   Wed, 7 Dec 2022 13:32:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device property: Fix documentation for
 fwnode_get_next_parent()
Message-ID: <Y5B51wScX5v2tr8m@smile.fi.intel.com>
References: <20221207112219.2652411-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207112219.2652411-1-linmq006@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 03:22:18PM +0400, Miaoqian Lin wrote:
> Use fwnode_handle_put() on the node pointer to release the refcount.
> Change fwnode_handle_node() to fwnode_handle_put().

Looks correct to me, thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 233872585de1 ("device property: Add fwnode_get_next_parent()")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/base/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 2a5a37fcd998..daa1e379762b 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -601,7 +601,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_parent);
>   * node's parents.
>   *
>   * Returns a node pointer with refcount incremented, use
> - * fwnode_handle_node() on it when done.
> + * fwnode_handle_put() on it when done.
>   */
>  struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
>  {
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


