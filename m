Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B0872601E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjFGMzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbjFGMzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:55:38 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0A219BB;
        Wed,  7 Jun 2023 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686142534; x=1717678534;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NlTfIPARILjMX2tlyJqPYMnoCEVAbNRBUNl5mHBgNIg=;
  b=WuMPGXr3PWCvj5AJ+MkcEeDpZDPLJAd59NX2yiH+g3CenjQ25jM0R3F8
   gi5st2U1bzDdErNJNoXdN8kgc5cUL6qtWdd+jOVcLznAT6o9iYC5InOo5
   qsLNzJL1Jw8AM+uAYYVuAzNHiixIYdEyH5TSbRwbTFGm1GapTo/JTgaHJ
   L1iMOlRcxS6JtrgsL6Ysg3inizHep+A20EOd1W1nleFFzx4raMPN3Kt1v
   O/FJBpJfrmzdv8aXOWbGAKZGJpsVpWNfIC/tMJOzgPIEOplG0T+nf6k01
   x5X/Vdun65e0dq88qI306rzR0Sum0cBW4LBy79pGnm4dDV1PxH4hvvpcm
   g==;
X-IronPort-AV: E=Sophos;i="6.00,224,1681164000"; 
   d="scan'208";a="31331083"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Jun 2023 14:55:31 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 07 Jun 2023 14:55:31 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 07 Jun 2023 14:55:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686142531; x=1717678531;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NlTfIPARILjMX2tlyJqPYMnoCEVAbNRBUNl5mHBgNIg=;
  b=k0uHsXLUB+yNxJ6ntMGsebaYdVdQRX1zEGHpnKXMH9m8L7Mvq+p+ScbI
   u6gFQR97r7t7OBo34x/F6fumK8n9uGUj5nDvqPDTr7KH0EtJ5X4lB+MNu
   mR9+DEXAbzFal7WfhGP6Hn7vtvZIgDqilRK5l0eu9umonYlumJG5dwS/L
   sv+WvagJs+NMh+4dXQScHOrRsLjCWXybPw/4ZLNA5X9SM9epiLvBeEN8/
   5jmVjMFelxj5XIsD+YFNEvdREVk25tL8fo6N3RyWrXp1L0DeF0KLIJEBW
   qn4WMCnadLfapZMzzy+JXpl8ehnhAkXkxuPAVMQWu89A0CnSmRLkxR2mK
   w==;
X-IronPort-AV: E=Sophos;i="6.00,224,1681164000"; 
   d="scan'208";a="31331082"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Jun 2023 14:55:31 +0200
Received: from [192.168.2.129] (SCHIFFERM-M2.tq-net.de [10.121.49.20])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 366DB280082;
        Wed,  7 Jun 2023 14:55:31 +0200 (CEST)
Message-ID: <6a0abd6bba2f8f940e695dfa9fd0c5f8ee19064f.camel@ew.tq-group.com>
Subject: Re: [PATCH 1/2] spi: dt-bindings: introduce linux,use-rt-queue flag
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Date:   Wed, 07 Jun 2023 14:55:31 +0200
In-Reply-To: <a1a1bf95-6333-40a8-9f08-4c952cd070df@sirena.org.uk>
References: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com>
         <628b7411-7d12-4915-80c8-cabb74ac6590@sirena.org.uk>
         <CACRpkdYhFmG-Cb-5+dt1Huktnm+tkOjSGO5ZFPjGeOXRott6Dw@mail.gmail.com>
         <a1a1bf95-6333-40a8-9f08-4c952cd070df@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-06-06 at 15:44 +0100, Mark Brown wrote:
> * PGP Signed by an unknown key
>=20
> On Tue, Jun 06, 2023 at 04:37:08PM +0200, Linus Walleij wrote:
> > On Fri, Jun 2, 2023 at 2:22=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:
> > > On Fri, Jun 02, 2023 at 01:52:00PM +0200, Matthias Schiffer wrote:
>=20
> > > > We have seen a number of downstream patches that allow enabling the
> > > > realtime feature of the SPI subsystem to reduce latency. These were
> > > > usually implemented for a specific SPI driver, even though the actu=
al
> > > > handling of the rt flag is happening in the generic SPI controller =
code.
>=20
> > > > Introduce a generic linux,use-rt-queue flag that can be used with a=
ny
> > > > controller driver. The now redundant driver-specific pl022,rt flag =
is
> > > > marked as deprecated.
>=20
> > > This is clearly OS specific tuning so out of scope for DT...
>=20
> > In a sense, but to be fair anything prefixed linux,* is out of scope fo=
r DT,
> > Documentation/devicetree/bindings/input/matrix-keymap.yaml being
> > the most obvious offender.
>=20
> That's at least a description of hardware though.  This is a performance
> tuning thing, if it needs to be configured at all it should be
> configured at runtime.  Some applications might see things work better,
> some might see performance reduced and new versions might have different
> performance characteristics and need different configuration.


It is not clear to me what alternative options we currently have if we
want a setting to be effective from the very beginning, before
userspace is running. Of course adding a cmdline option would work, but
that seems worse than having it in the DT in every possible way.

I can understand not wanting such tuning in Device Trees in the kernel
repo - I agree that these default DTs should only describe the hardware
and it makes sense to keep OS-specific tuning out of them.

Requiring such tuning for specific drivers or driver instances is
however a common issue for embedded systems, which is why we are seeing
(and occasionally writing) such patches - setting things up from
userspace may happen too late, or may not be possible at all if a
setting needs to be available during probe. And even when deferring
things to userspace is possible, making things configurable at runtime
always adds some complexity, even though it is often not a requirement
at all for embedded systems.

Just doing this through the DT is very convenient and robust. The
settings could be inserted into the default DT as an overlay applied
during build or by the bootloader.

Any alternative solution we could come up with would likely add more
complexity on the driver side, and be less convenient to use for
developers. Overall, the rationale for not supporting such bindings in
drivers seems much weaker to me than that for not having such settings
in default DTs...

Best regards,
Matthias


(ps. Sorry about our bouncing linux@ address. Should be fixed now.)

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/

