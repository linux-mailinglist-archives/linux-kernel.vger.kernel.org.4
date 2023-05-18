Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DA970887C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjERTlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjERTlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:41:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F3119F;
        Thu, 18 May 2023 12:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 902BB651D8;
        Thu, 18 May 2023 19:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA29C4339B;
        Thu, 18 May 2023 19:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684438861;
        bh=NU4ywM5dgREugZ4a6r1tYhbRQe1nLEkwPJTVqUYXj/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OiCdma3aE+CRL4/sUg38BiIizkEcRYHkYSx7QEPEIBxdt46LA7c3jUtVfj0XNoP8Q
         q+0UplFyHN1f0goz+tWro61SCeclDHr4id3TH4yvkWCKM++RgovSeVMPuAD61pkiuE
         KqD5pua1oo9K/WB1U7x/huAT6A37MSq4IEg+yRwYC6UWzcTKY5Ilwke90MXgtaHF6A
         nGQxOEp9UP9YaGn6VfmcZ2UiL2DKf3+9xmWGrpwLoiZunoXn5v3CaPrCb5RqJibcuq
         +lFC8LHUkZiscq0DonbwMutQNQ+lluvmj6HrdVLSg+j8W1xOjb+YdOUsf3yDVIOHbO
         oiOsBN8uzIbXg==
Date:   Thu, 18 May 2023 20:40:55 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Wei Fu <wefu@redhat.com>, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH v2 3/9] dt-bindings: riscv: Add T-HEAD TH1520 board
 compatibles
Message-ID: <20230518-estate-scoff-c009f19aad5a@spud>
References: <20230518184541.2627-1-jszhang@kernel.org>
 <20230518184541.2627-4-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lwMnHdNs4FO0hshN"
Content-Disposition: inline
In-Reply-To: <20230518184541.2627-4-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lwMnHdNs4FO0hshN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 02:45:35AM +0800, Jisheng Zhang wrote:
> Several SoMs and boards are available that feature the T-HEAD TH1520
> SoC. Document the compatible strings.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../devicetree/bindings/riscv/thead.yaml      | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/thead.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/thead.yaml b/Documen=
tation/devicetree/bindings/riscv/thead.yaml
> new file mode 100644
> index 000000000000..e62f6821372e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/thead.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/thead.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: T-HEAD SoC-based boards
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +description:
> +  T-HEAD SoC-based boards
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: Sipeed Lichee Pi 4A board for the Sipeed Lichee Mod=
ule 4A
> +        items:
> +          - enum:
> +              - sipeed,lichee-pi-4a
> +          - const: sipeed,lichee-module-4a
> +          - const: thead,th1520

Same here re: other SoMs I guess. Probably more interest in creating
them here though!

I heard on the grapevine that the boards people have now are perhaps not
the same as the design that they're going to ship in the main production
run?
Do you know if there is a more detailed part number for the boards, just
in case there are some software-visible changes?

Thanks,
Conor.

--lwMnHdNs4FO0hshN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGZ/RwAKCRB4tDGHoIJi
0jGSAQCY4kaOgHOoG9aRVof11tWusYqNws27HUKIe/mAvPbWQQD/eQDHmytrrfJ2
CpIn9rLovTl/X8C4YidVVzmRuLVQuw0=
=jiga
-----END PGP SIGNATURE-----

--lwMnHdNs4FO0hshN--
