Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E757F7267CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjFGRvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjFGRvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:51:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207E41FC2;
        Wed,  7 Jun 2023 10:51:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A994164247;
        Wed,  7 Jun 2023 17:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F26C433EF;
        Wed,  7 Jun 2023 17:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686160279;
        bh=ntiLTYcguWXdxyRVd95QDYdTgdqGqLgcSnpXeyhTLIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMIyp3sPP3MH59VYsFFpl5YuH4ki5veZ2kAVMFJLMyQ/yoQYDjc0CeDPpRs5KHWsz
         9rCJ4u5LJ4xI4gaOFblTwnmrKNpIeQuJP6p/yQjyccP/P7r5vpy0k3oQ3hVNkf7oaa
         NTxUWKhlONJsi7dHmTBqKXKfUYhBFQTGPMnJDjvheI7XAgc6oAJ/rXOFtL+P8epmR7
         iER/mANVMc8QMs35lHlg80bmV4q7hi7JxbNsseTju9sbLgGUsZHMPqX366LURzMolu
         xURY7x3z8tEiw+61WBrd21zD+t3CIB2jRghx3caAnd0nRr3uTSNSzONzLiuq0xunj9
         CGE0H4WVkrVzA==
Date:   Wed, 7 Jun 2023 18:51:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>
Cc:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kernel@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/8] dt-bindings: can: m_can: add
 termination-{gpios,ohms} properties
Message-ID: <20230607-squire-anointer-762f08b27d3d@spud>
References: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
 <20230607115508.2964574-4-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WZNfJtvOS3jfTXvT"
Content-Disposition: inline
In-Reply-To: <20230607115508.2964574-4-l.goehrs@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WZNfJtvOS3jfTXvT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 01:55:03PM +0200, Leonard G=F6hrs wrote:
> The termination-gpios property allows specifying a GPIO pin that
> enables/disables a termination resistor on said CAN interface.
> The termination-ohms property specifies the resistance of said resistor.
>=20
> Signed-off-by: Leonard G=F6hrs <l.goehrs@pengutronix.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--WZNfJtvOS3jfTXvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIDDkQAKCRB4tDGHoIJi
0oEuAPwJc1/Z8ftPtfOnY/Sgc8KPdSdKO5wwVToMZDYksPiTwQD/a6uwG0LRepdo
X/Vv1J3qe8cz0FCk2a5oY/eJnZ+Rcg0=
=tfPj
-----END PGP SIGNATURE-----

--WZNfJtvOS3jfTXvT--
