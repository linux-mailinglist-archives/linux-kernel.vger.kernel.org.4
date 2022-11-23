Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C894636842
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbiKWSEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239421AbiKWSCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:32 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14960BC5;
        Wed, 23 Nov 2022 10:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669226550; x=1700762550;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=kivik+kPuM3WnltAjgW4IIt2Bf+IrOZ9iPY+LvRUtIY=;
  b=atOR9RDdxv5QHCMd3CqJ3e/fg2Ebw9oBKNWDhChmLu8IwthaoZUWXgCV
   CbSAoDG0TJGNfDdB2++GWS3qSkrbAVF0Qv+rudi/sMQyx2bW5exhyXpbg
   9YPyDPlDTRsrgy5RmYp6SI6UU/8m/ZTtpA1bEiT8OipWW3PSWyL29DR6M
   3Wok81PgSJCckBtIMfp0drCwKQ2vY2liiDN8hKIfCIo/12iTePUOydXbQ
   UYE1fN9qN171oIjtAMzt47rh9L1ejL+4USfvpd6HExl2up4Abkgfy4l/O
   OGluBKzb9afNHg2LdezgJ91t+FKFU7mCDspjdJgc2QcRhC6ruxzAjESYb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="294516108"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="294516108"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 10:02:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="730865542"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="730865542"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Nov 2022 10:01:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxu4L-00GOVq-1P;
        Wed, 23 Nov 2022 20:01:57 +0200
Date:   Wed, 23 Nov 2022 20:01:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2 1/4] media: ipu3-cio2: Don't dereference fwnode handle
Message-ID: <Y35gFZ7aK9JIrUWy@smile.fi.intel.com>
References: <20221121152704.30180-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121152704.30180-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Cc: Petr, Sergey

On Mon, Nov 21, 2022 at 05:27:01PM +0200, Andy Shevchenko wrote:
> Use acpi_fwnode_handle() instead of dereferencing an fwnode handle directly,
> which is a better coding practice.

It appears that this series depends on fd070e8ceb90 ("test_printf: Refactor
fwnode_pointer() to make it more readable") which is in PRINTK tree.

Sakari, Mauro, if you are okay to route this via that tree, can we get your
tags for that? Otherwise we need to postpone this till v6.2-rc1 (but I would
like to decrease the chances to appear a new user of the to be removed API).

-- 
With Best Regards,
Andy Shevchenko


