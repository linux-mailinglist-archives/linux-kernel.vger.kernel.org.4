Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CB75BFF23
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIUNsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIUNsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:48:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD637285C;
        Wed, 21 Sep 2022 06:48:13 -0700 (PDT)
Received: from notapiano (unknown [71.190.76.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 98C5D660035D;
        Wed, 21 Sep 2022 14:48:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663768091;
        bh=kHonNTF/Lzlr8aSshRxKzH5rWoJVYD+SKE3V/t0eknU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YhoFbIAxA6bxocnv8A8BbQ2z9aflUs/v/bLdPBGTtbJx6ZWh92NoUz6Hvmt/5CySh
         qv9JK0gbugoCOmDebyFePqygFBJ01yH1JAhiRXb1L0GXahjmozyrX/l8M/ameLEskL
         YRj14SGj1VhfC+occC/FEnzAoBLi6AB8E/DcRvsy8gcFHFpV1rEY2asLRXifO6y8kk
         +1Dpv6ia2erykaS2SCM298Fl8hL+8mOkKLyLnH2ZyAY1VjEcJpAs8RRmh3EwK/RylK
         Mg3CoppufEHx61ro0O3vgMOJhUf11v7SfDC/oRkj5OWGL25jiTUTuvp3u40eWXraNT
         uGIESuRMOTOzw==
Date:   Wed, 21 Sep 2022 09:48:06 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] arm64: dts: mediatek: asurada: Add display regulators
Message-ID: <20220921134806.lbg5meuy4fn6pifm@notapiano>
References: <20220908171153.670762-1-nfraprado@collabora.com>
 <20220908171153.670762-2-nfraprado@collabora.com>
 <ab2027b9-17e8-4fe8-3847-84c54d6f9d58@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab2027b9-17e8-4fe8-3847-84c54d6f9d58@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 09:46:33AM +0200, AngeloGioacchino Del Regno wrote:
> Il 08/09/22 19:11, Nícolas F. R. A. Prado ha scritto:
> > Add the regulators present on the Asurada platform that are used to
> > power the internal and external displays.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > ---
> > 
> >   .../boot/dts/mediatek/mt8192-asurada.dtsi     | 114 ++++++++++++++++++
> >   1 file changed, 114 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > index 4b314435f8fd..1d99e470ea1a 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> 
> ..snip..
> 
> > @@ -56,6 +116,18 @@ pp3300_ldo_z: regulator-3v3-z {
> >   		vin-supply = <&ppvar_sys>;
> >   	};
> 
> Can you please add a comment here advertising that this regulator
> will not only provide power to the MIPI bridge, but *also* to the
> display panel itself?
> 
> This is to make sure that everyone understands what's going on, and
> also that we ourselves don't forget about that.
> 
> Probably something like:
> /* pp3300_mipibrdg also enables pp3300_panel */
> 
> I would then propose to add a "regulator-fixed" that has no GPIO
> but with vin-supply as this one.
> 
> pp3300_panel: regulator-3v3-panel {
> 	compatible = "regulator-fixed";
> 	regulator-name = "pp3300_panel";
> 	regulator-min-microvolt = <3300000>;
> 	regulator-max-microvolt = <3300000>;
> 
> 	vin-supply = <&pp3300_mipibrdg>;
> };
> 
> I would also test assigning this regulator to the panel node, as this
> will make sure to cover future corner cases (think about PM suspend/resume).
> 
> P.S.: If you add the pp3300_panel regulator-fixed with that vin-supply,
>       maybe the proposed comment would become a bit overkill. Your choice!

Hi Angelo,

thanks for the feedback.

I think the current layout makes more sense based on my understanding of the
power routing here: a single power line output by the pp3300_mipibrdg regulator
powers both the ANX chip as well as the panel. So I'm going to keep it the way
it is for now. If there are any other concerns please let me know.

Thanks,
Nícolas

> 
> Cheers,
> Angelo
> 
> > +	pp3300_mipibrdg: regulator-3v3-mipibrdg {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "pp3300_mipibrdg";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pp3300_mipibrdg_en_pins>;
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		enable-active-high;
> > +		regulator-boot-on;
> > +		gpio = <&pio 127 GPIO_ACTIVE_HIGH>;
> > +	};
> > +
> >   	/* separately switched 3.3V power rail */
> >   	pp3300_u: regulator-3v3-u {
> >   		compatible = "regulator-fixed";
> 
