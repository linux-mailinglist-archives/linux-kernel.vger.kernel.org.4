Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2FB71196D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbjEYVpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbjEYVpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:45:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BAFE4D;
        Thu, 25 May 2023 14:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6673364B71;
        Thu, 25 May 2023 21:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF540C433EF;
        Thu, 25 May 2023 21:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685051098;
        bh=1d20bjdX5HUdVvZRPf4VGSbqIqinzRsHvwcKXpOUIoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oAcQUkkSOjsmVnkbAo4rOPwsRIs+qW+MUrnXDJbyzI1Pifb67gOi0pDVzmXxEiaRF
         w26LgUXziy2EcR4xt0dZ2jqo1wPKGCGD+Mx1CZ6QVeuLCKqxiQtZuI6Axo+9pID+RU
         HGVtbDxkNNoSH8t1E++SMFq7Wv63fT9+ocO6MJED+HjPs67A78PRR+dcVRDiXtxznK
         NcUe1wFCrzkRoDF8rqA7NodXIuuB/RfyhdBGqzPowYgn4GrAOVKig2tVjFUSro4jkN
         SzJfi051sYZyOoljcfNKrmt5kgZX8y/wTvzJ4XhNmTQnocUfzg8D7/3Glsu+Of4IiS
         /AlNRIjLaIeyQ==
Date:   Thu, 25 May 2023 22:44:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 10/11] riscv: dts: starfive: jh7110: Add DVP and HDMI
 TX pixel external clocks
Message-ID: <20230525-upscale-siberian-54c5f003334c@spud>
References: <20230518101234.143748-1-xingyu.wu@starfivetech.com>
 <20230518101234.143748-11-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="14g6l7gbkD9WOY4x"
Content-Disposition: inline
In-Reply-To: <20230518101234.143748-11-xingyu.wu@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--14g6l7gbkD9WOY4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 06:12:33PM +0800, Xingyu Wu wrote:
> Add DVP and HDMI TX pixel external fixed clocks and the rates are
> 74.25MHz and 297MHz.
>=20
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--14g6l7gbkD9WOY4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG/W1QAKCRB4tDGHoIJi
0tacAQDzU7wda2zCGFCxnqT+sHimB4/P36sZ0pPmFeBEUk3dIAD/UZFrrFZD0rlX
S99BGmiDwdA9CkSxOXkuNlTIIz+rdAE=
=wubc
-----END PGP SIGNATURE-----

--14g6l7gbkD9WOY4x--
