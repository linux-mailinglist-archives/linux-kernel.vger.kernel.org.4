Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850DB5F98A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiJJGyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiJJGx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:53:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15DFE5D;
        Sun,  9 Oct 2022 23:53:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 705E960E06;
        Mon, 10 Oct 2022 06:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADBFC433D6;
        Mon, 10 Oct 2022 06:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665384835;
        bh=tr01/efgaCaoUSBggOvZZJW7MCJvMC5iJrs/iNEFtts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cZwsLoe9mf5z5Az/uf0pnC0/JteRNDhDvYBrsO0CFaqLemKErkQhKenUdaJaMPC2i
         1MOvm5almu+nMzHdyX7W+IwIIO4d+4lgA4UJR4ist3TjS8TstEF4wc7xUu94IxNyk0
         lRH9y7bUftBGdh4fkLq+ryA72Ihq29tOnlhi5XWtZRMqRmJQUIfyim3JOk+hAmIf1h
         RudrlUQJsx3JeLNdjhMay1qnfBZeMbRmrMdU5PTiGOkH69vK3gg1ANnjVheY7x50x2
         si3AOpFNNDpTnsNITPXhSpm8jUOe91vPUJsBBNet2k4NSrCjG77ZcIg51uW1mt+AS4
         mLby1v7qdawRw==
Date:   Mon, 10 Oct 2022 08:53:52 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 2/5] arm64: dts: renesas: rzg2lc-smarc-som: Drop enabling
 WDT2
Message-ID: <Y0PBgP3fq6jJYKyk@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221009230044.10961-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J1Yl7VJUe5ZsivnH"
Content-Disposition: inline
In-Reply-To: <20221009230044.10961-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J1Yl7VJUe5ZsivnH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2022 at 12:00:41AM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
> used from CA55 CPU would result in an unexpected behaviour. Hence drop
> enabling WDT2.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--J1Yl7VJUe5ZsivnH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNDwYAACgkQFA3kzBSg
KbYPOw//doJaSfvlyaJIrPGSEiYiUnQRw+jDwsR7jcpEcgjrboMPeW0KbalvyuhV
CHw3om/9jjjUE7+1N5lfnI5S+azgwFSP4V9WVjD/teMZtlJkw3wnFnK6FP4JQ3E7
u8/+b5kUZdB1PG5CWeUa9okU8AxmAVUrF57Osm5RjfULldXe9J4qLjgnPt84aroE
FM9h0JUlPYnCZplRWcG8L3lWnpdi/+Ot3t5t8cT29CgyPkE9nNBNX8CU3lJ2Mhwx
GvFYKMATFJ4gGPoQTH/HUE9P4R/OUfEbHHpoFQQgISrCWi71wiprgq+4EXZe5vLg
cjFIi69mowHBdBUyZkhyJErg9onhKcHJ/s1c4Aomm0/shX2nQnBlXN3hcyNnA0g8
MvJ6ZK383TKIZz09AITWKNlgH8YVOywO1oHodD3EfEul0URvN6+Z63El/5cFSR9i
iWLSd+QUzf7Lb9xiAzeUH1Xq/7WH3mOoNxeQuUMpkMrE6DLU5Pmf1ZaUqvyjx+2m
s3OxQzYxOvbM16OpsOXlFKvdLnoO8GTyT569dDZ2zWwEgpprQEIqxMUGqzc9LQsK
SMqub5UmX4a8n+SJDP4emSUZoKMyQvCmNQJntRji6NpRU3aVfEEu+mW6Up83iZRl
1vz1JvpDmJkkFqM6uaPezJcxFcTNV8FZGv2tSgA9AugmgW+Hr24=
=FVuz
-----END PGP SIGNATURE-----

--J1Yl7VJUe5ZsivnH--
