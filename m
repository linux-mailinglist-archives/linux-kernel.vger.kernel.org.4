Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E7066DFC2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjAQN7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjAQN6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:58:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74079448C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673963909; x=1705499909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jw4AntDJemNhljb1WSfot7V9dm7JFvqtbWvMl/JmLC4=;
  b=An8vFCVGysV/Tg4URjx9GkLa7UQBIev7r1nA+lWWddws2koYcaiHudhL
   SxKw/GLmv4qdLPQrrWieqD2DLJvkmiTMZ84TR4l6QKXeR9WdV0fH41Tz4
   BaG5LiVAGdpqssqxnxA/iuDv+STCW8nI+3i7ylaWsG/uiq6rUJH9CZpze
   f55QUhkVC9s6UE+rBZYDrEASG89iVIp5T+qkVu0+cC13okdUP700zjqk9
   5Rx2jg9ZuiazqacPevnqWzy1QXfNd+fKzR7YjiaZS+BFsOunt3TIPR9kl
   UXrYX3oAac2QGoR76taf+lZ9gcSgPAD2MHJYfjPs7tiduXU+QabdU4KQv
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,224,1669100400"; 
   d="asc'?scan'208";a="132725744"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jan 2023 06:58:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 06:58:12 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 17 Jan 2023 06:58:10 -0700
Date:   Tue, 17 Jan 2023 13:57:48 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Nylon Chen <nylon.chen@sifive.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <nylon7717@gmail.com>, <zong.li@sifive.com>,
        <greentime.hu@sifive.com>, <vincent.chen@sifive.com>
Subject: Re: [PATCH 1/2] riscv: dts: sifive unmatched: Remove PWM controlled
 LED's active-low properties
Message-ID: <Y8apXMzlDYhuLOqV@wendy>
References: <20230113083115.2590-1-nylon.chen@sifive.com>
 <20230113083115.2590-2-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sCY470tgzGEL1xs2"
Content-Disposition: inline
In-Reply-To: <20230113083115.2590-2-nylon.chen@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--sCY470tgzGEL1xs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Nylon,

On Fri, Jan 13, 2023 at 04:31:14PM +0800, Nylon Chen wrote:
> This removes the active-low properties of the PWM-controlled LEDs in
> the HiFive Unmatched device tree.

Does unleashed also have the same issue?
It has the same compatible at the very least.

Thanks,
Conor.

>=20
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> Reviewed-by: Vincent Chen <vincent.chen@sifive.com>
> ---
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/r=
iscv/boot/dts/sifive/hifive-unmatched-a00.dts
> index 07387f9c135c..11f08a545ee6 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> @@ -52,7 +52,6 @@ led-controller-1 {
> =20
>  		led-d12 {
>  			pwms =3D <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> -			active-low;
>  			color =3D <LED_COLOR_ID_GREEN>;
>  			max-brightness =3D <255>;
>  			label =3D "d12";
> @@ -69,19 +68,16 @@ multi-led {
> =20
>  			led-red {
>  				pwms =3D <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
> -				active-low;
>  				color =3D <LED_COLOR_ID_RED>;
>  			};
> =20
>  			led-green {
>  				pwms =3D <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
> -				active-low;
>  				color =3D <LED_COLOR_ID_GREEN>;
>  			};
> =20
>  			led-blue {
>  				pwms =3D <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
> -				active-low;
>  				color =3D <LED_COLOR_ID_BLUE>;
>  			};
>  		};
> --=20
> 2.36.1
>=20

--sCY470tgzGEL1xs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8apWwAKCRB4tDGHoIJi
0oUZAP0e0gBBGBiwm+MQJEOj24ncWAh9IauZg6zX7i9eBH9TjQD/Tt9PH6/uULNn
WSahkdpB8z8jOujvbc02ciHmsSMLqQU=
=b3Gd
-----END PGP SIGNATURE-----

--sCY470tgzGEL1xs2--
