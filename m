Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7560067BD63
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbjAYUv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbjAYUvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:51:55 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD8F4C16;
        Wed, 25 Jan 2023 12:51:54 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 735C1CD52B;
        Wed, 25 Jan 2023 20:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1674679882; bh=zyYeu0H+dDft3MxWwUV/3yLkJL0OcVfUcMzYpR4kdUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=H7Kaox9TbDxekWdwpukOzR4VRM9hZfaEiZu+n6SKIYJge5kTQYu0WNd1L+CeMeqxe
         ukwvsMs7+U8l/xMrx12gXchU58bdKho2Jk6wsUiNaFiavXDiHy3XR9G6u3w5qieNKT
         MhywND3/TApyl6t4411x+cdR+IdgMWy3tvY6W9wQ=
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
Date:   Wed, 25 Jan 2023 21:51:21 +0100
Message-ID: <4455893.LvFx2qVVIh@g550jk>
In-Reply-To: <02e5bf79-3e2d-02c8-67e7-61bbff32ba29@linaro.org>
References: <20230122-msm8974-bacon-features-v1-0-4049f565c24c@z3ntu.xyz>
 <20230122-msm8974-bacon-features-v1-5-4049f565c24c@z3ntu.xyz>
 <02e5bf79-3e2d-02c8-67e7-61bbff32ba29@linaro.org>
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

On Montag, 23. J=E4nner 2023 18:18:16 CET Krzysztof Kozlowski wrote:
> On 22/01/2023 17:48, Luca Weiss wrote:
> > Add the node describing the sn3193 that's used to provide notification
> > LED.
> >=20
> > Unfortunately the driver currently supports neither multicolor API nor
> > using the properties function & color, so we use label instead.
> >=20
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> >=20
> >  .../arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts | 28
> >  ++++++++++++++++++++++ 1 file changed, 28 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
> > b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts index
> > ffb486ceb6a6..a672c45d7070 100644
> > --- a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
> > +++ b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
> > @@ -114,6 +114,34 @@ led@0 {
> >=20
> >  			default-brightness =3D <80>;
> >  	=09
> >  		};
> >  =09
> >  	};
> >=20
> > +
> > +	led-controller@68 {
> > +		compatible =3D "si-en,sn3193";
> > +		reg =3D <0x68>;
> > +
> > +		shutdown-gpios =3D <&tlmm 45 GPIO_ACTIVE_HIGH>;
> > +
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		led@1 {
> > +			reg =3D <1>;
> > +			label =3D "red:status";
>=20
> These should be colors and functions.

Hi Krzysztof,

please check the commit message for this. I tried using it but it didn't wo=
rk,=20
the driver in general might need an overhaul at some point...

> Unfortunately the driver currently supports neither multicolor API nor
> using the properties function & color, so we use label instead.

Or maybe I messed up but pretty sure this was the case when I wrote the dts.

Regards
Luca

>=20
>=20
> Best regards,
> Krzysztof




