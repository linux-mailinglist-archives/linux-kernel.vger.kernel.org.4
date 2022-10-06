Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B9A5F6653
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJFMpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJFMpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:45:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E9788DFE;
        Thu,  6 Oct 2022 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665060345; x=1696596345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/BOOh1Cu+BGPC3M+7vmWVFiM/nnxyxHswxdVOZ9jz6Q=;
  b=DEFe9zQyyp+9TYws/RQNBmxwI+OLpw8Iqi2OSd4xl1ZroI+YKcTDdQQ9
   LLaX2/VwRdpX/2sbMoZkhY9snea4GvvqmfLGz+/rTUe9/W7IVT+TBtEr4
   A7vbreYVXihz9taY8Ct9I/UR5wvQu1NFveRHPRUn2RF1223tZFSxTod69
   db8I1TSpcHPyRn/bqoH1rVayQ3wO5cN9rQAySC81Qx/15tajaYPNa+xe4
   peY2Bsn3ax+mbj331V2vgTvyaBNc6aaZ2j2ET/Js5U4luG/FOcEMFESHw
   uJbNuGXRVOWZ/hB2YTnqc+BHjdGbTapk927jAa1fMERKbmm9yMFwfUwNq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="303407825"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="303407825"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 05:45:45 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="693338655"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="693338655"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 05:45:43 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 527B9201DB;
        Thu,  6 Oct 2022 15:45:41 +0300 (EEST)
Date:   Thu, 6 Oct 2022 12:45:41 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] device property: Fix documentation for
 *_match_string() APIs
Message-ID: <Yz7N9b3qibyaPAhJ@paasikivi.fi.intel.com>
References: <20221006123807.37014-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006123807.37014-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Oct 06, 2022 at 03:38:07PM +0300, Andy Shevchenko wrote:
> The returned value on success is an index of the matching string,
> starting from 0. Reflect this in the documentation.
> 
> Fixes: 3f5c8d318785 ("device property: Add fwnode_property_match_string()")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/property.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 617007a25783..bfed224c5724 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -236,7 +236,7 @@ EXPORT_SYMBOL_GPL(device_property_read_string);
>   * Find a given string in a string array and if it is found return the
>   * index back.
>   *
> - * Return: %0 if the property was found (success),
> + * Return: index, starting from %0, if the property was found (success),
>   *	   %-EINVAL if given arguments are not valid,
>   *	   %-ENODATA if the property does not have a value,
>   *	   %-EPROTO if the property is not an array of strings,

There are other error codes that can be returned such as -ENOMEM or what
else may be returned by fwnode_property_read_string_array().

I might just refer to fwnode_property_read_string_array() and document here
those specific to these functions.

Just FYI... I guess this could be a separate patch, too.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> @@ -457,7 +457,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_string);
>   * Find a given string in a string array and if it is found return the
>   * index back.
>   *
> - * Return: %0 if the property was found (success),
> + * Return: index, starting from %0, if the property was found (success),
>   *	   %-EINVAL if given arguments are not valid,
>   *	   %-ENODATA if the property does not have a value,
>   *	   %-EPROTO if the property is not an array of strings,

-- 
Kind regards,

Sakari Ailus
