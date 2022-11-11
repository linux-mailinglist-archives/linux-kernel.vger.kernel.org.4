Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F61625304
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 06:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiKKFRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 00:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKFR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 00:17:29 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA676B383
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 21:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668143848; x=1699679848;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=ql328E2NG2zRXgk89uFvUx0p6YzxyXQHLwUbNDKXi8k=;
  b=YKPQR9NHVqlhF+7+EP/LZBa8tq0MAE92NH/X3Xgg26CY/2HhOXNm1kzV
   kNbDfzCGnqhX1PtJ21a8ZFvA4K/uUOnKdYyNfotqIqtQWueRVb/C2CRmy
   EzqXzeSfrt/NMGnbPkBo+jfoDpbii0FxIs9ABpjjTZ1Hga8zRzyJQ6qQK
   ozYjThFMMZ9o0CF/XTfh46AKX31+FE2vAr4Q/Hm8NCV1fATAQATrEDvPG
   EQWgw5G5i92JirYkwgelAtyH5SWamxq1y1oGGmbFR7sM9hKk8i7k7VVnY
   GBqme4KOwdaIzGi6hehnbGoCkRtnKYSgSjhI5vGBDkpaXYICnBgJeWDbj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="397823412"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="asc'?scan'208";a="397823412"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 21:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="639894622"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="asc'?scan'208";a="639894622"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.159.108])
  by fmsmga007.fm.intel.com with ESMTP; 10 Nov 2022 21:17:27 -0800
Date:   Fri, 11 Nov 2022 13:16:55 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Zhi Wang <zhi.a.wang@intel.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/i915/gvt: Fix for KVM refcounting bug
Message-ID: <20221111051655.GO30028@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20221111002225.2418386-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Rmm1Stw9KgbdL9/H"
Content-Disposition: inline
In-Reply-To: <20221111002225.2418386-1-seanjc@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Rmm1Stw9KgbdL9/H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022.11.11 00:22:23 +0000, Sean Christopherson wrote:
> Bug fix and cleanup related to KVM refcounting.  Found by inspection while
> attempting to clean up KVM's page-tracker APIs.
>=20
> Compile tested only!
>=20
> Sean Christopherson (2):
>   drm/i915/gvt: Get reference to KVM iff attachment to VM is successful
>   drm/i915/gvt: Unconditionally put reference to KVM when detaching vGPU
>=20
>  drivers/gpu/drm/i915/gvt/kvmgt.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20

Thanks, Sean! and Kevin's review. Pushed this to fixes tree, will issue
regression test before going upstream.

--Rmm1Stw9KgbdL9/H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCY23awgAKCRCxBBozTXgY
J2EMAKCa/3JJB5jBs4Y27kn2yBiYr6NLmgCfaefRrTdWjykmFApwicOZO21ZUQg=
=/qdW
-----END PGP SIGNATURE-----

--Rmm1Stw9KgbdL9/H--
