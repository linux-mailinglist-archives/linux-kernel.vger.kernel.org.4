Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D239361E6A5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 22:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiKFVna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 16:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiKFVn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:43:27 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908A560D1;
        Sun,  6 Nov 2022 13:43:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N57CD19Pbz4x2c;
        Mon,  7 Nov 2022 08:43:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667771003;
        bh=NPLJIrYYOdhGjx9YSa7IN6VqLPLfnT7SouJu1IBs4+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YQpXDsUI1YvVo6K8bToXfxeV6JC15eE5KpAFuEdSrclVChuWe7uzzmU3RKveilrC1
         rg0Tnxg+TKjE5bhTSfYICZlVcWhB4NBjNzhSRJHu1nWyHgdxXsgpViKjWYQd/KkJh3
         V/I/rKDZ+KLB9xe4Wt9U18rcXOVFW3IO9wxDY6A3n5yN2+DUFlA9qcfVXzeK6ry9b1
         Zb6sc5yHm/FOq2WGQDdIbw8R6RU7mFPcoNB2ek67k2q+OepFQ7bZ6f/0/u13ccGj6n
         /BbklQh++UpbmojomWmpRxExjnD9ZnxLcNuvMGedlMUPPuDXTsA/P03KpxOA1wrkXc
         aw0JG0m18q/tQ==
Date:   Mon, 7 Nov 2022 08:43:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the sound-asoc-fixes
 tree
Message-ID: <20221107084318.5a83394a@canb.auug.org.au>
In-Reply-To: <20221031083917.6944b95b@canb.auug.org.au>
References: <20221031083917.6944b95b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MVjBo1Gv8enA0IwBrMpf=TE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MVjBo1Gv8enA0IwBrMpf=TE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Mon, 31 Oct 2022 08:39:17 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi all,
>=20
> After merging the sound-asoc-fixes tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>=20
> WARNING: modpost: sound/soc/snd-soc-core.o: section mismatch in reference=
: init_module (section: .init.text) -> snd_soc_util_exit (section: .exit.te=
xt)
>=20
> Introduced by commit
>=20
>   6ec27c53886c ("ASoC: core: Fix use-after-free in snd_soc_exit()")

I am still getting this warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/MVjBo1Gv8enA0IwBrMpf=TE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNoKnYACgkQAVBC80lX
0Gw4agf/QK7wosY8qsJs6laM66PRSYssbYZFlEtR1MLLYCKEYmGh0cZpGKQYt7k3
WNt1ysuVyglsvPUaRfA1GJm0SNhHf9uyE0RK1NrCfcDNTgiW3LApjY8ZWs+ERZCn
elPnwykukF5nd5bZf7XJE9f+6ICA9mN/5FsC7tCzS6zx1lRVFdfnL4e6sZ7hJgAy
VtCPpy7rzv6gHwzG3X+Hea7f2xowQkgw8TG3gKvD+8FyYR4fkXN6TrzD6OfX83P5
heKy+0Sf/u0rT8awiqPb4TqltmhnJH1Mpwivfkzi7FhBNE7lll92u4mtygNjVtKf
0mTCRPFjs2ggdCmKNNLUw5BCYGbg2w==
=iY7s
-----END PGP SIGNATURE-----

--Sig_/MVjBo1Gv8enA0IwBrMpf=TE--
