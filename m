Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FAF7025FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbjEOHWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbjEOHWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:22:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62951AB;
        Mon, 15 May 2023 00:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684135367; x=1715671367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v8Xgi03YncOZGRJJderrrJ4xjST8h4en5g7rhUUCfnw=;
  b=1UOMSn79GlnCKV2d8BNOAG1eg6d3c9zhM59/py9K1hQc7iCxsX9ckNCN
   gTEqTiDdXbJPoC2yoUC41DSETsOx/uXiCvGwBR2TYOAxX8OdTd/9/usjC
   4+GX4/C8HvE2/zy+rzl54fN56LV3vkkaK1ifQWz3sxgJK7GvVVKv7oZZE
   iOFKeazwpbbop7WMaTzlYRiSIETWGck9hXLlBmRVJIqn6Xoec+RVgGkD7
   pyXjf1IW/qdajMSAO+BytMBLFS1cnWiu0VFaCPS6TnBcvVME/tKxtpEkt
   4ZmYUUqyRPkhQv9afEnARz5XWqGmwHQg5HVUCKS/mZcwWWkEOkyT1UQx1
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,275,1677567600"; 
   d="asc'?scan'208";a="215381233"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2023 00:22:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 15 May 2023 00:22:45 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 15 May 2023 00:22:43 -0700
Date:   Mon, 15 May 2023 08:22:22 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Walker Chen <walker.chen@starfivetech.com>
CC:     Conor Dooley <conor@kernel.org>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] riscv: dts: starfive: jh7110: Add watchdog node
Message-ID: <20230515-quarrel-vocalize-930a189e719b@wendy>
References: <20230509151723.84989-1-xingyu.wu@starfivetech.com>
 <20230509151723.84989-3-xingyu.wu@starfivetech.com>
 <20230512-barrack-catchable-1f4072b9355b@spud>
 <ec5693b7-1ace-2215-1115-971d8086a171@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ujRRX7HonzNFd21D"
Content-Disposition: inline
In-Reply-To: <ec5693b7-1ace-2215-1115-971d8086a171@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ujRRX7HonzNFd21D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 09:47:44AM +0800, Walker Chen wrote:
>=20
>=20
> On 2023/5/13 6:27, Conor Dooley wrote:
> > On Tue, May 09, 2023 at 11:17:23PM +0800, Xingyu Wu wrote:
> >> Add the watchdog node for the Starfive JH7110 SoC.
> >=20
> > Emil or Walker, could I get a review on this please?
> > It's the only dts patch on the list right now for the jh7110 that I can
> > actually apply, so it'd be nice to do so.
>=20
> Of course, thank you for helping to review and apply.

I was hoping that you would reply with a "Reviewed-by", your thanks is
nice to but I can't do anything with that!

Cheers,
Conor.

--ujRRX7HonzNFd21D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGHdogAKCRB4tDGHoIJi
0k4CAQD4BEwpPDxRdIPtEhcDK2WdnRhIn6XAPAXknR/EmUxJxQEAgDqhW5gWb+Qr
YvI20G0S7y44BvGbGHd8JA9I4IontgY=
=1VMT
-----END PGP SIGNATURE-----

--ujRRX7HonzNFd21D--
