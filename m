Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76345FD659
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJMIlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiJMIlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:41:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5F811C247;
        Thu, 13 Oct 2022 01:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665650471; x=1697186471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w1Sr0LEJVX0x7cu5RWiamo3bb11Ja5HaRisj2wP73S4=;
  b=e/Z2VOPrbX+l//2Ucab6wgQsrRKfb4d8o2/Fh5DJkcKgUrUPGp7GYo4Q
   9IdtxXHCpeXe2dRn7+h9h46TDpvLHFtK6XrQ9cGyj0ICc+UhckgSNn9te
   3t3ltW1NPWCghWEaZ5NP8fJ8wq9umwBm9KS5nGsV0KGwPZLlpq2LyRq6c
   1ECzA5UZo3jcw/ui1/88uEQqjltWDm1ZzhHkHQww9UMqObZuhNBq3q7X7
   B0f6Gax1auIMzJwB5qGTwJHQq0dDm97yTtZJnlfyYi7Rr+kuZQS3SpOLo
   3eTNA+Z9uWATkma8yZMOjQ+flABzoEOaevyZ22KT0170+Y2ucdcBZGbhF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="306085512"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="306085512"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 01:41:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="802160583"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="802160583"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 13 Oct 2022 01:41:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4AF21FD; Thu, 13 Oct 2022 11:41:30 +0300 (EEST)
Date:   Thu, 13 Oct 2022 11:41:30 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mauro Lima <mauro.lima@eclypsium.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: intel: Fix the offset to get the 64K erase opcode
Message-ID: <Y0fPOjlLrxj0mm2R@black.fi.intel.com>
References: <20221012152135.28353-1-mauro.lima@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012152135.28353-1-mauro.lima@eclypsium.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 12:21:35PM -0300, Mauro Lima wrote:
> According to documentation, the 64K erase opcode is located in VSCC
> range [16:23] instead of [8:15].
> Use the proper value to shift the mask over the correct range.
> 
> Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
