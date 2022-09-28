Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7683F5EDE9A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiI1OQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiI1OQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:16:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1002A6AEA;
        Wed, 28 Sep 2022 07:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664374587; x=1695910587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5vq0qEvR6QMO1awFFXfP8C9KhW0DJh3xkyLxRxj/cK0=;
  b=f7Fuy25YHJmLufS3jlymFACbfUcgrjjWkTWuzygDGulQ1G6MC/fpHLFs
   qq4bR/WKjXtsJU5LopIMYGSrnB/uJPlZxrlW5i+Wci17n9ds8VR7tnXK3
   J6F4HCTsWjX1sOnzrruqU3P5pmocG0jzdYVfpIqmp4AIpQgAPxA7t+dyI
   8dBBl736N0oyQ0mWcKV9FBNFlq3ec4PYjr/knNgAWIODjPARscKM4bLoV
   tSQTiYS0+sEy4Sx4zdh/7R+G+1qy7qHI+4u3BBIZYv/theiZX4CAVceLW
   LpZ9DNbu71fKQFM7s6Zr6Jp1UPkArX/+kQPgQANKCfIpschXF1jj67M1K
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="281329205"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="281329205"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 07:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="624163333"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="624163333"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 28 Sep 2022 07:16:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1odXrI-008xfW-07;
        Wed, 28 Sep 2022 17:16:20 +0300
Date:   Wed, 28 Sep 2022 17:16:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org,
        rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, mario.limonciello@amd.com,
        pobrn@protonmail.com, coproscefalo@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] platform/x86: dell: Add new dell-wmi-ddv driver
Message-ID: <YzRXM2wN4Z5TYsS9@smile.fi.intel.com>
References: <20220927204521.601887-1-W_Armin@gmx.de>
 <20220927204521.601887-3-W_Armin@gmx.de>
 <YzQmQw0hEwzXV/iz@smile.fi.intel.com>
 <aaacb093-c5b2-09b4-2ddc-966b3b11544e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaacb093-c5b2-09b4-2ddc-966b3b11544e@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 01:33:53PM +0200, Hans de Goede wrote:
> On 9/28/22 12:47, Andy Shevchenko wrote:
> > On Tue, Sep 27, 2022 at 10:45:21PM +0200, Armin Wolf wrote:

...

> >> +	default m
> > 
> > Why? (Imagine I have Dell, but old machine)
> 
> Then you can select N if you really want to.
> 
> > (And yes, I see that other Kconfig options are using it, but we shall avoid
> >  cargo cult and each default choice like this has to be explained at least.)
> 
> This has been discussed during the review of v1 already.
> 
> There are quite a few dell modules and the choice has
> been made to put these all behind a dell platform drivers
> options and then default all the individual modules to 'm'.

Okay, thanks for pointing out that this was discussed. I was not aware.

...

> >> +	kfree(obj);
> > 
> > I'm wondering what is the best to use in the drivers:
> >  1) kfree()
> >  2) acpi_os_free()
> >  3) ACPI_FREE()

> > ?
> 
> Most ACPI driver code I know of just uses kfree() the other 2
> are more ACPI-core / ACPICA internal helpers.

To me 2) would look more consistent, esp. in case if it is extended in
the future.

...

> >> +	ret = device_create_file(&battery->dev, &data->temp_attr);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	ret = device_create_file(&battery->dev, &data->eppid_attr);
> >> +	if (ret < 0) {
> >> +		device_remove_file(&battery->dev, &data->temp_attr);
> >> +
> >> +		return ret;
> >> +	}
> > 
> > Why dev_groups member can't be utilized?
> 
> Because this is an extension to the ACPI battery driver, IOW
> this adds extra attributes to the power-supply-class device
> registered by the ACPI battery driver. Note that the device
> in this case is managed by the power-supply-class code, so
> there is no access to dev_groups even in the ACPI battery code.

Ah, I see now, so we extend the attributes of the 3rd party driver here.

-- 
With Best Regards,
Andy Shevchenko


