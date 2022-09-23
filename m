Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724FC5E7989
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiIWL0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiIWLZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:25:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F3FE7429;
        Fri, 23 Sep 2022 04:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663932324; x=1695468324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uOvFZoazlmsabCykYjowvAOS8R6HTT99n3V0ABLDATg=;
  b=G7m6sr6ITRvQ6nePMltUXpejQ9sIXR0Ly0jDXP8dhaAMHUFpwe2gIIsf
   uz71DMd0ZtIOLXQKbeHawdxxtNVZPBdx04Af8VCWBuEVNBYe84D4aHYZU
   TxmE/Ac9s0Qh5O2r25oZXFFUaslnsWAY9L7IKi4mXQrV55A1J4EY80wOE
   LnuSS277knBXNnV747ZnQ7EaYengFHHqpTr8cw6itNa9J8XXgR98Kvm4s
   mymUAU7d/j0xNgmzmTSL7MU23HYzX03bEgQq2O2BNZ5WVcDsVz6UdupOx
   K5jqlOz3mSOdUkArfCvu5OYOdOGmUGL4tb+DaCILSUwLP8T0O7ot0ujVa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="298170640"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="298170640"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 04:25:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="682628053"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 04:25:21 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id C7DBA20124;
        Fri, 23 Sep 2022 14:25:19 +0300 (EEST)
Date:   Fri, 23 Sep 2022 11:25:19 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] device property: Add const qualifier to
 device_get_match_data() parameter
Message-ID: <Yy2Xn+w1ajJ4At+o@paasikivi.fi.intel.com>
References: <20220922135410.49694-1-andriy.shevchenko@linux.intel.com>
 <YyzEHk2TTcsIO0ha@paasikivi.fi.intel.com>
 <Yy2Jph0AAugY/tn/@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy2Jph0AAugY/tn/@smile.fi.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Sep 23, 2022 at 01:25:42PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 22, 2022 at 08:22:54PM +0000, Sakari Ailus wrote:
> > On Thu, Sep 22, 2022 at 04:54:10PM +0300, Andy Shevchenko wrote:
> > > Add const qualifier to the device_get_match_data() parameter.
> > > Some of the future users may utilize this function without
> > > forcing the type.
> > 
> > From const to non-const? This is what this patch does, right?
> 
> Right.
> 
> > > All the same, dev_fwnode() may be used with a const qualifier.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > > -struct fwnode_handle *dev_fwnode(struct device *dev)
> > > +struct fwnode_handle *dev_fwnode(const struct device *dev)
> > 
> > If you have const struct device pointer, then the embedded fwnode handle in
> > that object sure is const, too. Isn't it?
> > 
> > If you really have const struct device pointer (where do you?), then I'd
> 
> device_get_match_data() expects the const parameter, but due to dev_fwnode()
> it can't be satisfied. This has been reported by LKP when I tried to submit
> a wrapper:
> https://lore.kernel.org/linux-spi/20220921204520.23984-1-andriy.shevchenko@linux.intel.com/
> 
> Yes, I probably can drop const there, but it will be again awkward to see
> almost all APIs beneath using const and upper one without it for unclear
> (to the reader) reasons.

dev could indeed be const there otherwise, I understand, but it's certainly
not better to force it non-const elsewhere for that.

> 
> > suggest to add another function, dev_fwnode_const() that is otherwise the
> > same except the argument as well as the return value are const.
> 
> Perhaps this is the case, but does it mean we need to duplicate APIs when
> we know we don't modify data? Seems road to bloating the code for peanuts.
> 
> > Or alternatively define it as a macro and use _Generic()?
> 
> Yeah, I have the mixed feelings about _Generic for generic APIs because
> it requires to convert some stuff to macros when type checking of the
> parameters can be missed (if a target takes two or more of them).

It's not uncommon to use wrapper functions in addition to get type checking
done properly.

> 
> It might work here (we have a single parameter), but in general...

If it works here, why not to do it then? :-)

-- 
Sakari Ailus
