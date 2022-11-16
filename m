Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBEA62CEFB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiKPXne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbiKPXmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:42:44 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AA5686B9;
        Wed, 16 Nov 2022 15:42:22 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id h132so155507oif.2;
        Wed, 16 Nov 2022 15:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5LdKOGlH65lOSoImyTv5F76TVsoyOjJ93aGKFHERCSs=;
        b=EQsSr8LdDDVDrlPDdDAswEBYh6O9Fpn5eD76wTEQm0fV8/QF2UAfQtIXpj6K8qtJh5
         IEKkg2D7lXHdwzUYRs6NMTzLgVJgPpPGs0QHLVXq4sCht1tF4iz5UgI4uaPDhieQy16X
         gPF3DPPafTH5BiRxP0J+Jw7j23P5Tlbs5X6+MKk/fkEL89j2p+2dkgbXIv20Gr3jCBUl
         El+U6u4A5CJUsnH7/QtbNssZ8s4TAcQxKEPfKzC8zn/2MLc/L5DEcducHxS6PGPvszK3
         w24nnktv57V7nSdPu9QTdFJ3RMbrjVQRW3B1NKAkFmYz9GWyVxP5Ihl4RgsKgnVydzRO
         NM3w==
X-Gm-Message-State: ANoB5pl83nFu1xDeL5TGAK7oEDS0bjtzNhXosL7cOTsE8uRiS9svlVrr
        FuI89WZjDxEPzIWXHlI+7euB/rUktg==
X-Google-Smtp-Source: AA0mqf6FgriVlXfvMJ9LHdjfinowMEqzwwe+lERbtwJvX0bDChLkPIPUTIL+nJTeLRlM0Zj9da+qXg==
X-Received: by 2002:a05:6808:ec9:b0:34d:d3a5:b2d with SMTP id q9-20020a0568080ec900b0034dd3a50b2dmr2771547oiv.224.1668642141339;
        Wed, 16 Nov 2022 15:42:21 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w13-20020a9d450d000000b00661948e6119sm7300245ote.47.2022.11.16.15.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:42:20 -0800 (PST)
Received: (nullmailer pid 1236701 invoked by uid 1000);
        Wed, 16 Nov 2022 23:42:22 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        samuel@sholland.org, linux-media@vger.kernel.org,
        linux-sunxi@lists.linux.dev, mchehab@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wens@csie.org
In-Reply-To: <20221116193105.363297-2-jernej.skrabec@gmail.com>
References: <20221116193105.363297-1-jernej.skrabec@gmail.com>
 <20221116193105.363297-2-jernej.skrabec@gmail.com>
Message-Id: <166864203895.1233471.6009951127753236678.robh@kernel.org>
Subject: Re: [PATCH 1/2] media: dt-bindings: allwinner: video-engine: Fix
 number of IOMMU channels
Date:   Wed, 16 Nov 2022 17:42:22 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Nov 2022 20:31:04 +0100, Jernej Skrabec wrote:
> Cedrus (video engine) on Allwinner H6 actually uses two IOMMU channel,
> not just one. However, Cedrus on SoCs like D1 only uses one channel.
> 
> Allow up to 2 IOMMU channels.
> 
> Fixes: 62a8ccf3a248 ("arm64: dts: allwinner: h6: Fix Cedrus IOMMU usage")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  .../bindings/media/allwinner,sun4i-a10-video-engine.yaml        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


video-codec@1c0e000: iommus: [[10, 3]] is too short
	arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dtb
	arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dtb

video-codec@1c0e000: iommus: [[12, 3]] is too short
	arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dtb
	arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dtb
	arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dtb
	arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dtb
	arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dtb
	arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6-mini.dtb

