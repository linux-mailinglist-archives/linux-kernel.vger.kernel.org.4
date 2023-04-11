Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E596DE68A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDKVfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjDKVfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:35:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1991055B8;
        Tue, 11 Apr 2023 14:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A322062C50;
        Tue, 11 Apr 2023 21:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADD6C433D2;
        Tue, 11 Apr 2023 21:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681248911;
        bh=EdaTBmGx5ipL6ZGZ09wYqo4JAou9hrLMcyRMGOrp9DQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhUFqokuwM/PyAhB7StoT6t2VzBtM7UGp+T7j4inc9RuXXVwW/5E2V+fqSftbitNw
         E3thFeDNKDeNS20UZTghwRH+tmRCrWsH8X1f9kOn1+uGEXTFXfOwaMQX25IqoHHFhS
         vf/pxUp8kjgqzQUYbyDfuhXWTz7Hvv1euQ7mp1HFYs8/ui43r/IiG8pjy3pYhJgP34
         wLgmuk1aJ09RsqsSwQhaaQJYnmCpPLdjyli+UZkiJg3VffSny90DRwnkJuS8FJo/wM
         UQq/lWZnxtz9xnoEmEZ27TbK/ghWyFzvYDUVqjZgYSeg2smR3zOkFDJyZp2R+p1swE
         lR0OvIJSlBIRg==
Date:   Tue, 11 Apr 2023 22:35:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>,
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
Subject: Re: [PATCH v7 00/22] Basic clock, reset & device tree support for
 StarFive JH7110 RISC-V SoC
Message-ID: <20230411-gleaming-parasail-34e2b7c3de2e@spud>
References: <20230401111934.130844-1-hal.feng@starfivetech.com>
 <20230405-wharf-rejoin-5222e5958611@spud>
 <ce311dcf-67a5-bf15-d0da-88967baf4ee9@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YCHkUOSmswIkgJOR"
Content-Disposition: inline
In-Reply-To: <ce311dcf-67a5-bf15-d0da-88967baf4ee9@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YCHkUOSmswIkgJOR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2023 at 03:03:14PM +0800, Hal Feng wrote:
> On Wed,  5 Apr 2023 22:30:45 +0100, Conor Dooley wrote:

> > Hal, can you get your folks to resend whatever dts bits that are now
> > applicable? IOW, the dt-bindings for the entries are in a for-next
> > branch for some subsystem.
>=20
> Of course. As far as I know, these nodes include trng / pmu / mmc / qspi.

Just FYI, you can get the lads to resend them whenever, but it's too
late for v6.4 now.

Cheers,
Conor.


--YCHkUOSmswIkgJOR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDXSiAAKCRB4tDGHoIJi
0n8bAP46Wjui6uRCpo1EmY/80+MrDWfxuiE6As1sjptafoKLNQEAltQ+fCrJjdwm
DA8tnYqSuOh1dsY1ECOqI2M2mTb6EwU=
=8yVv
-----END PGP SIGNATURE-----

--YCHkUOSmswIkgJOR--
