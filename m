Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212F05E61EE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiIVMFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiIVMFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:05:40 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1A18983F;
        Thu, 22 Sep 2022 05:05:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1B1E541F72;
        Thu, 22 Sep 2022 12:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1663848335; bh=4C8tp/J+vzOZn+IcAaj/31/YtIQ4NN2UYPR9Bjo1AeE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CAfX13+M95AnsYhz9cVsQBzaOhx6+6ISasDwrrP3gj5STGV7rtNESHmOPgB6STuU8
         53JKtUGFgFNIhqcCLQiERuC0dMjF/H4ABwFXSH/EpI7eXvXaD552fso8yPliiBQiiu
         EHJ3gx6Lo8P3d29D28RCV8tI1FeUCBex2/WtcPuOCktjW/8Oz/dM+v+SFqvquCiQ93
         cZNu0p1QGz/ABUCpPUmqo0h5TloLjosCIcoIMacPHLvWcog/e4mf7evxb6tdnWDdj4
         6cXoMrfI5vS3WTvRsiFsJ72/pd3OZozBAeAqyGMzxaZiUTchpgFZQb5w7apCCN1Hki
         vPbqTLYOmSXQQ==
Message-ID: <0f2a1930-9d43-60e8-5f6e-55779248bee5@marcan.st>
Date:   Thu, 22 Sep 2022 21:05:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 1/5] dt-bindings: iommu: dart: add t6000 compatible
Content-Language: es-ES
To:     Janne Grunau <j@jannau.net>, iommu@lists.linux.dev
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        asahi@lists.linux.dev, Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220916094152.87137-1-j@jannau.net>
 <20220916094152.87137-2-j@jannau.net>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20220916094152.87137-2-j@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 18.41, Janne Grunau wrote:
> From: Sven Peter <sven@svenpeter.dev>
> 
> The M1 Max/Pro SoCs come with a new DART variant that is incompatible with
> the previous one. Add a new compatible for those.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> Acked-by: Rob Herring <robh@kernel.org>
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - added Rob's Acked-by:
> 
>  Documentation/devicetree/bindings/iommu/apple,dart.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> index 82ad669feef7..06af2bacbe97 100644
> --- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> +++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> @@ -22,7 +22,9 @@ description: |+
>  
>  properties:
>    compatible:
> -    const: apple,t8103-dart
> +    enum:
> +      - apple,t8103-dart
> +      - apple,t6000-dart
>  
>    reg:
>      maxItems: 1

I'm taking this one via the Asahi-SoC tree, since it unblocks the t6000
DT series and it is already reviewed and ready to go. Thanks!

- Hector
