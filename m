Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46476574AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiL1Jdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiL1Jdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:33:31 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AE9D2D2;
        Wed, 28 Dec 2022 01:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672220010; x=1703756010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gx9fpJ8oD+AnWPvBqSZ+egEORtlNlJ1oyu72c/NUpYs=;
  b=GITTY+aQvBM2TNjwSJT5GM3Klay6n4JEdXgdb7PhZ28CWmm2YKtOfweX
   v+sfFrBawVEialt9++YY70HmJ1ebh0NCh0LPXbosLnKQOb8R8RQ74UthW
   yP4xW+uj/66MSLL4t8/po/dZ0OYFCN9Cuju+AAfl8NP6Id+uK3wa7X8Nz
   3wS1fH8vDmpc7V7rMi63364v11K9zwOxLjCEPcOytZ2JerqRjE1W75srN
   LacRCU2Af/eldd//qGwmqq/3PkLvg5+6yTmYiUSU+5dCX+LjIsHbK+CHc
   v/2KRbZER2IFsQnEDopI9ssEGLFtVnuyzvcMJ5vWiC8o18ky8JWrZziyj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="348043592"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="348043592"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 01:33:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="653280391"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="653280391"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 28 Dec 2022 01:33:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pASoJ-000VwL-2X;
        Wed, 28 Dec 2022 11:33:19 +0200
Date:   Wed, 28 Dec 2022 11:33:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v1 1/2] HID: i2c-hid: acpi: Drop unneded NULL check of
 adev
Message-ID: <Y6wNX12SyXpU5UKI@smile.fi.intel.com>
References: <20221122191821.18076-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221122191821.18076-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 09:18:20PM +0200, Andy Shevchenko wrote:
> The driver is enumerated on ACPI platforms, so adev is valid.
> Since there is no valid I²C ID table provided, there is no
> possibility to bind a device to this driver via user space.
> Hence, drop unneeded NULL check of adev.

Is there any comment on this?
Can it be applied?

-- 
With Best Regards,
Andy Shevchenko


