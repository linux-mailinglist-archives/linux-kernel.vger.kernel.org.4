Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646FC622E05
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiKIOev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiKIOet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:34:49 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276E91A832
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:34:48 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id s24so26047379ljs.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 06:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHJSPQ2KpVWRh2F/hjyLQ9O/rrarIAVTyAzIqjmkK+Q=;
        b=hS8jMuM9Pet8reMxHNhi9rZIVXDPD3jUHk7alRI0bEee4KIChuuDJoKCSFip+M6jjh
         P+kiVAuCE40+85SqJaFvuIMoGUBUNZejgQEx7E7aCrUGy4DaD7VupUlayC5DvZc/0X0D
         1EKysOd9Z9OqVpiv5hL+f4hZBaLgA8HQiuEvESZhBRURXFxymByDIYQ/hO7+P18Qyd5C
         54igwOJZ33o1e5+vznOlTySJEvBTUUveICTbu+4XfCspnFZb9Xfc/IKhLJZl6/f2juEr
         qEACdvU9p0Bim6ddDleeW/7fNVePVE9vDNYUG8THYPltcPkEpMPyg8QIOfHHmIaJutOw
         aFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHJSPQ2KpVWRh2F/hjyLQ9O/rrarIAVTyAzIqjmkK+Q=;
        b=R4JRaiX/fgM7m9sMx0nSqr5zdgPxlwF7HVyRRiECsR2+m+IMBB9lAiARxcGxa5VuuY
         K5beXgYl8Q/VZQ87QvkJSfgOjnxYotAxOphdObac8dujKbbnI3mL7FHD/m6rWd2Webg0
         g9ZaMXMj91CVT5go0+CsWWm3kS6KhqAXskPBNYgT4uFMwnQL6wfdBk8fEY7xDBCZZA4p
         hxZMUqLIsEre6fuXZ78LuX0M+Z27iwdCUdrR9fog/YEfG/dea1MN3CeeI73E7qF+gxDg
         E1IcV7a5BfqRt2fHgYMKJfAR4Gr5NjOt/f4J4bNSXIq5N+JKlz86GrFjlrgwrjpg/ZiR
         NR1w==
X-Gm-Message-State: ACrzQf05faKhnM6XMv/NZJyKs5yMpeuIPe0EfveHA9FtG50ylog+nqVd
        PZuQpYTemxetM7zR7y2wPgNlOA==
X-Google-Smtp-Source: AMsMyM5xucvgotaykf4drj5tJEgPzvpUZhqXSSzBWj2WDa22wBUY7Ce1wlpRPyEiC8E3DFcRB66SYg==
X-Received: by 2002:a2e:2417:0:b0:277:210:41d1 with SMTP id k23-20020a2e2417000000b00277021041d1mr7563569ljk.507.1668004486394;
        Wed, 09 Nov 2022 06:34:46 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id v6-20020a05651203a600b004b40c1f1c70sm719554lfp.212.2022.11.09.06.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 06:34:45 -0800 (PST)
Message-ID: <f079ebb0-2161-61bb-818e-840b74ba1821@linaro.org>
Date:   Wed, 9 Nov 2022 15:34:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] arch/arm64/boot/dts/marvell: add optee FW definitions
Content-Language: en-US
To:     kostap@marvell.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Chulski <stefanc@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
References: <20221109143054.1440158-1-kostap@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109143054.1440158-1-kostap@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 15:30, kostap@marvell.com wrote:
> From: Konstantin Porotchkin <kostap@marvell.com>
> 
> Add reserved memory and ARM firmware definitions for optee
> memory region in Marvell Armada SoCs to avoid protected memory
> access.
> 
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  | 11 +++++++++++
>  arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 13 +++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index df152c72276b..c7a5a25826ea 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -35,6 +35,11 @@ psci-area@4000000 {
>  			reg = <0 0x4000000 0 0x200000>;
>  			no-map;
>  		};
> +
> +		tee@4400000 {
> +			reg = <0 0x4400000 0 0x1000000>;
> +			no-map;
> +		};
>  	};
>  
>  	cpus {
> @@ -531,5 +536,11 @@ armada-3700-rwtm {
>  			mboxes = <&rwtm 0>;
>  			status = "okay";
>  		};
> +
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +			status = "okay";

Why? It's by default.

> +		 };
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> index a06a0a889c43..abf373b39463 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> @@ -41,6 +41,11 @@ psci-area@4000000 {
>  			reg = <0x0 0x4000000 0x0 0x200000>;
>  			no-map;
>  		};
> +
> +		tee@4400000 {
> +			reg = <0 0x4400000 0 0x1000000>;
> +			no-map;
> +		};
>  	};
>  
>  	AP_NAME {
> @@ -461,4 +466,12 @@ map3_emerg: map3-emerg {
>  			};
>  		};
>  	};
> +
> +	firmware {
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +			status = "okay";

Drop.

> +		 };
> +	};
>  };

Best regards,
Krzysztof

