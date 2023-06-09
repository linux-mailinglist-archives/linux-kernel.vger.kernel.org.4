Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E86729CA9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240941AbjFIOVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjFIOVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:21:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD22D30F3;
        Fri,  9 Jun 2023 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686320504; x=1717856504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2a+lt3aPP+ngTS29/z29BKrwVI4Tp9UL/tf+aJWyQX8=;
  b=QZjXBoFw8hL//vlPO5B7xLCesEhW2l5/dbdvgqjAlcDOWr4NQ7/6iKi3
   upIvnb158yfImg0SPWjoWbS7iSZ4H2KapnPp9mpz76eoJuzaX6uToQ/UA
   BF4dGXcKq7qLh3JI6p1RyvlKFVZFBpiJHQftSGkLGkfInx1m2PHHzF2QF
   s1KJYBiEsGYvoJLCj8LjE7uWKsv/r8zmcmTg5sPeuNJZX0fVKs9ttW0GJ
   MgTY7HaydKasbJNZZ+Wi2dZyfbekJesV9teMSj5cSpPq7TBw7Tz3I1AVJ
   1AnpVEbha+S4JJyU8cgeZ8iRXDdIMR23dfRNy4URzAzWKLl4wYftiZX+m
   w==;
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="asc'?scan'208";a="156290937"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2023 07:21:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 9 Jun 2023 07:21:43 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 9 Jun 2023 07:21:42 -0700
Date:   Fri, 9 Jun 2023 15:21:17 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: riscv: cpus: drop unneeded quotes
Message-ID: <20230609-discourse-lapped-5217cc4d7ede@wendy>
References: <20230609140706.64623-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bGQeEsxycwJfD2sU"
Content-Disposition: inline
In-Reply-To: <20230609140706.64623-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--bGQeEsxycwJfD2sU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2023 at 04:07:06PM +0200, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--bGQeEsxycwJfD2sU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIM1XQAKCRB4tDGHoIJi
0nBVAP0T8hWbMHaBw02aqSDgr7Tl2Q8lR8gW+HR1CNAnRw7BsAEA4TuanTVt5EJl
qcen++SX5zQGb7LCunLo88GpZK932AI=
=VSOJ
-----END PGP SIGNATURE-----

--bGQeEsxycwJfD2sU--
