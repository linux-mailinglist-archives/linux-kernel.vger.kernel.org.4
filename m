Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19176B81B1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjCMTWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjCMTWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:22:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C07C769FA;
        Mon, 13 Mar 2023 12:22:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3DB46148B;
        Mon, 13 Mar 2023 19:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF695C433A0;
        Mon, 13 Mar 2023 19:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678735338;
        bh=ZkbNkZ34NZMdf0rITcJevdNA8xkyXVHk3RQ3QHQCPo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FYRY/VOEfWWIWUGkUCEd2cUc6VwsJNb9sQK7C/5po95pQcevLD7l0xgF0y6QmJ/Tm
         eNj5ZgbZf07KGpnlv0sHLqA1u5wZT0twxjYVECSoYCaXO76bNQS4iFXDW7j1ubbi5l
         JYEPa6C9b/XNYnXmhBYcWPZ3g07cMVQbfCzCd+0tIpcdMnYqk51NEXVVLMbLpTrRFf
         MRw1pjkhKY72BsZ57jxfMu5FlyeusoXdjuIffEqvxR3MJIOP+hy8V2KMXtYLDpgvZl
         pnIRq8MjquCtUDVkmqock3S5sWKiNTiW32jKwkGSc5Rfjphd83d35JcoL8yK/iB0QT
         HV2ZFtRbGLYCA==
Date:   Mon, 13 Mar 2023 19:22:10 +0000
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
Message-ID: <9bf3dd37-71c2-4118-a8da-40e656b42d10@sirena.org.uk>
References: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
 <7a65d775-cf07-4393-8b10-2cef4d5266ab@sirena.org.uk>
 <08e98d1d-e79b-fe7e-0d59-827f72277fc5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w3ox4e/H/VGMGGHy"
Content-Disposition: inline
In-Reply-To: <08e98d1d-e79b-fe7e-0d59-827f72277fc5@linaro.org>
X-Cookie: Type louder, please.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w3ox4e/H/VGMGGHy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2023 at 07:39:45PM +0100, Krzysztof Kozlowski wrote:
> On 13/03/2023 14:55, Mark Brown wrote:
> > On Fri, Mar 10, 2023 at 11:28:42PM +0100, Krzysztof Kozlowski wrote:

> >>   drivers/spi/spi-armada-3700.c:807:34: error: =E2=80=98a3700_spi_dt_i=
ds=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]

> > It would be much better to fix of_match_ptr() and/or the module stuff
> > that also references the match table here.

> Why? The recommendation is in general not to use of_match_ptr, because
> there are little benefits but it disables matching via PRP0001. Jonathan
> in parallel thread explicitly said of_match_ptr should disappear and he
> is not accepting any new code with it. And in general he is right.

If that's the case then why are you adding maybe unused annotations for
half the drivers rather than removing their of_match_ptr() usages?
There doesn't seem to be any logic here, it's just randomly making
changes as far as I can tell.

The PRP0001 stuff isn't an issue, of_match_ptr() can just be changed to
do the right thing for CONFIG_ACPI.  It doesn't buy us huge amounts but
it also costs us very little and may be useful in future.  When there's
missing annotations it's not causing issues for practical configurations
as far as I can tell, and if the macro were updated for CONFIG_ACPI it'd
be even less of an issue.

--w3ox4e/H/VGMGGHy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQPd+EACgkQJNaLcl1U
h9DNrwf/S3t3cwLWoA+nkWX0VuXmOpSbOw7CSZL7nvCqVHn162nrIu6LmmcfJG/5
TvxaEb4hrOmkhboKNrvX8JYqykzRJE12GtrxlveQhR45dqP5F9pFGMDpR62fk0LL
NChJLRUKXP9asPzr3MxBXKfZ1PdpCctyZTIQb2hF6+u4FDHA7v0jinpxpyKXiJjI
PyAjXx4BUFspLxkUdkJE8coTxx1IeckxcmbEtpSj3iSDUzmIM0mfzc2ZpvoKPCBo
PNjLoEXpL1MRbe7LyijpEe66LxerpAYjUKtav8A4iJERLpIB4o1QY8wqNwZ3+P5+
NdQrFLt5aqs/+fwE4YQl+4Q6BNUkWQ==
=fkKm
-----END PGP SIGNATURE-----

--w3ox4e/H/VGMGGHy--
