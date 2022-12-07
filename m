Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02566459BF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiLGMVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiLGMVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:21:47 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640D4391E9;
        Wed,  7 Dec 2022 04:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670415706; x=1701951706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0kGd/OiPW1PJ4cPEb4PPblp3AImCctx/hnYQmTGU6Mc=;
  b=i8RyJaEwN4iHglzkfINp+KsNjzXgDW+kwVgWL5Hm2cVthgOivoV9eSDh
   K0nSmo9WW80Q7vCKbYcSKIS/Y0MvuZSl1i3M7tTRYkOAVcaWxNhqwHf0J
   duaepWr8r0qTFy4qpoBZNV1NuZ1ZhpVXlhdHTcN4NJBTKI6eLFcYrk1vS
   dD59j4OAovHkWhaVb3+c66f5aVsOvMylwxsv2XDybGncNtaZQKo7Sgu36
   3JJ4rBhgnHJAOM4aYwXtiSZXyDZl2nIm5RSvoRKuuVrZjTJYfMSk4fwj4
   +MCrpMpEzB6DRO3xsaWtvhMTenwX6GeiksxasazBTgbqufw4vPkgqCHr/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="403148135"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="403148135"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 04:21:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="891782203"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="891782203"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 04:21:42 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 6AE092033F;
        Wed,  7 Dec 2022 14:21:40 +0200 (EET)
Date:   Wed, 7 Dec 2022 12:21:40 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device property: Fix documentation for
 fwnode_get_next_parent()
Message-ID: <Y5CFVHL0xTeWbKfU@paasikivi.fi.intel.com>
References: <20221207112219.2652411-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207112219.2652411-1-linmq006@gmail.com>
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
> 
> Fixes: 233872585de1 ("device property: Add fwnode_get_next_parent()")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Thanks!

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

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

-- 
Kind regards,

Sakari Ailus
