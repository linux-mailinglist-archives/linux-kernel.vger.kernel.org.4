Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F317244CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbjFFNsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbjFFNsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:48:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFD410D1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686059314; x=1717595314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D/o5ZakC2TW7Kevz5hdBVuI++QKbHXfAwCanEKsA8lc=;
  b=hcaLUCm6ZWEDoz96F7Io7F6lZmYeRGZA/oABDVKyXIfl1l7ugRE1iHCt
   IKMGlL5pkbX60M7+Rb2WNaKw8G9l28uV+qa5/e6owiJe97Net4OOmzpwp
   Sr8kne1QGKDx/IgQ3k89MWbwzxD/NZCKUgqOOl/nxd/PP/wozqJtCI9YY
   hekqqtkieyBcVj69C4KFI037yDCcxCVDhUJ5H5sDlHY+KRqdkvyB3Nb2h
   U0/iWQtxg3cgp9iASPUtqqxjd2zVynclMEHo/mnwAeztUbpoFX9JHh6cZ
   0kXYr5BrGV0RrwF/NBBdsHg7rWvg7Dxk0kjgbQOYYohx8pdWGaioYyiLO
   A==;
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="asc'?scan'208";a="228668042"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2023 06:48:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 6 Jun 2023 06:48:23 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 6 Jun 2023 06:48:22 -0700
Date:   Tue, 6 Jun 2023 14:47:58 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Moti Haimovski <mhaimovski@habana.ai>
CC:     <gregkh@linuxfoundation.org>, <david.m.ertman@intel.com>,
        <ogabbay@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] make AUXILIARY_BUS config selection clearer
Message-ID: <20230606-aspirate-evident-00b27a98a718@wendy>
References: <20230606133528.197335-1-mhaimovski@habana.ai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uHq986Popr/Gh4ku"
Content-Disposition: inline
In-Reply-To: <20230606133528.197335-1-mhaimovski@habana.ai>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--uHq986Popr/Gh4ku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Moti,

On Tue, Jun 06, 2023 at 04:35:28PM +0300, Moti Haimovski wrote:
> Add a display string and a help section to the config AUXILIARY_BUS
> section under the "Generic Driver Options" menu in order to make its
> selection clearer.

I am a wee bit confused, since it is not explicitly mentioned here, why
is this now going to be user visible/selectable? What was wrong with the
drivers that needed it selecting it?

Thanks,
Conor.

>=20
> Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
> ---
>  drivers/base/Kconfig | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 6f04b831a5c0..e1caac1d9a58 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -2,7 +2,16 @@
>  menu "Generic Driver Options"
> =20
>  config AUXILIARY_BUS
> -	bool
> +	bool "Support for auxiliary bus"
> +	help
> +	  The auxiliary bus driver provides a way to export an interface
> +	  for another subsystem to drive, implement a common intersection
> +	  of functionality or split a function into child-devices
> +	  representing sub-domains of functionality where each auxiliary
> +	  device represents a part of its parent functionality (usually)
> +	  driven by another driver.
> +
> +	  If unsure, say Y.
> =20
>  config UEVENT_HELPER
>  	bool "Support for uevent helper"
> --=20
> 2.25.1
>=20

--uHq986Popr/Gh4ku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZH85DgAKCRB4tDGHoIJi
0t5AAP0bTTjHQ7O3y57NL+qc5ttrvsyuHiwjgeWw6dBey3/ZVQEA53tEP14yxKtq
EuyAnK4BJvQhOGn5H17ry0vM6tXJ1gk=
=BjK9
-----END PGP SIGNATURE-----

--uHq986Popr/Gh4ku--
