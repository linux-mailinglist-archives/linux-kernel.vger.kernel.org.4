Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2A8735F69
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 23:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjFSVyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 17:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjFSVyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 17:54:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BB3E76;
        Mon, 19 Jun 2023 14:54:14 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4DB116606F13;
        Mon, 19 Jun 2023 22:54:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687211653;
        bh=iX1WsP52rvu8TUG/hr+rCxY7LacBt13DuItmHpip29E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TrkY2SKYM46DhmM8O7nYasLX5BjBSNtXCZhZCVbhkBLP5geLMHMVacQakqp6ZCFRa
         LDHECS6Y7wucE2IxLIItibj8crNn5HZHXM1hcNHb9Iue0nddIAiU0D2ct7ykBTuxvL
         NoshC0Gh2Y/PLq9sFIY2Vf+/FtSXfiwYl47AL0CE4hc+JuJ6oO+8CbUoi104WRSMAg
         N1zl2+X2kXxm6M0cKYPlwcLXBu1Gd2Y4Y/xj+YKR2KbLyUoRTdlmGtV+UVxrzl0/if
         zyDjK815DlqZFlrxdhsz8+OWxn9opajoT8NGncd1ed4RmoMLr+PVeG5vGxlo7RjKPe
         C4/8RYi3r0NNA==
Received: by mercury (Postfix, from userid 1000)
        id DD5331060A6A; Mon, 19 Jun 2023 23:54:10 +0200 (CEST)
Date:   Mon, 19 Jun 2023 23:54:10 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/4] MAINTAINERS: add documentation file for Microchip
 SAMA5D2 shutdown controller
Message-ID: <20230619215410.cw52rjbjenjifvcx@mercury.elektranox.org>
References: <20230616101646.879480-1-claudiu.beznea@microchip.com>
 <20230616101646.879480-5-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5gzjbh54lkf3rfdd"
Content-Disposition: inline
In-Reply-To: <20230616101646.879480-5-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5gzjbh54lkf3rfdd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 16, 2023 at 01:16:46PM +0300, Claudiu Beznea wrote:
> Add documentation file for SAMA5D2 shutdown controller.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---

Thanks, queued.

-- Sebastian

>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 74a6b6b13d84..cdf4b41cf62b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13811,6 +13811,7 @@ F:	include/dt-bindings/iio/adc/at91-sama5d2_adc.h
>  MICROCHIP SAMA5D2-COMPATIBLE SHUTDOWN CONTROLLER
>  M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>  S:	Supported
> +F:	Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
>  F:	drivers/power/reset/at91-sama5d2_shdwc.c
> =20
>  MICROCHIP SPI DRIVER
> --=20
> 2.34.1
>=20

--5gzjbh54lkf3rfdd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSQzoIACgkQ2O7X88g7
+prvsQ//ZolFWiSJZtyR3LPZn7Mmq9cwerjY1feOPQoyiV9Sm9MSr1cx9lWDRzAK
7fLCt9ZibihWYzFnpGgBmPsjVMSwmQSC8mYmqt1kyinDBYI5W/isjXyGKFdRowhz
cdHejnBqPOwskKjjcQeNfxkgOfsoRmmVTYw5iFjVvsn68Se/1Wnwfq2S/dTXzVcU
n8xx7R6c5Q800rdZtCWcQi//kB9+regOG653+vdHrzLwbBv9RndzbOZN42NYQlNx
KkFCMMc7N1yYg7IPXriZtgfTzL9KSqSAYQN8u0EeUax6oSktIpbdRVpW+SnUxos+
K/ByH/DNeTsvw2jDT5DtbS2wirrI98c1ARnCZ4mV0eVJ/St1MqmUEPUdzGoZvU9c
I419JDACOnER6kTbecJeDYu+acZa9bXrgOIkVaQJnv9pgRse7qoqBQb1vjugDTZr
LolBhpt9kkJptmL0UdTml8enM1MToMVDehEbXEjYiGvbcUfT9hvGgD+oLE1+wGzG
gOyk5BUYQPNan1zl7UsLdqtgfU12pEi5JOHk7lEF+xzriqV/JmOwcH5EHv3wfm+Z
lHypVzRtbPr/cyeqx20qVNsltgmqAt6RdNkT1ODNFnqJhOkTiFV99PLReh1SZgsO
9VbT9MMhk8xxT6pYLbQk4zcFcny9DGirGC/yAWlqghLQyKMq9Ts=
=MKQh
-----END PGP SIGNATURE-----

--5gzjbh54lkf3rfdd--
