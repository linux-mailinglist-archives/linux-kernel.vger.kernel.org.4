Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F93F70BF4F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjEVNLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbjEVNLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:11:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E81C4;
        Mon, 22 May 2023 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684761099; x=1716297099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xpyLIb2+OMD3ly4N+A5YZqQ6cY7XOV1lf25zcvDcWtE=;
  b=Uf0mY18Ip7drzCzW44E44SYDFYH8AmObU0GzPYEKg4Ud3cWBhCMKVhYH
   8Ag/AeUmOtVjOe19KOf1c5Go+ZDPghaSmj2b6KnRZPuo6tREIQDAcCqHV
   9ijGwhOfwsZsy/eLhhv87+rsZyrAA3RWfshhoO/aJK6k1NT/HplqmQkfh
   I4tFO+2RuoIT0r+VfRu/9vWonCxIzFvNS7GLi+E09c874J+iDFyID6P8q
   wCK419LwqNbYB6hvxpkTx8nrUqkQ3OWLNwpnyeT+BfaJ9+9P4/5/jxJms
   8N4n4Tm4R3DW74pTI3OtkYGiZ5Neogm8utikuux0y4eZBM6dZf4sZJMG1
   A==;
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="asc'?scan'208";a="153308173"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 06:11:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 06:11:36 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 06:11:34 -0700
Date:   Mon, 22 May 2023 14:11:12 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 0/3] Add JH7110 MIPI DPHY RX support
Message-ID: <20230522-extradite-nastily-c2a88cfd2f02@wendy>
References: <20230412084540.295411-1-changhuang.liang@starfivetech.com>
 <93d39956-25c9-971b-e73b-09c69e803341@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ueSz+7+usqbjXZtt"
Content-Disposition: inline
In-Reply-To: <93d39956-25c9-971b-e73b-09c69e803341@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ueSz+7+usqbjXZtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 09:00:04PM +0800, Changhuang Liang wrote:
> On 2023/4/12 16:45, Changhuang Liang wrote:
> > This patchset adds mipi dphy rx driver for the StarFive JH7110 SoC.
> > It is used to transfer CSI camera data. The series has been tested on
> > the VisionFive 2 board.
> >=20

> Can you help to find the Vinod reviewed this patchset?

I am sorry, but I have no idea what you mean.
Are you asking if I can get Vinod to review the series?

Cheers,
Conor.

--ueSz+7+usqbjXZtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGtp8AAKCRB4tDGHoIJi
0oseAQC5Ema0k8zP3rAXvlOOucLhHBUucJkcO7G84GGXZOyIgwD/Z9jdZdiFz5Yf
XgHWF5jAmdOU/G75KFDw9g6CW4IHZQo=
=1M3+
-----END PGP SIGNATURE-----

--ueSz+7+usqbjXZtt--
