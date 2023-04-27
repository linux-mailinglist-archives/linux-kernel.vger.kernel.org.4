Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061F86F07B1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbjD0Osn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244065AbjD0Osj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:48:39 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC52649DA;
        Thu, 27 Apr 2023 07:48:34 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6a5f7341850so6709084a34.2;
        Thu, 27 Apr 2023 07:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682606914; x=1685198914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M31n+XREzugmZ1EKOJc53wCBLFu4hpN+NfwfiegJw4Y=;
        b=KP4CykY7hulQnShYX1w3SGOF7z0JjBtlIym7UgYeFpo/H9yEwLXIB3h3JoscrcG1CL
         vD6iVg+RjBh3UjkIkOWP00ppijbhJbgyp+Rlq+OfOYWII3j9cuNzWsSmVNO/QNEtOTEv
         d1r0SZB2PHhBh52CPf5d37ICgndIJBZH5IY3zcT3ATpA/faIj7AIi1/SigrtvMk2vom+
         BO85itUL2MKKpIEV5K/2pWOQkYsmgMQcgesd+Y46WW4QDuT0qaqG+GRTiFIk6uOdqkQM
         TNzdL/1tPcF8ORb1y8AqZcCn70dqnAq12I04iXm1A1XoQlah1/+ZwjfU7kysQq5utA4g
         tl5g==
X-Gm-Message-State: AC+VfDxjUd2uR+hjBr8TUucevrQ57044YmvMonSZJTq11dY2bsxbLK4F
        bCPNehLQnE0mcOzJk+nPCA==
X-Google-Smtp-Source: ACHHUZ7Gy9jZRZPv3O8hPWV17h7xoBKxBXZHUuJlHDEj5firr1OAVrcrJ0Ju0D2jaIC1gyaw5XDBgQ==
X-Received: by 2002:a9d:6404:0:b0:6a4:2f1d:133e with SMTP id h4-20020a9d6404000000b006a42f1d133emr771755otl.3.1682606913964;
        Thu, 27 Apr 2023 07:48:33 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z5-20020a9d65c5000000b006a12509bd94sm8042181oth.13.2023.04.27.07.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 07:48:33 -0700 (PDT)
Received: (nullmailer pid 3018266 invoked by uid 1000);
        Thu, 27 Apr 2023 14:48:32 -0000
Date:   Thu, 27 Apr 2023 09:48:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
        perex@perex.cz, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/7] ASoC: dt-bindings: mediatek,mt8188-afe: add audio
 properties
Message-ID: <20230427144832.GA2992031-robh@kernel.org>
References: <20230426055124.16529-1-trevor.wu@mediatek.com>
 <20230426055124.16529-8-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426055124.16529-8-trevor.wu@mediatek.com>
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

On Wed, Apr 26, 2023 at 01:51:24PM +0800, Trevor Wu wrote:
> Add apll1_d4 to clocks for switching the parent of top_a1sys_hp
> dynamically. On the other hand, "mediatek,infracfg" is included for bus
> protection.

Bus protection? Meaning access controls for the device? If so, there's a 
proposed binding[1] for just that. If that's something Mediatek needs 
too, please participate in that discussion. It's easier to define new 
common bindings if there is more than one user.

> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../bindings/sound/mediatek,mt8188-afe.yaml          | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
> index 82ccb32f08f2..eb58de8c0e68 100644
> --- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
> @@ -29,6 +29,10 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description: The phandle of the mediatek topckgen controller
>  
> +  mediatek,infracfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of the mediatek infracfg controller
> +
>    power-domains:
>      maxItems: 1
>  
> @@ -52,6 +56,7 @@ properties:
>        - description: mux for i2si1_mck
>        - description: mux for i2si2_mck
>        - description: audio 26m clock
> +      - description: audio pll1 divide 4
>  
>    clock-names:
>      items:
> @@ -73,6 +78,7 @@ properties:
>        - const: i2si1_m_sel
>        - const: i2si2_m_sel
>        - const: adsp_audio_26m
> +      - const: apll1_d4

A new required entry may break the ABI. If that's okay, it needs to be 
explained in the commit msg.

Rob

[1] https://lore.kernel.org/lkml/cover.1668070216.git.oleksii_moisieiev@epam.com/
