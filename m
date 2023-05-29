Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B430A71498B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjE2Mem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjE2Mei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:34:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BB7B1;
        Mon, 29 May 2023 05:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685363677; x=1716899677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4pmOlNa7lnhyf/SMcDgOZ3LHEEg6eRD1aYLUUYNr8Ek=;
  b=hExlsBTgdId86OHOizx6I8PcF+OfgoQg7fgIkMJfFqwZwlVrBr6SmgPK
   qdzSNV2n+otNxvHII0H7ezXPg04ym15WXhK/+eluFxKFYMUCDucigeUSm
   7N12zB5AX1J+o+WzadOW1jTAc6RVz4gvF7QKglKZ1AX4oKxJHy2Hoj/nY
   YW0qRnYUgPwYMAgAD7IXsUklioFSnqeIFuaA5EQM993NmkuX/5W1nIFrB
   AFP0qyn+lpKqaPiBiRazEq45/A9dfXa1Eq0aoJjZX5NMs0r/RA2/3HdCJ
   ETk2x6AU9Ce9LsQ4TTt3O+rmQkrBL9DxraZaWwmKUoM/EtXDnOybuDZPR
   A==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="asc'?scan'208";a="227438102"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 05:34:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 05:34:27 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 05:34:25 -0700
Date:   Mon, 29 May 2023 13:34:02 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>
CC:     Conor Dooley <conor@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: Re: [EXT] Re: [PATCH 1/2 v8] dt-bindings: watchdog: marvell GTI
 system watchdog driver
Message-ID: <20230529-unwanted-chewer-b3f6ab8bcb86@wendy>
References: <20230526062626.1180-1-bbhushan2@marvell.com>
 <20230526-bondless-slather-5de0a5659353@spud>
 <DM5PR1801MB188350DD9CFDBB3E240AC838E3449@DM5PR1801MB1883.namprd18.prod.outlook.com>
 <20230527-wiring-coping-88eba4d91f3f@spud>
 <DM5PR1801MB1883D475F396D2CBA02B6D91E34A9@DM5PR1801MB1883.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ywTPy+AUgC8z/xRs"
Content-Disposition: inline
In-Reply-To: <DM5PR1801MB1883D475F396D2CBA02B6D91E34A9@DM5PR1801MB1883.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ywTPy+AUgC8z/xRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Bharat,

On Mon, May 29, 2023 at 06:14:07AM +0000, Bharat Bhushan wrote:

> Fallback you mentioned make code look simple. Is below representation cor=
rect for above mentioned fallback?=20
>=20
> properties:
>   compatible:
>     oneOf:
>       - const: marvell,cn9670-wdt
>       - items:
>           - enum:
>               - marvell,cn9880-wdt
>               - marvell,cnf9535-wdt
>           - const: marvell,cn9670-wdt
>       - const: marvell,cn10624-wdt
>       - items:
>           - enum:
>               - marvell,cn10308-wdt
>               - marvell,cnf10518-wdt
>           - const: marvell,cn10624-wdt

Instead of having const: bits for each of the single-compatible ones, if
you are not going to add descriptions, I'd probably do:
properties:
  compatible:
    oneOf:
      - enum:
          - marvell,cn9670-wdt
          - marvell,cn10624-wdt

      - items:
          - enum:
              - marvell,cn9880-wdt
              - marvell,cnf9535-wdt
          - const: marvell,cn9670-wdt

      - items:
          - enum:
              - marvell,cn10308-wdt
              - marvell,cnf10518-wdt
          - const: marvell,cn10624-wdt

> And driver will have
>         { .compatible =3D "marvell,cn9670-wdt", .data =3D &match_data_oct=
eontx2},
>         { .compatible =3D "marvell,cn10624-wdt", .data =3D &match_data_cn=
10k},

Otherwise, looks good to me. You should probably also rename the file to
match one of the compatibles contained in it.

Thanks,
Conor.

--ywTPy+AUgC8z/xRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHSbugAKCRB4tDGHoIJi
0jZ9AP9dKKl1qfQuhXx6zf7LJ/oKTPhJB0Iymd+M3n5+3MyDMAD9HryFUB8C5p7A
zZ1uKMaseMn/g5aNILTTqA5PwMwQdQ4=
=6E/Q
-----END PGP SIGNATURE-----

--ywTPy+AUgC8z/xRs--
