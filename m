Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A236B7994
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCMN4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCMN4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:56:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98790F76A;
        Mon, 13 Mar 2023 06:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CA68B8111F;
        Mon, 13 Mar 2023 13:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A2FC4339B;
        Mon, 13 Mar 2023 13:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678715763;
        bh=XrmPKmwKZEzUZa89QLtk4Hd7HK8rWUR7XZq2R52mvKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVNK4YgYZJ4K0piJo8DAROawkHWiV1+E7FZWwtIO/Rt2OOgmhtH/LqF7k/X39Ds9L
         JSsJgJmRbkxqRUf5YCq+wkPHuyCBL2P0ko7LAjoBHxoTm0qDuxjZA1RM98qbYPlOym
         wsLZ27sFCNUI2w7Fz0XFd/lZGognWMCA9U6zy5Uu+BgEoDaC/VIFVXXOQ7Gwxt8Eyg
         DzeQcuT/4u9w83j46qXdIoAqx0e+xCT1jbWKVGEHftI6gGQ7X/bhw8k/W9Qi6NXwBz
         AIhlybAlFKfBPsrkJjnaC3Mm6Jma9WXfIWBT9YlWkNAQ/6NtDWlbhl/U6beUoCKvsU
         sD/YvX7+JerIw==
Date:   Mon, 13 Mar 2023 13:55:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 01/16] spi: armada-3700: Drop of_match_ptr for ID table
Message-ID: <7a65d775-cf07-4393-8b10-2cef4d5266ab@sirena.org.uk>
References: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6DRAQdU86hSK7NNa"
Content-Disposition: inline
In-Reply-To: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Type louder, please.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6DRAQdU86hSK7NNa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2023 at 11:28:42PM +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).
>=20
>   drivers/spi/spi-armada-3700.c:807:34: error: =E2=80=98a3700_spi_dt_ids=
=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]

It would be much better to fix of_match_ptr() and/or the module stuff
that also references the match table here.

--6DRAQdU86hSK7NNa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQPK2oACgkQJNaLcl1U
h9CaXwf8DMJQ+FCZOrCTMX1qtiYniAQfqUZMw81w1uhZli/zJ0bkKyQuozjfL87N
j5LsX0tvE/nD48FYdMKnHL1aZ7gnmS3iVWPTCb2hYYCjMiRddTVEe4Sw9o13d/zo
8lJrUeGddSjzluNsDnpxQzwtR/z33eHcjNGU3KkauqbVczIkrQS9vSXiRxLydFPk
+T3QQHtIn3Ya4Q3IRY9TO4eAMBFZgoHeeMWyYA98GSVmrrTdygzyGXKvdv6xeJQD
cBAtY0MVSyUACuxgGJWvxTi1eGiHvQ0a4aWEgO6J29PAJJyMr71SaiKHcBI5W6CB
RRo4kwWeaZerBbrW1ByTmVBKFXbQIQ==
=vTNz
-----END PGP SIGNATURE-----

--6DRAQdU86hSK7NNa--
