Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEEC6FA211
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjEHIWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjEHIVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:21:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC291FAA0;
        Mon,  8 May 2023 01:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683534075; x=1715070075;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=u8U6CpU+Uixx4b0Yc9a9cuI2RB9dOyCILQo/ufHu6C8=;
  b=Opj9L37u6PB8pm2Um1CR7FqbitSVXooCBj421PHAEtLVyRz8Y99wPde3
   lw50uw/oainX1ey1er+lTRMRlidAC5j8NJL2WNlAH1MjEtlIYx08Fq3dk
   mhcWkdLTvNLM58qG+/P/IxeV0ateYlyn8YA0R7cNXJ2Q6IimVuzQ99qaj
   SXMMYq5UlI564do58o3wi7LZa/ujOSz4j1Szth5bQ9mLkhSZtpw/oGdqg
   2svmvpJ5l5UXpb4UO9d7fzJ7ZRwQzbbLBHnmZXqbC83/NiCZCOKesRpe5
   dFRIMpoWFFqBnZjt80pcOkSov1GeyLaqVid+6TZf1tUE3woXi2mSWTVl7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="348416217"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="348416217"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="944762598"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="944762598"
Received: from cciobanu-mobl1.ger.corp.intel.com ([10.249.37.159])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:21:12 -0700
Date:   Mon, 8 May 2023 11:21:10 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Luke Jones <luke@ljones.dev>
cc:     platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        acpi4asus-user@lists.sourceforge.net, hdegoede@redhat.com,
        corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
In-Reply-To: <TWL7UR.KE812U8BYMG8@ljones.dev>
Message-ID: <39570a-d3a-13b9-f2d-e75b3d60c6c4@linux.intel.com>
References: <20230505043013.2622603-1-luke@ljones.dev> <20230505043013.2622603-2-luke@ljones.dev> <9f77e8fd-38fe-818f-2fee-ca3bf4243576@linux.intel.com> <TWL7UR.KE812U8BYMG8@ljones.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-487321179-1683533721=:1790"
Content-ID: <5dca5e23-df7d-2774-ed31-47f8441772@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-487321179-1683533721=:1790
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <e862af48-2873-40a0-439c-ebca6f841dcc@linux.intel.com>

On Sat, 6 May 2023, Luke Jones wrote:
> On Fri, May 5 2023 at 16:08:16 +0300, Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Fri, 5 May 2023, Luke D. Jones wrote:
> > 
> > >  Add support for the WMI methods used to turn off and adjust the
> > >  brightness of the secondary "screenpad" device found on some high-end
> > >  ASUS laptops like the GX650P series and others.
> > > 
> > >  These methods are utilised in a new backlight device named:
> > >  - asus_screenpad
> > > 
> > >  Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > >  ---

> > >  @@ -3208,6 +3209,129 @@ static int is_display_toggle(int code)
> > >   	return 0;
> > >   }
> > > 
> > >  +/* Screenpad backlight */
> > >  +
> > >  +static int read_screenpad_backlight_power(struct asus_wmi *asus)
> > >  +{
> > >  +	int ret = asus_wmi_get_devstate_simple(asus,
> > > ASUS_WMI_DEVID_SCREENPAD_POWER);
> > 
> > Please move this to own line because now you have the extra newline
> > in between the call and error handling.
> 
> I don't understand what you mean sorry. Remove the new line or:
> int ret;
> ret = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_SCREENPAD_POWER);

Don't do:

int func()
{
	int ret = func();

	if (ret < 0)
		return ret;
	...
}

But do:

int func()
{
	int ret;

	ret = func();
	if (ret < 0)
		return ret;
	...
}

This keeps the error handling next to the actual call following the usual 
error handling pattern (natural logic grouping). The added clarity is well 
worth the one extra line required.

> > >  +static int update_screenpad_bl_status(struct backlight_device *bd)
> > >  +{
> > >  +	struct asus_wmi *asus = bl_get_data(bd);
> > >  +	int power, err = 0;
> > >  +	u32 ctrl_param;
> > >  +
> > >  +	power = read_screenpad_backlight_power(asus);
> > >  +	if (power == -ENODEV)
> > >  +		return err;
> > 
> > Just return 0. Or is there perhaps something wrong/missing here?
> 
> I thought the correct thing was to return any possible error state (here,
> anything less than 0 would be an error, right?)

I think this was covered already but here what I meant, use either:
	return 0;
because err is always 0 at that point, or:
	return power;
Depending on which is correct, I wasn't sure because you had this after 
it:

> > >  +	else if (power < 0)
> > >  +		return power;

...So I thought you might really intentionally wanted to return 0 there.


-- 
 i.
--8323329-487321179-1683533721=:1790--
