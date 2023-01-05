Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570B465E356
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjAEDRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjAEDRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:17:20 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B4113FB5;
        Wed,  4 Jan 2023 19:17:19 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnWqJ6b0Yz4xwl;
        Thu,  5 Jan 2023 14:17:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672888637;
        bh=5S7GGgrErFmMIEBx0BSV0FbXaZsxDPJa2ZKeCikBLtc=;
        h=Date:From:To:Cc:Subject:From;
        b=THS8528MgPOTfNAe96q7j240zaGISh2mN7YD8GZuVyvRYbaqjtE3ylZwTzcv5wzQA
         AqQDvQmsv/q/70ygeDAplEvky582fqs4u4PipcoJ18ESilkcJqmdVrmafaDaEKpag2
         Z1vY3ADn2tBz13jgSBXYufgQHMXqDnDnMb+BQERfobjQCqMDq63Ybd/HcanTHCVI9V
         aSU/EB6o16lVh1QYMoGHZcyYgNHPwtrD8rYhec82oSvCk1ZGp3Hqy78n6/vAj7+Lts
         Uo6alUwcI3PS5BzvP3xq6tOnr34QbPO/K/+kuK3HjS0qNoBis5EN9LMn/iYkAKTjJL
         E7QRt/SQb2QFg==
Date:   Thu, 5 Jan 2023 14:17:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm tree
Message-ID: <20230105141715.200223e0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LE/p0cO/FdDWAm1VEvEIH2s";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LE/p0cO/FdDWAm1VEvEIH2s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (htmldocs) produced
this warning:

drivers/gpu/drm/drm_atomic_state_helper.c:560: warning: Cannot understand  =
* @drm_atomic_helper_connector_tv_check: Validate an analog TV connector st=
ate
 on line 560 - I thought it was a doc line

Introduced by commit

  5a28cefda3a9 ("drm/atomic-helper: Add an analog TV atomic_check implement=
ation")

--=20
Cheers,
Stephen Rothwell

--Sig_/LE/p0cO/FdDWAm1VEvEIH2s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO2QTsACgkQAVBC80lX
0Gxy9ggAmGK9TknHOcoEcqw1IfiDS83NQYLHomnoGHTtupgdV93H0KM2TchFgWmI
K88hXCuR4E1sSbTGjNQSCYDHUn2OU55Z1oT3AMUaVzNvxZAnLn8le4KUOorbz4pj
S7QYy+c0Vp8SVy0CZc+SMEl7vgE87uCRnZN+iDLAYUegPiI/woQTGoGUEcdYa4xN
9YXNpP5j1O4mLnPzms/iVcc0f8lfBk5A/sM+RRE278r5Cwxg17HY26qy6kWHSVSC
aiBLTK87SR6kXF+12P1npQpB4kmz3wuzdmpVkGBgjkh7/ElamScEhuEyesQl4O93
qZMpRZh/WQsnVzsceVPJ0SjRlNMa3g==
=zAcW
-----END PGP SIGNATURE-----

--Sig_/LE/p0cO/FdDWAm1VEvEIH2s--
