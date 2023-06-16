Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2320E7329B0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243772AbjFPIYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjFPIYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:24:21 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C692212B;
        Fri, 16 Jun 2023 01:24:19 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686903857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6aerGn4H3P3eMP8YIL2/40nqn0c221OfKnuzH6sZ5I=;
        b=AI1+Jxssbgi1lNlikHwHuTVkWIvDNTTTOnmK1Cx0gAo9lZ53N3vz0BDBcqMPoF4wXqYsLv
        ib16iY72MEfN05opc8QJ4TDswItD5JR3yGDNaLwCnJjriMevlPwvqYZPM0a4LjW6dyAl60
        3k5u4v07elNXSrS0RvnlSh/xrD9twtqz913jx5dtaQkgck2TNXcic91zvlXTFnWL199DMz
        45IsNlwrMlFt/lKWXpPLZVICFHGCboW4hm3GkRHDULMRT/6yVFDx+hEaLHfm9Cpifs5Rmi
        79tdL5t5LRALcKKNvSJm5nN/pxrSCLsiM+VaV5U33zSPgZbrVMgWQYInPkDq6w==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 639161C0003;
        Fri, 16 Jun 2023 08:24:15 +0000 (UTC)
Date:   Fri, 16 Jun 2023 10:24:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v9 3/3] dt-bindings: mtd: marvell-nand: Convert to YAML
 DT scheme
Message-ID: <20230616102414.222dde21@xps-13>
In-Reply-To: <781c1db2-ecca-901a-4e11-7f7c68cf744d@linaro.org>
References: <20230615040447.3484564-1-chris.packham@alliedtelesis.co.nz>
        <20230615040447.3484564-4-chris.packham@alliedtelesis.co.nz>
        <f16e742f-e6f2-9761-e70d-e0e7cadcba4a@linaro.org>
        <1863cd53-9846-def2-ee5f-f4a51160ed8d@alliedtelesis.co.nz>
        <781c1db2-ecca-901a-4e11-7f7c68cf744d@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

krzysztof.kozlowski@linaro.org wrote on Fri, 16 Jun 2023 10:15:31 +0200:

> On 15/06/2023 23:06, Chris Packham wrote:
> >> =20
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    oneOf:
> >>> +      - items:
> >>> +          - const: marvell,armada-8k-nand-controller
> >>> +          - const: marvell,armada370-nand-controller
> >>> +      - enum:
> >>> +          - marvell,armada-8k-nand-controller =20
> >> This is wrong. 8k cannot be both: compatible and not compatible with
> >> 370. It's not someone's cat to be in both states at the same time... =
=20
> >=20
> > The correct state (IMHO, Miquel correct me if I'm wrong) is `compatible=
=20
> > =3D "marvell,armada-8k-nand-controller";`=C2=A0 as there are some 8K sp=
ecific=20
> > requirements that aren't present on the 370 (specifically the=20
> > system-controller and the 2nd clock).  =20
>=20
> Presence of specific requirements does not invalidate compatibility. Two
> devices are compatible if the 8k can bind and work with 370 compatible
> string, even if this means some lower performance or less features (e.g.
> subset of features).

Quoting myself from 2019 (comment in the driver):
"Some SoCs like A7k/A8k need to enable manually the NAND controller,
gated clocks and reset bits to avoid being bootloader dependent."

So can the 8k controller work using a 370 compatible : yes, if the
booloader enabled the NAND controller already, no otherwise. But in
practice it is the same controller.

Given this information I don't know whether it makes sense to qualify
the 8k controller compatible with the 370 compatible or not.

> Now whether they are really compatible or not - I don't know. I expect
> the answer from you (as plural you).

:-)

> > The only reason `compatible =3D=20
> > "marvell,armada-8k-nand-controller",=20
> > "marvell,armada370-nand-controller";` is supported is because that is=20
> > what is in use in the existing dtses. =20
>=20
> Fix the DTS, use here the correct combination and, if it is a deviation
> from old binding, mention this in commit msg.

Fine by me.
=20
> Best regards,
> Krzysztof
>=20


Thanks,
Miqu=C3=A8l
