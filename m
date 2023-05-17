Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B1970725A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjEQTin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjEQTij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:38:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5706BA5D7
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:38:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so2214929a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684352298; x=1686944298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rYmCHe0UBx3C/dX8F6gPo606NtkPLb/fdOD1RWdJzkg=;
        b=bbeQg4UD9JQf6erRpGuPGkJefSXLT4EZPw4GEbdgBk0mXwtrOrR9bcUXhDi2lPmrN2
         SY7yGEyaW4rOcHsYnmhfbfOIS6WJ1P72cT7qjNOpW9e9rc3FGcQFKOsbTXyqHZrtQ899
         lqRpczEhCKHYqw4X4HXrLygrQOA/mDNmvSVqGhyLDEWHWAB/zQr8JeHGMe+cc++jTX3+
         eSn13zJdh+MYPqS1jaJc+8KRvKuuUOk4u1xn97NQgP9w5RgbAMncMp8edZUiMeKMhSn8
         2tX7xLkDwu4v49tQ/OTjPCt9qR94Xz6440yAu01sLictaBqTjYddsFD9G6rN0sIRFkMS
         RaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684352298; x=1686944298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYmCHe0UBx3C/dX8F6gPo606NtkPLb/fdOD1RWdJzkg=;
        b=lmWdamq+NMHb/Rx5Tp+LaP18Kopbq0NaVTLlM/7LJQiEXGkjxmUk+R66NOvv3e1paa
         btaBqzjm7zNG/+ALvSE0xghCLI7vFGUnTEjLcT83f5TbV5WfbYLQjiHq8mJOkUVazIh+
         WbIkcSVSuoLtKVvi+00eoMco3W0jHYX02ZiEn/1aYifBWu01+JAPdqN1kNDtKVU4BzIk
         RhLjDyIDyu4GfvyDB2mGxNHvB513k2vz+8Yo0Cz6ROGvuH+Mbz6pwejT5RWxxysIIk+R
         9ugU70F3KSJBJClKmPXs9Fg3RaInTjkAh4Cv+IFiuKYmcF0g4dalT9gdnxZc+GKP+IAz
         SAvQ==
X-Gm-Message-State: AC+VfDwaCcNxZtAScuI27rWqhOM0lAHCgeA18kIQbYDtL5xlQ0e+OYBv
        O99pqsf8YAy1NQddBNqnrT1CUA==
X-Google-Smtp-Source: ACHHUZ6obEbka8NNsbD0h9cxmp9F7B27iNr6Z+hy4ts3KoIhfXd8UU80M7LYR8OdkLm5EMLFayAcTw==
X-Received: by 2002:a17:907:97d0:b0:96a:2210:add8 with SMTP id js16-20020a17090797d000b0096a2210add8mr25616124ejc.8.1684352297680;
        Wed, 17 May 2023 12:38:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d7a:e7cc:21b3:c435? ([2a02:810d:15c0:828:d7a:e7cc:21b3:c435])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709067ccf00b0094f23480619sm12833636ejp.172.2023.05.17.12.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 12:38:17 -0700 (PDT)
Message-ID: <f0469fcb-a1ef-77a2-a8ab-40ab8d91bff7@linaro.org>
Date:   Wed, 17 May 2023 21:38:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 7/7] dt-bindings: Add bidings for mtk,apu-drm
Content-Language: en-US
To:     Alexandre Bailon <abailon@baylibre.com>, airlied@gmail.com,
        daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com, jstephan@baylibre.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, khilman@baylibre.com,
        nbelin@baylibre.com, bero@baylibre.com
References: <20230517145237.295461-1-abailon@baylibre.com>
 <20230517145237.295461-8-abailon@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230517145237.295461-8-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 16:52, Alexandre Bailon wrote:
> This adds the device tree bindings for the APU DRM driver.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Reviewed-by: Julien Stephan <jstephan@baylibre.com>

There are so many errors in this patch... that for sure it was not
tested. Reduced review, except what was already said:

> ---
>  .../devicetree/bindings/gpu/mtk,apu-drm.yaml  | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml b/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml
> new file mode 100644
> index 000000000000..6f432d3ea478
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpu/mediatek,apu-drm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AI Processor Unit DRM
> +
> +properties:
> +  compatible:
> +    const: mediatek,apu-drm

drm is not hardware. Drop everywhere or explain the acronym. If you
explain it like Linux explains, then: drm is not hardware.

> +
> +  remoteproc:
> +    maxItems: 2
> +    description:
> +      Handle to remoteproc devices controlling the APU

Missing type/ref. Does not look like generic property, so missing vendor
prefix.

> +
> +  iova:
> +    maxItems: 1
> +    description:
> +      Address and size of virtual memory that could used by the APU

So it is a reg?

> +
> +required:
> +  - compatible
> +  - remoteproc
> +  - iova
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    apu@0 {

Where is reg? @0 says you have it...

> +      compatible = "mediatek,apu-drm";
> +      remoteproc = <&vpu0>, <&vpu1>;
> +      iova = <0 0x60000000 0 0x10000000>;

Why would you store virtual address, not real, in DT? Let's say you have
some randomization like KASLR. How is it going to work? Drop, it is not
hardware property.

Best regards,
Krzysztof

