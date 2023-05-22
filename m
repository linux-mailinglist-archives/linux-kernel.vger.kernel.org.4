Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BC470B657
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjEVHUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjEVHTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:19:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A00189;
        Mon, 22 May 2023 00:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684739877; x=1716275877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1M6Z1ByBow/bXnOdxqxOjd8jNr1kq0mhhAPQJOGMrTY=;
  b=nLQQSzAoeEijsP300GK78DBeuth/7bGWhw02/LqaYxBHHIN4aMtzM4RB
   f9bi1ARDGR8koVjR2wS6Lianw1SIO0ieBJBJLu2NRYHuQWV75j3XiC4XJ
   hkOZs76k9m4qnNfQVvUa180LEIT0IFRe88ZAad4bvUva2qX1ZiN9tdfNR
   hHCH9iN/XMherZQ9bIBBzOI6ksGDNulKEQ7TP9lYQl0GyPdWU47IolBfP
   sWbyzRMVTGWC1LAXMMLAVDkF41xPZciCrtEab367ZGVWMvwkCJTGwvqBC
   xZPfGDfPAPRf2d7Ei7t9Ms9z34HPlpeH70m9ZszkIyp6cU+ZFskVi8FQe
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="asc'?scan'208";a="212408777"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 00:16:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 00:16:51 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 00:16:50 -0700
Date:   Mon, 22 May 2023 08:16:28 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Romain Perier <romain.perier@gmail.com>
CC:     Conor Dooley <conor@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-rtc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] dt-bindings: rtc: Add Mstar SSD20xD RTC devicetree
 bindings documentation
Message-ID: <20230522-entitle-pediatric-18da6d47df87@wendy>
References: <20230517144144.365631-1-romain.perier@gmail.com>
 <20230517144144.365631-3-romain.perier@gmail.com>
 <20230517-undertone-revolver-26b42b888b12@spud>
 <CABgxDoJa_yPmAGt6myOWNjQ6eXQ9YgL1H2HjTjza3oD7j4H=RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FDNTg1yOeMHAZATM"
Content-Disposition: inline
In-Reply-To: <CABgxDoJa_yPmAGt6myOWNjQ6eXQ9YgL1H2HjTjza3oD7j4H=RQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--FDNTg1yOeMHAZATM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 08:47:08AM +0200, Romain Perier wrote:
> Le mer. 17 mai 2023 =E0 19:44, Conor Dooley <conor@kernel.org> a =E9crit :

> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - mstar,ssd20xd-rtc
> >
> > Is this x a wildcard?
> > In general, having a specific compatible is preferred, and if there are
> > other models that are compatible we can list several "fall back" to the
> > most specific one implemented in a driver.
>=20
>=20
> The first SoC being concerned is SSD202D, so  "mstar,ssd202d-rtc" ?

Sounds good to me, thanks.

--FDNTg1yOeMHAZATM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGsWzAAKCRB4tDGHoIJi
0h6mAP44axUOcBRXHlC1XXKiO03fGCdj9szctxcElnu2RTN8KAEAlTlMi7zT2zQ3
8xTfzu6irOhovIkfauEYfi53Dr34uQY=
=ZhIz
-----END PGP SIGNATURE-----

--FDNTg1yOeMHAZATM--
