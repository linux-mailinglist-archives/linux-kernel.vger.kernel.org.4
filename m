Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0777A6D00BD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjC3KLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjC3KLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:11:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F5F72A7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680171100; x=1711707100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zbyNdV3eS+2sRqiPAQF1m42MYj6uTOjRyqXgBgtLQW0=;
  b=jcvdfmLoVF3goEjJuGM8V4eCvELAWwhZrmw1eiSlCNlDNE/3uhww03Zk
   b7zAWkC+g6pVOgeN7dGgn0l9TRPqr2IhKPrHBt4lPRlfXiIoYoWDrp1kL
   0B1LfWwBUFQurtXWU4SQ83fhkhCvYHjdfxLp75iQqpYtJvVG3bB22AtsI
   mmI6zRuy64Eih7c9aeqdNqi7K3qHHrfyFaT8r+j8GXrtD/XvXnP8XAOIH
   4gX+8Cw1VNfBKOz7v7bEL+fWH5rcrGFV+v+yIlSH9GG18a11k5mtzLoRl
   wagmglycRCJq7Qoc6/9xnFE9yIKQHw5l3FTFoVmlTQ9auL92nfDiC7ZzL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="339851659"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="339851659"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="714933818"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="714933818"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 30 Mar 2023 03:11:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1phpFp-00ANwr-2Z;
        Thu, 30 Mar 2023 13:11:37 +0300
Date:   Thu, 30 Mar 2023 13:11:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1 00/14] extcon: Core cleanups and documentation fixes
Message-ID: <ZCVgWX2t1fpGzZX9@smile.fi.intel.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 04:39:51PM +0200, Andy Shevchenko wrote:
> A few fixes to the documentation and some cleanups against extcon core
> module.

Anything I should do with the series?
Any comments on it?

-- 
With Best Regards,
Andy Shevchenko


