Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBE46A6448
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCAAeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCAAeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:34:17 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF9215560;
        Tue, 28 Feb 2023 16:34:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PRFbk46w9z4x80;
        Wed,  1 Mar 2023 11:34:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677630850;
        bh=WddB40fwO7PssRmHVI2hf2Agy9VvqAt62aegQrZ3DCg=;
        h=Date:From:To:Cc:Subject:From;
        b=c5HPsNR43DBoUwjEsFatjIKsXttK7pSy8BRqPqLIlZEnas7JKgwmwTkFmU5wVQavG
         o1suY3oANMAPLoGg0SHTYnqloXVeVSGo87pKHukykuBUB395mSh6TRNOK2+incMrdn
         bU8ZmWTgXol8I2q1kWuP3+fruuasS8OgpstnFsXAGVDXTW2bmjj3cwVM7yh/KvNzP1
         LYVFjcpvyu1Go3BDWV0sXP5wNti39abe4wVSvns27gaAgvXrHJEEYVwLm14gdDhOeA
         jyfCMk+vrws7kgVqP9ycmisBKgehV5zYOLreinmGZdFY6MsRVG47cNFrJzAMHBqePh
         WUMzlEKfro9Kg==
Date:   Wed, 1 Mar 2023 11:34:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alvin Lee <Alvin.Lee2@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20230301113409.6510f038@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PFvDxa2Dkl6blbuxmyz=_DA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PFvDxa2Dkl6blbuxmyz=_DA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/display/dc/dc.h:878: warning: Function parameter or mem=
ber 'override_dispclk_programming' not described in 'dc_debug_options'

Introduced by commit

  7bd571b274fd ("drm/amd/display: DAL to program DISPCLK WDIVIDER if PMFW d=
oesn't")

--=20
Cheers,
Stephen Rothwell

--Sig_/PFvDxa2Dkl6blbuxmyz=_DA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP+nYEACgkQAVBC80lX
0Gzbxgf/RbgHbH4ZZ3WNGHEjr68n5n3G4ZTetjklJ6Qre3+CqUKslerAaqDvDrDM
tQQZ55ez/Pta+TIbsIVnVPRGGj7yU4SBoeV45G2z80ckwWEKjum7DPxsJRniLMsO
aqolhkIaSuekHADnPmK2SmLAzXk0yswBtnY03iRJG0MbfN+mtmb9gPao3oqmL0il
luIuQbBKkpKizk5aghePQNZMA/8mkb4LYV0FmrLKLJphHU9u2vnIijITnrQdYnfF
Pqz2S4P/5OBOhDblAQ+Vl+0LxMmfBEpty5IrBy+eM5RRMoUXMTonpMx3vTkmfClF
uUZmaColnrTwVNZWvNRMzcrOa8g7nQ==
=DDkr
-----END PGP SIGNATURE-----

--Sig_/PFvDxa2Dkl6blbuxmyz=_DA--
