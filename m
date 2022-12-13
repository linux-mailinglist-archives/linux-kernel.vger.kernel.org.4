Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E8D64B5C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiLMNH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbiLMNHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:07:39 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129EF1FF86
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 05:07:35 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p36so4762988lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 05:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4i4GY2IoIa8cufEomfPpTLe28kwoi3FtbheLaKzoazs=;
        b=qe2veQwCIbDY+czEKy7nGSyF/KY8MjEIlfpc7vAQ/w7VUSLslcw1SIw7yFRTyDew8T
         VyTDReF9kGAtR3Ko38NVCdc+es35BeulABkASd588+Tw2kyWg2O7sSV2m3uqsiR4ypFD
         2OequDc64PKD8avmJ5sZd6WBSXiQ4lc0yNF2MHKfdx0YcYAwHimuP6O1bjQwIs7HUJ55
         PNPDJVfYBJCsBAaCYZo/6bAgMvuCSjQNyPlaKTpKueD09gbI6sSCIFMnfccxKb4SPXKf
         1333uDZFYz4kR72ZB9x0Oj4DoyI6vz0/F7+m88KOCXQE7Hk9123LSbf8Yj2smMYpYciS
         Azzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4i4GY2IoIa8cufEomfPpTLe28kwoi3FtbheLaKzoazs=;
        b=VdebhPLWQbeNW3PQrspKJ8vPKYEohP27okNA3ZWfqp3K+W0/9G5uookXFqVIBCilXZ
         kp2lf5gS3WSAxk3yLXlp1zlCauxIr2EAu9icz+4ZYPlcXjE9p+IWxZI7BntnokgeVDhq
         MtGW7BT/06EGB3WvJostM2bgEKAiolI6Oa6tWQLyiwYy2nyBF2qdDZC7/0uFjlRWC84E
         7CNHJhd0nvvRv6zcarEA3HpsikByqmU3g6rKvudRH4R3HlIn2xAz/IduYuDjZ16kU2FO
         NwUiIOhJFmu1lQgvQcVI/+8yKk2Gd14oqk9I5spovVYpiWzLbGrZJlcAebT8fslEJGF+
         pr9A==
X-Gm-Message-State: ANoB5pm6g6J5VqWvXi4PrbU6zJKDXm7VH4Ss6W+9ygBb0raWYAyzBoNI
        deuyvDo7Nx6gnyQtih2tftlnZw==
X-Google-Smtp-Source: AA0mqf4UuGrf1jIShKf0znJ1XQnUsROhhKPlJB55ucG+VnXJmRKGpOoFluo8hPqeQVXEoMPv61zyfA==
X-Received: by 2002:a05:6512:1145:b0:4b5:39fa:6dc with SMTP id m5-20020a056512114500b004b539fa06dcmr4924494lfg.18.1670936853370;
        Tue, 13 Dec 2022 05:07:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f0b000000b004a03d5c2140sm360384lfq.136.2022.12.13.05.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 05:07:32 -0800 (PST)
Message-ID: <d750c6e8-365c-7443-0847-78b9a6478803@linaro.org>
Date:   Tue, 13 Dec 2022 14:07:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] dt-bindings: display/panel: Add the focaltech gpt3
Content-Language: en-US
To:     Christophe Branchereau <cbranchereau@gmail.com>,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net
References: <20221213084203.17729-1-cbranchereau@gmail.com>
 <20221213084203.17729-2-cbranchereau@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213084203.17729-2-cbranchereau@gmail.com>
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

On 13/12/2022 09:42, Christophe Branchereau wrote:
> Add bindings for the focaltech gpt3, which is a 640x480 3.0" 4:3
> IPS LCD Panel found in the YLM/Anbernic RG300X handheld.
> 
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> ---
>  .../display/panel/focaltech,gpt3.yaml         | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml b/Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml
> new file mode 100644
> index 000000000000..969f117c51ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/focaltech,gpt3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Focaltech GPT3 3.0" (640x480 pixels) IPS LCD panel
> +
> +maintainers:
> +  - Christophe Branchereau <cbranchereau>

That's not a correct email address.

> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: focaltech,gpt3
> +
> +  backlight: true
> +  port: true
> +  power-supply: true

Drop all three - provided by panel-common.yaml

> +  reg: true

maxItems: 1

(or from which other schema does it come?)

> +  reset-gpios: true


Drop - provided by panel-common.yaml

> +
> +required:
> +  - compatible
> +  - reg
> +  - power-supply
> +  - reset-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "focaltech,gpt3";
> +            reg = <0>;
> +
> +            spi-max-frequency = <3125000>;
> +
> +            reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
> +
> +            backlight = <&backlight>;
> +            power-supply = <&vcc>;
> +
> +            port {
> +                panel_input: endpoint {
> +                    remote-endpoint = <&panel_output>;
> +                };
> +            };
> +        };
> +    };

Best regards,
Krzysztof

