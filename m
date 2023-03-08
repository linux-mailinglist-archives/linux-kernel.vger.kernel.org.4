Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE1B6B120D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCHTbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCHTba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:31:30 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A09CF98B;
        Wed,  8 Mar 2023 11:31:13 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1755e639b65so19919463fac.3;
        Wed, 08 Mar 2023 11:31:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678303872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVRxkbAcOH49LnvQjybsYaSoW319krR81ouXEhY/1GA=;
        b=sFL1+pNwdivSCzLPG6bR0NrnGjrADVKuwe7j2cq4OiPv3x0U6wG+6Mdkfxa8q6CCX6
         ljwSBev3DGQgkH+VcqAliJDnoMVEyf5HUP3NH6QHLr6DkUHkOEcWICiFrKn18whFIzFx
         2pGpRTOO7vHbhdTULH0xkBQDWI9Or2C7ZKYRtKcr128nux91vb9ZFGByN3+bxy1Itf3a
         nJzW/ze3F1DF1zdtcQLF/28CJJ4K4thPIJjWo6/b0z7yxkkUedNXlJ8sWlFrRd9DnKBN
         C7ryG5lGssuRpA/0Ie0Hdu3kVfuKq5IWsCXthKUR+eCnKpPZx1E+jFak8ixXSIIiz8YH
         HnpA==
X-Gm-Message-State: AO0yUKVaUStzzm/RIBME71p39DHbwo+rkSHjsGzP8RmB4MnRd4Kk0P6j
        EzvKxNg7iemQ6nyVHmpPew==
X-Google-Smtp-Source: AK7set+2G35ce6l0KBUah5lmSczkOPP8Rxk/KKrKFG3bwudwFBrKiHsr0HW+2VEzTaZfCdFpWT0Dvg==
X-Received: by 2002:a05:6870:c69b:b0:16a:a965:87e0 with SMTP id cv27-20020a056870c69b00b0016aa96587e0mr12331912oab.54.1678303871060;
        Wed, 08 Mar 2023 11:31:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p13-20020a9d4e0d000000b0068bbc9e7cc9sm6745998otf.53.2023.03.08.11.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 11:31:10 -0800 (PST)
Received: (nullmailer pid 3642800 invoked by uid 1000);
        Wed, 08 Mar 2023 19:31:09 -0000
Date:   Wed, 8 Mar 2023 13:31:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: iommu: dart: Add t8103-usb4-dart
 compatible
Message-ID: <167830386930.3642740.3268632059091796734.robh@kernel.org>
References: <20230228202132.4919-1-sven@svenpeter.dev>
 <20230228202132.4919-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228202132.4919-2-sven@svenpeter.dev>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Feb 2023 21:21:29 +0100, Sven Peter wrote:
> This DART variant is found in the t8103 (M1) SoCs and used for the
> USB4/Thunderbolt PCIe ports. Unlike the regular t8103 DART these support
> up to 64 SIDs and require a slightly different MMIO layout. This variant
> is only found on the M1 SoCs.
> 
> Acked-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  Documentation/devicetree/bindings/iommu/apple,dart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

