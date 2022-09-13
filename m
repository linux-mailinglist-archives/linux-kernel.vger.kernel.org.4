Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0344E5B790E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiIMSAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiIMSAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:00:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE52DAB07D;
        Tue, 13 Sep 2022 10:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663088529; x=1694624529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OQ1nVNV697R7SkSZxsmpJmYKMEnUiOGBi1tQctDBMg4=;
  b=aPnOCGMjP7jSa2qx60NfkuWSXkm9tVAC8tVmXrVTvty2w7pgv/r3Dxck
   d3zOwNl/1UGCFVEnrG5qaRIYdzNcDMGWcMEra5QPwvZe3YKtdmi8pjGS4
   TFEch5TYhVTic1pjq3g6Vv8Qw/Ba+CoLmfbrXGQhcdVOiFS5QouiGEcI4
   S3ZxeGU+O/0kwv6ao4SxybTMe4ifLSuN8nPUKQ5VYnVvdaKkvmfEZTLYp
   Dw9/Bcs6mPnib4Cnc3qyXIMHkMlWh67mQDe6GytXNYqWGwF+IzfaAX8tx
   1TpD0UIQxhVbZ1J4GGN4DPMmNmgxLAPay3SypAF3rSzTGfz2IofPgu2A0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="278585409"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="278585409"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 10:02:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="705621755"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 10:02:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oY9IN-001qlY-0U;
        Tue, 13 Sep 2022 20:01:59 +0300
Date:   Tue, 13 Sep 2022 20:01:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v5 20/21] hwmon: (mr75203) add debugfs to read and write
 temperature coefficients
Message-ID: <YyC3hsNhbQGIlReU@smile.fi.intel.com>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-21-farbere@amazon.com>
 <YxowTBIODMLjf1Ek@smile.fi.intel.com>
 <581a4a0b-8e0e-b7a2-f873-77ed74b54e96@amazon.com>
 <3b121ab4-dd64-68b3-ee89-8571b5d3651e@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b121ab4-dd64-68b3-ee89-8571b5d3651e@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 05:40:16PM +0300, Farber, Eliav wrote:
> On 9/13/2022 4:06 PM, Farber, Eliav wrote:

...

> It seems like debugfs_attr_write() calls simple_attr_write() and it uses
> kstrtoull(), which is why it fails when setting a negative value.
> This is the same also in v6.0-rc5.
> 
> debugfs_attr_read() on the other hand does show the correct value also
> when j is negative.

Which puzzles me since there is a few drivers that use %lld.
Yeah, changing it to

	ret = sscanf(attr->set_buf, attr->fmt, &val);
	if (ret != 1)
		ret = -EINVAL;

probably can fix that. Dunno if debugfs maintainer is okay with this.

P.S. This needs revisiting all format strings to see if there are no additional
characters, otherwise that needs to be addressed first, if feasible.

-- 
With Best Regards,
Andy Shevchenko


