Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C996FEE60
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbjEKJJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjEKJJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:09:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF9AB8;
        Thu, 11 May 2023 02:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683796186; x=1715332186;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LIAE6AICDiU3JtfOGCeNPnm8ua1Fx3jeY/DvL1sM4mg=;
  b=T7I6GnJv4Z0dOA0uk3vmKewmnYmd8wcWXmOPivUWjK5T4084zmwl1W8U
   vVSeck3D8gGFHf9/d2vQOKws49jG6Abjm1ePCTyIEcrYxCxZhkvZletNE
   G3FTpSfBF9xTGds4Y9PCF2aYtDVXOGVkrBnMoYhotqAMV1PIzm6v/D+SW
   STBZu3YpbPP7TPeoxi/RC4k29/PnmQuU8NbALNCc1A/YRXqh5ho/yDO+a
   0SEasuq4TyEPE7gpOKkyAH6I03JD1wHbr9dL3vJbSeuNQfkusaubPF9XB
   DsA5SznWUkj8jMaPW1GPlB86/kv1/XSiSAD/uLPlTUPPFdq6G7eR16vrR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="436776667"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="436776667"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 02:09:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="811510125"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="811510125"
Received: from jsanche3-mobl1.ger.corp.intel.com ([10.252.39.112])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 02:09:44 -0700
Date:   Thu, 11 May 2023 12:09:39 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, thomas@t-8ch.de
Subject: Re: [PATCH v12 06/13] HP BIOSCFG driver - passwdobj-attributes
In-Reply-To: <CAOOmCE9MUFyXzeb-iBaXdpD0-ctSnYPnM_07VCAzGCg-vaOjsg@mail.gmail.com>
Message-ID: <5fe49d95-79bd-441d-3a3a-4e2894536ae9@linux.intel.com>
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-7-jorge.lopez2@hp.com> <ff831b68-58ca-947e-1e1-b9461b781bc0@linux.intel.com> <CAOOmCE9MUFyXzeb-iBaXdpD0-ctSnYPnM_07VCAzGCg-vaOjsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-502350463-1683796186=:1900"
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

--8323329-502350463-1683796186=:1900
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 10 May 2023, Jorge Lopez wrote:

> On Tue, May 9, 2023 at 7:34 AM Ilpo Järvinen
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
> >
> > FYI, for me you don't need to reply into the comments where you'll be
> > following the review suggestion. It saves us both time if we focus on
> > points where there's more to discuss.


> > > +                     /*
> > > +                      * This HACK is needed to keep the expected
> > > +                      * element list pointing to the right obj[elem].type
> > > +                      * when the size is zero.  PREREQUISITES
> >
> > Please remove all these double space from your patches (should be easy
> > to find them with grep). Please check if your editor adds them e.g., when
> > reflowing text.
> 
> What double spaces are you referring to?

There's "zero.  PREREQUISITES" so double space after the full stop. We 
don't use them in the kernel comments.

It could be that your editor auto inserts the second space (by default) 
when e.g. reflowing text because it's some English rule to use two spaces 
there.


-- 
 i.

--8323329-502350463-1683796186=:1900--
