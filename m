Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFE87150CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 23:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjE2VA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 17:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2VA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 17:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C105BC7;
        Mon, 29 May 2023 14:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C00861455;
        Mon, 29 May 2023 21:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0901C433D2;
        Mon, 29 May 2023 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685394024;
        bh=GccOmRPB0udEztG6cwbnNPRx/HBXhHdt3X6KBCRBsic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWzvSwoHQ/248FecjaXfgp0WvKBBIweKxO5jIngX+JhFAdsoIX7/QBYZ+CZJZNVOO
         1t1lMhSeFvoleOBr7H9vfNcBn3O60QMpsKFRUw1IfIqWAiFGGW+6zgE0YzwN7WIn2g
         fLk/sWCGfGB+JtHxLDGIi6ScaUe7iRDgSwnYJiG9fQKZmoTm8oB3tSfUl1zdxwrNxB
         KHWnbt0BP27GfrF7uQBhvJUGFaVP/0fyPFlNdilDqUoazZu4aKT3lNvwKDoqMK/RI8
         hZtcH6khdIxbO3aJaSJ37vuCm2JRWBrB75dhHnZj7bosgGl1qrPOSvHVGecYkiLLXn
         3JeY/xLQ0YdsQ==
Date:   Mon, 29 May 2023 22:00:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: mips: Add bindings for TP-Link HC220
 G5 v1 board
Message-ID: <20230529-unhook-alone-1b1bd6e6a226@spud>
References: <84b31c59-81d3-c83d-ece9-a120b1cdcdd7@arinc9.com>
 <20230529150833.526084-1-liviu@dudau.co.uk>
 <20230529150833.526084-3-liviu@dudau.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bnLx8v7T1iZB9eV8"
Content-Disposition: inline
In-Reply-To: <20230529150833.526084-3-liviu@dudau.co.uk>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bnLx8v7T1iZB9eV8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Mon, May 29, 2023 at 04:08:33PM +0100, Liviu Dudau wrote:
> Add bindings for the compatible string used for the TP-Link's
> HC220 G5 V1 board, a wireless AP based on MT7621.
>=20
> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>

Two process things:
- Please run get_maintainer.pl against the current git tree - you seem
  to have missed 2 of the 3 dt-bindings maintainers. I don't mind my
  omission, but omitting Krzysztof means you're submitting patches based
  on a tree that is over a year old.
- Please don't send a v2 in reply to the v1.

> ---
>  Documentation/devicetree/bindings/mips/ralink.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mips/ralink.yaml b/Documen=
tation/devicetree/bindings/mips/ralink.yaml
> index 704b5b5951271..53c1f66353770 100644
> --- a/Documentation/devicetree/bindings/mips/ralink.yaml
> +++ b/Documentation/devicetree/bindings/mips/ralink.yaml
> @@ -80,6 +80,7 @@ properties:
>            - enum:
>                - gnubee,gb-pc1
>                - gnubee,gb-pc2
> +              - tplink,hc220-g5-v1

For the actual change though,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>            - const: mediatek,mt7621-soc
> =20
>  additionalProperties: true
> --=20
> 2.40.1
>=20

--bnLx8v7T1iZB9eV8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHUSZAAKCRB4tDGHoIJi
0veVAQCQVdUY/UK9HLiIxq82a+dRMWIpH3HSHl9pL8PrRVE3vwD+POs7fNQWE9Pl
gN+IYOIAL986MghPimgxudUJXa3Qcgc=
=LSFm
-----END PGP SIGNATURE-----

--bnLx8v7T1iZB9eV8--
