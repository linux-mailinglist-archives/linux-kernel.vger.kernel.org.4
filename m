Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D92A6E903D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbjDTKcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjDTKb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:31:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67460268A;
        Thu, 20 Apr 2023 03:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681986541; x=1713522541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PxxF+ybrqPaMA+5/3lIm0KfonobVUIOCFzFZF6VC8s4=;
  b=sTF+OV/hKGRWtan4VU324dX6U+waQMcMNgEhiWfZs3ZAybiJ5tBTt3ue
   Kx9UV4YCN8Qf2BO5y85dyYuM/9s/pUFr/Mc6Rb0sc1fcnH5VnUAo8BgET
   i+XeBwVpZsxq+4kjeUtjXiySF3t4hrZY3isTeyNnjFOR8kOZ4cAmelYpZ
   rHDzt96FhO3GgVqsp/8HSvt8chjEEFL8Rl48nFGa9MLQEDH6HmaLRoWml
   EBtKVywvkN8bsfpqxgOAmoSzqJSvti0yutKRRJauV3VsRT3nuzdTdJ3aF
   sJo0z+x8UFU3a/Q3EcF0n668YslRKSWR1EjJWiubF7pNVxGGKj8C8VqTZ
   g==;
X-IronPort-AV: E=Sophos;i="5.99,212,1677567600"; 
   d="asc'?scan'208";a="148053676"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2023 03:28:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Apr 2023 03:28:43 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 20 Apr 2023 03:28:40 -0700
Date:   Thu, 20 Apr 2023 11:28:24 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Nylon Chen <nylon.chen@sifive.com>
CC:     <aou@eecs.berkeley.edu>, <conor@kernel.org>,
        <emil.renner.berthing@canonical.com>, <geert+renesas@glider.be>,
        <heiko@sntech.de>, <krzysztof.kozlowski+dt@linaro.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nylon7717@gmail.com>,
        <zong.li@sifive.com>, <greentime.hu@sifive.com>,
        <vincent.chen@sifive.com>
Subject: Re: [PATCH v3 2/2] pwm: sifive: change the PWM controlled LED
 algorithm
Message-ID: <20230420-pension-threaten-bc9a549465ab@wendy>
References: <20230420093457.18936-1-nylon.chen@sifive.com>
 <20230420093457.18936-3-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="221CyLf96APVzjPW"
Content-Disposition: inline
In-Reply-To: <20230420093457.18936-3-nylon.chen@sifive.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--221CyLf96APVzjPW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2023 at 05:34:57PM +0800, Nylon Chen wrote:
> The `frac` variable represents the pulse inactive time, and the result of
> this algorithm is the pulse active time. Therefore, we must reverse the
> result.
>=20
> The reference is SiFive FU740-C000 Manual[0]
>=20
> Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b=
16acba_fu740-c000-manual-v1p6.pdf [0]
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Hmm, I don't recall reviewing or acking this patch. I do recalling doing
it for 1/2 though:
https://lore.kernel.org/linux-pwm/Y9len4GinXQ101xr@spud/

Please remove these from your next submission, I don't have any knowledge
of this driver nor do I maintain it, thanks.

> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>

This SoB is new too AFAICT and looks a bit odd.
Should there be a Co-developed-by for Vincent?

Thanks,
Conor.

--221CyLf96APVzjPW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEETyAAKCRB4tDGHoIJi
0twCAQD+D5uuZoL6Zj8V7Jd9fPKoYRdogs5ET3HIn+Gcls1UdQEAzjD2zPc7ebgY
pOORg2ws5wOTXnrM95U5x6F9kWjMzws=
=E5F/
-----END PGP SIGNATURE-----

--221CyLf96APVzjPW--
