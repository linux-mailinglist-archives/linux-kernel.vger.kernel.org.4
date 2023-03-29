Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023D36CD426
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjC2IN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjC2INu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:13:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0646A40EF;
        Wed, 29 Mar 2023 01:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680077626; x=1711613626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YUNeCchHYviE/oMcgGuWwu1o6g4tHdPndr5KvkXp32c=;
  b=lolvb4Ymo5tpZ4gEC+pTqazwjuyGSHVwdb8wIApZaK3a+/6t48C3/RcJ
   t63bYLwASzFNG6Iqm97RpuWjMVddcyfc8SYqS9E3T3hUK20po3QpCjM6D
   fIQWcHIsUgT9r8eIx/CrU4a/t4yS6vLgw1dy7JlmLnfVILcotSqij143a
   0OPU0JMpQc4JTY33/Wy+o/2zGpGQnXYYy5UtSVn/akRBa7+52PR2deCc6
   QZisMtyaeg54B/l0fNwwmVbzUpK5r/nWZoBLV9MVeP/QMiT9pMIIlmpe5
   rxdHzCtYkSP+8VILxnasA4Z6Vp2tW7FXMopGlrAIeBKgaOjR3luV0/BOM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="339538712"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="339538712"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 01:13:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="677703819"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="677703819"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2023 01:13:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0346879C; Wed, 29 Mar 2023 11:13:42 +0300 (EEST)
Date:   Wed, 29 Mar 2023 11:13:42 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH v1 1/2] thunderbolt: Get rid of redundant 'else'
Message-ID: <20230329081342.GH33314@black.fi.intel.com>
References: <20230327172017.20078-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230327172017.20078-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 08:20:16PM +0300, Andy Shevchenko wrote:
> In the snippets like the following
> 
> 	if (...)
> 		return / goto / break / continue ...;
> 	else
> 		...
> 
> the 'else' is redundant. Get rid of it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to thunderbolt.git/next, thanks!
