Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F04A6F9BB0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 23:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjEGVHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 17:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjEGVHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 17:07:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D35100F0;
        Sun,  7 May 2023 14:07:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CB4E60FA0;
        Sun,  7 May 2023 21:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E34C433D2;
        Sun,  7 May 2023 21:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683493621;
        bh=XPnBjKoldpYno0O1tuQ16AzF8oEJrDIxbKIF/vVQi0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Thxp4kzzkQT3cIYymiZv06NSQqdsHONF3Vw89XEfedX/zq35HczfrJgCjIGijedEZ
         wAXYpL33pEh9bbZ72eHPPdH4SiqeGzYub9m16b5ZRq8WWJkBWJae4vRgBgo2hs64nI
         b0b/TqZpX30Qob8pBePqziaB7oatjJ7OiOH5gfmtrT8/VxLb02g8CebTvxbOWOzpEJ
         6PK/Hz+KQzhqISAQPMstCPnhNrMF50ouNMOWk9jTHgLWP6qcmBQJtFXbdsXdM5W/Vy
         CezYH7gA+6UfMF/SJ8HmHEocCr6zSfOENZK5lrPrOor6KcIifY+0pRWd+uDergjP8v
         n/BiLkey4c/cg==
Date:   Sun, 7 May 2023 22:06:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Campello <campello@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: st,lsm6dsx: reference common
 schema for mount-matrix
Message-ID: <20230507-brutishly-underhand-48c2949eb46c@spud>
References: <20230507173923.263741-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xffzJ8lz6swB158w"
Content-Disposition: inline
In-Reply-To: <20230507173923.263741-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xffzJ8lz6swB158w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 07, 2023 at 07:39:21PM +0200, Krzysztof Kozlowski wrote:
> Reference iio.yaml schema from dtschema to allow already used
> mount-matrix property:
>=20
>   msm8953-xiaomi-daisy.dtb: imu@6a: Unevaluated properties are not allowe=
d ('mount-matrix' was unexpected)
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--xffzJ8lz6swB158w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFgS8AAKCRB4tDGHoIJi
0jt9AQC6QhCXgMaGd3EBvrt5fWNfnKzWBDEeDb2WDcSylheG5wD/cRR3VYPJjpGA
D6gSybHEtldKV3KekTISIP8JTbbAZAs=
=h9Fc
-----END PGP SIGNATURE-----

--xffzJ8lz6swB158w--
