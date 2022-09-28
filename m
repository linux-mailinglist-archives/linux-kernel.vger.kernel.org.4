Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531F35ED9BA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiI1KD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbiI1KDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:03:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B31F1840
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:03:06 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i26so19577376lfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=TEWocC+tj2xcNali2Qbyk/V9ZjXxIkXbOm3FYNklfEI=;
        b=MN7B4mhCX859zT/yrmW+I1P9YgX/2MvgTcKT6SecWc+1imbNDTGRve09i0MuR4oevc
         cI8l+h5qOuatF4/dRIsTqPm/BgWRGJbXqs7jMZfcIPkI0StPbr6M9XK37zGcbuntY8qy
         MLWJYOr/AS3VpdB3H26M27uNLPUf63hUW3D8PAk3y4k6HKoEMCW6PIZpknnaGjeYLJef
         YbdiIde8LEdL+eZm0wdg+pIsID4vYjBRsizdI7dQUv9Dsf4Ye6JJilTF9ZOIbjecsQXy
         qNCVt+n/rmypBrjTVUXA5k83uDd5w2EqOyANAcTk+qP/gkbW5AUV5YlM/tFJ44f0w/w3
         ZjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TEWocC+tj2xcNali2Qbyk/V9ZjXxIkXbOm3FYNklfEI=;
        b=D3TjzgSgZMpoubJg5qUOgc4IoyUrPJnnTlDuw3ouqy9GRQFHsN4qFtdfeV+AGqD3C9
         T91LEEv3DnUAj7GacPBZxtEvUKvUfnj5Wx6T0JTmdZtNVJtC/37JYVvv28gbmO3J7RKv
         Ty6TxXHVPjWba1ihbTNp3qb8GjAJIddqqUFUApj701yWGZYH9eFpnaImfPDcR1AeLt7h
         NEMayzCq2GTPjab2deEFFcW4BqLbwsP0OoKRHtS+AJOYtk4F8+VlUyT0hSMlI5RFqOx3
         KmOmaO/pvZzwK7vPsT0HCIHlU7Qdie8LDoFvMPkWtXiENf/Xm5Ue/WX8J2JxOQbTlhRc
         VuOw==
X-Gm-Message-State: ACrzQf2PrlF9VwpPk7OQB1zv424RssGO72ZncHtDTdp+21Uw3d2S0LcD
        JPMG6hFVwQgdulZCs1uralmG6Q==
X-Google-Smtp-Source: AMsMyM4qczTLCl0p3QuHE8hFtHN+/tWlnQd2LvIsyAM1sgbKXEwkDRSutNAUKQ0fuIftOov8+87scw==
X-Received: by 2002:ac2:5a49:0:b0:49f:f620:b81b with SMTP id r9-20020ac25a49000000b0049ff620b81bmr12383716lfn.307.1664359384789;
        Wed, 28 Sep 2022 03:03:04 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b28-20020a05651c033c00b00261ccf566e3sm386431ljp.65.2022.09.28.03.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 03:03:03 -0700 (PDT)
Message-ID: <df396303-aa88-04ee-54fa-fe971409737c@linaro.org>
Date:   Wed, 28 Sep 2022 12:03:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [V16,01/15] dt-bindings: mediatek: Add mediatek, mt8195-jpgenc
 compatible
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com, wenst@chromium.org,
        kyrie wu <kyrie.wu@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, Rob Herring <robh@kernel.org>
References: <20220928093258.32384-1-irui.wang@mediatek.com>
 <20220928093258.32384-2-irui.wang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928093258.32384-2-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 11:32, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add mediatek,mt8195-jpgenc compatible to binding document.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> Signed-off-by: irui wang <irui.wang@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../media/mediatek,mt8195-jpegenc.yaml        | 146 ++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> new file mode 100644
> index 000000000000..5c7ba5c7e598
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mt8195-jpegenc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek JPEG Encoder Device Tree Bindings

Drop "Device Tree Bindings"

> +
> +maintainers:
> +  - kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>
> +
> +description:
> +  MediaTek JPEG Encoder is the JPEG encode hardware present in MediaTek SoCs
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8195-jpgenc
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  iommus:
> +    maxItems: 4
> +    description:
> +      Points to the respective IOMMU block with master port as argument, see
> +      Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
> +      Ports are according to the HW.

Missing blank line.

> +  dma-ranges:
> +    maxItems: 1

Best regards,
Krzysztof

