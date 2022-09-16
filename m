Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8419A5BABFE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiIPLGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIPLF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:05:59 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEECFB9A;
        Fri, 16 Sep 2022 03:59:26 -0700 (PDT)
Received: from [89.101.193.72] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oZ945-0002Gx-84; Fri, 16 Sep 2022 12:59:21 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianling Shen <cnsztl@gmail.com>,
        Tianling Shen <cnsztl@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S Enterprise Edition
Date:   Fri, 16 Sep 2022 12:59:20 +0200
Message-ID: <3633903.MHq7AAxBmi@phil>
In-Reply-To: <20220915022511.4267-1-cnsztl@gmail.com>
References: <20220911040628.13774-1-cnsztl@gmail.com> <20220915022511.4267-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 15. September 2022, 04:25:10 CEST schrieb Tianling Shen:
> Add devicetree binding documentation for the FriendlyARM NanoPi R4S
> Enterprise Edition.
> 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>

applied both series for 6.1

Thanks
Heiko

> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 7811ba64149c..309f76b803a5 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -151,6 +151,7 @@ properties:
>                - friendlyarm,nanopi-m4b
>                - friendlyarm,nanopi-neo4
>                - friendlyarm,nanopi-r4s
> +              - friendlyarm,nanopi-r4s-enterprise
>            - const: rockchip,rk3399
>  
>        - description: GeekBuying GeekBox
> 




