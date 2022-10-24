Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4CA609915
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 06:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJXEOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 00:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJXEOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 00:14:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5472DE86;
        Sun, 23 Oct 2022 21:14:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MwhXz74rzz4xGG;
        Mon, 24 Oct 2022 15:14:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666584868;
        bh=OIxKlR2vI1RayHfkYuzpZ6kAfrX6v58yZMyPploAWdE=;
        h=Date:From:To:Cc:Subject:From;
        b=TVQJNzARmByxatF7GoIGxDMqnp+EZReVZLyDPtqhkyYRQkd/Nn5AsLfOfyQS6MuUk
         l0b+U8QT9e60n4rcSS6oBezB8xbsGlaCtRNwSlpXu5O0dZw70/jFMHvjRNnNG29edm
         OuEVCqmCZQVjqZxPlvCdn7Sfz5/Qfvmzjh8NSkZ/hmHvySvxty3pWdp3vddl5QT/76
         P8Uu5l8Y9vtZKdZhV3AcLm9jnDfF/rfvWpnkfaJj8FceEwtzKIY002QUAkicgn6wRL
         Er+y3LYYjAXOgRlgQiak05B/Q6IwZd4R4sEjuimNf5Qgj6oCB0l78h915VwT3cqAxb
         oIaQJxTCLUIMg==
Date:   Mon, 24 Oct 2022 15:14:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20221024151426.392a1c99@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vDG40ET2W4esxH5yNUp_ik+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vDG40ET2W4esxH5yNUp_ik+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/display/dc/dc.h:1275: warning: cannot understand functi=
on prototype: 'struct dc_validation_set '

Introduced by commit

  f4a59996c408 ("drm/amd/display: Include surface of unaffected streams")

The word "struct" was left out of the comment.

--=20
Cheers,
Stephen Rothwell

--Sig_/vDG40ET2W4esxH5yNUp_ik+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNWESIACgkQAVBC80lX
0Gx9aggAjDOFD6eqMgsVN1/gb9t8NZbZq/yesGyfcMlB4U71+rsmTPUrHymEG/y+
ocsfAtPE/59uOBRU7oX+e6qMUv5eJBLfCQLS9K4OpwoOxDNv/lFJCQA6RgNcmDwC
a/RzPwJTnoJIxYejCi2bBqfhAlhdTA/ahZ7k7jNxh7wqKnlKo1kMF8hZRNoveV7m
1iVTpigIJVg5D3NelaqSS2w0s2r4gMnOik1lMlJ+RJb1wUwjwejqQOzY83WFxx9M
HWb+krverz1svgluGCEnFB1Ir72dWFL5Rb/zeSGGQ74fu5M3uy2Q5hIZuqrWMQBy
zVSC2jb4Xqv/5LspDU48MomxisyXAg==
=U59Q
-----END PGP SIGNATURE-----

--Sig_/vDG40ET2W4esxH5yNUp_ik+--
