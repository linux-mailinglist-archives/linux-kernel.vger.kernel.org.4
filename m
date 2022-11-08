Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2822B6209F1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiKHHRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiKHHRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:17:18 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0191012634
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 23:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667891837; x=1699427837;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=6t23h1hLiPCwHNEIaCNYABDtZi21XuJ+LzVlZVwKpE0=;
  b=PshHj/NdyE4/m9JDnuNkRLkhaf5hj/xI0Q6WA4NmzG7CBo4nJrAZMUFI
   W/4uv125sIi52ZhJLmmG5Owm81xNpyhLu8oE9xgNWjBDBFr6RtT7nJRs0
   yVzNN5T5mJ2g9vab4uwA3yohl8QvIFaAiO63FRbOEMROdcGIfszX9jXeS
   fuZKF30t4CZ98xl+0fWMLdC7zudpwmjTdjoTm+0E5Wr9coZWz6PUnlS22
   595O0wpEIsPCkbEHYdBFb9gz1FSBwzvYSMyCpkFRh1pCapcrboyCTZfPX
   5TJfootpNNFSi6szzeI+C/L3740Ln8hnXLTICX2oofTwsOnZ1F1SCvoXj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="290345818"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="asc'?scan'208";a="290345818"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 23:17:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="667487694"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="asc'?scan'208";a="667487694"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.159.108])
  by orsmga008.jf.intel.com with ESMTP; 07 Nov 2022 23:17:14 -0800
Date:   Tue, 8 Nov 2022 15:16:49 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: fix repeated words in comments
Message-ID: <20221108071649.GL30028@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20221022061327.65275-1-wangjianli@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Content-Disposition: inline
In-Reply-To: <20221022061327.65275-1-wangjianli@cdjrlc.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022.10.22 14:13:27 +0800, wangjianli wrote:
> Delete the redundant word 'the'.
>=20
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  drivers/gpu/drm/i915/gvt/gtt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gt=
t.c
> index b4f69364f9a1..7b29ef36941a 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -2785,7 +2785,7 @@ int intel_gvt_init_gtt(struct intel_gvt *gvt)
>   * intel_gvt_clean_gtt - clean up mm components of a GVT device
>   * @gvt: GVT device
>   *
> - * This function is called at the driver unloading stage, to clean up the
> + * This function is called at the driver unloading stage, to clean up
>   * the mm components of a GVT device.
>   *
>   */
> --=20
> 2.36.1
>=20

Reviewed-by: Zhenyu Wang <zhenyuw@linux.intel.com>

thanks

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCY2oCYQAKCRCxBBozTXgY
J03KAKCWc57J8MDsLqa6/e4MQM3RDcGPXACfaKzldTcojTbuW2sk813a+6qgXTE=
=48ZN
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--
