Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8156C9EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjC0I6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjC0I6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:58:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FBC7AA2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:55:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w9so32851498edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679907318;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XT9BdnGYtPYThjY8LloDnbmIxfJ+0QWdiNM959e0Dys=;
        b=PWoAJ5vTFdugSRs05vJq49fX/YPmDogp4aIdlUt9RNHn+WZVrqKHjas6bicMLu7Ccn
         XRo/uOzqwZzST4Z2ML7tDsIVYrbhk06gWbHMsDVmSmrGFAsAhBMN+s4Q5TLS5tl/OTFT
         rs0mRj06fRgJfXy8eGDn0NPCUel+scc5hnuOir6rD86njVALOLz7Cy0s5WBiUCu7XfGf
         rvfWfItpX/EcEXMJRfrvkojjX9Lx9YQzSdYmtTNuOegyg9Wb+f8T8c2bIGYKG7X0AQ5W
         biTLK+i4paO+T+OXxbBDyJ4uEuZ9MuqcOTYsuu/9/HdQRz8/kjqbGZpcGTazdFdQLQZO
         2gPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679907318;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XT9BdnGYtPYThjY8LloDnbmIxfJ+0QWdiNM959e0Dys=;
        b=RZyHne7SlOFJPuVAumiTru+g0PYRufsgYV1Betd8bjdr+CWNaDkcyDhS453iD8EAjw
         dlcPnTYTfLalULf2QpZNO4viPkTyO1tX+9gTxMRYD/BhkJDTW6xwjeqHZYZxtx1NcLkv
         12JGcm+Wh95q50I2WdCy0d3PNkPgyOSnctCeQg3/WIqy5/0Csv8TAeLgTYOmkecotLRT
         mQvhhHILWUhASEacLJXEhDB0BfwAnrh/NX8BMHRl+ZmG/DDiuWyU+8SJMrLPzIUvFxna
         gEeogsBnvUaBMZw8u4knqK/w/550CojVvRH+A1LRhApfLDURgJROeg7kxWQzfWIEbSl+
         PYyw==
X-Gm-Message-State: AAQBX9et2eU2bUfdnebpOo2/WicTzAaS6gOvzrT0og0bGBY2dvcQVpud
        U5bhCL2SHrkscnVSzaIDDcdRUw==
X-Google-Smtp-Source: AKy350Ywv2T7IE75T69dWTwniYZIc3VRt1lnyfl/sYuW/unJMiTuWNiuVzjT5/kx3JnXfIHjfbx5yg==
X-Received: by 2002:a17:906:ac1:b0:92d:9767:8e0a with SMTP id z1-20020a1709060ac100b0092d97678e0amr10205796ejf.13.1679907318583;
        Mon, 27 Mar 2023 01:55:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:198e:c1a5:309b:d678? ([2a02:810d:15c0:828:198e:c1a5:309b:d678])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm13887119ejk.114.2023.03.27.01.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 01:55:18 -0700 (PDT)
Message-ID: <c89e1c75-360f-214b-5406-f1983a5aef2d@linaro.org>
Date:   Mon, 27 Mar 2023 10:55:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-evm: Add OSPI0 flash support
Content-Language: en-US
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230327082924.12427-1-a-nandan@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327082924.12427-1-a-nandan@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 10:29, Apurva Nandan wrote:
> Add support for OSPI flash connected to OSPI0 instance through FSS.
> Also enumerate OSPI1 instance in MCU DTSI.



> +
> +&ospi0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-tx-bus-width = <8>;
> +		spi-rx-bus-width = <8>;
> +		spi-max-frequency = <25000000>;
> +		cdns,tshsl-ns = <60>;
> +		cdns,tsd2d-ns = <60>;
> +		cdns,tchsh-ns = <60>;
> +		cdns,tslch-ns = <60>;
> +		cdns,read-delay = <4>;
> +		cdns,phy-mode;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};
> +};
> +
>  &main_i2c0 {
>  	status = "okay";
>  	pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> index 93952af618f6..b29b95a532f6 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> @@ -308,4 +308,47 @@ cpts@3d000 {
>  			ti,cpts-periodic-outputs = <2>;
>  		};
>  	};
> +
> +	fss: syscon@47000000 {
> +		compatible = "syscon", "simple-mfd";

NAK. This is not allowed on itself and dtbs_check would warn you.

> +		reg = <0x00 0x47000000 0x00 0x100>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		status = "disabled";
> +
> +		ospi0: spi@47040000 {
> +			compatible = "ti,am654-ospi", "cdns,qspi-nor";
> +			reg = <0x00 0x47040000 0x00 0x100>,
> +			      <0x5 0x0000000 0x1 0x0000000>;
> +			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
> +			cdns,fifo-depth = <256>;
> +			cdns,fifo-width = <4>;
> +			cdns,trigger-address = <0x0>;
> +			clocks = <&k3_clks 161 7>;
> +			assigned-clocks = <&k3_clks 161 7>;
> +			assigned-clock-parents = <&k3_clks 161 9>;
> +			assigned-clock-rates = <166666666>;
> +			power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		ospi1: spi@47050000 {
> +			compatible = "ti,am654-ospi", "cdns,qspi-nor";
> +			reg = <0x00 0x47050000 0x00 0x100>,
> +			      <0x7 0x0000000 0x1 0x0000000>;
> +			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
> +			cdns,fifo-depth = <256>;
> +			cdns,fifo-width = <4>;
> +			cdns,trigger-address = <0x0>;
> +			clocks = <&k3_clks 162 7>;
> +			power-domains = <&k3_pds 162 TI_SCI_PD_EXCLUSIVE>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +	};
> +

Don't add stay blank lines.

>  };

Best regards,
Krzysztof

