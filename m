Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07693699548
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBPNM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBPNM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:12:56 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C886196;
        Thu, 16 Feb 2023 05:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676553174; x=1708089174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oA5RgJJpAq5UHJHvgQA/ufGiWBI4ibAgsdQPXkJlx/Q=;
  b=mX/sEg5c3IPyvA17vZXHWBQPIjPZseF3N3/Ytd0q1lGuz6EtOhypMWAW
   zx9+VdHyfVo7Nx1N+PpQxkunPeJ2qgu9mHHQLZ+1ZnUZ9pwymzEfet8XZ
   Qo4c+4y0LtKB7kHTMO7yTaYgOspRb1oDjfsG1yN57LZToBiqhfQ/RlzhG
   rtIDOZDFQsvlxI4ogd6B8xkDUtIjL/wq9nGrbEk6LVfly/dg3LaeNmV73
   cHKZmkySWbaZm8YbO7oOsBrZWe0+nD4tfMdpecbm/2NTnmvq6WBLYjpRe
   Dm+DYvdmv0EMjf1rXBRHXcR1UV4mt8SrcRs4N35qotGRNsZXJKLSSJy1K
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="396355423"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="396355423"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:12:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="670123452"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="670123452"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:12:25 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 92E95121932;
        Thu, 16 Feb 2023 15:12:21 +0200 (EET)
Date:   Thu, 16 Feb 2023 15:12:21 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Bingbu Cao <bingbu.cao@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wentong Wu <wentong.wu@intel.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, srinivas.pandruvada@intel.com,
        pierre-louis.bossart@linux.intel.com, zhifeng.wang@intel.com,
        xiang.ye@intel.com, tian.shu.qiu@intel.com, bingbu.cao@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Message-ID: <Y+4rtSMArg5ow0Sh@kekkonen.localdomain>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <Y+ypKYI4c6fHL4Eu@pendragon.ideasonboard.com>
 <00c5c16e-c94e-a328-06d9-5f09ad35258d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c5c16e-c94e-a328-06d9-5f09ad35258d@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bingbu, Wentong,

On Wed, Feb 15, 2023 at 08:09:50PM +0800, Bingbu Cao wrote:
> 
> Hi, Wentong,
> 
> On 2/15/23 5:43 PM, Laurent Pinchart wrote:
> > Hello Wentong,
> > 
> > On Mon, Feb 13, 2023 at 10:23:44AM +0800, Wentong Wu wrote:
> >> Intel Visual Sensing Controller (IVSC), codenamed "Clover Falls", is a
> >> companion chip designed to provide secure and low power vision capability
> >> to IA platforms. IVSC is available in existing commercial platforms from
> >> multiple OEMs.
> >>
> >> The primary use case of IVSC is to bring in context awareness. IVSC
> >> interfaces directly with the platform main camera sensor via a CSI-2 link
> >> and processes the image data with the embedded AI engine. The detected
> >> events are sent over I2C to ISH (Intel Sensor Hub) for additional data
> >> fusion from multiple sensors. The fusion results are used to implement
> >> advanced use cases like:
> >>  - Face detection to unlock screen
> >>  - Detect user presence to manage backlight setting or waking up system
> > 
> > Do you have plan to support these features in the ivsc driver in the
> > future ?
> > 
> >> Since the Image Processing Unit(IPU) used on the host processor needs to
> >> configure the CSI-2 link in normal camera usages, the CSI-2 link and
> >> camera sensor can only be used in mutually-exclusive ways by host IPU and
> >> IVSC. By default the IVSC owns the CSI-2 link and camera sensor. The IPU
> >> driver can take ownership of the CSI-2 link and camera sensor using
> >> interfaces provided by this IVSC driver.
> >>
> >> Switching ownership requires an interface with two different hardware
> >> modules inside IVSC. The software interface to these modules is via Intel
> >> MEI (The Intel Management Engine) commands. These two hardware modules
> >> have two different MEI UUIDs to enumerate. These hardware modules are:
> >>  - ACE (Algorithm Context Engine): This module is for algorithm computing
> >> when IVSC owns camera sensor. Also ACE module controls camera sensor's
> >> ownership. This hardware module is used to set ownership of camera sensor.
> >>  - CSI (Camera Serial Interface): This module is used to route camera
> >> sensor data either to IVSC or to host for IPU driver and application.
> >>
> >> IVSC also provides a privacy mode. When privacy mode is turned on,
> >> camera sensor can't be used. This means that both ACE and host IPU can't
> >> get image data. And when this mode is turned on, host IPU driver is
> >> informed via a registered callback, so that user can be notified.
> > 
> > How does the privacy mode work, and how can the user trust that the
> > closed-source IVSC and IME firmwares will honour the privacy settings ?
> >
> 
> Continue with question from Laurent,
> 
> How IVSC handle the privacy request from user? Is there some notification
> mechanism to user-space? I'd have concern if IVSC driver need private callback
> to request back-end(e.g. ISP driver) to handle stream cutting.

How does the privacy mode work, does it just pass zeroes (or other dummy
data) towards the host or nothing?

A V4L2 control can be used for the purpose of passing the information to
the user space at least.

-- 
Regards,

Sakari Ailus
