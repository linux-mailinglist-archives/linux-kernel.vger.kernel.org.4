Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B756608260
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 01:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJUX7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 19:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiJUX7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 19:59:42 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D7E1B9D0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 16:59:29 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id r19so2673034qtx.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 16:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLVewMwCQ3h+F5+iDKTi/kVuEV/htostHOaYdqOz1MU=;
        b=FCsq656tPxy0dYq9UdwTGLds/rUDSnPuGlDt1DHI33YL/+TaDy5/CoiBTQtYswo1h2
         oQ3sfr9r+Z8F6b/NW6fGgZXBh/vIi2QEILNRt1Rl8dZkoMdDkx2mVupM732xhg2WjXMY
         r3GsEHyTVBqlf1YyifdJuAOVR6PBC1Ctrc5bUrwkpRf9StRDOADICUJZOEs7dOFQlq/U
         vhYAwcaSP1Sy3Wc3XuitegCqxOjcVZqzldS65e6xr0zKaeC3uaqiw83Hl2UZJR4Wrna5
         fc6B7Y3qOs9OLOm/rTTRhHX+j28HBiGHNi1d2F8YdYnOuLjaxlOvUZYaHLWOIeKoQkUw
         NgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLVewMwCQ3h+F5+iDKTi/kVuEV/htostHOaYdqOz1MU=;
        b=m/KJ36iapFd2//dHa8nUfTQg0wU9XY0W/Y3I6qzXajaS2jeUfOGKzkR5i7CHb++E1A
         a6/iQbzXKkmw6K6TwBs75X60PUGhlEfFgJsIMO35MMn86v1VuWH/1eLChHXTcgD1w3zy
         H9WZBvfmijTBFa3hVwr6pgDRlalbnwYpxXhgCCDGCoMYy4Z56mhcZ0/F4PGE99he9Vel
         556JzfifVG/+GD1dsPzAwqbE6oxdx2cdiheGuFhXHbfcCsM1Ljhgup1VbaubcOohDDfu
         zyhVcHCpOh0QeJ46rb61/9I+3rmKf3aHbimGQpEOM715n7LR0Ad5imFHywiH/tilSsO4
         7vSg==
X-Gm-Message-State: ACrzQf08QLMxRX7aPDHEpDrHzASuCFIiLxlUJRhXRf9FAvqc1s6C5s5D
        eBAfYDsnhsdtT121+rGXTtcX1A==
X-Google-Smtp-Source: AMsMyM4O9Mesth8sJL91+uqMdsVpGCr0EH+jXYtIePpFvf0Wn0uk61byBiaPxCpzqSIQ3hDwH5Up9Q==
X-Received: by 2002:ac8:5804:0:b0:39c:d63c:95b7 with SMTP id g4-20020ac85804000000b0039cd63c95b7mr18215800qtg.216.1666396768302;
        Fri, 21 Oct 2022 16:59:28 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a430600b006e16dcf99c8sm10739565qko.71.2022.10.21.16.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 16:59:27 -0700 (PDT)
Message-ID: <a5db8a34-acd0-e262-36f0-0b904468bd1f@linaro.org>
Date:   Fri, 21 Oct 2022 19:59:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/1] dt-bindings: rtc: convert hym8563 bindings to
 json-schema
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20221021170605.85163-1-sebastian.reichel@collabora.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021170605.85163-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 13:06, Sebastian Reichel wrote:
> Convert RTC binding for Haoyu Microelectronics HYM8563 to Device Tree
> Schema format.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/rtc/haoyu,hym8563.txt | 30 ----------
>  .../bindings/rtc/haoyu,hym8563.yaml           | 55 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
> deleted file mode 100644
> index a8934fe2ab4c..000000000000
> --- a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -Haoyu Microelectronics HYM8563 Real Time Clock
> -
> -The HYM8563 provides basic rtc and alarm functionality
> -as well as a clock output of up to 32kHz.
> -
> -Required properties:
> -- compatible: should be: "haoyu,hym8563"
> -- reg: i2c address
> -- #clock-cells: the value should be 0
> -
> -Optional properties:
> -- clock-output-names: From common clock binding
> -- interrupts: rtc alarm/event interrupt
> -
> -Example:
> -
> -hym8563: hym8563@51 {
> -	compatible = "haoyu,hym8563";
> -	reg = <0x51>;
> -
> -	interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> -
> -	#clock-cells = <0>;
> -};
> -
> -device {
> -...
> -	clocks = <&hym8563>;
> -...
> -};
> diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> new file mode 100644
> index 000000000000..b0b6126b12dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license please. I don't think you copied any content from original
bindings... unless the example?

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/haoyu,hym8563.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Haoyu Microelectronics HYM8563 RTC
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +
> +properties:
> +  compatible:
> +    const: haoyu,hym8563
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clock-output-names:
> +    description: From common clock binding to override the default output clock name.

You need maxItems for this.

> +
> +  wakeup-source:
> +    description: Enables wake up of host system on alarm.
> +
> +allOf:
> +  - $ref: rtc.yaml
> +
> +unevaluatedProperties: false
> +

Would be great if you could also correct DTS using these bindings (see
warning from Rob).

Best regards,
Krzysztof

