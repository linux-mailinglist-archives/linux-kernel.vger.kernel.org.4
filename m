Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18274706C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjEQPFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjEQPFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:05:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6976F1FE3;
        Wed, 17 May 2023 08:04:50 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 670CD660588A;
        Wed, 17 May 2023 16:04:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684335844;
        bh=15/GPkh3GbUYvzSc+PhVVCS+jBcNyePbbCQd7vQAmVA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oKXUwZG9/NNSqz2qObRQWaH8It+qDv2WRxyA1jEfwjltkbIPLkPXAWMzt9rlK4n6U
         508s0+CEm0QAUFmbpUaJfba/+2WjZQkSIaSI0q+ZKhwDjxTbM3bnjpwTCnY970gNTW
         M2x+b67vXcnj1n3FTh+1b5JyPjsKMfoK2uaFs3vALadtC/Np4dMXRMkADa8zE7+vK0
         +KqbNVfPLFHwHOH3jWtaxDB8SrcrU27c11pSCx+eCyzl/ZTEl0c+ZU6YOYz56j4rad
         hit+TkEHkn3KPk1c9uTpq+nllv/yuAXEmqVhI6CynmLCmcJAOYz8azGU3rkbosmCgQ
         hMvQnoCCX+2tA==
Message-ID: <c32f0c3f-b43a-7045-38cc-2c11c7bb571e@collabora.com>
Date:   Wed, 17 May 2023 17:04:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 7/7] dt-bindings: Add bidings for mtk,apu-drm
Content-Language: en-US
To:     Alexandre Bailon <abailon@baylibre.com>, airlied@gmail.com,
        daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        jstephan@baylibre.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, khilman@baylibre.com,
        nbelin@baylibre.com, bero@baylibre.com
References: <20230517145237.295461-1-abailon@baylibre.com>
 <20230517145237.295461-8-abailon@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230517145237.295461-8-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/05/23 16:52, Alexandre Bailon ha scritto:
> This adds the device tree bindings for the APU DRM driver.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Reviewed-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   .../devicetree/bindings/gpu/mtk,apu-drm.yaml  | 38 +++++++++++++++++++

mediatek,mt(model)-apu.yaml

>   1 file changed, 38 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml
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

const: mediatek,mt8195-apu (or whatever else).

...besides, I don't think that this patch even belongs to this series? :-)
Spoiler alert! :-)

Cheers,
Angelo


