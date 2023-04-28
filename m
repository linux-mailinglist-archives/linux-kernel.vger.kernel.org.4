Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5226F1D28
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjD1RGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjD1RGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:06:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED002694
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:05:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A4D5644C2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ECCC433D2;
        Fri, 28 Apr 2023 17:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682701558;
        bh=PBNgi24wLhulSF0zuj6iMWeLEm97lHhM6E5QUQLKk3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TCYBDwRJ0dzlVXBN4iA/ohH3nPhKEeoAux3MMWX6gRNTNzzR55VTo2dAldmWdCRrM
         2LYZoFENr0kx8IVk9D/whEz37pOlSUCL3flWEBJcM2xPI0Y2T/XqOYo3Zs6vU1Np8s
         I3VA5s6Ko4xbmBlabtxEVozLLDFhlCgzT9qdhGIQATRXjdlfG1iDRum+a0DIA9d7+S
         QvSRqFYboBy1GkGyEzePbtYr08Y5bkrMBvRSg1kxoRFd11YEyB21Cj4MW3rxgYFY6n
         Zc02bduRKLXALq6qi8G4eZC+6C0bJw1mysndoksvtCsQYIk70gafm05h9FEKPMyM37
         lb2Wb254b8XrQ==
Date:   Fri, 28 Apr 2023 18:05:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yangyu Chen <cyy@cyyself.name>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Wende Tan <twd2.me@gmail.com>, Soha Jin <soha@lohu.info>,
        Hongren Zheng <i@zenithal.me>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: riscv: drop invalid comment about
 riscv,isa lower-case reasoning
Message-ID: <20230428-repacking-percolate-79be27947af6@spud>
References: <20230428141601.678489-1-cyy@cyyself.name>
 <tencent_85F69423082E524C478844E31D5F8920A506@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="duh32IVum06IkP5O"
Content-Disposition: inline
In-Reply-To: <tencent_85F69423082E524C478844E31D5F8920A506@qq.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--duh32IVum06IkP5O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2023 at 10:16:01PM +0800, Yangyu Chen wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> "Ease of parsing" may have been the initial argument for keeping this
> string in lower-case, but parsers may have been written that expect
> lower-case only.
> For example, the one in released kernels currently does not behave
> correctly for multi-letter extensions that begin with a capital letter.
> Allowing upper-case here brings about no benefit but would break
> compatibility between new devicetrees and older kernels.
>=20
> Drop the comment to avoid confusing people.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

You missed an Acked-by from Rob here:
https://lore.kernel.org/all/168261158214.3107331.4410018416833510357.robh@k=
ernel.org/

Also, when you are submitting a patch authored by another person, you
need to append your Signed-off-by to the patch ;)

Cheers,
Conor.


> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index 001931d526ec..1ee97621d0c7 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -81,7 +81,7 @@ properties:
> =20
>        While the isa strings in ISA specification are case
>        insensitive, letters in the riscv,isa string must be all
> -      lowercase to simplify parsing.
> +      lowercase.
>      $ref: "/schemas/types.yaml#/definitions/string"
>      pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?(?:=
_[hsxz](?:[a-z])+)*$
> =20
> --=20
> 2.40.0
>=20

--duh32IVum06IkP5O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEv88QAKCRB4tDGHoIJi
0jmsAP99ehYUNjIbvjxkbNmAqoqscoLdD0claGcn5TvVuJyyTAD+P2K++thvAX97
EKhJQedy4RCGdCPiHbW3eqRL5fjwyQI=
=bqeQ
-----END PGP SIGNATURE-----

--duh32IVum06IkP5O--
