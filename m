Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD19E7027B6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjEOI6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEOI6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:58:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4609F0;
        Mon, 15 May 2023 01:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684141118; x=1715677118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hMsyLAgqduiMwamIfLzaLKeu61ywdWXcxC7+DE2RUok=;
  b=cIMQZPHSEx5zGh9UXDYDyic8v9fmfjZu71fXn+7OhL1/iWALE15DbPNH
   mCcKaSnA7wl7AKDrDPywolp2JdgjoOWwJM8/qGylwSLUka8DDx+sHAUYo
   C3gC0H4u2oOKbnxxa3+o+xh8qs1lgGPCkazuunOIEsJRN/EEyQvOnCsIk
   bJPil/SshjtOHcCNWTMiPltmuuSp0UDD4MTrgp/cEELABRDWf9Cvtcbrq
   fc40Nm3zqAQ3DmK/3qu9Xpw2LlB7TMaxOIjplQzXq/BvkwrxADfNep9/x
   A3WvjaWh9TDRN18PT2rcdsMBiYe4UpOzH+juE0ORibWkosxU+rRoPES2M
   g==;
X-IronPort-AV: E=Sophos;i="5.99,276,1677567600"; 
   d="asc'?scan'208";a="213313694"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2023 01:58:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 15 May 2023 01:58:37 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 15 May 2023 01:58:33 -0700
Date:   Mon, 15 May 2023 09:58:12 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Walker Chen <walker.chen@starfivetech.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 3/3] riscv: dts: starfive: add the node and pins
 configuration for tdm
Message-ID: <20230515-dragonish-diffuser-48a1c6f4c8ae@wendy>
References: <20230511091549.28003-1-walker.chen@starfivetech.com>
 <20230511091549.28003-4-walker.chen@starfivetech.com>
 <cd7803a2-38a0-c498-467f-1ef802645527@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UHn8PAOuSV97BRQJ"
Content-Disposition: inline
In-Reply-To: <cd7803a2-38a0-c498-467f-1ef802645527@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--UHn8PAOuSV97BRQJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 04:44:54PM +0800, Walker Chen wrote:

> Hi Conor / Emil,
>=20
> Based on our discussion a few days ago, the new version of patch for dts =
looks like this,
> Please help to review and provide your comments if you feel free.

> On 2023/5/11 17:15, Walker Chen wrote:

It's only been 4 days chief, of which 2 were the weekend, you don't need
to bump it yet! You'd be better off asking one of your co-workers to
review the content, instead of me. I'll happily apply the patch, with
appropriate review, once the dt-binding has been applied by Mark. I do
not have the capacity to review the detail of individual patches adding
peripherals unfortunately.
Getting your co-workers to look at your patches, and doing the same for
theirs, is almost always a good idea for speeding up the process

Thanks for dropping the overlay though,
Conor.

--UHn8PAOuSV97BRQJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGH0JAAKCRB4tDGHoIJi
0jLDAQDrt1XJCjQ6JyzG4qMUGcwEUFr+S+UP7zNXLyeoCpvSIAEAjxdzf/onbCjn
NqfHT2twydBb9KiPvxH3Xjj9vO+hnQQ=
=spdl
-----END PGP SIGNATURE-----

--UHn8PAOuSV97BRQJ--
