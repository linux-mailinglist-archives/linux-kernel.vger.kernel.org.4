Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BDF6FEEEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbjEKJd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237706AbjEKJdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:33:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA559EE4;
        Thu, 11 May 2023 02:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683797576; x=1715333576;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Im5pkr2QRlb8LR+SYpjjhDpJdt78iPfURYZcShZDMQg=;
  b=lKtiODNvOm4/R4EsWR8dWM/mWFmJkw/9GKFKU+b1y1HmVqXN9mjSu4TU
   UcGg8VPxXD/gf4cdy9mN0woFMMO28PAoY4MKz1wXP+cWGbv9igW75N7h5
   K0ouQU5OPJYlpI+3TFSgPAW7Po5g1zzY6PU21b+PDDjbgWhao+zRtSIhE
   IO2U3wteCG+eCDIMPmTn/6YR6m8J+I7cAEAU8MdDlCgI4SxwZ0bNoBmGG
   XMcHfQkKGkQWLcKwrzznk8EUQq1ViC8wL9ZT6RxO7qtucMZj+2O6Anrh1
   htUs+FK9+gRpMaHvMDa+aEcDMxlfBy2cACg4WpguigJPBn+SpHbiDe9AL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="413778616"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="413778616"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 02:32:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="873902817"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="873902817"
Received: from jsanche3-mobl1.ger.corp.intel.com ([10.252.39.112])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 02:32:53 -0700
Date:   Thu, 11 May 2023 12:32:51 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, thomas@t-8ch.de
Subject: Re: [PATCH v12 11/13] HP BIOSCFG driver - surestart-attributes
In-Reply-To: <CAOOmCE_dRivApf46KO1Cq-vHGsHVXNVCqbqF2NV4Y6SVpYx6hA@mail.gmail.com>
Message-ID: <79db2a99-5cd7-19c0-212d-9e28869a6a18@linux.intel.com>
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-12-jorge.lopez2@hp.com> <ef445e78-5751-bd8f-44ce-d9beaebaac6@linux.intel.com> <CAOOmCE_dRivApf46KO1Cq-vHGsHVXNVCqbqF2NV4Y6SVpYx6hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-624878464-1683797575=:1900"
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

--8323329-624878464-1683797575=:1900
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 10 May 2023, Jorge Lopez wrote:

> On Tue, May 9, 2023 at 8:57 AM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Fri, 5 May 2023, Jorge Lopez wrote:
> >
> > > HP BIOS Configuration driver purpose is to provide a driver supporting
> > > the latest sysfs class firmware attributes framework allowing the user
> > > to change BIOS settings and security solutions on HP Inc.’s commercial
> > > notebooks.
> > >
> > > Many features of HP Commercial notebooks can be managed using Windows
> > > Management Instrumentation (WMI). WMI is an implementation of Web-Based
> > > Enterprise Management (WBEM) that provides a standards-based interface
> > > for changing and monitoring system settings. HP BIOSCFG driver provides
> > > a native Linux solution and the exposed features facilitates the
> > > migration to Linux environments.
> > >
> > > The Linux security features to be provided in hp-bioscfg driver enables
> > > managing the BIOS settings and security solutions via sysfs, a virtual
> > > filesystem that can be used by user-mode applications. The new
> > > documentation cover HP-specific firmware sysfs attributes such Secure
> > > Platform Management and Sure Start. Each section provides security
> > > feature description and identifies sysfs directories and files exposed
> > > by the driver.
> > >
> > > Many HP Commercial notebooks include a feature called Secure Platform
> > > Management (SPM), which replaces older password-based BIOS settings
> > > management with public key cryptography. PC secure product management
> > > begins when a target system is provisioned with cryptographic keys
> > > that are used to ensure the integrity of communications between system
> > > management utilities and the BIOS.
> > >
> > > HP Commercial notebooks have several BIOS settings that control its
> > > behaviour and capabilities, many of which are related to security.
> > > To prevent unauthorized changes to these settings, the system can
> > > be configured to use a cryptographic signature-based authorization
> > > string that the BIOS will use to verify authorization to modify the
> > > setting.
> > >
> > > Linux Security components are under development and not published yet.
> > > The only linux component is the driver (hp bioscfg) at this time.
> > > Other published security components are under Windows.
> > >
> > > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> > >
> > > ---
> > > Based on the latest platform-drivers-x86.git/for-next
> > > ---

> > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> > > new file mode 100644
> > > index 000000000000..b627c324f6a6
> > > --- /dev/null
> > > +++ b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> > > @@ -0,0 +1,133 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Functions corresponding to sure start object type attributes under
> > > + * BIOS for use with hp-bioscfg driver
> > > + *
> > > + *  Copyright (c) 2022 HP Development Company, L.P.
> > > + */
> > > +
> > > +#include "bioscfg.h"
> > > +#include <linux/types.h>
> > > +
> > > +/* Maximum number of log entries supported when log entry size is 16
> > > + * bytes.  This value is calculated by dividing 4096 (page size) by
> > > + * log entry size.
> > > + */
> > > +#define LOG_MAX_ENTRIES              254
> > > +
> > > +/*
> > > + * Current Log entry size.  This value size will change in the
> > > + * future. The driver reads a total of 128 bytes for each log entry
> > > + * provided by BIOS but only the first 16 bytes are used/read.
> > > + */
> > > +#define LOG_ENTRY_SIZE               16
> > > +
> > > +/*
> > > + * audit_log_entry_count_show - Reports the number of
> > > + *                           existing audit log entries available
> > > + *                           to be read
> > > + */
> > > +static ssize_t audit_log_entry_count_show(struct kobject *kobj,
> > > +                                       struct kobj_attribute *attr, char *buf)
> > > +{
> > > +     int ret;
> > > +     u32 count = 0;
> > > +
> > > +     ret = hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG_COUNT,
> > > +                                HPWMI_SURESTART,
> > > +                                &count, 1, sizeof(count));
> > > +
> >
> > Extra newline.
> Done!
> >
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     return sysfs_emit(buf, "%d,%d,%d\n", count, LOG_ENTRY_SIZE,
> > > +                       LOG_MAX_ENTRIES);
> >
> > Why 3 values instead of 1?
> This version of BIOS only returns the number of audit log events available.
> The other two values are the current log entry size which today is
> hardcoded.  This will change in future when BIOS returns the log entry
> size.

And you cannot provide the others in separate sysfs files?

> > > +}
> > > +
> > > +/*
> > > + * audit_log_entries_show() - Return all entries found in log file
> > > + */
> > > +static ssize_t audit_log_entries_show(struct kobject *kobj,
> > > +                                   struct kobj_attribute *attr, char *buf)
> > > +{
> > > +     int ret;
> > > +     int i;
> > > +     u32 count = 0;
> > > +     u8 audit_log_buffer[128];
> > > +
> > > +     // Get the number of event logs
> > > +     ret = hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG_COUNT,
> > > +                                HPWMI_SURESTART,
> > > +                                &count, 1, sizeof(count));
> > > +
> >
> > Extra newline.
> Done!
> >
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     /*
> > > +      * The show() api will not work if the audit logs ever go
> > > +      *  beyond 4KB
> >
> > Extra space.
> Done!
> >
> > > +      */
> > > +     if (count * LOG_ENTRY_SIZE > PAGE_SIZE)
> > > +             return -EIO;
> > > +
> > > +     /*
> > > +      * We are guaranteed the buffer is 4KB so today all the event
> > > +      * logs will fit
> > > +      */
> > > +     for (i = 0; i < count; i++) {
> > > +             audit_log_buffer[0] = (i + 1);
> >
> > Extra parenthesis.
> Done!
> >
> > > +
> > > +             /*
> > > +              * read audit log entry at a time. 'buf' input value
> > > +              * provides  the audit log entry to be read.  On
> >
> > Extra spaces.
> Done!
> >
> > > +              * input, Byte 0 = Audit Log entry number from
> > > +              * beginning (1..254)
> > > +              * Entry number 1 is the newest entry whereas the
> > > +              * highest entry number (number of entries) is the
> > > +              * oldest entry.
> > > +              */
> > > +             ret = hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG,
> > > +                                        HPWMI_SURESTART,
> > > +                                        audit_log_buffer, 1, 128);
> > > +
> > > +             if (ret >= 0 && (LOG_ENTRY_SIZE * i) < PAGE_SIZE) {
> >
> > Can the second condition ever fail?
> >
> Only in the event BIOS data is corrupted.

i runs from 0 to count - 1 and you prevented count * LOG_ENTRY_SIZE > 
PAGE_SIZE above. So what the BIOS data has to do with that?

> > > +                     memcpy(buf, audit_log_buffer, LOG_ENTRY_SIZE);
> > > +                     buf += LOG_ENTRY_SIZE;
> > > +             } else {
> > > +                     /*
> > > +                      * Encountered a failure while reading
> > > +                      * individual logs. Only a partial list of
> > > +                      * audit log will be returned.
> > > +                      */
> > > +                     count = i + 1;
> > > +                     break;
> > > +             }
> >
> > Reverse order, do error handling with break first.
> Done!
> >
> > Why not return i * LOG_ENTRY_SIZE directly (or at the end), no need to
> > tweak count?
> 
> Done!
> >
> > > +     }
> > > +
> > > +     return count * LOG_ENTRY_SIZE;
> > > +}


-- 
 i.

--8323329-624878464-1683797575=:1900--
