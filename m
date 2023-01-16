Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E1C66B4E6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 01:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjAPAIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 19:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjAPAIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 19:08:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DBE3A92;
        Sun, 15 Jan 2023 16:08:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NwC651CL5z4xN4;
        Mon, 16 Jan 2023 11:08:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673827693;
        bh=lwy23nmfZhv4fkQY9tMbhHi8uDx2SVbb2g5we8iNcyQ=;
        h=Date:From:To:Cc:Subject:From;
        b=S/8oFxbfEo1lkluqs9nNhUbIuM2tqeVdG9fFKrXVCgu5qSsxurq2c4noC7M0PpmlA
         1b0tMhqm1HfjMUmXQimsIl5PnO8Kal/Oxp46X0DHCTcTjNrEG929ANu1X2x+BPj4eL
         TDG4pvDeyCEW875jHsnnj2anWyj6GVZT5Dm9OCk905S2jeBDiqshM9nieKM0VaZdrq
         Us+a10WH1dpU/Q/+OPEzUCqiaqGCRIYYNl3NGFDFM7JzqPtSQY358ZcsnFJ6KcCS9v
         G22J47QNzevhxy52JKWU9Nw/FSuiCYP/dKBP+tZrhejd8TSE2zZQWYCDsFgeNMfkiC
         6qLDIcEpk133g==
Date:   Mon, 16 Jan 2023 11:08:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the thermal tree
Message-ID: <20230116110811.4d361c15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cfhklDnZ0Sh+T9s_8f7qrRo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cfhklDnZ0Sh+T9s_8f7qrRo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the thermal tree, today's linux-next build (x86_64
allmodconfig) failed like this:


Caused by commit

  0a3e14bd1947 ("thermal/drivers/qcom: Remove duplicate set next trip point=
 interrupt code")

I have used the thermal tree from next-20230113 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/cfhklDnZ0Sh+T9s_8f7qrRo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPElWsACgkQAVBC80lX
0Gz1Zgf/fpXQgUrNS1kaNdk71JfwqsLxBfSy9ae2+rtI0mZpCY3o55oWwdflvoP/
xwpBHgFseWPANBJ/aSDzojh2AmZBUX46eFCuQgallsNWMRh9cyamacnb05YifgfO
qop6LEHnQD4M25la4lJaqX08dSkFrgEQhpi+H2MgYkCFyR92dPVtrJAkcCwiLge3
C7FzY5FoKqoQX9x1zhrj9vGB6DhROtLTouwcaztK473s6fvX9PcOYsn8/jnThgTT
p8Z/bXqVebksNq9WHtBRVWAQmQJIvrUPg8vnsThSYGrmbAA7LzP9mBXexO7BHz8Z
ciN6dPGL8VQFlKt+Adk3gfn5XjaCCA==
=k3/L
-----END PGP SIGNATURE-----

--Sig_/cfhklDnZ0Sh+T9s_8f7qrRo--
