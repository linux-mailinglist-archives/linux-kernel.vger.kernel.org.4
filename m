Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDACC6A4F08
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjB0W6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0W6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:58:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249ED83CD;
        Mon, 27 Feb 2023 14:58:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6A1360EAC;
        Mon, 27 Feb 2023 22:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8F9C433D2;
        Mon, 27 Feb 2023 22:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677538680;
        bh=DOn3IqzBFJ3kATuBFE3wlApyPVODRfIIpiPTqiQJYuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hEq+oLArpAqLo/uoxoF59arOtl6M6jRIvJqAuX3WHRl4PLpQZA6Z0rPAPoE+nzGjt
         83yytWT6c9k7ck/YuF7rBbApyD7/z9f4o8W7ywZl333hGqtzFQHEp4NXExPNVNJGP6
         Huv1fuKuBYUTL6HOIKXDY+N28CP61hkUMMaxPou+tmNLerpTVD5IW3e31hAzhbJ3py
         Jg6Zk0O4MNbT++ZEdVAHyXc8HI8m5QdiPrLfTgEa9ut+rkZ63JP5DcjYUJQGOz8P6+
         /iIckHedliE5RZmBfoD+/54BcryPhAPw1z4sxx86V8dm/zX1IS/lbmgcQxf3MWs4fv
         OeLcMXmk+J/dw==
Date:   Mon, 27 Feb 2023 22:57:55 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, heiko@sntech.de,
        slewis@rivosinc.com, vineetg@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 4/7] dt-bindings: Add RISC-V misaligned access
 performance
Message-ID: <Y/01c7sZ9ri5i8ao@spud>
References: <20230221190858.3159617-1-evan@rivosinc.com>
 <20230221190858.3159617-5-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YuphDP/Rndy0HYOx"
Content-Disposition: inline
In-Reply-To: <20230221190858.3159617-5-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YuphDP/Rndy0HYOx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Evan,

On Tue, Feb 21, 2023 at 11:08:55AM -0800, Evan Green wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> This key allows device trees to specify the performance of misaligned
> accesses to main memory regions from each CPU in the system.

Could you fold some of Palmer's explanation for why this must be in the
devicetree? Think this is where he explained it:
https://lore.kernel.org/all/mhng-8736b349-e27a-4372-81ca-3a25d2ec1e94@palme=
r-ri-x1c9/

>=20
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>
> ---
>=20
> Changes in v3:
>  - Added | to description: to make dt-checker happy.
>=20
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index c6720764e765..f79e9e5c5ee9 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -85,6 +85,21 @@ properties:
>      $ref: "/schemas/types.yaml#/definitions/string"
>      pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:_[hsxz](?:[a-z])+)*$
> =20
> +  riscv,misaligned-access-performance:
> +    description: |
> +      Identifies the performance of misaligned memory accesses to main m=
emory
> +      regions.  There are three flavors of unaligned access performance:=
 "emulated"
> +      means that misaligned accesses are emulated via software and thus
> +      extremely slow, "slow" means that misaligned accesses are supporte=
d by
> +      hardware but still slower that aligned accesses sequences, and "fa=
st"

s/that/than/

> +      means that misaligned accesses are as fast or faster than the
> +      cooresponding aligned accesses sequences.

s/cooresponding/corresponding/

Thanks,
Conor.

> +    $ref: "/schemas/types.yaml#/definitions/string"
> +    enum:
> +      - emulated
> +      - slow
> +      - fast
> +
>    # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
>    timebase-frequency: false
> =20
> --=20
> 2.25.1
>=20

--YuphDP/Rndy0HYOx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/01cwAKCRB4tDGHoIJi
0nAeAQDSm+Ztzo3Tbf7N3R9oO20Sh+ylQ2JQ5FZnSgknEmJYYwD+IOIvf5vpBkfu
PcnfnXXl8a2pwxomgK/WBgQbomX0IQg=
=KSgx
-----END PGP SIGNATURE-----

--YuphDP/Rndy0HYOx--
