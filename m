Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172D763CE13
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiK3DrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiK3Dqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:46:51 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC8F7CAA0;
        Tue, 29 Nov 2022 19:45:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMQ8J3lyhz4x2c;
        Wed, 30 Nov 2022 14:45:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669779921;
        bh=vSCNP20jNNU9PanNmKcpDhBYBAb0zoaX2BjWN9zjp8Q=;
        h=Date:From:To:Cc:Subject:From;
        b=EggiB4QBby6xt8qBr+gBbH2sXkvQP9bjyc/LTIFP8iG/+vB6/eyJPGlAMIwcSPdpc
         t4z7/ztJBxJsqmM/dMV0wvigarvRcay9xkk22MdZivxjYru1sOabYIRQEYclYPPQHM
         x6WE6DqxGhmOYj1s983OyqIXJOFGNiW+7KiOiByZaSVr6Z453Kcc1wnfkdyPc6a8Dl
         3UQv3skB0h6kSxN44dZONYlSrcDZ+7lti01L7MG134V7d9uqlvsHARFKqdQtUmvVf7
         dvLN6AL5BAuknHgwDEn+w/prfeu4uYSj22cX9zbqCDGr7pC+8Jq5Ce4f/CqXLLL5/W
         5YcGSs8SqBnSw==
Date:   Wed, 30 Nov 2022 14:45:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Matt Roper <matthew.d.roper@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm-intel tree
Message-ID: <20221130144519.59596e5b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hunDUK8tw9XrB0Hir.D4Y4b";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hunDUK8tw9XrB0Hir.D4Y4b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-intel tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/i915/gt/intel_gt_mcr.c:739: warning: expecting prototype fo=
r intel_gt_mcr_wait_for_reg_fw(). Prototype was for intel_gt_mcr_wait_for_r=
eg() instead

Introduced by commit

  41f425adbce9 ("drm/i915/gt: Manage uncore->lock while waiting on MCR regi=
ster")

--=20
Cheers,
Stephen Rothwell

--Sig_/hunDUK8tw9XrB0Hir.D4Y4b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOG0c8ACgkQAVBC80lX
0GzAawgAo5N+eKZzCqCdPTAqjZTB9m1NxOOAMDsO4vl3UFio6Nmnbh9acmofcyO4
y9tIkCfYbSzyJtQ3y5lPhK145ZXnIXgPXGT3Fmc8AwAdu7YeQ0jYcnIuKFwZGJ8F
0obnxzEPM94Z+OiI5m5vvcnf77TogOZFyt0FRJGuWmnHwDAG/UIPr/thz0dSTTfs
qglSQIDbr5QO5HODIbDmByqRRuUdnM2B9tq55CjyKkwCEaNeNaItq59a6malAGmG
5BXRxsX5lO9fZrCsgYO3JEXR9loZW+SvjYEM9uYx+VtFMaUIyWiehXOg6NJvDPTQ
lVzxG0NiEypb9BDiP08xpFAndSxyQQ==
=+OkD
-----END PGP SIGNATURE-----

--Sig_/hunDUK8tw9XrB0Hir.D4Y4b--
