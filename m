Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD137476D0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjGDQgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjGDQgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC6DF2;
        Tue,  4 Jul 2023 09:36:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BC99612F5;
        Tue,  4 Jul 2023 16:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB81AC433C8;
        Tue,  4 Jul 2023 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688488568;
        bh=SpCc/weuyI1enRk2z+oPYTNzEGwpO7yEdehgY7f+AWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHuqBcTPhFwBuGWWekOGnA+R20jbK7lqaqwuyE7UQGbmEC3xmdVaH8gUy8+PSq2dW
         MzJ/RgUxbPfHyW2YgQbSoMCEhuGlHSNZH0vh5y+/5Oa+J/5CNZwbsV963ZYqD0j+Ko
         wVTpn7IPAtTb0/WswB3KvI15qMDfCVPCn56MhPfl++jKWOwm9GWBhc7TlvBmjuc7pT
         w+0zP9tAOAtBA/dYRcPTyVifr91lh4DATbndhr5eqLXwP/51RdAEmj/68uv58EML+x
         cnZOIMvBySTdyK3NOwehaCrIKogaGBVA753mu0SjtuinC4w0ds+hofBltK+MwYzBPJ
         N1b6uSCjwfCug==
Date:   Tue, 4 Jul 2023 17:36:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH v4 2/3] spi: cadence-quadspi: Add clock configuration for
 StarFive JH7110 QSPI
Message-ID: <20230704-gooey-lair-2bc45bbd163c@spud>
References: <20230704090453.83980-1-william.qiu@starfivetech.com>
 <20230704090453.83980-3-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oezgEO9YoqNnv0Dg"
Content-Disposition: inline
In-Reply-To: <20230704090453.83980-3-william.qiu@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oezgEO9YoqNnv0Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey William,

On Tue, Jul 04, 2023 at 05:04:52PM +0800, William Qiu wrote:
> Add QSPI clock operation in device probe.
>=20
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306022017.UbwjjWRN-lkp@i=
ntel.com/

These Reported-by tags don't seem correct, given they were reports about
this patch, not the reason for it - but did you actually check that you
fixed the errors that the patch produces?

This particular one seems to complain about a hunk that is still in the
patch & the CI running on the RISC-V patchwork is complaining about it.

Cheers,
Conor.

> @@ -1840,6 +1858,8 @@ static int cqspi_resume(struct device *dev)
>  	struct spi_master *master =3D dev_get_drvdata(dev);
> =20
>  	clk_prepare_enable(cqspi->clk);
> +	if (of_device_is_compatible(dev->of_node, "starfive,jh7110-qspi"))
> +		clk_bulk_prepare_enable(cqspi->num_clks, cqspi->clks);
>  	cqspi_wait_idle(cqspi);
>  	cqspi_controller_init(cqspi);
> =20
> --=20
> 2.34.1
>=20

--oezgEO9YoqNnv0Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKRKcwAKCRB4tDGHoIJi
0pUKAP4wCw+hgpLoiMvepR3gmuLN/5ClOIQW3zICq88ap7eALgD/c9nTYk9tJZ8T
KdMpFaUJKzecsdmo6+5ZMbLvRRp2GwI=
=yjLt
-----END PGP SIGNATURE-----

--oezgEO9YoqNnv0Dg--
