Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309FE6CD4C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjC2Ig7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjC2Ig4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:36:56 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2DF126
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:36:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id e11so15237441lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680079013;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/xTfrQqdPOr1VUHDT+Xi7DQz6WS1kxLC72o+Ktlx4I=;
        b=p2o7LkjvWeqhqR1RKjzxBfXlcfSihucbat9diMVrvSv1WD6n2m2KAqwcWb80HfmP+y
         lKhKbl4FsRTq/u4Q8GMBGoqANkJseRef84IcyepO7CqkYgr0M7QHDfwWuHZAkQ5gWQYB
         tWrCJFcdSjk2I4Vumg3FQ3x5dXkH2Ht8KE/rp7R+LqZ7YBsH+AOoDX4A8NqXoE4FoqRC
         micX1WTx9Kreb0JbAF+IBhITjORuKQY3d0iO4edSlYrEn1Y2XJtCuxhmxn/mh5P0xNDB
         Dq6xvvB1EsWvD8vwLF/by8C5BkOptxQlTaz4eXg8q+DVcqxgAk3bhvuz8thicLLxm+mO
         aNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680079013;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/xTfrQqdPOr1VUHDT+Xi7DQz6WS1kxLC72o+Ktlx4I=;
        b=I36Bl9H59cBuL6DEUJXRgjXklRHQ7ZlJ3YkgVe1p/49GbMo5zGeGyGDnve60NJDqHH
         bwVN9UMZiY9aYFoG8JGHMTZS7VzEwAis4Hw3nq39AuMRbom/PRHI+P+8RG6Y7QZr5moS
         DWfUQ3PHAZvIYVZqPdYz4tfUT9hvng+jbb1DBrtWxgXPj9SlC0np1cSGDIOngUCEMTeI
         cFflOb4ho7GcL7ddYMhurfMAFEJmUEM5aGwqgnszfVv2o7UWeSF0qXWSOiWgKAFuclHJ
         VMpvgbwzMkhG/BldoC2PdkXUvsuZfHUcdGpCjiecWghShcxBqBOApShbYcz5o8RVaXRh
         r6Ow==
X-Gm-Message-State: AAQBX9eYkNARdyNH16zAmb2Tx49PJ89cmMqMhdcsPq7W1OCMVA9sIJ4X
        HUZSV09VoRo4avs3koSuTIMXHw==
X-Google-Smtp-Source: AKy350au2Z3WXceuIA+YYWZfaLMQVGEW7Enc0KrPMuuwmNNa7EeF+qBAEs5vHu4zkzvycHr2enqaEg==
X-Received: by 2002:a2e:a48e:0:b0:290:8289:8cba with SMTP id h14-20020a2ea48e000000b0029082898cbamr434794lji.8.1680079013617;
        Wed, 29 Mar 2023 01:36:53 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n1-20020ac24901000000b004eb0c18efc2sm1712311lfi.221.2023.03.29.01.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:36:53 -0700 (PDT)
Message-ID: <b66f708c-5369-c1c9-5506-c609a245bf4c@linaro.org>
Date:   Wed, 29 Mar 2023 10:36:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/2] ARM: dts: aspeed: greatlakes: Add gpio names
Content-Language: en-US
To:     Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>, patrick@stwcx.xyz,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230329083235.24123-1-Delphine_CC_Chiu@Wiwynn.com>
 <20230329083235.24123-2-Delphine_CC_Chiu@Wiwynn.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230329083235.24123-2-Delphine_CC_Chiu@Wiwynn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 10:32, Delphine CC Chiu wrote:
> From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> 
> Add GPIO names for SOC lines.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../dts/aspeed-bmc-facebook-greatlakes.dts    | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> index 8c05bd56ce1e..59819115c39d 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> @@ -238,4 +238,53 @@
>  &gpio0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_gpiu1_default &pinctrl_gpiu7_default>;
> +	status = "okay";

Was it disabled before?

> +	gpio-line-names =
> +	/*A0-A7*/ "","","","","","","","",
> +	/*B0-B7*/ "power-bmc-nic","presence-ocp-debug",
> +		  "power-bmc-slot1","power-bmc-slot2",
> +		  "power-bmc-slot3","power-bmc-slot4","","",
> +	/*C0-C7*/ "presence-ocp-nic","","","reset-cause-nic-primary",
> +		  "reset-cause-nic-secondary","","","",
> +	/*D0-D7*/ "","","","","","","","",
> +	/*E0-E7*/ "","","","","","","","",
> +	/*F0-F7*/ "slot1-bmc-reset-button","slot2-bmc-reset-button",
> +		  "slot3-bmc-reset-button","slot4-bmc-reset-button",
> +		  "","","","presence-emmc",
> +	/*G0-G7*/ "","","","","","","","",
> +	/*H0-H7*/ "","","","",
> +		  "presence-mb-slot1","presence-mb-slot2",
> +		  "presence-mb-slot3","presence-mb-slot4",
> +	/*I0-I7*/ "","","","","","","bb-bmc-button","",
> +	/*J0-J7*/ "","","","","","","","",
> +	/*K0-K7*/ "","","","","","","","",
> +	/*L0-L7*/ "","","","","","","","",
> +	/*M0-M7*/ "","power-nic-bmc-enable","","usb-bmc-enable","","reset-cause-usb-hub","","",
> +	/*N0-N7*/ "","","","","bmc-ready","","","",
> +	/*O0-O7*/ "","","","","","","fan0-bmc-cpld-enable","fan1-bmc-cpld-enable",
> +	/*P0-P7*/ "fan2-bmc-cpld-enable","fan3-bmc-cpld-enable",
> +		  "reset-cause-pcie-slot1","reset-cause-pcie-slot2",
> +		  "reset-cause-pcie-slot3","reset-cause-pcie-slot4","","",
> +	/*Q0-Q7*/ "","","","","","","","",
> +	/*R0-R7*/ "","","","","","","","",
> +	/*S0-S7*/ "","","power-p5v-usb","presence-bmc-tpm","","","","",
> +	/*T0-T7*/ "","","","","","","","",
> +	/*U0-U7*/ "","","","","","","","GND",
> +	/*V0-V7*/ "bmc-slot1-ac-button","bmc-slot2-ac-button",
> +		  "bmc-slot3-ac-button","bmc-slot4-ac-button",
> +		  "","","","",
> +	/*W0-W7*/ "","","","","","","","",
> +	/*X0-X7*/ "","","","","","","","",
> +	/*Y0-Y7*/ "","","","reset-cause-emmc","","","","",
> +	/*Z0-Z7*/ "","","","","","","","";
> +};
> +
> +&gpio1 {
> +	status = "okay";

Same question...
Best regards,
Krzysztof

