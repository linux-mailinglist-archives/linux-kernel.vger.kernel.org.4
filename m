Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CD16D292E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCaUMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCaUMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:12:35 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE04D21A82
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:12:33 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g19so17278669lfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680293552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3pYGyilJ6BcdJCkUm0wMYU9HfC+VKc1Mkn91BtgB/Q=;
        b=JJObS8Jb0P1VXNVMxu4cUvGe0LMKzr7kfnKK76FiIafs0Ukrfe2NSXWpaPkHlDcGLk
         khNm0FswewEfAjpNUz6PeEsEb/XcK7PR/61fKYY1qaX9FV0atWcKRIrNcE0m2W2ExgZ/
         sSbs6FSbM6s1W3qX1pCgRSiF4do1EGg+sirHB6JAJB4/743gdHlJ2gth17Kewq85MnwQ
         iQtMN6qV5bGZNJ5GcWX0WOj4DUb+7uRATktpODSUS+vF/NnUYLGEyl0CmebyMH0/NNBD
         DszhTWl5fK3CHapazGmCWDg1yUIKe/Ta9xInihhXX1rl/TJUScj8nJs1dqk6bBw7iwnT
         hXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680293552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3pYGyilJ6BcdJCkUm0wMYU9HfC+VKc1Mkn91BtgB/Q=;
        b=KjlctFM2XaZdm9jM5W/pbNZ9kHn6DHWd+BBnMDjqTKcsfJUirOTOXfMuM9uieBv2m/
         N6JKgrKhyFC6asYPJdv6lfoWEOO4Eb6QB1fmYrKGkWEFdqlYQB7Td8sUEjDGh2jG7f4o
         r6C3DsT7t6Ox4w4r581rkjEtIRIePSZHhwlLxfTM9AdjBf8YY+5gnVzKH4m7q6AsFP1Q
         kvCovTs/eCi54GDL67bmx5ATOrpTsNXNKgx/N0cIoKDo7ixihaxtaQJlon2gPBCXlLH6
         fKMQxgiZIYQNcFNBWAztCrDaYnh4wcrbGXTsJrHBoU0iUefgfOhRvuZnmtARonio/b/d
         h9vA==
X-Gm-Message-State: AAQBX9cv3xZa8MeY6AGfAln/ipEqI7/SvsRHTFy0pBWoofUtRVQNfhAJ
        D+qIXX5yhdigt/d0bYuI9o2J4g==
X-Google-Smtp-Source: AKy350YNFzAU3sTM3M/MFWfY6C7MugDxjTJ4aaT4Al+K76VNuhgyU41HPhXD6E5CBGnFK8iPJtGltQ==
X-Received: by 2002:ac2:4a6d:0:b0:4ea:e296:fe9e with SMTP id q13-20020ac24a6d000000b004eae296fe9emr7781234lfp.9.1680293552070;
        Fri, 31 Mar 2023 13:12:32 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w14-20020a2e9bce000000b00295a5aa9d05sm492863ljj.120.2023.03.31.13.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 13:12:31 -0700 (PDT)
Message-ID: <0aa3a039-daf3-7e05-6da9-258335a5ca20@linaro.org>
Date:   Fri, 31 Mar 2023 22:12:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 3/9] media: dt-bindings: cadence-csi2rx: Convert to DT
 schema
Content-Language: en-US
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, changhuang.liang@starfivetech.com
References: <20230331121826.96973-1-jack.zhu@starfivetech.com>
 <20230331121826.96973-4-jack.zhu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230331121826.96973-4-jack.zhu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2023 14:18, Jack Zhu wrote:
> Convert DT bindings document for Cadence MIPI-CSI2 RX controller
> to DT schema format.
> 
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> ---
>  .../devicetree/bindings/media/cdns,csi2rx.txt | 100 ----------
>  .../bindings/media/cdns,csi2rx.yaml           | 174 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 175 insertions(+), 100 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.txt
>  create mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt b/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
> deleted file mode 100644
> index 6b02a0657ad9..000000000000
> --- a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
> +++ /dev/null
> @@ -1,100 +0,0 @@
> -Cadence MIPI-CSI2 RX controller
> -===============================
> -
> -The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
> -lanes in input, and 4 different pixel streams in output.
> -
> -Required properties:
> -  - compatible: must be set to "cdns,csi2rx" and an SoC-specific compatible


...

> +$id: http://devicetree.org/schemas/media/cdns,csi2rx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence MIPI-CSI2 RX controller
> +
> +maintainers:
> +  - Maxime Ripard <mripard@kernel.org>
> +
> +description:
> +  The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
> +  lanes in input, and 4 different pixel streams in output.
> +
> +properties:
> +  compatible:
> +    const: cdns,csi2rx

That's not equivalent conversion and your commit msg does no mention any
drops in compatibles.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: CSI2Rx system clock
> +      - description: Gated Register bank clock for APB interface
> +      - description: pixel Clock for Stream interface 0
> +      - description: pixel Clock for Stream interface 1
> +      - description: pixel Clock for Stream interface 2
> +      - description: pixel Clock for Stream interface 3
> +

Best regards,
Krzysztof

