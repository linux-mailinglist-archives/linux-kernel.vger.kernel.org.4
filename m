Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B456B0BCE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjCHOr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjCHOrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:47:21 -0500
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D184391E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:46:17 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWw9g5X3gzMq8N7;
        Wed,  8 Mar 2023 15:46:15 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWw9g1TDZz27Pg;
        Wed,  8 Mar 2023 15:46:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678286775;
        bh=RENAi+ybMJ8tUOfFVqQd6nnRipwF0Lfvzf9JLGAOVfY=;
        h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
        b=IG0EaYQhwXLz6LkOWDgjDn3X/qiF0Poed2azxrcdrf0dkvPQWXDs9FnHGC0N0jAdJ
         V4mNo+2DRzixFFVE9OjkjbV4Wwsmq/9Hx6bICMDy9V5WGfEdE6Yq5T1knFKMvFZx/p
         rUQpgfzAgOLkComPpolHHrJrQQ+iqSLzF5OVJCsc=
Message-ID: <c04616d7c48d76022b24a184a3a7f0e80e037576.camel@pschenker.ch>
Subject: Re: [PATCH v1 17/25] arm64: dts: colibri-imx8x: eval: Add spi-to-can
From:   Philippe Schenker <dev@pschenker.ch>
Reply-To: dev@pschenker.ch
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 08 Mar 2023 15:46:15 +0100
In-Reply-To: <1a837bec-8658-3200-edff-76809de3fae6@linaro.org>
References: <20230308125300.58244-1-dev@pschenker.ch>
         <20230308125300.58244-18-dev@pschenker.ch>
         <07e64710-6b91-9da6-f483-03706b7ea95a@linaro.org>
         <3730a506119804b5740854c74d1558010ce37b47.camel@pschenker.ch>
         <1a837bec-8658-3200-edff-76809de3fae6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-03-08 at 15:34 +0100, Krzysztof Kozlowski wrote:
> On 08/03/2023 14:43, Philippe Schenker wrote:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mcp2515: can@0 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "microchip,mcp2515";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0reg =3D <0>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0interrupt-parent =3D <&lsio_gpio3>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0interrupts =3D <13 IRQ_TYPE_EDGE_FALLING>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0pinctrl-0 =3D <&pinctrl_can_int>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0pinctrl-names =3D "default";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0clocks =3D <&clk16m>;
> > >=20
> > > You just sorted all nodes in previous patches and add something
> > > unsorted? What is then the style of order? Random name?
> >=20
> > My logic behind this one is
> >=20
> > 1. compatible property
> > 2. reg property
> > 3. standard properties=20
> > =C2=A0=C2=A0 - first interrupt
> > =C2=A0=C2=A0 - then pinctrl
> > 4. specific properties
> > =C2=A0=C2=A0 - again alphabetically: clocks, spi-max-frequency
>=20
> clocks and spi-max-frequency are standard properties.
>=20
> BTW, what is a specific property?

I mean specific to this driver. With standard properties I mean those
you can add everywhere like pinctrl, interrupts etc. But then yes I
agree you can pretty quickly start to argue...

Would in this particular case something like


	mcp2515: can@0 {
		compatible =3D "microchip,mcp2515";
		reg =3D <0>;
		pinctrl-0 =3D <&pinctrl_can_int>;
		pinctrl-names =3D "default";
		clocks =3D <&clk16m>;
		interrupt-parent =3D <&lsio_gpio3>;
		interrupts =3D <13 IRQ_TYPE_EDGE_FALLING>;
		spi-max-frequency =3D <10000000>;
	};

be better?


>=20
> Best regards,
> Krzysztof
>=20

