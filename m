Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A872A710D11
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbjEYNQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEYNQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:16:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825D699;
        Thu, 25 May 2023 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685020587; x=1716556587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bji74CU8lVc3dQnwGVK8uYW1fWx2VIw8L4AKclmka2I=;
  b=d9MjSRa1YqEiBchkjRbMyiG0dILBbf9QUrgrIeScCzNOXuANKHhTB7sO
   0+kS3NNfNLi9Ot14YnhzioNppItJE/X3aGAU598h18b9SkI7d0BkqC4qf
   hN8yK9pfPrDX/C4AjdbR0jfAowev/pyz76gcqwCH0o7kMB3R7puiBL+Mh
   Q/sylqQ1LsEOXebxOJkrcuZA9+v5ReozPfA0CArp9Ss5TzLlyxBDVODtK
   EbnXizVF6YJGEt0S6DBG540jdu+hYSN6G2dyX8l59FitWSxwoA0Vo1Dea
   DMGYpOJX0HtQImmxNqrVuKguo3/3RsXse4dRqd7UyIgkOUo4wyEOq7UsX
   A==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="asc'?scan'208";a="214869960"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2023 06:16:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 06:16:27 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 25 May 2023 06:16:24 -0700
Date:   Thu, 25 May 2023 14:16:02 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor@kernel.org>, <jian.hu@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v16 5/6] dt-bindings: clock: meson: add A1 Peripherals
 clock controller bindings
Message-ID: <20230525-connected-skipper-442c6d0b52c1@wendy>
References: <20230523135351.19133-1-ddrokosov@sberdevices.ru>
 <20230523135351.19133-6-ddrokosov@sberdevices.ru>
 <20230525093736.naztwqlhvskujsoa@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="68QoUxHiy/kLBBjz"
Content-Disposition: inline
In-Reply-To: <20230525093736.naztwqlhvskujsoa@CAB-WSD-L081021>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--68QoUxHiy/kLBBjz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 12:37:36PM +0300, Dmitry Rokosov wrote:
> Hello Rob, Krzysztof and Conor,
>=20
> Could you please take a look at this patch version? Before Rob marked
> this patchset with RvB at v13 -
> https://lore.kernel.org/linux-amlogic/168130720431.2218249.76710619649880=
64525.robh@kernel.org/
>=20
> However, due to several comments from other maintainers, unfortunately,
> I had to rename the 'a1-clkc' controller to 'a1-peripherals-clkc' and
> remove Rob's RvB.

I dunno if the compatible change is worth dropping the tag for tbh.
That seems to be the only change, so I guess you can have my R-b instead
of Rob's...
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--68QoUxHiy/kLBBjz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG9fkgAKCRB4tDGHoIJi
0pRoAQDxk5nwMh6wGwdzyLznrxJI2Wbak7jHxQtaSq4C+2Zr7AEAt+xK055gIGNQ
a6u9fKyHj5+k8LB9XmdcuS5cl3HwpwI=
=HgEl
-----END PGP SIGNATURE-----

--68QoUxHiy/kLBBjz--
