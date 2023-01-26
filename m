Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965B467D69A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjAZUmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjAZUmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:42:04 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B997AB0;
        Thu, 26 Jan 2023 12:42:01 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 2321CCB452;
        Thu, 26 Jan 2023 20:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1674765719; bh=m+AyRkpU35PI1/KK7hJz1VYCQdwvbwm4TM5BZi0YkKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fkgTKbVsA5M4qFr25+D09azhzbUKoiPxHsuTvfCIoyc2q1D7DW5QpVXyswaM5f0q0
         Xtc3y0opFRlUxed8Jr4pHo5OM6caQavk5ROBAx0ofGPJMK+9bhZ1IF3AckUDuJBTV0
         Ww2/MqtwCS62j1NSJ8oYLhhy3YLhRs0/i7yzSaCc=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ARM: dts: qcom: msm8974-oneplus-bacon: Add notification LED
Date:   Thu, 26 Jan 2023 21:41:58 +0100
Message-ID: <1840339.tdWV9SEqCh@g550jk>
In-Reply-To: <dbfa802a-968f-0504-a131-59e2a8f52c9f@linaro.org>
References: <20230122-msm8974-bacon-features-v1-0-4049f565c24c@z3ntu.xyz>
 <4455893.LvFx2qVVIh@g550jk> <dbfa802a-968f-0504-a131-59e2a8f52c9f@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FROM_SUSPICIOUS_NTLD,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 26. J=E4nner 2023 10:41:24 CET Krzysztof Kozlowski wrote:
> On 25/01/2023 21:51, Luca Weiss wrote:
> > On Montag, 23. J=E4nner 2023 18:18:16 CET Krzysztof Kozlowski wrote:
> >> On 22/01/2023 17:48, Luca Weiss wrote:
> >>> Add the node describing the sn3193 that's used to provide notification
> >>> LED.
> >>>=20
> >>> Unfortunately the driver currently supports neither multicolor API nor
> >>> using the properties function & color, so we use label instead.
> >>>=20
> >>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> >>> ---
> >>>=20
> >>>  .../arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts | 28
> >>>  ++++++++++++++++++++++ 1 file changed, 28 insertions(+)
> >>>=20
> >>> diff --git a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
> >>> b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts index
> >>> ffb486ceb6a6..a672c45d7070 100644
> >>> --- a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
> >>> +++ b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
> >>> @@ -114,6 +114,34 @@ led@0 {
> >>>=20
> >>>  			default-brightness =3D <80>;
> >>>  	=09
> >>>  		};
> >>>  =09
> >>>  	};
> >>>=20
> >>> +
> >>> +	led-controller@68 {
> >>> +		compatible =3D "si-en,sn3193";
> >>> +		reg =3D <0x68>;
> >>> +
> >>> +		shutdown-gpios =3D <&tlmm 45 GPIO_ACTIVE_HIGH>;
> >>> +
> >>> +		#address-cells =3D <1>;
> >>> +		#size-cells =3D <0>;
> >>> +
> >>> +		led@1 {
> >>> +			reg =3D <1>;
> >>> +			label =3D "red:status";
> >>=20
> >> These should be colors and functions.
> >=20
> > Hi Krzysztof,
> >=20
> > please check the commit message for this. I tried using it but it didn't
> > work, the driver in general might need an overhaul at some point...
> >=20
> >> Unfortunately the driver currently supports neither multicolor API nor
> >> using the properties function & color, so we use label instead.
> >=20
> > Or maybe I messed up but pretty sure this was the case when I wrote the
> > dts.
> I don't understand how driver is related here - it's not the driver's
> property, but LED core. If the driver "supports" label, then it supports
> color and status.

The leds-is31fl319x.c driver uses devm_led_classdev_register but the functi=
on=20
where 'function' and 'color' is parsed is led_parse_fwnode_props which is=20
called from led_compose_name which is called from led_classdev_register_ext=
=20
(or with the devm_ prefix), and not called from the register method without=
=20
_ext suffix.

So in other words, the led driver would need changes to use the new=20
registration API to be able to use 'function' and 'color' instead of 'label=
'.

Regards
Luca

>=20
> Best regards,
> Krzysztof




