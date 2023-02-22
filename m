Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4683369F261
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjBVJ7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjBVJ7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:59:40 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67CF30B36;
        Wed, 22 Feb 2023 01:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677059960; x=1708595960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N2hk9GlJCT2NgITlKoyZMXhacfZJstXnR+eEKJSowwk=;
  b=IUZNvuwAjed5rwpmIGqtD14XdZyo9XDy53BLiMjeXIUOoFBSnQ7WTUtI
   I6DyjndPxKerpavcnF5RAR+rRS8XvZaQbDRItjKnIq1/QgfiHFA4cNDEW
   Eq7utCH8iICGfRUcW89xjJTQZ7Upaswg+65rqyFfDCuzr/iasbkMgaFoB
   n0oQV2P4/hWD583ZickmOHstmF+jh0R/Cnw0xDm5q97ck2uFpJKox/r6v
   OLm7aKRXM0nkwiNzC9BjSG3MTSgiP0e/8WqrpECs+NgcZ6BoPFp8YDMSi
   f7pHLqbnMOv4+F8cLIO7QgnMRUr+ucqUAgQeAXSqjjI4KdYsuGPrn3zcS
   g==;
X-IronPort-AV: E=Sophos;i="5.97,318,1669100400"; 
   d="asc'?scan'208";a="138447304"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Feb 2023 02:59:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 02:59:17 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Wed, 22 Feb 2023 02:59:14 -0700
Date:   Wed, 22 Feb 2023 09:58:48 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
CC:     shravan kumar <shravan.chippa@microchip.com>,
        <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Prakash Battu <Prakash.Battu@microchip.com>
Subject: Re: [PATCH v11 3/5] media: i2c: imx334: support lower bandwidth mode
Message-ID: <Y/XnWOomz2N9fCvc@wendy>
References: <20230208050915.1958183-1-shravan.chippa@microchip.com>
 <20230208050915.1958183-4-shravan.chippa@microchip.com>
 <Y/Xc9RCmO8P8eKtL@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6BcYyEiurpuctdJY"
Content-Disposition: inline
In-Reply-To: <Y/Xc9RCmO8P8eKtL@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--6BcYyEiurpuctdJY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2023 at 11:14:29AM +0200, Sakari Ailus wrote:
> On Wed, Feb 08, 2023 at 10:39:13AM +0530, shravan kumar wrote:
> > From: Shravan Chippa <shravan.chippa@microchip.com>

> > @@ -666,11 +885,26 @@ static int imx334_init_pad_cfg(struct v4l2_subdev=
 *sd,
> >  	struct v4l2_subdev_format fmt =3D { 0 };
> > =20
> >  	fmt.which =3D sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_=
ACTIVE;
> > -	imx334_fill_pad_format(imx334, &supported_mode, &fmt);
> > +	imx334_fill_pad_format(imx334, &supported_modes[0], &fmt);
>=20
> Now that there are multiple modes supported, this would appear to get the
> width, height as well as the other fields (apart from mbus code) from the
> first mode.

Is this statement supposed to be a request to change something, or just
a throwaway comment? It's a little hard for me to understand your
intention here, sorry.

> > =20
> >  	return imx334_set_pad_format(sd, sd_state, &fmt);
> >  }
> > =20


--6BcYyEiurpuctdJY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/XnWAAKCRB4tDGHoIJi
0pMEAQDF93yO1Y4hUi+49FMYt5ZCrzx5No5+sGSuHEFB/uLh+wEAnElojzoqotU6
PpeozsTZGz3d6VWaC32WOscjSMhGFgk=
=UzAQ
-----END PGP SIGNATURE-----

--6BcYyEiurpuctdJY--
