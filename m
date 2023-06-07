Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D7A7261DE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbjFGN7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbjFGN7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:59:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566F81FF1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:59:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9745d99cfccso1040271266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686146360; x=1688738360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RFkWycW6XB7DoQU4+95hgOLZaJ9MmCqICTZvyaEpZIQ=;
        b=SSFsJiZ2QNhdfivj8wIBcOvp2mvz3U7ksiMOIbUuDJHz1Njd+i0eUjquASK61xr5Y4
         RxpypbPzfSe7ZtbnZ4M13nvUEzzOet4ihVRFfIv1QR8PqHgD9AZsjT35qOsw/nOh2Dj2
         Vkz19SgOYGj6YlEWv30zIKHtjU7dDHP+xU2LiJug88NNvnbLidJc50S8bAOVvEZ2MJuX
         h/dT2Ykm48wpYlKDQUWjZHa4tBwYa2+MEsfX1y7w9ud2aBV/j1uIQjnax71kV6kAI44J
         mhpzflmNQXy/woniEXj3XLlQ76toGSh+mW0xuClNxAsS9kyS9traJZcjC9lw3P02LCNQ
         9VwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686146360; x=1688738360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFkWycW6XB7DoQU4+95hgOLZaJ9MmCqICTZvyaEpZIQ=;
        b=JQ+1jMCPQs8nBhzcOHBAhQgGigP5uXeGTLhxIKji9soKhsiZlopk1QwTtBwrTQ/YQV
         dLperKJVmZytGqNMq7uR/X7xdG19cHt1kc4hP5Rpkh9hUMsX47JZRek9lVVO5ZWSukfi
         IDksE+rOpqEKFt9xfBdhEG2fF+5m46TYaJ42oJKnRfEBbuA6Hz8McxtdL88AjfzERM+w
         t1ojDjYZVsDc7f39vei6awE8/51hwVUAj7kDZ8y+ZVmEOYHb/r5caDP7MNuIIEEfaKYD
         iNvAo5HXT4x9IPu5UwIO0JxpIAHXRJi+m87MztO1VHUKYRg4uKY80mfFmN/kkCMjCaxB
         DGxg==
X-Gm-Message-State: AC+VfDzlhlNS5FxYAhPes2pdCW3nODglSAHzJZlB4XyeIvCyP366Ztwt
        zp82paoqRLyE+nMVe4pQ88enyA==
X-Google-Smtp-Source: ACHHUZ7cl+L2KXdFp2rG5iVWinOrwOQOqHXvKEINORKaqwRPBu4nKgHpT831KsNV51xiwHZybriR6g==
X-Received: by 2002:a17:907:a426:b0:94f:2852:1d2b with SMTP id sg38-20020a170907a42600b0094f28521d2bmr5966494ejc.72.1686146360623;
        Wed, 07 Jun 2023 06:59:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id h26-20020aa7de1a000000b005148f0e8568sm6202646edv.39.2023.06.07.06.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 06:59:20 -0700 (PDT)
Message-ID: <f591d7d3-a728-af1f-d74d-24aec140fd46@linaro.org>
Date:   Wed, 7 Jun 2023 15:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/2] dt-bindings: HID: i2c-hid: ilitek: Introduce
 bindings for Ilitek ili9882t
Content-Language: en-US
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230607133458.4075667-1-yangcong5@huaqin.corp-partner.google.com>
 <20230607133458.4075667-2-yangcong5@huaqin.corp-partner.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607133458.4075667-2-yangcong5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 15:34, Cong Yang wrote:
> The ili9882t touch screen chip same as Elan eKTH6915 controller
> has a reset gpio. The difference is that ili9882t needs to use
> vccio-supply instead of vcc33-supply. Doug's series[1] allows panels
> and touchscreens to power on/off together, let's add a phandle for this.
> 
> [1]: https: //lore.kernel.org/all/20230523193017.4109557-1-dianders@chromium.org/
> 
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../bindings/input/ilitek,ili9882t.yaml       | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml b/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml
> new file mode 100644
> index 000000000000..f69fa3aaf4c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/ilitek,ili9882t.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ilitek ili9882t touchscreen controller
> +
> +maintainers:
> +  - Dmitry Torokhov <dmitry.torokhov@gmail.com>
> +
> +description:
> +  Supports the Ilitek ili9882t touchscreen controller.
> +  This touchscreen controller uses the i2c-hid protocol with a reset GPIO.
> +
> +properties:
> +  compatible:
> +    items:

Drop items, just const.

> +      - const: ilitek,ili9882t
> +
> +  reg:
> +    const: 0x41
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  panel:
> +    description: If this is a touchscreen, the panel it's connected to. This
> +      indicates that the panel and touchscreen are expected to be power
> +      sequenced together.
> +    $ref: /schemas/types.yaml#/definitions/phandle

"If this is a touchscreen"? Doesn't you description say this is
touchscreen controller? Then how this could be also not a touchscreen?

> +
> +  reset-gpios:
> +    description: Reset GPIO.

missing maxItems


Best regards,
Krzysztof

