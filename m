Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC64C6FEEA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbjEKJXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjEKJXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:23:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7784910E;
        Thu, 11 May 2023 02:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683797010; x=1715333010;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QgdaHAAgZazMw6AXL+sJC63JncWFpuoO5svFVyBFHic=;
  b=DhuD5ydFjme7MBLkVGs96GQcpXADft/ZAuc3iSYQs9Y/z4jH1UoJgaJ0
   9eeITOJ86JZpltundD/8qtXYcIQY5VFkZTHE6tjzvQUYCNpkrbONVMCiP
   P3chByVXQ2vw1Hx+bLrfiF67hd6ZHT7HfJWeLTWLdeEdKHNWJu3gmIojA
   EHwTSkyyNZldvNsLQ3aMg0L8ZYJsI42MjnASy/4gt0lat+diaBMpHb2tf
   DbDHCmga6+n4yMQjaYWUnL3UZx91XxowlhdvQm1H6W7FH3vWGfdBVd8hS
   T8JL1miZcdWYWI2KpsJkx6UuVMgxBU9pyP6Ep4w4ClZzsEZy9XnYKnZZq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="330806852"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="330806852"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 02:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="650087353"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="650087353"
Received: from jsanche3-mobl1.ger.corp.intel.com ([10.252.39.112])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 02:23:28 -0700
Date:   Thu, 11 May 2023 12:23:25 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, thomas@t-8ch.de
Subject: Re: [PATCH v12 10/13] HP BIOSCFG driver - spmobj-attributes
In-Reply-To: <CAOOmCE9m5++_4nBu3C64uWVOeyUQs3afn_Q9AJz9oudGvMHHiQ@mail.gmail.com>
Message-ID: <4a14de7-58fb-4192-496a-279dd4109b6@linux.intel.com>
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-11-jorge.lopez2@hp.com> <4537f210-4a7a-3c11-ecbb-ed4762a1f598@linux.intel.com> <CAOOmCE9m5++_4nBu3C64uWVOeyUQs3afn_Q9AJz9oudGvMHHiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1104371954-1683797009=:1900"
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

--8323329-1104371954-1683797009=:1900
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 10 May 2023, Jorge Lopez wrote:

> On Tue, May 9, 2023 at 8:48 AM Ilpo Järvinen
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


> > > +     } else {
> > > +             /*
> > > +              * UTF-16 prefix is append to the * buffer when a BIOS
> >
> > What is "the * buffer" ?
> 
> It is the data stored in 'buffer' variable which is composed of three
> strings concatenated together to be submitted to BIOS via WMI call.
> 'Buffer' will looks something as    [size attribute][attribute][size
> value][value][auth size][auth payload]
> size is the length in bytes,  attribute/value/auth are string represented in u16

Even after this explanation I don't understand why it's called "the * 
buffer". Is that common terminology in this domain (in which case it's 
fine, I just haven't come across such term before)?

> > > +              * admin password is configured in BIOS
> > > +              */
> > > +

[...snip...]

> > > +/*
> > > + * status_show - Reads SPM status
> > > + */
> > > +static ssize_t status_show(struct kobject *kobj, struct kobj_attribute
> > > +                 *attr, char *buf)
> > > +{
> > > +     int ret, i;
> > > +     struct secureplatform_provisioning_data data;
> > > +
> > > +     ret = statusbin(kobj, attr, &data);
> > > +     if (ret < 0)
> > > +             goto status_exit;
> >
> > Can you calculate strnlen() from buf at this point, or is the result
> > garbage? Should you return ret instead here?
> 
> It should return the error instead.
> >
> > > +
> > > +     sysfs_emit(buf, "%s{\n", buf);
> > > +     sysfs_emit(buf, "%s\t\"State\": \"%s\",\n", buf,
> > > +                spm_state_types[data.state]);
> > > +     sysfs_emit(buf, "%s\t\"Version\": \"%d.%d\",\n", buf, data.version[0],
> > > +                data.version[1]);
> > > +
> > > +     /*
> > > +      * state == 0 means secure platform management
> > > +      * feature is not configured in BIOS.
> > > +      */
> > > +     if (data.state == 0)
> > > +             goto status_exit;
> > > +
> > > +     sysfs_emit(buf, "%s\t\"Nonce\": %d,\n", buf, data.nonce);
> > > +     sysfs_emit(buf, "%s\t\"FeaturesInUse\": %d,\n", buf, data.features);
> > > +     sysfs_emit(buf, "%s\t\"EndorsementKeyMod\": \"", buf);
> > > +
> > > +     for (i = 255; i >= 0; i--)
> > > +             sysfs_emit(buf, "%s %u", buf, data.kek_mod[i]);
> > > +
> > > +     sysfs_emit(buf, "%s \",\n", buf);
> > > +     sysfs_emit(buf, "%s\t\"SigningKeyMod\": \"", buf);
> > > +
> > > +     for (i = 255; i >= 0; i--)
> > > +             sysfs_emit(buf, "%s %u", buf, data.sk_mod[i]);
> > > +
> > > +     /* Return buf contents */
> > > +
> > > +     sysfs_emit(buf, "%s \"\n", buf);
> > > +     sysfs_emit(buf, "%s}\n", buf);
> > > +
> > > +status_exit:
> > > +     return strnlen(buf, PAGE_SIZE);
> > > +}
> >
> > Emit buf into buf? There's sysfs_emit_at(), however,
> >
> > while I'm far from sysfs formatting expert, this feels something that
> > tries to expose more than one thing over same sysfs file. Shouldn't they
> > be each in their own files?
> 
> This concern was brought up in earlier reviews but it was decided to
> allow returning the information as a single json file.
> Because the information is part of the same structure and received in
> a single WMI call, separating the components into multiple files can
> cause the data read in one field to be stale by the time is read.

Okay, makes more sense. Maybe add a comment that the return is a json 
string because that's not very obvious (I only realized now when you told 
me).

The other point is still valid though, you should keep length in a 
variable and use sysfs_emit_at() to avoid printing buf into buf on 
every line.


-- 
 i.

--8323329-1104371954-1683797009=:1900--
