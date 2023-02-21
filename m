Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C8D69E5AF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjBURN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbjBURN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:13:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4DEDBD2;
        Tue, 21 Feb 2023 09:13:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C910DB81025;
        Tue, 21 Feb 2023 17:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0598AC433EF;
        Tue, 21 Feb 2023 17:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676999631;
        bh=UTWxdc56Bg+YO8XilIbhRusXF7346//1k4aqaSaRM1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hP96ZN9UTZzYGWST0dk16C5FXdoBfma6+G541tCU9g3TeAa/+C3jXPvTUmrkL0JRP
         jvDubqdRNPKR9UzaB5eeRgyRV48363T5k/9dGI63InzzBdoc5lcvzeCxlJt6Cuic8u
         QgB4k8wmrEimyeZy3WiCAxO5F8Zbz95yucNyhtpvSb3w+hs3M3qMQfeWxAdO8B+DwA
         w4CUO8CKCuJ7hEPg5kZYwGQS7YQr8QcYVSXgHRWhSD/tRA7u43xcIYOyMD6HocuuvU
         4/5fu9X7jBAT+6388bZfC4zRc4q/2fFiMAoSD/VGzyLbnhTwQTCysKeziPxmCC9jKH
         z16n1MbpmQJGQ==
Date:   Tue, 21 Feb 2023 17:13:45 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/19] reset: starfive: Extract the common JH71X0
 reset code
Message-ID: <Y/T7yVD1mHLxoQ1a@spud>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-7-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aqcjb486AUxWSCDg"
Content-Disposition: inline
In-Reply-To: <20230221024645.127922-7-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aqcjb486AUxWSCDg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023 at 10:46:32AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> Extract the common JH71X0 reset code for reusing them to
> support JH7110 SoC.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

Split out makes it easier to follow, thanks.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--aqcjb486AUxWSCDg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/T7yQAKCRB4tDGHoIJi
0mzCAQCzNX7ciETyNNPQvAwhWFyXvywt5DtH5jI3CcjZGeLMvgEAqU7NT1fMnV3w
9ZxpB97C+S6RTgF9h6k1xLAmeb9rswA=
=XwAV
-----END PGP SIGNATURE-----

--aqcjb486AUxWSCDg--
