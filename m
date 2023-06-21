Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEE0737DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjFUIMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFUIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:12:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0412DE;
        Wed, 21 Jun 2023 01:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687335137; x=1718871137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DM/VZm23k+KBPD9Z2nm/p/7AvFdl8laDmWGgyYJzjtQ=;
  b=v8s7LsvTYflOpQOo6WLwodXmWQK/hEDj2cNFKpjheUzLy5Zp1KNFsVY4
   QPv+FTwzuhA3rI/8WrxbPUUmnB8itKC3bJkA7dcA0/FYn3BgW4sEr4VCx
   T8N7pwGfXnFsSuwnds/P0D7LFOZR3MOD8910skIkgSzj8OINpYK4NvE1Y
   Q3SVnuCAdNZ00YY7t2/1+ml6W5ptHzAJe/dirZhXU6zoGiKNSbCwhYFVI
   MjwB5BDTU9hhZ9w0ovP+Kp6wSWAyp230J4gOeq6fNldHvCpB6dTNQlChr
   +RbQDgLIxJS397SD4+gRcPMyfaDEb0ruuvDpMAinuA3R9+3AhfyUCbb4f
   A==;
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="asc'?scan'208";a="231308487"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jun 2023 01:12:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 21 Jun 2023 01:12:16 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 21 Jun 2023 01:12:14 -0700
Date:   Wed, 21 Jun 2023 09:11:47 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
CC:     Lucas Tanure <tanure@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yixun Lan <dlan@gentoo.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: meson-t7-a311d2-khadas-vim4: add
 initial device-tree
Message-ID: <20230621-sloppy-lisp-d6569b907c41@wendy>
References: <20230620134857.238941-1-tanure@linux.com>
 <20230620134857.238941-3-tanure@linux.com>
 <ZJIjtphyKdC48JrN@ofant>
 <76a7f819-f3d2-d39d-1bc9-f1e7f837fd22@linaro.org>
 <CAJX_Q+3im20qphOXzn-=58Kx4--ajbaF4P8BVvRcDcPXn1Qheg@mail.gmail.com>
 <20230621-barber-enjoyably-04806271daea@wendy>
 <6fe5dfb6-5f18-feca-a2e7-8cfb78627e01@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SUGtz7gnd9H8ZpfO"
Content-Disposition: inline
In-Reply-To: <6fe5dfb6-5f18-feca-a2e7-8cfb78627e01@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--SUGtz7gnd9H8ZpfO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 10:04:28AM +0200, Neil Armstrong wrote:
> On 21/06/2023 10:01, Conor Dooley wrote:

> > Aye, but we do not want to propagate that. New stuff should not be
> > adding undocumented compatibles, and those that are undocumented should
> > be documented.
>=20
> Documentation is ongoing, it takes time !

Don't worry, I wasn't trying to criticise, just pointing out the ideal
situation.

--SUGtz7gnd9H8ZpfO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJKwwwAKCRB4tDGHoIJi
0mZ7AP9gCvbPnfk6sA39u0KwkV3NaFictZl7I0Mlsst3rLNtEQEA0Q9A9IX6pcj0
HEsgPVBiC5EVDdVuA9PbNMdVCd/qGwk=
=Rcr8
-----END PGP SIGNATURE-----

--SUGtz7gnd9H8ZpfO--
