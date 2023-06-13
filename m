Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A5572E5BE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242921AbjFMOaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbjFMOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:30:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C2E54;
        Tue, 13 Jun 2023 07:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686666606; x=1718202606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uE8h88szvoGxwdIx+6c5cOD/htbOXhAFq/tdRywRONE=;
  b=Olr+8lkQUIJ9uUZPFEoZknMt2l6GidZ6ovf0c2q2EEHo5/WDx5FXI8if
   dfGqeQ0HFijr5qSkdNXuZ2aj8xWJUGklZ36TH6xH3Wm9CAQGMzWsEMwAb
   p+AMsdGGMx701vctiRHYl78kRpthKustp7kDfP9iOFYZ6oePOUt+6tZ8a
   7MEDKFUZbXZ7dOF+twr/hACsSg/Chmc2UfcxrKtc7wpvnHrVcf1EKwd4u
   nrrpc4xWm+2ex57GUaRfWMsXYx9Zkv7AXgqyxugM30OztwUdZTh3lzPi4
   HMoW9B/7412DELJaspqVDUHsUMhpcIdPqLHtDMaLREQTVZqU6Iuwh8TvD
   A==;
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="asc'?scan'208";a="215841586"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2023 07:30:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 13 Jun 2023 07:30:01 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 13 Jun 2023 07:29:59 -0700
Date:   Tue, 13 Jun 2023 15:29:33 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Yingkun Meng <mengyingkun@loongson.cn>,
        Conor Dooley <conor@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <conor+dt@kernel.org>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <loongarch@lists.linux.dev>,
        <loongson-kernel@lists.loongnix.cn>
Subject: Re: [ PATCH v2 3/3] ASoC: dt-bindings: Add support for Loongson
 audio card
Message-ID: <20230613-crewmate-levitate-597ab96ea2d7@wendy>
References: <20230612085614.3039498-1-mengyingkun@loongson.cn>
 <20230612-booted-french-186dd95e78a9@spud>
 <bda7c25f-65cf-d45f-3ac0-f2471e3aacf8@loongson.cn>
 <20230613-zoologist-panorama-a87858bba075@wendy>
 <887f9cc4-6457-9d14-8aef-011ff4c9aeda@loongson.cn>
 <20230613-depletion-garnet-ccc2009111c3@wendy>
 <449d07d9-5538-4f36-83a0-3a81a9ab9ea2@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="F73UMBvZBx0/ykU7"
Content-Disposition: inline
In-Reply-To: <449d07d9-5538-4f36-83a0-3a81a9ab9ea2@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--F73UMBvZBx0/ykU7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 02:54:36PM +0100, Mark Brown wrote:
> On Tue, Jun 13, 2023 at 01:46:41PM +0100, Conor Dooley wrote:
>=20
> > So it is entirely a software construct? Why does it need a dt-binding
> > then? Your commit message says the controller is present on the device!
>=20
> A typical embedded (or power efficient laptop) audio design will consist
> of multiple devices connected together (frequently via non-control
> buses) together with system level passive components and plastics which
> are also important to the audio configuration.  A card binding describes
> the interconections between the devices in the system and provides
> identification information for the audio subsystem.  This system level
> audio integration is a physical thing that can be pointed at that
> requires real software control.

The bit you were responding to with that was a disingenuous question.
Probably not fair of me to ask one of a non-native speaker like that,
when all I wanted to know was whether it was appropriate not to add
a more specific compatible, or whether this was something invariant.

> Like I said before please look at the existing audio card bindings.

Yah, ofc I did that to see if there were other similar bindings that
used specific compatibles...


--F73UMBvZBx0/ykU7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIh9TQAKCRB4tDGHoIJi
0im6AQCKC+utNKucFVTzatpu/JT9toHFnwcH/P19lIwDWM2GMwD+LgeihZ5UpRNH
1O78Io5ySAoSy/xH4fujDTp98LU1SQI=
=AuWz
-----END PGP SIGNATURE-----

--F73UMBvZBx0/ykU7--
