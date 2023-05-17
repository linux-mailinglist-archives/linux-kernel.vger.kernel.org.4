Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EA5706FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjEQRjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjEQRjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:39:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0FAAD15;
        Wed, 17 May 2023 10:38:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B07E46499C;
        Wed, 17 May 2023 17:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0978DC4339B;
        Wed, 17 May 2023 17:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684345113;
        bh=GOTkZbPkforXCIzWEdpo7am5du/j5nr8N+7mzoL0Zmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kl3C95iruW7qNl8NfsMmB+NUtYvxQemdp3dXvg1/hKthWgpHqVk4u7n1AYETbf35G
         RDftNzec9GoRcL3fSiFRZiSKsB2soe8omYAnqFmOxZv+6nsfcD0HJDt3O0zGhqEy6L
         q6J6lFlIoTMnwWfAMO6huTtvX+GDgRIyc/fVRPIvE9ziWSA77NsrqcP0UxtvmvvBHW
         /M0BYoY6ZCGTFSRQ73eLwETY6TTE+LbJDTAIsIlKCFNgpGsbIULRjNaoJjeuEJaNti
         MPdEHibhjbTWMGbdnXNmdg8MXJX1/bsnxyfgblXsLu970Ekk/G4wnUWaQ5MfhwE8j1
         K2F+fmnzkCDQw==
Date:   Wed, 17 May 2023 18:38:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ryan.Wanner@microchip.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linus.walleij@linaro.org, ludovic.desroches@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: at91-pio4: Add push-pull
 support
Message-ID: <20230517-arrogance-unroll-5e6770618364@spud>
References: <cover.1684313910.git.Ryan.Wanner@microchip.com>
 <048a41d1dcb3da0e845986a73eaac61a54c69269.1684313910.git.Ryan.Wanner@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+3SZHxIRozdmFSZb"
Content-Disposition: inline
In-Reply-To: <048a41d1dcb3da0e845986a73eaac61a54c69269.1684313910.git.Ryan.Wanner@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+3SZHxIRozdmFSZb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 01:54:05PM +0200, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>=20
> Add generic push-pull support for pio4 driver.
>=20
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--+3SZHxIRozdmFSZb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGURFAAKCRB4tDGHoIJi
0te7AQDt8TKK6+zVXzAH08t+Tkji/Yh/hqx6L9JKrOlcW0ZpNAD+Jq+csic1yeFP
ILADgL/Ov0YL7qBr8oRdJvBngPbPogk=
=TyW4
-----END PGP SIGNATURE-----

--+3SZHxIRozdmFSZb--
