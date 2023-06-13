Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E686872E34C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242084AbjFMMrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbjFMMrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:47:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02938E4;
        Tue, 13 Jun 2023 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686660429; x=1718196429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9KV3amG53H3ns2W2UWEPrWJRjgAoTih55p2OZIWk4nM=;
  b=IYnhILDagPWgl5o0h9SR3hVu8dhzZviVmHZT7qtjROYenV4COsMd1PYQ
   BHBjLBl8q28TBispGWmitvFT6JTdU4lnmKNiLKTMOi3ZntIW9VsiJfveW
   3l3swOZ5fyirqLMh76GqevN9bMjBkzpP6dMg4VgATEmKpuMq+Z63Jhykm
   3/xfdPN2tXBRAg+eOjVgTbERRzOzfG5yKZ0utGEOaM1D5mwDn6IEM/+F7
   e4x6rCu2WUOV1d5cwae80YiPs3FUhrgrky5oLh3PC0tZgeHG+vbfzcnnv
   oIeIRzjCQY5mdLy59alMZOOxh6LgAWU1sgqadFsTN4eFKRQn37kc0c2BF
   w==;
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="asc'?scan'208";a="229858885"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2023 05:47:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 13 Jun 2023 05:47:08 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 13 Jun 2023 05:47:06 -0700
Date:   Tue, 13 Jun 2023 13:46:41 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Yingkun Meng <mengyingkun@loongson.cn>
CC:     Conor Dooley <conor@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <conor+dt@kernel.org>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <loongarch@lists.linux.dev>,
        <loongson-kernel@lists.loongnix.cn>
Subject: Re: [ PATCH v2 3/3] ASoC: dt-bindings: Add support for Loongson
 audio card
Message-ID: <20230613-depletion-garnet-ccc2009111c3@wendy>
References: <20230612085614.3039498-1-mengyingkun@loongson.cn>
 <20230612-booted-french-186dd95e78a9@spud>
 <bda7c25f-65cf-d45f-3ac0-f2471e3aacf8@loongson.cn>
 <20230613-zoologist-panorama-a87858bba075@wendy>
 <887f9cc4-6457-9d14-8aef-011ff4c9aeda@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aKk1AB1djxJIjJ7/"
Content-Disposition: inline
In-Reply-To: <887f9cc4-6457-9d14-8aef-011ff4c9aeda@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--aKk1AB1djxJIjJ7/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 08:38:59PM +0800, Yingkun Meng wrote:
> On 2023/6/13 20:28, Conor Dooley wrote:
> > On Tue, Jun 13, 2023 at 08:23:58PM +0800, Yingkun Meng wrote:
> > > On 2023/6/13 01:24, Conor Dooley wrote:
> > > > On Mon, Jun 12, 2023 at 04:56:14PM +0800, YingKun Meng wrote:
> > > > > From: Yingkun Meng <mengyingkun@loongson.cn>
> > > > >=20
> > > > > The audio card uses loongson I2S controller present in
> > > > > 7axxx/2kxxx chips to transfer audio data.
> > > > >=20
> > > > > On loongson platform, the chip has only one I2S controller.

> > > > > +description:
> > > > > +  The binding describes the sound card present in loongson
> > > > > +  7axxx/2kxxx platform. The sound card is an ASoC component
> > > > > +  which uses Loongson I2S controller to transfer the audio data.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: loongson,ls-audio-card

> > > > Reviewing sound stuff is beyond my pay grade, so forgive me if I am=
 off
> > > > the rails here, but this (and the "x"s in the description) look a b=
it
> > > > odd. Recently, we've noticed quite a few loongson dt-bindings attem=
pting
> > > > to use a single compatible for many different chips.
> > > > Usually you have individual compatibles for the various SoCs with t=
his
> > > > core, which can fall back to a generic one, rather than just adding=
 a
> > > > generic compatible for all devices.
> > > > As far as I know, there's several SoCs fitting 2kxxx, and the format
> > > > being used elsewhere is "loongson,ls2k1000" etc.
> > >=20
> > > Currently, Loongson has 2K0500/2K1000LA/2K1500/2K2000 chips.
> > >=20
> > > Here, its' possible to use a single compatible for different chips,
> > >=20
> > > as the audio device is a logical device, not dependent on chip model.
> > What, may I ask, is a "logical device"?
>=20
>=20
> I means it's not a physical one, like "platform bus".

So it is entirely a software construct? Why does it need a dt-binding
then? Your commit message says the controller is present on the device!

Confused,
Conor.

--aKk1AB1djxJIjJ7/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIhlMQAKCRB4tDGHoIJi
0k/DAQCasCv+M+mHIyy3THECy16Hhwe7ITu/f3lb4MVy64A/CwD7BlnAWtgAfv7H
IktHIHxxC6ITwBVp8qA9b1IE2/XejAA=
=INbA
-----END PGP SIGNATURE-----

--aKk1AB1djxJIjJ7/--
