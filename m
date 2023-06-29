Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318A37428F9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjF2O6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjF2O6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:58:40 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3095A2D56;
        Thu, 29 Jun 2023 07:58:39 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-78363cc070aso31992239f.1;
        Thu, 29 Jun 2023 07:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688050718; x=1690642718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljRf0hyGo8Gpwci5RsjZ1gzHX+tCb5+i5VvfOpLuGAs=;
        b=ZUfU8MANCNlulWXcIvFMqx263aH2ph7uYq7s0Jmmj6CKGPnQGZpfKBk9y32eSnPqK/
         0xp+6DHuB2lLHEXonqZIsutmBIYG3GvRne+qZLcTifdr0265uuwm13h3vKEOl1IZ2Q5d
         YUiwbEr82E6QKT1eoweFrfNcTGCk0958cEnhIKYmN2Su1Fruo/158a2KTUHvdynR1u63
         wYaR0ewieZqym5tRt/SItlK9z1f7tQ6srwNzENOnnxuXdmNxgGEH+wPovE2xqKOuzx/o
         2LJqx7nsXo3L669u6Vaf/3fVZ1xbCezmG2d9bE5xiVFDFL2pseYv7Kx+wdQeZ9jF+kAl
         fDog==
X-Gm-Message-State: AC+VfDwTOFfDjISdkuDuUE+QmqmXzgUqfzefjl+7QBSjQo5fTDcaobUH
        XBSpZ3BebCeiIjO92gxoDg==
X-Google-Smtp-Source: ACHHUZ4fvxRFhvMqpuckwCnsXWFPC/rwz9erlSudSvlNJ+tRVLwMuByK8y5rQaap4kBc7/3o7vVugA==
X-Received: by 2002:a5d:8c86:0:b0:783:4bd2:3fd2 with SMTP id g6-20020a5d8c86000000b007834bd23fd2mr15394851ion.17.1688050718366;
        Thu, 29 Jun 2023 07:58:38 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m5-20020a02cdc5000000b0042036f06b24sm2857172jap.163.2023.06.29.07.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 07:58:37 -0700 (PDT)
Received: (nullmailer pid 2961403 invoked by uid 1000);
        Thu, 29 Jun 2023 14:58:35 -0000
Date:   Thu, 29 Jun 2023 08:58:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maso Huang <maso.huang@mediatek.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 6/7] ASoC: dt-bindings: mediatek,mt7986-wm8960: add
 mt7986-wm8960 document
Message-ID: <20230629145835.GA2954895-robh@kernel.org>
References: <20230626023501.11120-1-maso.huang@mediatek.com>
 <20230626023501.11120-7-maso.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626023501.11120-7-maso.huang@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 10:35:00AM +0800, Maso Huang wrote:
> Add document for mt7986 board with wm8960.
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
> ---
>  .../sound/mediatek,mt7986-wm8960.yaml         | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt7986-wm8960.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt7986-wm8960.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt7986-wm8960.yaml
> new file mode 100644
> index 000000000000..76394f7e5502
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt7986-wm8960.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mediatek,mt7986-wm8960.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT7986 sound card with WM8960 codec
> +
> +maintainers:
> +  - Maso Huang <maso.huang@mediatek.com>
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt7986-wm8960-machine
> +
> +  mediatek,platform:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of MT7986 platform.
> +
> +  audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description:
> +      A list of the connections between audio components. Each entry is a
> +      sink/source pair of strings. Valid names could be the input or output
> +      widgets of audio components, power supplies, MicBias of codec and the
> +      software switch.
> +
> +  mediatek,audio-codec:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of wm8960 codec.

Please define these properties in a common schema and reference them 
where already used and here. A given property shouldn't have multiple 
type definitions.

Rob
