Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A06366BBFF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjAPKk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjAPKkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:40:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D64019698;
        Mon, 16 Jan 2023 02:38:41 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9E4556602BBC;
        Mon, 16 Jan 2023 10:38:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673865520;
        bh=MJZ8hIGpWIRst0RKUwXcfgQlfIxWHuKlt8Ve6cCdatc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Fz7Yq4eLkD1ujs7uy2bxt9BmtxdooCGyKLrIDW27LPcX2ZfpnAnumolgILTYLluWN
         5UqVsYNA/Ggz3Wu+4ATrr8ffyfDJ8JcpMpRDI6dveZAuWPOunlGpABFKfRfvM9WwxX
         dOiwbLgGHmET9w0WY76jzLTggz+rcP3kdYgNW9BsF//HCMRqRegRLgvIO1iZVEOf+8
         rW0AiInn9s1lAX17ZmiUayWtKJDApLIAQPtr7pAztrlpCkKFyxfTRczJ9psQaXWATm
         wFU9eAjq1Dbpejgle5/wqY7bRvOuGu+nGUq2Ghyr3/eYWFb3qn9Z66jsF5gqym1ye6
         HY9CKAB1PVycw==
Message-ID: <256c2328-a426-a1bf-4f47-1d6c9e706f63@collabora.com>
Date:   Mon, 16 Jan 2023 11:38:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 2/6] dt-bindings/thermal/mediatek: Add dt-binding
 document for LVTS thermal controllers
Content-Language: en-US
To:     bchihi@baylibre.com, daniel.lezcano@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230112152855.216072-1-bchihi@baylibre.com>
 <20230112152855.216072-3-bchihi@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230112152855.216072-3-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/01/23 16:28, bchihi@baylibre.com ha scritto:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add dt-binding document for mt8192 and mt8195 LVTS thermal controllers.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>   .../thermal/mediatek,lvts-thermal.yaml        | 140 ++++++++++++++++++
>   1 file changed, 140 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> new file mode 100644
> index 000000000000..43b8777fc1b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/mediatek,lvts-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek SoC Low Voltage Thermal Sensor (LVTS)
> +
> +maintainers:
> +  - Balsam CHIHI <bchihi@baylibre.com>
> +
> +description: |
> +  LVTS is a thermal management architecture composed of three subsystems,
> +  a Sensing device - Thermal Sensing Micro Circuit Unit (TSMCU),
> +  a Converter - Low Voltage Thermal Sensor converter (LVTS), and
> +  a Digital controller (LVTS_CTRL).
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8192-lvts-mcu
> +      - mediatek,mt8192-lvts-ap

I agree, MT8192 has LVTS... but you don't have it in the driver?
I don't think that it would be much effort to just add it to the commit that
adds the driver itself... otherwise, even though bindings are describing the
hardware and not the drivers, I, personally, don't really like to see the
binding advertising mt8192 mcu/ap while it's not really supported in the driver.

Regards,
Angelo
