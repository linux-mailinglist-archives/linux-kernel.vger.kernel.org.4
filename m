Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB65A60660A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiJTQmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJTQmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:42:07 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD7E19899D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:42:05 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id s3so14051910qtn.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGAAR2BMfaAANWL2R8YcIVSEZh0G1rs0+++u0ybOJWQ=;
        b=n9XO8dfIA6PtGSlMXzxeoH5vZLkJN/qPgV+9tdRknUZG9vkEbK+vAr02Hje6yei4YG
         WqFrxGj8dglk1yNeyhUhkGK2nnlp7t1KTi6BqKbtRDDIsWayM0Pris8nlEorXXLQXfkq
         GKQfpFwTu7EKpyQ02ojTPzNq9mWTw1Gmd0zNpqmIYJevGw1Owa+VXYqqEyVOiLvgPYb1
         8Ap1gf/q6OFbelFhFyQUnS46Vj5IR0j+7uEK3XCdaI48VlVQfLEUyDjSP0X+BXPPoxaM
         SPFL/YxjgVxxaEUz6ZfAfoX0ZymwnTJiAQL7Vd5vZMFvNn/0w1/isSUIGKljQtqmhvuq
         ATcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGAAR2BMfaAANWL2R8YcIVSEZh0G1rs0+++u0ybOJWQ=;
        b=B+g073bZZCCJeaZHMBnv2yeGqJJTUnSczmLC+uzyvmBVWTm4vIIaqzoLm17OY0GAxT
         XKWlEn/yq0e5/F/+7TDypBp6Ufi75sz2ZXi3RRWmPa9IOJYY3E5/SaUIbRZ3Agu2KmjR
         ZX3zJX7u4JDYtyT4+UO3EFM5G/yWmkH1WRNI9Gh17OUODttQMWyHqmvWLQLRC2VVWl+3
         psAw7hKIO6uVhaoc9lNL0nCClys3FjpAfYlk624uKt2mkVLYqCz1l9YS4istce/b6a2W
         ZEOXApgWC/X1h5PcxvBIOaXHg0poYSOyt+rNflOGYKxLLudViioRC6h4GdsRMCnKZARU
         o2MA==
X-Gm-Message-State: ACrzQf1VdO3uTvevR5ctu2exoKlr73RkLjIHqfnnmeyVA8m0Q1HPiF1c
        TSojOz3yC65GOx78F8yKFf9rww==
X-Google-Smtp-Source: AMsMyM5IomthQmzdC4Dq9NmLfyL4YqW1be9IT8LtgUzuYA0I8nVmUicKpJz0j8BzM1Xg/OxBPyArow==
X-Received: by 2002:ac8:5d88:0:b0:39d:804:90a5 with SMTP id d8-20020ac85d88000000b0039d080490a5mr5811848qtx.20.1666284124103;
        Thu, 20 Oct 2022 09:42:04 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id w28-20020a05622a191c00b0039bfe8acff6sm6249223qtc.58.2022.10.20.09.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 09:42:03 -0700 (PDT)
Message-ID: <3cf2801c-9be5-c012-606e-d8fb7c4a218f@linaro.org>
Date:   Thu, 20 Oct 2022 12:42:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 3/5] dt-bindings: regulator: Add binding schema for
 mt6357 regulators
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
References: <20221005-mt6357-support-v3-0-7e0bd7c315b2@baylibre.com>
 <20221005-mt6357-support-v3-3-7e0bd7c315b2@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221005-mt6357-support-v3-3-7e0bd7c315b2@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 12:20, Alexandre Mergnat wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add YAML schema for the MediaTek MT6357 regulators.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  .../regulator/mediatek,mt6357-regulator.yaml       | 292 +++++++++++++++++++++
>  1 file changed, 292 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml
> new file mode 100644
> index 000000000000..8dc1245304be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml
> @@ -0,0 +1,292 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6357-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6357 Regulators
> +
> +maintainers:
> +  - Fabien Parent <fabien.parent@linaro.org>
> +  - Alexandre Mergnat <amergnat@baylibre.com>
> +

The binding looks ok, but to be sure: you are aware that this schema is
not effective, does nothing without being referenced somewhere? And that
we do not see this reference neither in the patchset nor in cover letter?

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

