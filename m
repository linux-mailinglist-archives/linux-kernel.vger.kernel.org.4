Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CF56320A8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiKULbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKULbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:31:04 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0CFBEB64
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:25:43 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id x21so14109325ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVDTaihieHQletiACBV4ZG6LRAsVDgCwKqVNhlyzBKQ=;
        b=BswMM7GbaH9e9T8WrNTV2GfQ7T204jYhwzSzfZVqu/vOhcEwTQ5S6cTVJUWolF4oT+
         pGPw7QB+Zakp9bB36dGLnQq8iTuIK/FgYnz9PZguxtbKzIjcTZha+8jRlufW9ECXiG5A
         mDh19CNy9kExm7tCQ+AMdtN8CGGty6/oEWhb+GllGhdk1FSYuGxy0dsqIsK+ey7+M8R1
         x7nKXGHIwpg/BdDGAJSgKZl1jZOanF7nObt5KYnCQJf9a8vZ9OMtblwxwQW58NiNItpT
         MQpwP8VZ04dZM4jrXpv5/JKbDnH1k+PJSSVc/YLeGYh1Ills+hyoNoNW0Sb/9clCVzeU
         sLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVDTaihieHQletiACBV4ZG6LRAsVDgCwKqVNhlyzBKQ=;
        b=4uUuJlaY2w8qTuV9lKos1zWfbDspTl39Od0040vx/U9vcxjk9UAwtU7srpUqHzRHHW
         Zm8JPY2HcVabEt50SoQ/CZPRiejMb/hWj1E3qqxh8rtc+Ws4x4OZe0SR6/pA8RHlgAjx
         AVn/HtPXqqtxu4xQm0wtczLWBB24+vSycD+5Di3QjpPOwXP4aTOUZWcCrNe2QIgL9hwh
         c+YMDqO8TzrMxD53xUk1gm1dNbm9cMUE5OQdtpjQn4gNHhI6JELCq43akdRmQPDN/VhY
         iB2Kz4hHH19pkEZFaB7rX+Cz//OoacbpCFVcorRu7rmteZuxBghNvAJYnXMmekSGIV/V
         sLQw==
X-Gm-Message-State: ANoB5pnMAMWik4ERJ86P5lffOrGgud9npGDALWrGVzLViPo3mcD1uZF3
        zHeqfkYEcBUA1gubY3PuqseNZA==
X-Google-Smtp-Source: AA0mqf4X+9qX44KXcgmzIJ5dTRVkjYSGgPQ1xzoRs9+wK/v1cF/aseBXifGyeRqDHLJyuD6+JFNl0g==
X-Received: by 2002:a2e:a238:0:b0:277:99b:3826 with SMTP id i24-20020a2ea238000000b00277099b3826mr5108664ljm.412.1669029941379;
        Mon, 21 Nov 2022 03:25:41 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v8-20020ac25608000000b004afd23cf7eesm1968241lfd.168.2022.11.21.03.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:25:41 -0800 (PST)
Message-ID: <259ad74e-ec86-34e6-661f-7b7b172c4ddd@linaro.org>
Date:   Mon, 21 Nov 2022 12:25:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH dt-schema.git] schemas: add NVMEM cell with
 #nvmem-cell-cells
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20221121105830.7411-1-zajec5@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121105830.7411-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 11:58, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Some NVMEM cells may provide more than 1 value. An example can be base
> MAC address that is used for calculating multiple MACs (for few
> different devices). For specifying value to read phandle needs to be
> used with an argument.
> 
> Cc: Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>
> Cc: Michael Walle <michael@walle.cc>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> This bit is required for moving forward with the
> [PATCH v2 00/20] nvmem: core: introduce NVMEM layouts
> https://lore.kernel.org/linux-arm-kernel/20220901221857.2600340-1-michael@walle.cc/
> 
> As pointed out by Rob #nvmem-cell-cells should be added to the dt-schema
> and not a Linux binding:
> Re: [PATCH v2 15/20] dt-bindings: nvmem: add YAML schema for the sl28 vpd layout
> https://lore.kernel.org/linux-arm-kernel/20220912192038.GA1661550-robh@kernel.org/
> 
> sl28 is one example that needs #nvmem-cell-cells
> u-boot,env is another one
> 
> Please let me know if I got this binding right at all.
> ---
>  dtschema/schemas/nvmem/nvmem-cell.yaml | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 dtschema/schemas/nvmem/nvmem-cell.yaml
> 
> diff --git a/dtschema/schemas/nvmem/nvmem-cell.yaml b/dtschema/schemas/nvmem/nvmem-cell.yaml
> new file mode 100644
> index 0000000..dfa99b8
> --- /dev/null
> +++ b/dtschema/schemas/nvmem/nvmem-cell.yaml
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: BSD-2-Clause
> +$id: "http://devicetree.org/schemas/nvmem/nvmem-cell.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/base.yaml#"

Drop quotes from both.

> +
> +title: NVMEM Cell Common Properties
> +description: "Schema for NVMEM cell devicetree bindings"

Drop quotes.

> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +# always select the core schema
> +select: true
> +
> +properties:
> +  "#nvmem-cell-cells":
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Drop quotes.

Rest looks fine to me, except a bit funny cell-cell name, but that's
just life. :)

> +    description: >
> +      Some NVMEM cells may consist of raw data that requires some extra
> +      processing. They may provide more than 1 value.
> +
> +      Passing extra argument(s) allows selecting data to access.
> +
> +additionalProperties: true

Best regards,
Krzysztof

