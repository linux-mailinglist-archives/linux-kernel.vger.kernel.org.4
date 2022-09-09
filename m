Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640465B3532
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiIIKZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIIKZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:25:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA1B1F628
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662719103; x=1694255103;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:from:subject:to:cc:message-id:date;
  bh=40ExF1L86gWz6KoTvHfGYI69/vgJU/NDtTfBrosP+5U=;
  b=l5pks8KqMh1NNnqbqo+8vvoqGqjKZ7VrS2W4yI72soeBWvtTlvVspdE4
   XWRnW5KzRSyFWY6GTQe8w/+FeDhTT0/0ykcMQl41G4tWFwVKjlVOq1jdd
   +nlS6zq8NQGV+AgbTp8B63s9v5K4guxYG6v2pETFvV7TH/XuMCNfwAFMF
   djucUvh0Mo3NQ0rPgbImoWZeVoK14Wrq+zlP8VJM1Zw8Z3sU+anUXGyad
   eTobAxEP9Gc3uaPMqOFNCi84Ybm/wHuubkCY2FrJ5aUVYgVtcLh677tCD
   VTPP4Zpjv3wHIGVf5UVcCWWYsvehkReu7mWx0iVJFqsXxWqX7oha7ze/h
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="296182991"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="296182991"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 03:25:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="677109145"
Received: from fjkilken-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.15.201])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 03:25:00 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YxDLFWjIllqqh9de@kroah.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com> <YxDLFWjIllqqh9de@kroah.com>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH v7 00/15] GSC support for XeHP SDV and DG2
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        David Airlie <airlied@linux.ie>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <166271909777.4265.10724483511179344068@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date:   Fri, 09 Sep 2022 13:24:57 +0300
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave, do you have a preference how to deal with the mishap here, shall I do=
 a
force-push to drm-intel-gt-next to correctly record the Acked-by or revert =
and
re-push? Or just leave it as is?

Quoting Greg Kroah-Hartman (2022-09-01 18:09:09)
> On Sat, Aug 06, 2022 at 03:26:21PM +0300, Tomas Winkler wrote:
> > Add GSC support for XeHP SDV and DG2 platforms.
> >=20
> > The series includes changes for the mei driver:
> > - add ability to use polling instead of interrupts
> > - add ability to use extended timeouts
> > - setup extended operational memory for GSC
> >=20
> > The series includes changes for the i915 driver:
> > - allocate extended operational memory for GSC
> > - GSC on XeHP SDV offsets and definitions
> >=20
> > This patch set should be merged via gfx tree as
> > the auxiliary device belongs there.
> > Greg, your ACK is required for the drives/misc/mei code base,
> > please review the patches.
>=20
> With the exception that you all don't know what year it is:
>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Daniele, why were the patches applied without this A-b?

I'm just preparing the drm-intel-gt-next pull request and now it appears
like we're pushing a lot of commits outside of drm without any Acks.

Please reach out to the maintainers *before* pushing code for other
subsystems. Unless you get an explicit ack to do so, do not push such
code.

Quoting from the committer guidelines[1] the first rule is:
"Only push patches changing drivers/gpu/drm/i915."

In those cases, please ping a maintainer and don't rush things.

Regards, Joonas

[1] https://drm.pages.freedesktop.org/maintainer-tools/committer-drm-intel.=
html#high-level-guidelines

