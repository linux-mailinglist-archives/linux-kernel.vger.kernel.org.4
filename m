Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D648C6C9C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjC0Hln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjC0HlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:41:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C705B90
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:41:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b20so32045209edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679902867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5bi1+WfsUoOhFSAaV3zkoPw5HWDukivsoXGIfitVWss=;
        b=onsxnUGbG0YkjjIicT4drsh93B1D8wy6n5fIg2hGUvEm0OvX96uLjagWn2wvduDRTr
         H/kRzjB5qm5+Q/5xIRD2OXXEmyg5kKBXePi6tdZ66z5kumn32hqdh5d2KvIYwwdZJFI5
         ow5ZnoleYho2WaQ1pExI6Gsl79yJZyn9AlPcMwePE9YP0cyiZ7/owT7DIf4+R3LSSCjz
         NVeKVzrGgAyqgUdeG8UiBMVT9RbH/+NXJgT1afudLMpPJnkzEJdCEFSqyGAIQ82sx47M
         zoEdlNngaFdSQHiiTXjYrrvTcKZgvSFXmLLLvmq9onzdkBH0Zy6UhIe6nxpo0h3zyAJk
         JgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679902867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bi1+WfsUoOhFSAaV3zkoPw5HWDukivsoXGIfitVWss=;
        b=ljm9WzjS9KIJuvXRpRNCSEyzZ/mINJR5lKVR27m+W1pEeVopwTeMT5RqPOGRhBggHJ
         o1YeIHZQDcoDHX7MPz6GdrFimpmTiLKwUd+KY+erKJAoDnKrWZ9VDw1Qd94MO2sCdOQG
         vtzfCMohYY9Mrp4Bh4b7McM9kuO7uXCp1NkzVM+dhwm6WuIdfnXvaNgy9kHoJWLoiV0+
         lRnNVVcdg7LsT0NUhetBko7+eItWwnayj1oEHltDLfpNKyTwQh3HcjY1VbEzn/30Wr/J
         jNwnGYutX4H/aep0NsWrUdC7BnKFW1t6H0OOR8YaHJ0dmJVmDan+XR+2yRPhcbqlEYzO
         FtkA==
X-Gm-Message-State: AAQBX9dY0Mv+AwwSChCFizqlE260yEivh0Y19CvQxzH8WCPp3924Mbvn
        JhcWHH6isPnGXB2aaxHYd0/U/Q==
X-Google-Smtp-Source: AKy350aleSsdAxY1s4KnUYeWmyWXGg5PLmsFBRCpoHqR8NeeBSkghBxcejSgmI35vDaZqUmWDjlnHw==
X-Received: by 2002:a17:906:cecf:b0:932:2412:8abf with SMTP id si15-20020a170906cecf00b0093224128abfmr12062018ejb.62.1679902867556;
        Mon, 27 Mar 2023 00:41:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:198e:c1a5:309b:d678? ([2a02:810d:15c0:828:198e:c1a5:309b:d678])
        by smtp.gmail.com with ESMTPSA id kg2-20020a17090776e200b009334219656dsm12041982ejc.56.2023.03.27.00.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 00:41:07 -0700 (PDT)
Message-ID: <5675373c-af4f-906f-9906-7853a85f8ed6@linaro.org>
Date:   Mon, 27 Mar 2023 09:41:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: usb: typec-tcpci: convert to DT schema
 format
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        jun.li@nxp.com
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20230323065824.3857573-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323065824.3857573-1-peng.fan@oss.nxp.com>
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

On 23/03/2023 07:58, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the binding to DT schema format. The default speed is HS,
> so add a dummy port@0 in the example.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V1:
>  The default speed is HS, so port@0 is not added for some device tree,
>  however the usb-c-connector requires port@0. Not sure we should drop
>  the required port@0 from usb-c-connector schema or add a dummy port@0
>  for tcpci as what this patch does.

imx8mq-librem5-devkit has full port@0 so just use similar approach.

> 
>  .../devicetree/bindings/usb/typec-tcpci.txt   | 49 ------------
>  .../devicetree/bindings/usb/typec-tcpci.yaml  | 80 +++++++++++++++++++
>  2 files changed, 80 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/typec-tcpci.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/typec-tcpci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/typec-tcpci.txt b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
> deleted file mode 100644
> index 2082522b1c32..000000000000
> --- a/Documentation/devicetree/bindings/usb/typec-tcpci.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -TCPCI(Typec port cotroller interface) binding
> ----------------------------------------------
> -
> -Required properties:
> -- compatible:       should be set one of following:
> -		    - "nxp,ptn5110" for NXP USB PD TCPC PHY IC ptn5110.
> -
> -- reg:              the i2c slave address of typec port controller device.
> -- interrupt-parent: the phandle to the interrupt controller which provides
> -                    the interrupt.
> -- interrupts:       interrupt specification for tcpci alert.
> -
> -Required sub-node:
> -- connector: The "usb-c-connector" attached to the tcpci chip, the bindings
> -  of connector node are specified in
> -  Documentation/devicetree/bindings/connector/usb-connector.yaml
> -
> -Example:
> -
> -ptn5110@50 {
> -	compatible = "nxp,ptn5110";
> -	reg = <0x50>;
> -	interrupt-parent = <&gpio3>;
> -	interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> -
> -	usb_con: connector {
> -		compatible = "usb-c-connector";
> -		label = "USB-C";
> -		data-role = "dual";
> -		power-role = "dual";
> -		try-power-role = "sink";
> -		source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
> -		sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
> -			     PDO_VAR(5000, 12000, 2000)>;
> -		op-sink-microwatt = <10000000>;
> -
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@1 {
> -				reg = <1>;
> -				usb_con_ss: endpoint {
> -					remote-endpoint = <&usb3_data_ss>;
> -				};
> -			};
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/usb/typec-tcpci.yaml b/Documentation/devicetree/bindings/usb/typec-tcpci.yaml
> new file mode 100644
> index 000000000000..067d3b032e3d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/typec-tcpci.yaml

Is this a binding for PTN5110 or for generic tcpci? Looks like the
first, thus name should be rather device specific, so nxp,ptn5110.
Specially that there are other tcpci chips in separate bindings.

> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/typec-tcpci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TCPCI(Typec port cotroller interface)

Also title should be changed to device specific.

> +
> +maintainers:
> +  - Li Jun <jun.li@nxp.com>
> +
> +properties:
> +  compatible:
> +    const: nxp,ptn5110
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  port:
> +    description: This port is used for usb role switch.
> +    $ref: /schemas/graph.yaml#/properties/port

I don't think
> +
> +  connector:
> +    type: object
> +    $ref: /schemas/connector/usb-connector.yaml#
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - connector
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/usb/pd.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ptn5110@50 {

tcpci or actually more popular: usb-typec

> +            compatible = "nxp,ptn5110";
> +            reg = <0x50>;
> +            interrupt-parent = <&gpio3>;


Best regards,
Krzysztof

