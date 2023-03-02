Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E606A851B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCBP0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCBP0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:26:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA2A30EAF;
        Thu,  2 Mar 2023 07:26:45 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 305C26602081;
        Thu,  2 Mar 2023 15:26:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677770803;
        bh=U11kXg9GMD7Whi/I3g38OrRrWVczX1UuFxzmgWtNI+U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hyoGZAPCwe9dYxoGWNhYLwv8fhpKyk3lsyOeMyTq9cx1QrgTxFCl0juYo+U10nWrk
         Ob0Rz2RqGbl0KKMOyMjYl70KWUOw9QIwosD7olxaz0TXrfBM9FFk/VMOUiF59y2OMJ
         avNMp8GJDK2uv/Ry4L+mr0kD5vq90vYMeuwPgUEf2dmuMK+BgqcptlmLscBd3w1yP4
         7hS34hG4i8cSW2buP1rrRsixbMRvbm+SawxVoK5f0deL5XmAja6w+ziA8fzFH6/L29
         RBQQMOf5Mdivv7RbjHXZRuUOl/SgSB7bn/smGswoa1F6t9u2/jZq1zg7jNaYmd0ql8
         WLgqaxCuu4bvA==
Message-ID: <f0def8ec-ae85-de89-f858-81847134d641@collabora.com>
Date:   Thu, 2 Mar 2023 16:26:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: power: Add binding for MediaTek
 MT6735 power controller
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230302122708.73848-1-y.oudjana@protonmail.com>
 <20230302122708.73848-2-y.oudjana@protonmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230302122708.73848-2-y.oudjana@protonmail.com>
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

Il 02/03/23 13:27, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add DT binding for MediaTek MT6735 SCPSYS power controller.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   .../bindings/power/mediatek,power-controller.yaml  |  2 ++
>   .../devicetree/bindings/soc/mediatek/scpsys.txt    |  1 +
>   include/dt-bindings/power/mt6735-power.h           | 14 ++++++++++++++

I know many others don't follow the right binding filenames and I am sure
you named it like that looking at the other ones, but please rename this
to mediatek,mt6735-power.h and resend.

The rest looks good.

>   3 files changed, 17 insertions(+)
>   create mode 100644 include/dt-bindings/power/mt6735-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index c9acef80f452..710db61cab53 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -23,6 +23,7 @@ properties:
>   
>     compatible:
>       enum:
> +      - mediatek,mt6735-power-controller
>         - mediatek,mt6795-power-controller
>         - mediatek,mt8167-power-controller
>         - mediatek,mt8173-power-controller
> @@ -81,6 +82,7 @@ $defs:
>         reg:
>           description: |
>             Power domain index. Valid values are defined in:
> +              "include/dt-bindings/power/mt6735-power.h" - for MT6735 type power domain.

P.S.: Don't forget to update this addition after the rename :-)

After - and only after - renaming,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
