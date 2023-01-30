Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9141B681D00
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjA3VmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjA3VmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:42:22 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11784956A;
        Mon, 30 Jan 2023 13:41:53 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-16346330067so16981823fac.3;
        Mon, 30 Jan 2023 13:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8L0iZJB3bUGW9JLNkuI2s2g9EvqK3MUpW23NqWSMDg=;
        b=XqR7PqcQqb/lLl+u1w5oUdTMNIbj/qr3cqwS8XLlc/z9i6tAz5G73lUy2lY1nGAotY
         9VM3DrOIa6R95XQy3xLGxrCjMg6n+1ieIx10keqCDSd/JBh4Ap4XQ2FXhrSrYjLvFWAi
         IQgxAH9Vs6tNFlT/cT5xuj6h8d8jvDxtYGBWwuZf4EHyV+P5TrvsTBPSbNwEwRYK9A7X
         fW9gHZ6lp06mr9J3L6mlVUtgYxeM8LtRM/+DtQfrPHFt/RD2uw1PomNV0hJcyfmSVnm7
         zOhdOlSw1mmLILxpGor9Ey2MVEvKV/GAmb0tQVfUTZmxTNUnJyJ2xmRfmb4HCElQgHz9
         XiVA==
X-Gm-Message-State: AFqh2kqw9PTGXWS7rgiCdjgYaT1gr7t5dDl2T5gEjFBSTHm5p5h6oB2o
        NGVVoLBT5IXIG5TfuCAtew==
X-Google-Smtp-Source: AMrXdXuUUyx0J2fyOl+V0z9H3zFvJSnOqxZ+0A4HPV/Hc7mTZNyygaal32QIuFxRT/LW5jQm6sHG6w==
X-Received: by 2002:a05:6870:b14c:b0:15e:d25e:6d18 with SMTP id a12-20020a056870b14c00b0015ed25e6d18mr28491405oal.12.1675114892154;
        Mon, 30 Jan 2023 13:41:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w12-20020a4aa98c000000b004a0ad937ccdsm5421116oom.1.2023.01.30.13.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:41:31 -0800 (PST)
Received: (nullmailer pid 3578192 invoked by uid 1000);
        Mon, 30 Jan 2023 21:41:30 -0000
Date:   Mon, 30 Jan 2023 15:41:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iommu: dart: Add t8103-usb4-dart
 compatible
Message-ID: <20230130214130.GA3576591-robh@kernel.org>
References: <20230128111114.4049-1-sven@svenpeter.dev>
 <20230128111114.4049-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128111114.4049-2-sven@svenpeter.dev>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 12:11:11PM +0100, Sven Peter wrote:
> This DART variant is found in the t8103 (M1) SoCs and used for the
> USB4/Thunderbolt PCIe ports. Unlike the regular t8103 DART these support
> up to 64 SIDs and require a slightly different MMIO layout. This variant
> is only found on the M1 SoCs.

Looks fine to me other than the discrepancy in the name.

> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  Documentation/devicetree/bindings/iommu/apple,dart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> index 903edf85d72e..f9c1843c074d 100644
> --- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> +++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> @@ -24,6 +24,7 @@ properties:
>    compatible:
>      enum:
>        - apple,t8103-dart
> +      - apple,t8103-dart-usb4
>        - apple,t8110-dart
>        - apple,t6000-dart
>  
> -- 
> 2.25.1
> 
