Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6464574DD49
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjGJSYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjGJSYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79072C0;
        Mon, 10 Jul 2023 11:24:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1340B6118A;
        Mon, 10 Jul 2023 18:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692EFC433C7;
        Mon, 10 Jul 2023 18:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689013447;
        bh=rjU4uLiWYt4ftE2MPgO1TReUPqirL8bfjjX+jdgFQV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BiQmjWFXGyfPZVU+lfUfMILKq2gxxdkRmkChNm8Ho4Tmp5S1frLciQC7PJbeQS/AK
         lYIXtpsLgr5Uk9o9FJu1GgPf8jNg9cKcNyXgVZC56jMzQ31vlAG6bxXuLRuXXQKXnW
         kTkLv4YfyryF8iEX4EZenZ8WSajK0WObCrwxwMNGX25xVprZDDbYJWW4Jd+LlRgSr5
         wz8HKDkfUDgRPCPWUapfLJYGl8Vwb1Oq49qxMU9RZTHrukF9U0rM/9NuKrQs+Zu7zc
         p6W1vu/+emZgMuyOIffoV8xIqUBGyUiIUB9MfrSA0IPRHPDTLRvJDi25cs7OktYTmr
         cynBueTY1Ao2A==
Date:   Mon, 10 Jul 2023 19:24:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Subject: Re: [PATCH v1 02/13] dt-bindings: at24: add Belling BL24C16A
Message-ID: <20230710-sharper-dinner-f745df5f0980@spud>
References: <20230710165228.105983-1-sebastian.reichel@collabora.com>
 <20230710165228.105983-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KcRJAY7AMOgyBBbQ"
Content-Disposition: inline
In-Reply-To: <20230710165228.105983-3-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KcRJAY7AMOgyBBbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 06:52:17PM +0200, Sebastian Reichel wrote:
> Add binding for Belling BL24C16A, which is compatible with Atmel 24C16.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/eeprom/at24.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documen=
tation/devicetree/bindings/eeprom/at24.yaml
> index 84af0d5f52aa..2ec37c11286c 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.yaml
> +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> @@ -101,6 +101,9 @@ properties:
>                    pattern: spd$
>        # These are special cases that don't conform to the above pattern.
>        # Each requires a standard at24 model as fallback.
> +      - items:
> +          - const: belling,bl24c16a
> +          - const: atmel,24c16
>        - items:
>            - enum:
>                - rohm,br24g01
> --=20
> 2.40.1
>=20

--KcRJAY7AMOgyBBbQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKxMwwAKCRB4tDGHoIJi
0rZpAQDbwgCS9Zg4JSwt5AcLQsX8Nc0a9ofpQpfLTLnJzN2KbQD/Vnci9I604WGR
tLvTTsbkX3b5YRmXgHuFOT4XWo6lMgs=
=u4BM
-----END PGP SIGNATURE-----

--KcRJAY7AMOgyBBbQ--
