Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E17B6F4349
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjEBMH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjEBMH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:07:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF582693
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683029245; x=1714565245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n5uHiDH+SnajIznIYwgZH3EmqD4zWQ6ZYSN5MTqLhAE=;
  b=ZZCvbSprb4VGCUBN76pxMbecXmCHngL4h/Vs47wJ7CNPKGZx+SbuNWML
   vt8zcR6I9ZVUEbSPMQz6ui5T+nKFAW2FJJizM3Zha5jIvUO3JA66PsFQ0
   hGzzbVwhORU2AbqAqM+a4gzerfe7cn8kZCZo0NfLhQ/OZvahFMg+w1Q9P
   XJzrrFYlI/KSlYKQMaHbmTukubAelIVNWlGrtvo/S+abuQT/Tu/BGufNY
   k4WROr7qgDMi5elVEo+zaoghly1BvRVK6RriAa6Pn4EhnSY0rBsLlg/4t
   vnNUkkS/u3E5bzJDuCYTCEgcjcXHx1LQumQeNkopkL7vW7YaKm1ty6gLO
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,244,1677567600"; 
   d="asc'?scan'208";a="223454444"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 May 2023 05:07:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 2 May 2023 05:07:20 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 2 May 2023 05:07:20 -0700
Date:   Tue, 2 May 2023 13:07:01 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] reset: mpfs: select AUXILIARY_BUS
Message-ID: <20230502-uneven-configure-0f7e322e7a5c@wendy>
References: <20230502102041.1418397-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FiooAKBTGpfrY2OE"
Content-Disposition: inline
In-Reply-To: <20230502102041.1418397-1-p.zabel@pengutronix.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--FiooAKBTGpfrY2OE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2023 at 12:20:41PM +0200, Philipp Zabel wrote:
> CONFIG_AUXILIARY_BUS is not a user-visible symbol, replace 'depends on'
> with 'select'.
>=20
> Cc: Conor Dooley <conor.dooley@microchip.com>
> Cc: Daire McNamara <daire.mcnamara@microchip.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 6aa8f243b30c..086cb23debba 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -154,7 +154,8 @@ config RESET_PISTACHIO
> =20
>  config RESET_POLARFIRE_SOC
>  	bool "Microchip PolarFire SoC (MPFS) Reset Driver"
> -	depends on AUXILIARY_BUS && MCHP_CLK_MPFS
> +	depends on MCHP_CLK_MPFS

I think this `depends on` makes this patch moot, as MCHP_CLK_MPFS
selects AUXILIARY_BUS. I don't really mind if it's switched to select
for consistency, or removed entirely though, so:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +	select AUXILIARY_BUS
>  	default MCHP_CLK_MPFS
>  	help
>  	  This driver supports peripheral reset for the Microchip PolarFire SoC
> --=20
> 2.39.2
>=20

--FiooAKBTGpfrY2OE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFD85QAKCRB4tDGHoIJi
0uYSAP97Y1L2HznR1GU6MUA7Awr9Vihe4woT5Q9C/iTVb5LtuQEAlaXhApfu+UB/
H6wPtKdByxE8X3C2zqFRVocHRDT7UwM=
=23wo
-----END PGP SIGNATURE-----

--FiooAKBTGpfrY2OE--
