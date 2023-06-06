Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5A77236B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 07:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjFFFPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 01:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjFFFPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 01:15:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EFB123;
        Mon,  5 Jun 2023 22:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686028547; x=1717564547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8lmiOypB8vAiB2Z2YYrzUBCC9Yl8FGdiqONZSYE2wAQ=;
  b=nrnfNIhMw9wxup/A6XTQ/cP/5cROI5PR84Ho2sthucVZY9kB+oTMYH15
   TB71qz/WYmBe9qgRLOl3LiX5RLJ1Ws6jQlaMTCVSaCvKRL7CHisTkMFV9
   zNFojwAEXm7/5wFCxLOZl9z4FEWNgWHxJChHncASMqv/c7Ed5HWOdIuRS
   C+PbgT2qOt/BlYHRbdxS70tlxJECtRVnM3rbnOEBGEbEbwfUyfFY+RBDu
   avWexIfJJ9wqvnvMZUKy8F3euSqDswXEswBLALeM9fio9xngOd5n9j8J0
   URXeUkL4LLC7k7MAjOQPiX9SDFzb4dTTZ6xnpOTYbhlNtaYZQb8zzzKN0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336923988"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="336923988"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 22:15:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="712060484"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="712060484"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jun 2023 22:15:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 9295834F; Tue,  6 Jun 2023 08:15:47 +0300 (EEST)
Date:   Tue, 6 Jun 2023 08:15:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] pinctrl: moorefield: Fix open-drain pin mode
 configuration
Message-ID: <20230606051547.GX45886@black.fi.intel.com>
References: <20230605154523.11799-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230605154523.11799-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 06:45:22PM +0300, Andy Shevchenko wrote:
> Currently the pin may not be configured as open-drain in some
> cases because the argument may be 0 for the boolean types of
> the pin configurations. Fix this by ignoring the argument.
> 
> With that, allow to actually restore pin to the push-pull mode.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

BTW, looking at the two drivers they seem to have a lot of
commonalities. Perhaps it makes sense to consolidate?
