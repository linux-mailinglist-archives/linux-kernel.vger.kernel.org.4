Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60806E0F43
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjDMNxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjDMNxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:53:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C85C9ED9;
        Thu, 13 Apr 2023 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681393985; x=1712929985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RI5dxyny4pd6aZFj4Z1YM4GJ/8KIefexr1VJF7/pVbY=;
  b=RkREgTExxJvehHtbjdlCpVYyXJqGDk9uQLbfhoOzhSFnTZFjZlN2/8jE
   uVB4BFdVtquNSa3jspILzbz/w/YE1gh8Wy91p5SigOusEbgOs64vXvBBK
   U8KhNrchxkVyyo0Iu5H00rbqV+Ygu2/0zIzj0ar731hXsAKK9Z9aA0cDr
   4Gsv7PE+cALAvqBnX+KvaXuYJZeGI+bvihQN+/+RUoFgNZHh/mEDZVfCA
   osqJoT/X5UiS5kJfnpY5IclUtuQrGA2YQZ7dwChzJ6UbgA+gEXL6l+CaA
   rPdlSVkJnYVkzOHmJFcbeFwL+lROtaPndVOq4MrgRv8gr9VRLpoSwejwh
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,193,1677567600"; 
   d="asc'?scan'208";a="208958686"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2023 06:53:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Apr 2023 06:53:02 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Apr 2023 06:53:00 -0700
Date:   Thu, 13 Apr 2023 14:52:44 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v4 07/10] clk: starfive: Add StarFive JH7110 Video-Output
 clock driver
Message-ID: <20230413-hardcover-ground-efbd862c5ec3@wendy>
References: <20230411135558.44282-1-xingyu.wu@starfivetech.com>
 <20230411135558.44282-8-xingyu.wu@starfivetech.com>
 <683cbe934d1df9436e003466d2a419ef.sboyd@kernel.org>
 <463ee23c-f617-bed0-27a8-56c6fb40d092@starfivetech.com>
 <cd4a11ae65e186799145410969d40421.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v0ip4bKAlPiDmbMW"
Content-Disposition: inline
In-Reply-To: <cd4a11ae65e186799145410969d40421.sboyd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--v0ip4bKAlPiDmbMW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 09:04:08PM -0700, Stephen Boyd wrote:
> Quoting Xingyu Wu (2023-04-11 23:15:26)
> > On 2023/4/12 2:33, Stephen Boyd wrote:
> > > Quoting Xingyu Wu (2023-04-11 06:55:55)

> > >> +       if (ret < 0)
> > >> +               return dev_err_probe(priv->dev, ret, "failed to turn=
 on power\n");
> > >> +
> > >> +       ret =3D jh7110_vout_top_crg_init(priv, top);
> > >> +       if (ret)
> > >> +               goto err_clk;
> > >> +
> > >> +       top->base =3D priv->base;
> > >> +       dev_set_drvdata(priv->dev, (void *)(&top->base));
> > >=20
> > > See comment later about setting this to 'top' instead. Casting away
> > > iomem markings is not good hygiene.
> >=20
> > JH7110 resets as the auxiliary device of clocks use the same iomem as t=
he clocks
> > and the iomem will be got by dev_get_drvdata() in the 7110 reset driver=
s when registering reset.
> > So I follow the basic 7110 reset driver and also set the iomem not top_=
crg struct.
>=20
> Oh I totally missed that this is how it's been done for the other
> starfive driver. It's still not good hygiene to stash the iomem pointer
> that way because the iomem marking is lost and has to be recovered. Can
> you make a wrapper struct, either for the adev or to pass in struct
> device::platform_data?

FWIW, this did come up on an earlier version of the other starfive
driver:
https://lore.kernel.org/linux-clk/e0d8f9ba-5bf4-d7dd-5110-20d4196556f9@star=
fivetech.com/

I probably should've pushed Hal to use a struct, but evidently I didn't
reply to his final message there, so apologies for that!


--v0ip4bKAlPiDmbMW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDgJLAAKCRB4tDGHoIJi
0grQAQD5cpctgc5Bq3S7CyFGTLA6byxDhiBh5Iyvw4xFI+lLdAD/SOinBHpjM3Vf
npC+7trX9b+0Hc7eNQTp7L341SH1nAw=
=b8hm
-----END PGP SIGNATURE-----

--v0ip4bKAlPiDmbMW--
