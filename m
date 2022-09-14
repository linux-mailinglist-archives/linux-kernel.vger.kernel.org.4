Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860F55B8E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiINRYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiINRYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:24:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DFD10B5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 10:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663176271; x=1694712271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d9Qn9xSx7QuWR+qPUQvfP6425XmAVcvn+4eSyDc/K0Y=;
  b=Ey/uOtJWP5V2wRa7HPwM5hpruysiftPVQRJYjVdnCss/jmZYKwtfhAVC
   u9dUUblIyvqiHtWhq84SCnfKPt2ZxflTpz7b6D5ubtyv7FuQ8SsiVmeSr
   A0SjIyyeppgb58dWPJVtucEZ4hvEzZfGrcelRg1IN2avwgyTO1SGnLCkw
   h+peDHijGMXCAES4ObKF33skuM5aOotGSFLoAlZlpBw0iGdwR6oGo3yb7
   PlSbBxYPKBdw5G+WxyBBFXjbvULZh0St5Q4dxT8mpyRPWSTOaqUgWQuq8
   nTk9rHi0sonOC5m14zjq5nXp0ES6qRorB9y3nhqNZwgXoG6dEP+DyUjt6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="296080923"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="296080923"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 10:24:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="594468530"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 10:24:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oYW7f-002JVo-1I;
        Wed, 14 Sep 2022 20:24:27 +0300
Date:   Wed, 14 Sep 2022 20:24:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] Revert "kernel.h: Split out might_sleep() and
 friends"
Message-ID: <YyIOS6mc9QJGjxH9@smile.fi.intel.com>
References: <20220914170739.34600-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914170739.34600-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 08:07:39PM +0300, Andy Shevchenko wrote:
> This reverts commit e076cfdb3293a31b7d6cfc8d4a65355b0c9f82f4.

Sorry for this garbage. It wasn't expected to be here.

-- 
With Best Regards,
Andy Shevchenko


