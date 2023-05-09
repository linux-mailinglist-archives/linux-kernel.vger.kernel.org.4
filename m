Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA036FC3D3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjEIKZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbjEIKZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:25:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC06D875;
        Tue,  9 May 2023 03:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683627892; x=1715163892;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0o2bVtjt2zCtsSa0VS6xp4L/71+buNa9+sz40AhrWz4=;
  b=nVPnIWWu8pq8aoWNELzzPWy58kaG958Tan5Df3lTTuGnC7w6lRP82iHp
   OsiD7lUae2dsu5NjMSUlXaD6WXKjAlxM8TGTx198n7cJw2QdVrxtrQHhz
   JfDkXKZLwbPvgKJ1faoalZWj4QJRYzJ/19aHrCSersmqUV+kKdHhtkXYY
   wMlNES9+taDYhd97dD5fH+WS8LrF390NxaBD5QThpk7k8+3SaH6h5h2CR
   Yl3Mji6BsJsxzPwIxPJRSg3bh1CCX/N7A9+B7AO//WWxuhmW0U6n9qQF7
   H8OUcv3rHRq20vRjt+xbRhKC7Z1UbC4FyaQFCa0LYE724nQpq2P1mIl7H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="329512840"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="329512840"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 03:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="676415954"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="676415954"
Received: from mbrdon-mobl.ger.corp.intel.com ([10.251.219.121])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 03:24:49 -0700
Date:   Tue, 9 May 2023 13:24:47 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, thomas@t-8ch.de
Subject: Re: [PATCH v12 04/13] HP BIOSCFG driver - int-attributes
In-Reply-To: <CAOOmCE-7sAPYcPM393Zsj=eR96fJv8Ectm8FoEJdxwPPAwEVVw@mail.gmail.com>
Message-ID: <acac7018-99ad-c195-d361-f536a96aa5@linux.intel.com>
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-5-jorge.lopez2@hp.com> <51607d2d-2d74-7dd4-e266-cf3ec0235e7a@linux.intel.com> <CAOOmCE-7sAPYcPM393Zsj=eR96fJv8Ectm8FoEJdxwPPAwEVVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-748359660-1683627890=:2036"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-748359660-1683627890=:2036
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 8 May 2023, Jorge Lopez wrote:

> On Mon, May 8, 2023 at 9:45 AM Ilpo Järvinen
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

> > > +int alloc_integer_data(void)
> > > +{
> > > +     bioscfg_drv.integer_instances_count = get_instance_count(HP_WMI_BIOS_INTEGER_GUID);
> > > +     bioscfg_drv.integer_data = kcalloc(bioscfg_drv.integer_instances_count,
> > > +                                        sizeof(struct integer_data), GFP_KERNEL);
> >
> > It would be better to use sizeof(*...) format.
> 
> I cannot use sizeof(*...) at this time, because it is allocating
> bioscfg_drv.integer_instances_count number of  integer_data
> structures.

Isn't bioscfg_drv.integer_data is a pointer to a single struct 
integer_data? Why cannot you do sizeof(*bioscfg_drv.integer_data)?? It is 
perfectly legal C construct for getting the size of the struct the 
pointer points to.


-- 
 i.

--8323329-748359660-1683627890=:2036--
