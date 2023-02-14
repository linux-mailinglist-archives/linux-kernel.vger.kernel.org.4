Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1029696F94
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjBNV1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjBNV1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:27:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5311E305D5;
        Tue, 14 Feb 2023 13:26:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4162CB81F49;
        Tue, 14 Feb 2023 21:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0C4C433EF;
        Tue, 14 Feb 2023 21:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676409981;
        bh=clJ0I3LCRmL0vWDC9Hymc1AAmH2ySeO6uZdkjUwkz4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbGDKwQPY4B0oKJUk6o14xlicXoNxc0n4V2coiARvV23mVAdR6FAc3SapQ2PA3ZAO
         QqrMCD4oCk1nBYMNrwgoNxlpyvKN69BvhsliiscJW785pYCQqeqfhmNZiQzyEUfFTm
         etZUNRJwpVhtCsRTwvqBt0T0sDMvpzhrcudbw0kkSSx3sBn6ChRaKa7O5pQ1pQ65Jg
         FXoGMhIjgwmD5GIZFDG7/igT1vV+2jlUS6GNj6oaomk7mX+G3mfb5O5WpUjXUUxsSG
         Y+arJSNIYVeFD/kMOgqFscRb68x/O0u9a3/jy/geQolhB7HZb/XRxAkQViuT2OtICP
         +Jfji91IMBDdA==
Date:   Tue, 14 Feb 2023 21:26:16 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/6] dt-bindings: Add RISC-V misaligned access
 performance
Message-ID: <Y+v8eNlcG+jbB2oy@spud>
References: <20230206201455.1790329-1-evan@rivosinc.com>
 <20230206201455.1790329-5-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LZipd+p+IRBav5Wm"
Content-Disposition: inline
In-Reply-To: <20230206201455.1790329-5-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZipd+p+IRBav5Wm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2023 at 12:14:53PM -0800, Evan Green wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> This key allows device trees to specify the performance of misaligned
> accesses to main memory regions from each CPU in the system.
>=20
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>
> ---
>=20
> (no changes since v1)
>=20
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index c6720764e765..2c09bd6f2927 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -85,6 +85,21 @@ properties:
>      $ref: "/schemas/types.yaml#/definitions/string"
>      pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:_[hsxz](?:[a-z])+)*$
> =20
> +  riscv,misaligned-access-performance:
> +    description:
> +      Identifies the performance of misaligned memory accesses to main m=
emory
> +      regions.  There are three flavors of unaligned access performance:=
 "emulated"

Is the performance: emulated the source of the dt_binding_check issues?
And the fix is as simple as:
-    description:
+    description: |
?

> +      means that misaligned accesses are emulated via software and thus
> +      extremely slow, "slow" means that misaligned accesses are supporte=
d by
> +      hardware but still slower that aligned accesses sequences, and "fa=
st"
> +      means that misaligned accesses are as fast or faster than the
> +      cooresponding aligned accesses sequences.
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

--LZipd+p+IRBav5Wm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+v8eAAKCRB4tDGHoIJi
0pLfAQCliZsffpMCiR56h2wbSY9QS5JYkNkV6WZVn6zmd4HGtQEA28WgtVfwkxTb
ekWi8UF52cG+B6xOsdzg1pmIBx7IlQI=
=SICO
-----END PGP SIGNATURE-----

--LZipd+p+IRBav5Wm--
