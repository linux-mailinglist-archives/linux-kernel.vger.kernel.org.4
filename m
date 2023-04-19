Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E9D6E7457
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjDSHug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjDSHuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:50:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4E35FD1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:50:02 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fy21so36352115ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681890601; x=1684482601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ex3FQYwjZBBRU/xF477+zVlaZW3BxZIMIDLhGEELcuU=;
        b=OxZ/WQz01SXrYObce2yJW9CAy2aOw6dw2vSElL7HKxUuk6uGq/tUS3XjmdGqD8R0Fe
         3TfD9gBNBUJINE8p0WuEWKVWP+PCyhkWR8VMXbgVM5CVR/RXSxzH6vSQUni/Faz/KNEh
         0FEmMLaRbbktdhDWVqgJXkRFOUaNf+e/etuOsL1JIfkBwtEDXYcRqmR8/ian+fA4mIGD
         jy1XUrPECRYhO1cceH2E2EG/7dZ9zGfGvzkBzsIpJnCq5wm2X4YkaA2u7v3SrTGTi1KO
         qRUjSNFgwocgx7ymMBA3u8xElw0q0TV389JWtVwsWbxsL68Hq9Y4zUvrbGERaWHvV7lH
         kRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681890601; x=1684482601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ex3FQYwjZBBRU/xF477+zVlaZW3BxZIMIDLhGEELcuU=;
        b=hxUQbCRJ86AaoNYJq/06fHgBH4mUl8Tp2oy6+Ex9lkZJgSv3i6jRVBiGrSW+P36Y/U
         YcVa0wNMd+Brqq9SU8Fl2AEPCId3RN3sOgM4m1CFuXmSOT3lpDn+TJYppcQ1wST7fzCt
         VF624bQRHJmsYaVF0HKJmAx7Pu26etv7Mk3ZRkQaC/HZBiWJ87TEUAsli8JD8y9Lbkwv
         8/mZiyEm84px241Wor2qkRkbvWGSkaxZq40TlsbIC6/x8KIq6L9hQUnXxzKiU0kuJYSG
         p9ZLlZ/a5wBZRsedRCsfB8gFeOYeTS1NtmGToWfoEUTkT6woD7jE+3Oi5423D/aVrl0i
         yVBg==
X-Gm-Message-State: AAQBX9ca0BCEdmBYxo6PSa5J0kSqOZndN8k8jR9rP5Oj71svigyShIJj
        ev91gSUK2tEdRaPEneLY/Yqj4g==
X-Google-Smtp-Source: AKy350bYKg9848d4KXFH0IJZHSCHAmJ520zePJffoeMH2aWJrINnNuprN0NuepCabPPLCIjbLSbRtQ==
X-Received: by 2002:a17:906:f14f:b0:94a:a6f0:876a with SMTP id gw15-20020a170906f14f00b0094aa6f0876amr13715223ejb.1.1681890600844;
        Wed, 19 Apr 2023 00:50:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:62f5:eb43:f726:5fee? ([2a02:810d:15c0:828:62f5:eb43:f726:5fee])
        by smtp.gmail.com with ESMTPSA id rp26-20020a170906d97a00b0094f3132cb86sm5647711ejb.40.2023.04.19.00.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 00:50:00 -0700 (PDT)
Message-ID: <eb2540e6-6768-aa38-ec3e-d0f9bb75d797@linaro.org>
Date:   Wed, 19 Apr 2023 09:49:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/5] arm64: dts: ti: k3-j784s4-main: Add system
 controller and SERDES lane mux
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, nm@ti.com, vigneshr@ti.com,
        afd@ti.com
Cc:     s-vadapalli@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a-bhatia1@ti.com
References: <20230419061710.290068-1-j-choudhary@ti.com>
 <20230419061710.290068-2-j-choudhary@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419061710.290068-2-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 08:17, Jayesh Choudhary wrote:
> From: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> The system controller node manages the CTRL_MMR0 region.
> Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> [j-choudhary@ti.com: Minor cleanup to fix dtc warnings]
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index e9169eb358c1..5fb7edf4f5a0 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -5,6 +5,9 @@
>   * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
> +#include <dt-bindings/mux/mux.h>
> +#include <dt-bindings/mux/ti-serdes.h>
> +
>  &cbass_main {
>  	msmc_ram: sram@70000000 {
>  		compatible = "mmio-sram";
> @@ -26,6 +29,25 @@ l3cache-sram@200000 {
>  		};
>  	};
>  
> +	scm_conf: syscon@100000 {
> +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
> +		reg = <0x00 0x00100000 0x00 0x1c000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x00 0x00 0x00100000 0x1c000>;
> +
> +		serdes_ln_ctrl: mux-controller-4080 {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).


Best regards,
Krzysztof

