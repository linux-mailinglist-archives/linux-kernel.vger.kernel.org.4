Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A25867D2E6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjAZRRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjAZRRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:17:50 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDC91BCF;
        Thu, 26 Jan 2023 09:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674753467; x=1706289467;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b7Spntogh5Ps68+tL6zpclEU2jPr+rJmf4JqoHkUBgw=;
  b=Kosofd6FAWzT01gsv/6jKgR1eAlNxGKsm0v6WMd9GY+qh9csDNOXITlF
   LIdv4M2jrUbC94velY8g5klxAcQnrNrafjSurODx7eeOd4PF+mqo40JLn
   aLs5RQlMhD+0hm+l3HZy9eFibnJdhk2gVsFI+MvnW5NrvvbuLNxcKBUGN
   qIjHc1tOP2TFs5EzDUy6txfmbt26UvpcUUhFSr18x5kB0CKGykV6TRpWw
   +SazaV3a5jEcghY/cwSB3cy2p+LtliWq784S+Qc3AqaAiw/xyWuyJQMpk
   L6GtWFC3mRvAl66G4LImYxhUR5uwwuRbZCN/WngXXwEm+fZfT8QYc81pM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="326903693"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="326903693"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 09:17:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="836785192"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="836785192"
Received: from linjiaji-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.70.36])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 09:17:18 -0800
Message-ID: <3c45463d2dc546b4198272107738cc073b3d23c0.camel@linux.intel.com>
Subject: Re: [PATCH v1 0/3] thermal: intel: int340x: Use generic trip points
 table
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Thu, 26 Jan 2023 09:17:18 -0800
In-Reply-To: <5926007.lOV4Wx5bFT@kreacher>
References: <5665899.DvuYhMxLoT@kreacher>
         <CAJZ5v0iVqGoVq1TVvYoQLxRWnP1nTPe7seeQvbVPancxH_6J1g@mail.gmail.com>
         <10ad845597c47b8b7d1ba1aa9fe93825d249f56e.camel@linux.intel.com>
         <5926007.lOV4Wx5bFT@kreacher>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Thu, 2023-01-26 at 14:13 +0100, Rafael J. Wysocki wrote:
> On Thursday, January 26, 2023 1:02:59 AM CET srinivas pandruvada
> wrote:
> > Hi Rafael,
> > 
> > 
> 

[...]

> I've added the appended patch to the thermal-intel-test branch.  Can
> you please
> check if it makes that difference in behavior go away?
I synced the tree again and your patch in thermal-intel-test fixes the
issue.

Thanks,
Srinivas
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] thermal: ACPI: Initialize trips if temperature is
> out of range
> 
> In some cases it is still useful to register a trip point if the
> temperature returned by the corresponding ACPI thermal object (for
> example, _HOT) is invalid to start with, because the same ACPI
> thermal object may start to return a valid temperature after a
> system configuration change (for example, from an AC power source
> to battery an vice versa).
> 
> For this reason, if the ACPI thermal object evaluated by
> thermal_acpi_trip_init() successfully returns a temperature value
> that
> is out of the range of values taken into account, initialize the trip
> point using THERMAL_TEMP_INVALID as the temperature value instead of
> returning an error to allow the user of the trip point to decide what
> to do with it.
> 
> Also update pch_wpt_add_acpi_psv_trip() to reject trip points with
> invalid temperature values.
> 
> Fixes: 7a0e39748861 ("thermal: ACPI: Add ACPI trip point routines")
> Reported-by: Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/thermal/intel/intel_pch_thermal.c |    2 +-
>  drivers/thermal/thermal_acpi.c            |    7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_acpi.c
> +++ linux-pm/drivers/thermal/thermal_acpi.c
> @@ -64,13 +64,14 @@ static int thermal_acpi_trip_init(struct
>                 return -ENODATA;
>         }
>  
> -       if (temp < TEMP_MIN_DECIK || temp >= TEMP_MAX_DECIK) {
> +       if (temp >= TEMP_MIN_DECIK && temp <= TEMP_MAX_DECIK) {
> +               trip->temperature =
> deci_kelvin_to_millicelsius(temp);
> +       } else {
>                 acpi_handle_debug(adev->handle, "%s result %llu out
> of range\n",
>                                   obj_name, temp);
> -               return -ENODATA;
> +               trip->temperature = THERMAL_TEMP_INVALID;
>         }
>  
> -       trip->temperature = deci_kelvin_to_millicelsius(temp);
>         trip->hysteresis = 0;
>         trip->type = type;
>  
> Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
> +++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
> @@ -107,7 +107,7 @@ static void pch_wpt_add_acpi_psv_trip(st
>                 return;
>  
>         ret = thermal_acpi_trip_passive(adev, &ptd-
> >trips[*nr_trips]);
> -       if (ret)
> +       if (ret || ptd->trips[*nr_trips].temperature <= 0)
>                 return;
>  
>         ++(*nr_trips);
> 
> 
> 

