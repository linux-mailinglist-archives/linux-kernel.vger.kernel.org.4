Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7556DE605
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDKUwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDKUwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:52:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51267469E;
        Tue, 11 Apr 2023 13:52:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 304AC60FA0;
        Tue, 11 Apr 2023 20:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C453C433D2;
        Tue, 11 Apr 2023 20:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681246358;
        bh=Uw2/Byf4kuU8+07mE//heEnMrZgOuJnGJy2pZr8fhEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kr7O+0tZrPjEw0m/XXSwGiAmEd0MbZYqCzhbwtcx7NCA01FSSC9pitekLgnICQxbi
         syANdkMkdw1wXFuiLU96iyGAW7TceQUdlVMG+sd7JcKbBTNlzFL6qMHoFB7n57Htw4
         wo6n0LaAmGEh5FlbS8RBYEvlsa2iSUFr7THTM1mlNZdKnJKHStKO5tfowCNPf7Y4ug
         vl7TQstNxxUicCr9x2A7brZKNb+yKoIsxG4G/j+pVNvDnEQAJXLF7S2eKthRjnDNxV
         BicfhtBoLVOViQnorBBk7E5ByCJGD3PqOLQId1Ti6sSAHfvPEo1gg8xhllRLM0SpuH
         Py55B92WHjoNg==
Date:   Tue, 11 Apr 2023 21:52:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 4/7] soc: starfive: Add pmu type operation
Message-ID: <20230411-flavoring-sternness-a3b6cdee9fcb@spud>
References: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
 <20230411064743.273388-5-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9jTLzkgimlFJEOUu"
Content-Disposition: inline
In-Reply-To: <20230411064743.273388-5-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jTLzkgimlFJEOUu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Changhuang Liang,

On Mon, Apr 10, 2023 at 11:47:40PM -0700, Changhuang Liang wrote:
> Add pmu type, make a distinction between different PMU.

Please write more detailed commit messages, thanks.

>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  drivers/soc/starfive/jh71xx_pmu.c | 55 ++++++++++++++++++++++---------
>  1 file changed, 39 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh7=
1xx_pmu.c
> index 306218c83691..98f6849d61de 100644
> --- a/drivers/soc/starfive/jh71xx_pmu.c
> +++ b/drivers/soc/starfive/jh71xx_pmu.c
> @@ -45,6 +45,12 @@
>   */
>  #define JH71XX_PMU_TIMEOUT_US		100
> =20
> +/* pmu type */

Delete this comment, it's obvious.

> +enum pmu_type {
> +	JH71XX_PMU_GENERAL,

I'm really not sold on GENERAL as a name.
Why not name these after the compatibles?

> +	JH71XX_PMU_DPHY,
> +};
> +
>  struct jh71xx_domain_info {
>  	const char * const name;
>  	unsigned int flags;
> @@ -54,6 +60,7 @@ struct jh71xx_domain_info {
>  struct jh71xx_pmu_match_data {
>  	const struct jh71xx_domain_info *domain_info;
>  	int num_domains;
> +	u8 pmu_type;

This is an enum, not a u8?

Thanks,
Conor.


--9jTLzkgimlFJEOUu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDXIkQAKCRB4tDGHoIJi
0kByAP97IOiAFgI8nObj/x4ZMdTZk7xSaKs/qUUM2jPffnTMYQD+KVvBSO9lhyL7
NFR2FZ7jNsQX8DC9ZEqOFcs91Gip5A4=
=lb9a
-----END PGP SIGNATURE-----

--9jTLzkgimlFJEOUu--
