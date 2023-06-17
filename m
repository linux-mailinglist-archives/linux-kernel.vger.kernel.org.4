Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3F57343A8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjFQUi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjFQUiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:38:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083C9B9;
        Sat, 17 Jun 2023 13:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9087B612D4;
        Sat, 17 Jun 2023 20:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C30C433C0;
        Sat, 17 Jun 2023 20:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687034302;
        bh=/CHwpk9CBRFmj1qYfEWsG2JdH/bSAqaXeZPeerJdLOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ebt4yl7MR9pZwZCVuNh1wMiPjTlGYP6hkiDNUSQLteLPVD5x17gQ+FflSSpgJzgn1
         yYgUNq0KU6O179Qb6GrWe1aPbuI4yBKBP7WmhkU8jY618VYxdV0vZwaiVJMbR63Iiq
         +PBPISWdQ9NMXbZEDPkuGimMtk+aLYv+kfkmR4wAXKlKtATkmYcKrJc7dz7bgqATPH
         5ou6RLA68W9zH9SyucniKOVoxMYGHdo02H1s61pNy76dqqqHSXCMBQDbP3lkzh7+7A
         CkySlUNNcsPuoZR2cP9pTlFMILEVaPkxuIdrSIE1GFlun9ESFmXwlSqm3h1olsDYL/
         4POqhexA3kEAw==
Date:   Sat, 17 Jun 2023 21:38:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: bluetooth: qualcomm: document
 VDD_CH1
Message-ID: <20230617-utmost-outboard-d0fbda0588af@spud>
References: <20230617165716.279857-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gBVqaVQp7SyCcKqF"
Content-Disposition: inline
In-Reply-To: <20230617165716.279857-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBVqaVQp7SyCcKqF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 17, 2023 at 06:57:16PM +0200, Krzysztof Kozlowski wrote:
> WCN3990 comes with two chains - CH0 and CH1 - where each takes VDD
> regulator.  It seems VDD_CH1 is optional (Linux driver does not care
> about it), so document it to fix dtbs_check warnings like:
>=20
>   sdm850-lenovo-yoga-c630.dtb: bluetooth: 'vddch1-supply' does not match =
any of the regexes: 'pinctrl-[0-9]+'
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--gBVqaVQp7SyCcKqF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZI4ZtwAKCRB4tDGHoIJi
0nOmAP9Iu+69skBmd4x6Z/VRLzT2M963rDxIErRC3I8Hndv75QEAhOIW+4qs7m7I
UA9aps2KgWb69bcn7axi+MB02oDPlww=
=QFLZ
-----END PGP SIGNATURE-----

--gBVqaVQp7SyCcKqF--
