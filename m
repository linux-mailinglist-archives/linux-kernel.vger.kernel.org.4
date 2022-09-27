Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8270B5ECF2A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiI0VNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiI0VNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:13:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919391E0C63;
        Tue, 27 Sep 2022 14:13:44 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4C047660226A;
        Tue, 27 Sep 2022 22:13:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664313222;
        bh=9UjteKLPOSGyctNC2dvGb5oVbZ353r1Xwokh8mtTLmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BM2zDwDf7dEv8qNZAEb1RcaW5UUki18dIfL+WFvu58dzl2CZ0RAmHCI6zB5v7y4t/
         LxCfCgQwAqRdbqPGuS0rvjwnuTpzPBAmO3oHnHwg0EUUxHjsZ+GWlHVpm/8k+Q1Ek3
         y5hIyNvmYqtYtuGrq+WlCcLKgZ+o3aIGLoi4sRrAFy6H7KWSJchsNRh1pk1e2+90yI
         /0vqob9x1hqy7o/HbYhHNUA+/+7TCSQe3nM1vN9Qx0ZPySD6al3IG4G0UZMlhRB6OA
         93COQYze9ls7VVoqfUK6YcQNT4seFvz3T7V0aKycI/+KWqdQL2V1TqqdLCBQDGx2gF
         kX8hCsHuHk8Hw==
Date:   Tue, 27 Sep 2022 17:13:37 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] arm64: dts: mediatek: asurada: Add display regulators
Message-ID: <20220927211337.idgcuawo7xsiexah@notapiano>
References: <20220908171153.670762-1-nfraprado@collabora.com>
 <20220908171153.670762-2-nfraprado@collabora.com>
 <CAGXv+5FErSBT-t6vz_2naApuPoC4PympWft-9Gd_MMPUTN+CsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5FErSBT-t6vz_2naApuPoC4PympWft-9Gd_MMPUTN+CsQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

thank you for the insights on the power supply hierarchy. Just a couple further
questions below.

On Wed, Sep 21, 2022 at 10:20:43PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Fri, Sep 9, 2022 at 1:12 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > Add the regulators present on the Asurada platform that are used to
> > power the internal and external displays.
> >
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> >
> > ---
> >
> >  .../boot/dts/mediatek/mt8192-asurada.dtsi     | 114 ++++++++++++++++++
> >  1 file changed, 114 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > index 4b314435f8fd..1d99e470ea1a 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > @@ -23,6 +23,42 @@ memory@40000000 {
> >                 reg = <0 0x40000000 0 0x80000000>;
> >         };
> >
> > +       pp1000_dpbrdg: regulator-1v0-dpbrdg {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "pp1000_dpbrdg";
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pp1000_dpbrdg_en_pins>;
> > +               regulator-min-microvolt = <1000000>;
> > +               regulator-max-microvolt = <1000000>;
> 
> This is fed by a rail called PP1350_VS2, which is from the MT6359 PMIC.
> And this regulator is a proper LDO.

So, we should have an additional regulator node here called pp1350_vs2 which
will feed into pp1000_dpbrdg and that is itself fed in from mt6359_vs2_buck_reg
(from mt6359.dtsi). Is that right?

Also, is PP1350_VS2 just a simple switch or an LDO?

> 
[..]
> > +       pp1800_dpbrdg: regulator-1v8-dpbrdg {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "pp1800_dpbrdg";
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pp1800_dpbrdg_en_pins>;
> > +               regulator-min-microvolt = <1800000>;
> > +               regulator-max-microvolt = <1800000>;
> 
> This regulator is only a power switch. Please drop the min/max properties.
> This is fed by a rail called PP1800_VIO18_U, which is from an LDO on the
> MT6359 PMIC.

Similarly, we should have a pp1800_vio18_u node that is fed in by
mt6359_vio18_ldo_reg, right? And is it a switch or an LDO?

Thanks,
Nícolas

> 
> > +               enable-active-high;
> > +               regulator-boot-on;
> > +               gpio = <&pio 126 GPIO_ACTIVE_HIGH>;
> > +       };
> > +
[..]
