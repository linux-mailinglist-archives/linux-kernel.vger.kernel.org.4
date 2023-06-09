Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5D7729624
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjFIJ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbjFIJ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:58:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F1D3AB2;
        Fri,  9 Jun 2023 02:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686304271; x=1717840271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AvruXqThihYTdwzn7jJFQ7xk66jtEf/aSgqQmsYKfpM=;
  b=DVt97gJNS+CKMH1Ws0aM6MNWaFOnG9wtNfKAXepJhK+Wqd027JWTJrJY
   EWhSGrylWWbgG2EqHfw4eoHzfSCEtNB5h3JUraXehHpXj7STjn8A9vFOC
   sE4XP0e32P1+MZwdonBu/SsK2siBZCLPc7fM8XtXhaliBh/uH2Ft+R28u
   Zy7QxCPSyWa7Bz5miTQzFBRLtru7RkL9IUQKOIz2kIFf/h8kv4wLlqBzf
   wGEsruILjzG8fw9R9wh+xBj7+HzmoR/M7NHNpah0AgTlKo9LXbNvD7IAu
   l5iQQmhb5d65VCWcToA2DEHFT5jzg2w0RJrfP+mzbUWxm4w1vqmQWGgK4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342239922"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="342239922"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713454261"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="713454261"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:51:08 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 65F3011F9D2;
        Fri,  9 Jun 2023 12:51:04 +0300 (EEST)
Date:   Fri, 9 Jun 2023 09:51:04 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 0/6] ACPI: scan: MIPI DiSco for Imaging support
Message-ID: <ZIL2CPyNpy4xCfdn@kekkonen.localdomain>
References: <13276375.uLZWGnKmhe@kreacher>
 <CAJZ5v0gKaheHVfRcgFx_3JdBp9bw5nUQXYp9vZP4RVVXzdb7uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gKaheHVfRcgFx_3JdBp9bw5nUQXYp9vZP4RVVXzdb7uw@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Wed, May 24, 2023 at 08:06:09PM +0200, Rafael J. Wysocki wrote:
> On Wed, May 24, 2023 at 1:48 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > Hi Folks,
> >
> > This basically is a re-write of a recent patch series from Sakari:
> >
> > https://lore.kernel.org/linux-acpi/20230329100951.1522322-1-sakari.ailus@linux.intel.com
> >
> > The general idea is the same - CSI-2 resource descriptors, introduced in
> > ACPI 6.4 and defined by
> >
> > https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#camera-serial-interface-csi-2-connection-resource-descriptor
> >
> > are found and used for creating a set of software nodes that represent the CSI-2
> > connection graph.
> >
> > These software nodes need to be available before any scan handlers or ACPI drivers
> > are bound to any struct acpi_device objects, so all of that is done at the early
> > stage of ACPI device enumeration, but unnecessary ACPI namespace walks are avoided.
> >
> > The CSI-2 software nodes are populated with data extracted from the CSI-2 resource
> > descriptors themselves and from device properties defined by the MIPI DiSco for
> > Imaging specification (see https://www.mipi.org/specifications/mipi-disco-imaging).
> >
> > Patches [4,6/6] come from the original series directly, but the other patches have
> > been changes substantially, so I've decided to re-start patch series versioning from
> > scratch.
> >
> > This series is based on the patch at
> >
> > https://patchwork.kernel.org/project/linux-acpi/patch/12223415.O9o76ZdvQC@kreacher/
> >
> > applied on top of 6.4-rc3.
> >
> > Later on, I'll put all of this material into a special git branch for easier
> > access.
> 
> The patches are now available from the acpi-mipi-disco-imaging branch
> in the linux-pm.git tree at kernel.org.

I've been doing some testing on this version.

It oopses and that's relatively easy to fix by removing the kfree() that
releases memory of the software nodes and properties.

It doesn't work with that change either, it would seem like that the _CRS
CSI2 data is (most of the time) released before it gets used for creating
the software nodes, leading node registration to fail. This appears to be
taking place in different processes --- there's a work queue.

Moving the release of the _CRS CSI-2 resources to where they are no longer
needed makes the system crash early at boot. I've yet to debug this
further.

-- 
Regards,

Sakari Ailus
