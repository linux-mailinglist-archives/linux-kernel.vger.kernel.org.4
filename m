Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3C46C1D60
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjCTRKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjCTRJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:09:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FA418F;
        Mon, 20 Mar 2023 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679331907; x=1710867907;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=h5mqHkMMDgFWNI6UqCZ9y2+Rb+UJE+QUwnXWQX5nkCU=;
  b=DSJ/0tTbMrvqg7NMMy004eP1APLRy4tE6UW1H6AAHh3GupC997xYQ4Jl
   cD810Hmdbh9akI5esCvQn4Fhju2KjTHq8lQcaHAboMZfnYNHWx/qXjk/u
   bYFoAAxp8b7rEx1cFyCKx5rlN5wwN0RrayDV97wfc9tX9LKwXHdbdWW5P
   qH/CdTr60AH3XF+gX0mM4X+GDpUKXmnmRO1JNJJfOCukFvyYu5uKI5ovt
   2USiPMcjCbJaaORUcGU+BHPykQVZtdFt6tB3Ao5doKHC8OMsqkgtB3zwU
   eqf87TlO0d9ISx7o+jYPHrkmP2u3b+fUJlpBvhoIoRFTn0yIclUl/kdJP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="336225840"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="336225840"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 10:03:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="631188894"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="631188894"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 20 Mar 2023 10:03:26 -0700
Received: from sarkarbi-mobl1.amr.corp.intel.com (unknown [10.251.19.209])
        by linux.intel.com (Postfix) with ESMTP id 70FB3580110;
        Mon, 20 Mar 2023 10:03:26 -0700 (PDT)
Message-ID: <a6d27ad18452d13840cb4cdd2f17cef7dbe0275c.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] platform/x86/intel/pmt/telemetry: Add driver version
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     irenic.rajneesh@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Mon, 20 Mar 2023 10:03:26 -0700
In-Reply-To: <87382b5e-f3f8-601c-77ff-ecd44d911042@redhat.com>
References: <20230316225736.2856521-1-david.e.box@linux.intel.com>
         <20230316225736.2856521-2-david.e.box@linux.intel.com>
         <CAHp75VcP5jf4Tt-U7cs77gnTcUpQbQ+exXjOOc5epPRDfT0h0Q@mail.gmail.com>
         <87382b5e-f3f8-601c-77ff-ecd44d911042@redhat.com>
Organization: David E. Box
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

On Mon, 2023-03-20 at 15:18 +0100, Hans de Goede wrote:
> Hi,
>=20
> On 3/17/23 14:35, Andy Shevchenko wrote:
> > On Fri, Mar 17, 2023 at 12:57=E2=80=AFAM David E. Box
> > <david.e.box@linux.intel.com> wrote:
> > >=20
> > > Add a driver version number to make it easier to track changes in
> > > backported kernels.
> >=20
> > Sorry, but NAK. As Greg KH said, we do not use this anymore (in Git
> > era) =C2=AD=E2=80=94 the SHA from the Git _is_ the version of the drive=
r.
>=20
> I agree with Andy per driver version numbers are really not useful.
>=20
> Generally speaking the version number will get updated say once
> per upstream kernel-release in a separate commit,=C2=A0

> but there is
> no guarantee that commit will get cherry-picked together with
> other cherry-picked fixes.

Good point. Thanks.

David


>=20
> So for downstream kernels these version numbers really don't
> have any meaning and as such are useless.
>=20
> Regards,
>=20
> Hans
>=20

