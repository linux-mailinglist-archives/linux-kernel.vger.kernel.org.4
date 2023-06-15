Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1DF730F35
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243481AbjFOGWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjFOGWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:22:41 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF632126;
        Wed, 14 Jun 2023 23:22:39 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35F6MQU0016532;
        Thu, 15 Jun 2023 01:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686810146;
        bh=cshOftvcrMDU9QSykEgbILkJr0TxVZuYFvLzFdKDwWY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ECbr6sTK8/UELUiGj8/Cta7JIqQ19lSUALyzF348Y7DDwUlI8MeKhei5MZqQhGhNs
         ieJUFAs38qMOhU7x2aYsrdRtLBh4OnTnLL94FDwdFQ6JbjjaVG4l5o0GXnqpph2x+S
         PqbieYvg0B/mJpnS//H2C6GdpkK8NcBkT6qcMa2Y=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35F6MQNl058868
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 01:22:26 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 01:22:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 01:22:26 -0500
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35F6MMiD113107;
        Thu, 15 Jun 2023 01:22:23 -0500
Message-ID: <b6ebaf92-39ed-01af-6aa9-52232a2e3ea7@ti.com>
Date:   Thu, 15 Jun 2023 11:52:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/5] arm64: dts: ti: add verdin am62 dahlia
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        Nishanth Menon <nm@ti.com>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230601131332.26877-1-francesco@dolcini.it>
 <20230601131332.26877-5-francesco@dolcini.it>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230601131332.26877-5-francesco@dolcini.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/06/23 18:43, Francesco Dolcini wrote:

[...]

> +/* Verdin I2C_1 */
> +&main_i2c1 {
> +	status = "okay";
> +
> +	/* Audio Codec */
> +	wm8904_1a: audio-codec@1a {
> +		compatible = "wlf,wm8904";

This node doesn't have YAML bindings :(

> +		reg = <0x1a>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_i2s1_mclk>;
> +		/* POSTDIV4_16FF_MAIN_2_HSDIVOUT8_CLK -> AUDIO_EXT_REFCLK1 */
> +		assigned-clocks = <&k3_clks 157 10>;
> +		assigned-clock-parents = <&k3_clks 157 18>;
> +		assigned-clock-rates = <25000000>; /* for 48KHz ± 1.7% */
> +		clocks = <&k3_clks 157 10>;
> +		clock-names = "mclk";

> +		AVDD-supply = <&reg_1v8_sw>;
> +		CPVDD-supply = <&reg_1v8_sw>;
> +		DBVDD-supply = <&reg_1v8_sw>;
> +		DCVDD-supply = <&reg_1v8_sw>;
> +		MICVDD-supply = <&reg_1v8_sw>;

I dont see these properties in .txt bindings either.

> +		#sound-dai-cells = <0>;
> +	};
> +

[...]

-- 
Regards
Vignesh
