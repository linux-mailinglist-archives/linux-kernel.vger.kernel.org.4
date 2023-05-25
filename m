Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E7A7105AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 08:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbjEYG1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 02:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbjEYG1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 02:27:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A255187;
        Wed, 24 May 2023 23:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684996017; x=1716532017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rV7X8sJTUMiQ+nwFrbSH9S0xiOFtSvj7VBi8hCz7dKA=;
  b=n4BF8SR3xqpCxN7LN5PqkDMsoLLd5wFPmoKqFG4vRG/GXhlJKJSYIQru
   SUEmNBVyJUfvfdkyvNsvBT4VQru/mfjKeAVgxlpmAsMY4Euc44mCqbA39
   uOAgbkdGtQoySCNxUA0Xm79FEnwC90gx/VxTPuNHspO0g9qCMJL76zg0r
   0lH5IG9bCC+yWfRpJgKu1Rg1rn9hlZSYoEc6awzA+QcOcqNZOmtOkp5Ve
   /b1bll1eAotvLPGVTetfnxuqoimMm9XkcW/qYo5lpkgdqpwXbj+E0W4PQ
   WLGZMxU5p7kc+UQEpH9zAza6rlp0JxMoheIItslX0Ig/NS8vNNVFOM2Kx
   g==;
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="asc'?scan'208";a="217194852"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2023 23:26:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 24 May 2023 23:26:56 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 24 May 2023 23:26:53 -0700
Date:   Thu, 25 May 2023 07:26:31 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
CC:     <dianders@chromium.org>, <airlied@gmail.com>,
        <conor+dt@kernel.org>, <daniel@ffwll.ch>,
        <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <hsinyi@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <neil.armstrong@linaro.org>,
        <robh+dt@kernel.org>, <sam@ravnborg.org>
Subject: Re: [v3 2/4] drm/panel: Support for Starry-himax83102-j02 TDDI
 MIPI-DSI panel
Message-ID: <20230525-relearn-rug-0a75ea9674f9@wendy>
References: <CAD=FV=XUuzjjLq3YP3683jOd06odwk5Dox5MS8oY8goB-_8T5w@mail.gmail.com>
 <20230525025000.3692510-1-yangcong5@huaqin.corp-partner.google.com>
 <20230525025000.3692510-3-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CkngReavlAbqfK2R"
Content-Disposition: inline
In-Reply-To: <20230525025000.3692510-3-yangcong5@huaqin.corp-partner.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--CkngReavlAbqfK2R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 10:49:58AM +0800, Cong Yang wrote:
> The Starry-himax83102-j02 is a 10.51" WUXGA TFT panel. which fits in nice=
ly
> with the existing panel-boe-tv101wum-nl6 driver. From the datasheet[1], M=
IPI
> needs to keep the LP11 state before the lcm_reset pin is pulled high, so
> increase lp11_before_reset flag.
>=20
> [1]: https://github.com/HimaxSoftware/Doc/tree/main/Himax_Chipset_Power_S=
equence
>=20
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

I didn't Ack this (or 4/4). If the patches are otherwise acceptable,
perhaps the committer could remove my A-b from the non dt-binding
patches.

Thanks,
Conor.

--CkngReavlAbqfK2R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG7/lwAKCRB4tDGHoIJi
0uSCAP9Z8K30BSavxbACku/asQVqLBzDha1SIla3Ye4HGvrPMAEAzU40VFU1stOu
a8BR8h+xFvzt7BYgZfdbhs8oI7iw5wo=
=odpO
-----END PGP SIGNATURE-----

--CkngReavlAbqfK2R--
