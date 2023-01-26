Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69E467C150
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjAZAG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjAZAGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:06:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254A24EF6;
        Wed, 25 Jan 2023 16:06:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6209B81C5C;
        Thu, 26 Jan 2023 00:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81720C433D2;
        Thu, 26 Jan 2023 00:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674691611;
        bh=krGfb8fiMTnJ3sWgLJgyhtCwXwLorPNgOSjdWwe2A/s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=h6QhUV7yMXcKEik2CDp7OhaOoMu7vZMsxJ57WryGF1FsClUzPyaRYA3Fw/Kh4s+LS
         iLFr0KJAd/s3gERKN8oC0qaZplEzykPqmm9tTYblzXlUV0a3uVdbue8L8DXr+puJsY
         PYejVuWqkw1HXoyj1lxDGgm/nmJPyZJaF7yeDA76HH9CBFB2QdtbclqJDra/YmH3Iu
         rE4AzAT6OZOPy3egSvfBBa7RI7A9aoOPcuTrV5KSoLM08Ung9/0bjvJNXCelJKpbTa
         O2vZOR5NvnLCY5T8C4Yi00oa56M+J21Smryn8nePVrQOQNmRu8xvB4aSjPVgM78M/D
         LXsEpESw19gVg==
Message-ID: <f324c845f0d291d041a13046a349ae95.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <367fba29-bc08-1f27-249c-09e406adfbbb@ideasonboard.com>
References: <20221226095745.19757-1-a-bhatia1@ti.com> <20221226095745.19757-2-a-bhatia1@ti.com> <8980856c1138571976f00413b94cfeb8.sboyd@kernel.org> <1856e963-4514-92f3-5d43-d5b711083193@ti.com> <367fba29-bc08-1f27-249c-09e406adfbbb@ideasonboard.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: fixed-factor: Add TI AM62 SoC OLDI clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Linux Clock List <linux-clk@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 25 Jan 2023 16:06:49 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tomi Valkeinen (2023-01-17 01:40:24)
> On 16/01/2023 11:51, Aradhya Bhatia wrote:
> > Hi Stephen,
> >=20
> > Thanks for taking a look at the patch.
> >=20
> > On 12-Jan-23 01:14, Stephen Boyd wrote:
> >> Quoting Aradhya Bhatia (2022-12-26 01:57:44)
> >>> Add "ti,k3-am62-oldi-clk-div" to the fixed factor clock compatible en=
um
> >>> list.
> >>>
> >>> "ti,k3-am62-oldi-clk-div" is a fixed-factor clock that helps the TI
> >>> display subsystem request a pixel clock for itself and a corresponding
> >>> serial clock for its OLDI Transmitters. The serial clock is 7 times t=
he
> >>> pixel clock. This clock needs the clock set rate request to be
> >>> propagated to the parent clock provider.
> >>>
> >>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> >>> ---
> >>> =C2=A0 Documentation/devicetree/bindings/clock/fixed-factor-clock.yam=
l | 1 +
> >>> =C2=A0 1 file changed, 1 insertion(+)
> >>>
> >>> diff --git=20
> >>> a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml=20
> >>> b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
> >>> index 8f71ab300470..0696237530f7 100644
> >>> --- a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
> >>> +++ b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
> >>> @@ -14,6 +14,7 @@ properties:
> >>> =C2=A0=C2=A0=C2=A0 compatible:
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum:
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - fixed-factor-clock
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ti,k3-am62-oldi-clk-div
> >>
> >> I don't see this compatible anywhere in the kernel tree. Is there a
> >> patch that adds a node using this? I wonder why the display subsystem
> >> can't add this fixed factor clk directly in the driver. Does the OLDI
> >> Transmitter send a clk to the display subsystem?
> >>
> >> I'm asking all these questions because we got rid of vendor compatibles
> >> here in hopes of simplifying the logic. Maybe the problem can be
> >> approached differently, but I don't know all the details.
> >=20
> >=20
> > +--------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-=
-----------------+
> > |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > |=C2=A0 PLL=C2=A0=C2=A0 +---+----+------------->| OLDI Transmitter |
> > |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > +--------+=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +------------------+
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 |
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +------------------+
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 +------------->| OLDI Transmitter |
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +------------------+
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +------------------+
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 +----------+=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 /7=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Display=C2=A0=C2=A0=C2=A0=C2=A0 |
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 +-->|=C2=A0=C2=A0 Clock=C2=A0 +--->| Sub-System (DSS) |
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 Div=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 +----------+=C2=A0=C2=A0=C2=A0 +---------------=
---+
> >=20
> > This is how the the clock architecture for DSS looks like.
> >=20
> > The clock divider is not a part of DSS, but outside it.

The divider is fixed as well? And presumably inside the SoC?

> >=20
> > The clock request flow is initiated by the DSS driver because it has the
> > required timing parameter information. It requests a certain pixel
> > frequency. But the frequency required by the OLDI TXes is 7 times
> > that pixel frequency.
> >=20
> > (Just for clarification, in some cases, the OLDI TX does require only
> > 3.5 times the pixel frequency, but in those situations there is another
> > divider in-front of OLDI TX that gets activated with a signal and
> > divides the incoming frequency by 2, thereby requiring the PLL to still
> > generate a 7x frequency.)
> >=20
> > Hence, the idea is that the clock divider is able to propagate the set
> > rate request back to PLL, asking for a frequency 7 times more than the
> > DSS's asking rate.

Got it. Can the PLL driver provide a pll_div_7 clk that is used for the
DSS pixel clk?

> >=20
> > If this is something less than ideal and should not go up, then I can
> > implement a new clock device with a separate but similar clock driver.
> >=20
> > Let me know what you think!
>=20
> As a clarification I would also add to the above that on other TI SoCs=20
> with DSS, and also for the second video port on AM62, the clock=20
> framework provides DSS a clock using the pclk frequency.
>=20

Are you saying that adding a fixed div-7 clk in the DSS driver is wrong?
