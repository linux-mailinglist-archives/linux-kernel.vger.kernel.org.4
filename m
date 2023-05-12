Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D2B7000C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 08:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbjELGop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 02:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239826AbjELGok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 02:44:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6A8E73A;
        Thu, 11 May 2023 23:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683873842; x=1715409842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e7vrZzjTAHYlhbziScGZpOcO6sx7L2qpbdYMGhzF+tY=;
  b=SbH6v98IFRl+WRKzgD+26RijOO/qW8v/sIM8fSTeZiYnF7UleWUXaCI9
   v1TA+jbqkOw57ROED55fUlceLCs+9MfTHmzQgvCHQ8xeII0pq2DRblAvv
   aeVLlsRRXHr7MpdmYwGixZZxPqEsR1rqtyCSYMGozn/1VUFp+5gkY/8AZ
   EKxDpWBhPAYC0sUYRyITMe0So7XiiiydFHf5JjeubKPX3jBM4xWb+EqNA
   HpfIkpZCxLj7tjHgAy8PICqJwYhapslnZZCkng0FFVLlgwO56E0fAZPi7
   Fu3uwC65Akm76iqk/HUIELMTPNtz6AHNAHWDfzCu9+lbvhxLZdLn7Zpfg
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677567600"; 
   d="asc'?scan'208";a="210904823"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 May 2023 23:43:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 11 May 2023 23:43:58 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 11 May 2023 23:43:55 -0700
Date:   Fri, 12 May 2023 07:43:35 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] dt-bindings: soc: starfive: Add StarFive syscon
 module
Message-ID: <20230512-brewery-spouse-86350c9664d8@wendy>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
 <20230512022036.97987-6-xingyu.wu@starfivetech.com>
 <2fb8c88a-dab5-791b-eefe-c983decad5e8@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5hr07LkZOQg1PDAv"
Content-Disposition: inline
In-Reply-To: <2fb8c88a-dab5-791b-eefe-c983decad5e8@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--5hr07LkZOQg1PDAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2023 at 08:35:43AM +0200, Krzysztof Kozlowski wrote:
> On 12/05/2023 04:20, Xingyu Wu wrote:
> > From: William Qiu <william.qiu@starfivetech.com>

> > +  "#power-domain-cells":
> > +    const: 1
>=20
> Add it to the existing examples.
>=20
> This part confuses me... why aon appeared here?  Why power-controller
> disappeared? I don't think that Rob or me proposed any of this.

Rob did actually suggest this, as the power-controller child node had no
properties other than #power-domain-cells.

--5hr07LkZOQg1PDAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF3gDQAKCRB4tDGHoIJi
0uuIAQCH6VV+uDnZjuZ3RNd9XXAUySuX/C89byQ08aS6KRCLLAEAxr99pkJRygwB
r3nW46PrmXXBLmPQpoyoWa59BWkCyAg=
=Mzk6
-----END PGP SIGNATURE-----

--5hr07LkZOQg1PDAv--
