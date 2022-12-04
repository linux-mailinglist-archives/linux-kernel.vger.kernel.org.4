Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7212641DDE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 17:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiLDQTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 11:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiLDQTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 11:19:08 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4761402A;
        Sun,  4 Dec 2022 08:19:07 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B539ED1ECB;
        Sun,  4 Dec 2022 16:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1670170746; bh=fAcjGRcezqCXZz7nvp/OX/EUfrnnNRg5SKkTKAfw3J8=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=FDv5jDmR6vT1kJOa0OHYeQeWl4wIOEo3zSUO5gLS8hUz6BnTRjIq+VKzk1zhcqzcY
         zQXNa9sCAqOdmwQgvgLpIFudlQzKURuN3RaVxS6ZgVm5zBkXZnJY1SzBwTmqLmbQUp
         1DCHkFp6ADpCMxpahkqahIa5q6AJNM6X3Y39Wj+E=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add configuration for PMI8950 peripheral
Date:   Sun, 04 Dec 2022 17:19:05 +0100
Message-ID: <2656622.mvXUDI8C0e@g550jk>
In-Reply-To: <20221202093658.vg6t2ptar2arh7hn@SoMainline.org>
References: <20221101161801.1058969-1-luca@z3ntu.xyz> <20221106193722.j64xrhitdencrjxy@SoMainline.org> <20221202093658.vg6t2ptar2arh7hn@SoMainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag, 2. Dezember 2022 10:36:58 CET Marijn Suijten wrote:
> On 2022-11-06 20:37:24, Marijn Suijten wrote:
> > On 2022-11-05 00:44:37, Marijn Suijten wrote:
> > > On 2022-11-01 17:18:00, Luca Weiss wrote:
> > > > From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> > > > 
> > > > The PMI8950 features integrated peripherals like ADC, GPIO controller,
> > > > MPPs and others.
> > > > 
> > > > [luca@z3ntu.xyz: remove pm8950, style changes for 2022 standards, add
> > > > wled]
> > > > Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> > > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > > ---
> > > > Changes since v2:
> > > > * Pick up patch, and adjust as mentioned above sign-offs
> > > > 
> > > >  arch/arm64/boot/dts/qcom/pmi8950.dtsi | 97
> > > >  +++++++++++++++++++++++++++
> > > >  1 file changed, 97 insertions(+)
> > > >  create mode 100644 arch/arm64/boot/dts/qcom/pmi8950.dtsi
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/pmi8950.dtsi
> > > > b/arch/arm64/boot/dts/qcom/pmi8950.dtsi new file mode 100644
> > > > index 000000000000..32d27e2187e3
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
> > > > @@ -0,0 +1,97 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +// Copyright (c) 2019, AngeloGioacchino Del Regno <kholk11@gmail.com>
> > > > +
> > > > +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> > > > +#include <dt-bindings/interrupt-controller/irq.h>
> > > > +#include <dt-bindings/spmi/spmi.h>
> > > > +
> > > > +&spmi_bus {
> > > > +	pmic@2 {
> > > > +		compatible = "qcom,pmi8950", "qcom,spmi-pmic";
> > > > +		reg = <0x2 SPMI_USID>;
> > > > +		#address-cells = <1>;
> > > > +		#size-cells = <0>;
> > > > +
> > > > +		pmi8950_vadc: adc@3100 {
> > > > +			compatible = "qcom,spmi-vadc";
> > > > +			reg = <0x3100>;
> > > > +			interrupts = <0x2 0x31 0x0 
IRQ_TYPE_EDGE_RISING>;
> > > > +			#address-cells = <1>;
> > > > +			#size-cells = <0>;
> > > > +			#io-channel-cells = <1>;
> > > > +
> > > > +			adc-chan@0 {
> > > > +				reg = <VADC_USBIN>;
> > > > +				qcom,pre-scaling = <1 4>;
> > > > +				label = "usbin";
> > > 
> > > I've previously sent a patch with labels in the node name instead [1],
> > > what's the preferred way nowadays?
> > > 
> > > [1]:
> > > https://lore.kernel.org/linux-arm-msm/20220926190148.283805-4-marijn.su
> > > ijten@somainline.org/> 
> > As it turns out that patch relied on the ADC5 driver propagating the DT
> > node name (and label name if set) to IIO, which doesn't happen for the
> > legacy VADC driver used here.  I sent an RFC to that effect, with a
> > large discussion whether or not we should use node names, labels, or
> > rely on hardcoded names in the drivers entirely.  The recent migration
> > to fwnode made the node name include the `@xx` suffix which makes for
> > unpleasant reading in sysfs, so that's at least one reason to have
> > generic node names *and skip node names in these drivers altogether*.
> > 
> >     https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.s
> >     uijten@somainline.org/T/#u> 
> > In short: we may want to hold off changing these patches until a
> > clear-cut decision has been made (but I think your patch here is the
> > right approach in the end: generic node name *with label*, when the
> > label is more clear than the name hardcoded in the driver).
> 
> We came to the conclusion in [1] that using labels is the way to go so
> that the name doesn't get all mangled, then we can opt for generic node
> names here as well.  This does mean I'll have to send a followup for [2]
> and have to revise [3] again to use generic node names and labels.

So the way this patch does it is good or does it need changes?

> 
> - Marijn
> 
> [1]:
> https://lore.kernel.org/linux-arm-msm/20221112162719.0ac87998@jic23-huawei/
> [2]:
> https://lore.kernel.org/linux-arm-msm/20220926190148.283805-4-marijn.suijte
> n@somainline.org/ [3]:
> https://lore.kernel.org/linux-arm-msm/20221111120156.48040-10-angelogioacch
> ino.delregno@collabora.com/




