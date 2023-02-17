Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A0269A964
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBQKuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBQKt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:49:57 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122475FD7;
        Fri, 17 Feb 2023 02:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676630996; x=1708166996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O+mHzQSlbuG5WOZs3mRUmw8gyZ8jtCsCQALBsk2fkWE=;
  b=BJ5xRDxzZcc3vsYtUaPOiw5xfqY6bKwCrSDvMlm9S5R6q9u8R++j66fT
   hhzgxA7YL9tBpZ7e789zg466NWV1uL7MvJRgGCW19UlVB/TgaOWzsO+21
   +dupA/lz/w/rWRvlz53kpq0DKqXKEtmtdNbF5jCQg/cyAU64QdYdoYXuf
   N96boNDyAZMN0KrXcaDg1/1hoaLvx9R1N1Otbd0dPO3FBhvFNtDmGY+5k
   RpiBrEnN9Plyz5RTj7bWBGEYr9gSQUyvPhgh13kdW6Jsht29uiYSB515Z
   N+DgFwirEfQKhMu4q+9djoFh5in/LNAjQGlohkobkGvkFaI2gtDNQg1u4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="315676224"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="315676224"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 02:49:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="648038784"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="648038784"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 02:49:37 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id F0DEA11FC11;
        Fri, 17 Feb 2023 12:49:34 +0200 (EET)
Date:   Fri, 17 Feb 2023 12:49:34 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Wu, Wentong" <wentong.wu@intel.com>
Cc:     Bingbu Cao <bingbu.cao@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "Ye, Xiang" <xiang.ye@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Message-ID: <Y+9bvl5SA2a1nXhe@kekkonen.localdomain>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <Y+ypKYI4c6fHL4Eu@pendragon.ideasonboard.com>
 <00c5c16e-c94e-a328-06d9-5f09ad35258d@linux.intel.com>
 <Y+4rtSMArg5ow0Sh@kekkonen.localdomain>
 <8022b9da-e033-b77b-914c-d35a31aac2e2@linux.intel.com>
 <DM6PR11MB4316F7C9854B113556466BF58DA19@DM6PR11MB4316.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4316F7C9854B113556466BF58DA19@DM6PR11MB4316.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wentong,

On Fri, Feb 17, 2023 at 06:28:32AM +0000, Wu, Wentong wrote:
> 
> 
> > -----Original Message-----
> > From: Bingbu Cao <bingbu.cao@linux.intel.com>
> > Sent: Friday, February 17, 2023 9:44 AM
> > 
> > Hi, Sakari,
> > 
> > On 2/16/23 9:12 PM, Sakari Ailus wrote:
> > > Hi Bingbu, Wentong,
> > >
> > > On Wed, Feb 15, 2023 at 08:09:50PM +0800, Bingbu Cao wrote:
> > >>
> > >> Hi, Wentong,
> > >>
> > >> On 2/15/23 5:43 PM, Laurent Pinchart wrote:
> > >>> Hello Wentong,
> > >>>
> > >>> On Mon, Feb 13, 2023 at 10:23:44AM +0800, Wentong Wu wrote:
> > >>>> Intel Visual Sensing Controller (IVSC), codenamed "Clover Falls",
> > >>>> is a companion chip designed to provide secure and low power vision
> > >>>> capability to IA platforms. IVSC is available in existing
> > >>>> commercial platforms from multiple OEMs.
> > >>>>
> > >>>> The primary use case of IVSC is to bring in context awareness. IVSC
> > >>>> interfaces directly with the platform main camera sensor via a
> > >>>> CSI-2 link and processes the image data with the embedded AI
> > >>>> engine. The detected events are sent over I2C to ISH (Intel Sensor
> > >>>> Hub) for additional data fusion from multiple sensors. The fusion
> > >>>> results are used to implement advanced use cases like:
> > >>>>  - Face detection to unlock screen
> > >>>>  - Detect user presence to manage backlight setting or waking up
> > >>>> system
> > >>>
> > >>> Do you have plan to support these features in the ivsc driver in the
> > >>> future ?
> > >>>
> > >>>> Since the Image Processing Unit(IPU) used on the host processor
> > >>>> needs to configure the CSI-2 link in normal camera usages, the
> > >>>> CSI-2 link and camera sensor can only be used in mutually-exclusive
> > >>>> ways by host IPU and IVSC. By default the IVSC owns the CSI-2 link
> > >>>> and camera sensor. The IPU driver can take ownership of the CSI-2
> > >>>> link and camera sensor using interfaces provided by this IVSC driver.
> > >>>>
> > >>>> Switching ownership requires an interface with two different
> > >>>> hardware modules inside IVSC. The software interface to these
> > >>>> modules is via Intel MEI (The Intel Management Engine) commands.
> > >>>> These two hardware modules have two different MEI UUIDs to enumerate.
> > These hardware modules are:
> > >>>>  - ACE (Algorithm Context Engine): This module is for algorithm
> > >>>> computing when IVSC owns camera sensor. Also ACE module controls
> > >>>> camera sensor's ownership. This hardware module is used to set ownership
> > of camera sensor.
> > >>>>  - CSI (Camera Serial Interface): This module is used to route
> > >>>> camera sensor data either to IVSC or to host for IPU driver and application.
> > >>>>
> > >>>> IVSC also provides a privacy mode. When privacy mode is turned on,
> > >>>> camera sensor can't be used. This means that both ACE and host IPU
> > >>>> can't get image data. And when this mode is turned on, host IPU
> > >>>> driver is informed via a registered callback, so that user can be notified.
> > >>>
> > >>> How does the privacy mode work, and how can the user trust that the
> > >>> closed-source IVSC and IME firmwares will honour the privacy settings ?
> > 
> > As I know, without IVSC, once user enable the privacy mode, the Intel
> > Converged Security Engine will configure the IPU camera mask (security register),
> > which will mask the specific CSI2 port and produce dummy imaging data. For the
> > case with IVSC, there is no final solution on Linux so far I think.
> > 
> > Wentong, is IVSC trying to cut off the stream and then notify user and IPU?
> 
> yes

Does the CSI-2 transmitter on IVCS go to some LP mode during this time, or
does the receiver need to initialise the bus again when the stream resuems?

> 
> > 
> > >>>
> > >>
> > >> Continue with question from Laurent,
> > >>
> > >> How IVSC handle the privacy request from user? Is there some
> > >> notification mechanism to user-space?
> 
> IVSC has already defined privacy callback for host IPU/camera driver.
> 
> > > I'd have concern if IVSC driver
> > >> need private callback to request back-end(e.g. ISP driver) to handle stream
> > cutting.
> > >
> > > How does the privacy mode work, does it just pass zeroes (or other
> > > dummy
> > > data) towards the host or nothing?
> 
> No data on CSI transmitter side

Can it stop in the middle of the frame? Or is it guaranteed to produce full
frames (assuming the sensor does)?

> 
> > >
> > > A V4L2 control can be used for the purpose of passing the information
> > > to the user space at least.
> 
> I will take some time to review V4L2 sub-device and control mechanism,
> and then update the driver.

-- 
Kind regards,

Sakari Ailus
