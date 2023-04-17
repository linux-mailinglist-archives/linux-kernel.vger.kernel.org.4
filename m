Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF9D6E51FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjDQUl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQUlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:41:53 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7683C2B;
        Mon, 17 Apr 2023 13:41:52 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 22-20020a9d0116000000b006a5dcfee7d7so2679589otu.2;
        Mon, 17 Apr 2023 13:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764112; x=1684356112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgCCOyPJlZ+8fKfWAcjeoDQzm+xsVsIU0id6khxYMRs=;
        b=Tszf1T/2Mwg59NYn4XPk7ztLYeWTa4PyjEORx9EPdlhjAWj2/artAIWaqrwe3VCJF+
         zgXqX3PJ4vnd04FXiybcV9E0QsQb2QGAWnhnGJZ6sGz5RW2beHMzliwxcC1fIn0cuRcF
         Sr/LMhDX1T4Fkb6uACmD9bBjk85nOBCc73h+tWNe2TQntW9MzWU5GhyhO+Z+3d5KxVnM
         VY+ueczg1w488VHy1OQlTbg8RiKOEXGYqoDIf34AIuPhWOLrNGtLCYwl7ZTADRagCI5O
         x6pmFhvck8ltMxl8MtMDHiCRVtzB7U5EtFCMwpVCO4rrQmXZpEb24bwSW9kYeLgdIkrz
         UffA==
X-Gm-Message-State: AAQBX9c2GencTqxl+bPkWH+lOc1Wr0R9zVqLgtSLC63jbxzEXxPx9HPI
        aW1UHlbx+oETjzlSFKsY0w==
X-Google-Smtp-Source: AKy350ZAcIbUvUMqEkEj6s0RcHV75OABdvSUl6WmtBW303CKhwJhEkgKKZsF4j7q0QT8uLyV5Otqhw==
X-Received: by 2002:a05:6830:1d7a:b0:6a4:469a:1a59 with SMTP id l26-20020a0568301d7a00b006a4469a1a59mr5195094oti.23.1681764111870;
        Mon, 17 Apr 2023 13:41:51 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i18-20020a056830011200b006a44d90de05sm3262030otp.69.2023.04.17.13.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:41:51 -0700 (PDT)
Received: (nullmailer pid 3334304 invoked by uid 1000);
        Mon, 17 Apr 2023 20:41:50 -0000
Date:   Mon, 17 Apr 2023 15:41:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Anikiel <pan@semihalf.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com
Subject: Re: [PATCH 3/9] dt-bindings: ASoC: Add chv3-audio
Message-ID: <20230417204150.GA3328603-robh@kernel.org>
References: <20230414140203.707729-1-pan@semihalf.com>
 <20230414140203.707729-4-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230414140203.707729-4-pan@semihalf.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 04:01:57PM +0200, Paweł Anikiel wrote:
> Add binding for chv3-audio device.
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> ---
>  .../bindings/sound/google,chv3-audio.yaml     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/google,chv3-audio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/google,chv3-audio.yaml b/Documentation/devicetree/bindings/sound/google,chv3-audio.yaml
> new file mode 100644
> index 000000000000..8b602b60eaee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/google,chv3-audio.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/google,chv3-audio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google Chameleon v3 audio
> +
> +maintainers:
> +  - Paweł Anikiel <pan@semihalf.com>
> +
> +properties:
> +  compatible:
> +    const: google,chv3-audio
> +
> +  google,audio-cpu0:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of controller #0
> +
> +  google,audio-codec0:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of codec #0
> +
> +  google,audio-cpu1:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of controller #1
> +
> +  google,audio-codec1:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of codec #1

Why do you need custom properties when we have standard property to 
point to these things (sound-dai). We also have bindings to handle 
multiple devices.

Rob
