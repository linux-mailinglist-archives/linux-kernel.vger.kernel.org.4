Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57AA74B0AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjGGMZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjGGMZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:25:54 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5B31FE6;
        Fri,  7 Jul 2023 05:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1688732752; x=1720268752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fHVHlYyXVX/im36hgUnWjYzXHXB5AFCDep27NaHMXWM=;
  b=beYPnHRJ6LKY9Vc0IQ+oKLuic53q8hblbBfJ7Xz0wFVVcE4e4VpFoNNV
   Ce5q9PfSVCYwc95IqIAVJf2lZpAtbS2vee9SRRsT+G1/oMkzBk0THUnp0
   xhvVGp7WBUBWGUSfzsWxWIchIoV4TxT4G/g/Kz/wnmFP0AATYejs2Yaxt
   MqvcKbTyOr0geU5X37uW1DxdWzdPOb+2q4adAnag+fpvNlsZB80BkloYS
   nC9MYl9a7HpZSzbws92PiGBxIDRqq1HpdvkXPURn5Mrnlx6hsB1A/1LU6
   F+GeUjzIg6XzszGgy5suIa0xunNlJOhNQ1C/ClwtdRfoKrO9Dy5HTcYtL
   w==;
X-IronPort-AV: E=Sophos;i="6.01,187,1684792800"; 
   d="scan'208";a="31813721"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Jul 2023 14:25:49 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 97C4E280084;
        Fri,  7 Jul 2023 14:25:49 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Frank Li <Frank.li@nxp.com>, Robin Murphy <robin.murphy@arm.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>, suzuki.poulose@arm.com,
        coresight@lists.linaro.org, imx@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp: remove arm, primecell-periphid at etm nodes
Date:   Fri, 07 Jul 2023 14:25:49 +0200
Message-ID: <6505804.Sb9uPGUboI@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <5cf23bfd-a3b7-3dde-146b-4892d75b3485@arm.com>
References: <20230705205954.4159781-1-Frank.Li@nxp.com> <24260662.6Emhk5qWAg@steina-w> <5cf23bfd-a3b7-3dde-146b-4892d75b3485@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Am Freitag, 7. Juli 2023, 10:50:31 CEST schrieb Robin Murphy:
> On 2023-07-07 06:34, Alexander Stein wrote:
> > Hi Frank,
> >=20
> > Am Donnerstag, 6. Juli 2023, 16:39:07 CEST schrieb Frank Li:
> >> On Thu, Jul 06, 2023 at 12:06:19PM +0100, Robin Murphy wrote:
> >>>>> Am Mittwoch, 5. Juli 2023, 22:59:53 CEST schrieb Frank Li:
> >>>>>> The reg size of etm nodes is incorrectly set to 64k instead of 4k.
> >>>>>> This
> >>>>>> leads to a crash when calling amba_read_periphid().  After correct=
ed
> >>>>>> reg
> >>>>>> size, amba_read_periphid() retrieve the correct periphid.
> >>>>>> arm,primecell-periphid were removed from the etm nodes.
> >>>>>=20
> >>>>> So this means the reference manual is wrong here? It clearly states
> >>>>> the size is 64kiB. Reference Manual i.MX8MP Rev 1. 06/2021
> >>>>> On a side note: Is imx8mq affected by this as well? The DAP memory
> >>>>> table lists similar sizes in the RM .
> >>>>=20
> >>>> Note that the 64K MMIO space per device is really an alignment thing.
> >>>> It's a recommendation from ARM to allow individual device MMIO regio=
ns
> >>>> to be mapped on kernels with 64K page size. Most of the time the real
> >>>> MMIO space occupied by the device is actually much smaller than 64K.
> >>>=20
> >>> Indeed, it's quite common for TRM memory maps to be written in terms =
of
> >>> the
> >>> interconnect configuration, i.e. from the point of view of the
> >>> interconnect
> >>> itself, that whole range of address space is assigned to that
> >>> peripheral,
> >>> and it may even be true that the entire range is routed to the port
> >>> where
> >>> that peripheral is connected. However what's of more interest for DT =
is
> >>> how
> >>> much of that range the peripheral itself actually decodes.
> >>=20
> >> Yes, there are not problem by mapping bigger space in most case.
> >>=20
> >> amba bus's periphal use close to end of region to show device's identi=
cal
> >> information.
> >=20
> > Ah, thanks for the explanation. This make things more clear.
> > But on the other is it sensible to assume the memory resource size to f=
it
> > the IP address space? It appears to me the size is fixed to 4kiB anyway.
> > Would it make more sense to read the values from the address "base + 4K=
 -
> > x" instead of "base + size - x"?
>=20
> The size of PrimeCell components in general isn't necessarily 4KB
> though, and the ID registers were defined relative to the *end* of the
> register space. The old PrimeCell standards evolved into the CoreSight
> spec, and from the oldest version of that I can easily link to[1]:
>=20
> "Each component occupies one or more contiguous 4KB blocks of address
> space. Where a component occupies more than one 4KB block, these
> registers must appear in the highest 4KB block."
>=20
> (FWIW the latest Coresight 3.0 spec relaxes this restriction, but we
> tend to model newer stuff as platform drivers with explicit DT/ACPI
> identifiers rather than amba drivers anyway)

Ah, I wasn't aware the register space for PrimeCells/CoreSight could be lar=
ger=20
than 4k. So the exact size must be known and used in DT. Thanks for=20
explanation.

Best regards,
Alexander

> Thanks,
> Robin.
>=20
> [1] https://developer.arm.com/documentation/ihi0029/d/?lang=3Den
>=20
> > Best regards,
> > Alexander
> >=20
> >> In drivers/amba/bus.c,
> >>=20
> >> amba_read_periphid()
> >> {
> >>=20
> >> 	...
> >> 	size =3D resource_size(&dev->res);
> >> 	...
> >> 	for (pid =3D 0, i =3D 0; i < 4; i++)
> >> =09
> >> 		pid |=3D (readl(tmp + size - 0x20 + 4 * i) & 255) << (i *
> >=20
> > 8);
> >=20
> >> }
> >>=20
> >> So the range in DTS for arm,primecell should be actual IP address spac=
e.
> >>=20
> >>> Robin.
> >>>=20
> >>>> _______________________________________________
> >>>> linux-arm-kernel mailing list
> >>>> linux-arm-kernel@lists.infradead.org
> >>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


