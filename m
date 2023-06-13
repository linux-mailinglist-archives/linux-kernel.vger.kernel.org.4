Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BFC72DD0E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241813AbjFMIv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241805AbjFMIvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6C1188;
        Tue, 13 Jun 2023 01:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC05363305;
        Tue, 13 Jun 2023 08:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FCAC4339B;
        Tue, 13 Jun 2023 08:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686646307;
        bh=Fs2TQdypARqaeonb0tIJpF45H+5ETzPPP/OhXKzKJfg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Z1ugRPqQAgG7q4ip7dzx+ov4MrcxTdMzqcxqT48GRQbzkZeiwjw0PnWb547BsIhcv
         qCbTw0jLpG9oYZV8VzjskmU0ri0ZyMV0K+IBsnYJT4PaZpLclPb8hkk0RE4YuEzCRa
         niRBpSMapLcUCNEJ0M1uILKbwJJcPi/XXBDrbU6ay/AzQdcM3kWFaICDDB3qJzDRcl
         H4wA1GaRFxblgqutYYUKy4f0zhpbjB/9d2vA0twLy3PzOKJOLBJSxh6wieWtAiE2DF
         aU+7NC2+1Q248T8bDA9uNefaicnxqhbcIkO7sLvcNRIlycjOebK6VGsWj0YaXFvQ3r
         1aNYb0ahMjEAw==
Message-ID: <d9cd1ff3-b537-1481-9453-5b3683d30fed@kernel.org>
Date:   Tue, 13 Jun 2023 10:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt79xx-afe: add audio afe
 document
Content-Language: en-US
To:     Maso Hunag <maso.huang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230612105250.15441-1-maso.huang@mediatek.com>
 <20230612105250.15441-8-maso.huang@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230612105250.15441-8-maso.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 12:52, Maso Hunag wrote:
> From: Maso Huang <maso.huang@mediatek.com>
> 
> Add mt79xx audio afe document.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
> ---
>  .../bindings/sound/mediatek,mt79xx-afe.yaml   | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt79xx-afe.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt79xx-afe.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt79xx-afe.yaml
> new file mode 100644
> index 000000000000..11ef1cfdf49b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt79xx-afe.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mediatek,mt79xx-afe.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek AFE PCM controller for MT79xx

79XX sounds weird. Are you sure you are not using wildcards (which are
not allowed)?

> +
> +maintainers:
> +  - Maso Huang <maso.huang@mediatek.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: mediatek,mt79xx-afe
> +      - items:
> +          - enum:
> +              - mediatek,mt7981-afe
> +              - mediatek,mt7986-afe
> +              - mediatek,mt7988-afe
> +          - const: mediatek,mt79xx-afe

I already saw AFE, why it cannot be part of existing bindings?

This list is odd. 79xx, 7981? So it is wildcard?

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 5
> +    items:
> +      - description: audio bus clock
> +      - description: audio 26M clock
> +      - description: audio intbus clock
> +      - description: audio hopping clock
> +      - description: audio pll clock
> +      - description: mux for pcm_mck
> +      - description: audio i2s/pcm mck
> +
> +  clock-names:
> +    minItems: 5
> +    items:
> +      - const: aud_bus_ck
> +      - const: aud_26m_ck
> +      - const: aud_l_ck
> +      - const: aud_aud_ck
> +      - const: aud_eg2_ck
> +      - const: aud_sel
> +      - const: aud_i2s_m

Why this is variable?

> +
> +  assigned-clocks:
> +    minItems: 3
> +    maxItems: 4

Drop assigned-clocks

> +
> +  assigned-clock-parents:
> +    minItems: 3
> +    maxItems: 4

Drop



Best regards,
Krzysztof

