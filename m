Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A705E88B9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 08:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiIXGZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 02:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIXGY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 02:24:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791242EF1C;
        Fri, 23 Sep 2022 23:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664000698; x=1695536698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ahk3qTCXfZXiFTcCidMdjrCVQMdNXV2fOISqcNWVFbQ=;
  b=QDq0MpE2T3XDINS7P6ifBvZzKTz3FMKQZEsAgXsd6AiEJ64FghxTbO22
   UXaL1nSBym6o6wzlm4f6ugLb7FGCiLGmn4X3laanQdYGpNbNT83dBFcL0
   4jUhKTF1wTpXordNzA1ciyYyEYbwh706kpRjbrMT3KM5aJ7X8Izsf9o4M
   64/bAM2xO150Y7HM1zNitNdkXUdl8l4jysJqmswOLz6tFOvFmqfZPzzoz
   NN/FYHhnDakK6wiBLhRhkoyMFZu2DkS9NCGrMGbogA+gT4Wuj0dAHWrjp
   SW/LDJWYnfekDatymUPyJfrPGeHgKeT9gkFmUd779KGqWCS8eTcNosZ3S
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="299472942"
X-IronPort-AV: E=Sophos;i="5.93,341,1654585200"; 
   d="scan'208";a="299472942"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 23:24:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,341,1654585200"; 
   d="scan'208";a="651214007"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 23 Sep 2022 23:24:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id CDEB7F7; Sat, 24 Sep 2022 09:25:13 +0300 (EEST)
Date:   Sat, 24 Sep 2022 09:25:13 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Szuying Chen <Chloe_Chen@asmedia.com.tw>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH v1 1/2] thunderbolt: Convert to use
 sysfs_emit()/sysfs_emit_at() APIs
Message-ID: <Yy6iyYWd5CGQMFit@black.fi.intel.com>
References: <20220922143240.36878-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922143240.36878-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 05:32:39PM +0300, Andy Shevchenko wrote:
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the value
> to be returned to user space.
> 
> While at it, use Elvis operator in some cases.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This and the following patch applied to thunderbolt.git/next. Thanks
Andy!
