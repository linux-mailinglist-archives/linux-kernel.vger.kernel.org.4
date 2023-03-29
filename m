Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0416D6CCFE6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjC2CTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjC2CTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:19:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C693273E;
        Tue, 28 Mar 2023 19:19:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4B4AB81F94;
        Wed, 29 Mar 2023 02:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B26C433EF;
        Wed, 29 Mar 2023 02:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680056352;
        bh=FtQpj8iEUziXDo/mDSXE7qrZrcIgPVB/uYotZNpI5nk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=R0S/WePl5v3awL048+lqF2jzLgWIJv68pBHoA5Lu31hd1ugG/tKGd8ucFVR2frUMw
         1uPmbTod+B8vkN1b/7eInyZOnVMyHi6d2b+nhuz/8QQGxlyVJaT5DZZ0h0n24C3lcM
         Q+uK43vAcSFenqhla0qjJpP5m1ezRNqaW9VDCEwXYwjGKbsejHX63GGT9oD1Cc+8iZ
         x3M/umenURW9kvh4qsoyGC3ubIH2VJoDwfpW15r2D4AMeWpOmNZ0435dXUEllCvh+5
         UH1Li/aL9AaxOCMVuA4X+A2N0/0PXbn4NwTAdUg9/Z08GEyWPsBH1+WlP2qxyanyGt
         kkJ2m3VCMpCmw==
Message-ID: <c37e1f3a40c404acd81c2c9d5b28b340.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b7977069-4f82-76a1-10c1-b6400862c2c4@gmail.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com> <20230328021912.177301-9-ychuang570808@gmail.com> <ab4e0bc8834b7e618e9a88ea6a1c30cc.sboyd@kernel.org> <b7977069-4f82-76a1-10c1-b6400862c2c4@gmail.com>
Subject: Re: [PATCH v6 08/12] arm64: dts: nuvoton: Add initial ma35d1 device tree
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
To:     Jacky Huang <ychuang570808@gmail.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Date:   Tue, 28 Mar 2023 19:19:10 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jacky Huang (2023-03-28 19:03:24)
> On 2023/3/29 =E4=B8=8A=E5=8D=88 01:57, Stephen Boyd wrote:
> > Quoting Jacky Huang (2023-03-27 19:19:08)
> >> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot=
/dts/nuvoton/ma35d1.dtsi
> >> new file mode 100644
> >> index 000000000000..0740b0b218a7
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
> >> @@ -0,0 +1,231 @@
[...]
> >> +
> >> +               L2_0: l2-cache0 {
> > Just l2-cache for the node name. Doesn't it go under the cpu0 node as
> > well?
>=20
> This describes the level-2 cache which is external to and shared by cpu0 =

> & cpu1.
> And only level-1 cache is inside of CPU core.
> L2_0 is must, because both cpu0 and cpu1 has a next-level-cache =3D=20
> <&L2_0> property.

Ok. The name should just be l2-cache then, not l2-cache0.

>=20
> Many identical example of l2-cache node can be found in arm64 dts, such=20
> as k3-arm642.dtsi,
> rk3328.dtsi, mt8195.dtsi, etc. Here is just a copy of similar arm64=20
> multi-core SoCs.
>=20
> So we would like to keep this unchanged. Is it OK for you? Thanks.
>=20

Mostly ok, yes.

>=20
> >> +
> >> +       sys: system-management@40460000 {
> >> +               compatible =3D "nuvoton,ma35d1-sys", "syscon", "simple=
-mfd";
> >> +               reg =3D <0x0 0x40460000 0x0 0x200>;
> >> +
> >> +               reset: reset-controller {
> >> +                       compatible =3D "nuvoton,ma35d1-reset";
> >> +                       #reset-cells =3D <1>;
> >> +               };
> >> +       };
> >> +
> >> +       clk: clock-controller@40460200 {
> >> +               compatible =3D "nuvoton,ma35d1-clk", "syscon";
> >> +               reg =3D <0x00000000 0x40460200 0x0 0x100>;
> >> +               #clock-cells =3D <1>;
> >> +               clocks =3D <&clk_hxt>;
> >> +               nuvoton,sys =3D <&sys>;
> >> +       };
> > It looks like the device at 40460000 is a reset and clock controller.
> > Just make it one node and register the clk or reset device as an
> > auxiliary device.
>=20
> 40460000 is for system control registers, including power contrl,=20
> multifunction pin control,
> usb phy control, IP reset control, power-on setting information, and=20
> many other miscellaneous controls.
> The registers of reset controller is only a subset of system control=20
> registers.
>=20
> 40460200 is for clock controller which is independent of the system=20
> control integration
> The register base of clock controller is very close to system=20
> controller, but in fact the two are independent.

What do you use the syscon for then? The clock driver must want to use
the syscon for something, implying that they are the same device.
