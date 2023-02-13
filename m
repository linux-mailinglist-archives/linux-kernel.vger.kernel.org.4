Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD491694363
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjBMKrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjBMKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:46:38 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8024193C0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:46:15 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id by3so10356120wrb.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S8UFJP/UsuYqUTLKQBl4SQ4Mr97Ly8Qtr9hCCluFle0=;
        b=w1TE7+oGW0mDhzCJKIBQ089FkiikyWVzp7J9tboeLGaYgdxyePRgEKjsEnHyfg1FEb
         plvUG/2QT9T0VcRW9NcJmsKkSkMjuRBJ99IDP1NqC3fdB/2FMk3Qyrp9oH6xU2gC3Rhc
         V4pV0u3MxSHx5MsUMGC91h/ZnKNtSMxVHHpOliqfrRahwlUPOK2he8Z7kTyQIFwqB56I
         Dy3CoKwusYYkubdvR+rDQ9XPzfucmNWOVnU4nuK0gbYcPVqX/rkZRM43J+pC+s6JBEMJ
         NbqcUFQeY/yZSakd78R7UqzVJQBpYDHAoui9QQ/kSY8DBOTf/eEWXsdGjqCoCK8xSZSA
         em8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S8UFJP/UsuYqUTLKQBl4SQ4Mr97Ly8Qtr9hCCluFle0=;
        b=7JfujdoWakYDCTdWigOQnzye9wr4bMMHDMer1RjIuAW3lodsdDL8NrZPFACskef4gI
         /BPfJW7pFf2U5px5lku6muohvA68tthtdC7Lhyb87/UI5Bu4/Jlg8JOduhqiEJ9+rgaX
         vCdRRaQTEpXXgdWnUpi2+/iTHDuzGK5+5R0b8S/141BAwjtTA63nai/LWI5o3cTyjtus
         Br3K2LY6m2K0OtZB9cRyOI/bfBXbAKc7PEa6kErY7FspKFGDwTlbOcaGO9gXo3zTOtDH
         nzTzGhW7qgthfzVU2CtoKVBzNwINXSdWiBLn+V9z56oCgz9wZWoQaPMRSEpOrr2ArRqi
         PaDw==
X-Gm-Message-State: AO0yUKXkwElOpXRKxg0SHoesJwg5hMWtftnGYUG8FtzXheNKEWrjzAQQ
        9IAzJTEtrvZcQXmCWtDTpAKICg==
X-Google-Smtp-Source: AK7set+bcQ0uYZj3HdW+5cFNLawHTRc6K780n1e0pMVm/oqSPl7N0qrcpd6wOKFuR+f8L5wtBku57w==
X-Received: by 2002:adf:f111:0:b0:2c3:f06f:850c with SMTP id r17-20020adff111000000b002c3f06f850cmr20889689wro.31.1676285126140;
        Mon, 13 Feb 2023 02:45:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe8c6000000b002c55551e6e9sm3416169wrn.108.2023.02.13.02.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:45:25 -0800 (PST)
Message-ID: <6cffa875-d8cc-a4fe-e18d-2e24c28a49d8@linaro.org>
Date:   Mon, 13 Feb 2023 11:45:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Novatek NT36523
 bindings
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230210161925.32343-1-lujianhua000@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230210161925.32343-1-lujianhua000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 17:19, Jianhua Lu wrote:
> Novatek NT36523 is a display driver IC that can drive DSI panel. It
> is also present in the csot and boe video mode panels. It is found
> in Xiaomi Mi Pad 5 series.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
>  .../display/panel/novatek,nt36523.yaml        | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> new file mode 100644
> index 000000000000..a7098d0ce7e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/novatek,nt36523.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Novatek NT36523 based DSI display Panels
> +
> +maintainers:
> +  - Jianhua Lu <lujianhua000@gmail.com>
> +
> +description: |
> +  The nt36523 IC from Novatek is a generic DSI Panel IC used to drive dsi
> +  panels.
> +  Right now, only support cost and boe LCD display panels with the

boe? both?

> +  resolution of 1600x2560. It is a video mode DSI panel.

The binding or hardware supports only 1600x2560? The how it can be
"right now"? It's defined, isn't it?

> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - xiaomi,elish-csot-nt36523
> +          - xiaomi,elish-boe-nt36523
> +      - const: novatek,nt36523
> +    description: This indicates the panel manufacturer of the panel that is
> +      in turn using the NT36523 panel driver. This compatible string
> +      determines how the NT36523 panel driver is configured for the indicated
> +      panel. The novatek,nt36523 compatible shall always be provided as a fallback.

Drop description. First it is free form text of binding, so unnecessary.
Second, does not really bring any new information.

> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: phandle of gpio for reset line - This should be 8mA, gpio
> +      can be configured using mux, pinctrl, pinctrl-names (active high)

Simplify description - 90% of it is redundant and only drive strength of
8 mA is important.

> +
> +  vddio-supply:
> +    description: regulator that supplies the I/O voltage
> +
> +  vddpos-supply:
> +    description: positive boost supply regulator
> +
> +  vddneg-supply:
> +    description: negative boost supply regulator
> +
> +  reg: true
> +  ports: true
> +  backlight: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vddio-supply
> +  - vddpos-supply
> +  - vddneg-supply
> +  - reset-gpios
> +  - ports
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |+

Drop +

> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi0 {

dsi {

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "xiaomi,elish-csot-nt36523", "novatek,nt36523";
> +            reg = <0>;
> +            vddio-supply = <&vreg_l14a_1p88>;
> +            vddpos-supply = <&lcd_vddpos_5p5>;
> +            vddneg-supply = <&lcd_vddneg_5p5>;
> +
> +            backlight = <&backlight>;
> +            reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
> +
> +            ports {
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +
> +              port@0 {
> +                reg = <0>;

Mixed up indentation.

Best regards,
Krzysztof

