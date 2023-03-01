Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13DE6A6ADD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 11:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCAKec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 05:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCAKe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 05:34:26 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D39305DF;
        Wed,  1 Mar 2023 02:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677666865; x=1709202865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fcPQNsxpm6z5PSJbqO75a0IVYJg92k5c+FNXtKv/Fj4=;
  b=aYjPNPW67tuF3soAcgXVnvXBGyLeSECPz1JzCSI55j6KXy4y+1SH8uHZ
   FJj0Hy397bn6cOG+4aN67FWxoQIVD6+VgTAqKFFroRw3pQfhOvaMbx+z4
   d45mARz7iS4Ks72ncfXfnHMM/zV8OG2IMAzSXk4NhR/czto8/ZasLmepj
   LAgEDX/8UVLZ6u2tMGg/1cTdfULGx4JQXQmnVlei3ST8uA1mlV5HA9mvH
   MXIOE4cRtyPR3ygstTTIMqJrSTfx+NGY7JcqkazJJaQOaCzsUkR/chtSF
   kiDdUL6oAAqtLHUkXsRRZbRoqvLaVBUDQpfjHWSQV2iR0yTgpZSSJJorE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="322637654"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="322637654"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:34:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="624439707"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="624439707"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:34:19 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id ADB0C120362;
        Wed,  1 Mar 2023 12:34:15 +0200 (EET)
Date:   Wed, 1 Mar 2023 12:34:15 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Wentong Wu <wentong.wu@intel.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        srinivas.pandruvada@intel.com,
        pierre-louis.bossart@linux.intel.com, zhifeng.wang@intel.com,
        xiang.ye@intel.com, tian.shu.qiu@intel.com, bingbu.cao@intel.com,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Message-ID: <Y/8qJzScTfFucpP9@kekkonen.localdomain>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230213022347.2480307-1-wentong.wu@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wentong,

On Mon, Feb 13, 2023 at 10:23:44AM +0800, Wentong Wu wrote:
> Intel Visual Sensing Controller (IVSC), codenamed "Clover Falls", is a
> companion chip designed to provide secure and low power vision capability
> to IA platforms. IVSC is available in existing commercial platforms from
> multiple OEMs.
> 
> The primary use case of IVSC is to bring in context awareness. IVSC
> interfaces directly with the platform main camera sensor via a CSI-2 link
> and processes the image data with the embedded AI engine. The detected
> events are sent over I2C to ISH (Intel Sensor Hub) for additional data
> fusion from multiple sensors. The fusion results are used to implement
> advanced use cases like:
>  - Face detection to unlock screen
>  - Detect user presence to manage backlight setting or waking up system
> 
> Since the Image Processing Unit(IPU) used on the host processor needs to
> configure the CSI-2 link in normal camera usages, the CSI-2 link and
> camera sensor can only be used in mutually-exclusive ways by host IPU and
> IVSC. By default the IVSC owns the CSI-2 link and camera sensor. The IPU
> driver can take ownership of the CSI-2 link and camera sensor using
> interfaces provided by this IVSC driver.
> 
> Switching ownership requires an interface with two different hardware
> modules inside IVSC. The software interface to these modules is via Intel
> MEI (The Intel Management Engine) commands. These two hardware modules
> have two different MEI UUIDs to enumerate. These hardware modules are:
>  - ACE (Algorithm Context Engine): This module is for algorithm computing
> when IVSC owns camera sensor. Also ACE module controls camera sensor's
> ownership. This hardware module is used to set ownership of camera sensor.
>  - CSI (Camera Serial Interface): This module is used to route camera
> sensor data either to IVSC or to host for IPU driver and application.
> 
> IVSC also provides a privacy mode. When privacy mode is turned on,
> camera sensor can't be used. This means that both ACE and host IPU can't
> get image data. And when this mode is turned on, host IPU driver is
> informed via a registered callback, so that user can be notified.
> 
> In summary, to acquire ownership of camera by IPU driver, first ACE
> module needs to be informed of ownership and then to setup MIPI CSI-2
> link for the camera sensor and IPU.

I thought this for a while and did some research, and I can suggest the
following:

- The IVSC sub-device implements a control for privacy (V4L2_CID_PRIVACY
  is a good fit).

- Camera sensor access needs to be requested from IVSC before accessing the
  sensor via I²C. The IVSC ownership control needs to be in the right
  setting for this to work, and device links can be used for that purpose
  (see device_link_add()). With DL_FLAG_PM_RUNTIME and DL_FLAG_RPM_ACTIVE,
  the supplier devices will be PM runtime resumed before the consumer
  (camera sensor). As these devices are purely virtual on host side and has
  no power state as such, you can use runtime PM callbacks to transfer the
  ownership.

- The CSI-2 configuration should take place when streaming starts on the
  sensor (as well as IVSC).

- Device links need to be set up via IPU bridge which now is called  CIO2
  bridge (cio2-bridge.c).

Any questions, comments?

-- 
Kind regards,

Sakari Ailus
