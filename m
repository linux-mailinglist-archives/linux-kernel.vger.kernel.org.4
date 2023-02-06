Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C01768BE23
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBFNaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjBFNaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:30:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B888D2121;
        Mon,  6 Feb 2023 05:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675690205; x=1707226205;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ukdnUxaL0I/DHdvT7nUODR9r6U1yXlJ1n1A5zpafkEE=;
  b=WwkbZEZx7yY3MQfNAQYfTHP3vjRJh9gMwp4eZaRiLqGRwcriicgIrs92
   zRL/TabEns0R0mFzA7tqXKYSKEJheIAXSw6au8q393uSSWTnRjYthM+Zy
   KPm+BPTaG2YsMvI1U8dhze4d9h3KYYZk48rLgeVrpXcxeUd1U6UcBqNWg
   VZ/jQK8vmgHPTytJR+uDMBx3+SXX7LkSFGgm0bK7pHeNHcVEnXNI6BUPF
   SqSXnByHaCW6fA4YEmemkZNJFiItPHrP9RLZj3wga3sxw24M/nFUTxvVW
   lCwEDwm/h3+MBE9bBNVa5/Y3/XHbhWKerBNUS3zSnkeIZR0owzvAIms6s
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="329219777"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="329219777"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 05:29:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="616437755"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616437755"
Received: from gvenka5x-mobl.gar.corp.intel.com ([10.215.125.12])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 05:29:49 -0800
Message-ID: <7fb6fa717b2c8e7869e2a5c7abb299c365ec3af3.camel@linux.intel.com>
Subject: Re: [PATCH 0/7] Add TPMI support
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 06 Feb 2023 05:29:49 -0800
In-Reply-To: <14c1201b-7caf-e096-624c-e5ec3597d67f@redhat.com>
References: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
         <918ac0c5-9f35-0099-5be8-6dbc72aa88e9@redhat.com>
         <14c1201b-7caf-e096-624c-e5ec3597d67f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Mon, 2023-02-06 at 13:55 +0100, Hans de Goede wrote:
> Hi,
>=20
> On 2/6/23 13:49, Hans de Goede wrote:
>=20
> > Thank you for your patch-series, I've applied the series to my
> > review-hans branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-=
x86.git/log/?h=3Dreview-hans
> >=20
> > Note it will show up in my review-hans branch once I've pushed my
> > local branch there, which might take a while.
> >=20
> > Once I've run some tests on this branch the patches there will be
> > added to the platform-drivers-x86/for-next branch and eventually
> > will be included in the pdx86 pull-request to Linus for the next
> > merge-window.
>=20
> One thing which I did notice, which is a pre-existing problem
> is that the IDA accesses in drivers/platform/x86/intel/vsec.c
> are not protected by any locking.
>=20
> This is likely ok for now because there is only 1 PCI device
> per type of ida and the enumeration of the vsec devices
> under the PCI device is done in a single loop, so all
> IDA accesses are single threaded atm.
>=20
> But still IMHO it would be good to protect the IDA accesses
> (ida_alloc() / ida_free()) with a mutex to protect against
> any future races.
>=20
> I think that a single global static mutex inside
> drivers/platform/x86/intel/vsec.c to protect the
> ida calls there should suffice for this.
Let me look into this and get back.

Thanks,
Srinivas

>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20

