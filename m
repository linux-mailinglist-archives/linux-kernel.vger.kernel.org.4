Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B4370E401
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbjEWRAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjEWRAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:00:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDC4C2;
        Tue, 23 May 2023 10:00:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA99C634C1;
        Tue, 23 May 2023 17:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AF2C433EF;
        Tue, 23 May 2023 17:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684861247;
        bh=jaJ0/3b6pIAieL7fq+NdUUxtR/3D+7mbduKIsPhzoHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uT4yI8ErBZt7kPUabufNmr3U3qi7EuNpMVilSOx5eNIrSg82sGTBdqyHszf9Lk9wP
         CnI7VFgWJO5pm5A9ErF/VFCZiRpkAPTxOsh2mUeHzAnE/KoXffjZd1IZtZuuHiOb1w
         vjy1OInn3/iz5Waf7u35YTzzYGmuGE/O3nmV9nGybcrGdqKkotqFuwfcCUOSr33qBq
         jqRhKtFeLL85CVEAQ5Aq6vzIN7zolG0hjqMKngRW05FUSrMEIkIEF3Tf2LsTD0wBSf
         8ZzGgBhJb4HKilgyHvGf+QW4SrrjQTIE8QzBctOose6YCgZkAqvNGpSwZrAJRhhN1l
         Qs0JUi/QonHbA==
Date:   Tue, 23 May 2023 18:00:42 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller:
 microchip,sama7g5-eic: use proper naming syntax
Message-ID: <20230523-reversion-blinking-e957a2919a8e@spud>
References: <20230523070637.224476-1-claudiu.beznea@microchip.com>
 <20230523070637.224476-2-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TKZc35wrBgH3kM+L"
Content-Disposition: inline
In-Reply-To: <20230523070637.224476-2-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TKZc35wrBgH3kM+L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 10:06:36AM +0300, Claudiu Beznea wrote:
> Use the following syntax for Microchip EIC YAML file: vendor,device.yaml.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--TKZc35wrBgH3kM+L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGzxOgAKCRB4tDGHoIJi
0gEOAQDuo1qH+hiTtzNJeyy2FGVVsb+N2KIotaj6fhDQF+C5DQEA3/ke/XLLVljT
x/XAEQbixRySCP3oNgg4FdMtyhUNBwE=
=2vfd
-----END PGP SIGNATURE-----

--TKZc35wrBgH3kM+L--
