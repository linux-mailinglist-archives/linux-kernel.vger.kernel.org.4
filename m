Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70E260AE30
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiJXOwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbiJXOvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:51:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E197B1E1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666618181; x=1698154181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qV/bnkPLauA1VV9zeo2GpZ/RWVQGjMkbBLWU9xg+97U=;
  b=T/+vJbOHHdnpINflBKcTeHBHI5eeaE6lAWlwhDf83coIiZMzBAhhO6kq
   h1ssfYZZ9EdpIYrOondhhucK/c0Lt9fTRsvKfZip4r1u/niHUMaYt5Yll
   gZgyruIc7iUmFyYII3W2vicOwGeYjmP1ftwTKCzbO+6kBboc3hGjdytGx
   FRsdrMz/3bf4hJVO4/AZsl02i5fHWLNhswO02FpVAYN8S2QmmdaCPjszf
   qlV3n5paIMV0/EWMA9m+Y7nzmHCgkEOv9M0Frn2JnUDqtsSFwWC6XBtNs
   zxKq++F/4FD1YPZZE+zyPQU22MkbbIpoR3iyqr/pM4TAAW0g2IxAp9fDW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="308506704"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="308506704"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 06:20:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="756566394"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="756566394"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 24 Oct 2022 06:20:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omxN2-001SBE-1L;
        Mon, 24 Oct 2022 16:20:00 +0300
Date:   Mon, 24 Oct 2022 16:20:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] container_of: remove container_of_safe()
Message-ID: <Y1aRABf0GeZ6AKCA@smile.fi.intel.com>
References: <20221024123933.3331116-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024123933.3331116-1-gregkh@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 02:39:33PM +0200, Greg Kroah-Hartman wrote:
> It came in from a staging driver that has been long removed from the
> tree, and there are no in-kernel users of the macro, and it's very
> dubious if anyone should ever use this thing, so just remove it
> entirely.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/linux/container_of.h | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> index 2f4944b791b8..a6f242137b11 100644
> --- a/include/linux/container_of.h
> +++ b/include/linux/container_of.h
> @@ -21,20 +21,4 @@
>  		      "pointer type mismatch in container_of()");	\
>  	((type *)(__mptr - offsetof(type, member))); })
>  
> -/**
> - * container_of_safe - cast a member of a structure out to the containing structure
> - * @ptr:	the pointer to the member.
> - * @type:	the type of the container struct this is embedded in.
> - * @member:	the name of the member within the struct.
> - *
> - * If IS_ERR_OR_NULL(ptr), ptr is returned unchanged.
> - */
> -#define container_of_safe(ptr, type, member) ({				\
> -	void *__mptr = (void *)(ptr);					\
> -	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
> -		      __same_type(*(ptr), void),			\
> -		      "pointer type mismatch in container_of_safe()");	\
> -	IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) :			\
> -		((type *)(__mptr - offsetof(type, member))); })
> -
>  #endif	/* _LINUX_CONTAINER_OF_H */
> -- 
> 2.38.1
> 

-- 
With Best Regards,
Andy Shevchenko


