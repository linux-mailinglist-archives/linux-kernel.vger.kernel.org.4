Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AE16AD945
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCGIbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCGIbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:31:06 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE18B4989C;
        Tue,  7 Mar 2023 00:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678177862; x=1709713862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AM6ln3rEwrSobmh2w59/naDXELvfUoAjXqu07vSBDuc=;
  b=kRPCEZmS620hvL8rP+CZ7y34aZgIQyDKZmJYX30QoWHjLXUU4EycVmD9
   K+dsvLiYiiOuLAnyVIx8W35UXefsqLYL70yUXXd1ZhI1gftFDC0mzLKgr
   /HpftgYjN7pSmrq3ReoAUYEjv4KAzd50rKHT7xJRBohRw0chBmrOGE9iN
   jc9ddL+pjoZHq1LLj14Dx6Gghb+xMiAWGnlolX2gLBRJfDNXLyH6Au2Xu
   ChrAS0dMGfPYeFy8wAEGJ73g//KMXf6lztP8PROFhAH/5nw9DLzpfc/Qy
   ECePaAuSQscOj/oGKrWSbEyrSzwackAsQcx+gwu7w8xp4wRwa3oUQlH+k
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="324101924"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="324101924"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 00:30:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="740642801"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="740642801"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 00:30:22 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id A57D511F78D;
        Tue,  7 Mar 2023 10:30:19 +0200 (EET)
Date:   Tue, 7 Mar 2023 10:30:19 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Wu, Wentong" <wentong.wu@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
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
Message-ID: <ZAb2G7kqsEvrBhpG@kekkonen.localdomain>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <Y/8qJzScTfFucpP9@kekkonen.localdomain>
 <ae28faf8-c8a4-3f75-08d0-8e5233f2fa5d@redhat.com>
 <DM6PR11MB4316F4B72F98ADBF577412378DB79@DM6PR11MB4316.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR11MB4316F4B72F98ADBF577412378DB79@DM6PR11MB4316.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wentong,

On Tue, Mar 07, 2023 at 08:17:04AM +0000, Wu, Wentong wrote:
> 
> 
> > -----Original Message-----
> > From: Hans de Goede <hdegoede@redhat.com>
> > Sent: Wednesday, March 1, 2023 6:42 PM
> > 
> > Hi,
> > 
> > On 3/1/23 11:34, Sakari Ailus wrote:
> > > Hi Wentong,
> > >
> > > On Mon, Feb 13, 2023 at 10:23:44AM +0800, Wentong Wu wrote:
> > >> Intel Visual Sensing Controller (IVSC), codenamed "Clover Falls", is
> > >> a companion chip designed to provide secure and low power vision
> > >> capability to IA platforms. IVSC is available in existing commercial
> > >> platforms from multiple OEMs.
> > >>
> > >> The primary use case of IVSC is to bring in context awareness. IVSC
> > >> interfaces directly with the platform main camera sensor via a CSI-2
> > >> link and processes the image data with the embedded AI engine. The
> > >> detected events are sent over I2C to ISH (Intel Sensor Hub) for
> > >> additional data fusion from multiple sensors. The fusion results are
> > >> used to implement advanced use cases like:
> > >>  - Face detection to unlock screen
> > >>  - Detect user presence to manage backlight setting or waking up
> > >> system
> > >>
> > >> Since the Image Processing Unit(IPU) used on the host processor needs
> > >> to configure the CSI-2 link in normal camera usages, the CSI-2 link
> > >> and camera sensor can only be used in mutually-exclusive ways by host
> > >> IPU and IVSC. By default the IVSC owns the CSI-2 link and camera
> > >> sensor. The IPU driver can take ownership of the CSI-2 link and
> > >> camera sensor using interfaces provided by this IVSC driver.
> > >>
> > >> Switching ownership requires an interface with two different hardware
> > >> modules inside IVSC. The software interface to these modules is via
> > >> Intel MEI (The Intel Management Engine) commands. These two hardware
> > >> modules have two different MEI UUIDs to enumerate. These hardware
> > modules are:
> > >>  - ACE (Algorithm Context Engine): This module is for algorithm
> > >> computing when IVSC owns camera sensor. Also ACE module controls
> > >> camera sensor's ownership. This hardware module is used to set ownership
> > of camera sensor.
> > >>  - CSI (Camera Serial Interface): This module is used to route camera
> > >> sensor data either to IVSC or to host for IPU driver and application.
> > >>
> > >> IVSC also provides a privacy mode. When privacy mode is turned on,
> > >> camera sensor can't be used. This means that both ACE and host IPU
> > >> can't get image data. And when this mode is turned on, host IPU
> > >> driver is informed via a registered callback, so that user can be notified.
> > >>
> > >> In summary, to acquire ownership of camera by IPU driver, first ACE
> > >> module needs to be informed of ownership and then to setup MIPI CSI-2
> > >> link for the camera sensor and IPU.
> > >
> > > I thought this for a while and did some research, and I can suggest
> > > the
> > > following:
> > >
> > > - The IVSC sub-device implements a control for privacy (V4L2_CID_PRIVACY
> > >   is a good fit).
> > >
> > > - Camera sensor access needs to be requested from IVSC before accessing the
> > >   sensor via I²C. The IVSC ownership control needs to be in the right
> > >   setting for this to work, and device links can be used for that purpose
> > >   (see device_link_add()). With DL_FLAG_PM_RUNTIME and
> > DL_FLAG_RPM_ACTIVE,
> > >   the supplier devices will be PM runtime resumed before the consumer
> > >   (camera sensor). As these devices are purely virtual on host side and has
> > >   no power state as such, you can use runtime PM callbacks to transfer the
> > >   ownership.
> > 
> > Interesting proposal to use device-links + runtime-pm for this instead of
> > modelling this as an i2c-mux. FWIW I'm fine with going this route instead of
> > using an i2c-mux approach.
> > 
> > I have been thinking about the i2c-mux approach a bit and the problem is that
> > we are not really muxing but want to turn on/off control and AFAIK the i2c-mux
> > framework simply leaves the mux muxed to the last used i2c-chain, so control
> > will never be released when the i2c transfers are done.
> > 
> > And if were to somehow modify things (or maybe there already is some release
> > callback) then the downside becomes that the i2c-mux core code operates at
> > the i2c transfer level. So each i2c read/write would then enable + disavle control.
> > 
> > Modelling this using something like runtime pm as such is a much better fit
> > because then we request control once on probe / stream-on and release it once
> > we are fully done, rather then requesting + releasing control once per i2c-
> > transfer.
> 
> Seems runtime pm can't fix the problem of initial i2c transfer during sensor driver probe,
> probably we have to switch to i2c-mux modeling way.

What do you mean? The supplier devices are resumed before the driver's
probe is called.

-- 
Regards,

Sakari Ailus
