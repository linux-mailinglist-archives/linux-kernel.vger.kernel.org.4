Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A626CA08B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjC0JyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjC0JyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:54:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6741F49EB;
        Mon, 27 Mar 2023 02:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679910839; x=1711446839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S5NORdcXrq6M/oYcEA9ATUWhbN5J7ZlrbX5LXy6ouC8=;
  b=Ef9AMlMQ6a0/w7VQ0QNrJrYw9ucieHQm2KHKC3jQT7SjOnwMVjeCol8K
   R2fIYK2dKruuDK4bGMBi31ZJXd1YdG5cZRwxDeTWjbXR2KYX26XtO0e+B
   uKCk7aRliEej0/oqR1CoosCU9wErdBZ01H8t4IymryGLt8HWrdY3n7DOx
   pmpSGxxUx+7DF9Fd+Iaa4W8zpnQjvbKOGHh77AQl1M9d+9HW38Yxtz/Ix
   v93NKpKcUD+sOVKgv3GHg3HlASZZB29ZmZyS5YOrduOXP+c7A7qb+9hB6
   yo3oHK5Kt9qotFThYg7QlNKLCW87gjbgEaBp9bwUXLaDwnPIZ1g2ryvP9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="320626103"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="320626103"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 02:53:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="683407714"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="683407714"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 02:53:57 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 4071511F930;
        Mon, 27 Mar 2023 12:53:54 +0300 (EEST)
Date:   Mon, 27 Mar 2023 12:53:54 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI: property: Refactor
 acpi_data_prop_read_single()
Message-ID: <ZCFnssNwMgjKCX9L@kekkonen.localdomain>
References: <20230324114146.4037-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324114146.4037-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for the patch.

On Fri, Mar 24, 2023 at 01:41:46PM +0200, Andy Shevchenko wrote:
> Refactor acpi_data_prop_read_single() for decreased indentation
> and better structure. No functional changes intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
