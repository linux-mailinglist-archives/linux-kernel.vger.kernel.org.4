Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C96674C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjATF32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjATF2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:28:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E04D45895;
        Thu, 19 Jan 2023 21:23:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BC96B82752;
        Thu, 19 Jan 2023 22:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7243C433EF;
        Thu, 19 Jan 2023 22:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674166630;
        bh=89utuYKQCGzeq83oKyHYUYUZDVIx127sMQsoQcEb2wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qbXgWUQIUKpa3h09/Ocor30Egjb4MGaL7bx1gdKjpc2q4enyEUlMoMPksx2Cf0CKc
         oAYbo3lLTXDxvwnhRTSMe54EZETX4XQUIIsfASm1hjfv7MVEYFNjROj38OoDBRrRp8
         UHZt2wqjGbJMPxyBmBdirkPnFiyaeLVUaK0mgkleCHMunxOVh291Y92pbDPNshygZU
         5XxibQVOkBWbshESs3encPisolIseGbkEhJz3HflnIL5vOf3LeVICHn3vdbwoI5a+3
         4QGTHrp/yz+f0opebObVO2TfTK2GbSs6+QAn1wJoUkNnsISE3NcHWnIGqs6aXU98hv
         h8ZZNNVBFeFbw==
Date:   Thu, 19 Jan 2023 22:17:06 +0000
From:   Conor Dooley <conor@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mmc: starfive: Add sdio/emmc driver support
Message-ID: <Y8nBYpMWZnPfIqxH@spud>
References: <20221227122227.460921-1-william.qiu@starfivetech.com>
 <20221227122227.460921-3-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NUNkl8OsrY3EJ11E"
Content-Disposition: inline
In-Reply-To: <20221227122227.460921-3-william.qiu@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NUNkl8OsrY3EJ11E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 27, 2022 at 08:22:26PM +0800, William Qiu wrote:
> Add sdio/emmc driver support for StarFive JH7110 soc.
>=20
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>

Gave the patch a go w/ a chroot running on the sdcard. Seemed fine :)
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--NUNkl8OsrY3EJ11E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8nBYgAKCRB4tDGHoIJi
0ugVAQCT1oOYndDpHRFXvRmGKO5D1/5gymrPbI0BvzUu7bYCzwD/djaRzOTVgw9C
+WbQyiNFGpHXG1pGlshWuMzzbeKYYgY=
=pLQz
-----END PGP SIGNATURE-----

--NUNkl8OsrY3EJ11E--
