Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18DC7009FF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241321AbjELOMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240932AbjELOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:12:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3089786BE;
        Fri, 12 May 2023 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900747; x=1715436747;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rHSFEe9c+dXfKqcqMswTurt+PWDKv+CkZ1d0is5SzCk=;
  b=NOgpYsKBssYW0c8Mqxtx0COP6ehcUYwGBse0BkpmRGR9251C+LR8ZhnB
   5zEgswaKgWk0e9p2I+CU88FLW0Q027DQQtcIHJTfKRcm7+V1EvM5+yQ+v
   GSx8wf8lNKpL00+FXqnyxGYEIB+MxXWhbAGZrIFqA3NIsHGb/LqNvHtYH
   IbgHQsTNIGsuIEq6AR2nIHcUeJ1yVutjwMO6OsVaheBztLz6lfQYwAaVH
   oYsXBjNC5eWRJGHIufWm/27AcdcjUVmpd4Lx81jAMBoR31vzF8z6phz98
   DDiXoqm/CgaQ2cojunmCM6IrW8Q7+OFA3fHGSguFn3ZoSyyDviWpzDwQY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="350819676"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="350819676"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:12:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="694248833"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="694248833"
Received: from ralbanes-mobl.ger.corp.intel.com ([10.252.40.108])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:12:17 -0700
Date:   Fri, 12 May 2023 17:12:14 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, thomas@t-8ch.de
Subject: Re: [PATCH v12 11/13] HP BIOSCFG driver - surestart-attributes
In-Reply-To: <CAOOmCE9rNSJDbhoMgyEenog1CG6xG_cRoPNtYp--37DAi4iqsg@mail.gmail.com>
Message-ID: <a8d1a232-d0f0-16ab-57a8-28e3b2f84@linux.intel.com>
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-12-jorge.lopez2@hp.com> <ef445e78-5751-bd8f-44ce-d9beaebaac6@linux.intel.com> <CAOOmCE_dRivApf46KO1Cq-vHGsHVXNVCqbqF2NV4Y6SVpYx6hA@mail.gmail.com> <79db2a99-5cd7-19c0-212d-9e28869a6a18@linux.intel.com>
 <CAOOmCE9rNSJDbhoMgyEenog1CG6xG_cRoPNtYp--37DAi4iqsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1516034528-1683900741=:1742"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1516034528-1683900741=:1742
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 12 May 2023, Jorge Lopez wrote:

> On Thu, May 11, 2023 at 4:32 AM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Wed, 10 May 2023, Jorge Lopez wrote:
> >
> > > On Tue, May 9, 2023 at 8:57 AM Ilpo Järvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > >
> > > > On Fri, 5 May 2023, Jorge Lopez wrote:
> > > >
> > > > > HP BIOS Configuration driver purpose is to provide a driver supporting
> > > > > the latest sysfs class firmware attributes framework allowing the user
> > > > > to change BIOS settings and security solutions on HP Inc.’s commercial
> > > > > notebooks.
> > > > >
> > > > > Many features of HP Commercial notebooks can be managed using Windows
> > > > > Management Instrumentation (WMI). WMI is an implementation of Web-Based
> > > > > Enterprise Management (WBEM) that provides a standards-based interface
> > > > > for changing and monitoring system settings. HP BIOSCFG driver provides
> > > > > a native Linux solution and the exposed features facilitates the
> > > > > migration to Linux environments.
> > > > >
> > > > > The Linux security features to be provided in hp-bioscfg driver enables
> > > > > managing the BIOS settings and security solutions via sysfs, a virtual
> > > > > filesystem that can be used by user-mode applications. The new
> > > > > documentation cover HP-specific firmware sysfs attributes such Secure
> > > > > Platform Management and Sure Start. Each section provides security
> > > > > feature description and identifies sysfs directories and files exposed
> > > > > by the driver.
> > > > >
> > > > > Many HP Commercial notebooks include a feature called Secure Platform
> > > > > Management (SPM), which replaces older password-based BIOS settings
> > > > > management with public key cryptography. PC secure product management
> > > > > begins when a target system is provisioned with cryptographic keys
> > > > > that are used to ensure the integrity of communications between system
> > > > > management utilities and the BIOS.
> > > > >
> > > > > HP Commercial notebooks have several BIOS settings that control its
> > > > > behaviour and capabilities, many of which are related to security.
> > > > > To prevent unauthorized changes to these settings, the system can
> > > > > be configured to use a cryptographic signature-based authorization
> > > > > string that the BIOS will use to verify authorization to modify the
> > > > > setting.
> > > > >
> > > > > Linux Security components are under development and not published yet.
> > > > > The only linux component is the driver (hp bioscfg) at this time.
> > > > > Other published security components are under Windows.
> > > > >
> > > > > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> > > > >
> > > > > ---
> > > > > Based on the latest platform-drivers-x86.git/for-next
> > > > > ---

> > > > > +      */
> > > > > +     if (count * LOG_ENTRY_SIZE > PAGE_SIZE)
> > > > > +             return -EIO;
> > > > > +
> > > > > +     /*
> > > > > +      * We are guaranteed the buffer is 4KB so today all the event
> > > > > +      * logs will fit
> > > > > +      */
> > > > > +     for (i = 0; i < count; i++) {
> > > > > +             audit_log_buffer[0] = (i + 1);
> > > > > +
> > > > > +             /*
> > > > > +              * read audit log entry at a time. 'buf' input value
> > > > > +              * provides  the audit log entry to be read.  On
> > > > > +              * input, Byte 0 = Audit Log entry number from
> > > > > +              * beginning (1..254)
> > > > > +              * Entry number 1 is the newest entry whereas the
> > > > > +              * highest entry number (number of entries) is the
> > > > > +              * oldest entry.
> > > > > +              */
> > > > > +             ret = hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG,
> > > > > +                                        HPWMI_SURESTART,
> > > > > +                                        audit_log_buffer, 1, 128);
> > > > > +
> > > > > +             if (ret >= 0 && (LOG_ENTRY_SIZE * i) < PAGE_SIZE) {
> > > >
> > > > Can the second condition ever fail?
> > > >
> > > Only in the event BIOS data is corrupted.
> >
> > i runs from 0 to count - 1 and you prevented count * LOG_ENTRY_SIZE >
> > PAGE_SIZE above. So what does the BIOS data have to do with that?
> 
> BIOS guarantees the number of audit logs * LOG_ENTRY_SIZE will be less
> than 4K (PAGE_SIZE)
> Because Linux kernel trusts no one, we are checking that BIOS does not
> report more events than it should.

I know you're checking that.

What I'm trying to say that even after that check, your own code does not 
trust that when i < count holds (as per the for loop termination 
condition), i * LOG_ENTRY_SIZE < count * LOG_ENTRY_SIZE.

So what I'm trying to say is that this check:
		&& (LOG_ENTRY_SIZE * i) < PAGE_SIZE
...is always true (and therefore unnecessary).

> WMI expects the input buffer to include the current audit log number
> (audit_log_buffer[0] = (i + 1);) which is i+1.

I don't see how this is relevant to what I was asking.

> > > > > +                     memcpy(buf, audit_log_buffer, LOG_ENTRY_SIZE);
> > > > > +                     buf += LOG_ENTRY_SIZE;
> > > > > +             } else {
> > > > > +                     /*
> > > > > +                      * Encountered a failure while reading
> > > > > +                      * individual logs. Only a partial list of
> > > > > +                      * audit log will be returned.
> > > > > +                      */
> > > > > +                     count = i + 1;
> > > > > +                     break;
> > > > > +             }
> > > >
> > > > Reverse order, do error handling with break first.
> > > Done!
> > > >
> > > > Why not return i * LOG_ENTRY_SIZE directly (or at the end), no need to
> > > > tweak count?
> > >
> > > Done!
> > > >
> > > > > +     }
> > > > > +
> > > > > +     return count * LOG_ENTRY_SIZE;
> > > > > +}

-- 
 i.

--8323329-1516034528-1683900741=:1742--
