Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3DD6E7468
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjDSHwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjDSHwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:52:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A8F118D6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:51:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dm2so79452102ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681890710; x=1684482710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDlxSPCrAX4Nl9Tp9ky3UcOflYJp7M8armR9xRbnOzc=;
        b=Ok8e+/8gGGf3Sa6VRx391vR3zJfaYlDBevI4ECtzvfcpTjvGwPZ9LtNnTj6mSrBogi
         jbYaCmWh4YZThAmp4u/PY1t9VQgCPIcuFOXBfoJoZ9rQ9aMasEc4EZBHhxXuh7/1xykQ
         qPWnGey5Gp59fchiFiOBeLqnJt2p9Z2+HHc822a1HfsEcqWrZNYUyf6wMjKMHQ4EF+Rp
         /FSzBzuaVCx5p3AC7CJdtsDShQb59/TlyCgKu1NDluOqRzVCdgt6s9qv2YyaPASuJkA2
         gaBdcGw1QGrR1HoLibzvwgoeaVoDwwOmHtFSQW1Dv6dcVr7A+wNWAuQP9f2WhrY8maS6
         bhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681890710; x=1684482710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDlxSPCrAX4Nl9Tp9ky3UcOflYJp7M8armR9xRbnOzc=;
        b=jHJNAhcuBopGlYrsBt1etPKinqbDbYamJWidj4bHxL1KPmv14c3Tyeo0eIJFDNosUJ
         S0LDFzyZ08Xm6X7gMPZgzWilYxt3qWGC9t+gdFNsL+DSmGl7pwPQqfIYIyccvCg3V3w7
         Fz/Hs61YYPWY7g+O1EpiH2UIPr19rD1Cy/vBMoJ2Z4K1dHO73xIrYzA3L3zau2Xyumto
         m7qcCWbu6QbePuxfg6xRSnFqTd2JfmuDqTSExrobDoMeWdJu616KhijefvmHkf5EIk6w
         0dy8w8jmSy7Sa3DazgJ7qJKYANyOxbW7EHlcWh4IvhazPRGgPMnP44AuWhoOveAkpCQF
         a3Gg==
X-Gm-Message-State: AAQBX9frzswLTyoyK+LTvKw1hyaKY9GWDMYCfYJB+brP4/nYMNugqybo
        G3LWe4TMwpJffprygTf/+YyC1A==
X-Google-Smtp-Source: AKy350ZRTyS4+GTp8Pj7HoAthP042Am2UGVyUuHn7lPYpES4AgScsdDSfBMWEMGre6ktSarvslITpQ==
X-Received: by 2002:a17:906:149b:b0:92f:924b:e8f4 with SMTP id x27-20020a170906149b00b0092f924be8f4mr14128126ejc.4.1681890709967;
        Wed, 19 Apr 2023 00:51:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:62f5:eb43:f726:5fee? ([2a02:810d:15c0:828:62f5:eb43:f726:5fee])
        by smtp.gmail.com with ESMTPSA id xg12-20020a170907320c00b0094ee99eeb01sm7389793ejb.150.2023.04.19.00.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 00:51:49 -0700 (PDT)
Message-ID: <83c8bce1-f4e2-899e-46a9-0ba9da702572@linaro.org>
Date:   Wed, 19 Apr 2023 09:51:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 4/5] arm64: dts: ti: k3-j784s4-main: Add DSS and
 DP-bridge node
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, nm@ti.com, vigneshr@ti.com,
        afd@ti.com
Cc:     s-vadapalli@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a-bhatia1@ti.com
References: <20230419061710.290068-1-j-choudhary@ti.com>
 <20230419061710.290068-5-j-choudhary@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419061710.290068-5-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 08:17, Jayesh Choudhary wrote:
> From: Rahul T R <r-ravikumar@ti.com>
> 
> Add DSS and DP-bridge node for J784S4 SoC. DSS IP in J784S4 is
> same as DSS IP in J721E, so same compatible is being used.
> The DP is Cadence MHDP8546.
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> [j-choudhary@ti.com: move all k3-j784s4-main.dtsi changes together]
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index 51aa476dedba..739741e93bc1 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -1373,4 +1373,81 @@ main_spi7: spi@2170000 {
>  		clocks = <&k3_clks 383 1>;
>  		status = "disabled";
>  	};
> +
> +	mhdp: dp-bridge@a000000 {
> +		compatible = "ti,j721e-mhdp8546";
> +
> +		reg = <0x0 0xa000000 0x0 0x30a00>,
> +		      <0x0 0x4f40000 0x0 0x20>;
> +		reg-names = "mhdptx", "j721e-intg";
> +
> +		clocks = <&k3_clks 217 11>;
> +
> +		interrupt-parent = <&gic500>;
> +		interrupts = <GIC_SPI 614 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		power-domains = <&k3_pds 217 TI_SCI_PD_EXCLUSIVE>;
> +
> +		status = "disabled";
> +
> +		dp0_ports: ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +
> +	dss: dss@4a00000 {
> +		compatible = "ti,j721e-dss";
> +		reg =
> +			<0x00 0x04a00000 0x00 0x10000>,

Fix indent/stray line break.

> +			<0x00 0x04a10000 0x00 0x10000>,
> +			<0x00 0x04b00000 0x00 0x10000>,
> +			<0x00 0x04b10000 0x00 0x10000>,
> +
> +			<0x00 0x04a20000 0x00 0x10000>,
> +			<0x00 0x04a30000 0x00 0x10000>,
> +			<0x00 0x04a50000 0x00 0x10000>,
> +			<0x00 0x04a60000 0x00 0x10000>,
> +
> +			<0x00 0x04a70000 0x00 0x10000>,
> +			<0x00 0x04a90000 0x00 0x10000>,
> +			<0x00 0x04ab0000 0x00 0x10000>,
> +			<0x00 0x04ad0000 0x00 0x10000>,
> +
> +			<0x00 0x04a80000 0x00 0x10000>,
> +			<0x00 0x04aa0000 0x00 0x10000>,
> +			<0x00 0x04ac0000 0x00 0x10000>,
> +			<0x00 0x04ae0000 0x00 0x10000>,
> +			<0x00 0x04af0000 0x00 0x10000>;
> +
> +		reg-names = "common_m", "common_s0",
> +			"common_s1", "common_s2",
> +			"vidl1", "vidl2","vid1","vid2",
> +			"ovr1", "ovr2", "ovr3", "ovr4",
> +			"vp1", "vp2", "vp3", "vp4",
> +			"wb";
> +
> +		clocks =	<&k3_clks 218 0>,

Broken indentation.



Best regards,
Krzysztof

