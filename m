Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D02B636529
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbiKWQAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237197AbiKWQAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:00:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D172DA97;
        Wed, 23 Nov 2022 07:59:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D77561DB2;
        Wed, 23 Nov 2022 15:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65271C43144;
        Wed, 23 Nov 2022 15:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669219187;
        bh=NS11AyaOOzYSASBYlc4oJCK5uNhVXwOLd4pt39/P0oY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OSZ2n10hM0hKrs7saAE7lKyKvqaPuuWCmVvdvLWDgbVeRI4IlkEC1Nz5RxAbWnUrR
         ERHj1FNKpKY4E56WAxU8lOPQRg+RTjG4s2/53E/TejSFYKhIofzEPKxBree6tvNoBn
         OfaZjFr6nztFBkCdlwn9JaqZNUpxdQbcNG3+3P5AgCiTMo+W9+PXxllv+00Gw831Nn
         eYI3q+1AYyZNO6CKbSJ8kIf2/tiqaHs79kdbyOzy57uaFv7p/4msdFMK6Um+Qeb6Kc
         HLXKy0NPUUE7RDAvrd9/W1nPExKCzrpIqKafOrqnHIc0umhHY7Ryd9JoCoGrWsRJLM
         ODVHkRk97DMMg==
Message-ID: <7561a0c3-c63b-a3f2-efeb-4bb0f4ad03e4@kernel.org>
Date:   Wed, 23 Nov 2022 16:59:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 3/7] dt-bindings: arm: nuvoton: Add bindings for NPCM
 GFXI
Content-Language: en-US
To:     Marvin Lin <milkfafa@gmail.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
References: <20221122085724.3245078-1-milkfafa@gmail.com>
 <20221122085724.3245078-4-milkfafa@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221122085724.3245078-4-milkfafa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 09:57, Marvin Lin wrote:
> Add dt-bindings document for Graphics Core Information (GFXI) node. It
> is used by NPCM video driver to retrieve Graphics core information.
> 
> Signed-off-by: Marvin Lin <milkfafa@gmail.com>
> ---
>  .../bindings/arm/npcm/nuvoton,gfxi.yaml       | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
> 

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> diff --git a/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
> new file mode 100644
> index 000000000000..5b785bda5739
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/npcm/nuvoton,gfxi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Graphics Core Information block in Nuvoton SoCs
> +
> +maintainers:
> +  - Joseph Liu <kwliu@nuvoton.com>
> +  - Marvin Lin <kflin@nuvoton.com>
> +
> +description:
> +  The Graphics Core Information (GFXI) are a block of registers in Nuvoton SoCs
> +  that analyzes Graphics core behavior and provides inforomation in registers.

typo: information

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - nuvoton,npcm750-gfxi
> +          - nuvoton,npcm845-gfxi
> +      - const: syscon
> +      - const: simple-mfd

That's not simple-mfd, you do not have any devices.


Best regards,
Krzysztof

