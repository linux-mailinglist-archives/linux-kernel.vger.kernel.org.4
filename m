Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C33F5B8D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiINQt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiINQt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:49:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539BFAC;
        Wed, 14 Sep 2022 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663174166; x=1694710166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uk216UOZBZ7fs12CPJjNVEA7Tpus72SHzZBd+iTcYm4=;
  b=El6bo778YmbmEURkh5YrlMnk5mXz0/mY8aYyWN9NR7M6nA6jCz3MzNC+
   gLM/tdPBB4hXmrCn+Mn0lCp+YOThFiP37mre+2WYQ6LsEOq8WKMwhD2DH
   7YirfAIxr6pgBGGNPcSdy0oZxH8yuVva9b5hS52j44+wQWU9Pr1f47QOR
   0FjKi8jb1Hor/HSiBTIm9Uh1Nrls8W/ffhFhPPAgQ4vw0jUiaOhnQ03zZ
   hGsfwL0yk/gP6aWuY207umg3QUgjoSFGa8tq+Z4cT8aQHurPQMP5W4dyI
   N49kJP5fXvsW0wNN2BXNbE91jvJoFdHmmETWVvU0+kRo753i4hLGjv+cB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="285521275"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="285521275"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 09:49:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="685377793"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 09:49:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oYVZh-002Ii4-1P;
        Wed, 14 Sep 2022 19:49:21 +0300
Date:   Wed, 14 Sep 2022 19:49:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 1/1] TODO: serdev: Replace poll loop by
 readx_poll_timeout() macro
Message-ID: <YyIGEUjwr4exvEFx@smile.fi.intel.com>
References: <20220914163640.38003-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914163640.38003-1-andriy.shevchenko@linux.intel.com>
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

On Wed, Sep 14, 2022 at 07:36:40PM +0300, Andy Shevchenko wrote:
> The readx_poll_timeout() consolidates the necessary code under
> macro. Replace current code with it.

The code is like I want it to be, but subject contains a leftover "TODO:"
prefix, I will wait for other comments and will send a v2 with that dropped.

-- 
With Best Regards,
Andy Shevchenko


