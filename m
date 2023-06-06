Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD33C7240E8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbjFFLbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjFFLbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:31:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50239B1;
        Tue,  6 Jun 2023 04:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686051110; x=1717587110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PX4wIJsd0NfghjQ/uFE2ySZMqtdfL0c7FgIDmxAuXAg=;
  b=EmefW5k/qjg0vop9SHsOkiZslyAtKTM+KimyR5Z8oqx2HJ1ABOcHh8O+
   WfcyHXJt9sgqRPSA4xP2EOYPdgxrIaeAQ67FfrJfJqBofA7OZS2ypjF34
   VdTgrRxds2jsZG79n5a6LssD1ZeHUrSqD23ILIE6FLvTezyvxtYTGRf5A
   6NioUXYC5oW5PJwhpi5sRe9BCLzisTxLZsVW6vqyfUEN8bSpj/rg8musF
   IKF5SwR9LiG9bRet6CDWMSY8pi3ssRyJKEtdEK07OMXyaRskrj24yNeVK
   lvw64o67qi78LsjuLheib3UlduLFxwx5OluY+E/Rv2KewconKbUDEJzq7
   A==;
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="asc'?scan'208";a="155753414"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2023 04:31:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 6 Jun 2023 04:31:47 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 6 Jun 2023 04:31:45 -0700
Date:   Tue, 6 Jun 2023 12:31:21 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Mason Huo <mason.huo@starfivetech.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shengyu Qu <wiagn233@outlook.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 2/3] cpufreq: dt-platdev: Add JH7110 SOC to the
 allowlist
Message-ID: <20230606-unsmooth-slip-c80fab59c9b4@wendy>
References: <20230606105656.124355-1-mason.huo@starfivetech.com>
 <20230606105656.124355-3-mason.huo@starfivetech.com>
 <20230606110804.qns4rolrrj2gku6w@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PVnj5Dy2DGpzU6zM"
Content-Disposition: inline
In-Reply-To: <20230606110804.qns4rolrrj2gku6w@vireshk-i7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--PVnj5Dy2DGpzU6zM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 04:38:04PM +0530, Viresh Kumar wrote:
> On 06-06-23, 18:56, Mason Huo wrote:
> > Add the compatible strings for supporting the generic
> > cpufreq driver on the StarFive JH7110 SoC.
> >=20
> > Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpu=
freq-dt-platdev.c
> > index 338cf6cc6596..14aa8281c7f4 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -85,6 +85,8 @@ static const struct of_device_id allowlist[] __initco=
nst =3D {
> >  	{ .compatible =3D "st-ericsson,u9500", },
> >  	{ .compatible =3D "st-ericsson,u9540", },
> > =20
> > +	{ .compatible =3D "starfive,jh7110", },
> > +
> >  	{ .compatible =3D "ti,omap2", },
> >  	{ .compatible =3D "ti,omap4", },
> >  	{ .compatible =3D "ti,omap5", },
>=20
> I thought I already merged it ?

You did, 4b4c0d37164c ("cpufreq: dt-platdev: Add JH7110 SOC to the
allowlist").

--PVnj5Dy2DGpzU6zM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZH8ZCQAKCRB4tDGHoIJi
0rJnAQDaPUiev8/jv4DVEX6KPrP+2lQ61lVWp7MZRr2EUXwcuwD/RmDLMvupVtZR
NAUW47q4A9h7saZRU5kbxp63KRZKOAQ=
=RJ+E
-----END PGP SIGNATURE-----

--PVnj5Dy2DGpzU6zM--
