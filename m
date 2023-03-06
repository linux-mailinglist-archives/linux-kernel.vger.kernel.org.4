Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB2A6AC8C5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjCFQxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjCFQxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:53:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70165DBEC;
        Mon,  6 Mar 2023 08:52:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C89561013;
        Mon,  6 Mar 2023 16:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CECC433D2;
        Mon,  6 Mar 2023 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678121483;
        bh=GVS/y+MCIowLXLF6a4iduBGUyMME07hIbPy+mGY4qhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OEhbI14sE/tmSa23Y3HRKEw+FlapnlHMP0Tr/ds6t8hQR+rt2bjg2JIDC4nBZTY9u
         bnEse0o2RRMYYRkULM2NunUBvikQ6Cp1YcTMmp3FLkb9LYsCFL0Iol1bFVuqhhkKBK
         271YX+cqrqRC9Y3sVWqozdrO+ToHQJ8ywi3uwmU4o95upEb/nny1xnO7l7NMGJhH2q
         JmV12lo2yub9TFNMTE9fbx38iCzwvYi3Yr4ui29g3RKukkxRxpfufP6ndbxsu1V6nl
         x/+YfDb2x0ZrRs03CNeTObRowG1rZ5BqVn5XjB9AXZYLeth/x2udMaBeyE2zJ/un8O
         Dxak+Th/MwLoQ==
Date:   Mon, 6 Mar 2023 16:51:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 00/10] Add the PowerQUICC audio support using the QMC
Message-ID: <824314e0-b459-498b-9a7c-7dd4c94900aa@sirena.org.uk>
References: <20230306161754.89146-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O5OaE2O/CRe4hVyU"
Content-Disposition: inline
In-Reply-To: <20230306161754.89146-1-herve.codina@bootlin.com>
X-Cookie: teamwork, n.:
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O5OaE2O/CRe4hVyU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2023 at 05:17:44PM +0100, Herve Codina wrote:
> Hi,
>=20
> This series adds support for audio using the QMC controller available in
> some Freescale PowerQUICC SoCs.
>=20
> This series contains three parts in order to show the different blocks
> hierarchy and their usage in this support.

I already applied this series, please send incremental patches with any
changes.

--O5OaE2O/CRe4hVyU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQGGgIACgkQJNaLcl1U
h9D0Wwf/T+XbDDJ+a7hIsyWhV5O7eQGUIMp42yn1EGIJovbiv+GGxdWWJH9rKyON
muUMiRiUb1jwUtkZdtfqSLXj/jL5+2UTEEVUGOpp1MANtVFxkay56wtwpLOwXB9d
JSJrgbGOnkejnZzEBo8vFwotGy5ZayuYSbPAY3tbkZoAa7Qwy93eGXPxlhVmoOXj
lO84zg5BNwrtvmwc/FaeLwx6isoBXtGA+qg1+4uZ8L4c2mFVohVdNd4b7H0pqkP+
WKVUA/m4UfJErspOWi7hWL1MHNOfBVzF6TQ5hvNhJCjU1avbk9TGDYrMDC8RCLr1
2bNd1WOHiiLR0lfBX5wiro998wpLTA==
=vRUD
-----END PGP SIGNATURE-----

--O5OaE2O/CRe4hVyU--
