Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D78A72AC79
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 17:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjFJPHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 11:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjFJPHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 11:07:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B923A85;
        Sat, 10 Jun 2023 08:07:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A653A60B52;
        Sat, 10 Jun 2023 15:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F353AC433EF;
        Sat, 10 Jun 2023 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686409651;
        bh=OFXw4bB33vMAMP/mYtrrZ0SI5zDOVjnAgufarPsOhB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQGn99pnynaq9uYtEVwDAzPaCVqzhpd1OTSMw7uX9tK3QuRXZ/3SyX2snVoz9deYn
         7JIz9eaQdi/2YoK9ihy4ys4AsvU2vMOZAOcHyT/MnFU+syHwKbrQa6aHt7CD0Oxi/S
         SVJgm5WT8Cc/AlFzhxQ4q5M0GcxyZF6bgCsipuYWod8lBpXLgcBkaTRKoJXutecd7E
         vyP26AP8w6pAscSqadEnLZMahfGbdA0ngXAi6tyB/G7E0lZtk5jWcwUw46TXUdgKUr
         S8F00qKBUTtlJ22KSmOmOk7x+anwzyLdK18xOg2h2MtnkXuFYOSZWizcyQcjYxO4Qe
         5woFdFEakuMCg==
Date:   Sat, 10 Jun 2023 16:07:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, sebastian.reichel@collabora.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com
Subject: Re: [PATCH v2] dt-bindings: iio: rockchip: Fix 'oneOf' condition
 failed warning
Message-ID: <20230610-agreed-aground-8a08f6854965@spud>
References: <20230610143601.173307-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HX7e/hojOdb6OlLG"
Content-Disposition: inline
In-Reply-To: <20230610143601.173307-1-shreeya.patel@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HX7e/hojOdb6OlLG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 10, 2023 at 08:06:01PM +0530, Shreeya Patel wrote:
> rk3588-saradc isn't compatible with the rk3399-saradc variant,
> hence, fix the following dtbs_check warning for 'oneOf' condition
> failure.
>=20
> DTC_CHK arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb
> /home/shreeya/linux/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb:
> 	saradc@fec10000: compatible: 'oneOf' conditional failed,
> 	one must be fixed:
> 	['rockchip,rk3588-saradc'] is too short
> 	'rockchip,saradc' was expected
> 	'rockchip,rk3066-tsadc' was expected
> 	'rockchip,rk3399-saradc' was expected
>=20
> Fixes: 2daf2ae9793d ("dt-bindings: iio: adc: Add rockchip,rk3588-saradc s=
tring")
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--HX7e/hojOdb6OlLG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZISRrQAKCRB4tDGHoIJi
0q+iAQCBDXnjy5NryPeQQk7XL4f/lyuDEbE/4xBNyy6UWaXdmwD+L91PrMDYIF6a
CaCNra/LYyBrWPHVG64IgrjYkvtNrwc=
=3vCR
-----END PGP SIGNATURE-----

--HX7e/hojOdb6OlLG--
