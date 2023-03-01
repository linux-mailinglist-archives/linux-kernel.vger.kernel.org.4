Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50776A6897
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCAIKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjCAIKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:10:44 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AC23346F;
        Wed,  1 Mar 2023 00:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677658241; x=1709194241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4gJnoh1IaxxhjrT0UMbcLgad9K8iLaEC50MeRbK/Uj4=;
  b=KKhV3a+DBwjZbZR2MlbRurBMKq4/9+C8v4zwAmWrjdP5aGTl7Zcu+uDP
   Q1lWMYimZUAUsL2bMesntQyjGD6uxu2eTtK3ZMcm8cnRPdSei+lXSZ5S8
   GNKKcJQwOJ4spTOdYTiEYjr5y5O72UEhFiY+Ouy4gNWbfV5JFJQ/XnQuZ
   CpPxyaEe0C82+79rrJhcK72RfSVFQkQT3X2GpjQAZYsvsI9Ucnm0vHSO9
   AJW+WBsE57dkZ53WSRTXWWZuN+2yg0S8r8suG2zdBpSJO/hcuvUZCJ+o9
   0Da4XE8e0CtGxj5gSl9o62DDGKqbHS5ZtgIT7kenlddNe9oCBe24xV8qg
   w==;
X-IronPort-AV: E=Sophos;i="5.98,224,1673938800"; 
   d="asc'?scan'208";a="214173792"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2023 01:10:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Mar 2023 01:10:38 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Wed, 1 Mar 2023 01:10:37 -0700
Date:   Wed, 1 Mar 2023 08:10:09 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     William Qiu <william.qiu@starfivetech.com>
CC:     <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v1 0/2] StarFive's Pulse Width Modulation driver support
Message-ID: <Y/8IYSYOsDrGIXzT@wendy>
References: <20230228091345.70515-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1JJOGzyp5EWYwTYF"
Content-Disposition: inline
In-Reply-To: <20230228091345.70515-1-william.qiu@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--1JJOGzyp5EWYwTYF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey William,

On Tue, Feb 28, 2023 at 05:13:43PM +0800, William Qiu wrote:
> Hi,
>=20
> This patchset adds initial rudimentary support for the StarFive
> Pulse Width Modulation controller driver. And this driver will
> be used in StarFive's VisionFive 2 board.The first patch add
> Documentations for the device and Patch 2 adds device probe for
> the module.
>=20
> The patch series is based on v6.2.
>=20
> William Qiu (2):
>   dt-bindings: PWM: Add StarFive PWM module
>   pwm: starfive: Add PWM driver support

Is there a corresponding dts addition for this driver?

Cheers,
Conor.


--1JJOGzyp5EWYwTYF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/8IXgAKCRB4tDGHoIJi
0rFbAP9YFYNSLuqyDOAKlOFVOJMsnQqP04Og51BVRz+z4hrJRwD4i75kkecf2fnA
p6+RJ9RUMStLDGg1PRabr0JKNQdFDA==
=ODZv
-----END PGP SIGNATURE-----

--1JJOGzyp5EWYwTYF--
