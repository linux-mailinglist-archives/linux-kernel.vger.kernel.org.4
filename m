Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B414B70BD46
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjEVMQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbjEVMQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:16:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F995E7B;
        Mon, 22 May 2023 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684757695; x=1716293695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5A2lNb2BvA72ZMe6OLzVkg7olGY2nbHPxArNZlnKAVs=;
  b=CBwahVtvHB3FBG/Oogiuh754IiYyw8aVnr9XDJTyXphMyBJmES8iWh+b
   bW7gcucSzP47axUq12J7dp1Y4nwyEjihgQtZDj5ANe6X35cgovMqnr06X
   2ts6T7tt5EPAm1ifvEew7YrDocE4bEAtyxdRTF0/uhzjweQFNMNwNWHuk
   TikTnlj0JWvI6qKpt2Mmrawh697I5qdCvUEqEsqy+kuAjPeGtYemh/Jy+
   C9Qlzp6nl7+AI5UHrUEeBrFQ2zzWiExIj3OTY02CK69nmpm8Nn/HIpbKa
   SjmbbIMSLg5vTU9t6f7o/b5yRjMU9mO+i1UJipEKd4VAAWIU7ihyf9wBS
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="asc'?scan'208";a="214311809"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 05:14:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 05:14:39 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 05:14:38 -0700
Date:   Mon, 22 May 2023 13:14:16 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Artur Weber <aweber.kernel@gmail.com>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH 1/2] dt-bindings: mms114: Add linux,keycodes property for
 touch keys
Message-ID: <20230522-confining-scavenger-d1ba92046229@wendy>
References: <20230521145843.19489-1-aweber.kernel@gmail.com>
 <20230521145843.19489-2-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HvH9YPXJkuXA7uI"
Content-Disposition: inline
In-Reply-To: <20230521145843.19489-2-aweber.kernel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--+HvH9YPXJkuXA7uI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 21, 2023 at 04:58:42PM +0200, Artur Weber wrote:
> MELFAS MMS114 and similar touchscreens have support for touch keys.
> Add the linux,keycodes property which can be used to set up the
> keycodes for the touch keys.
>=20
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/input/touchscreen/melfas,mms114.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/melfas,m=
ms114.yaml b/Documentation/devicetree/bindings/input/touchscreen/melfas,mms=
114.yaml
> index fdd02898e249..07f9dd6b1c9c 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/melfas,mms114.y=
aml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/melfas,mms114.y=
aml
> @@ -52,6 +52,11 @@ properties:
>    touchscreen-swapped-x-y: true
>    touchscreen-max-pressure: true
> =20
> +  linux,keycodes:
> +    description: Keycodes for the touch keys
> +    minItems: 1
> +    maxItems: 15
> +
>  additionalProperties: false
> =20
>  required:
> --=20
> 2.40.1
>=20

--+HvH9YPXJkuXA7uI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGtcmAAKCRB4tDGHoIJi
0kYcAQD8TxGMHz/EZH+IDdlroL17EuLyZ5B0Zd1p18gdDPHAMgD/XjOvFTaH65jw
v//OeNsEoZ+/s/6CGw+N8qbW2tXtfQA=
=ZQg+
-----END PGP SIGNATURE-----

--+HvH9YPXJkuXA7uI--
