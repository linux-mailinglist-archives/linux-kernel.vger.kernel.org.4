Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6738731BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344581AbjFOOqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241515AbjFOOqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:46:23 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4FA2738;
        Thu, 15 Jun 2023 07:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686840382; x=1718376382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w2ayRntIx66c3kb7kHjkDoIbStA/FMzpLG4P7j/Q6ZY=;
  b=kZnkhlCyi8+9FBQKUWXD8mkDUb+ZBliok5J9Rgt5atOo9K2GgwJSOIsG
   puqlMCactx4BYnKZf39MhKvHjpDKKS7q5Zn44uhk4srSGOJVrma/nx1Xt
   b9Nz5zqqw2UacFGsvXcAOgXZVc0FHYbP6Bzd5gZ1QUOD51Tm7DwdnpyOA
   2ogdH6bVbwBbHTAbjVSuOA9dHsiRsdRwo6jSVl5ILkxdzleqoRINcOTMJ
   2Om0ZO0RadLWq2dRmGcBWswcS0hnbQPO+7ZKciW01USA+vzzdRgtl+cEu
   CL+z4p35v9MmF8JY9qRxHHaA7lM6Df/9j/ZbU80DcSGjQB4Fso9nx3klT
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,245,1681164000"; 
   d="scan'208";a="31453480"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Jun 2023 16:46:19 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id AF613280084;
        Thu, 15 Jun 2023 16:46:18 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 1/3] dt: bindings: add bindings for TQMa93xxLA SOM
Date:   Thu, 15 Jun 2023 16:46:20 +0200
Message-ID: <6315067.GXAFRqVoOG@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <1bf1890f-d24c-12a1-217d-27579a2464a6@linaro.org>
References: <20230609132915.634338-1-alexander.stein@ew.tq-group.com> <20230609132915.634338-2-alexander.stein@ew.tq-group.com> <1bf1890f-d24c-12a1-217d-27579a2464a6@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Freitag, 9. Juni 2023, 17:58:17 CEST schrieb Krzysztof Kozlowski:
> On 09/06/2023 15:29, Alexander Stein wrote:
> > From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> >=20
> > TQMa93xxLA is a SOM variant in the TQ-Systems GmbH TQMa93xx series using
> > NXP i.MX93 CPU on an LGA type board.
> > MBa93xxCA is a starterkit base board for TQMa93xxLA on an adapter board.
>=20
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
>=20
> It is dt-bindings, not something else.
>=20
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings. One
> bindings is enough.

Thanks. I'll update that.

> > Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >=20
> >  .../devicetree/bindings/arm/fsl.yaml          | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml
> > b/Documentation/devicetree/bindings/arm/fsl.yaml index
> > 2510eaa8906dd..8048c7f6a299d 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> >=20
> > @@ -1219,6 +1219,25 @@ properties:
> >                - fsl,imxrt1170-evk         # i.MXRT1170 EVK Board
> >           =20
> >            - const: fsl,imxrt1170
> >=20
> > +      - description:
> > +          TQMa93xxLA and TQMa93xxCA are two series of feature compatib=
le
> > SOM +          using NXP i.MX93 SOC in 11x11 mm package.
> > +          TQMa93xxLA is designed to be soldered on different carrier
> > boards. +          TQMa93xxCA is a compatible variant using board to
> > board connectors. +          All SOM and CPU variants use the same devi=
ce
> > tree hence only one +          compatible is needed. Bootloader disables
> > all features not present +          in the assembled SOC.
> > +          MBa93xxCA mainboard can be used as starterkit for the SOM
> > +          soldered on an adapter board or for the connector variant
> > +          MBa93xxLA mainboard is a single board computer using the
> > solderable +          SOM variant
> > +        items:
> > +          - enum:
> > +              - tq,imx93-tqma9352-mba93xxca # TQ-Systems GmbH i.MX93
> > TQMa93xxCA/LA SOM on MBa93xxCA +              -
> > tq,imx93-tqma9352-mba93xxla # TQ-Systems GmbH i.MX93 TQMa93xxLA SOM on
> > MBa93xxLA SBC
> xx sound like wildcard which you should not use. If you open the product
> page, it also suggests that.

xx is a wildcard only for modules TQMa93xx, depending on the soldered SoC, =
but=20
not for the mainboard MBa93xx.
You are right that there is the ordering number MBa9352LA-AA, so the=20
compatible would be "tq,imx93-tqma9352-mba9352la". But the actual values fo=
r=20
the wildcards is copied from the soldered module. So using a TQMa9351LA wou=
ld=20
result in MBa9351LA-AA, although the mainboard is identical.

Best regards,
Alexander

> Best regards,
> Krzysztof


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


