Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4274F7503D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjGLJtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjGLJtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:49:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236FD1734;
        Wed, 12 Jul 2023 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689155371; x=1720691371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7AaIohzmGHW88bh4A6tVGoqvBNMogRuXtIs67YR2RQE=;
  b=IEmqsRZKuFdGI0OY/S94qhf2/9DMPq8ICNJYmYTR8B/+7L3zI8+ssjlw
   J9puuEMi5ZcdVyu+YOQkZokiNwroNv+dbNDUzEDCrvcNISWZ/TL6jLp6y
   mIt/NnXOeixOSY6wpP8LZ5Rm7tNml45TmHV0styjMU3tcNIkyMkIes6Bm
   2Q1yzZiAZ9CsMamzvEyOvjkOJ+uSeLHqYB2OdmbK0SEC7cMxsaahhRc6Y
   9/Wh5KbBC7AELFhSLKVwFxS56+60WXYVJCDR/ktEHq+Ab1i2Ctwlkf0qy
   a8VJbozxzqyALqtZfUYqM2qbfIj4+NZ1EnesePJbRXHmK/TI+IYoIKQmS
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="asc'?scan'208";a="222577993"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2023 02:49:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 12 Jul 2023 02:49:30 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 12 Jul 2023 02:49:28 -0700
Date:   Wed, 12 Jul 2023 10:48:57 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <soc@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/process: maintainer-soc: document
 dtbs_check requirement for Samsung
Message-ID: <20230712-skier-ribcage-0d82be7e16fd@wendy>
References: <20230712084131.127982-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jnDx7med4PR7Ca25"
Content-Disposition: inline
In-Reply-To: <20230712084131.127982-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--jnDx7med4PR7Ca25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 10:41:31AM +0200, Krzysztof Kozlowski wrote:
> Samsung ARM/ARM64 SoCs (except legacy S5PV210) are also expected not to
> bring any new dtbs_check warnings.  In fact this have been already
> enforced and tested since few release.
>=20
> Cc: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---

> Not sure where to document this. Creating new maintainer profile for
> Samsung SoC would be an overkill. OTOH, more SoCs might want to grow
> this list, so this also scales poor.

To me, this portion of the document was "information to the
submaintainer", which would be you, not information to the contributors
to the platform. Adding the comment about Samsung SoC seems aimed at
contributors?
I added the bit about W=3D1 on RISC-V since there are multiple
sub-maintainers there.

> ---
>  Documentation/process/maintainer-soc.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/process/maintainer-soc.rst b/Documentation/pro=
cess/maintainer-soc.rst
> index 49f08289d62c..12637530d68f 100644
> --- a/Documentation/process/maintainer-soc.rst
> +++ b/Documentation/process/maintainer-soc.rst
> @@ -133,8 +133,8 @@ with the dt-bindings that describe the ABI.  Please r=
ead the section
>  more information on the validation of devicetrees.
> =20
>  For new platforms, or additions to existing ones, ``make dtbs_check`` sh=
ould not
> -add any new warnings.  For RISC-V, as it has the advantage of being a ne=
wer
> -architecture, ``make dtbs_check W=3D1`` is required to not add any new w=
arnings.
> +add any new warnings.  For RISC-V and Samsung SoC, ``make dtbs_check W=
=3D1`` is
> +required to not add any new warnings.
>  If in any doubt about a devicetree change, reach out to the devicetree
>  maintainers.
> =20
> --=20
> 2.34.1
>=20

--jnDx7med4PR7Ca25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK53CQAKCRB4tDGHoIJi
0g01AP9J2DO5r+KESygofbiZ5DRbA3R+nDW85who/mRtjzDaRgD/a2fBQPx9uYgQ
PMTDslMGKoeOXIwmcEChxspAVZkyGwc=
=Mk6D
-----END PGP SIGNATURE-----

--jnDx7med4PR7Ca25--
