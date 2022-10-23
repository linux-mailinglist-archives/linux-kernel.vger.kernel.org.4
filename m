Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DEC60917C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 08:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJWGr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 02:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJWGrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 02:47:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7955B74CE8;
        Sat, 22 Oct 2022 23:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666507671; x=1698043671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eq8jIQ7RZWYC7BNL5gYHBTBT+p5MvSeCMBb6u4fBjXU=;
  b=hZWVEZd/RrSq0Ul5NcBb+ChSeNoXjev6RPePAp54Qw+9IFBTNNb2Cg4a
   umjLx0qOo/4Q8XfqDmYVsXTClEO37aaPY6q2E1nn+e3H5qcEEjlH5JHqz
   rJUr6lsXx/yWiE3iqHFtfQiEDgVDSRp11osGYTq7Xbmrv35YlyvqaHw0r
   EENarLWk4ciUl/IoeeZNyESMl5+Fj2aboqIKoPPdRU4kAkF3MoKEyp1Fh
   ecOJXdkY/aTzz+3PRkRJrlnqBTuU8LuPzDnwT4HLbCbBguIXrZmVXcTMY
   ac0E5kn3bPnh/fbpc45jZOwQ6fNaZDkaF1Yx83jQ18T+2nW7H1jnnu2nv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="294636339"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="294636339"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 23:47:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="805987622"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="805987622"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Oct 2022 23:47:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3E229107; Sun, 23 Oct 2022 09:48:10 +0300 (EEST)
Date:   Sun, 23 Oct 2022 09:48:10 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH v1 1/1] thunderbolt: Use str_enabled_disabled() helper
Message-ID: <Y1TjqhkeTjDUYlU2@black.fi.intel.com>
References: <20221008194501.38157-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221008194501.38157-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 10:45:01PM +0300, Andy Shevchenko wrote:
> Use str_enabled_disabled() helper instead of open coding the same.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to thunderbolt.git/next, thanks!
