Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536CF65E445
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjAEDvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjAEDvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:51:07 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90B553726;
        Wed,  4 Jan 2023 19:49:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnXVH05Rtz4y0k;
        Thu,  5 Jan 2023 14:47:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672890456;
        bh=LxcYn7CdaUXveHJS3sIgtUUoBgSnw9O1NYqQgya82ag=;
        h=Date:From:To:Cc:Subject:From;
        b=BhuhNjQsLju6islS9dynrD1V3D6rpfmNkeEWQ+bRsQI7nDlwBAmlYB3hG+Ov6yyz5
         O7WfF8x/sYVz0FJXU0YU9s4Dgdd458fvKXXbcag/NnohNSPvUKw9VzeDzvgLL7XM9P
         +CpLIf8aaO8MtpdKmMPKGtRtJ5xhFnNUh7f9JhDZ44KmnlP5Kxgd/77f0aBl5Dxfjg
         yGaUXfX22+vSLnb26SXUeju9ah/kspU7eWLy+we+JJ/ZPNvL1E+w5b97lfmPZ9rlsH
         Y1F8SrsAQnajy0QUZpVpC0sGDGsh5o2bxc1gcmIKB8gFZ5U5qo+p/ICaHPrUAHKsre
         DZTCVSZ31ttNg==
Date:   Thu, 5 Jan 2023 14:47:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        =?UTF-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>,
        =?UTF-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the drm tree
Message-ID: <20230105144734.06278c8b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vcDC4foG=4ee6x3QtYzXh5x";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vcDC4foG=4ee6x3QtYzXh5x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (htmldocs) produced
these warnings:

include/drm/drm_debugfs.h:93: warning: Function parameter or member 'name' =
not described in 'drm_debugfs_info'
include/drm/drm_debugfs.h:93: warning: Function parameter or member 'show' =
not described in 'drm_debugfs_info'
include/drm/drm_debugfs.h:93: warning: Function parameter or member 'driver=
_features' not described in 'drm_debugfs_info'
include/drm/drm_debugfs.h:93: warning: Function parameter or member 'data' =
not described in 'drm_debugfs_info'
include/drm/drm_debugfs.h:105: warning: Function parameter or member 'dev' =
not described in 'drm_debugfs_entry'
include/drm/drm_debugfs.h:105: warning: Function parameter or member 'file'=
 not described in 'drm_debugfs_entry'
include/drm/drm_debugfs.h:105: warning: Function parameter or member 'list'=
 not described in 'drm_debugfs_entry'

Introduced by commit

  1c9cacbea880 ("drm/debugfs: create device-centered debugfs functions")

--=20
Cheers,
Stephen Rothwell

--Sig_/vcDC4foG=4ee6x3QtYzXh5x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO2SFYACgkQAVBC80lX
0Gw98QgAnADV1+PXGit7rad2UW8QIsn+mrvrKuOz6t/POkG+5y+OCHmbwDbap5hY
7E/m/EznDV+SgQBD3JiRzjX8rW/asN78iuCe3PXX5aRPHleXgSFXZsucvG7TBdwX
aX/ZaBCqASs9Q/Wk0l+mercb+NIVTNVPjURRbxa4BkimsPl9A2wkvz+ihhtCRXbd
7KKQCtw3akh8yp5xWaEys4zN/EnvFQYxbyUcJVwgFQ+qdSJVCvLLjglZNzWrUb0E
fPyRd/lzlAf0WvOXHvjrU1AcdFL7Kxc9/7NITvlzGCs5YljSAmnHb3M8D0/3eN5V
saxxCP8H+AyF+CmSHPnSVTizUx2C8w==
=30pc
-----END PGP SIGNATURE-----

--Sig_/vcDC4foG=4ee6x3QtYzXh5x--
