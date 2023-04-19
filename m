Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755AE6E78E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjDSLrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjDSLrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:47:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA264C22;
        Wed, 19 Apr 2023 04:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681904824; x=1713440824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iZ9zP/czoiwzuGqd+7mx8aaZzCqymmjJky/8w2YBO04=;
  b=GgvKPk+mwm7KiUFEw7XrE0YujxMqz2by6rrkwi2/ApqTB/p18T46wKRJ
   W/WNg6ntzZAhQJzxBVzIuwvLUsOxVlJGb+6+7AbelE2kGUCQ3tNbKxGum
   HOLFAGxB1sQFVCJZ42a1peO/SvIjL4Mp0ENv8ZEL3UISiUrs0f1WprJD/
   fSBDkFrnntw5waSZytW3iPJEYkEYRj7ODfmpvi6qHXToUAx24nhiIJqDj
   FDoKqtdfj90NqM8Q0cZpN2o5mGQnQa2+oZ+Fa1d1MNQp23N3Afl/cU4Xt
   cLMw97VDIE9bdf/Yo1De6FiL89pzIODT2kHDoeTVpueiONq3F6sqY728j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="325759615"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="325759615"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 04:47:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="721902168"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="721902168"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 19 Apr 2023 04:47:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pp6H5-002DIC-0p;
        Wed, 19 Apr 2023 14:46:59 +0300
Date:   Wed, 19 Apr 2023 14:46:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dinh Nguyen <dinh.nguyen@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com
Subject: Re: [PATCH 3/5] hwmon: (socfpga) Add hardware monitoring support on
 SoCFPGA platforms
Message-ID: <ZD/UsuzhZmK3AFJn@smile.fi.intel.com>
References: <20230410153314.27127-1-dinh.nguyen@linux.intel.com>
 <20230410153314.27127-3-dinh.nguyen@linux.intel.com>
 <09730359-8731-e21e-3335-bf60ba7f1280@roeck-us.net>
 <a3e966f8-8e9d-7081-1665-9d2e87acb310@linux.intel.com>
 <8d158880-1e6a-5fdd-dae7-a7647794eb60@roeck-us.net>
 <a1a34c32-dbd4-7a77-ab7e-5e34af85900f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1a34c32-dbd4-7a77-ab7e-5e34af85900f@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 12:29:40PM -0500, Dinh Nguyen wrote:
> On 4/17/2023 4:51 PM, Guenter Roeck wrote:
> > On 4/17/23 13:55, Dinh Nguyen wrote:

...

> > ... and this contradict each other. If bit 31 indicates an error,
> > this can not be a signed 32-bit value.
> > 
> You're right! I've re-read the spec and should have the the code look for
> the specific error values:
> 
> 0x80000000 - inactive
> 0x80000001 - old value
> 0x80000002 - invalid channel
> 0x80000003 -  corrupted.

No, they are not hex. Probably you need to define an error space with it, but
at least just use signed _decimal_ values.

Instead of BIT(31) this should go as

#define ..._ERR_BASE   INT_MIN // or equivalent if the type is not int
#define ..._ERR_MAX ... // or whatever name is better

Then in your code

	if (value >= _ERR_MAX)
		return 0;

	err = _ERR_MAX - value;
	switch (err) {
		...
	}

P.S. I asked during internal review if the values are bit fielded when errors.
AFAIU that time they are, now it seems different.

-- 
With Best Regards,
Andy Shevchenko


