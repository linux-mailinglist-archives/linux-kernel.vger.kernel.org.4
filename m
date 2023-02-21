Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2676369E5BF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjBURRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbjBURRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:17:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D27B1DB9E;
        Tue, 21 Feb 2023 09:17:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 528F4B8101B;
        Tue, 21 Feb 2023 17:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A867DC433D2;
        Tue, 21 Feb 2023 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676999836;
        bh=u/EX2EEQLLbGyZmnT1nRhHzcrS5k9v/S2qzFSwI8ijw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qL5sKm4UG9apubmZQOMu+2H8s1iMRxk332jvTjBXjj6XbrbSLqgbaCUlVG2jmFGU6
         q7xcC7/tKWXfiidzwA3hh4+tFnEc5zq6b1b5DzJbSV7J2IXDmdMdTg0kfLCLIfVq89
         jF232yre1YArVaxORYLJbJnO6/pcoU9FcYBYuCbgOYDbPi8zdM8zp0AUimBRIU84Ds
         jIUHErPXVmgewD1QMa0I6VmaxB3hrHVVraG1sbW/rudjSAa2USIZ7cGpgrknyqSqIY
         Tyk8GnXvpDmkFvFRnmdzQgMsOre3awurR2jWbCVCF67hnK37Mc8simqIe21HHyGYI0
         ixruPVbrFDspw==
Date:   Tue, 21 Feb 2023 17:17:10 +0000
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
Subject: Re: [PATCH v4 07/19] reset: starfive: Rename "jh7100" to "jh71x0"
 for the common code
Message-ID: <Y/T8lu07JEc7diPs@spud>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-8-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fU6grjyUvyTM1/0x"
Content-Disposition: inline
In-Reply-To: <20230221024645.127922-8-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fU6grjyUvyTM1/0x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023 at 10:46:33AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> For the common code will be shared with the StarFive JH7110 SoC.
>=20
> Reported-by: kernel test robot <lkp@intel.com>

And here too ;)


--fU6grjyUvyTM1/0x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/T8lgAKCRB4tDGHoIJi
0qXhAP94QqAsDlyOI5fHCgHZs6qx2RXiYS6SxH6gymSLvkvA1wD+IQEXOwyELVes
GPlcOEKTxiMv4SmHMsUhmgV7V77l3gs=
=m9Wi
-----END PGP SIGNATURE-----

--fU6grjyUvyTM1/0x--
