Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D1F5ED9C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiI1KFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiI1KEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:04:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386FEF2776;
        Wed, 28 Sep 2022 03:04:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F0BB61DF5;
        Wed, 28 Sep 2022 10:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF0FC433C1;
        Wed, 28 Sep 2022 10:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664359451;
        bh=g5tPUMuRs3hd6RQfSCVRf2c4IhMii1nQlqCrOQtWa9U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CQdz9zAAeVE7AF8DYtSxxiAcL1nBttpkPgJHxFKh30Tn8XK3xarv/P7Y6Hp/Rwt/k
         nDoby5HtBciwSHkB4JrieQEYQulFB8kuhWgJcc7fvrDRj75vfX3zf9YaLy6IiQlzP/
         6S67me3o5jxpfnBHOM7gxL+oehCpSBqqRGubWzVboTsc+zcgNakEg+jHHj8oVyZlRF
         t6zNJhakBPgyl5S7Yn6XarhxQ3W0WstoKCnAZSedzAgp6rZuNDpeaZhaVsd8BCUngr
         S/tjka/U43vDeafltuiea7iCif62+PGJc8Dwehr6PB57DlFahLZ3DDgg2ZBHdPWjdZ
         tsiyFGFMsdoBw==
Message-ID: <72a56f7e-e7a6-e751-c153-5e85417bc72b@kernel.org>
Date:   Wed, 28 Sep 2022 12:04:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [V16,08/15] dt-bindings: mediatek: Add mediatek,mt8195-jpgdec
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
 <20220928093258.32384-9-irui.wang@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220928093258.32384-9-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 11:32, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add mediatek,mt8195-jpgdec compatible to binding document.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> Signed-off-by: irui wang <irui.wang@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../media/mediatek,mt8195-jpegdec.yaml        | 168 ++++++++++++++++++
>  1 file changed, 168 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> new file mode 100644
> index 000000000000..1e81de4f1301
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> @@ -0,0 +1,168 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mt8195-jpegdec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek JPEG Encoder Device Tree Bindings

Drop "Device Tree Bindings"

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

