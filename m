Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37A6625DA7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiKKO6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiKKO6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:58:50 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD0026AFA;
        Fri, 11 Nov 2022 06:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668178729; x=1699714729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iokqu3N3/AkaN5JzOotARpVC/tBGH0Hf1rFvyuCpV3A=;
  b=cLSf6Nn4CLsG+1mo1IRAJtvpB9aaZt3rl5RxLQ1uAF9C2Mh+LKEhJFk0
   C0uuYIWsTVYlQdVOClC+dFghrdg//3nFoHRyquyQ02OB4DkqpKSFQtPej
   Dlai6khF9hryY8ZV4aBQg0RicqQwawVqofLC5iDFEyRleYwXzW7XCisZK
   bKWpKUkqS2i+btVGesqo136fvkBAf2gsigbW1fl/8bRjPwZb/71tJg+Ta
   M9lZkiVbhY5YE9bDQIY9sIzPhmoKKbSVqsmNmZ24rmFQvKHPNihOPV5yJ
   Li/ED5L5aysKq5wpbAGoZHnDa1AvBqT/gX6D1Ycb0dcJOU0aVrpMJyFN3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="397902725"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="397902725"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 06:58:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="780201313"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="780201313"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 06:58:47 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 91D5D2033F;
        Fri, 11 Nov 2022 16:58:45 +0200 (EET)
Date:   Fri, 11 Nov 2022 14:58:45 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 1/8] media: ov2740: Remove duplicative pointer in
 struct nvm_data
Message-ID: <Y25jJd24+Aq53gKE@paasikivi.fi.intel.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
 <YwTf22gkWxeyNKlR@smile.fi.intel.com>
 <Y246keIq4a541ooO@smile.fi.intel.com>
 <Y247UMkAUafPTBYI@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y247UMkAUafPTBYI@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 02:08:48PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 11, 2022 at 02:05:37PM +0200, Andy Shevchenko wrote:
> > On Tue, Aug 23, 2022 at 05:10:35PM +0300, Andy Shevchenko wrote:
> > > On Tue, Jul 26, 2022 at 03:05:49PM +0300, Andy Shevchenko wrote:
> > > > The struct i2c_client pointer is used only to get driver data,
> > > > associated with a struct device or print messages on behalf.
> > > > Moreover, the very same pointer to a struct device is already
> > > > assigned by a regmap and can be retrieved from there.
> > > > No need to keep a duplicative pointer.
> > > 
> > > Thanks, Bungbu, for the review. Can it be now applied?
> > 
> > Don't see this being applied or commented why not...
> > 
> > Mauro? Or who is taking care of this driver nowadays?
> 
> Okay, found a private response by Mauro where he tells that Sakari can take
> care of this. Sakari, should I resend this to you with all tags applied?
> Or you can use `b4` tool that allows to avoid unneeded resend.

No need to. But please cc me on the next time. I'll take a look now...

-- 
Sakari Ailus
