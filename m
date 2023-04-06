Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3C86D8C04
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjDFAkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDFAkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:40:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828F65BBD;
        Wed,  5 Apr 2023 17:40:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PsN1t4jh1z4wgv;
        Thu,  6 Apr 2023 10:40:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680741602;
        bh=s8MR4f9mTNGUrqMYHvlprgDUL8TVa/Ss6siG0iBaeBk=;
        h=Date:From:To:Cc:Subject:From;
        b=cwYwtfd4t25UqvJ6vDoBnQ+/EurqvA5ET+Rvnq5HIblQIiQfOK3ZmcmwCyZ9YFzF5
         JSKp+7K+peTKydsp9kpJhGAyVhrMLKnl+kyoWkpS/3Y5/8/ew1+yJIc8r9EuwAluZT
         MeXrCT+ekvETtmQxspWs3eaKB6CHCRzwpo6T35gzaNscyPAFmDIBXvDRn6cBwAwO1D
         dxFTEEJKCUdE1ItnxT67g4Qg6QTYvwbTgYpRHmYHe9AOUrXhXBP6AxPtlmcZT7F9WS
         pzzCpf4HKj5C151MuekhxpPYzKj/QUhLp8TDV4SHUBh5CFqRD7bLrd2PLYQEtj1bRZ
         3iTzwxHMgd6tg==
Date:   Thu, 6 Apr 2023 10:40:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the thermal tree
Message-ID: <20230406104001.371d4b1a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//Q_tXnfkAiapyzk3MC2M0XI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//Q_tXnfkAiapyzk3MC2M0XI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the pm tree as different
commits (but the same patches):

  0e2bb8157058 ("thermal/drivers/ti: Use fixed update interval")
  b85ff12b3701 ("thermal/drivers/stm: Don't set no_hwmon to false")
  9cacfd77e1c8 ("thermal/drivers/db8500: Use driver dev instead of tz->devi=
ce")
  ec009518b314 ("thermal/core: Relocate the traces definition in thermal di=
rectory")
  374b2a77da87 ("thermal/drivers/hisi: Use devm_platform_ioremap_resource()=
")
  a2ea61970a34 ("thermal/drivers/imx: Use the thermal framework for the tri=
p point")
  93960ded93e9 ("thermal/drivers/imx: Remove get_trip_temp ops")
  aaa8126bca74 ("thermal/drivers/rcar_gen3_thermal: Remove R-Car H3 ES1.* h=
andling")

These are commits

  0c492be4002b ("thermal/drivers/ti: Use fixed update interval")
  0fb6c6493fa2 ("thermal/drivers/stm: Don't set no_hwmon to false")
  311526b7e38f ("thermal/drivers/db8500: Use driver dev instead of tz->devi=
ce")
  32a7a02117de ("thermal/core: Relocate the traces definition in thermal di=
rectory")
  e45c9a2fc59d ("thermal/drivers/hisi: Use devm_platform_ioremap_resource()=
")
  ed4b51b8fd0b ("thermal/drivers/imx: Use the thermal framework for the tri=
p point")
  53c9ce497dd7 ("thermal/drivers/imx: Remove get_trip_temp ops")
  3f2f689559f7 ("thermal/drivers/rcar_gen3_thermal: Remove R-Car H3 ES1.* h=
andling")

in the pm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_//Q_tXnfkAiapyzk3MC2M0XI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQuFOEACgkQAVBC80lX
0GxVBgf/f9tDeqqf7dVU3caZ0ZtcCtpsYSW/8rWPIwTbqlFw7Gdjcr1rrzDtvZHw
LRPri8ENO0J+2EPQTAafIILQNd96NWuvSzPb1d+TOL2M6gHYiJHy2tV5hezE4GQy
felvNHBCW8FfwMC7KlNeOvMo7Wu0e5bwm5MfEfqLOyJj7WsyUMKeuRAIyaKQa9UZ
Y9mTxT8KSu79SiQJCyaGXr9JuLBsXnjnTvmKIT4+wkOpVFyakBuXkBVGHQ7B2S20
WuQdAfyO5uR36GcnVQIRKdQpf5U4U1I0HmXoFFt4B+pl8GF+1o73buVXi/ekxgAF
zR8uc9O0yzSF+krNQkCrq/lkrXKe7Q==
=tURW
-----END PGP SIGNATURE-----

--Sig_//Q_tXnfkAiapyzk3MC2M0XI--
