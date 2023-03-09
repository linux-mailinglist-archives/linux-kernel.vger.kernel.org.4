Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CB26B2FCA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCIVrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCIVr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:47:29 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E17F6C67;
        Thu,  9 Mar 2023 13:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678398447; x=1709934447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GkobNDt5ss03H4RMPe42lTr79ibZBDjdVet0F7xwX7c=;
  b=e79KzDYNRgbRfgdIAADAbJAI3YiGDEUmzPhsBXr3IL7oAlR7G3DyYbWJ
   QxZFRficQhtmavnTK8Qf5SPz+C6D2kcSEG66dtt3FyUpxDZUnrbzFG3cl
   69vh2hreHgdOUfWfpNAfw5mdXZRXD3crc59G9/QVF8Q6GrskteLAN9xch
   nxBPdi+FIdeZJ7CQXnd7kXypSln1mVNBXM1vBwYTZbdbQl8boM3V5Ybrq
   O1yOJ4zakYG26AvouwLBthAEPWetMEuA7ivsdZ97A6RUCAtx2C9NRcMOg
   ReRZnXDRnjPms2PTw+UNprGq7EhoAZkZTxQnFUyyW4dhFBnarfBzHczI5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="335276628"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="335276628"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 13:47:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="677557834"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="677557834"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 09 Mar 2023 13:47:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1paO6S-000aGh-1W;
        Thu, 09 Mar 2023 23:47:12 +0200
Date:   Thu, 9 Mar 2023 23:47:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] block: don't embed integrity_kobj into gendisk
Message-ID: <ZApT4KMT+cSbk3h4@smile.fi.intel.com>
References: <20230309-kobj_release-gendisk_integrity-v1-1-a240f54eac60@weissschuh.net>
 <d85ba503-d93c-3483-25e1-6043d4af444f@alu.unizg.hr>
 <0ac9777c-7586-494f-bbc5-87f14f645b12@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ac9777c-7586-494f-bbc5-87f14f645b12@t-8ch.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 09:23:24PM +0000, Thomas Weißschuh wrote:
> +Cc Andy
> 
> Answer below.

Thank you for sharing!

-- 
With Best Regards,
Andy Shevchenko


