Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7806F8A74
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjEEU4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjEEU4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:56:02 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9361984;
        Fri,  5 May 2023 13:56:00 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-545d82e1a1bso762597eaf.2;
        Fri, 05 May 2023 13:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683320159; x=1685912159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VN+kd2EhqqLwkd1HP1gj/tCZ2l7tn4n5+N9NH0LIdNk=;
        b=Fx0I6Ry5zF/DqYiy/+GXLchFVPMF2TFou7zHntKcg5/Z5YMi0bizpxxHfIun9Qx4/P
         fAWMeAxnIBREGRnCsMCWV1LeV6Uds7RJK0axsSHlE02blXEQrPgIh+BNFrH1loEZXIP4
         CN7FJhFVSjXJMjWZWbgyqCw7SHLJgMykakIvj+a2oHp2K8GWjWgNZ7mydyT/beuXBq/9
         9YxJfE+HTUepdTGw/rM6Z4tjimlWG/75HQKb30WPYsF9Scz/SC+Z4A9JXQNxXYgqJMto
         bxpS4CPwS2FMLaeGVdhHFjrA3SN22Hx9GgRgvm5N6eSFGRxtdc+XP9A25OG8gS9sZxN3
         PSzw==
X-Gm-Message-State: AC+VfDwePRmSVZxI/42jOZTnnPVlCuuYSdViERtoqeTdnyNZMmCL1Bci
        LXKOdlE+yTIPp+jM8bsMeA==
X-Google-Smtp-Source: ACHHUZ753eu5EI/LSk6iN0lvOVkNEoyddP53VCwh5WJqzbAvag6iNPXcKvC6W2TN9PHdEY3Uv6obYA==
X-Received: by 2002:a05:6820:290:b0:547:6105:e096 with SMTP id q16-20020a056820029000b005476105e096mr1349543ood.7.1683320159587;
        Fri, 05 May 2023 13:55:59 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h5-20020a9d6405000000b006a632c6af05sm1298506otl.54.2023.05.05.13.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 13:55:58 -0700 (PDT)
Received: (nullmailer pid 3548062 invoked by uid 1000);
        Fri, 05 May 2023 20:55:58 -0000
Date:   Fri, 5 May 2023 15:55:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        KCHSU0@nuvoton.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: nau8540: Convert to dtschema
Message-ID: <20230505205558.GA3544888-robh@kernel.org>
References: <ZE9rK6mktPByvRRz@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZE9rK6mktPByvRRz@yoga>
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

On Mon, May 01, 2023 at 01:02:59PM +0530, Anup Sharma wrote:
> Convert the NAU8540 audio CODEC bindings to DT schema
> 
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  .../devicetree/bindings/sound/nau8540.txt     | 16 --------
>  .../bindings/sound/nuvoton,nau8540.yaml       | 40 +++++++++++++++++++
>  2 files changed, 40 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/nau8540.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/nau8540.txt b/Documentation/devicetree/bindings/sound/nau8540.txt
> deleted file mode 100644
> index 307a76528320..000000000000
> --- a/Documentation/devicetree/bindings/sound/nau8540.txt
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -NAU85L40 audio CODEC
> -
> -This device supports I2C only.
> -
> -Required properties:
> -
> -  - compatible : "nuvoton,nau8540"
> -
> -  - reg : the I2C address of the device.
> -
> -Example:
> -
> -codec: nau8540@1c {
> -       compatible = "nuvoton,nau8540";
> -       reg = <0x1c>;
> -};
> diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml
> new file mode 100644
> index 000000000000..ac344e435a5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nuvoton,nau8540.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton Technology Corporation NAU85L40 Audio CODEC
> +
> +maintainers:
> +  - KCHSU0@nuvoton.com, broonie@kernel.org

Not the right format. It's one email per line/entry.

It needs a name too and drop Mark. It's who knows the h/w, not who 
applies patches.

> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: nuvoton,nau8540
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        codec@1c {
> +            compatible = "nuvoton,nau8540";
> +            reg = <0x1c>;
> +        };
> +    };
> -- 
> 2.34.1
> 
