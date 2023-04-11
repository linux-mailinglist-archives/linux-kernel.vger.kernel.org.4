Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E936DD679
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDKJUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDKJUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:20:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6218D1FC1;
        Tue, 11 Apr 2023 02:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681204850; x=1712740850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rG97cuIKZfWarCKMEtGQ4BtW1PVd9E6YqLa6yI8Cg34=;
  b=NgxTDwpYjhLLjxGj5B202GgPn6ZEvv0eQl0gIxS6PaNvP7ABGFlQ8TXh
   NnlVgUWgb+N446r3LGi7M2bYbzu+biiRt5ANQvB0mtmiIpkko9l2a4Z5P
   mezMhzRAdlZQ27LWObAFZ0zL2Q3sLynXyGtGnvGp0QyNXgBvwusOICG1l
   mamOE3nIdUUvQxe8txx4cOI84ctfIyDUlF8+VYCr1UBWZw4/1IEtx/Pc1
   Bc+EbZJBpnW6Nqd0CzzKx53QwEKtcYw5+XSnBYOh3feEOol4x/wapGrdy
   dpkeXZgrMPiok/LUF02vE1Rbg+hzWptS14cui26xpUiMf/78jobQ5OfSK
   g==;
X-IronPort-AV: E=Sophos;i="5.98,336,1673938800"; 
   d="asc'?scan'208";a="146441855"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2023 02:20:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 11 Apr 2023 02:20:49 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 11 Apr 2023 02:20:46 -0700
Date:   Tue, 11 Apr 2023 10:20:31 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Mason Huo <mason.huo@starfivetech.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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
Subject: Re: [PATCH v1 2/3] cpufreq: dt-platdev: Add JH7110 SOC to the
 allowlist
Message-ID: <20230411-rewire-outlook-a5fb631fb635@wendy>
References: <20230411083257.16155-1-mason.huo@starfivetech.com>
 <20230411083257.16155-3-mason.huo@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/DkWhqOrZbaY7lnw"
Content-Disposition: inline
In-Reply-To: <20230411083257.16155-3-mason.huo@starfivetech.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--/DkWhqOrZbaY7lnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2023 at 04:32:56PM +0800, Mason Huo wrote:
> Add the compatible strings for supporting the generic
> cpufreq driver on the StarFive JH7110 SoC.
>=20
> Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufr=
eq-dt-platdev.c
> index e85703651098..a1ac955aa7e2 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -92,6 +92,7 @@ static const struct of_device_id allowlist[] __initcons=
t =3D {
> =20
>  	{ .compatible =3D "xlnx,zynq-7000", },
>  	{ .compatible =3D "xlnx,zynqmp", },
> +	{ .compatible =3D "starfive,jh7110", },

This struct looks to be in alphabetical order with a blank line between
vendors.

--/DkWhqOrZbaY7lnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDUmXwAKCRB4tDGHoIJi
0q1CAP4hP0FaG1N8fWLK8YeBOG1dPrmqZ2GiASDCJ033kKDRsgEA+uyakkXQHuIE
C3ejb+nnlELB4J8+dRseORPc4E0dQQM=
=v6J5
-----END PGP SIGNATURE-----

--/DkWhqOrZbaY7lnw--
