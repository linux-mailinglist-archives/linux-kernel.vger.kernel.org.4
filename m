Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF816DA01A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbjDFSnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDFSnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:43:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3357A83;
        Thu,  6 Apr 2023 11:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680806631; x=1712342631;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yTc4EfHLqOSKx48trH6VvTg2rSzrs9tBuH+cpg4WIqY=;
  b=HKIfP9Ve4KzReSHK9XRBmqAnRUgAHQwxKkDV1aLZ57p348OmJ/RHIR+n
   /qa/6fvqnE95/tR//BIsbC8YvdX6gL88c8wljH9VMrt0D9VHtEjFoeubZ
   Pa2bEIiT8zW7TIa4s/pUFwerlB8aqcKWaqgaUYfWf3wodBeFdS4C6sXaG
   6RhnK771X/4H0njiI/OoCY39hM7FLeGlppVPu91NPy124Z5Wpe2aliXrx
   aiHZ/VzuxAOiVeYh4ZUVCX9MKIPhbKl73YnN6bANYi/ZPQ8z26rq0oeEf
   r/u4d08nglWkodfMg0zS3x/0KicD7S72fxhcJKzXlr94GFi/yhcdIPeO4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="331452241"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="331452241"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 11:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="830862514"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="830862514"
Received: from mjjuenem-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.81.95])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 11:43:50 -0700
Message-ID: <ac5651148d4ab2b243597af9d42fa0e374d810a8.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Uncore frequency
 control via TPMI
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Apr 2023 11:43:50 -0700
In-Reply-To: <9ea89b86-c027-5a73-7ccb-0c3388b31f5f@redhat.com>
References: <20230328215328.101990-1-srinivas.pandruvada@linux.intel.com>
         <9ea89b86-c027-5a73-7ccb-0c3388b31f5f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

> > 

[...]

> > The TPMI documentation can be downloaded from:
> > https://github.com/intel/tpmi_power_management
> > 
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> 
> Thanks 3 small remarks below (inline), if you can address those then
> v2 should be ready for merging.
Sure. Will send an update.

> 
> > ---
> > The fine grain control at cluster level patches are here:
> > https://github.com/spandruvada/linux-kernel/commit/0d66ea4ff76ea19127f2d207a7e17bb86846ca32
> > https://github.com/spandruvada/linux-kernel/commit/cb5c2349a58318c04955821d6528cc8015541e65
> > But not submitting to ease in review process as I posted too many
> > patches this cycle.
> 
> As mentioned before, it helps if you can get fellow Intel folks to
> review.
I will add to the next version with reviewed-by and tested-by.

> 
> >  .../x86/intel/uncore-frequency/Kconfig        |   4 +
> >  .../x86/intel/uncore-frequency/Makefile       |   2 +
> >  .../uncore-frequency/uncore-frequency-tpmi.c  | 346
> > ++++++++++++++++++
> > 

[...]

> > +/* Information for each power domain */
> > +struct tpmi_uncore_power_domain_info {
> > +       void __iomem *uncore_base;
> 
> Maybe make this an:
> 
>         u8 __iomem *uncore_base;
> 
> To avoid all the casts below ?
> 
> Although I wonder if the casts are necessary at all, AFAIK void *
> arithmics are the same as u8 * arithmics, so things should work
> without the casts regardless ?
> 
You are right. I already don't cast in SST, I missed this one.

> Still just turning this into a u8 * is probably better.
I will change to u8*

> > 

[...]


> > +               pd_info->uncore_base =
> > devm_ioremap_resource(&auxdev->dev, res);
> > +               if (IS_ERR(pd_info->uncore_base)) {
> > +                       ret = PTR_ERR(pd_info->uncore_base);
> > +                       pd_info->uncore_base = NULL;
> 
> pd_info is part of tpmi_uncore and on error the:
> 
>         auxiliary_set_drvdata(auxdev, tpmi_uncore);
> 
> call is skipped, so pd_info will never be reachable (and should get
> freed by devm).
> So AFAICT, there is no need to NULL uncore_base  ?

Correct. Let me think of case when firmware messed up one power domain
base address (very unlikely as this is goes through several validation
levels), may be continue to check next power domain instead of return.

> 
> > +                       goto err_rem_common;
> > +               }
> > +
> > +               /* Check for version and skip this resource if
> > there is mismatch */
> > +               header = readq(pd_info->uncore_base);
> > +               pd_info->ufs_header_ver = header &
> > UNCORE_GENMASK_VERSION;
> > +               if (pd_info->ufs_header_ver !=
> > UNCORE_HEADER_VERSION) {
> > +                       dev_info(&auxdev->dev, "Uncore: Unsupported
> > version:%d\n",
> > +                               pd_info->ufs_header_ver);
> > +                       continue;
> > +               }
> > +
> > +               /* Get Cluster ID Mask */
> > +               cluster_mask =
> > FIELD_GET(UNCORE_LOCAL_FABRIC_CLUSTER_ID_MASK, header);
> > +               if (!cluster_mask) {
> > +                       dev_info(&auxdev->dev, "Uncore: Invalid
> > cluster mask:%x\n", cluster_mask);
> > +                       continue;
> > +               }
> > +
> > +               /* Find out number of clusters in this resource */
> > +               mask = 0x01;
> > +               for (j = 0; j < UNCORE_MAX_CLUSTER_PER_DOMAIN; ++j)
> > {
> > +                       if (cluster_mask & mask)
> > +                               pd_info->cluster_count++;
> > +                       mask <<= 1;
> > +               }
> > +
> > +               pd_info->cluster_infos = devm_kcalloc(&auxdev->dev,
> > pd_info->cluster_count,
> > +                                                     sizeof(struct
> > tpmi_uncore_cluster_info),
> > +                                                     GFP_KERNEL);
> 
> This devm_kcalloc() call is missing error checking.
Thanks for pointing.

Thanks,
Srinivas

> 
> > +
> > +               /*
> > +                * Each byte in the register point to status and
> > control
> > +                * registers belonging to cluster id 0-8.
> > +                */
> > +               cluster_offset = readq((u8 __iomem *)pd_info-
> > >uncore_base +
> > +                                       UNCORE_FABRIC_CLUSTER_OFFSE
> > T);
> > +
> > +               for (j = 0; j < pd_info->cluster_count; ++j) {
> > +                       struct tpmi_uncore_cluster_info
> > *cluster_info;
> > +
> > +                       /* Get the offset for this cluster */
> > +                       mask = (cluster_offset &
> > UNCORE_CLUSTER_OFF_MASK);
> > +                       /* Offset in QWORD, so change to bytes */
> > +                       mask <<= 3;
> > +
> > +                       cluster_info = &pd_info->cluster_infos[j];
> > +
> > +                       cluster_info->cluster_base = (u8 __iomem
> > *)pd_info->uncore_base + mask;
> > +
> > +                       cluster_info->uncore_data.package_id = pkg;
> > +                       /* There are no dies like Cascade Lake */
> > +                       cluster_info->uncore_data.die_id = 0;
> > +
> > +                       /* Point to next cluster offset */
> > +                       cluster_offset >>=
> > UNCORE_MAX_CLUSTER_PER_DOMAIN;
> > +               }
> > +       }
> > +
> > +       auxiliary_set_drvdata(auxdev, tpmi_uncore);
> > +
> > +       tpmi_uncore->root_cluster.uncore_root = tpmi_uncore;
> > +       tpmi_uncore->root_cluster.uncore_data.package_id = pkg;
> > +       ret = uncore_freq_add_entry(&tpmi_uncore-
> > >root_cluster.uncore_data, 0);
> > +       if (ret)
> > +               goto err_rem_common;
> > +
> > +       return 0;
> > +
> > +err_rem_common:
> > +       uncore_freq_common_exit();
> > +
> > +       return ret;
> > +}
> > +
> > +static int tpmi_uncore_remove(struct auxiliary_device *auxdev)
> > +{
> > +       struct tpmi_uncore_struct *tpmi_uncore =
> > auxiliary_get_drvdata(auxdev);
> > +
> > +       uncore_freq_remove_die_entry(&tpmi_uncore-
> > >root_cluster.uncore_data);
> > +
> > +       uncore_freq_common_exit();
> > +
> > +       return 0;
> > +}
> > +
> > +static int intel_uncore_probe(struct auxiliary_device *auxdev,
> > const struct auxiliary_device_id *id)
> > +{
> > +       return tpmi_uncore_init(auxdev);
> > +}
> > +
> > +static void intel_uncore_remove(struct auxiliary_device *auxdev)
> > +{
> > +       tpmi_uncore_remove(auxdev);
> > +}
> > +
> > +static const struct auxiliary_device_id intel_uncore_id_table[] =
> > {
> > +       { .name = "intel_vsec.tpmi-uncore" },
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(auxiliary, intel_uncore_id_table);
> > +
> > +static struct auxiliary_driver intel_uncore_aux_driver = {
> > +       .id_table       = intel_uncore_id_table,
> > +       .remove         = intel_uncore_remove,
> > +       .probe          = intel_uncore_probe,
> > +};
> > +
> > +module_auxiliary_driver(intel_uncore_aux_driver);
> > +
> > +MODULE_IMPORT_NS(INTEL_TPMI);
> > +MODULE_IMPORT_NS(INTEL_UNCORE_FREQUENCY);
> > +MODULE_DESCRIPTION("Intel TPMI UFS Driver");
> > +MODULE_LICENSE("GPL");
> 
> 
> Regards,
> 
> Hans
> 
> 

