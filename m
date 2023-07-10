Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4574A74D00D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGJIgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGJIgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:36:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3839D;
        Mon, 10 Jul 2023 01:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688978165; x=1720514165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uoPd1bTj0XgN06/WtHRBEmJCtqN/Yd7PIGGsXb1/sJo=;
  b=irRfEzw+kxfSU5+YTzFqVSdbL6scHaFsttYVBlv7Mxiz9mvnS17yipMz
   uF21KRPN0xyUBRqvc3FVB+jp0Eqza8nWLuLNbeSBHJ4BFVCVLVBSQ2TgB
   JAoIT8imghgMJtHBoFAdMjg9nLI7WB/ekBVm4Dkvp+oiV11pmPGQKqmL4
   8IKBX+c4x213WKLCvf0fdCnNnEZ7sZlFYvVdO6tuP2PKrz6V9sBmuTT3v
   0R3o59fJk1sodBTVe7nvwqAF/ZRVNvtzHCYh4fxriT6L49tSuYqAsrT6v
   k0B886b53TUHw1bghgF+5njjoWeL0G2XKGVhoEaCrebmRVZhQNMQRBBe/
   w==;
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="asc'?scan'208";a="222859747"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jul 2023 01:36:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 10 Jul 2023 01:36:00 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 10 Jul 2023 01:35:58 -0700
Date:   Mon, 10 Jul 2023 09:35:27 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] ARM: dts: microchip: minor whitespace cleanup around
 '='
Message-ID: <20230710-exonerate-peculiar-933eb91bb94d@wendy>
References: <20230702185108.43959-1-krzysztof.kozlowski@linaro.org>
 <20230702185108.43959-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qL8ugyeNaAMQNs04"
Content-Disposition: inline
In-Reply-To: <20230702185108.43959-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--qL8ugyeNaAMQNs04
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 02, 2023 at 08:51:08PM +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before and after '=3D'
> sign.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I was speaking to Claudiu on Friday & he didn't see this in his queue,
so I have applied both patches.

--qL8ugyeNaAMQNs04
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKvCzwAKCRB4tDGHoIJi
0lDCAP9jo+nDIlNrtqFpJyirF1DORt3PK6h0R7LuwaeVJZHGIAD+LL/V941aGDHu
LRNNzTHZcMPC+KE3at3HUrGbak0eSA8=
=wwNe
-----END PGP SIGNATURE-----

--qL8ugyeNaAMQNs04--
