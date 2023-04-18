Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6B16E6D99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjDRUl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjDRUlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:41:40 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6418C654;
        Tue, 18 Apr 2023 13:41:38 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-546e2fddc04so580095eaf.2;
        Tue, 18 Apr 2023 13:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681850498; x=1684442498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Wn5jPh2OUBYBXHc1I8aQspr9Ndl9LxQc5kkluAkHCg=;
        b=UOdVX0rk9A6AH2fJ6H5VobmqDV1F172Yi8iheaALelo8zabfibijnIGkjS3VPl9S5N
         WkJDAHkIM4tPm81w6BxxmO14gTV4YQ0p6pFtuKtJ8JXENa5TrYvbnhISY87+nXvqb9wo
         XNB2zkr3tdz1hlpI3xMsjY1gsFp+a9QNK0+sGn3Pc8/ZEi0lA7aM7UrykiHekveQFfww
         3E4oW3jlPutvWTm34RDjwMdX0XKHJRLfOXtre9aVj3EzTVBk08L8aXxPxH+cSz7QQC/6
         8iwNv7/Vhr5sm65RtQBMLd4lEaJmvOFmN3HylHplrutJSshFjVohyiwVjyUAKTGNDLRM
         w+Mw==
X-Gm-Message-State: AAQBX9fyT69UaEOrgk8V8C7k0jMjWy/a4g5b+gweLwPtJWoXQumALkgN
        rSB/XeTc9Sm2LVI/8cKj/Q==
X-Google-Smtp-Source: AKy350a+NmjwKRcIM2O3weLQf7m8QnY1Y6F7Tc8lUnHf4ija54gAsp2mitsmSa1rHReBb0iR+FE2sg==
X-Received: by 2002:a05:6870:970c:b0:187:78db:feba with SMTP id n12-20020a056870970c00b0018778dbfebamr2244694oaq.59.1681850497867;
        Tue, 18 Apr 2023 13:41:37 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s3-20020a05687090c300b001805a3e722csm5983987oab.19.2023.04.18.13.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:41:37 -0700 (PDT)
Received: (nullmailer pid 2301746 invoked by uid 1000);
        Tue, 18 Apr 2023 20:41:36 -0000
Date:   Tue, 18 Apr 2023 15:41:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv1 3/5] dt-bindings: phy: rockchip: rk3588 has two reset
 lines
Message-ID: <20230418204136.GA2299798-robh@kernel.org>
References: <20230413182345.92557-1-sebastian.reichel@collabora.com>
 <20230413182345.92557-4-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413182345.92557-4-sebastian.reichel@collabora.com>
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

On Thu, Apr 13, 2023 at 08:23:43PM +0200, Sebastian Reichel wrote:
> The RK3588 has two reset lines for the combphy. One for the
> APB interface and one for the actual PHY.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/phy/phy-rockchip-naneng-combphy.yaml          | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> index 9ae514fa7533..bac1aae07555 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> @@ -31,8 +31,13 @@ properties:
>        - const: pipe
>  
>    resets:
> +    minItems: 1
> +    maxItems: 2
> +
> +  reset-names:
>      items:
> -      - description: exclusive PHY reset line
> +      - const: phy
> +      - const: apb

This will fail on any existing users with single entry. You need to add 
'minItems: 1' here.

It also fails if they didn't use 'phy' as the name, but names should be 
defined.

Rob
