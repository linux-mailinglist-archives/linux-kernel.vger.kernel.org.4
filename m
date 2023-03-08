Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4732F6B139C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCHVPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCHVPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:15:14 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A81C78F2;
        Wed,  8 Mar 2023 13:15:13 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-176eae36feaso154985fac.6;
        Wed, 08 Mar 2023 13:15:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678310112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktsS6gvJqIlBbC8B6VrYT4e0IFcYp23M4iEhHPG47pM=;
        b=y3UekNo7kds9XugCXthgXg+5/nfHaBxwqUFsW8Dy44ehtOLfdyF5inzico475vbpNz
         3mGgHDmKJk+44T4nob2TdlbwSy9xYmfZ5ZcH+U/ZKNlS/677CHSrdupR49Vv4aPH8cZr
         OpAx7ctewX4BzAWRSc81jbuzQjSbSHEmV7Yq6l3Kb28xVN3TVHViZV6gwzobvEG5YTRc
         Y05olE1jwZ7tTNpNGG84giPOLqqIh0fOn3URgpJutKHt73gqEOqjT0dgypSBSU2wEt/y
         b4uYxCstuve1nScmOtVTTf1HnKqlDIoKozDZbViIEpYwA+vUAh9YqC6oHxLvAaWHPqbx
         yBzQ==
X-Gm-Message-State: AO0yUKX1TCknKyhpSZSb2cB5YZ/vgsdEBwqbw8jjA5N9nQvRK0aieMKr
        JocnLWWuR4kef1oeLb4eevNFwJiSig==
X-Google-Smtp-Source: AK7set/guA8UuoeQpBiEWi5vzQStpahL+/DESR5U58DYCblv1tHuiS1b18dlELOYLHyJLaxszohlbg==
X-Received: by 2002:a05:6870:1602:b0:16d:ccea:3ea0 with SMTP id b2-20020a056870160200b0016dccea3ea0mr12616079oae.0.1678310112649;
        Wed, 08 Mar 2023 13:15:12 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e21-20020a056870c35500b0016e8726f0d4sm6616083oak.3.2023.03.08.13.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:15:12 -0800 (PST)
Received: (nullmailer pid 3855515 invoked by uid 1000);
        Wed, 08 Mar 2023 21:15:11 -0000
Date:   Wed, 8 Mar 2023 15:15:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: Re: [PATCH 17/20] dt-bindings: pinctrl: mediatek: mt7986: fix
 patternProperties regex
Message-ID: <20230308211511.GA3850618-robh@kernel.org>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
 <20230303002850.51858-18-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303002850.51858-18-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 03:28:46AM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Set second level patternProperties to '^.*mux.*$' and '^.*conf.*$' on
> mediatek,mt7986-pinctrl.yaml.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml  | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
> index 46b7228920ed..e937881210c5 100644
> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
> @@ -72,7 +72,7 @@ patternProperties:
>      additionalProperties: false
>  
>      patternProperties:
> -      '.*mux.*':
> +      '^.*mux.*$':

These are equivalent (so is just 'mux', but that's ambiguous). Why are 
we changing them? Ideally, we'd only have a wildcard on one end.

>          type: object
>          additionalProperties: false
>          description: |
> @@ -256,7 +256,7 @@ patternProperties:
>                    items:
>                      enum: [wf_2g, wf_5g, wf_dbdc]
>                    maxItems: 3
> -      '.*conf.*':
> +      '^.*conf.*$':
>          type: object
>          additionalProperties: false
>          description:
> -- 
> 2.37.2
> 
