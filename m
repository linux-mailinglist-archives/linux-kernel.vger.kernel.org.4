Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA416642A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjAJOAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238169AbjAJN7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:59:53 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACD03FA0F;
        Tue, 10 Jan 2023 05:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673359192; x=1704895192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CRS2K4zBotqHWkxsfKVWb7fKlZiMZd2LF1APTx5JxHM=;
  b=bEg5ZCEiGPdDK1ukkziTKTBlK99ChO4bN8xsFkpvQK8NwUrqUe6tlWaC
   +ka9pIxunn+pedl17zUZhCPNZx5Dm/hXK3mqYiIYzHy9qmj3l6avx8JHA
   yHkWlNhkUbEylPuydTFWBgqnTyTUn0bSyqaE2x/SrabXhi1UaSWS96tqm
   skxk4ZGTexWsA6ZMoWpSAMqnIFx9oxohIjtg/YKdxegfSv8Nu4znQOnSw
   MinhqlJs+L++57ECJKsZXJAL1tL8n+lBgNgKL8wym/yLSQlnmrmFj4D2r
   wIJ/D17UaqolkT69YkbKhuHaIEGm0DTNardhiRm7WdcYi6Ima9cjD2fyr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="387600562"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="387600562"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 05:59:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="830997736"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="830997736"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 10 Jan 2023 05:59:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pFFAG-0073P5-2e;
        Tue, 10 Jan 2023 15:59:44 +0200
Date:   Tue, 10 Jan 2023 15:59:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v1 1/2] HID: i2c-hid: acpi: Drop unneded NULL check of
 adev
Message-ID: <Y71vUGrUtsAK0zIk@smile.fi.intel.com>
References: <20221122191821.18076-1-andriy.shevchenko@linux.intel.com>
 <Y6wNX12SyXpU5UKI@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6wNX12SyXpU5UKI@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 11:33:19AM +0200, Andy Shevchenko wrote:
> On Tue, Nov 22, 2022 at 09:18:20PM +0200, Andy Shevchenko wrote:
> > The driver is enumerated on ACPI platforms, so adev is valid.
> > Since there is no valid I²C ID table provided, there is no
> > possibility to bind a device to this driver via user space.
> > Hence, drop unneeded NULL check of adev.
> 
> Is there any comment on this?
> Can it be applied?

Whom should I ask about this series?

-- 
With Best Regards,
Andy Shevchenko


