Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A0C6A5733
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjB1Kx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjB1Kxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:53:37 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931E7D51E;
        Tue, 28 Feb 2023 02:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677581520; x=1709117520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EmV1CDA32bCw5Yuxlf/FrxK14FNdKdtOjrbPPzU8wDE=;
  b=2onGzHsli+SpQt+1u+xA+QT+Mcdfo/nWBILSUETAu9D8+FTWLZ9wyraG
   X1CmIH+92uhS2HaGhXm9k/rb6tZfaM3UhF5PKY9jFU7RT97fDhdhDRTZZ
   HChcHDKufYP5+h9+4Br6PTwHQI5m+NeEmvotMuDGSoJKgf1QZDdyGKpQy
   2oTvL+rLPY2cJUwQWqv8dPZxH1stvqmfE44N9ktSlAd/V2LsMjxTJFD1+
   1cN15uEZuoLRSueePAtVHdg6qQAm7Fk9V1IQLLqXLTMPReklrhXYHGljg
   urKp0HC5SwVxuv5KogLoeFvo+rxbKaCc4jE0JQzH1q07Zf877ZhnzPNxF
   g==;
X-IronPort-AV: E=Sophos;i="5.98,221,1673938800"; 
   d="asc'?scan'208";a="202531380"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2023 03:51:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 03:51:42 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 28 Feb 2023 03:51:39 -0700
Date:   Tue, 28 Feb 2023 10:51:12 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v3 2/2] drivers: watchdog: Add StarFive Watchdog driver
Message-ID: <Y/3coFvMWOLaaY9p@wendy>
References: <20230220081926.267695-1-xingyu.wu@starfivetech.com>
 <20230220081926.267695-3-xingyu.wu@starfivetech.com>
 <CAJM55Z823iqUqD8enM0qJ_MA3Tw94Mn0mq71fbLT1Qjo2s2J3g@mail.gmail.com>
 <0ffb02d2-0bbd-fd0d-b0f6-cb5605570050@starfivetech.com>
 <CAJM55Z_hRpUYueZ-XuWUx1NfAsL9E+-4ry9TYeRWM_bKXvym-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UcWmcqa/y1djr3DO"
Content-Disposition: inline
In-Reply-To: <CAJM55Z_hRpUYueZ-XuWUx1NfAsL9E+-4ry9TYeRWM_bKXvym-g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--UcWmcqa/y1djr3DO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2023 at 11:36:49AM +0100, Emil Renner Berthing wrote:
> On Tue, 28 Feb 2023 at 10:44, Xingyu Wu <xingyu.wu@starfivetech.com> wrot=
e:
> > On 2023/2/26 22:14, Emil Renner Berthing wrote:
> > > On Mon, 20 Feb 2023 at 09:21, Xingyu Wu <xingyu.wu@starfivetech.com> =
wrote:

> > So the dt-bingdings need to rename, and which one could be better,
> > 'starfive,jh71x0-wdt.yaml' or 'starfive,jh-wdt.yaml'?
>=20
> Sure, starfive,jh71x0-wdt.yaml sounds good to me.

I feel like a common comment I see from the dt folks is to not put
wildcards in filenames & just pick the first compatible.
I could very well be wrong on that front though...

--UcWmcqa/y1djr3DO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/3coAAKCRB4tDGHoIJi
0mvBAP9uweiso5de1r1kZ9I8IGm1fB/JEam5Oz1DY1O5dqwAJwEAtMmWjEj8tDy+
yYIgRtECs4sOifuXiJ6LkiIXnV0JHQg=
=Issj
-----END PGP SIGNATURE-----

--UcWmcqa/y1djr3DO--
