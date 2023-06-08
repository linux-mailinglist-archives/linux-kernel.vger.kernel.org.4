Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762C37282B8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjFHOan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjFHOal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:30:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D8A1FFE;
        Thu,  8 Jun 2023 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686234641; x=1717770641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EMkL2EMJl9r3P8/75EkIzlfvl6ILn+y62uw75wJCfgw=;
  b=YbehFFxYL6pLW527fuUoDnEqTx/2aciAbzNLt+E5PxxLJ95NiEMHPDMs
   Fq9HobM1m6arhQByO4GtzeLZavO9+dqBB0dyYI+kuVBBZmxn9PA1zQqzz
   GSC3dJsPbduam4pv1j1gBZu/JQaR84ie/eOCFdWSlN73sZbVWMllr26t8
   EMbYyKrcyse2zq8XM215d/Z8OmzJamzX2+iTE3ZDMskO79DW/PvfozvaU
   ZOXiZyWRyKu+TtMTC7+u7Mw/5WMl6lCJ93W5D3bx/i2zwRCpDcQLmNEz2
   +apNHQ8qYecn5A1aWNj+8HtoqqlUBuknajtH5Grfu0BRtBK0sfkxR6F27
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="385662707"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="385662707"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 07:30:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="775070874"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="775070874"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jun 2023 07:30:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q7Geq-002BMQ-0n;
        Thu, 08 Jun 2023 17:30:36 +0300
Date:   Thu, 8 Jun 2023 17:30:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v1 0/4] Minor optimizations for Intel pinctrl
Message-ID: <ZIHmDBU7uZDzBeRv@smile.fi.intel.com>
References: <20230608070017.28072-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608070017.28072-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 12:30:13PM +0530, Raag Jadav wrote:
> This series implements minor optimizations for Intel pinctrl driver.
> 
> The numbers are as tested with gcc 7.5.0 and may vary with newer versions.

Please, follow what Mika commented on on both series and issue v2 of each
of them.

-- 
With Best Regards,
Andy Shevchenko


