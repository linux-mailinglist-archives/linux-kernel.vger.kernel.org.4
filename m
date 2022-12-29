Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DA0658F40
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiL2Qv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiL2Qv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:51:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A26ADF1A;
        Thu, 29 Dec 2022 08:51:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ABB66184A;
        Thu, 29 Dec 2022 16:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D73CC433EF;
        Thu, 29 Dec 2022 16:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672332684;
        bh=rXWUVU0CoyZ1qakTHHbRkRCXH6L/vHInrFwNMvYuoKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qMoTmF8IlANG5ZCFExaEO2AC2Vr3ZlROU6txSnwhGAQR2gK7I2mColCcnixDQeEEe
         hVPlDB0P2+spuVdAVMNaK1IAHNNniUdpn3PnkpsgAWj3qy8E2nob0Rn1/I7G8opfOW
         ewC98Aac6U402TK/bW8lL5EchJTer7wCdEpt/xsdyBp98SIJC5mgxFdqiydvdwH3Mq
         I37aDUIA0m4L1kl3WkwLeUWoAZGG7Ja7+dnpVzBI6gMQzZ4LEfdnu/l1QI8nXcJCog
         hIEzMx/dsMYONLXh1BhwusXhE/6AN6RDqmnHaE3VnOOLdHKd1xKW+w7ShaKEh0yPdh
         w39pgEPJt7zkA==
Date:   Thu, 29 Dec 2022 10:51:22 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8350: correct SDHCI interconnect
 arguments
Message-ID: <20221229165122.w3qg36yefyuzgpx6@builder.lan>
References: <20221224214351.18215-1-krzysztof.kozlowski@linaro.org>
 <9b17c480-db10-3e57-d071-8382e4989d1b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b17c480-db10-3e57-d071-8382e4989d1b@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 12:17:22PM +0100, Konrad Dybcio wrote:
> 
> 
> On 24.12.2022 22:43, Krzysztof Kozlowski wrote:
> > The interconnect providers accept only one argument (cells == 1), so fix
> > a copy&paste from SM8450:
> > 
> >   sm8350-hdk.dtb: mmc@8804000: interconnects: [[74, 9, 0], [75, 1, 0], [76, 2, 0], [77, 36, 0]] is too long
> > 
> > Fixes: 60477435e4de ("arm64: dts: qcom: sm8350: Add SDHCI2")
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> This patch is correct, but if 8350 dts mdss [1] gets merged, it will become
> unnecessary, as it changes icc-cells to 2. Apply with caution i guess :D
> 

Seems reasonable to pick this fix for 6.2. Please help me remember to
check that [1] gets this right...


Thanks Krzysztof.

> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Thanks,
Bjorn

> 
> Konrad
> 
> [1] https://lore.kernel.org/linux-arm-msm/CAG3jFyuoXekXN48jAgXxLMy8yGAzK9oJH_1HHYAuRLBCzyordQ@mail.gmail.com/T/#mdd42dd600f0818ec103daa27c63add6700db86d3
> > 
> > Fix for v6.2-rc merge window.
> > ---
> >  arch/arm64/boot/dts/qcom/sm8350.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > index 4fc15cc69b8c..0726930c9e28 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > @@ -2382,8 +2382,8 @@ sdhc_2: mmc@8804000 {
> >  				 <&rpmhcc RPMH_CXO_CLK>;
> >  			clock-names = "iface", "core", "xo";
> >  			resets = <&gcc GCC_SDCC2_BCR>;
> > -			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
> > -					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
> > +			interconnects = <&aggre2_noc MASTER_SDCC_2 &mc_virt SLAVE_EBI1>,
> > +					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_SDCC_2>;
> >  			interconnect-names = "sdhc-ddr","cpu-sdhc";
> >  			iommus = <&apps_smmu 0x4a0 0x0>;
> >  			power-domains = <&rpmhpd SM8350_CX>;
