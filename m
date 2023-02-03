Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C7D688D4D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 03:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjBCCuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 21:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjBCCua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 21:50:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E83234F8;
        Thu,  2 Feb 2023 18:50:29 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P7Ks03wBqz4xZj;
        Fri,  3 Feb 2023 13:50:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675392628;
        bh=vzoBRyeKZyNzy0K9k4ZvBz8EZZaV0JCQZzIhreFxgkw=;
        h=Date:From:To:Cc:Subject:From;
        b=QDcGlCbqLuuRuPUJVWhI/2ucXvQXpnKv05pjJg1a0PNVf11KlF2du2XQZIvQwpg6g
         ZCVSAc0fAXzBzrg6q0fs3qZqjFWpFFgCMsR8/5mwJArM0H7FCIwGFa2hdYurDwm0Dm
         Bp4IHzlZr4RDVYkMfFL1pTKes2q157m1hu+RHcbQZ/tVqb8P/lr9zLRho+hVxPRV9n
         PWsaEBFjvJahJPe+Xx4FMw+c3P50aRwVWkO5gfO7Mb5jERe8B3POrb1XIodPxDb2sR
         O0mKhGUoDh7dyDmjjPIb8Ha0UQyKNFPjtWGi1U1pehXsGh6AYIA98pRxGKnL/qn5Y3
         tEME5EmCeAT4w==
Date:   Fri, 3 Feb 2023 13:50:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the etnaviv tree
Message-ID: <20230203135027.1a4679d3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lZM9KKSoSixAGc_X0NV74Pu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lZM9KKSoSixAGc_X0NV74Pu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the etnaviv tree, today's linux-next build (htmldocs)
produced these warnings:

/home/sfr/next/next/include/drm/gpu_scheduler.h:232: warning: Incorrect use=
 of kernel-doc format:          * @elapsed_ns
/home/sfr/next/next/include/drm/gpu_scheduler.h:238: warning: Function para=
meter or member 'elapsed_ns' not described in 'drm_sched_entity'

Introduced by commit

  248cd9b265fc ("drm/scheduler: track GPU active time per entity")

--=20
Cheers,
Stephen Rothwell

--Sig_/lZM9KKSoSixAGc_X0NV74Pu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPcdnMACgkQAVBC80lX
0Gwt2wf+KzK9sOJcqtprLh/lCDLnoOE+W/odzGFrtlLP9qXR6jbWulBrMXp3f138
5qAGrTPzWZTuAe9WygeZdZwEhOb6B1oUg85I4qPOFWKBRB5Q6Fc7UeOaJAIVOSPI
NMLRuW83V0vB/36k3aVd3mY5v1JTp1uykq7iQw9b1wYke/Pc8Bq7VEMAph7xafg8
cq9I/JQdc9w6IWFhWywilV83Lhjw1k1rsvIhNa/aix5O7Kp8COBsDt4WICTdAuTq
nuaPa07WLV3/48iqcoBlAf7eKiu53EjVQh/9X2t4SRRkJzusZMhWf4DlGbbQGBKz
t57msIHHTHy4R1S/ztFk22VO2Corzg==
=s38K
-----END PGP SIGNATURE-----

--Sig_/lZM9KKSoSixAGc_X0NV74Pu--
