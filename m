Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A7861E594
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 20:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiKFTh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 14:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiKFTh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 14:37:26 -0500
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95972E02C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 11:37:25 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id CB7411F4F6;
        Sun,  6 Nov 2022 20:37:23 +0100 (CET)
Date:   Sun, 6 Nov 2022 20:37:22 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add configuration for PMI8950
 peripheral
Message-ID: <20221106193722.j64xrhitdencrjxy@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221101161801.1058969-1-luca@z3ntu.xyz>
 <20221101161801.1058969-2-luca@z3ntu.xyz>
 <20221104234435.xwjpwfxs73puvfca@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104234435.xwjpwfxs73puvfca@SoMainline.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-05 00:44:37, Marijn Suijten wrote:
> On 2022-11-01 17:18:00, Luca Weiss wrote:
> > From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> > 
> > The PMI8950 features integrated peripherals like ADC, GPIO controller,
> > MPPs and others.
> > 
> > [luca@z3ntu.xyz: remove pm8950, style changes for 2022 standards, add wled]
> > Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > Changes since v2:
> > * Pick up patch, and adjust as mentioned above sign-offs
> > 
> >  arch/arm64/boot/dts/qcom/pmi8950.dtsi | 97 +++++++++++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/pmi8950.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/pmi8950.dtsi b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
> > new file mode 100644
> > index 000000000000..32d27e2187e3
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
> > @@ -0,0 +1,97 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2019, AngeloGioacchino Del Regno <kholk11@gmail.com>
> > +
> > +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/spmi/spmi.h>
> > +
> > +&spmi_bus {
> > +	pmic@2 {
> > +		compatible = "qcom,pmi8950", "qcom,spmi-pmic";
> > +		reg = <0x2 SPMI_USID>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		pmi8950_vadc: adc@3100 {
> > +			compatible = "qcom,spmi-vadc";
> > +			reg = <0x3100>;
> > +			interrupts = <0x2 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			#io-channel-cells = <1>;
> > +
> > +			adc-chan@0 {
> > +				reg = <VADC_USBIN>;
> > +				qcom,pre-scaling = <1 4>;
> > +				label = "usbin";
> 
> I've previously sent a patch with labels in the node name instead [1],
> what's the preferred way nowadays?
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20220926190148.283805-4-marijn.suijten@somainline.org/

As it turns out that patch relied on the ADC5 driver propagating the DT
node name (and label name if set) to IIO, which doesn't happen for the
legacy VADC driver used here.  I sent an RFC to that effect, with a
large discussion whether or not we should use node names, labels, or
rely on hardcoded names in the drivers entirely.  The recent migration
to fwnode made the node name include the `@xx` suffix which makes for
unpleasant reading in sysfs, so that's at least one reason to have
generic node names *and skip node names in these drivers altogether*.

    https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u

In short: we may want to hold off changing these patches until a
clear-cut decision has been made (but I think your patch here is the
right approach in the end: generic node name *with label*, when the
label is more clear than the name hardcoded in the driver).

- Marijn
