Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3983B69914A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjBPKcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBPKb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:31:56 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E4447424;
        Thu, 16 Feb 2023 02:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676543515; x=1708079515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f+F4YCG9W6ZBi29/AlTYKJjNmWLtJall6Uk8FokYR40=;
  b=k8OWUEW+SBCXwPFq6noBi8lXvKLbMTxe0yidbXuvDqABqdTZNVgqTNth
   hzlyi6ZQThCZXuiAXhLy0CW7D8uVW0z5J+OQtm/2IVsr42T5d/jFE9a50
   IXSiWUsw9dd7AZCZVcPH07DMSMetHfkE4mElnkRA2dTYo8vZ/82FbgwdN
   o3N2+WwmWTav0pHdpe2uJ9HF3aCqRp0nwONPM0snIbi+8al82DWR0Rq4t
   BAXjYiAps9YwR4oaPzU11iLwsTwVkeD0iQhvRyVq6alYVGt1SBxeSMXPM
   3wCk74SlpsjRL2dfcy6b1h9bne54gOBlb87XlPKSxP5p3abM5VXAcSPib
   A==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669100400"; 
   d="asc'?scan'208";a="200876227"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Feb 2023 03:31:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 03:31:52 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 16 Feb 2023 03:31:51 -0700
Date:   Thu, 16 Feb 2023 10:31:25 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Shengyu Qu <wiagn233@outlook.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: mmc: Add StarFive MMC module
Message-ID: <Y+4F/V0ZJtWJ3290@wendy>
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-2-william.qiu@starfivetech.com>
 <TY3P286MB26111053410F3F96C9C71D2798A39@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <4bb1e640-475c-8516-2f73-ddfa0a3c23e0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zXMgQ4X1gAZdpo5M"
Content-Disposition: inline
In-Reply-To: <4bb1e640-475c-8516-2f73-ddfa0a3c23e0@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--zXMgQ4X1gAZdpo5M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 11:21:16AM +0100, Krzysztof Kozlowski wrote:
> On 15/02/2023 12:59, Shengyu Qu wrote:
> > Hello William,
> >=20
> > Are you sure changing driver is better than changing yaml bindings? All
>=20
> What do you mean - changing driver? This is new driver, new code, isn't i=
t?

Changing w.r.t. the v3 that was applied I suppose.
The v3 was dropped and patches 1 & 2 here have been applied instead, so
this request from Shengyu is moot now anyway.

Cheers,
Conor.


--zXMgQ4X1gAZdpo5M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+4F/QAKCRB4tDGHoIJi
0uRaAQDrNl3wDMBd/lA1oIl2jPYUipctYyMEyoz6RKoz0DM5+wEApPVbBskxiCoB
x+5tv90k9SFpSXj6T1oh0AvETWgOaQw=
=tuQM
-----END PGP SIGNATURE-----

--zXMgQ4X1gAZdpo5M--
