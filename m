Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43385F4298
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJDMB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJDMBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:01:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5EA5509D;
        Tue,  4 Oct 2022 05:01:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2053766022A5;
        Tue,  4 Oct 2022 13:01:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664884882;
        bh=A7MNTJ0TsW7yBbyoUL3RijUBZGu+1+WZoLaPaVZq1U0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kmudWHRlDszFPl6449AfG8cVAE0WtPoFDHguqqG5EGiRVDCyy+50kd5SsUZEFRyd3
         U3SUEq1NLfdVBrGbdB86CV3z9o6nByC7s7YWAaG4C3jHr83mG8bJs76rpiVgV7O9E4
         u1IayTFR7LcuFxI7LgT+z2JcPsDtUYdgCP4RAouru+hHxZDO8lHT94m2wdcHtcBHzz
         PGvPlqGVsuZtJo2KEIvySMJEfwSNO8o5238wzJQAY6VPTx8wV3mPCi6QAm8hsoCzNQ
         dnTk7ktfSx8xW1ohRjV94uUucX45HoWdNPw3N7JJR7hgczpx4krPnySMpSOv/nJPPx
         x65056Ucgvrqw==
Message-ID: <900ad271-29ca-c6a1-bc6d-36256c02a34b@collabora.com>
Date:   Tue, 4 Oct 2022 14:01:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 1/3] dt-bindings: iommu: mediatek: add binding
 documentation for MT8365 SoC
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
References: <20221001-iommu-support-v2-0-dbfef2eeebc9@baylibre.com>
 <20221001-iommu-support-v2-1-dbfef2eeebc9@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221001-iommu-support-v2-1-dbfef2eeebc9@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/10/22 12:01, Alexandre Mergnat ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add IOMMU binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   .../devicetree/bindings/iommu/mediatek,iommu.yaml  |  2 +
>   include/dt-bindings/memory/mt8365-larb-port.h      | 90 ++++++++++++++++++++++
>   2 files changed, 92 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index fee0241b5098..4b8cf3ce6963 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -81,6 +81,7 @@ properties:
>             - mediatek,mt8195-iommu-vdo        # generation two
>             - mediatek,mt8195-iommu-vpp        # generation two
>             - mediatek,mt8195-iommu-infra      # generation two
> +          - mediatek,mt8365-m4u  # generation two
>   
>         - description: mt7623 generation one
>           items:
> @@ -130,6 +131,7 @@ properties:
>         dt-binding/memory/mt8186-memory-port.h for mt8186,
>         dt-binding/memory/mt8192-larb-port.h for mt8192.
>         dt-binding/memory/mt8195-memory-port.h for mt8195.
> +      dt-binding/memory/mt8365-larb-port.h for mt8365.
>   
>     power-domains:
>       maxItems: 1
> diff --git a/include/dt-bindings/memory/mt8365-larb-port.h b/include/dt-bindings/memory/mt8365-larb-port.h
> new file mode 100644
> index 000000000000..56d5a5dd519e
> --- /dev/null
> +++ b/include/dt-bindings/memory/mt8365-larb-port.h

Let's start using the correct filenames for memory bindings as well, shall we?

Please rename this file to mediatek,mt8365-larb-port.h

Thanks,
Angelo


