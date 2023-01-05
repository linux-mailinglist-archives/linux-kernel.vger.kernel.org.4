Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3193065E372
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjAED1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjAED1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:27:19 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3C748826;
        Wed,  4 Jan 2023 19:27:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnX2q6jGtz4y0B;
        Thu,  5 Jan 2023 14:27:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672889237;
        bh=T/mJIWEOpF2Kt/Rsdz+IYRH758gICLRlV+vE8xQmF7w=;
        h=Date:From:To:Cc:Subject:From;
        b=BomVQFtbv5swYeeEZxYQdPH8ZzW2iLrE2e1ZsCQUuzknvO71zHHKWvlLKjXdyU7NM
         qaxLhdTuBIgKf0WKzhkatfEbE6IZBnue7arM2Rj3SS3zgykAfekHegYRscumbqqGqU
         0lvUNtELgjth2iB6nfjaeIc1CwzFTefZDQ1s8bNeaSu5zjEzuZH4lz55//t3+UPYLw
         gY6JYSEWDPtR7NZSpGcKH3VTPTfmsJ9PasWztoctFhKFmW2C9m+w9OXxifXhItOa2G
         wBQbFnrz10tj4dbHursPw/GY6vo1HyxunYDR5p88fXd0u0PZslKcgxouxfU5vIa9SK
         hYs7x+mnRl6BQ==
Date:   Thu, 5 Jan 2023 14:27:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the drm-intel tree
Message-ID: <20230105142713.6a6cac10@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Gsv_+fERN4E48iB=rDcj8aI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Gsv_+fERN4E48iB=rDcj8aI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-intel tree, today's linux-next build (htmldocs)
produced these warnings:

drivers/gpu/drm/i915/display/intel_dsb.c:201: warning: Excess function para=
meter 'crtc_state' description in 'intel_dsb_reg_write'
drivers/gpu/drm/i915/display/intel_dsb.c:201: warning: Function parameter o=
r member 'dsb' not described in 'intel_dsb_reg_write'

Introduced by commit

  b358c3b98813 ("drm/i915: Make DSB lower level")

--=20
Cheers,
Stephen Rothwell

--Sig_/Gsv_+fERN4E48iB=rDcj8aI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO2Q5IACgkQAVBC80lX
0GzSoAf/XfSdrpM25TU+j7+evILzw8FSIzjPYKmHD1Cq/oPFtftYAfznPaGtALSr
Qkn64bitLnHe0x1igfGBHMSOP3QX0Qb1zRbwDNkbJ7/8f6OTAEe2A05koMBnHQyq
BDCNvVcJ/kZdPq1OPTGPEKALYsLDvXr2KpUl5ODE/wB2tOTqrVbaT50nUnnWET4B
/CR4Wmcvsrk4Vw0J2Szw8/DQjuDT3ERvY4KxJf+w+GPunGaSo5ociIuehbY3O5/F
8st3IO9UK1uEkFlgHGeTpWo2Iw0k4EtzL4pjmbbDPpjh9BtaYn+qgWm0dTIAc62o
F+5x1Qklx3kGK1SuWy97BZoyzcxi4A==
=pqfY
-----END PGP SIGNATURE-----

--Sig_/Gsv_+fERN4E48iB=rDcj8aI--
