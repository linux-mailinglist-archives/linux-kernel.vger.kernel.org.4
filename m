Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A1869B2E4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBQTP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQTP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:15:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F2A305DB;
        Fri, 17 Feb 2023 11:15:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CECD61F45;
        Fri, 17 Feb 2023 19:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489C9C433D2;
        Fri, 17 Feb 2023 19:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676661325;
        bh=G/85bFWMblsbIz5H+NTur/T3kbROSsPA8F4KeWTtTxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrtDEi1IVNLAktpZEhk1uI+ToDFVeSSVBgZ1ez9vN0+RG7D2uXX5SgnlxwL3xEegT
         C94sbFYK/5JALtaoEkcw2FnS3IPBE51MIA3vbDJIg3dUUGrjNZwbxAPcmC/5D1AWg7
         muCfEXNkTG36ZqSXp9JLKJhC8+0hc1Y4GTLJQ3VPu8D30oovBCHr+3QNV94QhuEXln
         HgvqZiK1aL5KstnK1JlPXZLECJovSIJRjY0lQjHbqoqBx4sOkU+BENovq6FAiIZp3V
         cOr4kQbfd0EB3DlvLvKAMLxOMyteV8x5AViB9AypQd+HuWclObS5sK1YGBBpMtQVG3
         ujbn+ASxOwZsw==
Date:   Fri, 17 Feb 2023 19:15:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Li Yang <leoyang.li@nxp.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Herve Codina <herve.codina@bootlin.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 00/10] Add the PowerQUICC audio support using the QMC
Message-ID: <Y+/SStm9ifszrYA1@sirena.org.uk>
References: <20230216134226.1692107-1-herve.codina@bootlin.com>
 <87mt5dyxph.fsf@mpe.ellerman.id.au>
 <0606f44f-bdbb-055c-6fff-440007222ce3@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VaNrrXW2eNrXN8Fc"
Content-Disposition: inline
In-Reply-To: <0606f44f-bdbb-055c-6fff-440007222ce3@csgroup.eu>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VaNrrXW2eNrXN8Fc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 17, 2023 at 06:32:03AM +0000, Christophe Leroy wrote:

> Mark, is that ok for you or do you expect this series to go via soc tree ?

Sure, that sounds good to me.  I'll give it another check and
then assuming everything is fine apply for -rc1.

--VaNrrXW2eNrXN8Fc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPv0kkACgkQJNaLcl1U
h9A2ZAf+JT6rtuHjPfgpWsk/znSGdDmha4+vtlzEcAE1Dbq5/LFIShop84OCskiY
0dIpfquVu0eN9u5F983mJtpr/jZfFZIvvJaN5ccwRNpduirs17rh3o8V0LoJRElD
jv+lct+lydazjRFK/kmsuCtxrFvdoPI6edCHvAx8xIYUyG2cbNIpsU7X5hHGHzc6
lxhGZDHR7DNveAVx91r1WaAzd8loxbpXkjGGsoqZr2/dkdSx5jlLiyIbMLlTdfrT
PrkJ/ITqKSkmwMRCK0KH/gASwr7ChraDgaEIRhC+O0K+I3pL0BnInwSuv3XezGz9
hdSU/02x5goYzdcJddt12woaNCqQYw==
=SHcR
-----END PGP SIGNATURE-----

--VaNrrXW2eNrXN8Fc--
