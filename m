Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034505B6ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 16:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiIMOF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 10:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiIMOFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:05:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860AB21255
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:05:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bz13so20996593wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=j9AE7+MGh6BY4KWPPr0cYlAvnl+eZtdW7kdT8YeWHs4=;
        b=t7zXByxfhkphBgJbdx3n8AKs4Gz+pxXzSTFS5wBaNmr+qOv7Sr4XhjrvTVxIhkh0Ta
         8L75sQ/srTNdlt0SQfgnmHvUfxDGE6fJ8Au2UWZQO8Z8ZRfdjc78TCFNuEc+nN27fwh+
         Te4qdHZP09jJzN5Ry8mPXvWZZ+AOdbctnHFk50Qh5ITXsL/+jQadBoon96xZh+7IYJ9D
         +ws4w5IJuKdcfoHimVRKpfIv0eIuNPrbQFMQ5h2dtVW4RZ/Lk8S6bOjtH8vCKGMmDndV
         kPHLeVQMU1y8WZGAcKjK5Y3Wx+bALc6FahO41KIhhnhUDX7Xei0L8BPDsT6ggJFAzTLC
         Mn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=j9AE7+MGh6BY4KWPPr0cYlAvnl+eZtdW7kdT8YeWHs4=;
        b=xqTIzi3waP/AYPDURreD+hKvBTJKtJkWheaL4ELrhnExxI6/6VvFdBd9CHUElnKCXf
         Lbcj7AvTjDFGkIC35fWkyPsqmpsj4tfteUKrBQEkXdv7lN6WqiCzO+/V7iinofF6ouR/
         GZS3dK7icJ/DKpkR6WHxdHx6mEgwe8RiFdl1dltH32InMsYOtC8mtzSiKIwXyzJ9qQfx
         RCaOIIYenw0AScN2gWl7TcYzp/CPuo4eu1BpXM4fYnidc76cMzIqSHbEjE/8ZUr8GA+i
         CVOD/H430O2YIJQJaixyFHHugv7P+o35VlEDvCNWy3k+Nhn5Zg6wV6Pe3D8Z3V4zfuFK
         oYpQ==
X-Gm-Message-State: ACgBeo04TKX9MNE0dw3QKl1enI8mWTYsGYQGSY0eB3Gl6wEypxtenxWE
        t8WM0iUup+V0N7xQBr6wpQ9a/g==
X-Google-Smtp-Source: AA6agR6O1+8Y82XcsDX3f13kxIP4XvI+yu4ytmhCNVBE5REp8reHPbHcE+gUKAFUNjCG8wSqIsMnaw==
X-Received: by 2002:a5d:648c:0:b0:22a:2c04:97a5 with SMTP id o12-20020a5d648c000000b0022a2c0497a5mr16033680wri.326.1663077919967;
        Tue, 13 Sep 2022 07:05:19 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.67])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d6751000000b0021efc75914esm10468603wrw.79.2022.09.13.07.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 07:05:19 -0700 (PDT)
Message-ID: <638002c3-f402-96d3-7eb8-991f7f05f703@linaro.org>
Date:   Tue, 13 Sep 2022 16:05:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V2] dt-bindings: clock: add i.MX8M Anatop
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abelvesa@kernel.org,
        abel.vesa@linaro.org, sboyd@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220913092908.1708931-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220913092908.1708931-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 11:29, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8M Family features an anatop module the produces PLL to clock
> control module(CCM) root clock. Add the missing yaml file.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Drop syscon, use clock-controller
>  Add fsl vendor prefix
>  Add interrupt property
> 
>  dts update not included, so there will be dtbs_check fail.
> 
>  .../bindings/clock/fsl,imx8m-anatop.yaml      | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
> new file mode 100644
> index 000000000000..2c0efa58d898
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/fsl,imx8m-anatop.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8M Family Anatop Module
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +description: |
> +  NXP i.MX8M Family anatop PLL module which generates PLL to CCM root.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - fsl,imx8mm-anatop
> +          - fsl,imx8mq-anatop
> +      - items:
> +          - enum:
> +              - fsl,imx8mn-anatop
> +              - fsl,imx8mp-anatop
> +          - const: fsl,imx8mm-anatop

You dropped syscon which solves part of my previous comment. I suggested
to make it proper clock provider, so you would need clock-cells. Any
reason it is no a real clock provider?

Best regards,
Krzysztof
