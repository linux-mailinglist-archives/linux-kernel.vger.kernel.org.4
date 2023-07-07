Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2034174AAA0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjGGFfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjGGFex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:34:53 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C8D1FD8;
        Thu,  6 Jul 2023 22:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1688708067; x=1720244067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+rD/hewzM2PrvRZh93DLP5SxI8Y+Nxb+YvSesx2inws=;
  b=j+wumgaKtKSQz/tnytf50GsRiPANTFcArSjzOSsvUxh+/W5aKit8oJMe
   pLL1dUal6xUgDyoSbXMEjDpJAB5UYx9vKAelsxiogsvNSg4M+Scp96GxL
   0mCtO6e0c6QRw1/3RaWJshlF9t6Zx34A+x0wDa1BFHI/Mh6g9zzmyagkH
   yDfEuBSzxjVFHxCNjdiBjBfBTNAlAp1BLeLGcBlT2UG+iiZzyf4mf+2ya
   vFok1Tik7XSiOkc1X33iVWZ//awpKkbmoHpPNUCavIMWbMbT/eEtFMn1D
   b7EmT3Fv/x1cD0RG1gPfv+LzgJot1NjWGxHgcLlFAQywzLRDVXkly4uGD
   w==;
X-IronPort-AV: E=Sophos;i="6.01,187,1684792800"; 
   d="scan'208";a="31803225"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Jul 2023 07:34:24 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id DFB9C280084;
        Fri,  7 Jul 2023 07:34:23 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Robin Murphy <robin.murphy@arm.com>, Frank Li <Frank.li@nxp.com>
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
Date:   Fri, 07 Jul 2023 07:34:23 +0200
Message-ID: <24260662.6Emhk5qWAg@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <ZKbSC8LBjLuo3ygD@lizhi-Precision-Tower-5810>
References: <20230705205954.4159781-1-Frank.Li@nxp.com> <49ef52b7-0269-898c-7cc2-096f2f1037fc@arm.com> <ZKbSC8LBjLuo3ygD@lizhi-Precision-Tower-5810>
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

Hi Frank,

Am Donnerstag, 6. Juli 2023, 16:39:07 CEST schrieb Frank Li:
> On Thu, Jul 06, 2023 at 12:06:19PM +0100, Robin Murphy wrote:
> > > > Am Mittwoch, 5. Juli 2023, 22:59:53 CEST schrieb Frank Li:
> > > > > The reg size of etm nodes is incorrectly set to 64k instead of 4k.
> > > > > This
> > > > > leads to a crash when calling amba_read_periphid().  After correc=
ted
> > > > > reg
> > > > > size, amba_read_periphid() retrieve the correct periphid.
> > > > > arm,primecell-periphid were removed from the etm nodes.
> > > >=20
> > > > So this means the reference manual is wrong here? It clearly states
> > > > the size is 64kiB. Reference Manual i.MX8MP Rev 1. 06/2021
> > > > On a side note: Is imx8mq affected by this as well? The DAP memory
> > > > table lists similar sizes in the RM .
> > >=20
> > > Note that the 64K MMIO space per device is really an alignment thing.
> > > It's a recommendation from ARM to allow individual device MMIO regions
> > > to be mapped on kernels with 64K page size. Most of the time the real
> > > MMIO space occupied by the device is actually much smaller than 64K.
> >=20
> > Indeed, it's quite common for TRM memory maps to be written in terms of
> > the
> > interconnect configuration, i.e. from the point of view of the
> > interconnect
> > itself, that whole range of address space is assigned to that periphera=
l,
> > and it may even be true that the entire range is routed to the port whe=
re
> > that peripheral is connected. However what's of more interest for DT is
> > how
> > much of that range the peripheral itself actually decodes.
>=20
> Yes, there are not problem by mapping bigger space in most case.
>=20
> amba bus's periphal use close to end of region to show device's identical
> information.

Ah, thanks for the explanation. This make things more clear.
But on the other is it sensible to assume the memory resource size to fit t=
he=20
IP address space? It appears to me the size is fixed to 4kiB anyway. Would =
it=20
make more sense to read the values from the address "base + 4K - x" instead=
 of=20
"base + size - x"?

Best regards,
Alexander

> In drivers/amba/bus.c,
>=20
> amba_read_periphid()
> {
> 	...
> 	size =3D resource_size(&dev->res);
> 	...
> 	for (pid =3D 0, i =3D 0; i < 4; i++)
> 		pid |=3D (readl(tmp + size - 0x20 + 4 * i) & 255) << (i *=20
8);
> }
>=20
> So the range in DTS for arm,primecell should be actual IP address space.
>=20
> > Robin.
> >=20
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


