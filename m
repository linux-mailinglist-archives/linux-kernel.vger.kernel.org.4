Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0C36BD06E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCPNKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCPNKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:10:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1387BE5C8;
        Thu, 16 Mar 2023 06:10:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A34062023;
        Thu, 16 Mar 2023 13:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CE3C4339B;
        Thu, 16 Mar 2023 13:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678972251;
        bh=2RzCJldVk8jMArXUXUEDEFh76r5LCOt4dG1eWPmCSuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WrbVNZKmmK9kMk4qRPrHf+IuKMA3tyQxEC21ciaSMpUfhiW2F/fAO4l1pytQxMU7p
         rNo0TFKT/crW4RgLvRfurNPojhFJ9VizLzq1twNo0wffYL4ZJhTF7HCrJRycVMn0AN
         oMxkwZ46qiBRYjcjdyJtcDVenNzjzL1ECVNgSOzz3QwNNz3kIxkTFrEqeD3a+Bh27l
         WNt6jA3p3XzEfi5PnTjiegBH8FOlhCZSy6CuZCnVkN+FB9iaCpft4Yq+f57kaRTOz6
         Qb1qX2Q/8wjhWIpf1GKomrX6XNMUChtXspSMz2dAhBCYGMY5z6WXpEECzOXm+alglB
         llJ668HifIB7Q==
Date:   Thu, 16 Mar 2023 13:10:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v1 1/1] regulator: s5m8767: Replace of_gpio.h with what
 indeed is used
Message-ID: <306b94ce-1f45-43a2-ad27-567fa5c235ce@sirena.org.uk>
References: <20230316120113.86421-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e1kAqV0ll/kkrIn0"
Content-Disposition: inline
In-Reply-To: <20230316120113.86421-1-andriy.shevchenko@linux.intel.com>
X-Cookie: The eyes of taxes are upon you.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e1kAqV0ll/kkrIn0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2023 at 02:01:13PM +0200, Andy Shevchenko wrote:
> of_gpio.h in this driver is solely used as a proxy to other headers.
> This is incorrect usage of the of_gpio.h. Replace it .h with what
> indeed is used in the code.

This breaks an x86 allmodconfig build:

/build/stage/linux/drivers/regulator/s5m8767.c: In function =E2=80=98s5m876=
7_pmic_dt_parse_dvs_gpio=E2=80=99:
/build/stage/linux/drivers/regulator/s5m8767.c:492:24: error: implicit decl=
aration of function =E2=80=98of_get_named_gpio=E2=80=99 [-Werror=3Dimplicit=
-function-declaration]
  492 |                 gpio =3D of_get_named_gpio(pmic_np,
      |                        ^~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

--e1kAqV0ll/kkrIn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQTFVYACgkQJNaLcl1U
h9DO9wgAg2Ktl6pfVC9fsKaLVPjLh4I3VKJMdveXx+50n/9WhS9b+IuV9Zg/jRts
hhlHHDL4GUv2XWrj7DMZ+Ag4HdaVGEDGanX3rPokXOVwf1WXwSoUd5hKeeqaWyOg
WvokWqbCNDDFlAlhyh/tNoMatq84qiMQs/UwAVns4hj74o7gKlZXoy4YzG7xL0nJ
NuK47m+n1Gs+OuG778PscooMz7c9g0KzIt8sf9qQBhuBMc7wY7YTlP6P9txui7Jl
apywycUp/wcZZCjWNBP/obqsfFp7qlHuOFrM2600Px1PxorNMnpCDPchOD7mTSZ6
mh1tgI21TjXp3KBl4yu5FB5TaEKqSQ==
=A4si
-----END PGP SIGNATURE-----

--e1kAqV0ll/kkrIn0--
