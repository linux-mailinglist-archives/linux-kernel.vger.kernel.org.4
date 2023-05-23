Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAEC70E304
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbjEWQ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbjEWQ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:58:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6FC196;
        Tue, 23 May 2023 09:58:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CA35634BE;
        Tue, 23 May 2023 16:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698BBC433D2;
        Tue, 23 May 2023 16:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684861114;
        bh=Y5FZGJOVD6fWSyOkSrV9mHh+QEcVsnYTwwIwtV+YJIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kvsP8s1MjKTuRt9j6veIKTkaS75MerI1Jjz5VIozlpG+QzliQq01SpTU2H5A4PiJD
         KINeqqXwrENNizksF/jVOQScMYbxWiwoq5QwE8RIrzuA+b+tneITfBDBuHKlDJ+GX8
         GpmtNTEjSA9rmvUfGqjTEIgdgcxI5aSLhts4gvs+rYUmydJo1Ir5dUoo9TK/TF+rBP
         4RSGOO1sZaJ8aafENCvrrYiP/EQEeilHfxJHkq5KbO9Pkk3mbv9rgT8WBCbu1BZBz3
         9OMpEZjrzUu/94i3KZMrbqVKtYfCxHEHaxCXc4OW+3LL09Z6Yt2NXgqVeN+eLTPkc/
         e/lReVponM9bA==
Date:   Tue, 23 May 2023 17:58:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Judith Mendez <jm@ti.com>
Cc:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Schuyler Patton <spatton@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: net: can: Remove interrupt
 properties for MCAN
Message-ID: <20230523-sliding-brethren-17ce71cdb8bd@spud>
References: <20230523023749.4526-1-jm@ti.com>
 <20230523023749.4526-2-jm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PXixhndM8VNwGChl"
Content-Disposition: inline
In-Reply-To: <20230523023749.4526-2-jm@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PXixhndM8VNwGChl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 09:37:48PM -0500, Judith Mendez wrote:
> On AM62x SoC, MCANs on MCU domain do not have hardware interrupt
> routed to A53 Linux, instead they will use software interrupt by
> timer polling.
>=20
> To enable timer polling method, interrupts should be
> optional so remove interrupts property from required section and
> add an example for MCAN node with timer polling enabled.
>=20
> Signed-off-by: Judith Mendez <jm@ti.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--PXixhndM8VNwGChl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGzwswAKCRB4tDGHoIJi
0tXCAP9ltNbM9GBm65IeJW558coKXOtltJqAmSNzBzMM+Fm7cgD/eWve/kUtYKU8
tRZCBLPf2SA/ay8T2++x+f3Rt4QDkwM=
=al3C
-----END PGP SIGNATURE-----

--PXixhndM8VNwGChl--
