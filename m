Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AEE708A33
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjERVMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjERVMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:12:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64191B6;
        Thu, 18 May 2023 14:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B95761A5F;
        Thu, 18 May 2023 21:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE0BC433D2;
        Thu, 18 May 2023 21:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684444335;
        bh=9rao59iF0/hlenFI47AMwa2g21Ybabeem4OOm8CS2U0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ML3zP+bavZh8i0EG9Yp7C4Eq7IW+IXoy0jCSRQaKWC4qrvb9GCWkEsmXHqI70VRHF
         ZSxOaNHEkDtLXh5ZXLsUj3oHYZ5IkdazLGJUFfLKdxlSYQ2UkxS0E6nEqC3sH13wpc
         DWwndznU6e0JdmbqRSrMvFeNjGnB9NJzgUwHKNV5kF7oqPSlEtFFWab4uNyqzu3ik7
         b3EiCswKAMS59KhA/OcrkNFd4DHZ3vigul/oFx9v4HryifmoGYUJu1xtwnfAZS8UrY
         vTWsNwYuRAD99GZR+qBptjq1S6aaN0t9zNtQz53D0qzklQ29c8Zbgwv51qgMYkFNUj
         Oh97pDdAguZxw==
Date:   Thu, 18 May 2023 22:12:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: sifive,plic: Sort
 compatible values
Message-ID: <20230518-landless-reoccupy-efd52921a51e@spud>
References: <9cbf54da1ace03d7a45f28230fd99954d8c0d141.1683725029.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SbjnggWnJTqUrTqs"
Content-Disposition: inline
In-Reply-To: <9cbf54da1ace03d7a45f28230fd99954d8c0d141.1683725029.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SbjnggWnJTqUrTqs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 03:26:00PM +0200, Geert Uytterhoeven wrote:
> Restore alphabetical sort order of the supported SiFive-compatible
> values.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Palmer has assigned this one to me on the RISC-V patchwork, any objections
to me taking it via the riscv-dt tree Marc? There's some other patches for
a new platform that's almost ready touching the file too, so if you don't
mind I'd like to grab this one.

Cheers,
Conor.

--SbjnggWnJTqUrTqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGaUqgAKCRB4tDGHoIJi
0mQnAQC9UM3Eld08kXNym4VNUQFo9XIzMCJIShrHL56NnpCPxQEAsam87/5wbbL1
qXGirmvYqHj44ZA4RmNZgzPvtCszUwQ=
=8EvR
-----END PGP SIGNATURE-----

--SbjnggWnJTqUrTqs--
