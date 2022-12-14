Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C703E64C82B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiLNLjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLNLjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:39:15 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F742E87;
        Wed, 14 Dec 2022 03:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671017953; x=1702553953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HIQ2CVubamspPVoCrqEnnVpkpn4eO9oQvSkp8p5F0Hs=;
  b=ODGJvIayLolWrrZalyutcdNwE8jZXdERt4kSPpMV0Hv/A/yXgeEs1hWd
   YubYaisI6DM/j9i3udw0aGdtsTa5J23QNXxXh9Uam816jbs44zBIdq3fJ
   4FQBVy7r+NoAEXqmvU+1yQdbByfMI7TdpL53FOXIlcU2WjIw9d3DxKMUm
   bGQY71JFoTe0+OB3QqSossS7QeOBAHvZCjhXxNHG1aCzfTcO+vC4cn2O1
   Ggt8zT/s+5hZu4V0WnmQSEhgoQgZ6KLi3oYG95aX6h3guuCe5+5QBQhHt
   EmwIFx3RkZbJhagIpEBPjXJHsLF56Wiqh54hgR4bCXIpcbVWFjbuDjvxo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="380584184"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="380584184"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 03:39:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="791276457"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="791276457"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 14 Dec 2022 03:39:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p5Q6K-009mSh-01;
        Wed, 14 Dec 2022 13:39:04 +0200
Date:   Wed, 14 Dec 2022 13:39:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: Dubious usage of VM_SHARED in atomisp_fops.c
Message-ID: <Y5m117tMRfo4Gnm3@smile.fi.intel.com>
References: <fbefc16e-84d3-8afc-8c8e-4229bded0c8a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbefc16e-84d3-8afc-8c8e-4229bded0c8a@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 11:22:39AM +0100, David Hildenbrand wrote:

...

> the other one would be to remove this driver. Judging
> that the driver already was marked broken in 2020 (ad85094b293e ("Revert
> "media: staging: atomisp: Remove driver"")), maybe it's time for the driver
> to go.

Not an option at all. As Hans explained.

-- 
With Best Regards,
Andy Shevchenko


