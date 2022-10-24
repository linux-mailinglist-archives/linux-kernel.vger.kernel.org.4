Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D85609C57
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJXIWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJXIWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:22:10 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAF62FFE0;
        Mon, 24 Oct 2022 01:19:59 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B0A1CC0015;
        Mon, 24 Oct 2022 08:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666599572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RsqEFobdfsJRtGDvtqy+4TRi3reZeX3cMLi8uvmdLcY=;
        b=d0h7bSc2nXVRxjESjkDhnIoofW1xbyU1vXmWSVCrL/QG1B337LcN4oi1FQjU+V6RayoOW/
        GKwTh6RXECnaUN+1WqnYuTNXCXG7xKYe0OPL+ZiCyzig3uXoPbIr+yddHR+VsOgr4IwfPp
        BT+BdBqh3sq1dxhsb3om3KmrzpgR3W4uPEoRvDLFTHqsM81GID55zsIyNyYgm5gc3Dmxs8
        krZHxZsVtH5i4ODKchcu2PDTQiDNraysieaDDlSQz8Xg80RIxCw0b+CwN5if3j/M8coJmg
        KYM+TtKooSH80iHhlCz+jnLYAMFVtEp4mfjfHARe3u2c87f71ZnhYDpqXM9jZQ==
Date:   Mon, 24 Oct 2022 10:19:28 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Message-ID: <20221024101928.351ae15f@xps-13>
In-Reply-To: <a46c6a18-903d-2120-4876-509ce8ad19d5@linaro.org>
References: <20221021194552.683-1-vadym.kochan@plvision.eu>
        <20221021194552.683-2-vadym.kochan@plvision.eu>
        <a46c6a18-903d-2120-4876-509ce8ad19d5@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

krzysztof.kozlowski@linaro.org wrote on Sat, 22 Oct 2022 12:18:49 -0400:

> On 21/10/2022 15:45, Vadym Kochan wrote:
> > Switch the DT binding to a YAML schema to enable the DT validation.
> >=20
> > Dropped deprecated compatibles and properties described in txt file.
> >=20
> > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > ---
> >  .../bindings/mtd/marvell,nand-controller.yaml | 199 ++++++++++++++++++
> >  .../devicetree/bindings/mtd/marvell-nand.txt  | 126 -----------
> >  2 files changed, 199 insertions(+), 126 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-=
controller.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.=
txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-control=
ler.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.ya=
ml
> > new file mode 100644
> > index 000000000000..535b7f8903c8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> > @@ -0,0 +1,199 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/marvell,nand-controller.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Marvell NAND Flash Controller (NFC)
> > +
> > +maintainers:
> > +  - Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> This should be someone responsible for hardware, not subsystem
> maintainer. Unless by coincidence Miquel matches both. :)

Haha, actually I do because I rewrote this driver entirely few years
ago. I don't actively maintain these platforms anymore but I don't mind
being assigned here if nobody else cares. Otherwise indeed, Vadym
or someone else from Marvell can take over, I don't mind.

Thanks,
Miqu=C3=A8l
