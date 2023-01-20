Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC29467496A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjATClW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 21:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjATClU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:41:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DC4A254
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 18:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674182480; x=1705718480;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=xrL5fnmNBnIXgqAfypEkNdzoxAHEnUF6zyRBUREec7I=;
  b=aclFXqlsmRGzN1lNog70/96FEAfvP6IsG/QPS1XVfWjHBxrXNIqJ6uuX
   HQWKBhH9C6hFG0xQy5ZfLAbgjY4SeqW54P0yegcdzqtQkNVNCrmlX8xep
   0Az8cRTtvZQ660qGD7VaCND+LqdvQgGTnCSD2iDITpjGuzPQzPLbofBkt
   /qMX8bg+nb87SNMWA5Boe7nYHrBIZ47fRlQXyENr/NZvUeDQgm+ftkF/3
   UcmRCIdeYrefziIBFBMNDQIa08WR74dW8QFl0esea8WIVD5CZNp3RGRo1
   cDXySwg/lj4Lr5IucZ8hBoq1/LiL/68WvcI1tVOMsrE8/B4k9dySvPOyM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="352748257"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="asc'?scan'208";a="352748257"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 18:41:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="690897048"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="asc'?scan'208";a="690897048"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.159.108])
  by orsmga008.jf.intel.com with ESMTP; 19 Jan 2023 18:41:16 -0800
Date:   Fri, 20 Jan 2023 10:20:17 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Deepak R Varma <drv@mailo.com>, David Airlie <airlied@gmail.com>,
        intel-gfx@lists.freedesktop.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH 2/2] drm/i915/gvt: Avoid full proxy f_ops for
 vgpu_status debug attributes
Message-ID: <Y8n6YWMjRpT812B+@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <cover.1673375066.git.drv@mailo.com>
 <188df08e0feba0cda2c92145f513dd4e57c6e6cf.1673375066.git.drv@mailo.com>
 <Y72zVXYLVHXuyK05@intel.com>
 <Y8TkTi+/GQwhiMvO@zhen-hp.sh.intel.com>
 <Y8b3IRhx976Ke99X@intel.com>
 <Y8d6CwD3dHLKOUZ5@ubun2204.myguest.virtualbox.org>
 <Y8giB988U5cqsGdd@intel.com>
 <Y8icPEqkdF+7mg7E@zhen-hp.sh.intel.com>
 <Y8m+xBhGCa3kgcO2@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="m1aJLFosZhJsVcOI"
Content-Disposition: inline
In-Reply-To: <Y8m+xBhGCa3kgcO2@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m1aJLFosZhJsVcOI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023.01.19 17:05:56 -0500, Rodrigo Vivi wrote:
>=20
> It still doesn't apply in drm-intel-next.
> Could you please take it through your branch?
>=20

sure, I'll pick it.

--m1aJLFosZhJsVcOI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCY8n6WwAKCRCxBBozTXgY
J5SvAJ9C8g+BYbyVNlEdPG78ayrJ8RcOigCeJUNQO9mDJImWIsvnkOvowvuLr/A=
=KrnD
-----END PGP SIGNATURE-----

--m1aJLFosZhJsVcOI--
