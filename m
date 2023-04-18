Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852976E5974
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjDRGcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDRGcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:32:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C671BDA;
        Mon, 17 Apr 2023 23:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681799527; x=1713335527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jnwKOCRsuLnztB+KT1haBu8YKUI0iN96QK5cHgHZ3Ck=;
  b=xkjhZGU6f29Ly+pTCI7QUKkK+QISZ8uwDO0qmCjSjGJ37zcdfK8Sa8fo
   WzN5HBCzY6Q4QsBLLfkBgKbpLNdvDCd8QqwlFceYG35M7tf4aVD2fdkXa
   c3QaR0xYbEqq74KXDSBQTJ3ZrQIz0Ovfhk5xXL00Yqmi0b8J3Au8JjfaS
   DDQHGhzcdF8j59mc41Fi2tfyL+UqQ2DwYkNoQeqP6lFHmUWeIjlosaemM
   BzH3Y6NJYkZomvAShO/7ig67yWxyWeMUe/UtpTx0rzGHK6upzB1Jw4jJh
   Tw3TzNh+ND8upIPSDD8owBj5hy0eIq6KfgtafMFSUhSaQOoTX1BEIKPpD
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,206,1677567600"; 
   d="asc'?scan'208";a="210010487"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Apr 2023 23:32:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Apr 2023 23:32:06 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 17 Apr 2023 23:32:04 -0700
Date:   Tue, 18 Apr 2023 07:31:47 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Hal Feng <hal.feng@starfivetech.com>
CC:     Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <oe-kbuild-all@lists.linux.dev>, <linux-mm@kvack.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] clk: starfive: Fix RESET_STARFIVE_JH7110 can't be
 selected in a specified case
Message-ID: <20230418-caliber-clavicle-e8c1beb3fb75@wendy>
References: <20230417074115.30786-1-hal.feng@starfivetech.com>
 <20230417074115.30786-2-hal.feng@starfivetech.com>
 <20230417-buckwheat-wilt-92a4e85a5ca0@wendy>
 <83c5a35a-c646-cbc7-83f9-c02fcb24e069@starfivetech.com>
 <20230417-bolster-vitality-89d279146497@wendy>
 <0fe42faa3b34f82cc2fb73ae61460bf2.sboyd@kernel.org>
 <be049959-423e-6cd6-1f11-9bfa72665803@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Auc3gasTttW5e2PO"
Content-Disposition: inline
In-Reply-To: <be049959-423e-6cd6-1f11-9bfa72665803@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Auc3gasTttW5e2PO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2023 at 10:14:06AM +0800, Hal Feng wrote:
> On Mon, 17 Apr 2023 17:22:01 -0700, Stephen Boyd wrote:
> > Quoting Conor Dooley (2023-04-17 03:18:35)

> >> Aye, just the explicit dependency seems like it'd be less fragile and
> >> more obvious in the future.
> >=20
> > Agreed. Be explicit so we don't have to hunt down select dependencies.
>=20
> With further consideration, on the other hand, if we set `if ARCH_STARFIV=
E`
> here, it can point out that we need the reset driver to boot up JH7110
> besides the clock drivers, and the reset driver is not a necessary option
> for compilation test. So the reset driver is independent to the clock
> drivers when you doing a compilation test.

If ARCH_STARFIVE is enabled, both options (RESET_CONTROLLER &
RESET_STARFIVE_JH7110) will be selected & you don't need to worry about
people not realising this. Try it out & look at the option in
menuconfig.

> If we set `if RESET_CONTROLLER` here, the reset driver will be compiled
> automatically when (ARCH_STARFIVE [=3Dn] && COMPILE_TEST [=3Dy] &&=20
> RESET_CONTROLLER [=3Dy] && CLK_STARFIVE_JH7110_SYS [=3Dy]).

This is what we want, right? The more often it gets built by randconfig
etc the better, especially for archs that are not RISC-V.

Cheers,
Conor.

--Auc3gasTttW5e2PO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZD45UAAKCRB4tDGHoIJi
0gqZAP4zWJAbqDGJL6zo/fU0NWtQyqwb3ZmwLp+AV2ApCUFX4wEAqOy+AkXU9CQ1
b1QFGJkfN94a1mIqoBT5EPv8nfrnYwA=
=J1Iw
-----END PGP SIGNATURE-----

--Auc3gasTttW5e2PO--
