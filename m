Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF3C750C67
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjGLP1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGLP1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:27:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053CEC2;
        Wed, 12 Jul 2023 08:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689175651; x=1720711651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P4W6MPsZFgY6bY6jKmSosafQiemRM7LuCwj7B/c+36Q=;
  b=dC6n+LGoU6ZaS1s5d6mEsFBGckg8gjMj4kdVAVZ/HlfxiaUF9OSSCvVF
   L8uVhuvSVJoh+TQp21mVfp6MaUFj5j8yv8bPHf2HjdT1fuRSgg8c2waz3
   bSd1A0qYohqzgLPWoJfftma3pvMYOSm8Sd4sS9mCcPB8z2zf6gC6iOL+d
   3Iwdm6n7irA9mTRmKC9hmMYtGKUVRYbAoMNif15SktEeyAtr6halhSp9Q
   bM7ESInNZMaacwn21wo5DQMAsrusuz69akzEDXxeqnWxQ8ovq3/3guc6o
   +ssh5K+vxsr1H9tk6Ama+PJJUR7Vx8VLA27fUiarmis2PXv92S4SUFM/y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="395717881"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="395717881"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:27:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="1052242225"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="1052242225"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jul 2023 08:27:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJbkV-002AER-1B;
        Wed, 12 Jul 2023 18:27:27 +0300
Date:   Wed, 12 Jul 2023 18:27:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [UPDATE][PATCH v2 2/3] platform/x86/intel/tpmi: Add debugfs
 interface
Message-ID: <ZK7GXxHZ6jGnwccs@smile.fi.intel.com>
References: <20230711223103.77057-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711223103.77057-1-srinivas.pandruvada@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 03:31:03PM -0700, Srinivas Pandruvada wrote:
> Add debugfs interface for debugging TPMI configuration and register
> contents. This shows PFS (PM Feature structure) for each TPMI device.
> 
> For each feature, show full register contents and allow to modify
> register at an offset.
> 
> This debugfs interface is not present on locked down kernel with no
> DEVMEM access and without CAP_SYS_RAWIO permission.

Same comments applied as I gave per previous version.

-- 
With Best Regards,
Andy Shevchenko


