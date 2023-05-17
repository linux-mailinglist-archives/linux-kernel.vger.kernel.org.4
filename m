Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46F3706873
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjEQMn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjEQMnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:43:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3806B26A3;
        Wed, 17 May 2023 05:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684327382; x=1715863382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0wb+aIX7/letJ9Gm0YD6AnxqCsFTli+EhhB+a+U+28w=;
  b=SslVsAW6FXxd6f+ZaTufH/c+hLAJ9l11/xgsByN612z5cC8s5s6XMelE
   0sy30NWoZAs9c+YJoGC33M9VbTinrNftGu8unetDRJLA2yLXyTDBbhS6O
   D0O6iL36mNXP+YPW/VvinXJz+VKs5FGlPNIKI+q2zEE8O74jiBwYeqFnk
   7bgSlHookIZdbvFS/nnx4OASyoHhttO0VQnEMGJeccBtb0R4v5ijX23Yx
   OTunpIyBfX5kgbcw73X0NDVe21psEPu8Ve8d6fdEjgF0h8ZxqQsuCwdt9
   dFSuJh+/0pnt+XTVbjoFl/a+SLPQh8LISZmin/b7B4763T+jmKjtyheeR
   g==;
X-IronPort-AV: E=Sophos;i="5.99,282,1677567600"; 
   d="asc'?scan'208";a="152529056"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 05:42:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 05:42:51 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 17 May 2023 05:42:49 -0700
Date:   Wed, 17 May 2023 13:42:28 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc:
 convert to yaml
Message-ID: <20230517-degrading-stoppage-54f7769f1956@wendy>
References: <20230517094119.2894220-1-claudiu.beznea@microchip.com>
 <20230517094119.2894220-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ssdu9SzKEXVS/OPM"
Content-Disposition: inline
In-Reply-To: <20230517094119.2894220-3-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ssdu9SzKEXVS/OPM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 12:41:16PM +0300, Claudiu Beznea wrote:
> Convert Atmel PMC documentation to yaml. Along with it clock names
> were adapted according to the current available device trees as
> different controller versions accept different clock (some of them
> have 3 clocks as input, some has 2 clocks as inputs and some with 2
> input clocks uses different clock names).
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Looks good to me now Claudiu, thanks!

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--ssdu9SzKEXVS/OPM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGTLtAAKCRB4tDGHoIJi
0liRAQDsZjU9B15a9rnhIN17ei53YY8w3HzELiqszr4hvKfR1wEAjsnlJtzq5Z1w
U3kVEcygfCm3gQJxqEJTxAHcJtr6IgI=
=bdpZ
-----END PGP SIGNATURE-----

--ssdu9SzKEXVS/OPM--
