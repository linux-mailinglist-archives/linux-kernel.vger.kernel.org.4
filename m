Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D55A6716F2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjARJDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjARI7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:59:43 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C917611F2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:19:28 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h16so33063686wrz.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JEKWwonctGpIYQyBgQI4ckxGQ2LgFs9BvZSmjtP02g=;
        b=fpeFIu5SCiWtEqzPdjMpQQnizSO5gHn6+T9L7i5dI4vq1TwgPoyO+Mxc+G27U2jGEl
         uV3+vDLrYYQ0pKO+ekeTkzFqUzbdFZUB6yGM718pxmjsW2V8dk8dv/0zM6lu4/vPfBdf
         sWO/UtTk2hA0lONjcHhDSUK8R0CmJGti2Qw2LVjztthaM+/IVeiKjAu6J+zktnrqAwml
         Tf7PPxd7YlGEuIYs0oGVAm+Uq1aZz0ZtsXTCd8mwh84w86bS3PzcDTn+A10dEbifl/+A
         CLMwomuVhrhQ1jX+CMv6TcIBO/JF6dlANR9gkSunl8P2A+FALJ2D2//M6NwoCC9ninaS
         +F6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JEKWwonctGpIYQyBgQI4ckxGQ2LgFs9BvZSmjtP02g=;
        b=fwXxA51tm9IabhTPO1K3NR7IIydSyun9v+KBglc18sNtjR+H/QR6okBYmlu20lke1R
         abLodFJtQUIt9jBmsFMp5ZIBcbLgZX7kzMIC4gObuVJikMa+zCbs/NA+uNhBAWUx7tXm
         akkSdRsbx4mN934PmiBZun7D4qFUwSJjnM4SVzYwlYBK1ojm+prQUi1O5OikTCYf+/b/
         GnuRcYte/cY8UCgsv+dYJQFJ/qsDJUHa3HUWeC4ZBEsNhpfvTAS+rXB2olqclKLmurq0
         /9P3kTyg2I+C04Vbjf8YlP5uliIQ+R7aPF/Wi+ev8auvD64rSc8ZkCMiIags2hjkYtjA
         GKXw==
X-Gm-Message-State: AFqh2koVE5UR1qe0Z0kc+Z2pOTvFHzOfbzDZNjE9ViUUgnBRDAKH0E1V
        e4u6T4hXQFt/9jTjxkbgiXI0jA==
X-Google-Smtp-Source: AMrXdXtxvx6Qk2yzHCCoZTw0Gh6jNnIwwmM6YD/JTJFYkSjAFXi/y1n5cO2P1+elzl5fykTlk+PbJQ==
X-Received: by 2002:a5d:50c9:0:b0:2b4:790e:32f3 with SMTP id f9-20020a5d50c9000000b002b4790e32f3mr4986316wrt.68.1674029967087;
        Wed, 18 Jan 2023 00:19:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e7-20020a056000120700b00241dd5de644sm30685430wrx.97.2023.01.18.00.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 00:19:26 -0800 (PST)
Message-ID: <2c17eaa5-ee93-58c5-a35a-8366eb4cfc36@linaro.org>
Date:   Wed, 18 Jan 2023 09:19:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 6/9] dt-bindings: usb: Add binding for Via lab VL817
 hub controller
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230118044418.875-1-linux.amoon@gmail.com>
 <20230118044418.875-7-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118044418.875-7-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 05:44, Anand Moon wrote:
> The VIA Lab VL817 is a USB 3.1 Gen 1 hub and USB 2.0 hub
> controller that features 4 downstream ports and 1 otg, with
> an internal 5V regulator and has external reset pin.

Subject: drop second/last, redundant "binding for". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> Add a device tree binding for its USB protocol part.
> The internal LDO is not covered by this and can just be modelled
> as a fixed regulator.
> 
> Add combo of USB 2.0 and USB 3.0 root hub using peer-hub.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v2 - fix the compatible string and fix the $id
>    - update the commit message.
>    - update the example for use peer-hub node because it
>      combo of USB 2.0 and USB 3.0 hub.
>    - rename the yaml file from vialab,vl817q7.yaml to vialab,vl817.yaml
>      as q7 suffix is ued for USB 3.1 and q5 suffix is used for USB 2.0.
> ---
>  .../devicetree/bindings/usb/vialab,vl817.yaml | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/vialab,vl817.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
> new file mode 100644
> index 000000000000..5f9771e22058
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/vialab,vl817.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Via labs VL817 USB 3.1 hub controller
> +
> +maintainers:
> +  - Anand Moon <linux.amoon@gmail.com>
> +
> +allOf:
> +  - $ref: usb-device.yaml#
> +
> +properties:
> +  compatible:
> +    items:

Drop items

> +      - enum:
> +          - usb2109,2817
> +          - usb2109,817
> +
> +  reg: true
> +
> +  reset-gpios:
> +    description: GPIO controlling the RESET# pin.

maxItems

> +
> +  vdd-supply:
> +    description:
> +      phandle to the regulator that provides power to the hub.
> +
> +  peer-hub:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'

Drop quotes

> +    description:
> +      phandle to the peer hub on the controller.
> +
> +required:
> +  - peer-hub
> +  - compatible
> +  - reg

Keep same order as in properties: part.

> +

Best regards,
Krzysztof

