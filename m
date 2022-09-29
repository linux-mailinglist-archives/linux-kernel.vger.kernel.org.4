Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CA55EF2B0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiI2Juv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiI2Jup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:50:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9864F31203;
        Thu, 29 Sep 2022 02:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664445043; x=1695981043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OuzAVg6ea9JReu4tlJ0aMNveBoUNr4OMqqCO6UkME1Q=;
  b=Yl4GVGY8nOUHPA5nGzxxxmZ8EfL3g8KI9R46ljDPpIJhfqEPCthniHYm
   pmtYVQA+sptBdCPf9M4vTzWs65/CwxVzkg+YpNzY7BFqZge9QoxoTl8R2
   /JW7mm6JXSv7S0ihKbhVHO9NmVsNs3wBCaeAMP6ssBCInGXo1Fznz0y5m
   kbzWGxFS+ae7A3+DTH6ERVeHn3TMm46ney2mCXtY0TB4NSwon/O/yxnUd
   68979oALV3smN2xxUrEOnIfv4ahBHY2qjZO3XYw/qmpe2EBzeC5y3qW+c
   hMxj8etQaurxhNWP4IJ+pKeAAPgWOzhmWK/tM6zO8WzwVZKAeNUQSNe8w
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="282214030"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="282214030"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:50:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="726332208"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="726332208"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 29 Sep 2022 02:50:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1odqBh-009KrI-1K;
        Thu, 29 Sep 2022 12:50:37 +0300
Date:   Thu, 29 Sep 2022 12:50:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, markgross@kernel.org, rafael@kernel.org,
        lenb@kernel.org, hmh@hmh.eng.br, matan@svgalib.org,
        corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, mario.limonciello@amd.com,
        pobrn@protonmail.com, coproscefalo@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] platform/x86: dell: Add new dell-wmi-ddv driver
Message-ID: <YzVqbSBHm3OrjIaQ@smile.fi.intel.com>
References: <20220927204521.601887-1-W_Armin@gmx.de>
 <20220927204521.601887-3-W_Armin@gmx.de>
 <YzQmQw0hEwzXV/iz@smile.fi.intel.com>
 <34774c9d-1210-0015-f78e-97fdf717480c@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34774c9d-1210-0015-f78e-97fdf717480c@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 10:57:16PM +0200, Armin Wolf wrote:
> Am 28.09.22 um 12:47 schrieb Andy Shevchenko:
> > On Tue, Sep 27, 2022 at 10:45:21PM +0200, Armin Wolf wrote:

...

> > > +static void dell_wmi_ddv_debugfs_init(struct wmi_device *wdev)
> > Strictly speaking this should return int (see below).
> > 
> > > +{
> > > +	struct dentry *entry;
> > > +	char name[64];
> > > +
> > > +	scnprintf(name, ARRAY_SIZE(name), "%s-%s", DRIVER_NAME, dev_name(&wdev->dev));
> > > +	entry = debugfs_create_dir(name, NULL);
> > > +
> > > +	debugfs_create_devm_seqfile(&wdev->dev, "fan_sensor_information", entry,
> > > +				    dell_wmi_ddv_fan_read);
> > > +	debugfs_create_devm_seqfile(&wdev->dev, "thermal_sensor_information", entry,
> > > +				    dell_wmi_ddv_temp_read);
> > > +
> > > +	devm_add_action_or_reset(&wdev->dev, dell_wmi_ddv_debugfs_remove, entry);
> > return devm...
> > 
> > This is not related to debugfs and there is no rule to avoid checking error
> > codes from devm_add_action_or_reset().
> > 
> According to the documentation of debugfs_create_dir(), drivers should work fine if debugfs
> initialization fails. Thus the the return value of dell_wmi_ddv_debugfs_init() would be ignored
> when called, which means that returning an error would serve no purpose.
> Additionally, devm_add_action_or_reset() automatically executes the cleanup function if devres
> registration fails, so we do not have to care about that.

The problem with your code that if devm_ call fails and you ain't stop probing
the remove-insert module (or unbind-bind) cycle will fail, because of existing
(leaked) debugfs dentries.

> > > +}

That said, you must check error code of devm_ call above. This is a potential
leak of resources right now in the code.

...

> > > +		.name = DRIVER_NAME,
> > I would use explicit literal since this is a (semi-) ABI, and having it as
> > a define feels not fully right.
> 
> The driver name is used in two places (init and debugfs), so having a define for it
> avoids problems in case someone forgets to change both.

Which is exactly what we must prevent developer to do. If changing debugfs it
mustn't change the driver name, because the latter is ABI, while the former is
not.

I think now you got my point.

-- 
With Best Regards,
Andy Shevchenko


