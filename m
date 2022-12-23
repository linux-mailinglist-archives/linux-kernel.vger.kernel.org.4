Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4205B654F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiLWKgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiLWKgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:36:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4A59FE6;
        Fri, 23 Dec 2022 02:36:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DE7461EF7;
        Fri, 23 Dec 2022 10:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B331CC433EF;
        Fri, 23 Dec 2022 10:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671791769;
        bh=eZD5BxLrkoE7tEpFxJxI8Uz6LeurunxaeI9o5eKYFb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=niEqGPdyHdKEd57c7eFcCZPQhlb1KqdNq5/MURbXAlq3Cbi3LLntlYJ6B1TuIITSq
         k6tBxPt4e6M35xnt5g5hQl3+pbOjez0EeQpn/ktWzA9Xydk+C1ge4mPNuFb4eNl9J0
         4gxNrkKxEJybhQEOEMs1O/ZYQ6DRImDK1TOphNoJ3iDF8lMzFZQ/KiqcautQB1XeOx
         2S4ci4tA3aIO/LEZ+jqhpvWDQQE0ePYmLeXWaEewH2i0hUP96RFQliRsKbR65usZaL
         D7ItaSWju8D6yrZ0bTu9aj0e+P3pRh1MnDdctWbhL5/2Vt3vZlbR4ECMlzuQaD1K3G
         GDylTKDNVtLfg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p8fQE-0004X8-VV; Fri, 23 Dec 2022 11:37:03 +0100
Date:   Fri, 23 Dec 2022 11:37:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: Re: [PATCH v3 4/7] arm64: dts: qcom: sc8280xp: add missing i2c nodes
Message-ID: <Y6WEzkcP31S2JGrL@hovoldconsulting.com>
References: <20221220192854.521647-1-bmasney@redhat.com>
 <20221220192854.521647-5-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220192854.521647-5-bmasney@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 02:28:51PM -0500, Brian Masney wrote:
> Add the missing nodes for the i2c buses that's present on this SoC.
> 
> This work was derived from various patches that Qualcomm delivered
> to Red Hat in a downstream kernel.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
> Changes from v2 to v3
> - None
> 
> Changes from v1 to v2
> - Dropped qupX_ prefix from labels. (Johan)
> 
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 352 +++++++++++++++++++++++++
>  1 file changed, 352 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index f1111cd7f679..a502d4e19d98 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -813,6 +813,38 @@ qup2: geniqup@8c0000 {
>  
>  			status = "disabled";
>  
> +			i2c16: i2c@880000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0 0x00880000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;

I'm aware that the two current i2c nodes has these two properties here
in the middle, but would you mind moving '#address-cells' and
'#size-cells' after 'reg' instead where I'd expect them to be?

Same for the spi patch.

I can clean up the existing two nodes (and binding example) unless you
want to do it.

> +				power-domains = <&rpmhpd SC8280XP_CX>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
> +				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> +				status = "disabled";
> +			};

Johan
