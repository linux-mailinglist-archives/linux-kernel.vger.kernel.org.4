Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B27D6686EA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbjALW16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240517AbjALW1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:27:23 -0500
X-Greylist: delayed 623 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Jan 2023 14:24:43 PST
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CD26256;
        Thu, 12 Jan 2023 14:24:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673562270; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sP/ffea2VXzs5ctiBhBZtOrqKvTVucMFvkJmgkUrhJk88hDr4sSgS+qrfSqp5ULl0O
    jX4g64LhxSww7YdAxXSR1SmUf79NS8mKrdddKgcrsOtaHcRYmzxWqXjJ9i5AZaMiAXBy
    fuI2OQAE8xImpy6ZWK3Mmfd5GXeT+dbRSi/WoMnI2fmoYQ2Y+23zNeAYRrd0SYpqJ769
    4MG9k1pDeAUO+dL6PcKYqLVaRkwWMz+nqGmQht70v8O27gt7rYdsSpx8VO8yhaFyezvV
    HIU4UPHWNKts+bp1+aO3fE1qLBEwH86i31hB1xWGpkmwKXFIgJZa9rPwBDZGu8pq3BNe
    gAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1673562270;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=JTbqY/0foCfnZ+vBedvPjIQxwUaNY5Vwj25lmnUspGI=;
    b=dGkRfq9BfnPmHYD76sp2At7cdX5hZHBSo/WGQfIyN2XAbLwW0GTnBmRfSewCfXWK4A
    prp8PLJel+KBlINvm17Iq/UQZxDTr95SaxoulbFWKsnzqbYWOVfM4PDQQYNYsTAm57pZ
    sZlJxgBaUf7N6VCpIp/GGOVlZ7LcgsiWHCkLdt5KerV2pZ0MH3a1ajRufRo2GtIVmNFm
    f3ZPZCQdTdMfYd2ZSHqLlk9V644Z2h5BdgnDGcRKUYZJ4S1qdPPrjbnr74mnhJV05rj4
    I7rWcgMZRT50nPfK1a8a4HuoLvbsOKU61MXvTbgOlloPZ5a+3SZWkBFCAJ6+3bOgrbFb
    I69Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1673562270;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=JTbqY/0foCfnZ+vBedvPjIQxwUaNY5Vwj25lmnUspGI=;
    b=JEaMP74h0BCDJkkracrxXH4SCFbBzdjwbNSLdOCYwvIo18Vj4tmuXDtu2N6/Eoimlt
    K60huBA6F3lUutcOuG+RD9ypAxAQGQiPKQEdEod0RtcuEyUeq+3H72rm1iUsZOl/WRdY
    AHZbEzwyXdTHlmVCZTKkpAIy0JgUv65l4+QQPbSV1VbYxKXCTaonc+Jx+RjWQIqg4vRw
    IwIyteVZAXkBg4U49HeVZOArIcQSbP+nkk3i9cL7exbVFGuQC/PKLVHsJhcInz/HuFNN
    L0GBZWUA8OJEJ7g4FPyDDheyPwr9Ttx1PWdIozQCezrGCcBYLlM1X5ElBWEKBo/fDck4
    ZiJg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWwfGjtQ=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.6.2 DYNA|AUTH)
    with ESMTPSA id yacdeez0CMOU4hN
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 12 Jan 2023 23:24:30 +0100 (CET)
Date:   Thu, 12 Jan 2023 23:24:29 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Matti =?iso-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] ARM: dts: qcom: msm8226: Add modem remoteproc node
Message-ID: <Y8CInQ8UJdEen33p@gerhold.net>
References: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
 <20230112202612.791455-8-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230112202612.791455-8-matti.lehtimaki@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:26:10PM +0200, Matti Lehtimäki wrote:
> From: Luca Weiss <luca@z3ntu.xyz>
> 
> Add a node for the modem remoteproc found on MSM8226.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Co-developed-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-msm8226.dtsi | 86 +++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
> index 2639167c8976..34ea9cf46ae0 100644
> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
> [...]
> @@ -620,6 +655,57 @@ rpm_msg_ram: sram@fc428000 {
>  			reg = <0xfc428000 0x4000>;
>  		};
>  
> +		modem: remoteproc@fc880000 {
> +			compatible = "qcom,msm8226-mss-pil";
> +			reg = <0xfc880000 0x100>,
> +			      <0xfc820000 0x020>;
> +			reg-names = "qdsp6", "rmb";
> +
> +			interrupts-extended = <&intc GIC_SPI 24 IRQ_TYPE_EDGE_RISING>,
> +					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
> +
> +			clocks = <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
> +				 <&gcc GCC_MSS_CFG_AHB_CLK>,
> +				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
> +				 <&xo_board>;
> +			clock-names = "iface", "bus", "mem", "xo";
> +
> +			resets = <&gcc GCC_MSS_RESTART>;
> +			reset-names = "mss_restart";
> +
> +			power-domains = <&rpmpd MSM8226_VDDCX>;
> +			power-domain-names = "cx";
> +
> +			qcom,ext-bhs-reg = <&tcsr_regs_1 0x194>;
> +			qcom,halt-regs = <&tcsr_regs_1 0x180 0x200 0x280>;
> +
> +			qcom,smem-states = <&modem_smp2p_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			status = "disabled";
> +
> +			mba {
> +				memory-region = <&mba_region>;
> +			};
> +
> +			mpss {
> +				memory-region = <&mpss_region>;
> +			};

Please prefer using memory-region with two items in the node above, as
suggested in the DT schema:

			memory-region = <&mba_region>, <&mpss_region>;

Thanks,
Stephan
