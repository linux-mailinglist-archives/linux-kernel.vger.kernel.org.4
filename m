Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE17611432
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJ1ONG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiJ1OM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:12:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48891D5E34;
        Fri, 28 Oct 2022 07:12:57 -0700 (PDT)
Received: from mercury (unknown [37.84.150.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 891096602925;
        Fri, 28 Oct 2022 15:12:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666966376;
        bh=Q8Sm90eLz9bcTykS5udA2a2769DuI7dhaihk1DL2/OI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EK1YwROS5o/I/+6D0cAcus4o9M3IpJ+GyQOSkamLQsZ0xM8FLzoIyB2i4UFBS2Epf
         65VT71GdpZGOzMfrmeA0V+IKZlMAyF4lBc2qv5iGzhsAKgSPIWiLCa2tPokyBZi8eG
         x3HCxC1A/TtVUW8Ckm3mlo72jy4wTY6QOqOnaDKVtWziI1pSyhHXekamSnc8/YuRl8
         h1MQizX/9VZj3pP9gHOtmcrDAnlPF5OKYjs/o1AuGW2ZwHL2eIJX9dZhhMBFXnJUsW
         cm81EzdMXWC2Pb/2CiNO5D36bqQbHoppkNwyDGkKsjjJDw4cFh9cidvT3PIxvDCnYU
         83VnMTxo80AQQ==
Received: by mercury (Postfix, from userid 1000)
        id AEB8B10607E8; Fri, 28 Oct 2022 16:12:53 +0200 (CEST)
Date:   Fri, 28 Oct 2022 16:12:53 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power/supply: fix repeated words in comments
Message-ID: <20221028141253.scedsv7neimehpec@mercury.elektranox.org>
References: <20221022054544.35121-1-wangjianli@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="toctd2ayv5efoqap"
Content-Disposition: inline
In-Reply-To: <20221022054544.35121-1-wangjianli@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--toctd2ayv5efoqap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 22, 2022 at 01:45:44PM +0800, wangjianli wrote:
> Delete the redundant word 'the'.
>=20
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index d04d087caa50..2af83643508c 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -1963,7 +1963,7 @@ static int ab8500_charger_get_ext_psy_data(struct d=
evice *dev, void *data)
>   *
>   * Due to a asic bug it is necessary to lower the input current to the v=
bus
>   * charger when charging with at some specific levels. This issue is onl=
y valid
> - * for below a certain battery voltage. This function makes sure that the
> + * for below a certain battery voltage. This function makes sure that
>   * the allowed current limit isn't exceeded.
>   */
>  static void ab8500_charger_check_vbat_work(struct work_struct *work)
> --=20
> 2.36.1
>=20

--toctd2ayv5efoqap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNb42UACgkQ2O7X88g7
+pq1NQ/7BWd4wz61to42/m++n27nu3LTmeg0j8zeocQh683rSyx/93o8Dz4/H6qm
gHklvpELCKGpz0Q+mDMrhpMdFE0mz2CxiQTZOCFziXgMFHfbHKQaIWasYQadSdH1
78rJkEGVbyU0XkV29vG29cMVbjZ+7QT/AemgMmLpGe1BtHfQRKOFphXRAsxfQAq1
0J6FS+2xspt5Am+bjMOvgsIaAN7w72vCNjptwyex6p1qAPlY1FFixweCxp7EOXMD
+5LcCqAASMnUFJTl1qNiacr0F7Rfa3xB6gzaeeIsrt/vBz1VcKpBQxi4a1mAT4tl
cyvkdRuT1q79M7kJIKA0rPzUFBy96goO1IaFa+oN1CZrhBMQOOraLmc2cfZ1buKQ
q6lQMlDRZqOKp9osaHbWRP4H5jcxYxKCuSOI8ZTiLOaPhIpwB/aRr4f5m7TtF7iB
Gk54nZen9iFrlzFl+gN19xXrmw6NsHtHJdsA3AmVSgb5fxn1rlG1mNTXuIq35a2d
EEcQpVAyHJTTQs7zyjhh+nXmzMYUcU9MsuslKtvsl0hPQJF1YZNct+UBQTmLYhgH
KOMf9uB03F5UFvFKi2CKK+QGcFEGs9hSMGRee4dZQTpcdI+sBD+1/VoSLBBOPOrq
vPHokTxOs8WqpWbwV2o4pzdL8jcxmBAxSlZGMF8eNX65mwKHwpQ=
=hw1n
-----END PGP SIGNATURE-----

--toctd2ayv5efoqap--
