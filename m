Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7087C6E3FCE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjDQG24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjDQG2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:28:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E685AAB
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:28:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id c9so22408907ejz.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681712931; x=1684304931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FWt4j1Xyr69lbkAY813rpWiC/cGT82L+jMmEMr4HTcs=;
        b=loFYBhfJt3dyjdU6SBduolRdS1nAAbq6hyS4FSac/F2myypjS70HKvGuQwokG9V/zn
         lXP0WUl2QXmJ78Kxu6XsdtICqQp4evc0ovNa42HG/FK9qpAGMuxZeg7dqFMZNkfO7WsN
         bqFRdzxoeIkLSay0RyFZ3R4AsYQXRbwTrRVD3LC8vITg7SrTvi7Wg4xt1v58+/hVkiLD
         n+f/GWS21UZ6s0dCcqeeKxb46yY1uTzr8hA5X8L4yinlEhiAQa3ylZ/auPwYvoYhXlsH
         AlUwd4BeXZEFqbid2ttprh/XTf7wrOkG2vOTBftRHrwNJ/n+aJLIKs/NIGHmsK3O8zMS
         NVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681712931; x=1684304931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWt4j1Xyr69lbkAY813rpWiC/cGT82L+jMmEMr4HTcs=;
        b=EQtxZ8kJnYu9Kj/KzCOA9oNNDTl2as2aG0nbkekXmwoNvZ5FCgTvo1hQWVjZBimPbj
         uOmyxD3/EB4OacCfj9d7A9euiqq5v+6MjcVIadtTJpX3WZEN1OCHRYJ1DVFGFGFyNMTk
         TmTGV/KUM7jMCCgv++/QSj0Vr4vCihhmugOtBMZ5IzX3+Z3zlTKxwwPOWgQ2kHBSfEuV
         9xyoZp7sfq0ypYkgOMBbNw2k6Uwj+Whwz5a99fgh8vvRvJNotIW8RmDTviqlchQQhNWo
         FYH7Nx3VJAMP1KfMwoAM0MfTHsVWGsand69uy8DvZ7pfI3GVPLsFX4ZtdLMhR807xSt1
         JErQ==
X-Gm-Message-State: AAQBX9drFaOYKjN+srNlALqwwNwjopXXdHKYDZ8egNWoX9BZTfDagWYV
        gQS9PcprJy0pr67uV5mAnuvzew==
X-Google-Smtp-Source: AKy350aPIsKVFkNiUYJXoHhG85Ys1PSKY6PHLsNIO+VEZ20BRm9+qEcx56PYrkYAQUr7BtBudyZwJA==
X-Received: by 2002:a17:907:1c26:b0:94a:921b:c805 with SMTP id nc38-20020a1709071c2600b0094a921bc805mr8296953ejc.45.1681712931432;
        Sun, 16 Apr 2023 23:28:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b0ac:4d3b:966c:b33d? ([2a02:810d:15c0:828:b0ac:4d3b:966c:b33d])
        by smtp.gmail.com with ESMTPSA id la19-20020a170906ad9300b0094f8ff0d899sm525244ejb.45.2023.04.16.23.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 23:28:51 -0700 (PDT)
Message-ID: <dd3efedd-54b8-5d10-397f-4c7c2a62d3a2@linaro.org>
Date:   Mon, 17 Apr 2023 08:28:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/4] dt-bindings: clock: Add simple-clock-controller
Content-Language: en-US
To:     David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230416194624.1258860-1-mmyangfl@gmail.com>
 <20230416194624.1258860-2-mmyangfl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230416194624.1258860-2-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 21:46, David Yang wrote:
> Add DT bindings documentation for simple clock controller, just a
> contiguous region of multiple clock registers.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  .../clock/simple-clock-controller.yaml        | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/simple-clock-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/simple-clock-controller.yaml b/Documentation/devicetree/bindings/clock/simple-clock-controller.yaml
> new file mode 100644
> index 000000000000..3d9b436b0ef9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/simple-clock-controller.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/simple-clock-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple clock controller
> +
> +maintainers:
> +  - David Yang <mmyangfl@gmail.com>
> +
> +description: |
> +  A contiguous register region of multiple different clocks. No operations are
> +  required to enable or disable the clock controller.
> +
> +properties:
> +  compatible:
> +    const: simple-clock-controller
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  '.*clock.*':
> +    type: object
> +    description: Clock devices.

I don't know what improved here... this is still without any refs.

It looks like you ignored my feedback from v1 and maybe v2, so respond
to each of it.

Best regards,
Krzysztof

