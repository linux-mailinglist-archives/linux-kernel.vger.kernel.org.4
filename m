Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2079B658FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiL2R3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbiL2R2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:28:24 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D7B167F7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 09:25:52 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id D79511F9A9;
        Thu, 29 Dec 2022 18:25:49 +0100 (CET)
Date:   Thu, 29 Dec 2022 18:25:48 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm64: dts: qcom: sm6125: QUPs, SPI and Seine I2C
 buses
Message-ID: <20221229172548.eddluubb7ljqwiqy@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221216233408.1283581-1-marijn.suijten@somainline.org>
 <20221229171301.7sjbyvqpn3qjwexu@builder.lan>
 <20221229172148.2hcmi7uypwlnxmhu@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229172148.2hcmi7uypwlnxmhu@SoMainline.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-29 18:21:55, Marijn Suijten wrote:
> On 2022-12-29 11:13:01, Bjorn Andersson wrote:
> > On Sat, Dec 17, 2022 at 12:34:05AM +0100, Marijn Suijten wrote:
> > > Introduce Qualcomm Universal Peripheral support on SM6125 and define all
> > > known SPI and I2C Serial Engines.  On Sony Seine PDX201 all I2C buses
> > > with known-connected hardware are enabled for future hardware mapping,
> > > together with the respective GPI DMA 0 and QUP 0.
> > > 
> > > Changes since v1:
> > > - Un-downstream pinctrl mapping:
> > >   - Remove nested mux {} / config {};
> > >   - Remove useless comments;
> > >   - Remove unreferenced pinctrl states;
> > > - Use qup14 pinctrl function name instead of unknown qup_14;
> > > - Reword commit message;
> > > - Add iommus to QUP nodes now that this series depends on apps_smmu to
> > >   be available;
> > > - Reorder all properties to match other SoCs;
> > > - Reorder/intersperse QUP nodes with GPI DMA nodes to maintain sorting
> > >   by address;
> > > - Reorder SPI nodes to fit in with I2C nodes, restoring sorting by
> > >   address too;
> > > - Use QCOM_GPI_* constants;
> > > - Adhere to 3 instead of 5 dma cells for gpi_dma.
> > > 
> > > v1: https://lore.kernel.org/all/20221001185628.494884-1-martin.botka@somainline.org/T/#u
> > > 
> > > Depends on:
> > > - SM6125 APPS SMMU: https://lore.kernel.org/linux-arm-msm/20221216215819.1164973-1-marijn.suijten@somainline.org/T/#u
> > > - SM6125 GPI DMA: https://lore.kernel.org/linux-arm-msm/20221216231528.1268447-1-marijn.suijten@somainline.org/T/#u
> > 
> > Please, in the future, when you have dependencies between your dts
> > patches, send them together so I don't need to go on a treasure hunt in
> > my mailbox to figure out which order to apply things...
> 
> I was quite confident separating out "unrelated" patches in separate
> series was preferred, especially when dependencies are marked explicitly
> like this... what changed?

Perhaps because both dependencies have been resent, and the links for
APPS SMMU v4 and GPI DMA v2 have become obsolete in favour of:

- SM6125 APPS SMMU v5: https://lore.kernel.org/linux-arm-msm/20221222193254.126925-1-marijn.suijten@somainline.org/T/#u
- SM6125 GPI DMA v3: https://lore.kernel.org/linux-arm-msm/20221222194600.139854-1-marijn.suijten@somainline.org/T/#u

- Marijn
