Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C9F6D5E99
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbjDDLGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbjDDLF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:05:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3B735A5;
        Tue,  4 Apr 2023 04:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03A6563210;
        Tue,  4 Apr 2023 11:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504B2C433EF;
        Tue,  4 Apr 2023 11:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680606192;
        bh=aJ+ukukh1/o+Hvdqjwyk7hNPpvFV5NVh+CzU1Ihgp6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fEn2D/bNRNRPumV4inV0NckbLrNKhZkGg6gSrCIc5i1J1jpI7vpE+MjAF+UL1+f2w
         vkAG+ToDGyTXS6K20v/5FqON1ToY881e++SawtsQFjKtE7gecfaTFGuI+1XPgS20wy
         KskGloRvCRRML+BPTEqMEaoKGBVacttxBnbyXOoPdhgvZCWUScNc6h4bf3fjiRGR/g
         mNDQ2IN0ZI7Fgad2HUsl+2WUPSs3Bc1Q7bqR5zVL1wbjCpoB39toL61/MLG9UgzBk/
         G0SSqI8VZTVnJPu/YnOFYl9kty+nC6wfXRhjAqDRMf9GeG7eMeq0S6dNmKjwhWeGM2
         DVW8VrFiZR+yA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pjeRR-005atW-MV;
        Tue, 04 Apr 2023 12:03:09 +0100
MIME-Version: 1.0
Date:   Tue, 04 Apr 2023 12:03:09 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, shawnguo@kernel.org, arnd@arndb.de,
        marcel.ziswiler@toradex.com, dmitry.baryshkov@linaro.org,
        geert+renesas@glider.be, rafal@milecki.pl, nfraprado@collabora.com,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_srichara@quicinc.com,
        quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_poovendh@quicinc.com
Subject: Re: [PATCH V11 3/4] arm64: dts: qcom: Add support for ipq9574 SoC and
 RDP433 variant
In-Reply-To: <20230404101622.5394-4-quic_devipriy@quicinc.com>
References: <20230404101622.5394-1-quic_devipriy@quicinc.com>
 <20230404101622.5394-4-quic_devipriy@quicinc.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d410c51ee4beeb4dfee80e13d54d598b@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: quic_devipriy@quicinc.com, agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de, shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com, dmitry.baryshkov@linaro.org, geert+renesas@glider.be, rafal@milecki.pl, nfraprado@collabora.com, broonie@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, quic_srichara@quicinc.com, quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com, quic_anusha@quicinc.com, quic_poovendh@quicinc.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-04 11:16, Devi Priya wrote:
> Add initial device tree support for Qualcomm IPQ9574 SoC and
> Reference Design Platform(RDP) 433 which is based on IPQ9574
> family of SoCs
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V11:
> 	- Dropped the unused backup clock source bias_pll_ubi_nc_clk
> 
>  arch/arm64/boot/dts/qcom/Makefile           |   1 +
>  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts |  84 +++++++
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi       | 263 ++++++++++++++++++++
>  3 files changed, 348 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
> 

[...]

> +		intc: interrupt-controller@b000000 {
> +			compatible = "qcom,msm-qgic2";
> +			reg = <0x0b000000 0x1000>,  /* GICD */
> +			      <0x0b002000 0x1000>,  /* GICC */

This is definitely wrong. The GICC region cannot be less than
8kB, as the GICC_DIR register is in the second 4kB region.

I'm pretty sure the kernel shouts at you when booting at EL2.

> +			      <0x0b001000 0x1000>,  /* GICH */
> +			      <0x0b004000 0x1000>;  /* GICV */

Same thing here.

> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;

Missing target CPU encoding.

         M.
-- 
Jazz is not dead. It just smells funny...
