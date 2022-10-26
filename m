Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F99C60D8C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 03:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiJZBOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 21:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiJZBOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 21:14:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3C810B45;
        Tue, 25 Oct 2022 18:14:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MxrSQ2qdPz4x1G;
        Wed, 26 Oct 2022 12:14:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666746870;
        bh=KYZQBP+r+NEO/kh9qsoAYXJ6ceHtahcWMWsYSABpAic=;
        h=Date:From:To:Cc:Subject:From;
        b=iP6EM+amPgj+C93nqgVElsvurhnQN7wW5wcifZNgq8E5VMPfJsxaKK6ZJWGe9sChs
         YlyaivGYiAjlZmF+kL6rBwTlcIV6eTjCCavzVGnWMVfy3Jf2NoVgqQx+GJ0xh5hvQe
         lbusEq+BZyYC1X0zt8tESOxDflHeJUuUIby5A2Hrt1A0mRgjbEq/deydBQ8rUyqE5u
         xFbWZY+6tTDJnbHvQ7ql2A8rASYciCgDj04ayF0YMlYjkDo6NgG5uv1TV2dZYAn61L
         yDGX0xoqbL1gzcfCEAs2tU831eQKj9+IVY9iUqQl0OUk4NNrkTWP3M/1YGBRwRX7PC
         UKKtyh/FNLIEQ==
Date:   Wed, 26 Oct 2022 12:14:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20221026121428.5181969a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=k/BjTolL+Hjgnf7IvGAwtg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=k/BjTolL+Hjgnf7IvGAwtg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/display/dc/dc.h:1289: warning: Function parameter or me=
mber 'plane_states' not described in 'dc_validation_set'

Introduced by commit

  f6ae69f49fcf ("drm/amd/display: Include surface of unaffected streams")

--=20
Cheers,
Stephen Rothwell

--Sig_/=k/BjTolL+Hjgnf7IvGAwtg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNYifQACgkQAVBC80lX
0GyPPgf/SCbSRcMWfytdAY5F2fcPCQsaBgQXkuJEvRQzAUk5REiivXF5P3mJAWE+
7EcrsImeqiA0utlDjX9Yz7JGdEE7YgQdYuy6+A18MAugcik+3+koF/w0qS3k7+fo
cMXh3DZ/wZL9tUrbzebVPqJt0c0S7+AsCiZwBNDoJWJguv1Z0E0w2KdYl+f61Jcs
AlJHrkiL8piCA7iwyW5sk0/o/p5ilPhaa3/iufvyhAYV4sta+I5pAfbSJRP8fg6b
5qEJZtQUwfKHtDkg0XwrN+l8tjiC0JSSR+aUXUkDzPgp7/VlcjqTHTGpRnmJia9D
N2H4cNe3CY7rfPj+7hdRJR2KWEWvaw==
=rWKb
-----END PGP SIGNATURE-----

--Sig_/=k/BjTolL+Hjgnf7IvGAwtg--
