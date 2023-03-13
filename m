Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990E86B79B7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCMN7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjCMN7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:59:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B8923C79;
        Mon, 13 Mar 2023 06:58:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15AD4612D2;
        Mon, 13 Mar 2023 13:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A34BC4339B;
        Mon, 13 Mar 2023 13:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678715938;
        bh=zEcQUdMeBfoETlPddkKFkjIDDgvirbomXMlkHaajWe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IEu82KsPAFa2JlJsPns2YbDSdht0+ESoS/nkVvjQMhJ1+EuOY4YHHM8jWXmlw6Lue
         0ItydL57xtY29cHzYD2+xqk/RhZeL5oSCE9u/1egMtP9XV6c8vVFiFEqIUGV8CYwwK
         Koj58JUag+J1f3sa/euBpe6mLKnlzUFG2Mvmj9b1UsFZGX2Sc5coWWsMu7SEB3LdOg
         O8k/H5TIKsy5cE5yTptmqNF5/QR0lunWpjQe03UOiFJDofqUsgNbULnvlCc9q80x6d
         4ou8QmxC4uyk59dTfcR6SgleKnp3ByCSCI7/xRYh0qpy8GOSRIRsnTxOBzKiE2f9AU
         xtmfugXQY012g==
Date:   Mon, 13 Mar 2023 13:58:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/9] regulator: lp872x: Mark OF related data as maybe
 unused
Message-ID: <a3c886f2-571e-4b66-827a-2b0fade61c61@sirena.org.uk>
References: <20230310214553.275450-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5sz95mK51+KCvPTd"
Content-Disposition: inline
In-Reply-To: <20230310214553.275450-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Type louder, please.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5sz95mK51+KCvPTd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2023 at 10:45:45PM +0100, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
>=20
>   drivers/regulator/lp872x.c:931:34: error: =E2=80=98lp872x_dt_ids=E2=80=
=99 defined but not used [-Werror=3Dunused-const-variable=3D]

Here you're using maybe unused instead of removing the of_match_ptr()
(which does seem like a better approach).  This really feels very
random, there's obviously a usability problem here.

--5sz95mK51+KCvPTd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQPLBsACgkQJNaLcl1U
h9CyJwf/WqKJPKC6kh2mubKAh8kZ595kuWjjTRVC3nIoN7SeXxKElHC+EAekIWW2
N2CKvSu+0/rnDO1xXVlzwlxocljHthQoB3llq8k8ffUdsKdk5a56cG+31hklnuPs
CydA9CgZmqBiLG5nj5h7FteJjO39HdZa5iwWO2AHodjF7RECQCfsiBcjjz9vyiZg
ckx9xRTNsQSKzG0GPMSwugJd8zRvv2nbbTTdIZkd45K3E1FqNL4LhRC73QJByH9E
vTxR1ustr/UVD3gR1P22DKLOJH2egLgVZfdInAbbL5fmtrCXWfPYefZCMJ1puXwJ
DYamtgQhghBCKuguwjidqjAVkjwMxw==
=GokI
-----END PGP SIGNATURE-----

--5sz95mK51+KCvPTd--
