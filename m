Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09368611693
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJ1P6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiJ1P5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:57:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003D1214679;
        Fri, 28 Oct 2022 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1666972632;
        bh=nRKXV0qvwDL9I8bHXNjzoNeda8BPvLXBGzFqDz1CBK0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=rbdqX0YrRDhoPFb7Rzty7m/2TwVTiEmuqegCUaWnjajspXIGzxAqR0sBNVTklGYp/
         seNtpuvwXZsVLeaGkIHFEeqA27n9KL8Lpd6go9uD8nniqtb3wEMfvqtG+MZXFwZoBx
         5qAoNbX1TtepJS/NSA1oFOInNc+xeVloVGeuWdQUXIg2liPBUjiytR8lRxs/k3OfNh
         HqecD3mbYI7rN89yQE1oAvVby1zVDfkdkgK6bwMqURn6llgTuCzdgLpnTPN7jG5++M
         ww+ta3SZXtWw/WtyPTsDA4PIXm3qRs9Se6CrdIsJvdliHUx6au7Roha8xYhk2XPZ+f
         eMUbXULfOVYaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.151.20] ([217.61.151.20]) by web-mail.gmx.net
 (3c-app-gmx-bs17.server.lan [172.19.170.69]) (via HTTP); Fri, 28 Oct 2022
 17:57:12 +0200
MIME-Version: 1.0
Message-ID: <trinity-6e94e8e9-4b31-4d93-ac21-f51aee3b790a-1666972632153@3c-app-gmx-bs17>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     "Frank Wunderlich (linux)" <linux@fw-web.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, Felix Fietkau <nbd@nbd.name>
Subject: Aw: Re: [RFC v2 7/7] arm64: dts: mt7986: add Bananapi R3
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Oct 2022 17:57:12 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <Y1vd9+q2PzG5DIKa@makrotopia.org>
References: <20221026093650.110290-1-linux@fw-web.de>
 <20221026093650.110290-8-linux@fw-web.de>
 <64daf96b-b2b5-6f02-91aa-58d19083ee01@collabora.com>
 <a97aa98a6230e7f33a6b5f5e2c9e54ce@fw-web.de>
 <Y1vd9+q2PzG5DIKa@makrotopia.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:2Jf5uCm93TCrRRVMUpsdNxtQIL/d0QsSjHv7fNClGY/TTCHAn9Z0DqfxZ2UnKkGFaRMbG
 m/W0B1uIQqbknKQHn8cnuQ1KJAUggdcFYIo6FlnjkelLLU38iBMHEtuby6EEklxe94weXDWyj91Q
 68/ZaLszOjo5pAScv4TowYn4zT6gBhVehcUUZePjdhFVFAW4qYe4c+gUBaJUNGiVp1Xg8AkrKCz4
 z5i3HTCKoGF99/aY/WMNmvKXbdk47WSPj2RZnl2SDJkzjVfo2ZRtOGrT0EzZ9heO/mwME/v3NQ+l
 p0=
UI-OutboundReport: notjunk:1;M01:P0:YkrS8YEqMno=;IIodNu81S8JdrNW4QABw2sg5KjV
 dhBUui4yBhUJI/hH9bhssPgbGD0f/g0lhJQ52kEM9aHpCf4QJTyW/S38L7hWdc8tVdQRYLwEx
 sYgoKRXtiuXRnclg/8jTwYGjGWmdxQKmmOEOwXSWv9URD/95gTUPz0ecsbtgCHV8pd1AJVx98
 b2BMoTFddpvEqFfEyIUs2V0waGT/C4xD5I5F/fogsrAXw5Dll6K6Vz3cdE9FrvcPljfdc2PjM
 ZuqMNjVh+OzdlYs35NcgDTa4qm5VR4S9A2HPhXLz5couWxDpJiQVATrX8L9rx9gyBNLOEshN/
 1/uecBn+t2oPJTOGqXHM2mmajoc4IAiee7J5PsL8PRH9+4Zd9XmA17+Me0NSza1iIkdlpQ03j
 XlDgf/V7AE0BOmq7Vw7vniEiZ/UnKGvWjkWGoQwd8TJIiB0dlcKit0j5oasb34314goa7exof
 j+MMxrxzgNEoEwcQICMvAROfrQkvqzkSTDs4+poz5lPMAYWLtpmYdCBMUBjtmA7YA6oM0iuZe
 xYxuD+EJREfASLq+paHx66VKQf7J2+UbvFGvv8dW86pmz6CNrKraslXIjT8t/T3mwEMolPe8t
 N7W0mn5lZm48ss+rAS8nDOgvqvtd3ge8mRuzieq8Xgx2QA5FJpFotKB9KOuoPweGONVxltcri
 oLEahQpfCt7NSFl7FPDhe8s64zsgy3y1N2Ngzmk9WLHbAunS9X7LJO++JBgk1raf3AtCMWKi4
 oxOH7rR5Yhc6WHthsorbIMCPODY/7tIM+m9cYtx5HebgoFOrNBHEHf/WbQd1cgF+Om2+PPrXn
 3GgqxKTXG194m5iWYYhUT0MQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
> Gesendet: Freitag, 28. Oktober 2022 um 15:49 Uhr
> Von: "Daniel Golle" <daniel@makrotopia.org>

> On Fri, Oct 28, 2022 at 12:57:44PM +0200, Frank Wunderlich (linux) wrote=
:
> > Am 2022-10-28 11:19, schrieb AngeloGioacchino Del Regno:
> > > Il 26/10/22 11:36, Frank Wunderlich ha scritto:
> > > > From: Frank Wunderlich <frank-w@public-files.de>

> You could also use device tree overlays to select SDMMC or eMMC just
> like for the NOR vs. NAND choice on this board.

i recently found a way to compile dtbo via kernel compile-tools

https://github.com/frank-w/BPI-R2-4.14/commit/8a0d96d0932e71dd226b4cca641d=
cc097b23247c

is this the right way?

imho adding the mmc-node in base dts is better than getting device to boot=
 only
with at least one overlay.

> > > > +		factory-key {
> > >
> > > I'd say that this is not "factory-key" but "reset-key"?
> >
> > okay i rename it.
> >
> > > > +			label =3D "reset";
> > > > +			linux,code =3D <KEY_RESTART>;
> > > > +			gpios =3D <&pio 9 GPIO_ACTIVE_LOW>;
>
> At least on my V1.0 board and reportedly also on V1.1 boards the RST
> button doesn't work. As soon as a NVME/M.2 module is inserted this
> also connects the GPIO just like if the button was pressed all the
> time. This issue has also been discussed in BananaPi forums.

maybe drop it for now till we can test it?

> > > > +	mmc0_pins_default: mmc0-pins {
> > > > +		mux {
> > > > +			function =3D "emmc";
> > > > +			groups =3D "emmc_51";
> > > > +		};
> > > > +		conf-cmd-dat {
> > > > +			pins =3D "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
> > > > +			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
> > > > +			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
> > > > +			input-enable;
> > > > +			drive-strength =3D <4>;
> > > > +			mediatek,pull-up-adv =3D <1>;	/* pull-up 10K */
> > >
> > > Can we please stop using these custom pull-{up,down}-adv properties?
> > > Check what was done on pinctrl-mt8192.c (and dt schema) for more
> > > information
> > > and examples.

as far as i see it defines array mt8192_pull_type with multiple MTK_PULL_P=
U_PD_TYPE / MTK_PULL_PUPD_R1R0_TYPE / MTK_PULL_PU_PD_RSEL_TYPE, but have n=
ot yet found out how it is working (array only put into mt8192_data.pull_t=
ype, no usage of this memeber, see no reference in mt8192.dtsi).

maybe with the

bias-pull-up =3D <MTK_PULL_SET_RSEL_011>;

in arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi is pointing to this ar=
ray?

> > need to check these with MTK.
> >
> > > > +		};
> > > > +		conf-clk {

> > > > +&wifi {
> > > > +	status =3D "okay";
> > > > +	pinctrl-names =3D "default", "dbdc";
> > > > +	pinctrl-0 =3D <&wf_2g_5g_pins>, <&wf_led_pins>;
> > > > +	pinctrl-1 =3D <&wf_dbdc_pins>, <&wf_led_pins>;
> > > > +
> > > > +	mediatek,eeprom-data =3D <0x86790900 0xc4326 0x60000000 0x00 0x0=
0
> > > > 0x00 0x00 0x00
> > >
> > > Ouch! This looks like firmware unrolled in a devicetree property - t=
hat
> > > can't
> > > be right.
> > >
> > > Please dump that in a binary file and load it as firmware from
> > > userspace.
> >
> > it uses the mt76 driver and here eeprom can only be loaded from
> > mtd-partition or from device tree. Previous attempts loading eeprom da=
ta
> > from userspace file (like it's done for "normal" firmware) were reject=
ed.
>
> Note that strictly speaking this is not firmware but rather calibration
> data (ie. board-specific configuration, not code).
>
> In case you don't like the large amount of data in the DTS file, you
> can use the /incbin/ statement to include it from a file instead.

but this file needs to be inside the kernels tree to get the dts compiled.
As this is basicly a blob (and firmware is stored outside) this is tricky.

> As there is no physical EEPROM nor calibration data stored anywhere in
> he flash there is no easy way the driver could request a board-specific
> filename, unlike e.g. ath10k requesting BDF from userspace.
> In the past (e.g. out-of-tree patches for rt2x00 driver allowing it's
> use on Rt305x WiSoC) this lack of a board-specific filename has lead to
> people treating the file just like a generic firmware file: ignoring
> the board-specific nature of calibration data and just copying it from
> another board... As a work-around to prevent that, we could at least
> embed the filename in the dts or hack the driver to request a filename
> based on the top level 'compatible' string of the board's device tree.
>
> I've added Felix to Cc: as he suggested that solution back then.

maybe i should drop it for now to get basic support of the board without w=
ifi till this is solved?

or adding wifi without the eeprom-data property and add firmware (file or =
directly like now) in my
own repo, but this needs to be done in every sourcebase as mainline is the=
n non-functional.

regards Frank
