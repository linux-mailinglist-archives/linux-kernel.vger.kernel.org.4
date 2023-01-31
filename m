Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5776682DD0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjAaN0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjAaN0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:26:00 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542AC4FCF5;
        Tue, 31 Jan 2023 05:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675171540; x=1706707540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P34nOjVcnNypl+Kk1cS78xdIMrTtiyaiPBMGNb5PAMM=;
  b=jKsX/dn4TvHEbBTL+vkHHoMQi8uEan1jYfiSgyeuYcNzdhsznupELzSA
   QZfa4OWRW8IfBQ8G5Y1eqWr7swLD1XRJcTK79aLwbR7yge6z/KNGffgin
   XJiy4+afkb9mbzz2ABR4ilIhYW2u8WkbzCsOUyFCb5MfWmn2Xql2573Fi
   wn2tlVw75Vha7Q1UOxVpZ+3h1DhfKlmyjqakT9KfOTk27mA//7f1PjrdL
   d05tMxDmiwfxzOIi2om2JjrWmOMQVfHHffND5Yohshir1t3u7iE20YQCM
   os9bDALmwF+/Ax8XAoK6aGZGKVcW+7x4bqFLMNiCZ0njMI7zaED3iK89p
   A==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669100400"; 
   d="asc'?scan'208";a="198722076"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jan 2023 06:25:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 06:25:38 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 31 Jan 2023 06:25:36 -0700
Date:   Tue, 31 Jan 2023 13:25:12 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Hal Feng <hal.feng@starfivetech.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] Basic pinctrl support for StarFive JH7110 RISC-V
 SoC
Message-ID: <Y9kWuMmfvpizkuOG@wendy>
References: <20221220005529.34744-1-hal.feng@starfivetech.com>
 <CACRpkdbU=Y_LVBfSctQULzFuo4tB9KxgFbv=JGHPuuok6jC8FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0x/nIgbgGdl/P7v7"
Content-Disposition: inline
In-Reply-To: <CACRpkdbU=Y_LVBfSctQULzFuo4tB9KxgFbv=JGHPuuok6jC8FQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0x/nIgbgGdl/P7v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2023 at 02:13:44PM +0100, Linus Walleij wrote:
> On Tue, Dec 20, 2022 at 1:55 AM Hal Feng <hal.feng@starfivetech.com> wrot=
e:
>=20
> > This patch series adds basic pinctrl support for StarFive JH7110 SoC.
> > You can simply get or review the patches at the link [1].
> >
> > [1]: https://github.com/hal-feng/linux/commits/visionfive2-minimal
> >
> > Changes since v2:
> > - Rebased on tag v6.1.
>=20
> Overall this looks OK, the DT bindings does not have any review from
> the DT people but I think they had enough time to do that and were
> properly CC:ed so not your fault.

FWIW, Rob left comments on patches 2 & 3 of the series:
https://lore.kernel.org/linux-riscv/20221220201920.GA1012864-robh@kernel.or=
g/
https://lore.kernel.org/linux-riscv/20221220202003.GA1018798-robh@kernel.org

Relatively minor, but not ignored by the DT people.

> However when I try to apply this to the pinctrl tree it fails,
> for example it seems to depend on an entry in MAINTAINERS
> which isn't upstream.
>=20
> Can you please rebase the patches that are supposed to be
> applied to the pinctrl tree (for example normally not patch 1, the DTS
> patch) on my "devel" branch:

Yah, the DTS patch needs to be dropped, the file it applies to doesn't
exist in any branch yet.

> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/=
log/?h=3Ddevel
>=20
> If you resend this quickly I can apply it pronto.

It'd be nice to get this stuff into v6.3 if there is still time so that
there is one thing fewer blocking the base platform support!

Thanks Linus,
Conor.


--0x/nIgbgGdl/P7v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9kWqQAKCRB4tDGHoIJi
0jKoAQDwEN/yAutcm2C9S+weVvInq0FrTX/MBj04AH7uKiz68QD/cR8sggDoE9KR
buGAMW+O6YJN3LCNH1kb8IDYRmLo8Ak=
=/HNw
-----END PGP SIGNATURE-----

--0x/nIgbgGdl/P7v7--
